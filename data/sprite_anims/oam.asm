MACRO spriteanimoam
; vtile offset, data pointer
	db \1
	dw \2
ENDM

SpriteAnimOAMData:
; entries correspond to SPRITE_ANIM_OAMSET_* constants (see constants/sprite_anim_constants.asm)
	table_width 3
	spriteanimoam $00, .OAMData_RedWalk                ; SPRITE_ANIM_OAMSET_RED_WALK_1
	spriteanimoam $04, .OAMData_RedWalk                ; SPRITE_ANIM_OAMSET_RED_WALK_2
	spriteanimoam $00, .OAMData_TextEntryCursor        ; SPRITE_ANIM_OAMSET_TEXT_ENTRY_CURSOR
	spriteanimoam $00, .OAMData_TextEntryCursorBig     ; SPRITE_ANIM_OAMSET_TEXT_ENTRY_CURSOR_BIG
	spriteanimoam $00, .OAMData_TextEntryCursorBlue    ; SPRITE_ANIM_OAMSET_TEXT_ENTRY_CURSOR_BLUE
	spriteanimoam $00, .OAMData_TextEntryCursorBlueBig ; SPRITE_ANIM_OAMSET_TEXT_ENTRY_CURSOR_BLUE_BIG
	spriteanimoam $00, .OAMData_SlotsGolem             ; SPRITE_ANIM_OAMSET_SLOTS_GOLEM_1
	spriteanimoam $08, .OAMData_SlotsGolem             ; SPRITE_ANIM_OAMSET_SLOTS_GOLEM_2
	spriteanimoam $10, .OAMData_SlotsChansey1          ; SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_1
	spriteanimoam $10, .OAMData_SlotsChansey2          ; SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_2
	spriteanimoam $10, .OAMData_SlotsChansey3          ; SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_3
	spriteanimoam $10, .OAMData_SlotsChansey4          ; SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_4
	spriteanimoam $10, .OAMData_SlotsChansey5          ; SPRITE_ANIM_OAMSET_SLOTS_CHANSEY_5
	spriteanimoam $3a, .OAMData_1x1_Palette0           ; SPRITE_ANIM_OAMSET_SLOTS_EGG
	spriteanimoam $00, .OAMData_RedWalk                ; SPRITE_ANIM_OAMSET_STILL_CURSOR
	spriteanimoam $00, .OAMData_TradePokeBall1         ; SPRITE_ANIM_OAMSET_TRADE_POKE_BALL_1
	spriteanimoam $02, .OAMData_MagnetTrain            ; SPRITE_ANIM_OAMSET_TRADE_POKE_BALL_2
	spriteanimoam $06, .OAMData_TradePoofBubble        ; SPRITE_ANIM_OAMSET_TRADE_POOF_1
	spriteanimoam $0a, .OAMData_TradePoofBubble        ; SPRITE_ANIM_OAMSET_TRADE_POOF_2
	spriteanimoam $0e, .OAMData_TradePoofBubble        ; SPRITE_ANIM_OAMSET_TRADE_POOF_3
	spriteanimoam $12, .OAMData_TradeTubeBulge         ; SPRITE_ANIM_OAMSET_TRADE_TUBE_BULGE_1
	spriteanimoam $13, .OAMData_TradeTubeBulge         ; SPRITE_ANIM_OAMSET_TRADE_TUBE_BULGE_2
	spriteanimoam $00, .OAMData_TradeMonIcon           ; SPRITE_ANIM_OAMSET_TRADEMON_ICON_1
	spriteanimoam $04, .OAMData_TradeMonIcon           ; SPRITE_ANIM_OAMSET_TRADEMON_ICON_2
	spriteanimoam $10, .OAMData_TradePoofBubble        ; SPRITE_ANIM_OAMSET_TRADEMON_BUBBLE
	spriteanimoam $00, .OAMData_MagnetTrain            ; SPRITE_ANIM_OAMSET_EVOLUTION_BALL_OF_LIGHT_1
	spriteanimoam $04, .OAMData_1x1_Palette0           ; SPRITE_ANIM_OAMSET_EVOLUTION_BALL_OF_LIGHT_2
	spriteanimoam $00, .OAMData_RadioTuningKnob        ; SPRITE_ANIM_OAMSET_RADIO_TUNING_KNOB
	spriteanimoam $00, .OAMData_PartyMonWithMail1      ; SPRITE_ANIM_OAMSET_PARTY_MON_WITH_MAIL_1
	spriteanimoam $00, .OAMData_PartyMonWithMail2      ; SPRITE_ANIM_OAMSET_PARTY_MON_WITH_MAIL_2
	spriteanimoam $00, .OAMData_PartyMonWithItem1      ; SPRITE_ANIM_OAMSET_PARTY_MON_WITH_ITEM_1
	spriteanimoam $00, .OAMData_PartyMonWithItem2      ; SPRITE_ANIM_OAMSET_PARTY_MON_WITH_ITEM_2
	spriteanimoam $00, .OAMData_MagnetTrain            ; SPRITE_ANIM_OAMSET_MAGNET_TRAIN_1
	spriteanimoam $04, .OAMData_MagnetTrain            ; SPRITE_ANIM_OAMSET_MAGNET_TRAIN_2
	spriteanimoam $00, .OAMData_Leaf                   ; SPRITE_ANIM_OAMSET_LEAF
	spriteanimoam $00, .OAMData_Tree                   ; SPRITE_ANIM_OAMSET_TREE_1
	spriteanimoam $00, .OAMData_CutTree2               ; SPRITE_ANIM_OAMSET_CUT_TREE_2
	spriteanimoam $00, .OAMData_CutTree3               ; SPRITE_ANIM_OAMSET_CUT_TREE_3
	spriteanimoam $00, .OAMData_CutTree4               ; SPRITE_ANIM_OAMSET_CUT_TREE_4
	spriteanimoam $00, .OAMData_1x1_Palette0           ; SPRITE_ANIM_OAMSET_EGG_CRACK
	spriteanimoam $01, .OAMData_1x1_Palette0           ; SPRITE_ANIM_OAMSET_EGG_HATCH
	spriteanimoam $04, .OAMData_Tree                   ; SPRITE_ANIM_OAMSET_HEADBUTT_TREE_2
	spriteanimoam $08, .OAMData_Tree                   ; SPRITE_ANIM_OAMSET_HEADBUTT_TREE_3
	spriteanimoam $00, .OAMData_BlueWalk               ; SPRITE_ANIM_OAMSET_BLUE_WALK_1
	spriteanimoam $04, .OAMData_BlueWalk               ; SPRITE_ANIM_OAMSET_BLUE_WALK_2
	spriteanimoam $00, .OAMData_IntroSuicune1          ; SPRITE_ANIM_OAMSET_INTRO_SUICUNE_1
	spriteanimoam $08, .OAMData_IntroSuicune2          ; SPRITE_ANIM_OAMSET_INTRO_SUICUNE_2
	spriteanimoam $60, .OAMData_IntroSuicune3          ; SPRITE_ANIM_OAMSET_INTRO_SUICUNE_3
	spriteanimoam $68, .OAMData_IntroSuicune4          ; SPRITE_ANIM_OAMSET_INTRO_SUICUNE_4
	spriteanimoam $00, .OAMData_IntroPichu             ; SPRITE_ANIM_OAMSET_INTRO_PICHU_1
	spriteanimoam $05, .OAMData_IntroPichu             ; SPRITE_ANIM_OAMSET_INTRO_PICHU_2
	spriteanimoam $0a, .OAMData_IntroPichu             ; SPRITE_ANIM_OAMSET_INTRO_PICHU_3
	spriteanimoam $50, .OAMData_IntroWooper            ; SPRITE_ANIM_OAMSET_INTRO_WOOPER
	spriteanimoam $00, .OAMData_IntroUnown1            ; SPRITE_ANIM_OAMSET_INTRO_UNOWN_1
	spriteanimoam $01, .OAMData_IntroUnown2            ; SPRITE_ANIM_OAMSET_INTRO_UNOWN_2
	spriteanimoam $04, .OAMData_IntroUnown3            ; SPRITE_ANIM_OAMSET_INTRO_UNOWN_3
	spriteanimoam $00, .OAMData_IntroUnownF2_1         ; SPRITE_ANIM_OAMSET_INTRO_UNOWN_F_2_1
	spriteanimoam $01, .OAMData_IntroUnownF2_2         ; SPRITE_ANIM_OAMSET_INTRO_UNOWN_F_2_2
	spriteanimoam $03, .OAMData_IntroUnownF2_3         ; SPRITE_ANIM_OAMSET_INTRO_UNOWN_F_2_3
	spriteanimoam $08, .OAMData_IntroUnownF2_4_5       ; SPRITE_ANIM_OAMSET_INTRO_UNOWN_F_2_4
	spriteanimoam $1c, .OAMData_IntroUnownF2_4_5       ; SPRITE_ANIM_OAMSET_INTRO_UNOWN_F_2_5
	spriteanimoam $80, .OAMData_IntroSuicuneAway       ; SPRITE_ANIM_OAMSET_INTRO_SUICUNE_AWAY
	spriteanimoam $00, .OAMData_Celebi                 ; SPRITE_ANIM_OAMSET_CELEBI_1
	spriteanimoam $04, .OAMData_Celebi                 ; SPRITE_ANIM_OAMSET_CELEBI_2
	spriteanimoam $d0, .OAMData_GameFreakLogo1_3       ; SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_1
	spriteanimoam $d3, .OAMData_GameFreakLogo1_3       ; SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_2
	spriteanimoam $d6, .OAMData_GameFreakLogo1_3       ; SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_3
	spriteanimoam $6c, .OAMData_GameFreakLogo4_11      ; SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_4
	spriteanimoam $68, .OAMData_GameFreakLogo4_11      ; SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_5
	spriteanimoam $64, .OAMData_GameFreakLogo4_11      ; SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_6
	spriteanimoam $60, .OAMData_GameFreakLogo4_11      ; SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_7
	spriteanimoam $0c, .OAMData_GameFreakLogo4_11      ; SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_8
	spriteanimoam $08, .OAMData_GameFreakLogo4_11      ; SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_9
	spriteanimoam $04, .OAMData_GameFreakLogo4_11      ; SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_10
	spriteanimoam $00, .OAMData_GameFreakLogo4_11      ; SPRITE_ANIM_OAMSET_GAMEFREAK_LOGO_11
	spriteanimoam $00, .OAMData_MaxStatSparkle         ; SPRITE_ANIM_OAMSET_MAX_STAT_SPARKLE
	spriteanimoam $00, .OAMData_HyperTrainedStat       ; SPRITE_ANIM_OAMSET_HYPER_TRAINED_STAT
	spriteanimoam $00, .OAMData_PcCursor               ; SPRITE_ANIM_OAMSET_PC_CURSOR
	spriteanimoam $00, .OAMData_PcCursorItem           ; SPRITE_ANIM_OAMSET_PC_CURSOR_ITEM
	spriteanimoam $00, .OAMData_PcQuick                ; SPRITE_ANIM_OAMSET_PC_QUICK
	spriteanimoam $00, .OAMData_PcMode                 ; SPRITE_ANIM_OAMSET_PC_MODE
	spriteanimoam $00, .OAMData_PcMode2                ; SPRITE_ANIM_OAMSET_PC_MODE2
	spriteanimoam $00, .OAMData_PcPack                 ; SPRITE_ANIM_OAMSET_PC_PACK
	spriteanimoam $00, .OAMData_DexCursor              ; SPRITE_ANIM_OAMSET_DEX_CURSOR
	spriteanimoam $1e, .OAMData_DexUnownCursor         ; SPRITE_ANIM_OAMSET_DEX_UNOWN_CURSOR
	spriteanimoam $40, .OAMData_DexSlowpoke            ; SPRITE_ANIM_OAMSET_DEX_SLOWPOKE_1
	spriteanimoam $43, .OAMData_DexSlowpoke            ; SPRITE_ANIM_OAMSET_DEX_SLOWPOKE_2
	spriteanimoam $46, .OAMData_DexSlowpoke            ; SPRITE_ANIM_OAMSET_DEX_SLOWPOKE_3
	spriteanimoam $49, .OAMData_DexSlowpoke            ; SPRITE_ANIM_OAMSET_DEX_SLOWPOKE_4
	spriteanimoam $4c, .OAMData_DexSlowpoke            ; SPRITE_ANIM_OAMSET_DEX_SLOWPOKE_5
	spriteanimoam $09, .OAMData_TownMapFly             ; SPRITE_ANIM_OAMSET_TOWN_MAP_FLY
	spriteanimoam $00, .OAMData_GreenWalk              ; SPRITE_ANIM_OAMSET_GREEN_WALK_1
	spriteanimoam $04, .OAMData_GreenWalk              ; SPRITE_ANIM_OAMSET_GREEN_WALK_2
	spriteanimoam $00, .OAMData_PartyMon               ; SPRITE_ANIM_OAMSET_PARTY_MON_1
	spriteanimoam $04, .OAMData_PartyMon               ; SPRITE_ANIM_OAMSET_PARTY_MON_2
	spriteanimoam $00, .OAMData_FlyMon                 ; SPRITE_ANIM_OAMSET_FLY_MON_1
	spriteanimoam $04, .OAMData_FlyMon                 ; SPRITE_ANIM_OAMSET_FLY_MON_2
	spriteanimoam $04, .OAMData_FlyMon2                ; SPRITE_ANIM_OAMSET_FLY_MON_3
	assert_table_length NUM_SPRITE_ANIM_OAMSETS

