local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)


function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) 			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid) 		end
function onCreatureSay(cid, type, msg) 		npcHandler:onCreatureSay(cid, type, msg) 	end
function onThink() 							npcHandler:onThink() 						end

local confirmPattern = {'yes', 'sim'}
local negationPattern = {'no', 'n�o', 'nao'}

local TALK_MISSION = {
	NONE = 0,
	FIRST_START = 1,
	FIRST_FINISH = 2,
	SECOND_START = 3,
	SECOND_FINISH = 4,
	THIRD_START = 5,
	THIRD_FINISH = 6
}

local TALK_STATE = TALK_MISSION.NONE

function npcSystemHeader(cid, message, keywords, parameters, node)

	local npcHandler = parameters.npcHandler
	
	if(npcHandler == nil) then
		print('[Warning - ' .. getCreatureName(getNpcId()) .. '] NpcSystem:', 'StdModule.travel - Call without any npcHandler instance.')
		return false
	end

	if(not npcHandler:isFocused(cid)) then
		return false
	end
	
	return true
end

function noCallback(cid, message, keywords, parameters, node)

	local messages = {
		"Se mudar de ideia estarei aqui!",
		"Sem problemas...",
		"Ent�o posso lhe ajudar em algo mais?",
		"Argh! Droga!"
	}

	local rand = math.random(1, #messages)
	local npcHandler = parameters.npcHandler
	npcHandler:say(messages[rand], cid)
	
	if(parameters.talkState ~= nil) then
		parameters.talkState = TALK_MISSION.NONE
	end
	
	npcHandler:resetNpc(cid)
	return true
end

function yesCallback(cid, message, keywords, parameters, node)

	local talkState = parameters.talkState
	
	local ret = true
	
	if(talkState == TALK_MISSION.FIRST_START) then
		ret = startFirstMissionCallback(cid, message, keywords, parameters, node)
	elseif(talkState == TALK_MISSION.FIRST_FINISH) then
		ret = finishFirstMissionCallback(cid, message, keywords, parameters, node)
	elseif(talkState == TALK_MISSION.SECOND_START) then
		ret = startSecondMissionCallback(cid, message, keywords, parameters, node)
	elseif(talkState == TALK_MISSION.SECOND_FINISH) then
		ret = finishSecondMissionCallback(cid, message, keywords, parameters, node)
	elseif(talkState == TALK_MISSION.THIRD_START) then
		ret = startThirdMissionCallback(cid, message, keywords, parameters, node)
	elseif(talkState == TALK_MISSION.THIRD_FINISH) then
		ret = finishThirdMissionCallback(cid, message, keywords, parameters, node)
	end
	
	talkState = TALK_MISSION.NONE
	return ret
end

function startFirstMissionCallback(cid, message, keywords, parameters, node)

	if(not npcSystemHeader(cid, message, keywords, parameters, node)) then
		return false
	end

	local npcHandler = parameters.npcHandler

	setPlayerStorageValue(cid, QUESTLOG.INQUISITION.MISSION_OUTFIT, 0)
	npcHandler:say("Ent�o prove o seu valor e retorne quando tiver em posse do solicitado! Boa sorte!", cid)
	
	npcHandler:resetNpc()
	return true
end

function finishFirstMissionCallback(cid, message, keywords, parameters, node)

	if(not npcSystemHeader(cid, message, keywords, parameters, node)) then
		return false
	end

	local npcHandler = parameters.npcHandler

	local ITEMS_DEMONIC_ESSENCE = 6500

	if(getPlayerItemCount(cid, ITEMS_DEMONIC_ESSENCE) < 20) then
		npcHandler:say("Que decep��o! Voc� ainda n�o conseguiu as 20 demonic essences que lhe solicitei! Estou a come�ando a achar que n�o conseguira cumprir-la...", cid)		
		npcHandler:resetNpc()
		
		return true
	end	
	
	if(not doPlayerRemoveItem(cid, ITEMS_DEMONIC_ESSENCE, 20)) then
		print('[Warning - ' .. getCreatureName(getNpcId()) .. '] NpcSystem:', 'Inquisition - Can not remove required items. Details:', '{player=' .. getCreatureName(cid) .. ', item_id=' .. ITEMS_DEMONIC_ESSENCE .. ', count=' .. 20 .. '}')
		return false
	end	

	setPlayerStorageValue(cid, QUESTLOG.INQUISITION.MISSION_OUTFIT, 1)
	doPlayerAddOutfitId(cid, 20, 0)
	
	npcHandler:say("Confesso que estou surpreso! Como recompensa eu lhe darei uma nova roupa, a do ca�ador de demonios! Retorne quando estiver preparado para sua primeira miss�o!", cid)
	
	npcHandler:resetNpc()
	return true
end

function startSecondMissionCallback(cid, message, keywords, parameters, node)

	if(not npcSystemHeader(cid, message, keywords, parameters, node)) then
		return false
	end

	local npcHandler = parameters.npcHandler

	setPlayerStorageValue(cid, QUESTLOG.INQUISITION.MISSION_FIRST_ADDON, 0)
	npcHandler:say("Este demonio � conhecido como Ungreez, h� informa��es que atualmente ele pode ser encontrado atravez da caverna ao sul de Aracura, e tamb�m de algum lugar de Aaragon. Estarei aguardando a sua volta com a miss�o concluida!", cid)
	npcHandler:resetNpc()
	
	return true
end

function finishSecondMissionCallback(cid, message, keywords, parameters, node)

	if(not npcSystemHeader(cid, message, keywords, parameters, node)) then
		return false
	end

	local npcHandler = parameters.npcHandler
	local killUngreez = (getPlayerStorageValue(cid, sid.INQ_KILL_UNGREEZ) == 1) and true or false

	if(not killUngreez) then
		npcHandler:say("Est� tentando me enganar " .. getCreatureName(cid) .. "? Eu ainda posso sentir que as for�as demoniacas continuam forte! Derrote-o!", cid)
		npcHandler:resetNpc()
		
		return true
	end	

	setPlayerStorageValue(cid, QUESTLOG.INQUISITION.MISSION_FIRST_ADDON, 1)
	doPlayerAddOutfitId(cid, 20, 1)
	
	npcHandler:say("Bom trabalho " .. getCreatureName(cid) .. "! Ja vejo as for�as demoniacas muito mais vulneraveis! Como recompensa lhe concedo alguns infeites para sua roupa! <...>", cid)
	npcHandler:say("Retorne a falar comigo quando estiver preparado para a sua ultima e mais perigosa miss�o!", cid)
	
	npcHandler:resetNpc()	
	return true
end

function startThirdMissionCallback(cid, message, keywords, parameters, node)

	if(not npcSystemHeader(cid, message, keywords, parameters, node)) then
		return false
	end

	local npcHandler = parameters.npcHandler

	local ITEMS_SPECIAL_FLASK = 7494
	
	local tmp = doCreateItemEx(ITEMS_SPECIAL_FLASK, 1)
	
	if(getPlayerFreeCap(cid) < getItemWeightById(ITEMS_SPECIAL_FLASK, 1) or doPlayerAddItemEx(cid, tmp, false) ~= RETURNVALUE_NOERROR) then
		npcHandler:say("Para come�ar esta miss�o preciso lhe dar um frasco com o liquido sagrado, porem voc� parece ja estar carregado muitos itens e n�o pode carregar-lo!", cid)
		
		npcHandler:resetNpc()
		return true	
	end

	setPlayerStorageValue(cid, QUESTLOG.INQUISITION.MISSION_SHADOW_NEXUS, 0)
	npcHandler:say("Aqui est� o frasco com a liquido sagrado. Estarei aguardando a sua volta! Espero que tenha sorte e que os Deuses lhe ajudem!", cid)
	
	npcHandler:resetNpc()
	return true
end

function finishThirdMissionCallback(cid, message, keywords, parameters, node)

	if(not npcSystemHeader(cid, message, keywords, parameters, node)) then
		return false
	end

	local npcHandler = parameters.npcHandler
	local wall = (getPlayerStorageValue(cid, sid.INQ_DONE_MWALL) == 1) and true or false

	if(not wall) then
		npcHandler:say("Toda for�a demoniaca continua muito alta e expandindo! N�o parece que voc� tenha concluido sua miss�o! Volte quando tiver a terminado!", cid)
		npcHandler:resetNpc()
		
		return true
	end	

	setPlayerStorageValue(cid, QUESTLOG.INQUISITION.MISSION_SHADOW_NEXUS, 1)
	doPlayerAddOutfitId(cid, 20, 2)
	
	npcHandler:say("Bravo guerreiro! Agora a presen�a demoniaca est� mais controlada! Todo nosso reino lhe agrade�e! <...>", cid)
	npcHandler:say("Como recompensa por sua grande miss�o lhe concedo mais alguns infeites para a sua roupa de ca�ador de demonios! Al�m disto lhe concedo a permiss�o para acessar a sala seguindo o corredor a norte <...>!", cid)
	npcHandler:say("L� voc� encontrar� alguns dos mais poderosos equipamentos e armas conhecidos e poder� escolher uma para voc�! Esteja atento a sua decis�o, pois n�o poder� voltar atraz! <...>", cid)
	npcHandler:say("Eu tamb�m terei prazer em, se necess�rio, aben�oar voc� com toda as cinco ben��es de uma vez! Boa sorte!", cid)
	
	npcHandler:resetNpc()	
	return true
end

function missionCallback(cid, message, keywords, parameters, node)

	if(not npcSystemHeader(cid, message, keywords, parameters, node)) then
		return false
	end
	
	local npcHandler = parameters.npcHandler

	local questStatus = getPlayerStorageValue(cid, QUESTLOG.INQUISITION.MISSION_OUTFIT)
	
	if(questStatus == -1) then
		npcHandler:say("N�s estamos dando uma grande investida contra as for�as demoniacas que assombram este mundo, e sim, precisamos de ajuda. Mas antes de receber a sua primeira miss�o voc� devera provar o seu valor e tambem o seu comprometimento conosco nesta guerra <...>", cid)
		npcHandler:say("Para provar isto, voc� precisar� derrotar algumas criaturas demoniacas e obter 20 demonic essences e ent�o me trazer-los. Assim irei lhe passar a sua primeira brava miss�o, al�m de lhe dar uma recompensa. E ent�o, o que me diz?", cid)

		parameters.talkState = TALK_MISSION.FIRST_START
		node:addChildKeyword(confirmPattern, yesCallback, parameters)
		node:addChildKeyword(negationPattern, noCallback, parameters)
		
		return true
	elseif(questStatus == 0) then
		npcHandler:say("E ent�o, algum progresso em seu teste?", cid)
		
		parameters.talkState = TALK_MISSION.FIRST_FINISH
		node:addChildKeyword(confirmPattern, yesCallback, parameters)
		node:addChildKeyword(negationPattern, noCallback, parameters)	
		
		return true
	end
	
	questStatus = getPlayerStorageValue(cid, QUESTLOG.INQUISITION.MISSION_FIRST_ADDON)
	
	if(questStatus == -1) then
		npcHandler:say("As essencias demoniacas que voc� me trouxe em seu teste ser�o uteis na cria��o de uma arma que nos ajudar� a combater toda for�a demoniaca. Mas para que tudo d� certo precisamos enfraquecer esta for�a primeiro <...>", cid)
		npcHandler:say("Para isto ser� necessario viajar at� o continente de Aracura e partir para uma caverna ao sul da cidade, em algum lugar nela reside um antigo demonio chamado Ungreez. <...>", cid)
		npcHandler:say("Apos encontrar-lo voc� ir� derrotar-lo e ent�o as for�as demoniacas estar�o significativame mais vulneraveis. Gostaria de cumprir esta perigosa miss�o?", cid)
		
		parameters.talkState = TALK_MISSION.SECOND_START
		node:addChildKeyword(confirmPattern, yesCallback, parameters)
		node:addChildKeyword(negationPattern, noCallback, parameters)
		
		return true	
	elseif(questStatus == 0) then
		npcHandler:say("E ent�o, o velho demonio Ungreez j� foi derrotado?", cid)
		
		parameters.talkState = TALK_MISSION.SECOND_FINISH
		node:addChildKeyword(confirmPattern, yesCallback, parameters)
		node:addChildKeyword(negationPattern, noCallback, parameters)				
		
		return true		
	end
	
	questStatus = getPlayerStorageValue(cid, QUESTLOG.INQUISITION.MISSION_SHADOW_NEXUS)
	
	if(questStatus == -1) then
		npcHandler:say("A sua ultima miss�o ser� a mais dificil e mais arriscada " .. getCreatureName(cid) .. " e creio que voc� ir� precisar de muita ajuda para concluir-la. Se lembra da arma que falei para voc� certa vez? <...>", cid)
		npcHandler:say("Pois bem, � um frasco que contem uma pequena quantidade do mais divino liquido, extraido de toda essencia demoniaca. Em sua ultima miss�o voc� precisar� ir ao local onde se origina todas for�as demoniacas <...> ", cid)
		npcHandler:say("Este lugar fica no cora��o de onde nascem os demonios, nas profundezas de caverna no continente da cidade de Aaragon e � conhecido como nexo das sombras. Entretanto seu desafio ir� come�ar muito antes de chegar l� <...> ", cid)
		npcHandler:say("Para chegar l� voc� ir� precisar enfrentar antigos e tremendamente poderosos demonios guardi�es, j� nesta parte de sua miss�o voc� ir� precisar de toda ajuda possivel <...> ", cid)
		npcHandler:say("Quando voc� conseguir chegar no nexo das sombras ir� precisar derramar o liquido divino em uma barreira magica na qual � a fonte de toda for�a demoniaca <...> ", cid)
		npcHandler:say("Ela inicialmente ir� enfraquecer porem voltar� a se fortalecer e voc� ir� precisar enfraquecer-la novamente at� que o liquido em seu frasco se esgote <...>", cid)
		npcHandler:say("Fique preparado pois os demonios n�o deixar�o voc� atacar a fonte de sua existencia passivamente. Eles ir�o atacar sem piedade voc� e seus companheiros <...>", cid)
		npcHandler:say("E ent�o, est� preparado para sua ultima miss�o?", cid)
		
		parameters.talkState = TALK_MISSION.THIRD_START
		node:addChildKeyword(confirmPattern, yesCallback, parameters)
		node:addChildKeyword(negationPattern, noCallback, parameters)	
		
		return true	
	elseif(questStatus == 0) then
		npcHandler:say("� bom lhe ver " .. getCreatureName(cid) .. "! Conseguiu completar a sua miss�o?", cid)
		
		parameters.talkState = TALK_MISSION.THIRD_FINISH
		node:addChildKeyword(confirmPattern, yesCallback, parameters)
		node:addChildKeyword(negationPattern, noCallback, parameters)	
		
		return true		
	end	
	
	npcHandler:say("Oh, infelizmente n�o tenho mais miss�es para voc� bravo guerreiro. Mas todos somos muito gratos pela sua grande contribui��o no combate as for�as demoniacas!", cid)
	npcHandler:resetNpc()	
	
	return true
end

local node = keywordHandler:addKeyword({'mission', 'miss�o', 'missao'}, missionCallback, {npcHandler = npcHandler, onlyFocus = true, talkState = TALK_MISSION.NONE})

local node1 = keywordHandler:addKeyword({'bless', 'ben��o', 'blessings'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'A bravos guerreiros que tiverem ajudado no combate as for�as demoniacas eu posso conceder todas ben��es de uma vez porem custando um pouco mais caro, voc� gostaria?'})
	node1:addChildKeyword(confirmPattern, D_CustomNpcModules.inquisitionBless, {npcHandler = npcHandler, premium = true, baseCost = 2000, aditionalCostMultipler = 1.10, levelCost = 200, startLevel = 30, endLevel = 120})
	node1:addChildKeyword(negationPattern, noCallback, {npcHandler = npcHandler, onlyFocus = true})
npcHandler:addModule(FocusModule:new())