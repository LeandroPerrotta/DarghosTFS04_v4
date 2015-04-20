-- ----------- --
-- TRADE LISTS --
-- ----------- --

trade_lists = {

	["jewerly"] = {
		{ name = "black pearl", sell_for = 560, buy_for = 420 },
		{ name = "small amethyst", sell_for = 400, buy_for = 270 },
		{ name = "small diamond", sell_for = 600, buy_for = 100 },
		{ name = "small sapphire", sell_for = 500, buy_for = 375 },
		{ name = "white pearl", sell_for = 320, buy_for = 300 },
		{ name = "small ruby", sell_for = 500, buy_for = 352 },
		{ name = "small emerald", sell_for = 500, buy_for = 352 },
		{ name = "golden amulet", sell_for = 6600 },
		{ name = "ruby necklace", sell_for = 3560 },
		{ name = "wedding ring", sell_for = 990 },
		{ name = "bronze goblet", sell_for = 2000 },
		{ name = "golden goblet", sell_for = 5000 },
		{ name = "silver goblet", sell_for = 3000 }
	},
	
	["runes"] = {
		{ name = "animate dead rune", sell_for = 375 },
		{ name = "blank rune", sell_for = 10 },
		{ name = "desintegrate rune", sell_for = 26 },
		{ name = "energy bomb rune", sell_for = 162 },
		{ name = "fireball rune", sell_for = 30 },
		{ name = "holy missile rune", sell_for = 16 },
		{ name = "icicle rune", sell_for = 30 },
		{ name = "magic wall rune", sell_for = 116 },
		{ name = "paralyze rune", sell_for = 700 },
		{ name = "poison bomb rune", sell_for = 85 },
		{ name = "soulfire rune", sell_for = 46 },
		{ name = "stone shower rune", sell_for = 37 },
		{ name = "thunderstorm rune", sell_for = 37 },
		{ name = "wild growth rune", sell_for = 37 },
		
		{ name = "avalanche rune", sell_for = 45 },
		{ name = "antidote rune", sell_for = 65 },
		{ name = "chameleon rune", sell_for = 210 },
		{ name = "convince creature rune", sell_for = 80 },
		{ name = "destroy field rune", sell_for = 15 },
		{ name = "energy field rune", sell_for = 38 },
		{ name = "energy wall rune", sell_for = 85 },
		{ name = "explosion rune", sell_for = 31 },
		{ name = "firebomb rune", sell_for = 28 },
		{ name = "fire field rune", sell_for = 28 },
		{ name = "fire wall rune", sell_for = 61 },
		{ name = "great fireball rune", sell_for = 45 },
		{ name = "heavy magic missile rune", sell_for = 12 },
		{ name = "intense healing rune", sell_for = 95 },
		{ name = "light magic missile rune", sell_for = 4 },
		{ name = "poison field rune", sell_for = 21 },
		{ name = "poison wall rune", sell_for = 52 },
		{ name = "stalagmite rune", sell_for = 12 },
		{ name = "sudden death rune", sell_for = 108 },
		{ name = "ultimate healing rune", sell_for = 175 }
	},
	
	["potions"] = {
		{ name = "small health potion", sell_for = 20 },
		{ name = "health potion", sell_for = 45 },
		{ name = "strong health potion", sell_for = 100 },
		{ name = "great health potion", sell_for = 190 },
		{ name = "ultimate health potion", sell_for = 310 },
		
		{ name = "mana potion", sell_for = 50 },
		{ name = "strong mana potion", sell_for = 80 },
		{ name = "great mana potion", sell_for = 120 },
		
		{ name = "great spirit potion", sell_for = 190 },
		
		{ name = "antidote potion", sell_for = 30 },
		
		{ name = "empty potion flask (small)", itemtype = 7636, buy_for = 5 },	
		{ name = "empty potion flask (medium)", itemtype = 7634, buy_for = 7 },	
		{ name = "empty potion flask (large)", itemtype = 7635, buy_for = 10 },
	},
	
	["wands"] = {
		{ name = "wand of vortex", sell_for = 500 },
		{ name = "wand of dragonbreath", sell_for = 1000 },
		{ name = "wand of decay", sell_for = 5000 },
		{ name = "wand of draconia", sell_for = 7500 },
		{ name = "wand of cosmic energy", sell_for = 10000 },
		{ name = "wand of inferno", sell_for = 15000 },
		{ name = "wand of starstorm", sell_for = 18000 },
		{ name = "wand of voodoo", sell_for = 22000 },
	},
	
	["rods"] = {
		{ name = "snakebite rod", sell_for = 500 },
		{ name = "moonlight rod", sell_for = 1000 },
		{ name = "necrotic rod", sell_for = 5000 },
		{ name = "northwind rod", sell_for = 7500 },
		{ name = "terra rod", sell_for = 10000 },
		{ name = "hailstorm rod", sell_for = 15000 },
		{ name = "springsprout rod", sell_for = 18000 },
		{ name = "underworld rod", sell_for = 22000 },
	},
	
	["magic_misc"] = {
		{ name = "spellbook", itemtype = 2175, sell_for = 150 },
	},
	
	["armors"] = {
		{ name = "chain armor", sell_for = 200, buy_for = 105 },
		{ name = "brass armor", sell_for = 450, buy_for = 225 },
		{ name = "scale armor", sell_for = 260, buy_for = 112 },
		{ name = "plate armor", sell_for = 1200, buy_for = 600 },
		{ name = "dark armor", sell_for = 1200, buy_for = 600 },
		{ name = "spirit cloak", sell_for = 1000, buy_for = 350 },
		{ name = "belted cape", sell_for = 1300, buy_for = 500 },
		
		{ name = "magician's robe", sell_for = 450 },
		{ name = "knight armor", buy_for = 1125 },
		{ name = "golden armor", buy_for = 2250 },
	},
	
	["equipments_premium"] = {
		{ name = "focus cape", buy_for = 6000 },
		{ name = "batwing hat", buy_for = 8000 },
		{ name = "jade hat", buy_for = 9000 },

		{ name = "draken boots", buy_for = 40000 },
		{ name = "drakinata", buy_for = 10000 },
		{ name = "elite draken mail", buy_for = 50000 },
		{ name = "guardian boots", buy_for = 35000 },
		{ name = "twiceslicer", buy_for = 28000 },
		{ name = "wailing widow necklace", buy_for = 3000 },
		{ name = "zaoan armor", buy_for = 14000 },
		{ name = "zaoan halberd", buy_for = 500 },
		{ name = "zaoan helmet", buy_for = 45000 },
		{ name = "zaoan legs", buy_for = 14000 },
		{ name = "zaoan shoes", buy_for = 5000 },
		{ name = "zaoan sword", buy_for = 30000 },
	},
	
	["helmets"] = {
		{ name = "chain helmet", sell_for = 52, buy_for = 25 },
		{ name = "brass helmet", sell_for = 120, buy_for = 45 },
		{ name = "viking helmet", sell_for = 265, buy_for = 99 },
		{ name = "soldier helmet", sell_for = 200, buy_for = 30 },
		{ name = "iron helmet", sell_for = 390, buy_for = 225 },
		{ name = "steel helmet", sell_for = 580, buy_for = 285 },
		{ name = "legion helmet", buy_for = 45 },
		{ name = "warrior helmet", buy_for = 1044 },
	},
	
	["legs"] = {
		{ name = "studded legs", sell_for = 60, buy_for = 22 },
		{ name = "chain legs", sell_for = 80, buy_for = 37 },
		{ name = "brass legs", sell_for = 195, buy_for = 73 },
		{ name = "plate legs", buy_for = 57 },
		{ name = "knight legs", buy_for = 562 },
	},
	
	["shields"] = {
		{ name = "wooden shield", sell_for = 15, buy_for = 7 },
		{ name = "studded shield", sell_for = 50, buy_for = 24 },
		{ name = "brass shield", sell_for = 65, buy_for = 37 },
		{ name = "plate shield", sell_for = 125, buy_for = 67 },
		{ name = "steel shield", sell_for = 240, buy_for = 120 },
		{ name = "viking shield", sell_for = 260, buy_for = 127 },
		{ name = "dwarven shield", sell_for = 500, buy_for = 150 },
		{ name = "copper shield", buy_for = 75 },
		{ name = "sentinel shield", buy_for = 180 },
		{ name = "battle shield", buy_for = 142 },
		{ name = "salamander shield", buy_for = 420 },
		{ name = "tusk shield", buy_for = 1275 },
		{ name = "guardian shield", buy_for = 270 },
		{ name = "dragon shield", buy_for = 547 },
		{ name = "mastermind shield", buy_for = 825 },
	},
	
	["boots"] = {
		{ name = "leather boots", sell_for = 10, buy_for = 3 },
		{ name = "crocodile boots", buy_for = 150 },
	},
	
	["weapons_premium"] = {
		
	},
	
	["swords"] = {
		{ name = "rapier", sell_for = 15, buy_for = 7 },
		{ name = "sabre", sell_for = 35, buy_for = 18 },
		{ name = "machete", sell_for = 35, buy_for = 15 },
		{ name = "sword", itemtype = 2376, sell_for = 85, buy_for = 37 },
		{ name = "carlin sword", sell_for = 473, buy_for = 177 },
		{ name = "longsword", sell_for = 160, buy_for = 76 },
		{ name = "two handed sword", itemtype = 2377, sell_for = 950, buy_for = 675 },
		{ name = "crimson sword", sell_for = 610 },
		{ name = "short sword", buy_for = 15 },
		{ name = "katana", buy_for = 37 },
		{ name = "templar scytheblade", buy_for = 300 },
		{ name = "spike sword", buy_for = 360 },
		{ name = "fire sword", buy_for = 1500 },
		{ name = "broadsword", buy_for = 270 },
	},
	
	["axes"] = {
		{ name = "hand axe", sell_for = 8, buy_for = 6 },
		{ name = "axe", itemtype = 2386, sell_for = 20, buy_for = 10 },
		{ name = "hatchet", sell_for = 85, buy_for = 37 },
		{ name = "battle axe", sell_for = 235, buy_for = 80 },
		{ name = "barbarian axe", sell_for = 590, buy_for = 277 },
		{ name = "steel axe", sell_for = 500 },
		{ name = "orcish axe", buy_for = 82 },
		{ name = "fire axe", buy_for = 420 },
		{ name = "ripper lance", buy_for = 750 },
		{ name = "halberd", buy_for = 400 },
		{ name = "double axe", buy_for = 390 },
		{ name = "dragon lance", buy_for = 990 },
	},
	
	["clubs"] = {
		{ name = "mace", sell_for = 90, buy_for = 30 },
		{ name = "battle hammer", sell_for = 350, buy_for = 180 },
		{ name = "morning star", sell_for = 430, buy_for = 150 },
		{ name = "clerical mace", sell_for = 540, buy_for = 225 },
		{ name = "bone club", buy_for = 7 },
		{ name = "daramanian mace", buy_for = 97 },
		{ name = "banana staff", buy_for = 1500 },
		{ name = "war hammer", buy_for = 705 },
		{ name = "thunder hammer", buy_for = 1498 },
	},
	
	["ranged"] = {
		{ name = "crossbow", sell_for = 500, buy_for = 240 },
		{ name = "bow", sell_for = 400, buy_for = 195 },
		{ name = "spear", sell_for = 10, buy_for = 4 },
		{ name = "throwing knife", sell_for = 25 },
		{ name = "throwing star", sell_for = 42 },
		{ name = "royal spear", sell_for = 15 },
		{ name = "enchanted spear", sell_for = 50 },
		{ name = "hunting spear", buy_for = 37 },
	},
	
	["ammunition"] = {
		{ name = "arrow", sell_for = 3 },
		{ name = "earth arrow", sell_for = 5 },
		{ name = "flaming arrow", sell_for = 5 },
		{ name = "flash arrow", sell_for = 5 },
		{ name = "onyx arrow", sell_for = 7 },
		{ name = "shiver arrow", sell_for = 5 },
		{ name = "sniper arrow", sell_for = 5 },
		
		{ name = "bolt", sell_for = 4 },
		{ name = "piercing bolt", sell_for = 5 },
		{ name = "power bolt", sell_for = 7 },
	},
	
	["ammunition_special1"] = {
		{ name = "assassin star", sell_for = 100 },
	},
	
	["containers_free"] = {
		{ name = "brown backpack", itemtype = 1988, sell_for = 20 },	
		{ name = "green backpack", sell_for = 20 },	
		{ name = "grey backpack", sell_for = 20 },	
		{ name = "purple backpack", sell_for = 20 },	
		{ name = "red backpack", sell_for = 20 },	
		{ name = "blue backpack", sell_for = 20 },	
		{ name = "golden backpack", sell_for = 20 },	
		{ name = "yellow backpack", sell_for = 20 },
		
		{ name = "brown bag", itemtype = 1987, sell_for = 5 },	
		{ name = "green bag", sell_for = 5 },	
		{ name = "grey bag", sell_for = 5 },	
		{ name = "purple bag", sell_for = 5 },	
		{ name = "red bag", sell_for = 5 },		
		{ name = "blue bag", sell_for = 5 },	
		{ name = "golden bag", sell_for = 5 },	
		{ name = "yellow bag", sell_for = 5 },		
	},
	
	["containers_premium"] = {
		{ name = "beach backpack", sell_for = 20 },	
		{ name = "brocade backpack", sell_for = 20 },	
		{ name = "camouflage backpack", sell_for = 20 },	
		{ name = "fur backpack", sell_for = 20 },	
		{ name = "pirate backpack", sell_for = 20 },		
		
		{ name = "beach bag", sell_for = 5 },	
		{ name = "brocade bag", sell_for = 5 },	
		{ name = "camouflage bag", sell_for = 5 },	
		{ name = "fur bag", sell_for = 5 },	
		{ name = "pirate bag", sell_for = 5 },				
	},
	
	["tools"] = {
		{ name = "fishing rod", sell_for = 150, buy_for = 60 },	
		{ name = "pick", sell_for = 50, buy_for = 15 },				
		{ name = "rope", sell_for = 50, buy_for = 15 },				
		{ name = "scythe", sell_for = 50, buy_for = 10 },				
		{ name = "shovel", sell_for = 50, buy_for = 8 },				
		{ name = "worm", sell_for = 1 },				
		{ name = "torch", sell_for = 2 },				
		{ name = "magic lightwand", itemtype = 2162, sell_for = 120, buy_for = 35 },				
	},	
	
	["foods"] = {
		{ name = "brown mushroom", sell_for = 10 },
		{ name = "white mushroom", sell_for = 6 },
		{ name = "egg", sell_for = 2 },			
		{ name = "cookie", sell_for = 2 },			
		{ name = "orange", sell_for = 5 },			
		{ name = "strawberry", sell_for = 2 },			
		{ name = "red mushroom", sell_for = 12 },			
		{ name = "tomato", sell_for = 3 },			
		{ name = "potato", sell_for = 4 },			
		{ name = "raspberry", sell_for = 1 },			
		{ name = "lemon", sell_for = 3 },			
		{ name = "cherry", sell_for = 1 },			
		{ name = "blueberry", sell_for = 1 },			
		{ name = "banana", sell_for = 2 },			
		{ name = "red apple", sell_for = 3 },			
		{ name = "plum", sell_for = 3 },			
		{ name = "beetroot", sell_for = 2 },			
		{ name = "pear", sell_for = 4 },			
		{ name = "onion", sell_for = 2 },			
		{ name = "grapes", sell_for = 5 },			
		{ name = "cucumber", sell_for = 3 },			
		{ name = "jalapeno pepper", sell_for = 2 },			
		{ name = "salmon", sell_for = 6 },			
		{ name = "carrot", sell_for = 2 },			
		{ name = "roll", sell_for = 2 },			
		{ name = "corncob", sell_for = 3 },			
		{ name = "valentine's cake", itemtype = 6393, sell_for = 100 },			
		{ name = "fish", itemtype = 2667, sell_for = 5 },			
		{ name = "mango", sell_for = 10 },			
		{ name = "melon", sell_for = 8 },			
		{ name = "dragon ham", sell_for = 25 },			
		{ name = "brown bread", sell_for = 3 },			
		{ name = "bread", sell_for = 3 },			
		{ name = "ham", sell_for = 8 },			
		{ name = "meat", sell_for = 3 },			
		{ name = "pumpkin", sell_for = 10 },			
	},	
	
	["thaun_aol"] = {
		{ name = "amulet of loss", sell_for = 50000 },		
	},
	
	["djinn_alessar"] = {
		{ name = "ancient shield", buy_for = 900 },
		{ name = "black shield", buy_for = 800 },
		{ name = "bonebreaker", buy_for = 10000 },
		{ name = "dragon hammer", buy_for = 2000 },
		{ name = "dreaded cleaver", buy_for = 15000 },
		{ name = "giant sword", buy_for = 17000 },
		{ name = "haunted blade", buy_for = 8000 },
		{ name = "mystic turban", buy_for = 150 },
		{ name = "onyx flail", buy_for = 22000 },
		{ name = "ornamented axe", buy_for = 20000 },
		{ name = "poison dagger", buy_for = 50 },
		{ name = "scimitar", buy_for = 150 },
		{ name = "strange helmet", buy_for = 500 },
		{ name = "titan axe", buy_for = 4000 },
		{ name = "knight axe", buy_for = 2000 },
		{ name = "serpent sword", buy_for = 900 },
		{ name = "skull staff", buy_for = 6000 },
		{ name = "knight armor", buy_for = 5000 },
		{ name = "warrior helmet", buy_for = 5000 },
		{ name = "knight legs", buy_for = 5000 },
		{ name = "tower shield", buy_for = 8000 },
		{ name = "vampire shield", buy_for = 15000 },
	},
	
	["djinn_yaman"] = {
		{ name = "hailstorm rod", buy_for = 3000 },
		{ name = "moonlight rod", buy_for = 200 },
		{ name = "necrotic rod", buy_for = 1000 },
		{ name = "northwind rod", buy_for = 1500 },
		{ name = "snakebite rod", buy_for = 100 },
		{ name = "springsprout rod", buy_for = 3600 },
		{ name = "terra rod", buy_for = 2000 },
		{ name = "underworld rod", buy_for = 4400 },
		
		{ name = "dwarven ring", itemtype = 2213, sell_for = 2000 },
		{ name = "energy ring", itemtype = 2167, sell_for = 2000 },
		{ name = "life ring", itemtype = 2168, sell_for = 900 },
		{ name = "might ring", itemtype = 2164, subtype = 20, sell_for = 7500 },
		{ name = "ring of healing", itemtype = 2214, sell_for = 3500 },
		{ name = "time ring", itemtype = 2169, sell_for = 2000 },
	},
	
	["djinn_nah"] = {
		{ name = "beholder shield", sell_for = 7000, buy_for = 1200 },
		{ name = "noble armor", sell_for = 8000, buy_for = 900 },
		{ name = "spike sword", sell_for = 7000, buy_for = 1000 },
		{ name = "war hammer", sell_for = 10000, buy_for = 1200 },
		
		{ name = "crown shield", buy_for = 8000 },
		{ name = "broadsword", buy_for = 500 },
		{ name = "butcher's axe", buy_for = 18000 },
		{ name = "angelic axe", buy_for = 5000 },
		{ name = "dragon shield", buy_for = 4000 },
		{ name = "guardian shield", buy_for = 2000 },
		{ name = "phoenix shield", buy_for = 16000 },
		{ name = "queen's sceptre", buy_for = 20000 },
		{ name = "blue robe", buy_for = 10000 },
		{ name = "crown armor", buy_for = 12000 },
		{ name = "boots of haste", buy_for = 30000 },
		{ name = "dragon lance", buy_for = 9000 },
		{ name = "fire axe", buy_for = 8000 },
		{ name = "shadow sceptre", buy_for = 10000 },
		{ name = "thaian sword", buy_for = 16000 },
		{ name = "fire sword", buy_for = 4000 },
		{ name = "glorious axe", buy_for = 3000 },
		{ name = "ice rapier", buy_for = 1000 },
		{ name = "obsidian lance", buy_for = 500 },
		{ name = "crown helmet", buy_for = 2500 },
		{ name = "crusader helmet", buy_for = 13500 },
		{ name = "royal helmet", buy_for = 30000 },
		{ name = "crown legs", buy_for = 12000 },
	},
	
	["djinn_haroun"] = {
		{ name = "wand of cosmic energy", buy_for = 3000 },	
		{ name = "wand of decay", buy_for = 1500 },	
		{ name = "wand of draconia", buy_for = 2250 },	
		{ name = "wand of dragonbreath", buy_for = 300 },	
		{ name = "wand of inferno", buy_for = 4500 },	
		{ name = "wand of starstorm", buy_for = 5400 },	
		{ name = "wand of voodoo", buy_for = 6600 },	
		{ name = "wand of vortex", buy_for = 150 },		
		
		{ name = "axe ring", itemtype = 2208, sell_for = 500 },	
		{ name = "club ring", itemtype = 2209, sell_for = 500 },	
		{ name = "sword ring", itemtype = 2207, sell_for = 500 },	
		{ name = "stealth ring", itemtype = 2165, sell_for = 5000 },	
		{ name = "power ring", itemtype = 2166, sell_for = 100 },
		
		{ name = "stone skin amulet", sell_for = 7500 },
	},
	
	["rashid"] = {	
		{ name = "dragon scale mail", buy_for = 40000 },	
		{ name = "glacier robe", buy_for = 11000 },	
		{ name = "golden armor", buy_for = 20000 },	
		{ name = "lightning robe", buy_for = 16500 },	
		{ name = "magma coat", buy_for = 11000 },	
		{ name = "paladin armor", buy_for = 15000 },	
		{ name = "skullcracker armor", buy_for = 18000 },	
		{ name = "terra mantle", buy_for = 11000 },	
		{ name = "glacier kilt", buy_for = 11000 },	
		{ name = "lightning legs", buy_for = 16500 },	
		{ name = "magma legs", buy_for = 11000 },	
		{ name = "terra legs", buy_for = 11000 },	
		{ name = "demon shield", buy_for = 30000 },	
		{ name = "medusa shield", buy_for = 9000 },	
		{ name = "spellbook of enlightenment", buy_for = 6000 },	
		{ name = "glacier mask", buy_for = 2500 },	
		{ name = "lightning headband", buy_for = 2500 },	
		{ name = "magma monocle", buy_for = 2500 },	
		{ name = "skull helmet", buy_for = 40000 },	
		{ name = "fur boots", buy_for = 3000 },	
		{ name = "glacier shoes", buy_for = 2500 },	
		{ name = "lightning boots", buy_for = 2500 },	
		{ name = "magma boots", buy_for = 2500 },	
		{ name = "steel boots", buy_for = 30000 },	
		{ name = "terra boots", buy_for = 2500 },	
		{ name = "amber staff", buy_for = 8000 },	
		{ name = "chaos mace", buy_for = 18000 },	
		{ name = "demonrage sword", buy_for = 36000 },	
		{ name = "dragon slayer", itemtype = 7402, buy_for = 15000 },	
		{ name = "guardian halberd", buy_for = 11000 },	
		{ name = "wyvern fang", buy_for = 1500 },	
		{ name = "ring of the sky", buy_for = 30000 },	
		{ name = "relic sword", itemtype = 7383, buy_for = 25000 },	
		{ name = "dragonbone staff", buy_for = 3000 },	
		{ name = "crocodile boots", buy_for = 1000 },	
		{ name = "daramanian waraxe", buy_for = 1000 },	
		{ name = "devil helmet", buy_for = 1000 },	
		{ name = "flower dress", buy_for = 1000 },	
		{ name = "furry club", buy_for = 1000 },	
		{ name = "leopard armor", buy_for = 1000 },	
		{ name = "pirate hat", buy_for = 1000 },	
		{ name = "beastslayer axe", buy_for = 1500 },	
		{ name = "brutetamer's staff", buy_for = 1500 },	
		{ name = "glacier amulet", buy_for = 1500 },	
		{ name = "lightning pendant", buy_for = 1500 },	
		{ name = "magma amulet", buy_for = 1500 },	
		{ name = "norse shield", buy_for = 1500 },	
		{ name = "noble axe", buy_for = 10000 },	
		{ name = "dreaded cleaver", buy_for = 10000 },	
		{ name = "crystal mace", buy_for = 12000 },	
		{ name = "earth war axe", itemtype = 7863, buy_for = 12000 },	
		{ name = "energy war axe", itemtype = 7878, buy_for = 12000 },	
		{ name = "fiery war axe", itemtype = 7753, buy_for = 12000 },	
		{ name = "icy war axe", itemtype = 7772, buy_for = 12000 },	
		{ name = "war axe", itemtype = 2454, buy_for = 12000 },	
		{ name = "mercenary sword", buy_for = 12000 },	
		{ name = "djinn blade", buy_for = 15000 },	
		{ name = "earth dragon slayer", itemtype= 7858, buy_for = 15000 },	
		{ name = "energy dragon slayer", itemtype= 7873, buy_for = 15000 },	
		{ name = "fiery dragon slayer", itemtype= 7748, buy_for = 15000 },	
		{ name = "icy dragon slayer", itemtype= 7767, buy_for = 15000 },	
		{ name = "fiery dragon slayer", itemtype= 7858, buy_for = 15000 },	
		{ name = "crystalline armor", buy_for = 16000 },	
		{ name = "lavos armor", buy_for = 16000 },	
		{ name = "swamplair armor", buy_for = 16000 },	
		{ name = "fur boots", buy_for = 2000 },	
		{ name = "naginata", buy_for = 2000 },	
		{ name = "patched boots", buy_for = 2000 },	
		{ name = "ruby necklace", buy_for = 2000 },	
		{ name = "scarab shield", buy_for = 2000 },	
		{ name = "platinum amulet", buy_for = 2500 },	
		{ name = "terra hood", buy_for = 2500 },	
		{ name = "abyss hammer", buy_for = 20000 },	
		{ name = "assassin dagger", buy_for = 20000 },	
		{ name = "pharaoh sword", buy_for = 23000 },	
		{ name = "composite hornbow", buy_for = 25000 },	
		{ name = "earth relic sword", itemtype = 7855, buy_for = 25000 },	
		{ name = "energy relic sword", itemtype = 7870, buy_for = 25000 },	
		{ name = "fiery relic sword", itemtype = 7745, buy_for = 25000 },	
		{ name = "icy relic sword", itemtype = 7764, buy_for = 25000 },	
		{ name = "jade hammer", buy_for = 25000 },	
		{ name = "diamond sceptre", buy_for = 3000 },	
		{ name = "hibiscus dress", buy_for = 3000 },	
		{ name = "pirate boots", buy_for = 3000 },	
		{ name = "sacred tree amulet", buy_for = 3000 },	
		{ name = "shockwave amulet", buy_for = 3000 },	
		{ name = "cranial basher", itemtype = 7415, buy_for = 30000 },	
		{ name = "dwarven armor", buy_for = 30000 },	
		{ name = "earth cranial basher", itemtype = 7866, buy_for = 30000 },	
		{ name = "energy cranial basher", itemtype = 7881, buy_for = 30000 },	
		{ name = "fiery cranial basher", itemtype = 7756, buy_for = 30000 },	
		{ name = "icy cranial basher", itemtype = 7775, buy_for = 30000 },	
		{ name = "heroic axe", itemtype = 7389, buy_for = 30000 },	
		{ name = "earth heroic axe", itemtype = 7861, buy_for = 30000 },	
		{ name = "energy heroic axe", itemtype = 7876, buy_for = 30000 },	
		{ name = "fiery heroic axe", itemtype = 7751, buy_for = 30000 },	
		{ name = "icy heroic axe", itemtype = 7770, buy_for = 30000 },	
		{ name = "mystic blade", itemtype = 7384, buy_for = 30000 },	
		{ name = "earth mystic blade", itemtype = 7856, buy_for = 30000 },	
		{ name = "energy mystic blade", itemtype = 7871, buy_for = 30000 },	
		{ name = "fiery mystic blade", itemtype = 7746, buy_for = 30000 },	
		{ name = "icy mystic blade", itemtype = 7765, buy_for = 30000 },	
		{ name = "golden legs", buy_for = 30000 },	
		{ name = "hammer of wrath", buy_for = 30000 },	
		{ name = "vile axe", buy_for = 30000 },	
		{ name = "demonbone amulet", buy_for = 32000 },	
		{ name = "nightmare blade", buy_for = 35000 },	
		{ name = "tempest shield", buy_for = 35000 },	
		{ name = "berserker", buy_for = 40000 },	
		{ name = "chain bolter", buy_for = 40000 },	
		{ name = "ruthless axe", buy_for = 45000 },	
		{ name = "castle shield", buy_for = 5000 },	
		{ name = "lunar staff", buy_for = 5000 },	
		{ name = "spiked squelcher", buy_for = 5000 },		
		{ name = "heavy mace", buy_for = 50000 },	
		{ name = "mastermind shield", buy_for = 50000 },
		{ name = "mammoth fur cape", buy_for = 6000 },
		{ name = "sapphire hammer", buy_for = 7000 },
		{ name = "beholder helmet", buy_for = 7500 },
		{ name = "amber staff", buy_for = 8000 },
		{ name = "epee", buy_for = 8000 },
		{ name = "gold ring", buy_for = 8000 },
		{ name = "chaos mace", buy_for = 9000 },
		{ name = "magic plate armor", buy_for = 90000 },
		
		{ name = "death ring", itemtype = 6300, buy_for = 1000 },

		{ name = "ancient shield", buy_for = 900 },
		{ name = "black shield", buy_for = 800 },
		{ name = "bonebreaker", buy_for = 10000 },
		{ name = "dragon hammer", buy_for = 2000 },
		{ name = "dreaded cleaver", buy_for = 15000 },
		{ name = "giant sword", buy_for = 17000 },
		{ name = "haunted blade", buy_for = 8000 },
		{ name = "mystic turban", buy_for = 150 },
		{ name = "onyx flail", buy_for = 22000 },
		{ name = "ornamented axe", buy_for = 20000 },
		{ name = "poison dagger", buy_for = 50 },
		{ name = "scimitar", buy_for = 150 },
		{ name = "strange helmet", buy_for = 500 },
		{ name = "titan axe", buy_for = 4000 },
		{ name = "knight axe", buy_for = 2000 },
		{ name = "serpent sword", buy_for = 900 },
		{ name = "skull staff", buy_for = 6000 },
		{ name = "knight armor", buy_for = 5000 },
		{ name = "warrior helmet", buy_for = 5000 },
		{ name = "knight legs", buy_for = 5000 },
		{ name = "tower shield", buy_for = 8000 },
		{ name = "vampire shield", buy_for = 15000 },

		{ name = "hailstorm rod", buy_for = 3000 },
		{ name = "moonlight rod", buy_for = 200 },
		{ name = "necrotic rod", buy_for = 1000 },
		{ name = "northwind rod", buy_for = 1500 },
		{ name = "snakebite rod", buy_for = 100 },
		{ name = "springsprout rod", buy_for = 3600 },
		{ name = "terra rod", buy_for = 2000 },
		{ name = "underworld rod", buy_for = 4400 },

		{ name = "beholder shield", sell_for = 7000, buy_for = 1200 },
		{ name = "noble armor", sell_for = 8000, buy_for = 900 },
		{ name = "spike sword", sell_for = 7000, buy_for = 1000 },
		{ name = "war hammer", sell_for = 10000, buy_for = 1200 },
		
		{ name = "crown shield", buy_for = 8000 },
		{ name = "broadsword", buy_for = 500 },
		{ name = "butcher's axe", buy_for = 18000 },
		{ name = "angelic axe", buy_for = 5000 },
		{ name = "dragon shield", buy_for = 4000 },
		{ name = "guardian shield", buy_for = 2000 },
		{ name = "phoenix shield", buy_for = 16000 },
		{ name = "queen's sceptre", buy_for = 20000 },
		{ name = "blue robe", buy_for = 10000 },
		{ name = "crown armor", buy_for = 12000 },
		{ name = "boots of haste", buy_for = 30000 },
		{ name = "dragon lance", buy_for = 9000 },
		{ name = "fire axe", buy_for = 8000 },
		{ name = "shadow sceptre", buy_for = 10000 },
		{ name = "thaian sword", buy_for = 16000 },
		{ name = "fire sword", buy_for = 4000 },
		{ name = "glorious axe", buy_for = 3000 },
		{ name = "ice rapier", buy_for = 1000 },
		{ name = "obsidian lance", buy_for = 500 },
		{ name = "crown helmet", buy_for = 2500 },
		{ name = "crusader helmet", buy_for = 13500 },
		{ name = "royal helmet", buy_for = 30000 },
		{ name = "crown legs", buy_for = 12000 },

		{ name = "wand of cosmic energy", buy_for = 3000 },	
		{ name = "wand of decay", buy_for = 1500 },	
		{ name = "wand of draconia", buy_for = 2250 },	
		{ name = "wand of dragonbreath", buy_for = 300 },	
		{ name = "wand of inferno", buy_for = 4500 },	
		{ name = "wand of starstorm", buy_for = 5400 },	
		{ name = "wand of voodoo", buy_for = 6600 },	
		{ name = "wand of vortex", buy_for = 150 },		
		
		{ name = "axe ring", itemtype = 2208, sell_for = 500 },	
		{ name = "club ring", itemtype = 2209, sell_for = 500 },	
		{ name = "sword ring", itemtype = 2207, sell_for = 500 },	
		{ name = "stealth ring", itemtype = 2165, sell_for = 5000 },	
		{ name = "power ring", itemtype = 2166, sell_for = 100 },
		
		{ name = "stone skin amulet", sell_for = 7500 },									
	},
	
	["beds"] = {
		{ name = "bed kit (green)", itemtype = 7905, sell_for = 80 },	
		{ name = "bed kit (red)", itemtype = 7906, sell_for = 80 },	
		{ name = "bed kit (blue)", itemtype = 7904, sell_for = 80 },	
		{ name = "bed kit (yellow)", itemtype = 7907, sell_for = 80 },	
	},
	
	["tables"] = {
		{ name = "trophy stand", itemtype= 7936, sell_for = 50 },
		{ name = "table kit (small)", itemtype= 3908, sell_for = 20 },
		{ name = "table kit (round)", itemtype= 3909, sell_for = 25 },
		{ name = "table kit (square)", itemtype= 3910, sell_for = 25 },
		{ name = "table kit (big)", itemtype= 3911, sell_for = 35 },
	},
	
	["vases"] = {
		{ name = "amphora", sell_for = 4 },
		{ name = "vase", itemtype= 2008, sell_for = 3 },
	},
	
	["boxes"] = {
		{ name = "box kit (drawer)", itemtype = 3915, sell_for = 18 },
		{ name = "box kit (dresser)", itemtype = 3916, sell_for = 25 },
		{ name = "box kit (locker)", itemtype = 3917, sell_for = 30 },
		{ name = "box kit (trough)", itemtype = 3918, sell_for = 7 },
		{ name = "box kit (barrel)", itemtype = 3919, sell_for = 12 },
		{ name = "box kit (trunk)", itemtype = 3920, sell_for = 10 },
		{ name = "box", itemtype = 1738, sell_for = 10 },
		{ name = "rack kit (armor)", itemtype = 6114, sell_for = 90 },
		{ name = "rack kit (weapon)", itemtype = 6115, sell_for = 90 },
		{ name = "bookcase kit", itemtype = 6373, sell_for = 70 },
	},
	
	["pillows"] = {
		{ name = "small pillow (purple)", itemtype = 1678, sell_for = 20 },
		{ name = "small pillow (green)", itemtype = 1679, sell_for = 20 },
		{ name = "small pillow (red)", itemtype = 1680, sell_for = 20 },
		{ name = "small pillow (blue)", itemtype = 1688, sell_for = 20 },
		{ name = "small pillow (orange)", itemtype = 1682, sell_for = 20 },
		{ name = "small pillow (turquoise)", itemtype = 1683, sell_for = 20 },
		{ name = "small pillow (white)", itemtype = 1684, sell_for = 20 },
		
		{ name = "pillow (hearth)", itemtype = 1685, sell_for = 85 },
		{ name = "pillow (blue)", itemtype = 1686, sell_for = 25 },
		{ name = "pillow (red)", itemtype = 1687, sell_for = 25 },
		{ name = "pillow (green)", itemtype = 1688, sell_for = 25 },
		{ name = "pillow (yellow)", itemtype = 8072, sell_for = 25 },
		{ name = "pillow (yellow)", itemtype = 8072, sell_for = 25 },
		
		{ name = "round pillow (blue)", itemtype = 1690, sell_for = 25 },
		{ name = "round pillow (purple)", itemtype = 1692, sell_for = 25 },
		{ name = "round pillow (turquoise)", itemtype = 1693, sell_for = 25 },
		{ name = "round pillow (turquoise)", itemtype = 1693, sell_for = 25 },
		
		{ name = "tapestry (purple)", itemtype = 1857, sell_for = 25 },
		{ name = "tapestry (green)", itemtype = 1860, sell_for = 25 },
		{ name = "tapestry (yellow)", itemtype = 1863, sell_for = 25 },
		{ name = "tapestry (orange)", itemtype = 1866, sell_for = 25 },
		{ name = "tapestry (red)", itemtype = 1869, sell_for = 25 },
		{ name = "tapestry (blue)", itemtype = 1872, sell_for = 25 },
		{ name = "tapestry (white)", itemtype = 1880, sell_for = 25 },
	},
	
	["plants"] = {
		{ name = "exotic flowers", itemtype = 2107, sell_for = 300 },
		{ name = "indoor plant kit", itemtype = 3937, sell_for = 80 },
		{ name = "god flowers", itemtype = 2100, sell_for = 5 },
		{ name = "flower bowl", itemtype = 2102, sell_for = 6 },
		{ name = "honey flower", itemtype = 2103, sell_for = 5 },
		{ name = "potted flower", itemtype = 2104, sell_for = 5 },
	}
}

changeItemsPriceCallback = {
	
}
