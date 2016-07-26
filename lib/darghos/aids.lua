--[[
 * Contains all Action IDS of SERVER!
]]--

	aid =
	{
		
	--[[ IDS OF TEMPLES MOVEMENETS:]]--
		NORTH_TEMPLES 			= 3001,
		SALA_TEMPLES 			= 3002,
		THORN_TEMPLES			= 3003,
		ARACURA_TEMPLES			= 3004,
		QUENDOR_TEMPLES			= 3005,
	--[[ IDS OF TEMPLES MOVEMENETS:]]--	

	-- [[ IDs in Map ]]--
		DH_ALAVANCA				= 4001,
		BANSHEE_FIRST			= 4002,
		BANSHEE_SECOND			= 4003,
		BANSHEE_THIRD			= 4004,
		BANSHEE_FOUR			= 4005,
		BANSHEE_FIVE			= 4006,
		BANSHEE_SIX				= 4007,
		BANSHEE_SEALFORPASS		= 4008,
		BANSHEE_QUEENDOOR		= 4009,
		ANIHI_SWITCH			= 4010,
		GOROMA_STONE1			= 4011,
		
		
		POI_GRAVESTONE_USE		= 4012,
		POI_LEVER_ENTER			= 4013,
		POI_CREATE_STAIR		= 4014,
		POI_FIRESTONE			= 4015,
		POI_MWALL_GO			= 4016,
		POI_MWALL_BACK			= 4017,
		POI_TRONE1				= 4018,
		POI_TRONE2				= 4019,
		POI_TRONE3				= 4020,
		POI_TRONE4				= 4021,
		POI_TRONE5				= 4022,
		POI_TRONE6				= 4023,
		POI_VERIFY_1			= 4024,
		POI_VERIFY_2			= 4025,
		POI_VERIFY_3			= 4026,
		POI_VERIFY_4			= 4027,
		POI_VERIFY_5			= 4028,
		POI_VERIFY_6			= 4029,
		
		MINES_ELEVADOR			= 4030,
		TRAINERS_WEST			= 4031,
		TRAINER_EAST			= 4032,
		INQ_HALL_USHURIEL		= 4033,
		INQ_HALL_ZUGUROSH		= 4034,
		INQ_HALL_MADARETH		= 4035,
		INQ_HALL_LATRIVAN		= 4036,
		INQ_HALL_ANIHILION		= 4037,
		INQ_HALL_HELLGORAK		= 4038,
		INQ_MAGIC_WALL			= 4039,
		SALAZART_MEDUSAS_TP		= 4040,
		
		-- ARIADNE TROLLS WING
		ARIADNE_TOTEMS			= {
			
			-- 12 aids para 12 totems
			4041, 4042, 4043, 4044, 4045, 4046, 4047, 4048, 4049, 4050, 4051, 4052		
		},
		
		ARIADNE_HYDRA_NEST		= {
		
			4053, 4054, 4055, 4056
		},
		
		ARIADNE_GHAZRAN_CORPSE = 4057,

		DIVINE_ANKH 	= 4058,
		CHURCH_ALTAR 	= 4059,
		CHURCH_PORTAL	= 4060,
		ANIHI_ARACURA_SWITCH	= 4061,
		DH_ARACURA_SWITCH		= 4062,
		INQ_PORTAL		= 4063,
		INQ_UNGREEZ_PORTAL = 4064,
		
		DEMON_OAK_DEAD_TREE			= 4065,
		DEMON_OAK_TELEPORT			= 4066,
		DEMON_OAK_STONE_COFFIN		= 4067,
		
		SHRINE_MIN					= 4068,
		SHRINE_EARTH				= 4068,
		SHRINE_ICE					= 4069,
		SHRINE_FIRE					= 4070,
		SHRINE_ENERGY				= 4071,
		SHRINE_MAX					= 4071,
		
		OPEN_CHRISTMAS_PRESENT			= 4072,
		
		KOSHEI_STATUE_1				= 4073,
		KOSHEI_STATUE_2				= 4074,
		
		TELEPORT_NO_SKULLS			= 4075,		
		
		--POI VOCATION LEVERS
		POI_LEVER_SORCERER			= 4076,
		POI_LEVER_DRUID				= 4077,
		POI_LEVER_PALADIN			= 4078,
		POI_LEVER_KNIGHT			= 4079,
		
		
		BATTLEGROUND_EXIT					= 5400,
		BATTLEGROUND_LEAVE_SPAWN 			= 5401,

		-- NORTHREND ARENAS
		ARENA_TELEPORT				= 4080,
		ARENA_TELEPORT_REWARD		= 4081,
		ARENA_TELEPORT_EXIT			= 4082,
		ARENA_SEARING_FIRE			= 4083,
		
		TRAINERS_ROOM_ENTRANCE			= 4084,
		TRAINERS_ROOM_LEAVE			= 4085,
			
		PORTAL_HUNTS                           	= 4086,
		RAIDS_ENTRANCE				= 4087,

		DARK_GENERAL_ENTRANCE		= 4088,
		DARK_GENERAL_LEAVE			= 4089,
		SURVIVAL_ENTRANCE			= 4090,

		ENT_ENTRANCE				= 4092,
		ENT_LEAVE					= 4093,

		--  Poi Entrance Fields
		POI_FIELDS_START			= 6010,
		POI_FIELDS_END				= 6044,
		
		-- Dungeons (7400~7500)
		DUNGEONS_DEMON_HELMET		= 7400,
		DUNGEONS_ARIADNE_GHAZRAN	= 7401,
			

		--@ POI LABIRINTO | Used small numbers for aids, because its better1!!
		POI_MOVE_TP1			= 250,
		POI_MOVE_TP2			= 251,
		POI_MOVE_TP3			= 252,
		POI_MOVE_TP4			= 253,
		POI_MOVE_TP5			= 254,
		POI_MOVE_TP6			= 255,	
		POI_MOVE_TP7			= 256,	
		POI_MOVE_TP8			= 257,	
		POI_MOVE_TP_ERRO		= 258,
		POI_DOWN_TO_CENTRAL		= 260,
		
		-- MINI GAME
		MINI_GAME_TP		= 261,
		MINI_GAME_TILE		= 262,
		
		------------------------------
		----[[ by Bruno | Storm ]]----
		------------------------------
		
		-- Kashmir Quest
		KASHMIR_LAST_TILE		= 7501, 
		KASHMIR_GLOBE_READY		= 7502,
		KASHMIR_GLOBE_WAITING		= 7503,
		KASHMIR_REWARD_CHEST_MASK	= 7504,
		KASHMIR_REWARD_CHEST_ARMOR	= 7505,
		KASHMIR_REWARD_CHEST_LEGS	= 7506,
		KASHMIR_DOOR_1			= 7507,
		KASHMIR_DOOR_2			= 7508,
		
		DEMONA_SHORTCUT_ACCESS_TP_IN	= 7520,
		DEMONA_SHORTCUT_ACCESS_TP_OUT	= 7521,
		
                --AIDS FROM 8500 to 9000 are used on TELEPORTS, check libs/teleports.lua to more informations
                TELEPORT_SYSTEM_INIT           = 8500,		
	
	}
