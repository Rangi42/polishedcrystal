SpriteAnimSeqData:
; entries correspond to SPRITE_ANIM_INDEX_* constants (see constants/sprite_anim_constants.asm)
	table_width 3, SpriteAnimSeqData
	; frameset, sequence, tile
; SPRITE_ANIM_INDEX_PARTY_MON
	db SPRITE_ANIM_FRAMESET_PARTY_MON, SPRITE_ANIM_SEQ_PARTY_MON, $00
; SPRITE_ANIM_INDEX_NAMING_SCREEN_CURSOR
	db SPRITE_ANIM_FRAMESET_TEXT_ENTRY_CURSOR, SPRITE_ANIM_SEQ_NAMING_SCREEN_CURSOR, $05
; SPRITE_ANIM_INDEX_GAMEFREAK_LOGO
	db SPRITE_ANIM_FRAMESET_GAMEFREAK_LOGO, SPRITE_ANIM_SEQ_GAMEFREAK_LOGO, $00
; SPRITE_ANIM_INDEX_SLOTS_GOLEM
	db SPRITE_ANIM_FRAMESET_SLOTS_GOLEM, SPRITE_ANIM_SEQ_SLOTS_GOLEM, $07
; SPRITE_ANIM_INDEX_SLOTS_CHANSEY
	db SPRITE_ANIM_FRAMESET_SLOTS_CHANSEY, SPRITE_ANIM_SEQ_SLOTS_CHANSEY, $07
; SPRITE_ANIM_INDEX_SLOTS_EGG
	db SPRITE_ANIM_FRAMESET_SLOTS_EGG, SPRITE_ANIM_SEQ_SLOTS_EGG, $07
; SPRITE_ANIM_INDEX_COMPOSE_MAIL_CURSOR
	db SPRITE_ANIM_FRAMESET_TEXT_ENTRY_CURSOR, SPRITE_ANIM_SEQ_COMPOSE_MAIL_CURSOR, $05
; SPRITE_ANIM_INDEX_RED_WALK
	db SPRITE_ANIM_FRAMESET_RED_WALK, SPRITE_ANIM_SEQ_NULL, $00
;; SPRITE_ANIM_INDEX_MEMORY_GAME
;	db SPRITE_ANIM_FRAMESET_STILL_CURSOR, SPRITE_ANIM_SEQ_MEMORY_GAME_CURSOR, $08
; SPRITE_ANIM_INDEX_POKEGEAR_MODE_ARROW
	db SPRITE_ANIM_FRAMESET_STILL_CURSOR, SPRITE_ANIM_SEQ_POKEGEAR_MODE_ARROW, $08
; SPRITE_ANIM_INDEX_TRADE_POKE_BALL
	db SPRITE_ANIM_FRAMESET_TRADE_POKE_BALL, SPRITE_ANIM_SEQ_TRADE_POKE_BALL, $00
; SPRITE_ANIM_INDEX_TRADE_POOF
	db SPRITE_ANIM_FRAMESET_TRADE_POOF, SPRITE_ANIM_SEQ_NULL, $00
; SPRITE_ANIM_INDEX_TRADE_TUBE_BULGE
	db SPRITE_ANIM_FRAMESET_TRADE_TUBE_BULGE, SPRITE_ANIM_SEQ_TRADE_TUBE_BULGE, $00
; SPRITE_ANIM_INDEX_TRADEMON_ICON
	db SPRITE_ANIM_FRAMESET_TRADEMON_ICON, SPRITE_ANIM_SEQ_TRADEMON_IN_TUBE, $00
; SPRITE_ANIM_INDEX_TRADE_BUBBLE
	db SPRITE_ANIM_FRAMESET_TRADEMON_BUBBLE, SPRITE_ANIM_SEQ_TRADEMON_IN_TUBE, $00
; SPRITE_ANIM_INDEX_EVOLUTION_BALL_OF_LIGHT
	db SPRITE_ANIM_FRAMESET_EVOLUTION_BALL_OF_LIGHT, SPRITE_ANIM_SEQ_REVEAL_NEW_MON, $00
; SPRITE_ANIM_INDEX_RADIO_TUNING_KNOB
	db SPRITE_ANIM_FRAMESET_RADIO_TUNING_KNOB, SPRITE_ANIM_SEQ_RADIO_TUNING_KNOB, $00
; SPRITE_ANIM_INDEX_MAGNET_TRAIN_RED
	db SPRITE_ANIM_FRAMESET_MAGNET_TRAIN_RED, SPRITE_ANIM_SEQ_NULL, $00
; SPRITE_ANIM_INDEX_LEAF
	db SPRITE_ANIM_FRAMESET_LEAF, SPRITE_ANIM_SEQ_CUT_GRASS_LEAVES, $00
