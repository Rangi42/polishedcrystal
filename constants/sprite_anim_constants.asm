; sprite_anim_struct members (see macros/wram.asm)
rsreset
SPRITEANIMSTRUCT_INDEX           rb ; 0
SPRITEANIMSTRUCT_FRAMESET_ID     rb ; 1
SPRITEANIMSTRUCT_ANIM_SEQ_ID     rb ; 2
SPRITEANIMSTRUCT_TILE_ID         rb ; 3
SPRITEANIMSTRUCT_XCOORD          rb ; 4
SPRITEANIMSTRUCT_YCOORD          rb ; 5
SPRITEANIMSTRUCT_XOFFSET         rb ; 6
SPRITEANIMSTRUCT_YOFFSET         rb ; 7
SPRITEANIMSTRUCT_DURATION        rb ; 8
SPRITEANIMSTRUCT_DURATIONOFFSET  rb ; 9
SPRITEANIMSTRUCT_FRAME           rb ; a
SPRITEANIMSTRUCT_JUMPTABLE_INDEX rb ; b
SPRITEANIMSTRUCT_VAR1            rb ; c
SPRITEANIMSTRUCT_VAR2            rb ; d
SPRITEANIMSTRUCT_VAR3            rb ; e
SPRITEANIMSTRUCT_VAR4            rb ; f
SPRITEANIMSTRUCT_LENGTH EQU _RS
NUM_SPRITE_ANIM_STRUCTS EQU 10 ; see wSpriteAnimationStructs

; wSpriteAnimDict size (see wram.asm)
NUM_SPRITEANIMDICT_ENTRIES EQU 10

; SpriteAnimSeqData indexes (see data/sprite_anims/sequences.asm)
	const_def
	const SPRITE_ANIM_INDEX_PARTY_MON
	const SPRITE_ANIM_INDEX_NAMING_SCREEN_CURSOR
	const SPRITE_ANIM_INDEX_GAMEFREAK_LOGO
	const SPRITE_ANIM_INDEX_SLOTS_GOLEM
	const SPRITE_ANIM_INDEX_SLOTS_CHANSEY
	const SPRITE_ANIM_INDEX_SLOTS_EGG
	const SPRITE_ANIM_INDEX_COMPOSE_MAIL_CURSOR
	const SPRITE_ANIM_INDEX_RED_WALK
;	const SPRITE_ANIM_INDEX_MEMORY_GAME
	const SPRITE_ANIM_INDEX_POKEGEAR_MODE_ARROW
	const SPRITE_ANIM_INDEX_TRADE_POKE_BALL
	const SPRITE_ANIM_INDEX_TRADE_POOF
	const SPRITE_ANIM_INDEX_TRADE_TUBE_BULGE
	const SPRITE_ANIM_INDEX_TRADEMON_ICON
	const SPRITE_ANIM_INDEX_TRADEMON_BUBBLE
	const SPRITE_ANIM_INDEX_EVOLUTION_BALL_OF_LIGHT
	const SPRITE_ANIM_INDEX_RADIO_TUNING_KNOB
	const SPRITE_ANIM_INDEX_MAGNET_TRAIN_RED
	const SPRITE_ANIM_INDEX_LEAF
	const SPRITE_ANIM_INDEX_CUT_TREE
	const SPRITE_ANIM_INDEX_FLY_LEAF
	const SPRITE_ANIM_INDEX_EGG_CRACK
	const SPRITE_ANIM_INDEX_HEADBUTT
	const SPRITE_ANIM_INDEX_EGG_HATCH
	const SPRITE_ANIM_INDEX_BLUE_WALK
	const SPRITE_ANIM_INDEX_MAGNET_TRAIN_BLUE
	const SPRITE_ANIM_INDEX_INTRO_SUICUNE
	const SPRITE_ANIM_INDEX_INTRO_PICHU
	const SPRITE_ANIM_INDEX_INTRO_WOOPER
	const SPRITE_ANIM_INDEX_INTRO_UNOWN
	const SPRITE_ANIM_INDEX_INTRO_UNOWN_F
	const SPRITE_ANIM_INDEX_INTRO_SUICUNE_AWAY
	const SPRITE_ANIM_INDEX_CELEBI
	const SPRITE_ANIM_INDEX_MAX_STAT_SPARKLE
	const SPRITE_ANIM_INDEX_HYPER_TRAINED_STAT
	const SPRITE_ANIM_INDEX_PC_CURSOR
	const SPRITE_ANIM_INDEX_PC_QUICK
	const SPRITE_ANIM_INDEX_PC_MODE
	const SPRITE_ANIM_INDEX_PC_MODE2
	const SPRITE_ANIM_INDEX_PC_PACK
	const SPRITE_ANIM_INDEX_DEX_CURSOR
	const SPRITE_ANIM_INDEX_DEX_UNOWN
