local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
local tellingAStory
 
function onCreatureAppear(cid)            npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)        npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)        npcHandler:onCreatureSay(cid, type, msg) end
function onThink() if #npcHandler.focuses == 0 then selfTurn(WEST) end                npcHandler:onThink() end
 
function greetCallback(cid)
	talkState[cid] = 0
	tellingAStory = 0
	return true
end

local messagesTable = {
	mission_firstTalk = {
		"Voc� deve ter ouvido sobre os problemas que estamos enfrentando aqui em Kashmir. Nossas for�as s�o limitadas e precisamos de ajuda externa.",
		"Quer saber o que est� acontecendo?",
	},
	mission_secondTalk = {
		"Bom, o nosso maior problema � o meu superior. Um dos nobres mais ricos e poderosos de Kashmir, seu nome � Azerus. Ele vem agindo de forma muita estranha ultimamente e percebi que a situa��o chegou a um n�vel cr�tico.",
		"Muitos nobres com quem ele disputava o poder e as riquezas de Kashmir foram mortos. E as explica��es todas muito suspeitas. Algumas explos�es foram ouvidas vindo do esgoto, inclusive tremores cont�nuos � noite.",
		"Em alguns de meus sonhos vi criaturas malignas nunca antes vistas...",
		"Pelo que pude concluir Azerus est� formando um ex�rcito para tomar a cidade, e depois todo o Darghos! O seu �ltimo passo parece que � algum tipo de ritual para invocar os �ltimos e mais poderoso dem�nios.",
		"O mecanismo usado para a invoca��o deve ficar no {centro} do seu 'laborat�rio' e necessita de muita energia. Preciso que voc� invada seu laborat�rio antes que ele comece a invoca��o e enfrente-o!",
		"Entenda que ser� muito perigoso, Azerus possui muitos poderes e � por isso que precisamos de sua ajuda. Ent�o, posso contar com voc�?",
	},
	mission_thirdTalk = {
		"Gra�as aos deuses! Mas antes de ir voc� precisa saber de duas coisas {muito importantes}. Primeiro, preciso ter certeza que voc� obteve �xito, ou seja, tenha {visto com} {seus pr�prios olhos} que o ex�rcito de Azerus foi impedido de entrar no nosso mundo.",
		"Segundo, Azerus carrega consigo um tipo de {dispositivo teleportador} que provavelmente o teleporta para o lugar onde ele est� reunindo seu ex�rcito.",
		"Lembre-se que preciso ter certeza de que voc� obteve �xito, caso contr�rio {n�o} poderei lhe dar acesso � sala de recompensa.",
		"Pronto! Te dei permiss�o para acessar o pal�cio. Leve outros com voc� porque {sozinho n�o conseguir� derrot�-lo}! V�, Kashmir depende de voc�!",
	},
}

local function sayMessages(messageTable, delay, config, currentMessageIndex, endTalkState, changeStorage)
	if not npcHandler:isFocused(config.cid) then
		return false
	else
		doCreatureSay(config.npcCid, messageTable[currentMessageIndex], TALKTYPE_PRIVATE_NP, false, config.cid, config.npcPos)		
		if currentMessageIndex < table.getn(messageTable) then
			currentMessageIndex = currentMessageIndex + 1
			addEvent(sayMessages, delay, messageTable, delay, config, currentMessageIndex, endTalkState, changeStorage)
		elseif currentMessageIndex == table.getn(messageTable) then
			if endTalkState ~= nil then -- op��o para usar a fun��o sem mudar o talkState
				talkState[config.cid] = endTalkState
			end
			if changeStorage ~= nil then
				setPlayerStorageValue(config.cid, changeStorage.id, changeStorage.value)
			end
			tellingAStory = 0
		end
	end
end

local function npcMessagesWithDelay(cid, messagesTable, delay, endTalkState, changeStorage) -- messagesTable � o caminho para a tabela secund�ria desejada que cont�m as mensagens de certa parte da hist�ria. Delay � o tempo entre uma mensagem e outra. Pars � uma tabela que deve conter os seguintes valores: cid (do player), npcCid (cid do npc) e npcPos (posi��o do npc).
	
	local currentMessageIndex = 1
	local config = {cid=cid, npcCid=getNpcCid(), npcPos=getNpcPos()}
	tellingAStory = 1
	
	sayMessages(messagesTable, delay, config, currentMessageIndex, endTalkState, changeStorage)
	
	return true