.OAMData_1x1_Palette0:
	db 1
	dsprite -1,  4, -1,  4, $00, $0

.OAMData_TradePokeBall1:
	db 4
	dsprite -1,  0, -1,  0, $00, $0 | OAM_PRIO
	dsprite -1,  0,  0,  0, $00, $0 | OAM_XFLIP | OAM_PRIO
	dsprite  0,  0, -1,  0, $01, $0 | OAM_PRIO
	dsprite  0,  0,  0,  0, $01, $0 | OAM_XFLIP | OAM_PRIO

.OAMData_IntroUnownF2_1:
	db 4
	dsprite -1,  0, -1,  0, $00, $0
	dsprite -1,  0,  0,  0, $00, $0 | OAM_XFLIP
	dsprite  0,  0, -1,  0, $00, $0 | OAM_YFLIP
	dsprite  0,  0,  0,  0, $00, $0 | OAM_XFLIP | OAM_YFLIP

.OAMData_TradeTubeBulge:
	db 4
	dsprite -1,  0, -1,  0, $00, $7
	dsprite -1,  0,  0,  0, $00, $7 | OAM_XFLIP
	dsprite  0,  0, -1,  0, $00, $7 | OAM_YFLIP
	dsprite  0,  0,  0,  0, $00, $7 | OAM_XFLIP | OAM_YFLIP

	db 4
	dsprite -1,  0, -1,  0, $00, $0 | OAM_PRIO
	dsprite -1,  0,  0,  0, $00, $0 | OAM_XFLIP | OAM_PRIO
	dsprite  0,  0, -1,  0, $00, $0 | OAM_YFLIP | OAM_PRIO
	dsprite  0,  0,  0,  0, $00, $0 | OAM_XFLIP | OAM_YFLIP | OAM_PRIO