NUM_SPRITE_ANIM_INDEXES EQU const_value

; DoAnimFrame.Jumptable indexes (see engine/gfx/sprite_anims.asm)
	const_def
	const SPRITE_ANIM_SEQ_NULL
	const SPRITE_ANIM_SEQ_PARTY_MON
	const SPRITE_ANIM_SEQ_PARTY_MON_SWITCH
	const SPRITE_ANIM_SEQ_PARTY_MON_SELECTED
	const SPRITE_ANIM_SEQ_NAMING_SCREEN_CURSOR
	const SPRITE_ANIM_SEQ_COMPOSE_MAIL_CURSOR
	const SPRITE_ANIM_SEQ_GAMEFREAK_LOGO
	const SPRITE_ANIM_SEQ_SLOTS_GOLEM
	const SPRITE_ANIM_SEQ_SLOTS_CHANSEY
	const SPRITE_ANIM_SEQ_SLOTS_EGG
;	const SPRITE_ANIM_SEQ_MEMORY_GAME_CURSOR
	const SPRITE_ANIM_SEQ_POKEGEAR_MODE_ARROW
	const SPRITE_ANIM_SEQ_TRADE_POKE_BALL
	const SPRITE_ANIM_SEQ_TRADE_TUBE_BULGE
	const SPRITE_ANIM_SEQ_TRADEMON_IN_TUBE
	const SPRITE_ANIM_SEQ_REVEAL_NEW_MON
	const SPRITE_ANIM_SEQ_RADIO_TUNING_KNOB
	const SPRITE_ANIM_SEQ_CUT_GRASS_LEAVES
	const SPRITE_ANIM_SEQ_FLY_FROM
	const SPRITE_ANIM_SEQ_FLY_LEAF
	const SPRITE_ANIM_SEQ_FLY_TO
	const SPRITE_ANIM_SEQ_INTRO_SUICUNE
	const SPRITE_ANIM_SEQ_PICHU_WOOPER
	const SPRITE_ANIM_SEQ_UNOWN
	const SPRITE_ANIM_SEQ_UNOWN_F
	const SPRITE_ANIM_SEQ_SUICUNE_AWAY
	const SPRITE_ANIM_SEQ_CELEBI
	const SPRITE_ANIM_SEQ_MAX_STAT_SPARKLE
	const SPRITE_ANIM_SEQ_PC_CURSOR
	const SPRITE_ANIM_SEQ_PC_QUICK
	const SPRITE_ANIM_SEQ_PC_MODE
	const SPRITE_ANIM_SEQ_PC_PACK
	const SPRITE_ANIM_SEQ_DEX_CURSOR
NUM_SPRITE_ANIM_SEQS EQU const_value

