local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_HEALING)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, FALSE)
setCombatParam(combat, COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)

function onGetFormulaValues(cid, level, maglevel)
	local min = ((level*0.2)+(maglevel*3.184)+20)
	local max = ((level*0.2)+(maglevel*5.59)+35)
	return min, max
end

setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")


function onCastSpell(cid, var)

	local manaCost = 70
	
	if(doPlayerIsInBattleground(cid)) then
		manaCost = math.floor(getCreatureMaxMana(cid) * 0.10)
	end
	
    if(getCreatureMana(cid) < manaCost) then
            doPlayerSendDefaultCancel(cid, RETURNVALUE_NOTENOUGHMANA)
            doSendMagicEffect(getCreaturePosition(cid), CONST_ME_POFF)
            return false
    end
    
    doCreatureAddMana(cid, -manaCost, false)
    doPlayerAddSpentMana(cid, manaCost)

	return doCombat(cid, combat, var)
end