.OAMData_TradePoofBubble:
	db 16
	dsprite -2,  0, -2,  0, $00, $0
	dsprite -2,  0, -1,  0, $01, $0
	dsprite -1,  0, -2,  0, $02, $0
	dsprite -1,  0, -1,  0, $03, $0
	dsprite -2,  0,  0,  0, $01, $0 | OAM_XFLIP
	dsprite -2,  0,  1,  0, $00, $0 | OAM_XFLIP
	dsprite -1,  0,  0,  0, $03, $0 | OAM_XFLIP
	dsprite -1,  0,  1,  0, $02, $0 | OAM_XFLIP
	dsprite  0,  0, -2,  0, $02, $0 | OAM_YFLIP
	dsprite  0,  0, -1,  0, $03, $0 | OAM_YFLIP
	dsprite  1,  0, -2,  0, $00, $0 | OAM_YFLIP
	dsprite  1,  0, -1,  0, $01, $0 | OAM_YFLIP
	dsprite  0,  0,  0,  0, $03, $0 | OAM_XFLIP | OAM_YFLIP
	dsprite  0,  0,  1,  0, $02, $0 | OAM_XFLIP | OAM_YFLIP
	dsprite  1,  0,  0,  0, $01, $0 | OAM_XFLIP | OAM_YFLIP
	dsprite  1,  0,  1,  0, $00, $0 | OAM_XFLIP | OAM_YFLIP

.OAMData_RedWalk:
	db 4
	dsprite -1,  0, -1,  0, $00, $0
	dsprite -1,  0,  0,  0, $01, $0
	dsprite  0,  0, -1,  0, $02, $0
	dsprite  0,  0,  0,  0, $03, $0

.OAMData_FlyMon:
	db 4
	dsprite -1,  0, -1,  0, $00, SPRITEOAM_SKIP_PAL_APPLY
	dsprite -1,  0,  0,  0, $01, SPRITEOAM_SKIP_PAL_APPLY
	dsprite  0,  0, -1,  0, $02, SPRITEOAM_SKIP_PAL_APPLY
	dsprite  0,  0,  0,  0, $03, SPRITEOAM_SKIP_PAL_APPLY

.OAMData_FlyMon2:
	db 4
	dsprite -1,  0, -1,  0, $00, SPRITEOAM_SKIP_PAL_APPLY_XFLIP
	dsprite -1,  0,  0,  0, $01, SPRITEOAM_SKIP_PAL_APPLY_XFLIP
	dsprite  0,  0, -1,  0, $02, SPRITEOAM_SKIP_PAL_APPLY_XFLIP
	dsprite  0,  0,  0,  0, $03, SPRITEOAM_SKIP_PAL_APPLY_XFLIP

.OAMData_TradeMonIcon:
	db 4
	dsprite -1,  0, -1,  0, $00, $1
	dsprite -1,  0,  0,  0, $01, $1
	dsprite  0,  0, -1,  0, $02, $1
	dsprite  0,  0,  0,  0, $03, $1

.OAMData_PartyMon:
	db 4
	dsprite -1,  0, -1,  0, $00, SPRITEOAM_SKIP_PAL_APPLY
	dsprite -1,  0,  0,  0, $01, SPRITEOAM_SKIP_PAL_APPLY
	dsprite  0,  0, -1,  0, $02, SPRITEOAM_SKIP_PAL_APPLY
	dsprite  0,  0,  0,  0, $03, SPRITEOAM_SKIP_PAL_APPLY

.OAMData_MagnetTrain:
	db 4
	dsprite -1,  0, -1,  0, $00, $0 | OAM_PRIO
	dsprite -1,  0,  0,  0, $01, $0 | OAM_PRIO
	dsprite  0,  0, -1,  0, $02, $0 | OAM_PRIO
	dsprite  0,  0,  0,  0, $03, $0 | OAM_PRIO

.OAMData_PartyMonWithMail1:
	db 4
	dsprite -1,  0, -1,  0, $00, SPRITEOAM_SKIP_PAL_APPLY
	dsprite -1,  0,  0,  0, $01, SPRITEOAM_SKIP_PAL_APPLY
	dsprite  0,  0, -1,  0, $08, $0
	dsprite  0,  0,  0,  0, $03, SPRITEOAM_SKIP_PAL_APPLY

