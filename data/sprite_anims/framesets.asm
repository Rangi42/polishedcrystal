SpriteAnimFrameData:
; entries correspond to SPRITE_ANIM_FRAMESET_* constants (see constants/sprite_anim_constants.asm)
	table_width 2, SpriteAnimFrameData
	dw .Frameset_00
	dw .Frameset_PartyMon
	dw .Frameset_PartyMonWithMail
	dw .Frameset_PartyMonWithItem
	dw .Frameset_PartyMonFast
	dw .Frameset_PartyMonWithMailFast
	dw .Frameset_PartyMonWithItemFast
	dw .Frameset_TextEntryCursor
	dw .Frameset_TextEntryCursorBig
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
	dw .Frameset_MagnetTrainRed
	dw .Frameset_Leaf
	dw .Frameset_CutTree
	dw .Frameset_EggCrack
	dw .Frameset_EggHatch1
	dw .Frameset_EggHatch2
	dw .Frameset_EggHatch3
	dw .Frameset_EggHatch4
	dw .Frameset_HeadbuttTree
	dw .Frameset_BlueWalk
	dw .Frameset_MagnetTrainBlue
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
	dw .Frameset_PcQuick
	dw .Frameset_PcMode
	dw .Frameset_PcMode2
	dw .Frameset_PcPack
	assert_table_length NUM_SPRITE_ANIM_FRAMESETS

.Frameset_00:
	frame SPRITE_ANIM_OAMSET_RED_WALK_1, 32
	endanim

.Frameset_PartyMon:
	frame SPRITE_ANIM_OAMSET_RED_WALK_1,  8
	frame SPRITE_ANIM_OAMSET_RED_WALK_2,  8
	dorestart

.Frameset_PartyMonWithMail:
	frame SPRITE_ANIM_OAMSET_PARTY_MON_WITH_MAIL_1,  8
	frame SPRITE_ANIM_OAMSET_PARTY_MON_WITH_MAIL_2,  8
	dorestart

.Frameset_PartyMonWithItem:
	frame SPRITE_ANIM_OAMSET_PARTY_MON_WITH_ITEM_1,  8
	frame SPRITE_ANIM_OAMSET_PARTY_MON_WITH_ITEM_2,  8
	dorestart

.Frameset_PartyMonFast:
	frame SPRITE_ANIM_OAMSET_RED_WALK_1,  4
	frame SPRITE_ANIM_OAMSET_RED_WALK_2,  4
	dorestart

.Frameset_PartyMonWithMailFast:
	frame SPRITE_ANIM_OAMSET_PARTY_MON_WITH_MAIL_1,  4
	frame SPRITE_ANIM_OAMSET_PARTY_MON_WITH_MAIL_2,  4
	dorestart

.Frameset_PartyMonWithItemFast:
	frame SPRITE_ANIM_OAMSET_PARTY_MON_WITH_ITEM_1,  4
	frame SPRITE_ANIM_OAMSET_PARTY_MON_WITH_ITEM_2,  4
	dorestart

.Frameset_RedWalk:
	frame SPRITE_ANIM_OAMSET_TRADEMON_ICON_1,  8
	frame SPRITE_ANIM_OAMSET_TRADEMON_ICON_2,  8
	frame SPRITE_ANIM_OAMSET_TRADEMON_ICON_1,  8
	frame SPRITE_ANIM_OAMSET_TRADEMON_ICON_2,  8, OAM_X_FLIP
	dorestart

.Frameset_BlueWalk:
	frame SPRITE_ANIM_OAMSET_BLUE_WALK_1,  8
	frame SPRITE_ANIM_OAMSET_BLUE_WALK_2,  8
	frame SPRITE_ANIM_OAMSET_BLUE_WALK_1,  8
	frame SPRITE_ANIM_OAMSET_BLUE_WALK_2,  8, OAM_X_FLIP
	dorestart