; SPRITE_ANIM_INDEX_CUT_TREE
	db SPRITE_ANIM_FRAMESET_CUT_TREE, SPRITE_ANIM_SEQ_NULL, $00
; SPRITE_ANIM_INDEX_FLY_LEAF
	db SPRITE_ANIM_FRAMESET_LEAF, SPRITE_ANIM_SEQ_FLY_LEAF, $00
; SPRITE_ANIM_INDEX_EGG_CRACK
	db SPRITE_ANIM_FRAMESET_EGG_CRACK, SPRITE_ANIM_SEQ_NULL, $00
; SPRITE_ANIM_INDEX_HEADBUTT
	db SPRITE_ANIM_FRAMESET_HEADBUTT, SPRITE_ANIM_SEQ_NULL, $00
; SPRITE_ANIM_INDEX_EGG_HATCH
	db SPRITE_ANIM_FRAMESET_EGG_HATCH, SPRITE_ANIM_SEQ_REVEAL_NEW_MON, $00
; SPRITE_ANIM_INDEX_BLUE_WALK
	db SPRITE_ANIM_FRAMESET_BLUE_WALK, SPRITE_ANIM_SEQ_NULL, $00
; SPRITE_ANIM_INDEX_MAGNET_TRAIN_BLUE
	db SPRITE_ANIM_FRAMESET_MAGNET_TRAIN_BLUE, SPRITE_ANIM_SEQ_NULL, $00
; SPRITE_ANIM_INDEX_INTRO_SUICUNE
	db SPRITE_ANIM_FRAMESET_INTRO_SUICUNE, SPRITE_ANIM_SEQ_INTRO_SUICUNE, $00
; SPRITE_ANIM_INDEX_INTRO_PICHU
	db SPRITE_ANIM_FRAMESET_INTRO_PICHU, SPRITE_ANIM_SEQ_PICHU_WOOPER, $00
; SPRITE_ANIM_INDEX_INTRO_WOOPER
	db SPRITE_ANIM_FRAMESET_INTRO_WOOPER, SPRITE_ANIM_SEQ_PICHU_WOOPER, $00
; SPRITE_ANIM_INDEX_INTRO_UNOWN
	db SPRITE_ANIM_FRAMESET_INTRO_UNOWN_1, SPRITE_ANIM_SEQ_UNOWN, $00
; SPRITE_ANIM_INDEX_INTRO_UNOWN_F
	db SPRITE_ANIM_FRAMESET_INTRO_UNOWN_F, SPRITE_ANIM_SEQ_UNOWN_F, $00
; SPRITE_ANIM_INDEX_INTRO_SUICUNE_AWAY
	db SPRITE_ANIM_FRAMESET_INTRO_SUICUNE_AWAY, SPRITE_ANIM_SEQ_SUICUNE_AWAY, $00
; SPRITE_ANIM_INDEX_CELEBI
	db SPRITE_ANIM_FRAMESET_CELEBI_LEFT, SPRITE_ANIM_SEQ_NULL, $00
; SPRITE_ANIM_INDEX_MAX_STAT_SPARKLE
	db SPRITE_ANIM_FRAMESET_MAX_STAT_SPARKLE, SPRITE_ANIM_SEQ_MAX_STAT_SPARKLE, $00
; SPRITE_ANIM_INDEX_HYPER_TRAINED_STAT
	db SPRITE_ANIM_FRAMESET_HYPER_TRAINED_STAT, SPRITE_ANIM_SEQ_MAX_STAT_SPARKLE, $00
; SPRITE_ANIM_INDEX_PC_CURSOR
	db SPRITE_ANIM_FRAMESET_PC_CURSOR, SPRITE_ANIM_SEQ_PC_CURSOR, $00
; SPRITE_ANIM_INDEX_PC_QUICK
	db SPRITE_ANIM_FRAMESET_PC_QUICK, SPRITE_ANIM_SEQ_PC_QUICK, $00
; SPRITE_ANIM_INDEX_PC_MODE
	db SPRITE_ANIM_FRAMESET_PC_MODE, SPRITE_ANIM_SEQ_PC_MODE, $00
; SPRITE_ANIM_INDEX_PC_MODE2
	db SPRITE_ANIM_FRAMESET_PC_MODE2, SPRITE_ANIM_SEQ_NULL, $00
; SPRITE_ANIM_INDEX_PC_PACK
	db SPRITE_ANIM_FRAMESET_PC_PACK, SPRITE_ANIM_SEQ_PC_PACK, $00
; SPRITE_ANIM_INDEX_DEX_CURSOR
	db SPRITE_ANIM_FRAMESET_DEX_CURSOR, SPRITE_ANIM_SEQ_DEX_CURSOR, $00
	assert_table_length NUM_SPRITE_ANIM_INDEXES