.OAMData_PartyMonWithMail2:
	db 4
	dsprite -1,  0, -1,  0, $04, SPRITEOAM_SKIP_PAL_APPLY
	dsprite -1,  0,  0,  0, $05, SPRITEOAM_SKIP_PAL_APPLY
	dsprite  0,  0, -1,  0, $08, $0
	dsprite  0,  0,  0,  0, $07, SPRITEOAM_SKIP_PAL_APPLY

.OAMData_PartyMonWithItem1:
	db 4
	dsprite -1,  0, -1,  0, $00, SPRITEOAM_SKIP_PAL_APPLY
	dsprite -1,  0,  0,  0, $01, SPRITEOAM_SKIP_PAL_APPLY
	dsprite  0,  0, -1,  0, $09, $0
	dsprite  0,  0,  0,  0, $03, SPRITEOAM_SKIP_PAL_APPLY

.OAMData_PartyMonWithItem2:
	db 4
	dsprite -1,  0, -1,  0, $04, SPRITEOAM_SKIP_PAL_APPLY
	dsprite -1,  0,  0,  0, $05, SPRITEOAM_SKIP_PAL_APPLY
	dsprite  0,  0, -1,  0, $09, $0
	dsprite  0,  0,  0,  0, $07, SPRITEOAM_SKIP_PAL_APPLY

.OAMData_Leaf:
	db 1
	dsprite -1,  4, -1,  4, $00, $7

.OAMData_Tree:
	db 4
	dsprite -1,  0, -1,  0, $00, $7
	dsprite -1,  0,  0,  0, $01, $7
	dsprite  0,  0, -1,  0, $02, $7
	dsprite  0,  0,  0,  0, $03, $7

.OAMData_TextEntryCursor:
	db 4
	dsprite -1,  7, -1,  7, $00, $0
	dsprite -1,  7,  0,  0, $00, $0 | OAM_XFLIP
	dsprite  0,  0, -1,  7, $00, $0 | OAM_YFLIP
	dsprite  0,  0,  0,  0, $00, $0 | OAM_XFLIP | OAM_YFLIP

.OAMData_TextEntryCursorBig:
	db 10
	dsprite -1,  7,  0,  0, $00, $0
	dsprite -1,  7,  1,  0, $01, $0
	dsprite -1,  7,  2,  0, $01, $0
	dsprite -1,  7,  3,  0, $01, $0
	dsprite -1,  7,  4,  0, $00, $0 | OAM_XFLIP
	dsprite  0,  0,  0,  0, $00, $0 | OAM_YFLIP
	dsprite  0,  0,  1,  0, $01, $0 | OAM_YFLIP
	dsprite  0,  0,  2,  0, $01, $0 | OAM_YFLIP
	dsprite  0,  0,  3,  0, $01, $0 | OAM_YFLIP
	dsprite  0,  0,  4,  0, $00, $0 | OAM_XFLIP | OAM_YFLIP

.OAMData_TextEntryCursorBlue:
	db 4
	dsprite -1,  7, -1,  7, $00, $1
	dsprite -1,  7,  0,  0, $00, $1 | OAM_XFLIP
	dsprite  0,  0, -1,  7, $00, $1 | OAM_YFLIP
	dsprite  0,  0,  0,  0, $00, $1 | OAM_XFLIP | OAM_YFLIP

.OAMData_TextEntryCursorBlueBig:
	db 10
	dsprite -1,  7,  0,  0, $00, $1
	dsprite -1,  7,  1,  0, $01, $1
	dsprite -1,  7,  2,  0, $01, $1
	dsprite -1,  7,  3,  0, $01, $1
	dsprite -1,  7,  4,  0, $00, $1 | OAM_XFLIP
	dsprite  0,  0,  0,  0, $00, $1 | OAM_YFLIP
	dsprite  0,  0,  1,  0, $01, $1 | OAM_YFLIP
	dsprite  0,  0,  2,  0, $01, $1 | OAM_YFLIP
	dsprite  0,  0,  3,  0, $01, $1 | OAM_YFLIP
	dsprite  0,  0,  4,  0, $00, $1 | OAM_XFLIP | OAM_YFLIP

.OAMData_SlotsGolem:
	db 6
	dsprite -2,  4, -2,  4, $00, $5
	dsprite -2,  4, -1,  4, $02, $5
	dsprite -2,  4,  0,  4, $00, $5 | OAM_XFLIP
	dsprite  0,  4, -2,  4, $04, $5
	dsprite  0,  4, -1,  4, $06, $5
	dsprite  0,  4,  0,  4, $04, $5 | OAM_XFLIP

.OAMData_SlotsChansey1:
	db 6
	dsprite -2,  4, -2,  4, $00, $6
	dsprite -2,  4, -1,  4, $02, $6
	dsprite -2,  4,  0,  4, $04, $6
	dsprite  0,  4, -2,  4, $06, $6
	dsprite  0,  4, -1,  4, $08, $6
	dsprite  0,  4,  0,  4, $0a, $6

.OAMData_SlotsChansey2:
	db 6
	dsprite -2,  4, -2,  4, $00, $6
	dsprite -2,  4, -1,  4, $02, $6
	dsprite -2,  4,  0,  4, $04, $6
	dsprite  0,  4, -2,  4, $0c, $6
	dsprite  0,  4, -1,  4, $0e, $6
	dsprite  0,  4,  0,  4, $10, $6

.OAMData_SlotsChansey3:
	db 6
	dsprite -2,  4, -2,  4, $00, $6
	dsprite -2,  4, -1,  4, $02, $6
	dsprite -2,  4,  0,  4, $04, $6
	dsprite  0,  4, -2,  4, $12, $6
	dsprite  0,  4, -1,  4, $14, $6
	dsprite  0,  4,  0,  4, $16, $6

.OAMData_SlotsChansey4:
	db 6
	dsprite -2,  4, -2,  4, $00, $6
	dsprite -2,  4, -1,  4, $02, $6
	dsprite -2,  4,  0,  4, $04, $6
	dsprite  0,  4, -2,  4, $18, $6
	dsprite  0,  4, -1,  4, $1a, $6
	dsprite  0,  4,  0,  4, $1c, $6

.OAMData_SlotsChansey5:
	db 6
	dsprite -2,  4, -2,  4, $1e, $6
	dsprite -2,  4, -1,  4, $20, $6
	dsprite -2,  4,  0,  4, $22, $6
	dsprite  0,  4, -2,  4, $24, $6
	dsprite  0,  4, -1,  4, $26, $6
	dsprite  0,  4,  0,  4, $28, $6

