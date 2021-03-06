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

#ifndef __TASKS__
#define __TASKS__
#include <condition_variable>
#include "otsystem.h"
#include <atomic>
#include "enums.h"

const int DISPATCHER_TASK_EXPIRATION = 2000;
const auto SYSTEM_TIME_ZERO = std::chrono::system_clock::time_point(std::chrono::milliseconds(0));

class Task
{
    public:
        // DO NOT allocate this class on the stack
        Task(uint32_t ms, const std::function<void (void)>& f) : func(f) {
            expiration = std::chrono::system_clock::now() + std::chrono::milliseconds(ms);
        }
        explicit Task(const std::function<void (void)>& f)
            : expiration(SYSTEM_TIME_ZERO), func(f) {}

        void operator()() {
            func();
        }

        void setDontExpire() {
            expiration = SYSTEM_TIME_ZERO;
        }

        bool hasExpired() const {
            if (expiration == SYSTEM_TIME_ZERO) {
                return false;
            }
            return expiration < std::chrono::system_clock::now();
        }

    protected:
        // Expiration has another meaning for scheduler tasks,
        // then it is the time the task should be added to the
        // dispatcher
        std::chrono::system_clock::time_point expiration;
        std::function<void (void)> func;
};

inline Task* createTask(const std::function<void (void)>& f)
{
    return new Task(f);
}

inline Task* createTask(uint32_t expiration, const std::function<void (void)>& f)
{
    return new Task(expiration, f);
}

class Dispatcher
{
    public:
        void addTask(Task* task, bool push_front = false);

        void start();
        void stop();
        void shutdown();
        void join();

    protected:
        void dispatcherThread();
        void setState(ThreadState newState) {
            threadState.store(newState, std::memory_order_relaxed);
        }

        ThreadState getState() const {
            return threadState.load(std::memory_order_relaxed);
        }

        std::thread thread;
        std::mutex taskLock;
        std::condition_variable taskSignal;

        std::list<Task*> taskList;
        std::atomic<ThreadState> threadState {THREAD_STATE_TERMINATED};
};

extern Dispatcher g_dispatcher;
#endif
