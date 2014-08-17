local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_EXPLOSIONAREA)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_EXPLOSION)

function onGetFormulaValues(cid, level, maglevel)
	local min = ((level/5))
	local max = ((level/5)+(maglevel*4.8))
	return -min, -max
end

setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local area = createCombatArea(AREA_CROSS1X1)
setCombatArea(combat, area)

function onCastSpell(cid, var)
	if(doPlayerIsInBattleground(cid) and isDruid(cid)) then
		local manaCost = math.floor(getCreatureMaxMana(cid) * 0.02) -- 2% base mana para Druids em Battleground...
	
		doCreatureAddMana(cid, -manaCost, false)
		doPlayerAddSpentMana(cid, manaCost)
	end

	return doCombat(cid, combat, var)
end
