function onLogin(cid)

	--print("Custom login done!")

	--Register the kill/die event
	registerCreatureEvent(cid, "CustomPlayerDeath")
	registerCreatureEvent(cid, "CustomStages")
	registerCreatureEvent(cid, "Inquisition")
	registerCreatureEvent(cid, "CustomPlayerTarget")
	registerCreatureEvent(cid, "CustomPlayerCombat")
	registerCreatureEvent(cid, "CustomBonartesTasks")
	registerCreatureEvent(cid, "onKill")
	registerCreatureEvent(cid, "lookItem")
	registerCreatureEvent(cid, "onMoveItem")
	registerCreatureEvent(cid, "PrepareDeath")
	registerCreatureEvent(cid, "onTradeAccept")
	registerCreatureEvent(cid, "onTradeRequest")
	
	--if(tasks.hasStartedTask(cid)) then
		registerCreatureEvent(cid, "CustomTasks")
	--end
	
	registerCreatureEvent(cid, "Hacks")
	registerCreatureEvent(cid, "GainStamina")
	registerCreatureEvent(cid, "onPush")
	
	playerRecord()
	runPremiumSystem(cid)
	OnKillCreatureMission(cid)
	--Dungeons.onLogin(cid)
	--defineFirstItems(cid)
	--restoreAddon(cid)
	onLoginNotify(cid)
	--playerAutoEat(cid)
	--customStaminaUpdate(cid)
	
	if(getPlayerStorageValue(cid, sid.FIRSTLOGIN_ITEMS) ~= 1) then
		defineFirstItems(cid)
		
		if(getPlayerTown(cid) ~= towns.ISLAND_OF_PEACE) then		
			doPlayerEnablePvp(cid)
		else
			doPlayerDisablePvp(cid)
		end		
	end
	
	
	setStagesOnLogin(cid)

	local itemShop = itemShop:new()
	itemShop:onLogin(cid)
	
	Auctions.onLogin(cid)	
	
	--doPlayerOpenChannel(cid, CUSTOM_CHANNEL_PVP)
	
	-- premium test
	if(canReceivePremiumTest(cid, getPlayerLevel(cid))) then
		addPremiumTest(cid)
	end	
	
	if(not hasValidEmail(cid)) then	
		notifyValidateEmail(cid)
	end	
	
	local notifyPoll = hasPollToNotify(cid)
	if(notifyPoll) then
		local message = "Caro " .. getCreatureName(cid) ..",\n\n"
		
		message = message .. "Uma nova e importante enquete est� disponivel para vota��o em nosso website e\n"
		message = message .. "reparamos que voc� ainda n�o votou nesta enquete. No Darghos nos fazemos enquetes\n"
		message = message .. "periodicamente e elas s�o uma forma dos jogadores participarem do desenvolvimento e \n"
		message = message .. "melhorias do servidor.\n\n"
		
		message = message .. "N�o deixe de participar! A sua opini�o � muito importante para para o Darghos!\n"
		message = message .. "Para votar basta acessar acessar nosso website informado abaixo, e ir na categoria\n"
		message = message .. "'Comunidade' -> 'Enquetes' (requer login na conta).\n\n"
		
		message = message .. "www.darghos.com.br\n\n"
		
		message = message .. "Obrigado e tenha um bom jogo!"
		doPlayerPopupFYI(cid, message)
	end

	if(getPlayerAccess(cid) == access.GOD) then
		addAllOufits(cid)
	end
	
	--Give basic itens after death
	if getPlayerStorageValue(cid, sid.GIVE_ITEMS_AFTER_DEATH) == 1 then
		if getPlayerSlotItem(cid, CONST_SLOT_BACKPACK).uid == 0 then
			local item_backpack = doCreateItemEx(1988, 1) -- backpack
			
			doAddContainerItem(item_backpack, 2120, 1) -- rope
			doAddContainerItem(item_backpack, 2554, 1) -- shovel
			doAddContainerItem(item_backpack, 2666, 4) -- meat
			--doAddContainerItem(item_backpack, CUSTOM_ITEMS.TELEPORT_RUNE, 1) -- teleport rune
			
			doPlayerAddItemEx(cid, item_backpack, FALSE, CONST_SLOT_BACKPACK)
		end
		setPlayerStorageValue(cid, sid.GIVE_ITEMS_AFTER_DEATH, -1)
	end
	
	setPlayerStorageValue(cid, sid.TRAINING_SHIELD, 0)
	--setPlayerStorageValue(cid, sid.TELEPORT_RUNE_STATE, STORAGE_NULL)
	setPlayerStorageValue(cid, sid.HACKS_LIGHT, LIGHT_NONE)
	setPlayerStorageValue(cid, sid.HACKS_DANCE_EVENT, STORAGE_NULL)
	setPlayerStorageValue(cid, sid.HACKS_CASTMANA, STORAGE_NULL)
	setPlayerStorageValue(cid, sid.NEXT_STAMINA_UPDATE, STORAGE_NULL)
	
	setPlayerStorageValue(cid, sid.LOGIN_LEVEL, getPlayerLevel(cid))
	setPlayerStorageValue(cid, sid.LOGIN_EXPERIENCE, getPlayerExperience(cid))
	
	-- Map Marks
	local hasMapMarks = getPlayerStorageValue(cid, sid.FIRST_LOGIN_MAPMARKS) == 1
	if not hasMapMarks then
		if(uid.MM_TICK) then
			addMapMarksByUids(cid, uid.MM_TICK, MAPMARK_TICK)
		end
		
		if(uid.MM_QUESTION) then
			addMapMarksByUids(cid, uid.MM_QUESTION, MAPMARK_QUESTION)
		end
		
		if(uid.MM_EXCLAMATION) then
			addMapMarksByUids(cid, uid.MM_EXCLAMATION, MAPMARK_EXCLAMATION)
		end
		
		if(uid.MM_STAR) then
			addMapMarksByUids(cid, uid.MM_STAR, MAPMARK_STAR)
		end
		
		if(uid.MM_CROSS) then
			addMapMarksByUids(cid, uid.MM_CROSS, MAPMARK_CROSS)
		end
		
		if(uid.MM_TEMPLE) then
			addMapMarksByUids(cid, uid.MM_TEMPLE, MAPMARK_TEMPLE)
		end
		
		if(uid.MM_KISS) then
			addMapMarksByUids(cid, uid.MM_KISS, MAPMARK_KISS)
		end
		
		if(uid.MM_SHOVEL) then
			addMapMarksByUids(cid, uid.MM_SHOVEL, MAPMARK_SHOVEL)
		end
		
		if(uid.MM_SWORD) then
			addMapMarksByUids(cid, uid.MM_SWORD, MAPMARK_SWORD)
		end
		
		if(uid.MM_FLAG) then
			addMapMarksByUids(cid, uid.MM_FLAG, MAPMARK_FLAG)
		end
		
		if(uid.MM_LOCK) then
			addMapMarksByUids(cid, uid.MM_LOCK, MAPMARK_LOCK)
		end
		
		if(uid.MM_BAG) then
			addMapMarksByUids(cid, uid.MM_BAG, MAPMARK_BAG)
		end
		--[[ debuga o client
		if(uid.MM_SKULL) then
			addMapMarksByUids(cid, uid.MM_SKULL, MAPMARK_SKULL)
		end
		]]
		if(uid.MM_DOLLAR) then
			addMapMarksByUids(cid, uid.MM_DOLLAR, MAPMARK_DOLLAR)
		end
		
		if(uid.MM_RED_NORTH) then
			addMapMarksByUids(cid, uid.MM_RED_NORTH, MAPMARK_REDNORTH)
		end
		
		if(uid.MM_RED_SOUTH) then
			addMapMarksByUids(cid, uid.MM_RED_SOULTH, MAPMARK_REDSOUTH)
		end
		
		if(uid.MM_RED_EAST) then
			addMapMarksByUids(cid, uid.MM_RED_EAST, MAPMARK_REDEAST)
		end
		
		if(uid.MM_RED_WEST) then
			addMapMarksByUids(cid, uid.MM_RED_WEST, MAPMARK_REDWEST)
		end
		
		if(uid.MM_GREEN_NORTH) then
			addMapMarksByUids(cid, uid.MM_GREEN_NORTH, MAPMARK_GREENNORTH)
		end
		
		if(uid.MM_GREEN_SOUTH) then
			addMapMarksByUids(cid, uid.MM_GREEN_SOUTH, MAPMARK_GREENSOUTH)
		end
		
		setPlayerStorageValue(cid, sid.FIRST_LOGIN_MAPMARKS, 1)
	end
	
	if(isInTunnel(cid)) then
 		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Voce est� conectado atrav�s do Darghos Tunnel!")
 	end	
	
	return TRUE
