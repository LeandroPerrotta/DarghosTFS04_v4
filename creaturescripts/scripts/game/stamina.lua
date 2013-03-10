function onThink(cid, interval)
	if(not isCreature(cid) or not isPlayer(cid) or getPlayerPremiumDays(cid) == 0) then
		return
	end
	
	local target = getCreatureTarget(cid)
	if(not target or target == 0) then
		return
	end
	
	if(getCreatureName(target) ~= "monk") then
		return
	end
	
	local master = getCreatureMaster(target)
	if(not master) then
		return
	end
	
	if(not isPlayer(master) or master == cid) then
		return
	end
	
	--[[
	local tile = getTileInfo(getCreaturePosition(cid))
	
	if(not tile.optional) then
		setPlayerStorageValue(cid, sid.NEXT_STAMINA_UPDATE, STORAGE_NULL)		
		return
	end
	]]
	
	local nextStaminaUpdate = getPlayerStorageValue(cid, sid.NEXT_STAMINA_UPDATE)
	
	if(nextStaminaUpdate ~= -1 and os.time() < nextStaminaUpdate) then
		return
	end
	
	local bonusStamina = 40 * 60
	local maxStamina = 42 * 60
	
	local staminaMinutes = getPlayerStamina(cid)
	local newStamina = staminaMinutes + 1
	
	local highStaminaInterval = (60 * 10)
	local lowStaminaInterval = (60 * 3)
	
	if(isPremium(cid)) then
		highStaminaInterval = (60 * 7)
		lowStaminaInterval = (60 * 2)	
	end
	
	if(staminaMinutes >= maxStamina) then
		return
	end
	
	if(newStamina >= bonusStamina) then		
		setPlayerStorageValue(cid, sid.NEXT_STAMINA_UPDATE, os.time() + highStaminaInterval)
	else	
		setPlayerStorageValue(cid, sid.NEXT_STAMINA_UPDATE, os.time() + lowStaminaInterval)
	end
	
	if(nextStaminaUpdate ~= -1) then
		doPlayerSetStamina(cid, 1)
		doSendAnimatedText(getPlayerPosition(cid), "STAMINA +1", TEXTCOLOR_PURPLE)
	end
end
