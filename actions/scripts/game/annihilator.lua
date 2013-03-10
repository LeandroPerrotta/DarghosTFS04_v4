local INTERVAL_ENTER = 10 * 60 -- 10 minutes

players = {}
demons = {}

local function loadValues(actionid)

	players = {}
	demons = {}

	if(actionid == aid.ANIHI_SWITCH) then
	
		table.insert(players, {from = uid.ANIHI_PLAYER1, dest = uid.ANIHI_NPOS1})
		table.insert(players, {from = uid.ANIHI_PLAYER2, dest = uid.ANIHI_NPOS2})
		table.insert(players, {from = uid.ANIHI_PLAYER3, dest = uid.ANIHI_NPOS3})
		table.insert(players, {from = uid.ANIHI_PLAYER4, dest = uid.ANIHI_NPOS4})
		
		table.insert(demons, uid.ANIHI_DEMON1)
		table.insert(demons, uid.ANIHI_DEMON2)
		table.insert(demons, uid.ANIHI_DEMON3)
		table.insert(demons, uid.ANIHI_DEMON4)		
		table.insert(demons, uid.ANIHI_DEMON5)		
		table.insert(demons, uid.ANIHI_DEMON6)		
		table.insert(demons, uid.ANIHI_DEMON7)		
				
	elseif(actionid == aid.ANIHI_ARACURA_SWITCH) then

		table.insert(players, {from = uid.ANIHI_ARACURA_PLAYER1, dest = uid.ANIHI_ARACURA_NPOS4})
		table.insert(players, {from = uid.ANIHI_ARACURA_PLAYER2, dest = uid.ANIHI_ARACURA_NPOS3})
		table.insert(players, {from = uid.ANIHI_ARACURA_PLAYER3, dest = uid.ANIHI_ARACURA_NPOS2})
		table.insert(players, {from = uid.ANIHI_ARACURA_PLAYER4, dest = uid.ANIHI_ARACURA_NPOS1})
		
		table.insert(demons, uid.ANIHI_ARACURA_DEMON1)
		table.insert(demons, uid.ANIHI_ARACURA_DEMON2)
		table.insert(demons, uid.ANIHI_ARACURA_DEMON3)
		table.insert(demons, uid.ANIHI_ARACURA_DEMON4)		
		table.insert(demons, uid.ANIHI_ARACURA_DEMON5)		
		table.insert(demons, uid.ANIHI_ARACURA_DEMON6)		
		table.insert(demons, uid.ANIHI_ARACURA_DEMON7)		
	else
		error("[Annihilator] Unknown actionid for location: " .. actionid)
	end

end

function canTeleportPlayers(cid)

	local ERROR = {
		NONE 							= 1,
		NEED_ALL_PLAYERS 				= 2,
		PLAYER_ALREADY_MADE_QUEST 		= 3
	}

	local stats = ERROR.NONE

	-- check if all is ok to teleport players
	for k,v in pairs(players) do
	
		local thing_pos = getThingPos(v.from)		
		local pid = getTopCreature(thing_pos).uid
		
		if(pid ~= 0) then
			if(getPlayerAccess(cid) < ACCESS_ADMIN and not isPlayer(pid)) then
				stats = ERROR.NEED_ALL_PLAYERS
				break
			end
			
			if(getPlayerStorageValue(pid, sid.ANIHI_COMPLETE) ~= -1) then
				stats = ERROR.PLAYER_ALREADY_MADE_QUEST
				break
			end
			
			players[k].cid = pid			
		else
			stats = ERROR.NEED_ALL_PLAYERS
			break
		end
	end
	
	if(stats == ERROR.NONE) then
		-- inserimos o objeto do jogador para ser usado posteriormente
		return true
	end
	
	if(stats == ERROR.PLAYER_ALREADY_MADE_QUEST) then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_DEFAULT, "A player of this team already have done this quest.")
	elseif(stats == ERROR.NEED_ALL_PLAYERS) then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_DEFAULT, "Its nescessary four players to own this quest.")
	else
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_DEFAULT, "For an unknown reason can not be make this action. An log has been reported to admin.")
		--debugPrint("Unknown error code for checking players.")
	end
	
	return false
end

local function teleportPlayers()
	for k,v in pairs(players) do
		if(v.cid) then
			local pos = getCreaturePosition(v.cid)
			doSendMagicEffect(pos, CONST_ME_TELEPORT)
			doTeleportThing(v.cid, getThingPos(v.dest))
			doSendMagicEffect(getThingPos(v.dest), CONST_ME_TELEPORT)
		end
	end
end

local function summonDemons()

	for k,v in pairs(demons) do
		local demon_pos = getThingPos(v)
		doSummonCreature("demon", demon_pos)
	end
end

function removeDemons()
	for k,v in pairs(demons) do
		local demon_pos = getThingPos(v)
		local demon = getTopCreature(demon_pos).uid
		
		if(demon ~= 0 and isMonster(demon)) then
			doRemoveCreature(demon)
		end
	end
	
	-- we need to check in player pos because the demons can be walk to this tiles
	for k,v in pairs(players) do
		local player_pos = getThingPos(v.dest)
		local pid = getTopCreature(player_pos).uid
		
		if(pid ~= 0 and isMonster(pid)) then
			doRemoveCreature(pid)	
		end
	end	
end

function onUse(cid, item, frompos, item2, topos)

	if item.itemid ~= 1945 and item.itemid ~= 1946 then
		--debugPrint("Wrong item id?")
		return true
	end

	local lastEnter = getGlobalStorageValue(gid.ANIHI_TIMER)

	if(lastEnter == -1 or os.time() > lastEnter + INTERVAL_ENTER) then
		loadValues(item.actionid)
	
		if(canTeleportPlayers(cid)) then
			summonDemons()
			teleportPlayers()
			
			setGlobalStorageValue(gid.ANIHI_TIMER, os.time())
			addEvent(anihi_timmer, INTERVAL_ENTER * 1000)
			
			return false
		end		
	else
		local secondsLeft = ((lastEnter + INTERVAL_ENTER) - os.time()) 
		local minutes = math.ceil(secondsLeft / 60)
		
		if(secondsLeft > 60) then
			doPlayerSendTextMessage(cid, MESSAGE_EVENT_DEFAULT, "An another team has recently actived the lever. You must wait " .. minutes .. " minutes to activate it again.")
		else
			doPlayerSendTextMessage(cid, MESSAGE_EVENT_DEFAULT, "An another team has recently actived the lever. You must wait less then a minute to activate it again.")
		end
	end
	
	return true
end

function anihi_timmer()

	removeDemons()
end 