.Frameset_MagnetTrainBlue:
	frame SPRITE_ANIM_OAMSET_MAGNET_TRAIN_BLUE_1,  8
	frame SPRITE_ANIM_OAMSET_MAGNET_TRAIN_BLUE_2,  8
	frame SPRITE_ANIM_OAMSET_MAGNET_TRAIN_BLUE_1,  8
	frame SPRITE_ANIM_OAMSET_MAGNET_TRAIN_BLUE_2,  8, OAM_X_FLIP
	dorestart

.Frameset_TextEntryCursor:
	frame SPRITE_ANIM_OAMSET_TEXT_ENTRY_CURSOR,  1
	dorepeat  1
	dorestart

.Frameset_TextEntryCursorBig:
	frame SPRITE_ANIM_OAMSET_TEXT_ENTRY_CURSOR_BIG,  1
	dorepeat  1
	dorestart

.Frameset_GameFreakLogo:
	frame SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_1, 12
	frame SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_2,  1
	frame SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_3,  1
	frame SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_2,  4
	frame SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_1, 12
	frame SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_2, 12
	frame SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_3,  4
	frame SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_4, 32
	frame SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_5,  3
	frame SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_6,  3
	frame SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_7,  4
	frame SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_8,  4
	frame SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_9,  4
	frame SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_10, 10
	frame SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_11,  7
	endanim

.Frameset_SlotsGolem:
	frame SPRITE_ANIM_OAMSET_SLOTS_GOLEM_1,  7
	frame SPRITE_ANIM_OAMSET_SLOTS_GOLEM_2,  7
	frame SPRITE_ANIM_OAMSET_SLOTS_GOLEM_1,  7, OAM_Y_FLIP
	frame SPRITE_ANIM_OAMSET_SLOTS_GOLEM_2,  7, OAM_X_FLIP
	dorestart

.Frameset_SlotsChansey:
	frame SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_1,  7
	frame SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_2,  7
	frame SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_1,  7
	frame SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_3,  7
	dorestart

.Frameset_SlotsChansey2:
	frame SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_1,  7
	frame SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_4,  7
	frame SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_5,  7
	frame SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_4,  7
	frame SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_1,  7
	endanim

.Frameset_SlotsEgg:
	frame SPRITE_ANIM_OAMSET_SLOTS_EGG, 20
	endanim

.Frameset_StillCursor:
	frame SPRITE_ANIM_OAMSET_STILL_CURSOR, 32
	endanim

.Frameset_TradePokeBall:
	frame SPRITE_ANIM_OAMSET_TRADE_POKE_BALL_1, 32
	endanim

.Frameset_TradePokeBallWobble:
	frame SPRITE_ANIM_OAMSET_TRADE_POKE_BALL_1,  3
	frame SPRITE_ANIM_OAMSET_TRADE_POKE_BALL_2,  3
	frame SPRITE_ANIM_OAMSET_TRADE_POKE_BALL_1,  3
	frame SPRITE_ANIM_OAMSET_TRADE_POKE_BALL_2,  3, OAM_X_FLIP
	dorestart

.Frameset_TradePoof:
	frame SPRITE_ANIM_OAMSET_TRADE_POOF_1,  4
	frame SPRITE_ANIM_OAMSET_TRADE_POOF_2,  4
	frame SPRITE_ANIM_OAMSET_TRADE_POOF_3,  4
	delanim

.Frameset_TradeTubeBulge:
	frame SPRITE_ANIM_OAMSET_TRADE_TUBE_BULGE_1,  3
	frame SPRITE_ANIM_OAMSET_TRADE_TUBE_BULGE_2,  3
	dorestart

.Frameset_TrademonIcon:
	frame SPRITE_ANIM_OAMSET_TRADEMON_ICON_1,  7
	frame SPRITE_ANIM_OAMSET_TRADEMON_ICON_2,  7
	dorestart

