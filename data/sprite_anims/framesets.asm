SpriteAnimFrameData:
; entries correspond to SPRITE_ANIM_FRAMESET_* constants (see constants/sprite_anim_constants.asm)
	table_width 2
	dw .Frameset_00
	dw .Frameset_PartyMon
	dw .Frameset_PartyMonWithItem
	dw .Frameset_PartyMonWithInertItem
	dw .Frameset_PartyMonWithMail
	dw .Frameset_PartyMonWithBerry
	dw .Frameset_TextEntryCursor
	dw .Frameset_TextEntryCursorBig
	dw .Frameset_TextEntryCursorBlue
	dw .Frameset_TextEntryCursorBlueBig
	dw .Frameset_GameFreakLogo
	dw .Frameset_SlotsGolem
	dw .Frameset_SlotsChansey
	dw .Frameset_SlotsChansey2
	dw .Frameset_SlotsEgg
	dw .Frameset_RedWalk
	dw .Frameset_StillCursor
	dw .Frameset_TradePokeBall
	dw .Frameset_TradePokeBallWobble
	dw .Frameset_TradePoof
	dw .Frameset_TradeTubeBulge
	dw .Frameset_TrademonIcon
	dw .Frameset_TrademonBubble
	dw .Frameset_EvolutionBallOfLight
	dw .Frameset_RadioTuningKnob
	dw .Frameset_MagnetTrain
	dw .Frameset_Leaf
	dw .Frameset_CutTree
	dw .Frameset_EggCrack
	dw .Frameset_EggHatch1
	dw .Frameset_EggHatch2
	dw .Frameset_EggHatch3
	dw .Frameset_EggHatch4
	dw .Frameset_HeadbuttTree
	dw .Frameset_BlueWalk
	dw .Frameset_IntroSuicune
	dw .Frameset_IntroSuicune2
	dw .Frameset_IntroPichu
	dw .Frameset_IntroWooper
	dw .Frameset_IntroUnown1
	dw .Frameset_IntroUnown2
	dw .Frameset_IntroUnown3
	dw .Frameset_IntroUnown4
	dw .Frameset_IntroUnownF2
	dw .Frameset_IntroSuicuneAway
	dw .Frameset_IntroUnownF
	dw .Frameset_CelebiLeft
	dw .Frameset_CelebiRight
	dw .Frameset_MaxStatSparkle
	dw .Frameset_HyperTrainedStat
	dw .Frameset_PcCursor
	dw .Frameset_PcCursorItem
	dw .Frameset_PcQuick
	dw .Frameset_PcMode
	dw .Frameset_PcMode2
	dw .Frameset_PcPack
	dw .Frameset_DexCursor
	dw .Frameset_DexUnownCursor
	dw .Frameset_DexSlowpoke
	dw .Frameset_TownMapFly
	dw .Frameset_GreenWalk
	dw .Frameset_FlyMon
	assert_table_length NUM_SPRITE_ANIM_FRAMESETS

.Frameset_00:
	oamframe SPRITE_ANIM_OAMSET_PARTY_MON_1, 32
	oamend

.Frameset_PartyMon:
	oamframe SPRITE_ANIM_OAMSET_PARTY_MON_1,  8
	oamframe SPRITE_ANIM_OAMSET_PARTY_MON_2,  8
	oamrestart

.Frameset_PartyMonWithItem:
	oamframe SPRITE_ANIM_OAMSET_PARTY_MON_WITH_ITEM_1,  8
	oamframe SPRITE_ANIM_OAMSET_PARTY_MON_WITH_ITEM_2,  8
	oamrestart

.Frameset_PartyMonWithInertItem:
	oamframe SPRITE_ANIM_OAMSET_PARTY_MON_WITH_INERT_ITEM_1,  8
	oamframe SPRITE_ANIM_OAMSET_PARTY_MON_WITH_INERT_ITEM_2,  8
	oamrestart