.OAMData_RadioTuningKnob:
	db 3
	dsprite -2,  4, -1,  4, $00, $0
	dsprite -1,  4, -1,  4, $00, $0
	dsprite  0,  4, -1,  4, $00, $0

.OAMData_CutTree2:
	db 4
	dsprite -1,  0, -2,  6, $00, $7
	dsprite -1,  0,  0,  2, $01, $7
	dsprite  0,  0, -2,  6, $02, $7
	dsprite  0,  0,  0,  2, $03, $7

.OAMData_CutTree3:
	db 4
	dsprite -1,  0, -2,  4, $00, $7
	dsprite -1,  0,  0,  4, $01, $7
	dsprite  0,  0, -2,  4, $02, $7
	dsprite  0,  0,  0,  4, $03, $7

.OAMData_CutTree4:
	db 4
	dsprite -1,  0, -2,  0, $00, $7
	dsprite -1,  0,  1,  0, $01, $7
	dsprite  0,  0, -2,  0, $02, $7
	dsprite  0,  0,  1,  0, $03, $7

.OAMData_BlueWalk:
	db 4
	dsprite -1,  0, -1,  0, $00, $1
	dsprite -1,  0,  0,  0, $01, $1
	dsprite  0,  0, -1,  0, $02, $1
	dsprite  0,  0,  0,  0, $03, $1

.OAMData_IntroSuicune1:
	db 36
	dsprite -3,  0,  1,  0, $05, $0
	dsprite -3,  0,  2,  0, $06, $0
	dsprite -3,  0,  3,  0, $07, $0
	dsprite -2,  0, -3,  0, $11, $0
	dsprite -2,  0, -2,  0, $12, $0
	dsprite -2,  0, -1,  0, $13, $0
	dsprite -2,  0,  0,  0, $14, $0
	dsprite -2,  0,  1,  0, $15, $0
	dsprite -2,  0,  2,  0, $16, $0
	dsprite -2,  0,  3,  0, $17, $0
	dsprite -1,  0, -4,  0, $20, $0
	dsprite -1,  0, -3,  0, $21, $0
	dsprite -1,  0, -2,  0, $22, $0
	dsprite -1,  0, -1,  0, $23, $0
	dsprite -1,  0,  0,  0, $24, $0
	dsprite -1,  0,  1,  0, $25, $0
	dsprite -1,  0,  2,  0, $26, $0
	dsprite -1,  0,  3,  0, $27, $0
	dsprite  0,  0, -4,  0, $30, $0
	dsprite  0,  0, -3,  0, $31, $0
	dsprite  0,  0, -2,  0, $32, $0
	dsprite  0,  0, -1,  0, $33, $0
	dsprite  0,  0,  0,  0, $34, $0
	dsprite  0,  0,  1,  0, $35, $0
	dsprite  0,  0,  2,  0, $36, $0
	dsprite  1,  0, -4,  0, $40, $0
	dsprite  1,  0, -3,  0, $41, $0
	dsprite  1,  0, -2,  0, $42, $0
	dsprite  1,  0, -1,  0, $43, $0
	dsprite  1,  0,  0,  0, $44, $0
	dsprite  1,  0,  1,  0, $45, $0
	dsprite  1,  0,  2,  0, $46, $0
	dsprite  1,  0,  3,  0, $47, $0
	dsprite  2,  0, -4,  0, $50, $0
	dsprite  2,  0, -3,  0, $51, $0
	dsprite  2,  0,  3,  0, $57, $0

.OAMData_IntroSuicune2:
	db 28
	dsprite -3,  0,  0,  0, $04, $0
	dsprite -3,  0,  1,  0, $05, $0
	dsprite -3,  0,  2,  0, $06, $0
	dsprite -2,  0, -3,  0, $11, $0
	dsprite -2,  0, -2,  0, $12, $0
	dsprite -2,  0, -1,  0, $13, $0
	dsprite -2,  0,  0,  0, $14, $0
	dsprite -2,  0,  1,  0, $15, $0
	dsprite -2,  0,  2,  0, $16, $0
	dsprite -1,  0, -3,  0, $21, $0
	dsprite -1,  0, -2,  0, $22, $0
	dsprite -1,  0, -1,  0, $23, $0
	dsprite -1,  0,  0,  0, $24, $0
	dsprite -1,  0,  1,  0, $25, $0
	dsprite -1,  0,  2,  0, $26, $0
	dsprite  0,  0, -4,  0, $30, $0
	dsprite  0,  0, -3,  0, $31, $0
	dsprite  0,  0, -2,  0, $32, $0
	dsprite  0,  0, -1,  0, $33, $0
	dsprite  0,  0,  0,  0, $34, $0
	dsprite  0,  0,  1,  0, $35, $0
	dsprite  1,  0, -2,  0, $42, $0
	dsprite  1,  0, -1,  0, $43, $0
	dsprite  1,  0,  0,  0, $44, $0
	dsprite  1,  0,  1,  0, $45, $0
	dsprite  2,  0, -1,  0, $53, $0
	dsprite  2,  0,  0,  0, $54, $0
	dsprite  2,  0,  1,  0, $55, $0

.OAMData_IntroSuicune3:
	db 30
	dsprite -3,  0,  0,  0, $04, $0
	dsprite -3,  0,  1,  0, $05, $0
	dsprite -2,  0, -3,  0, $11, $0
	dsprite -2,  0, -2,  0, $12, $0
	dsprite -2,  0, -1,  0, $13, $0
	dsprite -2,  0,  0,  0, $14, $0
	dsprite -2,  0,  1,  0, $15, $0
	dsprite -2,  0,  2,  0, $16, $0
	dsprite -2,  0,  3,  0, $17, $0
	dsprite -1,  0, -4,  0, $20, $0
	dsprite -1,  0, -3,  0, $21, $0
	dsprite -1,  0, -2,  0, $22, $0
	dsprite -1,  0, -1,  0, $23, $0
	dsprite -1,  0,  0,  0, $24, $0
	dsprite -1,  0,  1,  0, $25, $0
	dsprite -1,  0,  2,  0, $26, $0
	dsprite  0,  0, -4,  0, $30, $0
	dsprite  0,  0, -3,  0, $31, $0
	dsprite  0,  0, -2,  0, $32, $0
	dsprite  0,  0, -1,  0, $33, $0
	dsprite  0,  0,  0,  0, $34, $0
	dsprite  0,  0,  1,  0, $35, $0
	dsprite  1,  0, -2,  0, $42, $0
	dsprite  1,  0, -1,  0, $43, $0
	dsprite  1,  0,  0,  0, $44, $0
	dsprite  1,  0,  1,  0, $45, $0
	dsprite  2,  0, -2,  0, $52, $0
	dsprite  2,  0, -1,  0, $53, $0
	dsprite  2,  0,  0,  0, $54, $0
	dsprite  2,  0,  1,  0, $55, $0

