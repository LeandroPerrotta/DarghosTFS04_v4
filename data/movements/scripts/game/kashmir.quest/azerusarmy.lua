function onStepIn(cid, item, position, fromPosition)
	if getCreatureStorage(cid, sid.KASHMIR_QUEST_PROGRESS) == 0 then
		doCreatureSay(cid, "Parece que ao derrotar Azerus voc� impediu que o seu ex�rcito invadisse o Darghos! � melhor sair desse lugar medonho para sempre.", TALKTYPE_MONSTER_YELL, false, cid)
		doCreatureSetStorage(cid, sid.KASHMIR_QUEST_PROGRESS, 1)
	elseif getCreatureStorage(cid, sid.KASHMIR_QUEST_PROGRESS) == -1 then
		doPlayerSendTextMessage(cid, 22, "Voc� n�o tem acesso � Kashmir Quest, como voc� veio parar aqui? ...")
	end
	return TRUE
end