end

function addMapMarksByUids(cid, uids, type)

	for k,v in pairs(uids) do
		local pos = getThingPosition(12000 + v.uid)
		doPlayerAddMapMark(cid, pos, type, v.description)
	end
end

function onLoginNotify(cid)

	--[[
	local today = os.date("*t").wday
	
	local msg = nil
	
	if(isInArray({WEEKDAY.SUNDAY, WEEKDAY.TUESDAY}, today)) then
		local eventState = getStorage(gid.EVENT_MINI_GAME_STATE)
	
		if(isInArray({EVENT_STATE_NONE, EVENT_STATE_INIT}, eventState)) then
		
			msg = (eventState == EVENT_STATE_INIT) and "Evento do dia (ABERTO!!):\n\n" or "Evento do dia:\n\n"			
			msg = msg .. "N�o se esque�a que hoje � dia do evento semanal Warmaster a partir das 15:00 PM! \n\n"
			msg = msg .. "O Warmaster � um evento de PvP que acontece as ter�a-feiras e domingos e o vencedor � premiado com um ticket para o Warmaster Outfit. \n"
			msg = msg .. "A entrada do evento fica no deserto ao oeste de Quendor, em uma estrutura com teleports.\n"
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, msg)
			msg = ""
			msg = msg .. "Dentro do evento tudo � Hardcore PvP e se voc� morrer n�o perder� nada. O objetivo � simplesmente destruir os obstaculos e se manter vivo!\n"
			msg = msg .. "Na ultima sala existir� o boss que ao ser derrotado dropar� o premio!\n"
		end
	end
	
	if(today == WEEKDAY.SATURDAY) then
	
		local eventState = getStorage(gid.EVENT_DARK_GENERAL)
		
		if(isInArray({EVENT_STATE_NONE, EVENT_STATE_INIT}, eventState)) then
			msg = (eventState == EVENT_STATE_INIT) and "Invas�o do dia (INICIADA!!):\n\n" or "Invas�o do dia:\n\n"	
			msg = msg .. "Informantes de Ordon anunciaram que Quendor precisar� se unir para mais um desafio! Dark General e a Armada Negra marcham diretamente para a cidade! \n\n"
			msg = msg .. "O Dark General � uma invas�o especial e desafiadora que ocorre todos s�bados as 16:00, durante o evento todas as penalidades em mortes s�o desativadas. \n"
			msg = msg .. "Os jogadores dever�o se preparar para enfrentar os poderosos seguidores da Armada Negra, como Dark Warrior, Dark Archer, Dark Mage, Dark Summoner,\n"
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, msg)
			msg = ""
			msg = msg .. "Dark Priestess al�m de seu lider, o Dark General!\n"
			msg = msg .. "A invas�o � uma otima oportunidade para conseguir items raros nas criaturas derrotadas assim como exp�riencia, al�m de muita divers�o! Participe!\n"			
		end
	end
	
	if(today == darghos_weecly_change_day and getPlayerLevel(cid) >= darghos_weecly_change_max_level_any_day) then
	
		msg = "Lembrete do dia:\n\n"
		msg = msg .. "Hoje � " .. WEEKDAY_STRING[darghos_weecly_change_day] .. " e o barco que faz viagens entre Quendor (area para agressivos) e Island of Peace (area para pacificos) est� disponivel caso voc� deseje mudar seu personagem de area! \n"
		msg = msg .. "Pense bem e lembre-se que caso seja feita a mudan�a voc� precisar� permanecer na area escolhida ao menos at� a proxima " .. WEEKDAY_STRING[darghos_weecly_change_day] .. "!\n"
	end
	
	if(msg ~= nil) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, msg)
	end
	]]
end