.Frameset_PartyMonWithMail:
	oamframe SPRITE_ANIM_OAMSET_PARTY_MON_WITH_MAIL_1,  8
	oamframe SPRITE_ANIM_OAMSET_PARTY_MON_WITH_MAIL_2,  8
	oamrestart

.Frameset_PartyMonWithBerry:
	oamframe SPRITE_ANIM_OAMSET_PARTY_MON_WITH_BERRY_1,  8
	oamframe SPRITE_ANIM_OAMSET_PARTY_MON_WITH_BERRY_2,  8
	oamrestart

.Frameset_RedWalk:
	oamframe SPRITE_ANIM_OAMSET_RED_WALK_1,  8
	oamframe SPRITE_ANIM_OAMSET_RED_WALK_2,  8
	oamframe SPRITE_ANIM_OAMSET_RED_WALK_1,  8
	oamframe SPRITE_ANIM_OAMSET_RED_WALK_2,  8, B_OAM_XFLIP
	oamrestart

.Frameset_BlueWalk:
	oamframe SPRITE_ANIM_OAMSET_BLUE_WALK_1,  8
	oamframe SPRITE_ANIM_OAMSET_BLUE_WALK_2,  8
	oamframe SPRITE_ANIM_OAMSET_BLUE_WALK_1,  8
	oamframe SPRITE_ANIM_OAMSET_BLUE_WALK_2,  8, B_OAM_XFLIP
	oamrestart

.Frameset_GreenWalk:
	oamframe SPRITE_ANIM_OAMSET_GREEN_WALK_1,  8
	oamframe SPRITE_ANIM_OAMSET_GREEN_WALK_2,  8
	oamframe SPRITE_ANIM_OAMSET_GREEN_WALK_1,  8
	oamframe SPRITE_ANIM_OAMSET_GREEN_WALK_2,  8, B_OAM_XFLIP
	oamrestart

.Frameset_TextEntryCursor:
	oamframe SPRITE_ANIM_OAMSET_TEXT_ENTRY_CURSOR,  1
	dorepeat  1
	oamrestart

.Frameset_TextEntryCursorBig:
	oamframe SPRITE_ANIM_OAMSET_TEXT_ENTRY_CURSOR_BIG,  1
	dorepeat  1
	oamrestart

.Frameset_TextEntryCursorBlue:
	oamframe SPRITE_ANIM_OAMSET_TEXT_ENTRY_CURSOR_BLUE,  1
	dorepeat  1
	oamrestart

.Frameset_TextEntryCursorBlueBig:
	oamframe SPRITE_ANIM_OAMSET_TEXT_ENTRY_CURSOR_BLUE_BIG,  1
	dorepeat  1
	oamrestart

.Frameset_GameFreakLogo:
	oamframe SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_1, 12
	oamframe SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_2,  1
	oamframe SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_3,  1
	oamframe SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_2,  4
	oamframe SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_1, 12
	oamframe SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_2, 12
	oamframe SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_3,  4
	oamframe SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_4, 32
	oamframe SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_5,  3
	oamframe SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_6,  3
	oamframe SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_7,  4
	oamframe SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_8,  4
	oamframe SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_9,  4
	oamframe SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_10, 10
	oamframe SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_11,  7
	oamend

.Frameset_SlotsGolem:
	oamframe SPRITE_ANIM_OAMSET_SLOTS_GOLEM_1,  7
	oamframe SPRITE_ANIM_OAMSET_SLOTS_GOLEM_2,  7
	oamframe SPRITE_ANIM_OAMSET_SLOTS_GOLEM_1,  7, B_OAM_YFLIP
	oamframe SPRITE_ANIM_OAMSET_SLOTS_GOLEM_2,  7, B_OAM_XFLIP
	oamrestart

.Frameset_SlotsChansey:
	oamframe SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_1,  7
	oamframe SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_2,  7
	oamframe SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_1,  7
	oamframe SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_3,  7
	oamrestart

