function onEnterInUngreezPortal(cid, position, fromPosition)

	local killUngreez = getPlayerStorageValue(cid, sid.INQ_KILL_UNGREEZ) == 1
	if(killUngreez) then
		doPlayerSendCancel(cid, "Voc� j� derrotou o demonio Ungreez.")
		doTeleportThing(cid, fromPosition, false)
		doSendMagicEffect(position, CONST_ME_MAGIC_BLUE)
		
		return false
	end
	
	local inQuest = getPlayerStorageValue(cid, QUESTLOG.INQUISITION.MISSION_FIRST_ADDON) == 0
	if(not inQuest) then
		doPlayerSendCancel(cid, "Somente jogadores que estiverem em uma certa miss�o podem atravessar este portal.")
		doTeleportThing(cid, fromPosition, false)
		doSendMagicEffect(position, CONST_ME_MAGIC_BLUE)		
		
		return false
	end
	
	return true
end

function movementTileOnStepIn(cid, item, position, fromPosition)	

	if(item.actionid == aid.INQ_PORTAL) then
		
		local killUngreez = (getPlayerStorageValue(cid, sid.INQ_KILL_UNGREEZ) == 1) and true or false	
		
		if(not killUngreez) then
			doPlayerSendCancel(cid, "Somente os que ajudam a combater as for�as demoniacas est�o autorizados a atravessar este portal.")
			doTeleportThing(cid, fromPosition, false)
			doSendMagicEffect(position, CONST_ME_MAGIC_BLUE)
		end
	end	

	return false
end

function movementTileOnStepOut(cid, item, position, fromPosition)
	
	return false
end

function doUpdateCreatureImpassable(cid)
		
	error("Deprecated: Not used yet.")
	--[[
	if(getPlayerGroupId(cid) > GROUP_PLAYER_NON_PVP) then
		return
	end
	
	doPlayerSetGroupId(cid, GROUP_PLAYER)
	]]
end

function doUpdateCreaturePassable(cid)
	
	error("Deprecated: Not used yet.")
	--[[
	if(getPlayerGroupId(cid) > GROUP_PLAYER_NON_PVP) then
		return
	end	
	
	if(getPlayerTown(cid) ~= towns.ISLAND_OF_PEACE) then
		return
	end
	
	doPlayerSetGroupId(cid, GROUP_PLAYER_NON_PVP)
	]]
end

function doTeleportBack(cid, backPos)
	
	if(backPos == nil) then
	
		local teleportTo = (getPlayerStorageValue(cid, sid.TELEPORT_BACK_POS) ~= -1) and unpackPosition(getPlayerStorageValue(cid, sid.TELEPORT_BACK_POS)) or false
	
		if(not teleportTo) then
			print("[Darghos Movement] doTeleportBack - Backpos not found on storage value of player " .. getPlayerName(cid) .. ".")
			return false
		end
		
		doTeleportThing(cid, teleportTo)
		doSendMagicEffect(teleportTo, CONST_ME_MAGIC_BLUE)	
		
		setPlayerStorageValue(cid, sid.TELEPORT_BACK_POS, -1)
	else
		setPlayerStorageValue(cid, sid.TELEPORT_BACK_POS, packPosition(backPos))
	end
	
	return true
end

function onEnterTrainers(cid, login)
  
	local _uid = uid.TRAINERS_ROOMS_START
	while(_uid < uid.TRAINERS_ROOMS_LAST) do
		
		local pos = getThingPosition(_uid)
		local creature = getTopCreature(pos)
		if(creature.uid == 0) then
			doTeleportThing(cid, pos)
			doSendMagicEffect(pos, CONST_ME_MAGIC_BLUE)

			setPlayerStorageValue(cid, sid.INSIDE_TRAINING_ROOM, 1)
			
			return true
		end
		
		_uid = _uid + 1
	end
	
	print("[Darghos Movement] Training Rooms - All slots full:" .. _uid)
	
	if(not login) then
		doPlayerSendCancel(cid, "Todos os trainers j� est�o em uso. Tente novamente mais tarde.")
	else
		doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)))
		setPlayerStorageValue(cid, sid.INSIDE_TRAINING_ROOM, -1)
	end
	
	return false
end

function onLeaveTrainers(cid)
	setPlayerStorageValue(cid, sid.INSIDE_TRAINING_ROOM, -1)
	return true
end