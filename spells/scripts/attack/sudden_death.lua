local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SUDDENDEATH)
setCombatParam(combat, COMBAT_PARAM_TARGETCASTERORTOPMOST, TRUE)

function onGetFormulaValues(cid, level, maglevel)
	local min = ( (level * 0.2) + (maglevel * 4.605) + 28 )
	local max = ( (level * 0.2) + (maglevel * 7.395) + 46 )
	
	local baseMin = min
	local baseMax = max
	
	local head = getPlayerSlotItem(cid, CONST_SLOT_HEAD)
	local armor = getPlayerSlotItem(cid, CONST_SLOT_ARMOR)
	local legs = getPlayerSlotItem(cid, CONST_SLOT_LEGS)
	local boots = getPlayerSlotItem(cid, CONST_SLOT_FEET)
	
	
	local HELMET_BONUS = {
		[10559] = 10 -- deathface helmet	
	}
	
	local ARMOR_BONUS = {
		[10560] = 15 -- deathface armor
	}
	
	local LEGS_BONUS = {
		[10561] = 5 -- deathface legs
	}
	
	local BOOTS_BONUS = {
		[10562] = 5 -- deathface boots
	}	
	
	local hasPartOfSet = false
	
	if(head ~= FALSE and HELMET_BONUS[head.itemid] ~= nil) then
		min = min + ((baseMin * (1 + (HELMET_BONUS[head.itemid] / 100))) - baseMin)
		max = max + ((baseMax * (1 + (HELMET_BONUS[head.itemid] / 100))) - baseMax)
		hasPartOfSet = true
	end
	
	if(armor ~= FALSE and ARMOR_BONUS[armor.itemid] ~= nil) then
		min = min + ((baseMin * (1 + (ARMOR_BONUS[armor.itemid] / 100))) - baseMin)
		max = max + ((baseMax * (1 + (ARMOR_BONUS[armor.itemid] / 100))) - baseMax)
		hasPartOfSet = true
	end
	
	if(legs ~= FALSE and LEGS_BONUS[legs.itemid] ~= nil) then
		min = min + ((baseMin * (1 + (LEGS_BONUS[legs.itemid] / 100))) - baseMin)
		max = max + ((baseMax * (1 + (LEGS_BONUS[legs.itemid] / 100))) - baseMax)	
		hasPartOfSet = true
	end
	
	if(boots ~= FALSE and BOOTS_BONUS[boots.itemid] ~= nil) then
		min = min + ((baseMin * (1 + (BOOTS_BONUS[boots.itemid] / 100))) - baseMin)
		max = max + ((baseMax * (1 + (BOOTS_BONUS[boots.itemid] / 100))) - baseMax)	
		hasPartOfSet = true
	end	
	
	-- Removemos o manashield
	if(hasPartOfSet) then
		doRemoveCondition(cid, CONDITION_MANASHIELD)
	end
		
	return -min, -max
end

setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(cid, var)

	if(doPlayerIsInBattleground(cid) and isDruid(cid)) then
		local manaCost = math.floor(getCreatureMaxMana(cid) * 0.04) -- 4% base mana para Druids em Battleground...
	
		doCreatureAddMana(cid, -manaCost, false)
		doPlayerAddSpentMana(cid, manaCost)
	end

	return doCombat(cid, combat, var)
end