.Frameset_SlotsChansey2:
	oamframe SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_1,  7
	oamframe SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_4,  7
	oamframe SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_5,  7
	oamframe SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_4,  7
	oamframe SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_1,  7
	oamend

.Frameset_SlotsEgg:
	oamframe SPRITE_ANIM_OAMSET_SLOTS_EGG, 20
	oamend

.Frameset_StillCursor:
	oamframe SPRITE_ANIM_OAMSET_STILL_CURSOR, 32
	oamend

.Frameset_TradePokeBall:
	oamframe SPRITE_ANIM_OAMSET_TRADE_POKE_BALL_1, 32
	oamend

.Frameset_TradePokeBallWobble:
	oamframe SPRITE_ANIM_OAMSET_TRADE_POKE_BALL_1,  3
	oamframe SPRITE_ANIM_OAMSET_TRADE_POKE_BALL_2,  3
	oamframe SPRITE_ANIM_OAMSET_TRADE_POKE_BALL_1,  3
	oamframe SPRITE_ANIM_OAMSET_TRADE_POKE_BALL_2,  3, B_OAM_XFLIP
	oamrestart

.Frameset_TradePoof:
	oamframe SPRITE_ANIM_OAMSET_TRADE_POOF_1,  4
	oamframe SPRITE_ANIM_OAMSET_TRADE_POOF_2,  4
	oamframe SPRITE_ANIM_OAMSET_TRADE_POOF_3,  4
	oamdelete

.Frameset_TradeTubeBulge:
	oamframe SPRITE_ANIM_OAMSET_TRADE_TUBE_BULGE_1,  3
	oamframe SPRITE_ANIM_OAMSET_TRADE_TUBE_BULGE_2,  3
	oamrestart

.Frameset_TrademonIcon:
	oamframe SPRITE_ANIM_OAMSET_TRADEMON_ICON_1,  7
	oamframe SPRITE_ANIM_OAMSET_TRADEMON_ICON_2,  7
	oamrestart

.Frameset_TrademonBubble:
	oamframe SPRITE_ANIM_OAMSET_TRADEMON_BUBBLE, 32
	oamend

.Frameset_EvolutionBallOfLight:
	oamframe SPRITE_ANIM_OAMSET_EVOLUTION_BALL_OF_LIGHT_2,  2
	oamframe SPRITE_ANIM_OAMSET_EVOLUTION_BALL_OF_LIGHT_1,  2
	oamframe SPRITE_ANIM_OAMSET_EVOLUTION_BALL_OF_LIGHT_2,  2
	oamend

.Frameset_RadioTuningKnob:
	oamframe SPRITE_ANIM_OAMSET_RADIO_TUNING_KNOB, 32
	oamend

.Frameset_MagnetTrain:
	oamframe SPRITE_ANIM_OAMSET_MAGNET_TRAIN_1,  8
	oamframe SPRITE_ANIM_OAMSET_MAGNET_TRAIN_2,  8
	oamframe SPRITE_ANIM_OAMSET_MAGNET_TRAIN_1,  8
	oamframe SPRITE_ANIM_OAMSET_MAGNET_TRAIN_2,  8, B_OAM_XFLIP
	oamrestart

.Frameset_Leaf:
	oamframe SPRITE_ANIM_OAMSET_LEAF, 32
	oamend

.Frameset_CutTree:
	oamframe SPRITE_ANIM_OAMSET_TREE_1,  2
	oamframe SPRITE_ANIM_OAMSET_CUT_TREE_2, 16
	dorepeat  1
	oamframe SPRITE_ANIM_OAMSET_CUT_TREE_3,  1
	dorepeat  1
	oamframe SPRITE_ANIM_OAMSET_CUT_TREE_4,  1
	oamdelete

.Frameset_EggCrack:
	oamframe SPRITE_ANIM_OAMSET_EGG_CRACK, 32
	oamend

