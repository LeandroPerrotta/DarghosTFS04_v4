////////////////////////////////////////////////////////////////////////
// OpenTibia - an opensource roleplaying game
////////////////////////////////////////////////////////////////////////
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
////////////////////////////////////////////////////////////////////////
#include "otpch.h"
#include "scheduler.h"

Scheduler::Scheduler()
{
    lastEventId = 0;
}

void Scheduler::start()
{
    setState(THREAD_STATE_RUNNING);
    thread = std::thread(&Scheduler::schedulerThread, this);
}

void Scheduler::schedulerThread()
{
    std::unique_lock<std::mutex> eventLockUnique(eventLock, std::defer_lock);
    while (getState() != THREAD_STATE_TERMINATED) {
        std::cv_status ret = std::cv_status::no_timeout;

        eventLockUnique.lock();
        if (eventList.empty()) {
            eventSignal.wait(eventLockUnique);
        } else {
            ret = eventSignal.wait_until(eventLockUnique, eventList.top()->getCycle());
        }

        // the mutex is locked again now...
        if (ret == std::cv_status::timeout) {
            // ok we had a timeout, so there has to be an event we have to execute...
            SchedulerTask* task = eventList.top();
            eventList.pop();

            // check if the event was stopped
            auto it = eventIds.find(task->getEventId());
            if (it == eventIds.end()) {
                eventLockUnique.unlock();
                delete task;
                continue;
            }
            eventIds.erase(it);
            eventLockUnique.unlock();

            task->setDontExpire();
            g_dispatcher.addTask(task, true);
        } else {
            eventLockUnique.unlock();
        }
    }
}

uint32_t Scheduler::addEvent(SchedulerTask* task)
{
    bool do_signal = false;
    eventLock.lock();

    if (getState() == THREAD_STATE_RUNNING) {
        // check if the event has a valid id
        if (task->getEventId() == 0) {
            // if not generate one
            if (++lastEventId == 0) {
                lastEventId = 1;
            }

            task->setEventId(lastEventId);
        }

        // insert the event id in the list of active events
        eventIds.insert(task->getEventId());

        // add the event to the queue
        eventList.push(task);

        // if the list was empty or this event is the top in the list
        // we have to signal it
        do_signal = (task == eventList.top());
    } else {
        eventLock.unlock();
        delete task;
        return 0;
    }

    eventLock.unlock();

    if (do_signal) {
        eventSignal.notify_one();
    }

    return task->getEventId();
}

bool Scheduler::stopEvent(uint32_t eventid)
{
    if (eventid == 0) {
        return false;
    }

    std::lock_guard<std::mutex> lockGuard(eventLock);

    // search the event id..
    auto it = eventIds.find(eventid);
    if (it == eventIds.end()) {
        return false;
    }

    eventIds.erase(it);
    return true;
}

void Scheduler::stop()
{
    setState(THREAD_STATE_CLOSING);
}

void Scheduler::shutdown()
{
    setState(THREAD_STATE_TERMINATED);
    eventLock.lock();

    //this list should already be empty
    while (!eventList.empty()) {
        delete eventList.top();
        eventList.pop();
    }

    eventIds.clear();
    eventLock.unlock();
    eventSignal.notify_one();
}

void Scheduler::join()
{
    if (thread.joinable()) {
        thread.join();
    }
}