; SpriteAnimFrameData indexes (see data/sprite_anims/framesets.asm)
	const_def
	const SPRITE_ANIM_FRAMESET_NULL
	const SPRITE_ANIM_FRAMESET_PARTY_MON
	const SPRITE_ANIM_FRAMESET_PARTY_MON_WITH_MAIL
	const SPRITE_ANIM_FRAMESET_PARTY_MON_WITH_ITEM
	const SPRITE_ANIM_FRAMESET_PARTY_MON_FAST
	const SPRITE_ANIM_FRAMESET_PARTY_MON_WITH_MAIL_FAST
	const SPRITE_ANIM_FRAMESET_PARTY_MON_WITH_ITEM_FAST
	const SPRITE_ANIM_FRAMESET_TEXT_ENTRY_CURSOR
	const SPRITE_ANIM_FRAMESET_TEXT_ENTRY_CURSOR_BIG
	const SPRITE_ANIM_FRAMESET_GAMEFREAK_LOGO
	const SPRITE_ANIM_FRAMESET_SLOTS_GOLEM
	const SPRITE_ANIM_FRAMESET_SLOTS_CHANSEY
	const SPRITE_ANIM_FRAMESET_SLOTS_CHANSEY_2
	const SPRITE_ANIM_FRAMESET_SLOTS_EGG
	const SPRITE_ANIM_FRAMESET_RED_WALK
	const SPRITE_ANIM_FRAMESET_STILL_CURSOR
	const SPRITE_ANIM_FRAMESET_TRADE_POKE_BALL
	const SPRITE_ANIM_FRAMESET_TRADE_POKE_BALL_0
	const SPRITE_ANIM_FRAMESET_TRADE_POOF
	const SPRITE_ANIM_FRAMESET_TRADE_TUBE_BULGE
	const SPRITE_ANIM_FRAMESET_TRADEMON_ICON
	const SPRITE_ANIM_FRAMESET_TRADEMON_BUBBLE
	const SPRITE_ANIM_FRAMESET_EVOLUTION_BALL_OF_LIGHT
	const SPRITE_ANIM_FRAMESET_RADIO_TUNING_KNOB
	const SPRITE_ANIM_FRAMESET_MAGNET_TRAIN_RED
	const SPRITE_ANIM_FRAMESET_LEAF
	const SPRITE_ANIM_FRAMESET_CUT_TREE
	const SPRITE_ANIM_FRAMESET_EGG_CRACK
	const SPRITE_ANIM_FRAMESET_EGG_HATCH
	const SPRITE_ANIM_FRAMESET_EGG_HATCH_2
	const SPRITE_ANIM_FRAMESET_EGG_HATCH_3
	const SPRITE_ANIM_FRAMESET_EGG_HATCH_4
	const SPRITE_ANIM_FRAMESET_HEADBUTT
	const SPRITE_ANIM_FRAMESET_BLUE_WALK
	const SPRITE_ANIM_FRAMESET_MAGNET_TRAIN_BLUE
	const SPRITE_ANIM_FRAMESET_INTRO_SUICUNE
	const SPRITE_ANIM_FRAMESET_INTRO_SUICUNE_2
	const SPRITE_ANIM_FRAMESET_INTRO_PICHU
	const SPRITE_ANIM_FRAMESET_INTRO_WOOPER
	const SPRITE_ANIM_FRAMESET_INTRO_UNOWN_1
	const SPRITE_ANIM_FRAMESET_INTRO_UNOWN_2
	const SPRITE_ANIM_FRAMESET_INTRO_UNOWN_3
	const SPRITE_ANIM_FRAMESET_INTRO_UNOWN_4
	const SPRITE_ANIM_FRAMESET_INTRO_UNOWN_F_2
	const SPRITE_ANIM_FRAMESET_INTRO_SUICUNE_AWAY
	const SPRITE_ANIM_FRAMESET_INTRO_UNOWN_F
	const SPRITE_ANIM_FRAMESET_CELEBI_LEFT
	const SPRITE_ANIM_FRAMESET_CELEBI_RIGHT
	const SPRITE_ANIM_FRAMESET_MAX_STAT_SPARKLE
	const SPRITE_ANIM_FRAMESET_HYPER_TRAINED_STAT
	const SPRITE_ANIM_FRAMESET_PC_CURSOR
	const SPRITE_ANIM_FRAMESET_PC_QUICK
	const SPRITE_ANIM_FRAMESET_PC_MODE
	const SPRITE_ANIM_FRAMESET_PC_MODE2
	const SPRITE_ANIM_FRAMESET_PC_PACK
	const SPRITE_ANIM_FRAMESET_DEX_CURSOR
	const SPRITE_ANIM_FRAMESET_DEX_UNOWN
NUM_SPRITE_ANIM_FRAMESETS EQU const_value