.Frameset_EggHatch1:
	oamframe SPRITE_ANIM_OAMSET_EGG_HATCH, 32
	oamend

.Frameset_EggHatch2:
	oamframe SPRITE_ANIM_OAMSET_EGG_HATCH, 32, B_OAM_XFLIP
	oamend

.Frameset_EggHatch3:
	oamframe SPRITE_ANIM_OAMSET_EGG_HATCH, 32, B_OAM_YFLIP
	oamend

.Frameset_EggHatch4:
	oamframe SPRITE_ANIM_OAMSET_EGG_HATCH, 32, B_OAM_XFLIP, B_OAM_YFLIP
	oamend

.Frameset_HeadbuttTree:
	oamframe SPRITE_ANIM_OAMSET_TREE_1,  2
	oamframe SPRITE_ANIM_OAMSET_HEADBUTT_TREE_2,  2
	oamframe SPRITE_ANIM_OAMSET_TREE_1,  2
	oamframe SPRITE_ANIM_OAMSET_HEADBUTT_TREE_3,  2
	oamrestart

.Frameset_IntroSuicune:
	oamframe SPRITE_ANIM_OAMSET_INTRO_SUICUNE_1,  3
	oamframe SPRITE_ANIM_OAMSET_INTRO_SUICUNE_2,  3
	oamframe SPRITE_ANIM_OAMSET_INTRO_SUICUNE_3,  3
	oamframe SPRITE_ANIM_OAMSET_INTRO_SUICUNE_4,  3
	oamrestart

.Frameset_IntroSuicune2:
	oamframe SPRITE_ANIM_OAMSET_INTRO_SUICUNE_4,  3
	oamframe SPRITE_ANIM_OAMSET_INTRO_SUICUNE_1,  7
	oamend

.Frameset_IntroPichu:
	oamframe SPRITE_ANIM_OAMSET_INTRO_PICHU_1, 32
	oamframe SPRITE_ANIM_OAMSET_INTRO_PICHU_2,  7
	oamframe SPRITE_ANIM_OAMSET_INTRO_PICHU_3,  7
	oamend

.Frameset_IntroWooper:
	oamframe SPRITE_ANIM_OAMSET_INTRO_WOOPER,  3
	oamend

.Frameset_IntroUnown1:
	oamframe SPRITE_ANIM_OAMSET_INTRO_UNOWN_1,  3
	oamframe SPRITE_ANIM_OAMSET_INTRO_UNOWN_2,  3
	oamframe SPRITE_ANIM_OAMSET_INTRO_UNOWN_3,  7
	oamdelete

.Frameset_IntroUnown2:
	oamframe SPRITE_ANIM_OAMSET_INTRO_UNOWN_1,  3, B_OAM_XFLIP
	oamframe SPRITE_ANIM_OAMSET_INTRO_UNOWN_2,  3, B_OAM_XFLIP
	oamframe SPRITE_ANIM_OAMSET_INTRO_UNOWN_3,  7, B_OAM_XFLIP
	oamdelete

.Frameset_IntroUnown3:
	oamframe SPRITE_ANIM_OAMSET_INTRO_UNOWN_1,  3, B_OAM_YFLIP
	oamframe SPRITE_ANIM_OAMSET_INTRO_UNOWN_2,  3, B_OAM_YFLIP
	oamframe SPRITE_ANIM_OAMSET_INTRO_UNOWN_3,  7, B_OAM_YFLIP
	oamdelete

.Frameset_IntroUnown4:
	oamframe SPRITE_ANIM_OAMSET_INTRO_UNOWN_1,  3, B_OAM_XFLIP, B_OAM_YFLIP
	oamframe SPRITE_ANIM_OAMSET_INTRO_UNOWN_2,  3, B_OAM_XFLIP, B_OAM_YFLIP
	oamframe SPRITE_ANIM_OAMSET_INTRO_UNOWN_3,  7, B_OAM_XFLIP, B_OAM_YFLIP
	oamdelete