.Frameset_TrademonBubble:
	frame SPRITE_ANIM_OAMSET_TRADEMON_BUBBLE, 32
	endanim

.Frameset_EvolutionBallOfLight:
	frame SPRITE_ANIM_OAMSET_EVOLUTION_BALL_OF_LIGHT_2,  2
	frame SPRITE_ANIM_OAMSET_EVOLUTION_BALL_OF_LIGHT_1,  2
	frame SPRITE_ANIM_OAMSET_EVOLUTION_BALL_OF_LIGHT_2,  2
	endanim

.Frameset_RadioTuningKnob:
	frame SPRITE_ANIM_OAMSET_RADIO_TUNING_KNOB, 32
	endanim

.Frameset_MagnetTrainRed:
	frame SPRITE_ANIM_OAMSET_MAGNET_TRAIN_RED_1,  8
	frame SPRITE_ANIM_OAMSET_MAGNET_TRAIN_RED_2,  8
	frame SPRITE_ANIM_OAMSET_MAGNET_TRAIN_RED_1,  8
	frame SPRITE_ANIM_OAMSET_MAGNET_TRAIN_RED_2,  8, OAM_X_FLIP
	dorestart

.Frameset_Leaf:
	frame SPRITE_ANIM_OAMSET_LEAF, 32
	endanim

.Frameset_CutTree:
	frame SPRITE_ANIM_OAMSET_TREE_1,  2
	frame SPRITE_ANIM_OAMSET_CUT_TREE_2, 16
	dorepeat  1
	frame SPRITE_ANIM_OAMSET_CUT_TREE_3,  1
	dorepeat  1
	frame SPRITE_ANIM_OAMSET_CUT_TREE_4,  1
	delanim

.Frameset_EggCrack:
	frame SPRITE_ANIM_OAMSET_EGG_CRACK, 32
	endanim

.Frameset_EggHatch1:
	frame SPRITE_ANIM_OAMSET_EGG_HATCH, 32
	endanim

.Frameset_EggHatch2:
	frame SPRITE_ANIM_OAMSET_EGG_HATCH, 32, OAM_X_FLIP
	endanim

.Frameset_EggHatch3:
	frame SPRITE_ANIM_OAMSET_EGG_HATCH, 32, OAM_Y_FLIP
	endanim

.Frameset_EggHatch4:
	frame SPRITE_ANIM_OAMSET_EGG_HATCH, 32, OAM_X_FLIP, OAM_Y_FLIP
	endanim

.Frameset_HeadbuttTree:
	frame SPRITE_ANIM_OAMSET_TREE_1,  2
	frame SPRITE_ANIM_OAMSET_HEADBUTT_TREE_2,  2
	frame SPRITE_ANIM_OAMSET_TREE_1,  2
	frame SPRITE_ANIM_OAMSET_HEADBUTT_TREE_2,  2, OAM_X_FLIP
	dorestart

.Frameset_IntroSuicune:
	frame SPRITE_ANIM_OAMSET_INTRO_SUICUNE_1,  3
	frame SPRITE_ANIM_OAMSET_INTRO_SUICUNE_2,  3
	frame SPRITE_ANIM_OAMSET_INTRO_SUICUNE_3,  3
	frame SPRITE_ANIM_OAMSET_INTRO_SUICUNE_4,  3
	dorestart

.Frameset_IntroSuicune2:
	frame SPRITE_ANIM_OAMSET_INTRO_SUICUNE_4,  3
	frame SPRITE_ANIM_OAMSET_INTRO_SUICUNE_1,  7
	endanim

.Frameset_IntroPichu:
	frame SPRITE_ANIM_OAMSET_INTRO_PICHU_1, 32
	frame SPRITE_ANIM_OAMSET_INTRO_PICHU_2,  7
	frame SPRITE_ANIM_OAMSET_INTRO_PICHU_3,  7
	endanim

