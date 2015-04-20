-- ACTIONS HANDLER

function defaultActions(cid, item, fromPosition, itemEx, toPosition)

	local item_id = item.itemid
	
	local ret = false
	
	local CHRISTMAS_PRESENTS = {
		CUSTOM_ITEMS.GREEN_CHRISTMAS_PRESENT,
		CUSTOM_ITEMS.RED_CHRISTMAS_PRESENT,
		CUSTOM_ITEMS.BLUE_CHRISTMAS_PRESENT,
		CUSTOM_ITEMS.BIG_CHRISTMAS_PRESENT,
	}
	
	if(item_id == CUSTOM_ITEMS.TELEPORT_RUNE) then
		ret = teleportRune.onUse(cid, item, fromPosition, itemEx, toPosition)
	elseif(item_id == CUSTOM_ITEMS.UNHOLY_SWORD) then
		ret = unholySword.onUse(cid, item, fromPosition, itemEx, toPosition)
	elseif(item_id == CUSTOM_ITEMS.VIP_SCROLL_MONTLY or item_id == CUSTOM_ITEMS.VIP_SCROLL_WEEKLY) then
		ret = vipScroll.onUse(cid, item, fromPosition, itemEx, toPosition)
	elseif(item_id == CUSTOM_ITEMS.OUTFIT_TICKET) then
		ret = outfitTicket.onUse(cid, item, fromPosition, itemEx, toPosition)
	elseif(isInArray(CHRISTMAS_PRESENTS, item_id)) then
		ret = christmasPresent.onUse(cid, item, fromPosition, itemEx, toPosition)
	elseif(item_id == CUSTOM_ITEMS.FLASK_OF_MAGIC_PRODUCTIVITY)  then
		ret = staminaFlask.onUse(cid, item, fromPosition, itemEx, toPosition)
	end

	return ret
end

christmasPresent = {}