end

function creatureSayCallback(cid, type, msg)
	
	if not npcHandler:isFocused(cid) then
		return false
	elseif tellingAStory == 0 then
		if  talkState[cid] == 0 then
			if msgcontains(msg, {'mission', 'missao', 'miss�o', 'ajuda'}) then
				if getPlayerStorageValue(cid, sid.KASHMIR_QUEST_PROGRESS) == -1 then
					npcMessagesWithDelay(cid, messagesTable.mission_firstTalk, 4000, 1, {id=sid.KASHMIR_QUEST_PROGRESS})
				elseif getPlayerStorageValue(cid, sid.KASHMIR_QUEST_PROGRESS) == 0 then
					selfSay("J� lhe dei permiss�o para acessar a sala. V� e impe�a-o enquanto h� tempo!", cid)
					talkState[cid] = 0
				elseif getPlayerStorageValue(cid, sid.KASHMIR_QUEST_PROGRESS) >= 1 then
					if canPlayerWearOutfitId(cid, 21) then
						selfSay("N�o tenho palavras para agradecer, mas posso lhe dar mais uma recompensa: uma {vestimenta} digna de um cidad�o de Kashmir!", cid)
					else
						selfSay("Voc� salvou Kashmir! Seremos eternamente gratos!", cid)
					end
					talkState[cid] = 0
				end
			elseif msgcontains(msg, {'outfit', 'outfits', 'vestimenta', 'vestes'}) then
				if getPlayerStorageValue(cid, sid.KASHMIR_QUEST_PROGRESS) >= 1 then 
					if getPlayerStorageValue(cid, sid.KASHMIR_QUEST_OUTFIT) ~= 1 then
						selfSay("Aqui est�! Para que se lembre que Kashmir sempre lembrar� da sua bravura.", cid)
						doPlayerAddOutfitId(cid, 21, 3)
						setPlayerStorageValue(cid, sid.KASHMIR_QUEST_OUTFIT, 1)
					else
						selfSay("Voc� j� possui as vestes de Kashmir! Use-as com orgulho!", cid)
					end
				elseif getPlayerStorageValue(cid, sid.KASHMIR_QUEST_PROGRESS) < 1 then
					selfSay("Voc� n�o merece essa recompensa... Mas Kashmir precisa de {ajuda}, se voc� se juntar a nossa causa talvez eu mude de ideia.", cid)
				end
				talkState[cid] = 0
			elseif msgcontains(msg, {'addon'}) then
				selfSay("N�o sei nada sobre addons... mas posso lhe dar como recompensa {vestes} especiais.", cid)
				talkState[cid] = 0
			end
		elseif talkState[cid] == 1 then
			if msgcontains(msg, {'yes', 'sim'}) then
				npcMessagesWithDelay(cid, messagesTable.mission_secondTalk, 8000, 2)
			elseif (msgcontains(msg, {'no', 'n�o', 'nao'}) and getPlayerStorageValue(cid, sid.KASHMIR_QUEST_PROGRESS) == -1) then
				selfSay("Caso mude de ideia estarei aqui.", cid)
				talkState[cid] = 0
			else
				selfSay("N�o entendi o que voc� disse.", cid)
				talkState[cid] = 0
			end
		elseif talkState[cid] == 2 then
			if msgcontains(msg, {'yes', 'sim'}) then
				npcMessagesWithDelay(cid, messagesTable.mission_thirdTalk, 8000, 0, {id=sid.KASHMIR_QUEST_PROGRESS, value=0})
			elseif msgcontains(msg, {'no', 'n�o', 'nao'}) then
				selfSay("� uma pena. Kashmir precisa de sua ajuda, mas n�o posso for��-lo...", cid)
				talkState[cid] = 0
			else
				selfSay("N�o entendi o que voc� disse.", cid)
				talkState[cid] = 0
			end
		end
	end
	return true
end
	
			
			
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
