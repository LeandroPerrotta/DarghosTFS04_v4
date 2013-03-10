local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) 			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid) 		end
function onCreatureSay(cid, type, msg) 		npcHandler:onCreatureSay(cid, type, msg) 	end
function onThink() 							npcHandler:onThink() 						end

keywordHandler:addKeyword({'bless', 'ben��o', 'bencao', 'twist of fate', 'pvp bless'}, D_CustomNpcModules.offerBlessing, {npcHandler = npcHandler, onlyFocus = true, ispvp = true, cost = 190000})
keywordHandler:addKeyword({'job', 'trabalho', 'ajudar'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Eu ajudo os novatos que passam por aqui. Eu tamb�m sou autorizado a aben�oar com a {twist of fate}, a ben��o para o {pvp}.'})


npcHandler:addModule(FocusModule:new())