.OAMData_IntroSuicune4:
	db 31
	dsprite -2,  0, -3,  0, $11, $0
	dsprite -2,  0, -2,  0, $12, $0
	dsprite -2,  0, -1,  0, $13, $0
	dsprite -2,  0,  0,  0, $14, $0
	dsprite -2,  0,  1,  0, $15, $0
	dsprite -2,  0,  2,  0, $16, $0
	dsprite -2,  0,  3,  0, $17, $0
	dsprite -1,  0, -4,  0, $20, $0
	dsprite -1,  0, -3,  0, $21, $0
	dsprite -1,  0, -2,  0, $22, $0
	dsprite -1,  0, -1,  0, $23, $0
	dsprite -1,  0,  0,  0, $24, $0
	dsprite -1,  0,  1,  0, $25, $0
	dsprite -1,  0,  2,  0, $26, $0
	dsprite -1,  0,  3,  0, $27, $0
	dsprite  0,  0, -4,  0, $30, $0
	dsprite  0,  0, -3,  0, $31, $0
	dsprite  0,  0, -2,  0, $32, $0
	dsprite  0,  0, -1,  0, $33, $0
	dsprite  0,  0,  0,  0, $34, $0
	dsprite  0,  0,  1,  0, $35, $0
	dsprite  0,  0,  2,  0, $36, $0
	dsprite  1,  0, -3,  0, $41, $0
	dsprite  1,  0, -2,  0, $42, $0
	dsprite  1,  0, -1,  0, $43, $0
	dsprite  1,  0,  0,  0, $44, $0
	dsprite  1,  0,  1,  0, $45, $0
	dsprite  2,  0, -3,  0, $51, $0
	dsprite  2,  0, -2,  0, $52, $0
	dsprite  2,  0,  0,  0, $54, $0
	dsprite  2,  0,  1,  0, $55, $0

.OAMData_IntroPichu:
	db 25
	dsprite -3,  4, -3,  4, $00, $1 | OAM_BANK1
	dsprite -3,  4, -2,  4, $01, $1 | OAM_BANK1
	dsprite -3,  4, -1,  4, $02, $1 | OAM_BANK1
	dsprite -3,  4,  0,  4, $03, $1 | OAM_BANK1
	dsprite -3,  4,  1,  4, $04, $1 | OAM_BANK1
	dsprite -2,  4, -3,  4, $10, $1 | OAM_BANK1
	dsprite -2,  4, -2,  4, $11, $1 | OAM_BANK1
	dsprite -2,  4, -1,  4, $12, $1 | OAM_BANK1
	dsprite -2,  4,  0,  4, $13, $1 | OAM_BANK1
	dsprite -2,  4,  1,  4, $14, $1 | OAM_BANK1
	dsprite -1,  4, -3,  4, $20, $1 | OAM_BANK1
	dsprite -1,  4, -2,  4, $21, $1 | OAM_BANK1
	dsprite -1,  4, -1,  4, $22, $1 | OAM_BANK1
	dsprite -1,  4,  0,  4, $23, $1 | OAM_BANK1
	dsprite -1,  4,  1,  4, $24, $1 | OAM_BANK1
	dsprite  0,  4, -3,  4, $30, $1 | OAM_BANK1
	dsprite  0,  4, -2,  4, $31, $1 | OAM_BANK1
	dsprite  0,  4, -1,  4, $32, $1 | OAM_BANK1
	dsprite  0,  4,  0,  4, $33, $1 | OAM_BANK1
	dsprite  0,  4,  1,  4, $34, $1 | OAM_BANK1
	dsprite  1,  4, -3,  4, $40, $1 | OAM_BANK1
	dsprite  1,  4, -2,  4, $41, $1 | OAM_BANK1
	dsprite  1,  4, -1,  4, $42, $1 | OAM_BANK1
	dsprite  1,  4,  0,  4, $43, $1 | OAM_BANK1
	dsprite  1,  4,  1,  4, $44, $1 | OAM_BANK1

.OAMData_IntroWooper:
	db 16
	dsprite -2,  0, -3,  4, $00, $2 | OAM_BANK1
	dsprite -2,  0, -2,  4, $01, $2 | OAM_BANK1
	dsprite -2,  0, -1,  4, $02, $2 | OAM_BANK1
	dsprite -2,  0,  0,  4, $03, $2 | OAM_BANK1
	dsprite -1,  0, -3,  4, $04, $2 | OAM_BANK1
	dsprite -1,  0, -2,  4, $05, $2 | OAM_BANK1
	dsprite -1,  0, -1,  4, $06, $2 | OAM_BANK1
	dsprite -1,  0,  0,  4, $07, $2 | OAM_BANK1
	dsprite  0,  0, -3,  4, $08, $2 | OAM_BANK1
	dsprite  0,  0, -2,  4, $09, $2 | OAM_BANK1
	dsprite  0,  0, -1,  4, $0a, $2 | OAM_BANK1
	dsprite  0,  0,  0,  4, $0b, $2 | OAM_BANK1
	dsprite  1,  0, -3,  4, $0c, $2 | OAM_BANK1
	dsprite  1,  0, -2,  4, $0d, $2 | OAM_BANK1
	dsprite  1,  0, -1,  4, $0e, $2 | OAM_BANK1
	dsprite  1,  0,  0,  4, $0f, $2 | OAM_BANK1

.OAMData_IntroUnown1:
	db 1
	dsprite -1,  4, -1,  4, $00, $0

.OAMData_IntroUnown2:
	db 3
	dsprite  0,  0, -1,  0, $00, $0
	dsprite -1,  0, -1,  0, $01, $0
	dsprite -1,  0,  0,  0, $02, $0

.OAMData_IntroUnown3:
	db 7
	dsprite  1,  0, -2,  0, $00, $0
	dsprite  0,  0, -2,  0, $01, $0
	dsprite -1,  0, -2,  0, $02, $0
	dsprite -1,  0, -1,  0, $03, $0
	dsprite -2,  0, -1,  0, $04, $0
	dsprite -2,  0,  0,  0, $05, $0
	dsprite -2,  0,  1,  0, $06, $0