function christmasPresent.onUse(cid, item, fromPosition, itemEx, toPosition)

	local items = {
		purple_knife = {id = 10513},
		red_knife = {id = 10511},
		blue_knife = {id = 10515},
		brotherhood_ticket = {id = 12691, actionid = 19},
		nightmare_ticket = {id = 12691, actionid = 17},
		wizard_ticket = {id = 12691, actionid = 10},
		pirate_ticket = {id = 12691, actionid = 12},
		oriental_ticket = {id = 12691, actionid = 11},
		assassin_ticket = {id = 12691, actionid = 13},
		barbarian_ticket = {id = 12691, actionid = 8},
		hunter_ticket = {id = 12691, actionid = 2},
		warrior_ticket = {id = 12691, actionid = 7},
		mage_ticket = {id = 12691, actionid = 3},
		summoner_ticket = {id = 12691, actionid = 6},
		warmaster_ticket = {id = 12691, actionid = 22},
		yalaharian_ticket = {id = 12691, actionid = 21},
		wayfarer_ticket = {id = 12691, actionid = 23},
		soft_boots = {id = 6132},
		firewalker_boots = {id = 9933},
		nightmare_shield = {id = 6391},
		necromancer_shield = {id = 6433},
		spellbook_of_dark_mysteries = {id = 8918},
		royal_crossbow = {id = 8851},
		zaoan_helmet = {id = 11302},
		zaoan_legs = {id = 11304},
		fireborn_giant_armor = {id = 8881},
		master_archer_armor = {id = 8888},
		hellforged_axe = {id = 8924},
		obsidian_truncheon = {id = 8928},
		emerald_sword = {id = 8930},
		windborn_colossus_armor = {id = 8883},
		yalahari_armor = {id = 9776},
		guardian_boots = {id = 11240},
		yalahari_mask = {id = 9778},
		the_devileye = {id = 8852},
		great_shield = {id = 2522},
		golden_boots = {id = 2646},
		demon_legs = {id = 2495},
		earthborn_titan_armor = {id = 8882},
		royal_draken_mail = {id = 12642},
		yalahari_leg_piece = {id = 9777},
		elite_draken_helmet = {id = 12645}
	}

	local SORTED_ITEMS = {
		[CUSTOM_ITEMS.GREEN_CHRISTMAS_PRESENT] = {
			knife = { items.purple_knife, items.red_knife, items.blue_knife }, 
			outfit = { items.brotherhood_ticket, items.nightmare_ticket, items.wizard_ticket, pirate_ticket, oriental_ticket },
			item1 = { items.soft_boots, items.firewalker_boots },
			item2 = { items.nightmare_shield, items.necromancer_shield }
		},
		[CUSTOM_ITEMS.RED_CHRISTMAS_PRESENT] = {
			knife = { items.purple_knife, items.red_knife, items.blue_knife }, 
			outfit = { items.assassin_ticket, items.barbarian_ticket, items.hunter_ticket, items.warrior_ticket },
			item1 = { items.spellbook_of_dark_mysteries, items.royal_crossbow },
			item2 = { items.zaoan_helmet, items.zoan_legs }
		},
		[CUSTOM_ITEMS.BLUE_CHRISTMAS_PRESENT] = {
			knife = { items.purple_knife, items.red_knife, items.blue_knife }, 
			outfit = { items.mage_ticket, items.summoner_ticket, items.warmaster_ticket },
			item1 = { items.fireborn_giant_armor, items.master_archer_armor, items.hellforged_axe, items.obsidian_truncheon, items.emerald_sword },
			item2 ={ items.windborn_colossus_armor, items.yalahari_armor, items.guardian_boots, items.yalahari_mask }
		},
		[CUSTOM_ITEMS.BIG_CHRISTMAS_PRESENT] = {
			knife = { items.purple_knife, items.red_knife, items.blue_knife }, 
			outfit = { items.yalaharian_ticket, items.wayfarer_ticket },
			item1 = { items.the_devileye, items.great_shield, items.golden_boots, items.demon_legs },
			item2 = { items.earthborn_titan_armor, items.royal_draken_mail, items.yalahari_leg_piece, items.elite_draken_helmet }
		}
	}
	
	local date = os.date("*t")
	
	if(item.actionid == aid.OPEN_CHRISTMAS_PRESENT) then
	
		-- Somente pode abrir depois da meia noite :P
		if(date.day < 25 and date.month == 12 and date.year == 2011) then			
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Hey! Ainda n�o � dia de natal! Tenha paciencia e aguarde at� a noite de natal!")
			doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
			return true
		end
		
		-- Ok, abrindo o presente...
		local presentContent = SORTED_ITEMS[item.itemid]	
		local present = doCreateItemEx(item.itemid)
		
		local sortedOutfit = math.random(1, #presentContent.outfit)		
		local toCreateItems = {
			presentContent.knife[math.random(1, #presentContent.knife)].id,
			presentContent.outfit[sortedOutfit].id,
			presentContent.item1[math.random(1, #presentContent.item1)].id,
			presentContent.item2[math.random(1, #presentContent.item2)].id
		}		
		
		if(item.itemid == CUSTOM_ITEMS.BIG_CHRISTMAS_PRESENT) then
			christmasPresent.sortBonusItems()
			
			local checkItems = {
				{logId = getStorage(gid.CHRISTMAS_PRESENT_DRAGON_SCALE_LEGS), id = 2469},
				{logId = getStorage(gid.CHRISTMAS_PRESENT_BLESSED_SHIELD), id = 2523},
				{logId = getStorage(gid.CHRISTMAS_PRESENT_SOLAR_AXE), id = 8925}
			}
			
			for k,v in pairs(checkItems) do
				local shopLog = getItemAttribute(item.uid, "itemShopLogId")
				if(shopLog and shopLog == v.logId) then
					table.insert(toCreateItems, v.id)
				end
			end			
		end

		local success = true
		local addedItems = {}
		
		for k,v in pairs(toCreateItems) do
			local _item = doAddContainerItem(item.uid, v)
			if (not _item) then
				success = false
				error("N�o foi possivel adicionar um item ao presente de natal do jogador " .. getPlayerName(cid) .. ". Uid: ".. v .. "")
				break
			else
				if( k == 2) then
					doItemSetActionId(_item, presentContent.outfit[sortedOutfit].actionid)
				end
				table.insert(addedItems, _item)
			end
		end
		
		if(not success) then
			for k,v in pairs(addedItems) do
				doRemoveItem(v)
			end
			
			doPlayerSendCancel(cid, "N�o foi possivel entregar o seu presente! Cerfique de possuir espa�o e capacidade sulficiente.")
			doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
		end

		
		if(success) then
			doItemSetActionId(item.uid, 0)
			doSendMagicEffect(getPlayerPosition(cid), CONST_ME_FIREWORK_RED)
			doCreatureSay(cid, "HoHoHo Feliz Natal!", TALKTYPE_MONSTER)
			return false
		end
		
		return true
	end
	
	return false
end

function christmasPresent.sortBonusItems()

	if(getStorage(gid.CHRISTMAS_PRESENT_DRAGON_SCALE_LEGS) ~= -1) then
		return
	end

	local result = db.getResult("SELECT `id` FROM `wb_itemshop_log` WHERE `shop_id` = 75;")
	
	if(result:getID() ~= -1) then
		local logIdTable = {}
	
		repeat
			table.insert(logIdTable, result:getDataInt("id"))	
		until not(result:next())
		result:free()
		
		local toSort = {
			gid.CHRISTMAS_PRESENT_DRAGON_SCALE_LEGS,
			gid.CHRISTMAS_PRESENT_BLESSED_SHIELD,
			gid.CHRISTMAS_PRESENT_SOLAR_AXE
		}
		
		for k,v in pairs(toSort) do
		
			local sortedKey = math.random(1, #logIdTable)
			doSetStorage(v, logIdTable[sortedKey])
			logIdTable[sortedKey] = nil
		end
	end
end

unholySword = {}

function unholySword.onUse(cid, item, fromPosition, itemEx, toPosition)

	if(itemEx.actionid == aid.CHURCH_ALTAR) then
		doRemoveItem(itemEx.uid, 1)
	end
end

outfitTicket = {}

function outfitTicket.onUse(cid, item, fromPosition, itemEx, toPosition)
	
	local outfitId = item.actionid or 0
	local outfitName = {
		[1] = "Citizen",
		[2] = "Hunter",
		[3] = "Mage",
		[4] = "Knight",
		[5] = "Noble",
		[6] = "Summoner",
		[7] = "Warrior",
		[8] = "Barbarian",
		[9] = "Druid",
		[10] = "Wizard",
		[11] = "Oriental",
		[12] = "Pirate",
		[13] = "Assassin",
		[14] = "Beggar",
		[15] = "Shaman",
		[16] = "Norse",
		[17] = "Nightmare",
		[18] = "Jester",
		[19] = "Brotherhood",
		[20] = "Demonhunter",
		[21] = "Yalaharian",
		[22] = "Warmaster",
		[23] = "Wayfarer"
	}

	local tempName = "Unkwnown"

	if(outfitName[outfitId] ~= nil) then
		tempName = outfitName[outfitId]
	else
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "This is an invalid outfit ticket. Report to game master!")
		return true
	end
	
	local playerOutfit = { outfit = false, first_addon = false, second_addon = false }
	
	if(canPlayerWearOutfitId(cid, outfitId, 0)) then
		playerOutfit.outfit = true
	end
	
	if(canPlayerWearOutfitId(cid, outfitId, 1)) then
		playerOutfit.first_addon = true
	end
	
	if(canPlayerWearOutfitId(cid, outfitId, 2)) then
		playerOutfit.second_addon = true
	end
	
	if(not playerOutfit.outfit) then
		local log_id = getItemAttribute(item.uid, "itemShopLogId")
		
		if(log_id and not doLogItemShopUse(cid, log_id)) then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "The benefit of this item has already been provided. Issue reported.")
			return true
		end		
	
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You earned the " .. tempName .. " outfit!")
		doPlayerAddOutfitId(cid, outfitId, 0)
	elseif(not playerOutfit.first_addon) then
		local log_id = getItemAttribute(item.uid, "itemShopLogId")
		
		if(log_id and not doLogItemShopUse(cid, log_id)) then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "The benefit of this item has already been provided. Issue reported.")
			return true
		end		
	
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You earned the first addon for " .. tempName .. " outfit!")
		doPlayerAddOutfitId(cid, outfitId, 1)	
	elseif(not playerOutfit.second_addon) then
		local log_id = getItemAttribute(item.uid, "itemShopLogId")
		
		if(log_id and not doLogItemShopUse(cid, log_id)) then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "The benefit of this item has already been provided. Issue reported.")
			return true
		end		
		
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You earned the second addon for " .. tempName .. " outfit!")
		doPlayerAddOutfitId(cid, outfitId, 2)
	else
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You already have the full " .. tempName .. " outfit!")
		return true		
	end
	
	sendEnvolveEffect(cid, CONST_ME_HOLYAREA)
	doRemoveItem(item.uid)
	return true
end

vipScroll = {}

function vipScroll.onUse(cid, item, frompos, item2, topos)
    
    vipScroll.DAYS = { [CUSTOM_ITEMS.VIP_SCROLL_MONTLY] = 30, [CUSTOM_ITEMS.VIP_SCROLL_WEEKLY] = 7}
    
    if(not hasValidEmail(cid)) then
        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Voc� n�o possui ainda um e-mail cadastrado em sua conta. Voc� n�o podera usar este item enquanto n�o resolver este problema.")
        return true
    end    
    
    local log_id = getItemAttribute(item.uid, "itemShopLogId")
    
    if(not log_id or not doLogItemShopUse(cid, log_id)) then
    
        local log_id = getItemAttribute(item.uid, "itemShopLogId") or 0
        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Este item foi detectado como duplicado e ilegal e foi APAGADO do servidor.")
        std.clog("[Warning - Item Destroyed] Duplicated itemid " .. item.itemid .. " from log shop id #" .. log_id .. " destroyed on try to use of " .. getPlayerName(cid) .. ".")
        doRemoveItem(item.uid)
        
        return true
    end
    
    doPlayerAddVipDays(cid, vipScroll.DAYS[item.itemid])
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "You get " .. vipScroll.DAYS[item.itemid] .. " days of VIP time with this vip ticket! Good luck!")
    doRemoveItem(item.uid)
    
    return true    
end

teleportRune = {}

teleportRune.STATE_NONE = -1
teleportRune.STATE_TELEPORTING_FIRST = 0
teleportRune.STATE_TELEPORTING_SECOND = 1
teleportRune.STATE_TELEPORTING_THIRD = 2

teleportRune.TELEPORT_USAGE_NEVER = -1
teleportRune.TELEPORT_USAGE_INTERVAL = 60 * 30 -- 30 minutos

function teleportRune.onUse(cid, item, frompos, item2, topos)
	
	return true
--[[
	if(teleportScrollIsLocked(cid)) then
		doPlayerSendCancel(cid, "Voc� n�o pode usar este item neste lugar!")
		return true
	end

	if(hasCondition(cid, CONDITION_INFIGHT) == TRUE) then
		doPlayerSendCancel(cid, "Voc� n�o pode usar este item enquanto estiver em batalha!")
		return true
	end
	
	if(getPlayerStorageValue(cid, sid.TELEPORT_RUNE_STATE) ~= teleportRune.STATE_NONE) then
		doPlayerSendCancel(cid, "A carga j� sendo carregada, tenha paciencia!")
		return true
	end
	
	local lastTeleportRuneUsage = getPlayerStorageValue(cid, sid.TELEPORT_RUNE_LAST_USAGE)
	if(lastTeleportRuneUsage ~= teleportRune.TELEPORT_USAGE_NEVER and os.time() <= lastTeleportRuneUsage + teleportRune.TELEPORT_USAGE_INTERVAL) then
		local secondsLeft = (lastTeleportRuneUsage + teleportRune.TELEPORT_USAGE_INTERVAL) - os.time()
		
		if(secondsLeft >= 60) then
			doPlayerSendCancel(cid, "Voc� deve aguardar " .. math.floor(secondsLeft / 60) .. " minutos para que sua teleport rune descan�e e possa usar-la novamente.")
		else
			doPlayerSendCancel(cid, "Voc� deve aguardar menos de um minuto para que sua teleport rune termine de descan�ar e possa usar-la novamente.")
		end
		
		doPlayerSendCancel(cid, "Voc� deve aguardar " .. math.ceil(((lastTeleportRuneUsage + teleportRune.TELEPORT_USAGE_INTERVAL) - os.time()) / 60) .. " minutos para que sua teleport rune descan�e e possa usar-la novamente.")
		return true
	end
	
	doCreatureSay(cid, "Faltam 30 segundos para minha teleport rune ser carregada...", TALKTYPE_ORANGE_1)
	setPlayerStorageValue(cid, sid.TELEPORT_RUNE_STATE, teleportRune.STATE_TELEPORTING_FIRST)
	addEvent(teleportRune.firstStep, 1000 * 10, cid)
	
	return true
]]
end

function teleportRune.firstStep(cid)
	if(isCreature(cid) == FALSE) then
		return
	end
	
	if(hasCondition(cid, CONDITION_INFIGHT) == TRUE) then
		setPlayerStorageValue(cid, sid.TELEPORT_RUNE_STATE, teleportRune.STATE_NONE)
		doCreatureSay(cid, "Arggh! Entrei em batalha! O transporte foi abortado!", TALKTYPE_ORANGE_1)
		return
	end	
	
	if(teleportScrollIsLocked(cid)) then
		setPlayerStorageValue(cid, sid.TELEPORT_RUNE_STATE, teleportRune.STATE_NONE)
		doCreatureSay(cid, "Arggh! A teleport rune n�o funciona neste lugar! O transporte foi abortado!", TALKTYPE_ORANGE_1)
		return	
	end
	
	doCreatureSay(cid, "Faltam 20 segundos para minha teleport rune ser carregada...", TALKTYPE_ORANGE_1)
	setPlayerStorageValue(cid, sid.TELEPORT_RUNE_STATE, teleportRune.STATE_TELEPORTING_SECOND)
	addEvent(teleportRune.secondStep, 1000 * 10, cid)
end

function teleportRune.secondStep(cid)
	if(isCreature(cid) == FALSE) then
		return
	end
	
	if(hasCondition(cid, CONDITION_INFIGHT) == TRUE) then
		setPlayerStorageValue(cid, sid.TELEPORT_RUNE_STATE, teleportRune.STATE_NONE)
		doCreatureSay(cid, "Arggh! Entrei em batalha! O transporte foi abortado!", TALKTYPE_ORANGE_1)
		return
	end	
	
	if(teleportScrollIsLocked(cid)) then
		setPlayerStorageValue(cid, sid.TELEPORT_RUNE_STATE, teleportRune.STATE_NONE)
		doCreatureSay(cid, "Arggh! A teleport rune n�o funciona neste lugar! O transporte foi abortado!", TALKTYPE_ORANGE_1)
		return	
	end	
	
	doCreatureSay(cid, "Faltam 10 segundos para minha teleport rune ser carregada...", TALKTYPE_ORANGE_1)
	setPlayerStorageValue(cid, sid.TELEPORT_RUNE_STATE, teleportRune.STATE_TELEPORTING_THIRD)
	addEvent(teleportRune.thirdStep, 1000 * 10, cid)
end

function teleportRune.thirdStep(cid)
	if(isCreature(cid) == FALSE) then
		return
	end
	
	if(hasCondition(cid, CONDITION_INFIGHT) == TRUE) then
		setPlayerStorageValue(cid, sid.TELEPORT_RUNE_STATE, teleportRune.STATE_NONE)
		doCreatureSay(cid, "Arggh! Entrei em batalha! O transporte foi abortado!", TALKTYPE_ORANGE_1)
		return
	end	
	
	if(teleportScrollIsLocked(cid)) then
		setPlayerStorageValue(cid, sid.TELEPORT_RUNE_STATE, teleportRune.STATE_NONE)
		doCreatureSay(cid, "Arggh! A teleport rune n�o funciona neste lugar! O transporte foi abortado!", TALKTYPE_ORANGE_1)
		return	
	end	
	
	doCreatureSay(cid, "Finalmente minha teleport rune foi carregada!", TALKTYPE_ORANGE_1)
	
	doSendMagicEffect(getCreaturePosition(cid), CONST_ME_MAGIC_BLUE)	
	doTeleportThing(cid, getPlayerMasterPos(cid))
	doSendMagicEffect(getCreaturePosition(cid), CONST_ME_MAGIC_BLUE)	
	
	setPlayerStorageValue(cid, sid.TELEPORT_RUNE_STATE, teleportRune.STATE_NONE)
	setPlayerStorageValue(cid, sid.TELEPORT_RUNE_LAST_USAGE, os.time())
end

staminaFlask = {}

function staminaFlask.onUse(cid, item, frompos, item2, topos)
	
	local staminaMinutes = getPlayerStamina(cid)
	
	local staminaMax = 60 * 42
	local staminaBonus = 40 * 60
	
	if(staminaMinutes >= staminaBonus) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "Voc� n�o est� t�o cansado, somente use este item quando a sua barra stamina estiver na cor laranja ou vermelha.")
		return true
	end
	
	local stamimaAdd = staminaMax - staminaMinutes
	
	doPlayerSetStamina(cid, stamimaAdd)
	doCreatureSay(cid, "Aaahhh! Incr�vel! Me sinto completamente renovado!", TALKTYPE_ORANGE_1)
	doSendMagicEffect(getPlayerPosition(cid), CONST_ME_HOLYDAMAGE)
	doRemoveItem(item.uid)
	
	return true
end