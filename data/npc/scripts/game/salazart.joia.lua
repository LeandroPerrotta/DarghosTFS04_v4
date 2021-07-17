local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
D_CustomNpcModules.parseCustomParameters(keywordHandler, npcHandler)

function onCreatureAppear(cid)                          npcHandler:onCreatureAppear(cid)                        end
function onCreatureDisappear(cid)                       npcHandler:onCreatureDisappear(cid)                     end
function onCreatureSay(cid, type, msg)                  npcHandler:onCreatureSay(cid, type, msg)                end
function onThink()                                      npcHandler:onThink()                                    end

local AMULET_PIECES = { 8262, 8263, 8264, 8265 } 
local ITEM_KOSHEI_AMULET = 8266

function hasAllPieces(cid, pieces)
	local found = 0
	for k,v in pairs(pieces) do
		if(getPlayerItemCount(cid, v) >= 1) then found = found + 1 end		
	end
	
	return found >= #pieces
end

function takeAllPieces(cid, pieces)
	for k,v in pairs(pieces) do
		if not doPlayerRemoveItem(cid, v, 1) then print('[Warning - ' .. getCreatureName(getNpcId()) .. '] Impossivel remover todas as partes de ' .. getPlayerName(cid) .. '.') return false end
	end
	
	return true
end

function process(cid, message, keywords, parameters, node)
	
	local npcHandler = parameters.npcHandler
	local talkState = parameters.talk_state
	
    if(not npcHandler:isFocused(cid)) then
        return false
    end 
    
    local alreadyHasAmulet = (getPlayerStorageValue(cid, sid.GET_KOSHEI_AMULET) == 1) and true or false
    local amuletDate = getPlayerStorageValue(cid, sid.KOSHEI_AMULET_DATE)
    local hasAllPieces = hasAllPieces(cid, AMULET_PIECES)
    
    if(talkState == 1) then
    	if(not alreadyHasAmulet) then
    		if(hasAllPieces or amuletDate ~= 1) then
    			if(amuletDate == -1) then
    				npcHandler:say("Oooohhh! Quanto tempo eu n�o via isto? Todas as partes reunidas! Magnifico trabalho! Se voc� me entregar-las e mais 5000 moedas de ouro para amanha eu lhe entregarei o amuleto do velho Koshei, aceita?", cid)
    			elseif(amuletDate + (60 * 60 * 24) > os.time()) then
    				npcHandler:say("Mas ainda n�o se passou um dia, o seu amuleto ainda n�o est� pronto! Deixe-me trabalhar ou ir� atrazar!", cid)
    				npcHandler:resetNpc(cid)
				else
					local tmp = doCreateItemEx(ITEM_KOSHEI_AMULET, 1)
					if(doPlayerAddItemEx(cid, tmp, true) ~= RETURNVALUE_NOERROR) then
						print('[Warning - ' .. getCreatureName(getNpcId()) .. '] Impossivel adicionar o amuleto a ' .. getPlayerName(cid) .. '.')
						npcHandler:resetNpc(cid)
						return false
					end
					
					setPlayerStorageValue(cid, sid.GET_KOSHEI_AMULET, 1)
							
					npcHandler:say("Que bom lhe ver, por que tanta demora?? Tenho boas noticias! Seu amuleto est� pronto! Aqui est�! Espero que fa�a bom aproveito!", cid)
    			end
    		else
    			npcHandler:say("Ent�o quer saber do amuleto? Ohh.. Ok! Estamos falando de um artefato muito poderoso, o amuleto de Koshei, uma criatura que acreditam ser imortal! E eu posso o fazer, voc� o gostaria?", cid)
    		end		
    	else
    		npcHandler:say("Mas que pena, n�o conhe�o outros amuletos especiais al�m do que j� lhe fiz...", cid)
    		npcHandler:resetNpc()
    	end
    elseif(talkState == 2) then
    	if(hasAllPieces) then
    		if(takeAllPieces(cid, AMULET_PIECES)) then
    			doPlayerRemoveMoney(cid, 5000)
    			setPlayerStorageValue(cid, sid.KOSHEI_AMULET_DATE, os.time())
    			npcHandler:say("Otimo, agora m� de um dia para trabalhar na restaura��o, retorne amanha e lhe entregarei o amuleto!", cid)
			else
				npcHandler:resetNpc()
				return false
    		end
    	else
    		npcHandler:say("Bom, para conseguir-lo n�o ser� facil, pois o amuleto foi partido em quatro partes que est�o espalhadas por todo deserto de Salazart. Mas eu sei o lugar aproximado em que elas est�o, voc� precisar� buscar-las, certo?", cid)
    	end 	
    elseif(talkState == 3) then
    	npcHandler:say("Preste aten��o: O paradeiro da primeira parte � uma camara no sub-solo n�o muito longe daqui ao sudoeste, proximo a entrada para o barco da cidade, procure-o nas raizes do ch�o. Para a segunda parte siga ao sudeste, procure na proa do barco dos piratas esqueletos.", cid)
    	npcHandler:say("Para a terceira parte siga ao norte, e voc� encontrar� um pequeno o�sis, procure nas arvores. E finalmente para a quarta e �ltima parte siga ao noroeste pela margem do oceano, logo quando este der lugar a montanha examine as rochas. Retorne quando estiver com todas as partes.", cid)
    end
    
    return true
end

local node1 = keywordHandler:addKeyword({'amuleto'}, process, {npcHandler = npcHandler, onlyFocus = true, talk_state = 1})
    local node2 = node1:addChildKeyword({'yes', 'sim'}, process, {npcHandler = npcHandler, onlyFocus = true, talk_state = 2})
   		node2:addChildKeyword({'yes', 'sim'}, process, {npcHandler = npcHandler, onlyFocus = true, talk_state = 3})   
    	node2:addChildKeyword({'no', 'n�o', 'n�o'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Que pena... Tem algo mais em que eu possa lhe ajudar?', reset = true})
    
    node1:addChildKeyword({'no', 'n�o', 'n�o'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Que pena... Tem algo mais em que eu possa lhe ajudar?', reset = true})

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())