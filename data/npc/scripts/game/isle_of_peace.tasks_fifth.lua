local dialog = NpcDialog:new()
local npcSys = _NpcSystem:new()
npcSys:setDialog(dialog)

local npcTask = NpcTasks:new(npcSys)
npcTask:registerTask(CAP_ONE.ISLAND_OF_PEACE.NINTH)
npcTask:registerTask(CAP_ONE.ISLAND_OF_PEACE.TENTH)
--npcTask:setNpcSystem(npcSys)
npcTask:setDialog(dialog)

function onCreatureSay(cid, type, msg)
	msg = string.lower(msg)
	npcTask:setPlayer(cid)
	local distance = getDistanceTo(cid) or -1
	if((distance < npcSys:getTalkRadius()) and (distance ~= -1)) then
		if((msg == "hi" or msg == "hello" or msg == "ola") and not (npcSys:isFocused(cid))) then
			dialog:say("Hello ".. getCreatureName(cid) .."! Tell me how can I help you.", cid)
			npcSys:addFocus(cid)	
		elseif(npcSys:isFocused(cid) and (msg == "tarefa" or msg == "miss?o" or msg == "missao" or msg == "task" or msg == "mission")) then
			npcTask:responseTask(cid)
		elseif(npcSys:isFocused(cid) and (msg == "n?o" or msg == "nao" or msg == "no")) then
			dialog:say("Allright. Then how can I help you?", cid)
			npcSys:setTopic(cid, 0)		
		elseif(npcSys:isFocused(cid) and (msg == "sim" or msg == "yes")) then
		
			if(npcSys:getTopic(cid) == 2) then
				npcTask:sendTaskObjectives()
				npcSys:setTopic(cid, 3)
			elseif(npcSys:getTopic(cid) == 3) then
				npcTask:sendTaskStart()
				npcSys:setTopic(cid, 0)
			elseif(npcSys:getTopic(cid) == 4) then
				npcTask:onCompleteConfirm()
			end
		elseif((npcSys:isFocused(cid)) and (msg == "bye" or msg == "goodbye" or msg == "cya" or msg == "adeus")) then
			dialog:say("Human, be carefull!", cid)
			npcSys:removeFocus(cid)		
		end
	end
end

function onCreatureDisappear(cid) npcSys:onCreatureDisappear(cid) end
function onPlayerCloseChannel(cid) npcSys:onPlayerCloseChannel(cid) end
function onThink() npcSys:onThink() end