.Frameset_IntroWooper:
	frame SPRITE_ANIM_OAMSET_INTRO_WOOPER,  3
	endanim

.Frameset_IntroUnown1:
	frame SPRITE_ANIM_OAMSET_INTRO_UNOWN_1,  3
	frame SPRITE_ANIM_OAMSET_INTRO_UNOWN_2,  3
	frame SPRITE_ANIM_OAMSET_INTRO_UNOWN_3,  7
	delanim

.Frameset_IntroUnown2:
	frame SPRITE_ANIM_OAMSET_INTRO_UNOWN_1,  3, OAM_X_FLIP
	frame SPRITE_ANIM_OAMSET_INTRO_UNOWN_2,  3, OAM_X_FLIP
	frame SPRITE_ANIM_OAMSET_INTRO_UNOWN_3,  7, OAM_X_FLIP
	delanim

.Frameset_IntroUnown3:
	frame SPRITE_ANIM_OAMSET_INTRO_UNOWN_1,  3, OAM_Y_FLIP
	frame SPRITE_ANIM_OAMSET_INTRO_UNOWN_2,  3, OAM_Y_FLIP
	frame SPRITE_ANIM_OAMSET_INTRO_UNOWN_3,  7, OAM_Y_FLIP
	delanim

.Frameset_IntroUnown4:
	frame SPRITE_ANIM_OAMSET_INTRO_UNOWN_1,  3, OAM_X_FLIP, OAM_Y_FLIP
	frame SPRITE_ANIM_OAMSET_INTRO_UNOWN_2,  3, OAM_X_FLIP, OAM_Y_FLIP
	frame SPRITE_ANIM_OAMSET_INTRO_UNOWN_3,  7, OAM_X_FLIP, OAM_Y_FLIP
	delanim

.Frameset_IntroUnownF2:
	frame SPRITE_ANIM_OAMSET_INTRO_UNOWN_F_2_1,  3
	frame SPRITE_ANIM_OAMSET_INTRO_UNOWN_F_2_2,  3
	frame SPRITE_ANIM_OAMSET_INTRO_UNOWN_F_2_3,  3
	frame SPRITE_ANIM_OAMSET_INTRO_UNOWN_F_2_4,  7
	frame SPRITE_ANIM_OAMSET_INTRO_UNOWN_F_2_5,  7
	endanim

.Frameset_IntroSuicuneAway:
	frame SPRITE_ANIM_OAMSET_INTRO_SUICUNE_AWAY,  3
	endanim

.Frameset_IntroUnownF:
	dorepeat 0
	endanim

.Frameset_CelebiLeft:
	frame SPRITE_ANIM_OAMSET_CELEBI_1,  8
	frame SPRITE_ANIM_OAMSET_CELEBI_2,  8
	endanim

.Frameset_CelebiRight:
	frame SPRITE_ANIM_OAMSET_CELEBI_1,  8, OAM_X_FLIP
	frame SPRITE_ANIM_OAMSET_CELEBI_2,  8, OAM_X_FLIP
	endanim

.Frameset_MaxStatSparkle:
	frame SPRITE_ANIM_OAMSET_MAX_STAT_SPARKLE, 32
	dorestart

.Frameset_HyperTrainedStat:
	frame SPRITE_ANIM_OAMSET_HYPER_TRAINED_STAT, 32
	dorestart

.Frameset_PcCursor:
	frame SPRITE_ANIM_OAMSET_PC_CURSOR, 32
	dorestart

.Frameset_PcQuick:
	frame SPRITE_ANIM_OAMSET_PC_QUICK, 8
	delanim

.Frameset_PcMode:
	frame SPRITE_ANIM_OAMSET_PC_MODE, 32
	dorestart

.Frameset_PcMode2:
	frame SPRITE_ANIM_OAMSET_PC_MODE2, 32
	dorestart

.Frameset_PcPack:
	frame SPRITE_ANIM_OAMSET_PC_PACK, 32
	dorestart