.OAMData_IntroUnownF2_2:
	db 8
	dsprite -1,  0, -2,  0, $00, $0
	dsprite -1,  0, -1,  0, $01, $0
	dsprite -1,  0,  0,  0, $01, $0 | OAM_XFLIP
	dsprite -1,  0,  1,  0, $00, $0 | OAM_XFLIP
	dsprite  0,  0, -2,  0, $00, $0 | OAM_YFLIP
	dsprite  0,  0, -1,  0, $01, $0 | OAM_YFLIP
	dsprite  0,  0,  0,  0, $01, $0 | OAM_XFLIP | OAM_YFLIP
	dsprite  0,  0,  1,  0, $00, $0 | OAM_XFLIP | OAM_YFLIP

.OAMData_IntroUnownF2_3:
	db 12
	dsprite -3,  0, -1,  0, $00, $0
	dsprite -2,  0, -1,  0, $01, $0
	dsprite -1,  0, -1,  0, $02, $0
	dsprite -3,  0,  0,  0, $00, $0 | OAM_XFLIP
	dsprite -2,  0,  0,  0, $01, $0 | OAM_XFLIP
	dsprite -1,  0,  0,  0, $02, $0 | OAM_XFLIP
	dsprite  0,  0, -1,  0, $02, $0 | OAM_YFLIP
	dsprite  1,  0, -1,  0, $01, $0 | OAM_YFLIP
	dsprite  2,  0, -1,  0, $00, $0 | OAM_YFLIP
	dsprite  0,  0,  0,  0, $02, $0 | OAM_XFLIP | OAM_YFLIP
	dsprite  1,  0,  0,  0, $01, $0 | OAM_XFLIP | OAM_YFLIP
	dsprite  2,  0,  0,  0, $00, $0 | OAM_XFLIP | OAM_YFLIP

.OAMData_IntroUnownF2_4_5:
	db 20
	dsprite -3,  4, -2,  0, $00, $0
	dsprite -3,  4, -1,  0, $01, $0
	dsprite -3,  4,  0,  0, $02, $0
	dsprite -3,  4,  1,  0, $03, $0
	dsprite -2,  4, -2,  0, $04, $0
	dsprite -2,  4, -1,  0, $05, $0
	dsprite -2,  4,  0,  0, $06, $0
	dsprite -2,  4,  1,  0, $07, $0
	dsprite -1,  4, -2,  0, $08, $0
	dsprite -1,  4, -1,  0, $09, $0
	dsprite -1,  4,  0,  0, $0a, $0
	dsprite -1,  4,  1,  0, $0b, $0
	dsprite  0,  4, -2,  0, $0c, $0
	dsprite  0,  4, -1,  0, $0d, $0
	dsprite  0,  4,  0,  0, $0e, $0
	dsprite  0,  4,  1,  0, $0f, $0
	dsprite  1,  4, -2,  0, $10, $0
	dsprite  1,  4, -1,  0, $11, $0
	dsprite  1,  4,  0,  0, $12, $0
	dsprite  1,  4,  1,  0, $13, $0

.OAMData_IntroSuicuneAway:
	db 20
	dsprite  0,  0,   1,  0, $00, $1 | OAM_PRIO
	dsprite  1,  0,   2,  0, $00, $1 | OAM_PRIO
	dsprite  2,  0,   3,  0, $00, $1 | OAM_PRIO
	dsprite  3,  0,   4,  0, $00, $1 | OAM_PRIO
	dsprite  4,  0,   5,  0, $00, $1 | OAM_PRIO
	dsprite  3,  0,   6,  0, $00, $1 | OAM_PRIO
	dsprite  2,  0,   7,  0, $00, $1 | OAM_PRIO
	dsprite  1,  0,   8,  0, $00, $1 | OAM_PRIO
	dsprite  0,  0,   9,  0, $00, $1 | OAM_PRIO
	dsprite  1,  0,  10,  0, $00, $1 | OAM_PRIO
	dsprite  2,  0,  11,  0, $00, $1 | OAM_PRIO
	dsprite  3,  0,  12,  0, $00, $1 | OAM_PRIO
	dsprite  4,  0,  13,  0, $00, $1 | OAM_PRIO
	dsprite  3,  0,  14,  0, $00, $1 | OAM_PRIO
	dsprite  2,  0,  15,  0, $00, $1 | OAM_PRIO
	dsprite  1,  0,  16,  0, $00, $1 | OAM_PRIO
	dsprite  0,  0, -15,  0, $00, $1 | OAM_PRIO
	dsprite  1,  0, -14,  0, $00, $1 | OAM_PRIO
	dsprite  2,  0, -13,  0, $00, $1 | OAM_PRIO
	dsprite  3,  0, -12,  0, $00, $1 | OAM_PRIO

.OAMData_Celebi:
	db 4
	dsprite -1,  0, -1,  0, $00, $7
	dsprite -1,  0,  0,  0, $01, $7
	dsprite  0,  0, -1,  0, $02, $7
	dsprite  0,  0,  0,  0, $03, $7

.OAMData_GameFreakLogo1_3:
	db 9
	dsprite -2,  0, -2,  4, $00, $1
	dsprite -2,  0, -1,  4, $01, $1
	dsprite -2,  0,  0,  4, $02, $1
	dsprite -1,  0, -2,  4, $10, $1
	dsprite -1,  0, -1,  4, $11, $1
	dsprite -1,  0,  0,  4, $12, $1
	dsprite  0,  0, -2,  4, $20, $1
	dsprite  0,  0, -1,  4, $21, $1
	dsprite  0,  0,  0,  4, $22, $1

.OAMData_GameFreakLogo4_11:
	db 24
	dsprite -5,  0, -2,  4, $00, $1
	dsprite -5,  0, -1,  4, $01, $1
	dsprite -5,  0,  0,  4, $02, $1
	dsprite -5,  0,  1,  4, $03, $1
	dsprite -4,  0, -2,  4, $10, $1
	dsprite -4,  0, -1,  4, $11, $1
	dsprite -4,  0,  0,  4, $12, $1
	dsprite -4,  0,  1,  4, $13, $1
	dsprite -3,  0, -2,  4, $20, $1
	dsprite -3,  0, -1,  4, $21, $1
	dsprite -3,  0,  0,  4, $22, $1
	dsprite -3,  0,  1,  4, $23, $1
	dsprite -2,  0, -2,  4, $30, $1
	dsprite -2,  0, -1,  4, $31, $1
	dsprite -2,  0,  0,  4, $32, $1
	dsprite -2,  0,  1,  4, $33, $1
	dsprite -1,  0, -2,  4, $40, $1
	dsprite -1,  0, -1,  4, $41, $1
	dsprite -1,  0,  0,  4, $42, $1
	dsprite -1,  0,  1,  4, $43, $1
	dsprite  0,  0, -2,  4, $50, $1
	dsprite  0,  0, -1,  4, $51, $1
	dsprite  0,  0,  0,  4, $52, $1
	dsprite  0,  0,  1,  4, $53, $1

