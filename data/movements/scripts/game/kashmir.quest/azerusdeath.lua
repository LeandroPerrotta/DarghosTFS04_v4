function onStepIn(cid, item, position, fromPosition)

        if item.itemid == 9738 then
        doTeleportThing(cid, KASHMIR_LAST_TILE_POSITION, TRUE)
        doSendMagicEffect(KASHMIR_LAST_TILE_POSITION,12)
	doCreatureSay(cid, "Voc� sente algo muito ruim...", TALKTYPE_MONSTER_YELL, false, cid)
        end
    
    return TRUE
end  