local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)                  npcHandler:onCreatureAppear(cid)                        end
function onCreatureDisappear(cid)               npcHandler:onCreatureDisappear(cid)                     end
function onCreatureSay(cid, type, msg)          npcHandler:onCreatureSay(cid, type, msg)                end
function onThink()                              npcHandler:onThink()                                    end

function task(cid, message, keywords, parameters, node)
    if(not npcHandler:isFocused(cid)) then
            return false
    end

	task = Task:new()
	task:loadById(CAP_ONE.ISLAND_OF_PEACE.EIGHTH)
	task:setPlayer(cid)
	task:setNpcName(getNpcName())
	
	if(task:getState() ~= taskStats.COMPLETED and task:checkPlayerRequirements()) then
		if(task:removeRequiredItems()) then
			if(getPlayerVocation(cid) <= 4 and isPremium(cid)) then
				setPlayerPromotionLevel(cid, 1)
				npcHandler:say("Oh! Como soube do roubo da ta�a real? Este � um artefato muito valioso! Voc� merece uma generosa recompensa pelo seu ato de bravura! Por isso, eu como Rei de Island of Peace, lhe concedo a PROMO��O!", cid)
			else
				doPlayerAddMoney(cid, 20000)
				
				if(isPremium(cid)) then
					npcHandler:say("Oh! Como soube do roubo da ta�a real? Este � um artefato muito valioso! Voc� merece uma generosa recompensa pelo seu ato de bravura! Eu pensei em lhe dar uma promo��o pelo ato, mas vejo que voc� j� esta promovido, neste caso vou lhe dar 20.000 gold coins!", cid)
				else
					npcHandler:say("Oh! Como soube do roubo da ta�a real? Este � um artefato muito valioso! Voc� merece uma generosa recompensa pelo seu ato de bravura! Eu pensei em lhe dar uma promo��o pelo ato, mas vejo que voc� n�o possui uma premium account, neste caso vou lhe dar 20.000 gold coins!", cid)
				end
			end
			
			task:setCompleted()
		else
			npcHandler:say("Os minotauros roubaram um valioso artefato de meu palacio. Meus guardas acreditam que eles o levaram para o leste, na piramide dos minotauros... Preciso de algum bravo guerreiro que se arrisque a recuperar-lo... ",cid)
		end
	else
		npcHandler:say("Uhmm, claro! As pessoas precisam de tarefas, converse com as pessoas na cidade, elas sempre possuem alguma tarefa e costumam ser generosas em suas recompensas!",cid)
	end

    return true
end

keywordHandler:addKeyword({'tarefa'}, task, nil)

D_CustomNpcModules.addPromotionHandler(keywordHandler, npcHandler)

--[[
local node2 = keywordHandler:addKeyword({'epic'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I can epicize you for 200000 gold coins. Do you want me to epicize you?'})
        node2:addChildKeyword({'yes'}, StdModule.promotePlayer, {npcHandler = npcHandler, cost = 200000, level = 120, promotion = 2, text = 'Congratulations! You are now epicized.'})
        node2:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Alright then, come back when you are ready.', reset = true})
]]--

npcHandler:addModule(FocusModule:new())