.OAMData_MaxStatSparkle:
	db 1
	dsprite  2,  0,  2,  0, $00, $0 | OAM_BANK1

.OAMData_HyperTrainedStat:
	db 1
	dsprite  2,  0,  2,  0, $01, $1 | OAM_BANK1

.OAMData_PcCursor:
	db 12
	; Cursor
	dsprite  0,  0,  0,  0, $04, $1 | OAM_BANK1
	dsprite  0,  0,  1,  0, $04, $2 | OAM_BANK1 | OAM_XFLIP
	dsprite  1,  0,  0,  0, $05, $1 | OAM_BANK1
	dsprite  1,  0,  1,  0, $05, $2 | OAM_BANK1 | OAM_XFLIP

	; Mini
	dsprite  1,  2,  0,  0, $08, $3 | OAM_BANK1
	dsprite  1,  2,  1,  0, $09, $3 | OAM_BANK1
	dsprite  2,  2,  0,  0, $0a, $3 | OAM_BANK1
	dsprite  2,  2,  1,  0, $0b, $3 | OAM_BANK1

	; Mini shadow
	dsprite  1,  2,  0,  0, $0c, $6 | OAM_BANK1
	dsprite  1,  2,  1,  0, $0d, $6 | OAM_BANK1
	dsprite  2,  2,  0,  0, $0e, $6 | OAM_BANK1
	dsprite  2,  2,  1,  0, $0f, $6 | OAM_BANK1

.OAMData_PcCursorItem:
	db 5
	; Cursor
	dsprite  0,  0,  0,  0, $04, $1 | OAM_BANK1
	dsprite  0,  0,  1,  0, $04, $2 | OAM_BANK1 | OAM_XFLIP
	dsprite  1,  0,  0,  0, $05, $1 | OAM_BANK1
	dsprite  1,  0,  1,  0, $05, $2 | OAM_BANK1 | OAM_XFLIP

	; Item
	dsprite  2,  0,  0,  4, $08, $0 | OAM_BANK1

.OAMData_PcQuick:
	db 8
	; Mini or item (only uses 1 sprite with the rest blank)
	dsprite  0,  0,  0,  0, $14, $5 | OAM_BANK1
	dsprite  0,  0,  1,  0, $15, $5 | OAM_BANK1
	dsprite  1,  0,  0,  0, $16, $5 | OAM_BANK1
	dsprite  1,  0,  1,  0, $17, $5 | OAM_BANK1

	; Mini shadow if applicable
	dsprite  0,  0,  0,  0, $18, $6 | OAM_BANK1
	dsprite  0,  0,  1,  0, $19, $6 | OAM_BANK1
	dsprite  1,  0,  0,  0, $1a, $6 | OAM_BANK1
	dsprite  1,  0,  1,  0, $1b, $6 | OAM_BANK1

.OAMData_PcMode:
	db 3
	dsprite  0,  0,  2,  0, $26, $2 | OAM_BANK1
	dsprite  0,  0,  3,  0, $27, $2 | OAM_BANK1
	dsprite  0,  0,  4,  0, $28, $2 | OAM_BANK1

.OAMData_PcMode2:
	db 2
	dsprite  0,  0,  0,  0, $24, $2 | OAM_BANK1
	dsprite  0,  0,  1,  0, $25, $2 | OAM_BANK1

.OAMData_PcPack:
	db 4
	dsprite  0,  0,  0,  0, $2f, $4 | OAM_BANK1
	dsprite  0,  0,  1,  0, $30, $4 | OAM_BANK1
	dsprite  1,  0,  0,  0, $31, $4 | OAM_BANK1
	dsprite  1,  0,  1,  0, $32, $4 | OAM_BANK1

.OAMData_DexCursor:
	db 12
	; top
	dsprite  0,  0,  0,  0, $01, $0
	dsprite  0,  0,  1,  0, $02, $0
	dsprite  0,  0,  2,  0, $02, $0
	dsprite  0,  0,  3, -1, $01, $0 | OAM_XFLIP
	; right
	dsprite  1,  0,  3, -1, $03, $0 | OAM_XFLIP
	dsprite  2,  0,  3, -1, $03, $0 | OAM_XFLIP
	; bottom
	dsprite  3,  0,  3, -1, $02, $0
	dsprite  3,  0,  2,  0, $02, $0
	dsprite  3,  0,  1,  0, $02, $0
	dsprite  3,  0,  0,  0, $02, $0
	; left
	dsprite  2,  0,  0,  0, $03, $0
	dsprite  1,  0,  0,  0, $03, $0

.OAMData_DexUnownCursor:
	db 4
	dsprite -1,  7, -1,  7, $00, $2
	dsprite -1,  7,  0,  0, $00, $2 | OAM_XFLIP
	dsprite  0,  0, -1,  7, $00, $2 | OAM_YFLIP
	dsprite  0,  0,  0,  0, $00, $2 | OAM_XFLIP | OAM_YFLIP

.OAMData_DexSlowpoke:
	db 9
	; top row
	dsprite  0,  0,  0,  0, $00, $0 | OAM_BANK1
	dsprite  0,  0,  1,  0, $01, $0 | OAM_BANK1
	dsprite  0,  0,  2,  0, $02, $0 | OAM_BANK1
	; middle
	dsprite  1,  0,  0,  0, $0f, $0 | OAM_BANK1
	dsprite  1,  0,  1,  0, $10, $0 | OAM_BANK1
	dsprite  1,  0,  2,  0, $11, $0 | OAM_BANK1
	; bottom
	dsprite  2,  0,  0,  0, $1e, $0 | OAM_BANK1
	dsprite  2,  0,  1,  0, $1f, $0 | OAM_BANK1
	dsprite  2,  0,  2,  0, $20, $0 | OAM_BANK1

.OAMData_TownMapFly:
	db 4
	dsprite  0,  0,  0,  0, $00, $3
	dsprite  0,  0,  1,  0, $01, $3
	dsprite  0,  0,  2,  0, $02, $3
	dsprite  0,  0,  3,  0, $03, $3

.OAMData_GreenWalk:
	db 4
	dsprite -1,  0, -1,  0, $00, $2
	dsprite -1,  0,  0,  0, $01, $2
	dsprite  0,  0, -1,  0, $02, $2
	dsprite  0,  0,  0,  0, $03, $2