.Frameset_IntroUnownF2:
	oamframe SPRITE_ANIM_OAMSET_INTRO_UNOWN_F_2_1,  3
	oamframe SPRITE_ANIM_OAMSET_INTRO_UNOWN_F_2_2,  3
	oamframe SPRITE_ANIM_OAMSET_INTRO_UNOWN_F_2_3,  3
	oamframe SPRITE_ANIM_OAMSET_INTRO_UNOWN_F_2_4,  7
	oamframe SPRITE_ANIM_OAMSET_INTRO_UNOWN_F_2_5,  7
	oamend

.Frameset_IntroSuicuneAway:
	oamframe SPRITE_ANIM_OAMSET_INTRO_SUICUNE_AWAY,  3
	oamend

.Frameset_IntroUnownF:
	dorepeat 0
	oamend

.Frameset_CelebiLeft:
	oamframe SPRITE_ANIM_OAMSET_CELEBI_1,  8
	oamframe SPRITE_ANIM_OAMSET_CELEBI_2,  8
	oamend

.Frameset_CelebiRight:
	oamframe SPRITE_ANIM_OAMSET_CELEBI_1,  8, B_OAM_XFLIP
	oamframe SPRITE_ANIM_OAMSET_CELEBI_2,  8, B_OAM_XFLIP
	oamend

.Frameset_MaxStatSparkle:
	oamframe SPRITE_ANIM_OAMSET_MAX_STAT_SPARKLE, 32
	oamrestart

.Frameset_HyperTrainedStat:
	oamframe SPRITE_ANIM_OAMSET_HYPER_TRAINED_STAT, 32
	oamrestart

.Frameset_PcCursor:
	oamframe SPRITE_ANIM_OAMSET_PC_CURSOR, 32
	oamrestart

.Frameset_PcCursorItem:
	; Conditionally switched to when dealing with items
	oamframe SPRITE_ANIM_OAMSET_PC_CURSOR_ITEM, 32
	oamrestart

.Frameset_PcQuick:
	oamframe SPRITE_ANIM_OAMSET_PC_QUICK, 8
	oamdelete

.Frameset_PcMode:
	oamframe SPRITE_ANIM_OAMSET_PC_MODE, 32
	oamrestart

.Frameset_PcMode2:
	oamframe SPRITE_ANIM_OAMSET_PC_MODE2, 32
	oamrestart

.Frameset_PcPack:
	oamframe SPRITE_ANIM_OAMSET_PC_PACK, 32
	oamrestart

.Frameset_DexCursor:
	oamframe SPRITE_ANIM_OAMSET_DEX_CURSOR, 32
	oamrestart

.Frameset_DexUnownCursor:
	oamframe SPRITE_ANIM_OAMSET_DEX_UNOWN_CURSOR, 32
	oamrestart

.Frameset_DexSlowpoke:
	oamframe SPRITE_ANIM_OAMSET_DEX_SLOWPOKE_1, 3
	oamframe SPRITE_ANIM_OAMSET_DEX_SLOWPOKE_2, 3
	oamframe SPRITE_ANIM_OAMSET_DEX_SLOWPOKE_3, 3
	oamframe SPRITE_ANIM_OAMSET_DEX_SLOWPOKE_4, 3
	oamframe SPRITE_ANIM_OAMSET_DEX_SLOWPOKE_5, 3
	oamrestart

.Frameset_TownMapFly:
	oamframe SPRITE_ANIM_OAMSET_TOWN_MAP_FLY, 32
	oamrestart

.Frameset_FlyMon:
	oamframe SPRITE_ANIM_OAMSET_FLY_MON_1,  8
	oamframe SPRITE_ANIM_OAMSET_FLY_MON_2,  8
	oamframe SPRITE_ANIM_OAMSET_FLY_MON_1,  8
	oamframe SPRITE_ANIM_OAMSET_FLY_MON_3,  8, B_OAM_XFLIP
	oamrestart