; SpriteAnimOAMData indexes (see data/sprite_anims/oam.asm)
	const_def
	const SPRITE_ANIM_OAMSET_RED_WALK_1
	const SPRITE_ANIM_OAMSET_RED_WALK_2
	const SPRITE_ANIM_OAMSET_TEXT_ENTRY_CURSOR
	const SPRITE_ANIM_OAMSET_TEXT_ENTRY_CURSOR_BIG
	const SPRITE_ANIM_OAMSET_SLOTS_GOLEM_1
	const SPRITE_ANIM_OAMSET_SLOTS_GOLEM_2
	const SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_1
	const SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_2
	const SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_3
	const SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_4
	const SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_5
	const SPRITE_ANIM_OAMSET_SLOTS_EGG
	const SPRITE_ANIM_OAMSET_STILL_CURSOR
	const SPRITE_ANIM_OAMSET_TRADE_POKE_BALL_1
	const SPRITE_ANIM_OAMSET_TRADE_POKE_BALL_2
	const SPRITE_ANIM_OAMSET_TRADE_POOF_1
	const SPRITE_ANIM_OAMSET_TRADE_POOF_2
	const SPRITE_ANIM_OAMSET_TRADE_POOF_3
	const SPRITE_ANIM_OAMSET_TRADE_TUBE_BULGE_1
	const SPRITE_ANIM_OAMSET_TRADE_TUBE_BULGE_2
	const SPRITE_ANIM_OAMSET_TRADEMON_ICON_1
	const SPRITE_ANIM_OAMSET_TRADEMON_ICON_2
	const SPRITE_ANIM_OAMSET_TRADEMON_BUBBLE
	const SPRITE_ANIM_OAMSET_EVOLUTION_BALL_OF_LIGHT_1
	const SPRITE_ANIM_OAMSET_EVOLUTION_BALL_OF_LIGHT_2
	const SPRITE_ANIM_OAMSET_RADIO_TUNING_KNOB
	const SPRITE_ANIM_OAMSET_PARTY_MON_WITH_MAIL_1
	const SPRITE_ANIM_OAMSET_PARTY_MON_WITH_MAIL_2
	const SPRITE_ANIM_OAMSET_PARTY_MON_WITH_ITEM_1
	const SPRITE_ANIM_OAMSET_PARTY_MON_WITH_ITEM_2
	const SPRITE_ANIM_OAMSET_MAGNET_TRAIN_RED_1
	const SPRITE_ANIM_OAMSET_MAGNET_TRAIN_RED_2
	const SPRITE_ANIM_OAMSET_LEAF
	const SPRITE_ANIM_OAMSET_TREE_1
	const SPRITE_ANIM_OAMSET_CUT_TREE_2
	const SPRITE_ANIM_OAMSET_CUT_TREE_3
	const SPRITE_ANIM_OAMSET_CUT_TREE_4
	const SPRITE_ANIM_OAMSET_EGG_CRACK
	const SPRITE_ANIM_OAMSET_EGG_HATCH
	const SPRITE_ANIM_OAMSET_HEADBUTT_TREE_2
	const SPRITE_ANIM_OAMSET_BLUE_WALK_1
	const SPRITE_ANIM_OAMSET_BLUE_WALK_2
	const SPRITE_ANIM_OAMSET_MAGNET_TRAIN_BLUE_1
	const SPRITE_ANIM_OAMSET_MAGNET_TRAIN_BLUE_2
	const SPRITE_ANIM_OAMSET_INTRO_SUICUNE_1
	const SPRITE_ANIM_OAMSET_INTRO_SUICUNE_2
	const SPRITE_ANIM_OAMSET_INTRO_SUICUNE_3
	const SPRITE_ANIM_OAMSET_INTRO_SUICUNE_4
	const SPRITE_ANIM_OAMSET_INTRO_PICHU_1
	const SPRITE_ANIM_OAMSET_INTRO_PICHU_2
	const SPRITE_ANIM_OAMSET_INTRO_PICHU_3
	const SPRITE_ANIM_OAMSET_INTRO_WOOPER
	const SPRITE_ANIM_OAMSET_INTRO_UNOWN_1
	const SPRITE_ANIM_OAMSET_INTRO_UNOWN_2
	const SPRITE_ANIM_OAMSET_INTRO_UNOWN_3
	const SPRITE_ANIM_OAMSET_INTRO_UNOWN_F_2_1
	const SPRITE_ANIM_OAMSET_INTRO_UNOWN_F_2_2
	const SPRITE_ANIM_OAMSET_INTRO_UNOWN_F_2_3
	const SPRITE_ANIM_OAMSET_INTRO_UNOWN_F_2_4
	const SPRITE_ANIM_OAMSET_INTRO_UNOWN_F_2_5
	const SPRITE_ANIM_OAMSET_INTRO_SUICUNE_AWAY
	const SPRITE_ANIM_OAMSET_CELEBI_1
	const SPRITE_ANIM_OAMSET_CELEBI_2
	const SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_1
	const SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_2
	const SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_3
	const SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_4
	const SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_5
	const SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_6
	const SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_7
	const SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_8
	const SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_9
	const SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_10
	const SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_11
	const SPRITE_ANIM_OAMSET_MAX_STAT_SPARKLE
	const SPRITE_ANIM_OAMSET_HYPER_TRAINED_STAT
	const SPRITE_ANIM_OAMSET_PC_CURSOR
	const SPRITE_ANIM_OAMSET_PC_QUICK
	const SPRITE_ANIM_OAMSET_PC_MODE
	const SPRITE_ANIM_OAMSET_PC_MODE2
	const SPRITE_ANIM_OAMSET_PC_PACK
	const SPRITE_ANIM_OAMSET_DEX_CURSOR
	const SPRITE_ANIM_OAMSET_DEX_UNOWN
NUM_SPRITE_ANIM_OAMSETS EQU const_value
