SpriteAnimFrameData: ; 8d6e6
	dw .Frameset_00 ; SPRITE_ANIM_FRAMESET_NULL
	dw .Frameset_01 ; SPRITE_ANIM_FRAMESET_PARTY_MON
	dw .Frameset_02 ; SPRITE_ANIM_FRAMESET_PARTY_MON_WITH_MAIL
	dw .Frameset_03 ; SPRITE_ANIM_FRAMESET_PARTY_MON_WITH_ITEM
	dw .Frameset_04 ; SPRITE_ANIM_FRAMESET_04
	dw .Frameset_05 ; SPRITE_ANIM_FRAMESET_05
	dw .Frameset_06 ; SPRITE_ANIM_FRAMESET_06
	dw .Frameset_07 ; SPRITE_ANIM_FRAMESET_07
	dw .Frameset_08 ; SPRITE_ANIM_FRAMESET_TEXT_ENTRY_CURSOR
	dw .Frameset_09 ; SPRITE_ANIM_FRAMESET_09
	dw .Frameset_0a ; SPRITE_ANIM_FRAMESET_GAMEFREAK_LOGO
	dw .Frameset_0b ; SPRITE_ANIM_FRAMESET_0B
	dw .Frameset_0c ; SPRITE_ANIM_FRAMESET_0C
	dw .Frameset_0d ; SPRITE_ANIM_FRAMESET_SLOTS_GOLEM
	dw .Frameset_0e ; SPRITE_ANIM_FRAMESET_SLOTS_CHANSEY
	dw .Frameset_0f ; SPRITE_ANIM_FRAMESET_SLOTS_CHANSEY_2
	dw .Frameset_10 ; SPRITE_ANIM_FRAMESET_SLOTS_EGG
	dw .Frameset_11 ; SPRITE_ANIM_FRAMESET_RED_WALK
	dw .Frameset_12 ; SPRITE_ANIM_FRAMESET_STILL_CURSOR
	dw .Frameset_13 ; SPRITE_ANIM_FRAMESET_TRADE_POKE_BALL
	dw .Frameset_14 ; SPRITE_ANIM_FRAMESET_TRADE_POKE_BALL_0
	dw .Frameset_15 ; SPRITE_ANIM_FRAMESET_TRADE_POOF
	dw .Frameset_16 ; SPRITE_ANIM_FRAMESET_TRADE_TUBE_BULGE
	dw .Frameset_17 ; SPRITE_ANIM_FRAMESET_TRADEMON_ICON
	dw .Frameset_18 ; SPRITE_ANIM_FRAMESET_TRADEMON_BUBBLE
	dw .Frameset_19 ; SPRITE_ANIM_FRAMESET_EVOLUTION_BALL_OF_LIGHT
	dw .Frameset_1a ; SPRITE_ANIM_FRAMESET_RADIO_TUNING_KNOB
	dw .Frameset_1b ; SPRITE_ANIM_FRAMESET_MAGNET_TRAIN_RED
	dw .Frameset_1c ; SPRITE_ANIM_FRAMESET_1C
	dw .Frameset_1d ; SPRITE_ANIM_FRAMESET_LEAF
	dw .Frameset_1e ; SPRITE_ANIM_FRAMESET_CUT_TREE
	dw .Frameset_1f ; SPRITE_ANIM_FRAMESET_EGG_CRACK
	dw .Frameset_20 ; SPRITE_ANIM_FRAMESET_EGG_HATCH
	dw .Frameset_21 ; SPRITE_ANIM_FRAMESET_21
	dw .Frameset_22 ; SPRITE_ANIM_FRAMESET_22
	dw .Frameset_23 ; SPRITE_ANIM_FRAMESET_23
	dw .Frameset_24 ; SPRITE_ANIM_FRAMESET_24
	dw .Frameset_25 ; SPRITE_ANIM_FRAMESET_HEADBUTT
	dw .Frameset_26 ; SPRITE_ANIM_FRAMESET_26
	dw .Frameset_27 ; SPRITE_ANIM_FRAMESET_27
	dw .Frameset_28 ; SPRITE_ANIM_FRAMESET_28
	dw .Frameset_29 ; SPRITE_ANIM_FRAMESET_29
	dw .Frameset_2a ; SPRITE_ANIM_FRAMESET_2A
	dw .Frameset_2b ; SPRITE_ANIM_FRAMESET_2B
	dw .Frameset_2c ; SPRITE_ANIM_FRAMESET_2C
	dw .Frameset_2d ; SPRITE_ANIM_FRAMESET_BLUE_WALK
	dw .Frameset_2e ; SPRITE_ANIM_FRAMESET_MAGNET_TRAIN_BLUE
	dw .Frameset_2f ; SPRITE_ANIM_FRAMESET_2F
	dw .Frameset_30 ; SPRITE_ANIM_FRAMESET_30
	dw .Frameset_31 ; SPRITE_ANIM_FRAMESET_31
	dw .Frameset_32 ; SPRITE_ANIM_FRAMESET_32
	dw .Frameset_33 ; SPRITE_ANIM_FRAMESET_33
	dw .Frameset_34 ; SPRITE_ANIM_FRAMESET_34
	dw .Frameset_35 ; SPRITE_ANIM_FRAMESET_INTRO_SUICUNE
	dw .Frameset_36 ; SPRITE_ANIM_FRAMESET_INTRO_SUICUNE_2
	dw .Frameset_37 ; SPRITE_ANIM_FRAMESET_INTRO_PICHU
	dw .Frameset_38 ; SPRITE_ANIM_FRAMESET_INTRO_WOOPER
	dw .Frameset_39 ; SPRITE_ANIM_FRAMESET_INTRO_UNOWN_1
	dw .Frameset_3a ; SPRITE_ANIM_FRAMESET_INTRO_UNOWN_2
	dw .Frameset_3b ; SPRITE_ANIM_FRAMESET_INTRO_UNOWN_3
	dw .Frameset_3c ; SPRITE_ANIM_FRAMESET_INTRO_UNOWN_4
	dw .Frameset_3d ; SPRITE_ANIM_FRAMESET_INTRO_UNOWN_F_2
	dw .Frameset_3e ; SPRITE_ANIM_FRAMESET_INTRO_SUICUNE_AWAY
	dw .Frameset_3f ; SPRITE_ANIM_FRAMESET_INTRO_UNOWN_F
	dw .Frameset_40 ; SPRITE_ANIM_FRAMESET_CELEBI_LEFT
	dw .Frameset_41 ; SPRITE_ANIM_FRAMESET_CELEBI_RIGHT
; 8d76a

; OAM idx (see SpriteAnimOAMData), flip flags/duration
.Frameset_00:
	frame SPRITE_ANIM_FRAME_IDX_00, 32
	endanim

.Frameset_01:
	frame SPRITE_ANIM_FRAME_IDX_00,  8
	frame SPRITE_ANIM_FRAME_IDX_01,  8
	dorestart

.Frameset_02:
	frame SPRITE_ANIM_FRAME_IDX_3D,  8
	frame SPRITE_ANIM_FRAME_IDX_3E,  8
	dorestart

.Frameset_03:
	frame SPRITE_ANIM_FRAME_IDX_3F,  8
	frame SPRITE_ANIM_FRAME_IDX_40,  8
	dorestart

.Frameset_04:
	frame SPRITE_ANIM_FRAME_IDX_00,  4
	frame SPRITE_ANIM_FRAME_IDX_01,  4
	dorestart

.Frameset_05:
	frame SPRITE_ANIM_FRAME_IDX_3D,  4
	frame SPRITE_ANIM_FRAME_IDX_3E,  4
	dorestart

.Frameset_06:
	frame SPRITE_ANIM_FRAME_IDX_3F,  4
	frame SPRITE_ANIM_FRAME_IDX_40,  4
	dorestart

.Frameset_11:
	frame SPRITE_ANIM_FRAME_IDX_37,  8
	frame SPRITE_ANIM_FRAME_IDX_38,  8
	frame SPRITE_ANIM_FRAME_IDX_37,  8
	frame SPRITE_ANIM_FRAME_IDX_38,  8, OAM_X_FLIP
	dorestart

.Frameset_2d:
	frame SPRITE_ANIM_FRAME_IDX_63,  8
	frame SPRITE_ANIM_FRAME_IDX_64,  8
	frame SPRITE_ANIM_FRAME_IDX_63,  8
	frame SPRITE_ANIM_FRAME_IDX_64,  8, OAM_X_FLIP
	dorestart

.Frameset_2e:
	frame SPRITE_ANIM_FRAME_IDX_65,  8
	frame SPRITE_ANIM_FRAME_IDX_66,  8
	frame SPRITE_ANIM_FRAME_IDX_65,  8
	frame SPRITE_ANIM_FRAME_IDX_66,  8, OAM_X_FLIP
	dorestart

.Frameset_07:
	frame SPRITE_ANIM_FRAME_IDX_1E,  1
	frame SPRITE_ANIM_FRAME_IDX_1F,  1
	dorestart

.Frameset_08:
	frame SPRITE_ANIM_FRAME_IDX_20,  1
	dorepeat  1
	dorestart

.Frameset_09:
	frame SPRITE_ANIM_FRAME_IDX_21,  1
	dorepeat  1
	dorestart

.Frameset_0a:
	frame SPRITE_ANIM_FRAME_IDX_81, 12
	frame SPRITE_ANIM_FRAME_IDX_82,  1
	frame SPRITE_ANIM_FRAME_IDX_83,  1
	frame SPRITE_ANIM_FRAME_IDX_82,  4
	frame SPRITE_ANIM_FRAME_IDX_81, 12
	frame SPRITE_ANIM_FRAME_IDX_82, 12
	frame SPRITE_ANIM_FRAME_IDX_83,  4
	frame SPRITE_ANIM_FRAME_IDX_84, 32
	frame SPRITE_ANIM_FRAME_IDX_85,  3
	frame SPRITE_ANIM_FRAME_IDX_86,  3
	frame SPRITE_ANIM_FRAME_IDX_87,  4
	frame SPRITE_ANIM_FRAME_IDX_88,  4
	frame SPRITE_ANIM_FRAME_IDX_89,  4
	frame SPRITE_ANIM_FRAME_IDX_8A, 10
	frame SPRITE_ANIM_FRAME_IDX_8B,  7
	endanim

.Frameset_0b:
	frame SPRITE_ANIM_FRAME_IDX_23,  3
	frame SPRITE_ANIM_FRAME_IDX_23,  3, OAM_Y_FLIP
	dorestart

.Frameset_0c:
	frame SPRITE_ANIM_FRAME_IDX_24,  2
	frame SPRITE_ANIM_FRAME_IDX_25,  2
	frame SPRITE_ANIM_FRAME_IDX_26,  2
	frame SPRITE_ANIM_FRAME_IDX_25,  2
	dorestart

.Frameset_0d:
	frame SPRITE_ANIM_FRAME_IDX_27,  7
	frame SPRITE_ANIM_FRAME_IDX_28,  7
	frame SPRITE_ANIM_FRAME_IDX_27,  7, OAM_Y_FLIP
	frame SPRITE_ANIM_FRAME_IDX_28,  7, OAM_X_FLIP
	dorestart

.Frameset_0e:
	frame SPRITE_ANIM_FRAME_IDX_29,  7
	frame SPRITE_ANIM_FRAME_IDX_2A,  7
	frame SPRITE_ANIM_FRAME_IDX_29,  7
	frame SPRITE_ANIM_FRAME_IDX_2B,  7
	dorestart

.Frameset_0f:
	frame SPRITE_ANIM_FRAME_IDX_29,  7
	frame SPRITE_ANIM_FRAME_IDX_2C,  7
	frame SPRITE_ANIM_FRAME_IDX_2D,  7
	frame SPRITE_ANIM_FRAME_IDX_2C,  7
	frame SPRITE_ANIM_FRAME_IDX_29,  7
	endanim

.Frameset_10:
	frame SPRITE_ANIM_FRAME_IDX_2E, 20
	endanim

.Frameset_12:
	frame SPRITE_ANIM_FRAME_IDX_2F, 32
	endanim

.Frameset_13:
	frame SPRITE_ANIM_FRAME_IDX_30, 32
	endanim

.Frameset_14:
	frame SPRITE_ANIM_FRAME_IDX_30,  3
	frame SPRITE_ANIM_FRAME_IDX_31,  3
	frame SPRITE_ANIM_FRAME_IDX_30,  3
	frame SPRITE_ANIM_FRAME_IDX_31,  3, OAM_X_FLIP
	dorestart

.Frameset_15:
	frame SPRITE_ANIM_FRAME_IDX_32,  4
	frame SPRITE_ANIM_FRAME_IDX_33,  4
	frame SPRITE_ANIM_FRAME_IDX_34,  4
	delanim

.Frameset_16:
	frame SPRITE_ANIM_FRAME_IDX_35,  3
	frame SPRITE_ANIM_FRAME_IDX_36,  3
	dorestart

.Frameset_17:
	frame SPRITE_ANIM_FRAME_IDX_37,  7
	frame SPRITE_ANIM_FRAME_IDX_38,  7
	dorestart

.Frameset_18:
	frame SPRITE_ANIM_FRAME_IDX_39, 32
	endanim

.Frameset_19:
	frame SPRITE_ANIM_FRAME_IDX_3B,  2
	frame SPRITE_ANIM_FRAME_IDX_3A,  2
	frame SPRITE_ANIM_FRAME_IDX_3B,  2
	endanim

.Frameset_1a:
	frame SPRITE_ANIM_FRAME_IDX_3C, 32
	endanim

.Frameset_1b:
	frame SPRITE_ANIM_FRAME_IDX_41,  8
	frame SPRITE_ANIM_FRAME_IDX_42,  8
	frame SPRITE_ANIM_FRAME_IDX_41,  8
	frame SPRITE_ANIM_FRAME_IDX_42,  8, OAM_X_FLIP
	dorestart

.Frameset_1c:
	dorepeat 32
	endanim

.Frameset_1d:
	frame SPRITE_ANIM_FRAME_IDX_4F, 32
	endanim

.Frameset_1e:
	frame SPRITE_ANIM_FRAME_IDX_50,  2
	frame SPRITE_ANIM_FRAME_IDX_51, 16
	dorepeat  1
	frame SPRITE_ANIM_FRAME_IDX_52,  1
	dorepeat  1
	frame SPRITE_ANIM_FRAME_IDX_53,  1
	delanim

.Frameset_1f:
	frame SPRITE_ANIM_FRAME_IDX_54, 32
	endanim

.Frameset_20:
	frame SPRITE_ANIM_FRAME_IDX_55, 32
	endanim

.Frameset_21:
	frame SPRITE_ANIM_FRAME_IDX_55, 32, OAM_X_FLIP
	endanim

.Frameset_22:
	frame SPRITE_ANIM_FRAME_IDX_55, 32, OAM_Y_FLIP
	endanim

.Frameset_23:
	frame SPRITE_ANIM_FRAME_IDX_55, 32, OAM_X_FLIP, OAM_Y_FLIP
	endanim

.Frameset_24:
	frame SPRITE_ANIM_FRAME_IDX_56, 10
	frame SPRITE_ANIM_FRAME_IDX_57,  9
	frame SPRITE_ANIM_FRAME_IDX_58, 10
	frame SPRITE_ANIM_FRAME_IDX_59, 10
	frame SPRITE_ANIM_FRAME_IDX_58,  9
	frame SPRITE_ANIM_FRAME_IDX_5A, 10
	dorestart

.Frameset_25:
	frame SPRITE_ANIM_FRAME_IDX_50,  2
	frame SPRITE_ANIM_FRAME_IDX_5B,  2
	frame SPRITE_ANIM_FRAME_IDX_50,  2
	frame SPRITE_ANIM_FRAME_IDX_5B,  2, OAM_X_FLIP
	dorestart

.Frameset_26:
	frame SPRITE_ANIM_FRAME_IDX_5C,  2
	endanim

.Frameset_27:
	frame SPRITE_ANIM_FRAME_IDX_5D,  2
	endanim

.Frameset_28:
	frame SPRITE_ANIM_FRAME_IDX_5E,  2
	endanim

.Frameset_29:
	frame SPRITE_ANIM_FRAME_IDX_5F,  2
	endanim

.Frameset_2a:
	frame SPRITE_ANIM_FRAME_IDX_60,  2
	endanim

.Frameset_2b:
	frame SPRITE_ANIM_FRAME_IDX_61,  2
	endanim

.Frameset_2c:
	frame SPRITE_ANIM_FRAME_IDX_62,  2
	endanim

.Frameset_2f:
	frame SPRITE_ANIM_FRAME_IDX_32,  3
	frame SPRITE_ANIM_FRAME_IDX_33,  3
	frame SPRITE_ANIM_FRAME_IDX_34,  3
	frame SPRITE_ANIM_FRAME_IDX_30,  3
	frame SPRITE_ANIM_FRAME_IDX_31,  3
	frame SPRITE_ANIM_FRAME_IDX_30,  3
	frame SPRITE_ANIM_FRAME_IDX_31,  3, OAM_X_FLIP
	frame SPRITE_ANIM_FRAME_IDX_30,  3
	frame SPRITE_ANIM_FRAME_IDX_31,  3
	frame SPRITE_ANIM_FRAME_IDX_30,  3
	frame SPRITE_ANIM_FRAME_IDX_31,  3, OAM_X_FLIP
	frame SPRITE_ANIM_FRAME_IDX_30,  3
	frame SPRITE_ANIM_FRAME_IDX_31,  3
	frame SPRITE_ANIM_FRAME_IDX_30,  3
	frame SPRITE_ANIM_FRAME_IDX_31,  3, OAM_X_FLIP
	endanim

.Frameset_30:
	frame SPRITE_ANIM_FRAME_IDX_30,  3
	frame SPRITE_ANIM_FRAME_IDX_31,  3
	frame SPRITE_ANIM_FRAME_IDX_30,  3
	frame SPRITE_ANIM_FRAME_IDX_31,  3, OAM_X_FLIP
	frame SPRITE_ANIM_FRAME_IDX_30,  3
	frame SPRITE_ANIM_FRAME_IDX_31,  3
	frame SPRITE_ANIM_FRAME_IDX_30,  3
	frame SPRITE_ANIM_FRAME_IDX_31,  3, OAM_X_FLIP
	frame SPRITE_ANIM_FRAME_IDX_30,  3
	frame SPRITE_ANIM_FRAME_IDX_31,  3
	frame SPRITE_ANIM_FRAME_IDX_30,  3
	frame SPRITE_ANIM_FRAME_IDX_31,  3, OAM_X_FLIP
	frame SPRITE_ANIM_FRAME_IDX_32,  3
	frame SPRITE_ANIM_FRAME_IDX_33,  3
	frame SPRITE_ANIM_FRAME_IDX_34,  3
	delanim

.Frameset_31:
	frame SPRITE_ANIM_FRAME_IDX_67,  3
	frame SPRITE_ANIM_FRAME_IDX_68,  3
	dorestart

.Frameset_32:
	frame SPRITE_ANIM_FRAME_IDX_6C,  3
	endanim

.Frameset_33:
	frame SPRITE_ANIM_FRAME_IDX_6D,  3
	endanim

.Frameset_34:
	frame SPRITE_ANIM_FRAME_IDX_69,  2
	frame SPRITE_ANIM_FRAME_IDX_6A,  2
	frame SPRITE_ANIM_FRAME_IDX_6B,  2
	delanim

.Frameset_35:
	frame SPRITE_ANIM_FRAME_IDX_6E,  3
	frame SPRITE_ANIM_FRAME_IDX_6F,  3
	frame SPRITE_ANIM_FRAME_IDX_70,  3
	frame SPRITE_ANIM_FRAME_IDX_71,  3
	dorestart

.Frameset_36:
	frame SPRITE_ANIM_FRAME_IDX_71,  3
	frame SPRITE_ANIM_FRAME_IDX_6E,  7
	endanim

.Frameset_37:
	frame SPRITE_ANIM_FRAME_IDX_72, 32
	frame SPRITE_ANIM_FRAME_IDX_73,  7
	frame SPRITE_ANIM_FRAME_IDX_74,  7
	endanim

.Frameset_38:
	frame SPRITE_ANIM_FRAME_IDX_75,  3
	endanim

.Frameset_39:
	frame SPRITE_ANIM_FRAME_IDX_76,  3
	frame SPRITE_ANIM_FRAME_IDX_77,  3
	frame SPRITE_ANIM_FRAME_IDX_78,  7
	delanim

.Frameset_3a:
	frame SPRITE_ANIM_FRAME_IDX_76,  3, OAM_X_FLIP
	frame SPRITE_ANIM_FRAME_IDX_77,  3, OAM_X_FLIP
	frame SPRITE_ANIM_FRAME_IDX_78,  7, OAM_X_FLIP
	delanim

.Frameset_3b:
	frame SPRITE_ANIM_FRAME_IDX_76,  3, OAM_Y_FLIP
	frame SPRITE_ANIM_FRAME_IDX_77,  3, OAM_Y_FLIP
	frame SPRITE_ANIM_FRAME_IDX_78,  7, OAM_Y_FLIP
	delanim

.Frameset_3c:
	frame SPRITE_ANIM_FRAME_IDX_76,  3, OAM_X_FLIP, OAM_Y_FLIP
	frame SPRITE_ANIM_FRAME_IDX_77,  3, OAM_X_FLIP, OAM_Y_FLIP
	frame SPRITE_ANIM_FRAME_IDX_78,  7, OAM_X_FLIP, OAM_Y_FLIP
	delanim

.Frameset_3d:
	frame SPRITE_ANIM_FRAME_IDX_79,  3
	frame SPRITE_ANIM_FRAME_IDX_7A,  3
	frame SPRITE_ANIM_FRAME_IDX_7B,  3
	frame SPRITE_ANIM_FRAME_IDX_7C,  7
	frame SPRITE_ANIM_FRAME_IDX_7D,  7
	endanim

.Frameset_3e:
	frame SPRITE_ANIM_FRAME_IDX_7E,  3
	endanim

.Frameset_3f:
	dorepeat 0
	endanim

.Frameset_40:
	frame SPRITE_ANIM_FRAME_IDX_7F,  8
	frame SPRITE_ANIM_FRAME_IDX_80,  8
	endanim

.Frameset_41:
	frame SPRITE_ANIM_FRAME_IDX_7F,  8, OAM_X_FLIP
	frame SPRITE_ANIM_FRAME_IDX_80,  8, OAM_X_FLIP
	endanim
; 8d94d

SpriteAnimOAMData: ; 8d94d
	; vtile offset, pointer
	dbw $00, .OAMData_85 ; SPRITE_ANIM_FRAME_IDX_00
	dbw $04, .OAMData_85 ; SPRITE_ANIM_FRAME_IDX_01
	dbw $4c, .OAMData_02 ; SPRITE_ANIM_FRAME_IDX_02
	dbw $5c, .OAMData_02 ; SPRITE_ANIM_FRAME_IDX_03
	dbw $6c, .OAMData_04 ; SPRITE_ANIM_FRAME_IDX_04
	dbw $6e, .OAMData_04 ; SPRITE_ANIM_FRAME_IDX_05
	dbw $2d, .OAMData_06 ; SPRITE_ANIM_FRAME_IDX_06
	dbw $4d, .OAMData_06 ; SPRITE_ANIM_FRAME_IDX_07
	dbw $60, .OAMData_08 ; SPRITE_ANIM_FRAME_IDX_08
	dbw $00, .OAMData_08 ; SPRITE_ANIM_FRAME_IDX_09
	dbw $00, .OAMData_08 ; SPRITE_ANIM_FRAME_IDX_0A
	dbw $06, .OAMData_08 ; SPRITE_ANIM_FRAME_IDX_0B
	dbw $0c, .OAMData_0c ; SPRITE_ANIM_FRAME_IDX_0C
	dbw $0d, .OAMData_02 ; SPRITE_ANIM_FRAME_IDX_0D
	dbw $00, .OAMData_0e ; SPRITE_ANIM_FRAME_IDX_0E
	dbw $04, .OAMData_0e ; SPRITE_ANIM_FRAME_IDX_0F
	dbw $08, .OAMData_0e ; SPRITE_ANIM_FRAME_IDX_10
	dbw $40, .OAMData_0e ; SPRITE_ANIM_FRAME_IDX_11
	dbw $44, .OAMData_0e ; SPRITE_ANIM_FRAME_IDX_12
	dbw $48, .OAMData_0e ; SPRITE_ANIM_FRAME_IDX_13
	dbw $4c, .OAMData_0e ; SPRITE_ANIM_FRAME_IDX_14
	dbw $80, .OAMData_15 ; SPRITE_ANIM_FRAME_IDX_15
	dbw $85, .OAMData_15 ; SPRITE_ANIM_FRAME_IDX_16
	dbw $8a, .OAMData_15 ; SPRITE_ANIM_FRAME_IDX_17
	dbw $00, .OAMData_18 ; SPRITE_ANIM_FRAME_IDX_18
	dbw $01, .OAMData_19 ; SPRITE_ANIM_FRAME_IDX_19
	dbw $09, .OAMData_1a ; SPRITE_ANIM_FRAME_IDX_1A
	dbw $10, .OAMData_1b ; SPRITE_ANIM_FRAME_IDX_1B
	dbw $29, .OAMData_1b ; SPRITE_ANIM_FRAME_IDX_1C
	dbw $42, .OAMData_1b ; SPRITE_ANIM_FRAME_IDX_1D
	dbw $f8, .OAMData_1e ; SPRITE_ANIM_FRAME_IDX_1E
	dbw $fa, .OAMData_1e ; SPRITE_ANIM_FRAME_IDX_1F
	dbw $00, .OAMData_20 ; SPRITE_ANIM_FRAME_IDX_20
	dbw $00, .OAMData_21 ; SPRITE_ANIM_FRAME_IDX_21
	dbw $00, .OAMData_22 ; SPRITE_ANIM_FRAME_IDX_22
	dbw $0f, .OAMData_23 ; SPRITE_ANIM_FRAME_IDX_23
	dbw $11, .OAMData_02 ; SPRITE_ANIM_FRAME_IDX_24
	dbw $12, .OAMData_02 ; SPRITE_ANIM_FRAME_IDX_25
	dbw $13, .OAMData_02 ; SPRITE_ANIM_FRAME_IDX_26
	dbw $00, .OAMData_27 ; SPRITE_ANIM_FRAME_IDX_27
	dbw $08, .OAMData_27 ; SPRITE_ANIM_FRAME_IDX_28
	dbw $10, .OAMData_29 ; SPRITE_ANIM_FRAME_IDX_29
	dbw $10, .OAMData_2a ; SPRITE_ANIM_FRAME_IDX_2A
	dbw $10, .OAMData_2b ; SPRITE_ANIM_FRAME_IDX_2B
	dbw $10, .OAMData_2c ; SPRITE_ANIM_FRAME_IDX_2C
	dbw $10, .OAMData_2d ; SPRITE_ANIM_FRAME_IDX_2D
	dbw $3a, .OAMData_02 ; SPRITE_ANIM_FRAME_IDX_2E
	dbw $00, .OAMData_00 ; SPRITE_ANIM_FRAME_IDX_2F
	dbw $00, .OAMData_30 ; SPRITE_ANIM_FRAME_IDX_30
	dbw $02, .OAMData_31 ; SPRITE_ANIM_FRAME_IDX_31
	dbw $06, .OAMData_19 ; SPRITE_ANIM_FRAME_IDX_32
	dbw $0a, .OAMData_19 ; SPRITE_ANIM_FRAME_IDX_33
	dbw $0e, .OAMData_19 ; SPRITE_ANIM_FRAME_IDX_34
	dbw $12, .OAMData_35 ; SPRITE_ANIM_FRAME_IDX_35
	dbw $13, .OAMData_35 ; SPRITE_ANIM_FRAME_IDX_36
	dbw $00, .OAMData_00 ; SPRITE_ANIM_FRAME_IDX_37
	dbw $04, .OAMData_00 ; SPRITE_ANIM_FRAME_IDX_38
	dbw $10, .OAMData_19 ; SPRITE_ANIM_FRAME_IDX_39
	dbw $00, .OAMData_31 ; SPRITE_ANIM_FRAME_IDX_3A
	dbw $04, .OAMData_02 ; SPRITE_ANIM_FRAME_IDX_3B
	dbw $00, .OAMData_3c ; SPRITE_ANIM_FRAME_IDX_3C
	dbw $00, .OAMData_3d ; SPRITE_ANIM_FRAME_IDX_3D
	dbw $00, .OAMData_3e ; SPRITE_ANIM_FRAME_IDX_3E
	dbw $00, .OAMData_3f ; SPRITE_ANIM_FRAME_IDX_3F
	dbw $00, .OAMData_40 ; SPRITE_ANIM_FRAME_IDX_40
	dbw $00, .OAMData_31 ; SPRITE_ANIM_FRAME_IDX_41
	dbw $04, .OAMData_31 ; SPRITE_ANIM_FRAME_IDX_42
	dbw $00, .OAMData_43 ; SPRITE_ANIM_FRAME_IDX_43
	dbw $30, .OAMData_43 ; SPRITE_ANIM_FRAME_IDX_44
	dbw $03, .OAMData_43 ; SPRITE_ANIM_FRAME_IDX_45
	dbw $33, .OAMData_43 ; SPRITE_ANIM_FRAME_IDX_46
	dbw $06, .OAMData_43 ; SPRITE_ANIM_FRAME_IDX_47
	dbw $36, .OAMData_43 ; SPRITE_ANIM_FRAME_IDX_48
	dbw $09, .OAMData_43 ; SPRITE_ANIM_FRAME_IDX_49
	dbw $39, .OAMData_43 ; SPRITE_ANIM_FRAME_IDX_4A
	dbw $0c, .OAMData_4b ; SPRITE_ANIM_FRAME_IDX_4B
	dbw $0c, .OAMData_4c ; SPRITE_ANIM_FRAME_IDX_4C
	dbw $3c, .OAMData_02 ; SPRITE_ANIM_FRAME_IDX_4D
	dbw $3e, .OAMData_02 ; SPRITE_ANIM_FRAME_IDX_4E
	dbw $00, .OAMData_4f ; SPRITE_ANIM_FRAME_IDX_4F
	dbw $00, .OAMData_50 ; SPRITE_ANIM_FRAME_IDX_50
	dbw $00, .OAMData_51 ; SPRITE_ANIM_FRAME_IDX_51
	dbw $00, .OAMData_52 ; SPRITE_ANIM_FRAME_IDX_52
	dbw $00, .OAMData_53 ; SPRITE_ANIM_FRAME_IDX_53
	dbw $00, .OAMData_02 ; SPRITE_ANIM_FRAME_IDX_54
	dbw $01, .OAMData_02 ; SPRITE_ANIM_FRAME_IDX_55
	dbw $00, .OAMData_56 ; SPRITE_ANIM_FRAME_IDX_56
	dbw $00, .OAMData_57 ; SPRITE_ANIM_FRAME_IDX_57
	dbw $00, .OAMData_58 ; SPRITE_ANIM_FRAME_IDX_58
	dbw $00, .OAMData_59 ; SPRITE_ANIM_FRAME_IDX_59
	dbw $00, .OAMData_5a ; SPRITE_ANIM_FRAME_IDX_5A
	dbw $04, .OAMData_50 ; SPRITE_ANIM_FRAME_IDX_5B
	dbw $00, .OAMData_5c ; SPRITE_ANIM_FRAME_IDX_5C
	dbw $00, .OAMData_5d ; SPRITE_ANIM_FRAME_IDX_5D
	dbw $00, .OAMData_5e ; SPRITE_ANIM_FRAME_IDX_5E
	dbw $00, .OAMData_5f ; SPRITE_ANIM_FRAME_IDX_5F
	dbw $00, .OAMData_60 ; SPRITE_ANIM_FRAME_IDX_60
	dbw $00, .OAMData_61 ; SPRITE_ANIM_FRAME_IDX_61
	dbw $00, .OAMData_62 ; SPRITE_ANIM_FRAME_IDX_62
	dbw $00, .OAMData_63 ; SPRITE_ANIM_FRAME_IDX_63
	dbw $04, .OAMData_63 ; SPRITE_ANIM_FRAME_IDX_64
	dbw $00, .OAMData_65 ; SPRITE_ANIM_FRAME_IDX_65
	dbw $04, .OAMData_65 ; SPRITE_ANIM_FRAME_IDX_66
	dbw $20, .OAMData_67 ; SPRITE_ANIM_FRAME_IDX_67
	dbw $21, .OAMData_67 ; SPRITE_ANIM_FRAME_IDX_68
	dbw $22, .OAMData_69 ; SPRITE_ANIM_FRAME_IDX_69
	dbw $23, .OAMData_6a ; SPRITE_ANIM_FRAME_IDX_6A
	dbw $27, .OAMData_6b ; SPRITE_ANIM_FRAME_IDX_6B
	dbw $2a, .OAMData_6c ; SPRITE_ANIM_FRAME_IDX_6C
	dbw $2a, .OAMData_6d ; SPRITE_ANIM_FRAME_IDX_6D
	dbw $00, .OAMData_6e ; SPRITE_ANIM_FRAME_IDX_6E
	dbw $08, .OAMData_6f ; SPRITE_ANIM_FRAME_IDX_6F
	dbw $60, .OAMData_70 ; SPRITE_ANIM_FRAME_IDX_70
	dbw $68, .OAMData_71 ; SPRITE_ANIM_FRAME_IDX_71
	dbw $00, .OAMData_72 ; SPRITE_ANIM_FRAME_IDX_72
	dbw $05, .OAMData_72 ; SPRITE_ANIM_FRAME_IDX_73
	dbw $0a, .OAMData_72 ; SPRITE_ANIM_FRAME_IDX_74
	dbw $50, .OAMData_75 ; SPRITE_ANIM_FRAME_IDX_75
	dbw $00, .OAMData_76 ; SPRITE_ANIM_FRAME_IDX_76
	dbw $01, .OAMData_77 ; SPRITE_ANIM_FRAME_IDX_77
	dbw $04, .OAMData_78 ; SPRITE_ANIM_FRAME_IDX_78
	dbw $00, .OAMData_18 ; SPRITE_ANIM_FRAME_IDX_79
	dbw $01, .OAMData_7a ; SPRITE_ANIM_FRAME_IDX_7A
	dbw $03, .OAMData_7b ; SPRITE_ANIM_FRAME_IDX_7B
	dbw $08, .OAMData_7c ; SPRITE_ANIM_FRAME_IDX_7C
	dbw $1c, .OAMData_7c ; SPRITE_ANIM_FRAME_IDX_7D
	dbw $80, .OAMData_7e ; SPRITE_ANIM_FRAME_IDX_7E
	dbw $00, .OAMData_7f ; SPRITE_ANIM_FRAME_IDX_7F
	dbw $04, .OAMData_7f ; SPRITE_ANIM_FRAME_IDX_80
	dbw $d0, .OAMData_81 ; SPRITE_ANIM_FRAME_IDX_81
	dbw $d3, .OAMData_81 ; SPRITE_ANIM_FRAME_IDX_82
	dbw $d6, .OAMData_81 ; SPRITE_ANIM_FRAME_IDX_83
	dbw $6c, .OAMData_84 ; SPRITE_ANIM_FRAME_IDX_84
	dbw $68, .OAMData_84 ; SPRITE_ANIM_FRAME_IDX_85
	dbw $64, .OAMData_84 ; SPRITE_ANIM_FRAME_IDX_86
	dbw $60, .OAMData_84 ; SPRITE_ANIM_FRAME_IDX_87
	dbw $0c, .OAMData_84 ; SPRITE_ANIM_FRAME_IDX_88
	dbw $08, .OAMData_84 ; SPRITE_ANIM_FRAME_IDX_89
	dbw $04, .OAMData_84 ; SPRITE_ANIM_FRAME_IDX_8A
	dbw $00, .OAMData_84 ; SPRITE_ANIM_FRAME_IDX_8B

.OAMData_02:
	db 1
	dsprite -1,  4, -1,  4, $00, $0

.OAMData_04:
	db 4
	dsprite -1,  0, -1,  0, $00, $0
	dsprite -1,  0,  0,  0, $01, $0
	dsprite  0,  0, -1,  0, $10, $0
	dsprite  0,  0,  0,  0, $11, $0

.OAMData_23:
	db 4
	dsprite -1,  0, -1,  0, $00, $0
	dsprite -1,  0,  0,  0, $00, $0 | X_FLIP
	dsprite  0,  0, -1,  0, $01, $0
	dsprite  0,  0,  0,  0, $01, $0 | X_FLIP

.OAMData_30:
	db 4
	dsprite -1,  0, -1,  0, $00, $0 | BEHIND_BG
	dsprite -1,  0,  0,  0, $00, $0 | X_FLIP | BEHIND_BG
	dsprite  0,  0, -1,  0, $01, $0 | BEHIND_BG
	dsprite  0,  0,  0,  0, $01, $0 | X_FLIP | BEHIND_BG

.OAMData_18:
	db 4
	dsprite -1,  0, -1,  0, $00, $0
	dsprite -1,  0,  0,  0, $00, $0 | X_FLIP
	dsprite  0,  0, -1,  0, $00, $0 | Y_FLIP
	dsprite  0,  0,  0,  0, $00, $0 | X_FLIP | Y_FLIP

.OAMData_35:
	db 4
	dsprite -1,  0, -1,  0, $00, $7
	dsprite -1,  0,  0,  0, $00, $7 | X_FLIP
	dsprite  0,  0, -1,  0, $00, $7 | Y_FLIP
	dsprite  0,  0,  0,  0, $00, $7 | X_FLIP | Y_FLIP
; 8db4b

; 8db4b
	db 4
	dsprite -1,  0, -1,  0, $00, $0 | BEHIND_BG
	dsprite -1,  0,  0,  0, $00, $0 | X_FLIP | BEHIND_BG
	dsprite  0,  0, -1,  0, $00, $0 | Y_FLIP | BEHIND_BG
	dsprite  0,  0,  0,  0, $00, $0 | X_FLIP | Y_FLIP | BEHIND_BG

.OAMData_19:
	db 16
	dsprite -2,  0, -2,  0, $00, $0
	dsprite -2,  0, -1,  0, $01, $0
	dsprite -1,  0, -2,  0, $02, $0
	dsprite -1,  0, -1,  0, $03, $0
	dsprite -2,  0,  0,  0, $01, $0 | X_FLIP
	dsprite -2,  0,  1,  0, $00, $0 | X_FLIP
	dsprite -1,  0,  0,  0, $03, $0 | X_FLIP
	dsprite -1,  0,  1,  0, $02, $0 | X_FLIP
	dsprite  0,  0, -2,  0, $02, $0 | Y_FLIP
	dsprite  0,  0, -1,  0, $03, $0 | Y_FLIP
	dsprite  1,  0, -2,  0, $00, $0 | Y_FLIP
	dsprite  1,  0, -1,  0, $01, $0 | Y_FLIP
	dsprite  0,  0,  0,  0, $03, $0 | X_FLIP | Y_FLIP
	dsprite  0,  0,  1,  0, $02, $0 | X_FLIP | Y_FLIP
	dsprite  1,  0,  0,  0, $01, $0 | X_FLIP | Y_FLIP
	dsprite  1,  0,  1,  0, $00, $0 | X_FLIP | Y_FLIP

.OAMData_1a:
	db 36
	dsprite -3,  0, -3,  0, $00, $0
	dsprite -3,  0, -2,  0, $01, $0
	dsprite -3,  0, -1,  0, $02, $0
	dsprite -2,  0, -3,  0, $03, $0
	dsprite -2,  0, -2,  0, $04, $0
	dsprite -2,  0, -1,  0, $05, $0
	dsprite -1,  0, -3,  0, $06, $0
	dsprite -1,  0, -2,  0, $05, $0
	dsprite -1,  0, -1,  0, $05, $0
	dsprite -3,  0,  0,  0, $02, $0 | X_FLIP
	dsprite -3,  0,  1,  0, $01, $0 | X_FLIP
	dsprite -3,  0,  2,  0, $00, $0 | X_FLIP
	dsprite -2,  0,  0,  0, $05, $0 | X_FLIP
	dsprite -2,  0,  1,  0, $04, $0 | X_FLIP
	dsprite -2,  0,  2,  0, $03, $0 | X_FLIP
	dsprite -1,  0,  0,  0, $05, $0 | X_FLIP
	dsprite -1,  0,  1,  0, $05, $0 | X_FLIP
	dsprite -1,  0,  2,  0, $06, $0 | X_FLIP
	dsprite  0,  0, -3,  0, $06, $0 | Y_FLIP
	dsprite  0,  0, -2,  0, $05, $0 | Y_FLIP
	dsprite  0,  0, -1,  0, $05, $0 | Y_FLIP
	dsprite  1,  0, -3,  0, $03, $0 | Y_FLIP
	dsprite  1,  0, -2,  0, $04, $0 | Y_FLIP
	dsprite  1,  0, -1,  0, $05, $0 | Y_FLIP
	dsprite  2,  0, -3,  0, $00, $0 | Y_FLIP
	dsprite  2,  0, -2,  0, $01, $0 | Y_FLIP
	dsprite  2,  0, -1,  0, $02, $0 | Y_FLIP
	dsprite  0,  0,  0,  0, $05, $0 | X_FLIP | Y_FLIP
	dsprite  0,  0,  1,  0, $05, $0 | X_FLIP | Y_FLIP
	dsprite  0,  0,  2,  0, $06, $0 | X_FLIP | Y_FLIP
	dsprite  1,  0,  0,  0, $05, $0 | X_FLIP | Y_FLIP
	dsprite  1,  0,  1,  0, $04, $0 | X_FLIP | Y_FLIP
	dsprite  1,  0,  2,  0, $03, $0 | X_FLIP | Y_FLIP
	dsprite  2,  0,  0,  0, $02, $0 | X_FLIP | Y_FLIP
	dsprite  2,  0,  1,  0, $01, $0 | X_FLIP | Y_FLIP
	dsprite  2,  0,  2,  0, $00, $0 | X_FLIP | Y_FLIP

.OAMData_43:
	db 9
	dsprite -2,  4, -2,  4, $00, $0
	dsprite -2,  4, -1,  4, $01, $0
	dsprite -2,  4,  0,  4, $02, $0
	dsprite -1,  4, -2,  4, $10, $0
	dsprite -1,  4, -1,  4, $11, $0
	dsprite -1,  4,  0,  4, $12, $0
	dsprite  0,  4, -2,  4, $20, $0
	dsprite  0,  4, -1,  4, $21, $0
	dsprite  0,  4,  0,  4, $22, $0

.OAMData_0e:
	db 16
	dsprite -2,  0, -2,  0, $00, $0
	dsprite -2,  0, -1,  0, $01, $0
	dsprite -2,  0,  0,  0, $02, $0
	dsprite -2,  0,  1,  0, $03, $0
	dsprite -1,  0, -2,  0, $10, $0
	dsprite -1,  0, -1,  0, $11, $0
	dsprite -1,  0,  0,  0, $12, $0
	dsprite -1,  0,  1,  0, $13, $0
	dsprite  0,  0, -2,  0, $20, $0
	dsprite  0,  0, -1,  0, $21, $0
	dsprite  0,  0,  0,  0, $22, $0
	dsprite  0,  0,  1,  0, $23, $0
	dsprite  1,  0, -2,  0, $30, $0
	dsprite  1,  0, -1,  0, $31, $0
	dsprite  1,  0,  0,  0, $32, $0
	dsprite  1,  0,  1,  0, $33, $0

.OAMData_1b:
	db 25
	dsprite -3,  4, -3,  4, $00, $0
	dsprite -2,  4, -3,  4, $01, $0
	dsprite -1,  4, -3,  4, $02, $0
	dsprite  0,  4, -3,  4, $03, $0
	dsprite  1,  4, -3,  4, $04, $0
	dsprite -3,  4, -2,  4, $05, $0
	dsprite -2,  4, -2,  4, $06, $0
	dsprite -1,  4, -2,  4, $07, $0
	dsprite  0,  4, -2,  4, $08, $0
	dsprite  1,  4, -2,  4, $09, $0
	dsprite -3,  4, -1,  4, $0a, $0
	dsprite -2,  4, -1,  4, $0b, $0
	dsprite -1,  4, -1,  4, $0c, $0
	dsprite  0,  4, -1,  4, $0d, $0
	dsprite  1,  4, -1,  4, $0e, $0
	dsprite -3,  4,  0,  4, $0f, $0
	dsprite -2,  4,  0,  4, $10, $0
	dsprite -1,  4,  0,  4, $11, $0
	dsprite  0,  4,  0,  4, $12, $0
	dsprite  1,  4,  0,  4, $13, $0
	dsprite -3,  4,  1,  4, $14, $0
	dsprite -2,  4,  1,  4, $15, $0
	dsprite -1,  4,  1,  4, $16, $0
	dsprite  0,  4,  1,  4, $17, $0
	dsprite  1,  4,  1,  4, $18, $0
; 8dcf9

; 8dcf9
	db 36
	dsprite -3,  0, -3,  0, $00, $0
	dsprite -3,  0, -2,  0, $01, $0
	dsprite -3,  0, -1,  0, $02, $0
	dsprite -3,  0,  0,  0, $03, $0
	dsprite -3,  0,  1,  0, $04, $0
	dsprite -3,  0,  2,  0, $05, $0
	dsprite -2,  0, -3,  0, $06, $0
	dsprite -2,  0, -2,  0, $07, $0
	dsprite -2,  0, -1,  0, $08, $0
	dsprite -2,  0,  0,  0, $09, $0
	dsprite -2,  0,  1,  0, $0a, $0
	dsprite -2,  0,  2,  0, $0b, $0
	dsprite -1,  0, -3,  0, $0c, $0
	dsprite -1,  0, -2,  0, $0d, $0
	dsprite -1,  0, -1,  0, $0e, $0
	dsprite -1,  0,  0,  0, $0f, $0
	dsprite -1,  0,  1,  0, $10, $0
	dsprite -1,  0,  2,  0, $11, $0
	dsprite  0,  0, -3,  0, $12, $0
	dsprite  0,  0, -2,  0, $13, $0
	dsprite  0,  0, -1,  0, $14, $0
	dsprite  0,  0,  0,  0, $15, $0
	dsprite  0,  0,  1,  0, $16, $0
	dsprite  0,  0,  2,  0, $17, $0
	dsprite  1,  0, -3,  0, $18, $0
	dsprite  1,  0, -2,  0, $19, $0
	dsprite  1,  0, -1,  0, $1a, $0
	dsprite  1,  0,  0,  0, $1b, $0
	dsprite  1,  0,  1,  0, $1c, $0
	dsprite  1,  0,  2,  0, $1d, $0
	dsprite  2,  0, -3,  0, $1e, $0
	dsprite  2,  0, -2,  0, $1f, $0
	dsprite  2,  0, -1,  0, $20, $0
	dsprite  2,  0,  0,  0, $21, $0
	dsprite  2,  0,  1,  0, $22, $0
	dsprite  2,  0,  2,  0, $23, $0

.OAMData_00:
; former party menu icons
	db 4
	dsprite -1,  0, -1,  0, $00, $0
	dsprite -1,  0,  0,  0, $01, $0
	dsprite  0,  0, -1,  0, $02, $0
	dsprite  0,  0,  0,  0, $03, $0

.OAMData_85:
; new party menu icons
	db 4
	dsprite -1,  0, -1,  0, $00, -1
	dsprite -1,  0,  0,  0, $01, -1
	dsprite  0,  0, -1,  0, $02, -1
	dsprite  0,  0,  0,  0, $03, -1

.OAMData_31:
	db 4
	dsprite -1,  0, -1,  0, $00, $0 | BEHIND_BG
	dsprite -1,  0,  0,  0, $01, $0 | BEHIND_BG
	dsprite  0,  0, -1,  0, $02, $0 | BEHIND_BG
	dsprite  0,  0,  0,  0, $03, $0 | BEHIND_BG

.OAMData_3d:
; party menu icon with mail, frame 1
	db 4
	dsprite -1,  0, -1,  0, $00, -1
	dsprite -1,  0,  0,  0, $01, -1
	dsprite  0,  0, -1,  0, $08, $0
	dsprite  0,  0,  0,  0, $03, -1

.OAMData_3e:
; party menu icon with mail, frame 2
	db 4
	dsprite -1,  0, -1,  0, $04, -1
	dsprite -1,  0,  0,  0, $05, -1
	dsprite  0,  0, -1,  0, $08, $0
	dsprite  0,  0,  0,  0, $07, -1

.OAMData_3f:
; party menu icon with item, frame 1
	db 4
	dsprite -1,  0, -1,  0, $00, -1
	dsprite -1,  0,  0,  0, $01, -1
	dsprite  0,  0, -1,  0, $09, $0
	dsprite  0,  0,  0,  0, $03, -1

.OAMData_40:
; party menu icon with item, frame 2
	db 4
	dsprite -1,  0, -1,  0, $04, -1
	dsprite -1,  0,  0,  0, $05, -1
	dsprite  0,  0, -1,  0, $09, $0
	dsprite  0,  0,  0,  0, $07, -1

.OAMData_06:
	db 6
	dsprite -1,  0, -2,  4, $00, $1
	dsprite -1,  0, -1,  4, $01, $1
	dsprite -1,  0,  0,  4, $02, $1
	dsprite  0,  0, -2,  4, $10, $1
	dsprite  0,  0, -1,  4, $11, $1
	dsprite  0,  0,  0,  4, $12, $1

.OAMData_08:
	db 29
	dsprite -3,  0, -3,  0, $00, $0
	dsprite -3,  0, -2,  0, $01, $0
	dsprite -3,  0, -1,  0, $02, $0
	dsprite -3,  0,  0,  0, $03, $0
	dsprite -2,  0, -3,  0, $10, $0
	dsprite -2,  0, -2,  0, $11, $0
	dsprite -2,  0, -1,  0, $12, $0
	dsprite -2,  0,  0,  0, $13, $0
	dsprite -1,  0, -3,  0, $20, $0
	dsprite -1,  0, -2,  0, $21, $0
	dsprite -1,  0, -1,  0, $22, $0
	dsprite -1,  0,  0,  0, $23, $0
	dsprite -1,  0,  1,  0, $24, $0
	dsprite  0,  0, -3,  0, $30, $0 | BEHIND_BG
	dsprite  0,  0, -2,  0, $31, $0 | BEHIND_BG
	dsprite  0,  0, -1,  0, $32, $0 | BEHIND_BG
	dsprite  0,  0,  0,  0, $33, $0 | BEHIND_BG
	dsprite  0,  0,  1,  0, $34, $0 | BEHIND_BG
	dsprite  1,  0, -3,  0, $40, $0 | BEHIND_BG
	dsprite  1,  0, -2,  0, $41, $0 | BEHIND_BG
	dsprite  1,  0, -1,  0, $42, $0 | BEHIND_BG
	dsprite  1,  0,  0,  0, $43, $0 | BEHIND_BG
	dsprite  1,  0,  1,  0, $44, $0 | BEHIND_BG
	dsprite  1,  0,  2,  0, $45, $0 | BEHIND_BG
	dsprite  2,  0, -2,  0, $51, $0 | BEHIND_BG
	dsprite  2,  0, -1,  0, $52, $0 | BEHIND_BG
	dsprite  2,  0,  0,  0, $53, $0 | BEHIND_BG
	dsprite  2,  0,  1,  0, $54, $0 | BEHIND_BG
	dsprite  2,  0,  2,  0, $55, $0 | BEHIND_BG

.OAMData_0c:
	db 2
	dsprite -1,  0, -1,  4, $00, $0
	dsprite  0,  0, -1,  4, $10, $0

.OAMData_15:
	db 5
	dsprite -2,  0,  3,  0, $00, $0
	dsprite -2,  0,  4,  0, $01, $0
	dsprite -1,  0,  2,  0, $02, $0
	dsprite -1,  0,  3,  0, $03, $0
	dsprite  0,  0,  2,  0, $04, $0

.OAMData_4f:
	db 1
	dsprite -1,  4, -1,  4, $00, $6

.OAMData_50:
	db 4
	dsprite -1,  0, -1,  0, $00, $6
	dsprite -1,  0,  0,  0, $01, $6
	dsprite  0,  0, -1,  0, $02, $6
	dsprite  0,  0,  0,  0, $03, $6

.OAMData_20:
	db 4
	dsprite -1,  7, -1,  7, $00, $0
	dsprite -1,  7,  0,  0, $00, $0 | X_FLIP
	dsprite  0,  0, -1,  7, $00, $0 | Y_FLIP
	dsprite  0,  0,  0,  0, $00, $0 | X_FLIP | Y_FLIP

.OAMData_21:
	db 10
	dsprite -1,  7,  0,  0, $00, $0
	dsprite -1,  7,  1,  0, $01, $0
	dsprite -1,  7,  2,  0, $01, $0
	dsprite -1,  7,  3,  0, $01, $0
	dsprite -1,  7,  4,  0, $00, $0 | X_FLIP
	dsprite  0,  0,  0,  0, $00, $0 | Y_FLIP
	dsprite  0,  0,  1,  0, $01, $0 | Y_FLIP
	dsprite  0,  0,  2,  0, $01, $0 | Y_FLIP
	dsprite  0,  0,  3,  0, $01, $0 | Y_FLIP
	dsprite  0,  0,  4,  0, $00, $0 | X_FLIP | Y_FLIP

.OAMData_22:
	db 15
	dsprite -3,  4, -2,  4, $00, $1
	dsprite -3,  4, -1,  4, $01, $1
	dsprite -3,  4,  0,  4, $02, $1
	dsprite -2,  4, -2,  4, $03, $1
	dsprite -2,  4, -1,  4, $04, $1
	dsprite -2,  4,  0,  4, $05, $1
	dsprite -1,  4, -2,  4, $06, $1
	dsprite -1,  4, -1,  4, $07, $1
	dsprite -1,  4,  0,  4, $08, $1
	dsprite  0,  4, -2,  4, $09, $1
	dsprite  0,  4, -1,  4, $0a, $1
	dsprite  0,  4,  0,  4, $0b, $1
	dsprite  1,  4, -2,  4, $0c, $1
	dsprite  1,  4, -1,  4, $0d, $1
	dsprite  1,  4,  0,  4, $0e, $1

.OAMData_27:
	db 6
	dsprite -2,  4, -2,  4, $00, $5
	dsprite -2,  4, -1,  4, $02, $5
	dsprite -2,  4,  0,  4, $00, $5 | X_FLIP
	dsprite  0,  4, -2,  4, $04, $5
	dsprite  0,  4, -1,  4, $06, $5
	dsprite  0,  4,  0,  4, $04, $5 | X_FLIP

.OAMData_29:
	db 6
	dsprite -2,  4, -2,  4, $00, $6
	dsprite -2,  4, -1,  4, $02, $6
	dsprite -2,  4,  0,  4, $04, $6
	dsprite  0,  4, -2,  4, $06, $6
	dsprite  0,  4, -1,  4, $08, $6
	dsprite  0,  4,  0,  4, $0a, $6

.OAMData_2a:
	db 6
	dsprite -2,  4, -2,  4, $00, $6
	dsprite -2,  4, -1,  4, $02, $6
	dsprite -2,  4,  0,  4, $04, $6
	dsprite  0,  4, -2,  4, $0c, $6
	dsprite  0,  4, -1,  4, $0e, $6
	dsprite  0,  4,  0,  4, $10, $6

.OAMData_2b:
	db 6
	dsprite -2,  4, -2,  4, $00, $6
	dsprite -2,  4, -1,  4, $02, $6
	dsprite -2,  4,  0,  4, $04, $6
	dsprite  0,  4, -2,  4, $12, $6
	dsprite  0,  4, -1,  4, $14, $6
	dsprite  0,  4,  0,  4, $16, $6

.OAMData_2c:
	db 6
	dsprite -2,  4, -2,  4, $00, $6
	dsprite -2,  4, -1,  4, $02, $6
	dsprite -2,  4,  0,  4, $04, $6
	dsprite  0,  4, -2,  4, $18, $6
	dsprite  0,  4, -1,  4, $1a, $6
	dsprite  0,  4,  0,  4, $1c, $6

.OAMData_2d:
	db 6
	dsprite -2,  4, -2,  4, $1e, $6
	dsprite -2,  4, -1,  4, $20, $6
	dsprite -2,  4,  0,  4, $22, $6
	dsprite  0,  4, -2,  4, $24, $6
	dsprite  0,  4, -1,  4, $26, $6
	dsprite  0,  4,  0,  4, $28, $6

.OAMData_3c:
	db 3
	dsprite -2,  4, -1,  4, $00, $0
	dsprite -1,  4, -1,  4, $00, $0
	dsprite  0,  4, -1,  4, $00, $0

.OAMData_4b:
	db 6
	dsprite  0,  0,  0,  0, $00, $0
	dsprite  0,  0,  1,  0, $01, $0
	dsprite  0,  0,  2,  0, $01, $0
	dsprite  0,  0,  3,  0, $01, $0
	dsprite  0,  0,  4,  0, $02, $0
	dsprite  0,  0,  5,  0, $03, $0

.OAMData_4c:
	db 4
	dsprite  0,  0,  0,  0, $00, $0
	dsprite  0,  0,  1,  0, $01, $0
	dsprite  0,  0,  2,  0, $02, $0
	dsprite  0,  0,  3,  0, $03, $0

.OAMData_51:
	db 4
	dsprite -1,  0, -2,  6, $00, $6
	dsprite -1,  0,  0,  2, $01, $6
	dsprite  0,  0, -2,  6, $02, $6
	dsprite  0,  0,  0,  2, $03, $6

.OAMData_52:
	db 4
	dsprite -1,  0, -2,  4, $00, $6
	dsprite -1,  0,  0,  4, $01, $6
	dsprite  0,  0, -2,  4, $02, $6
	dsprite  0,  0,  0,  4, $03, $6

.OAMData_53:
	db 4
	dsprite -1,  0, -2,  0, $00, $6
	dsprite -1,  0,  1,  0, $01, $6
	dsprite  0,  0, -2,  0, $02, $6
	dsprite  0,  0,  1,  0, $03, $6

.OAMData_56:
	db 19
	dsprite -1,  0, -4,  0, $00, $0
	dsprite -2,  0, -3,  0, $02, $0
	dsprite  0,  0, -3,  0, $04, $0
	dsprite -3,  0, -2,  0, $06, $0
	dsprite -1,  0, -2,  0, $08, $0
	dsprite  1,  0, -2,  0, $0a, $0
	dsprite -3,  0, -1,  0, $0c, $0
	dsprite -1,  0, -1,  0, $0e, $0
	dsprite  1,  0, -1,  0, $10, $0
	dsprite -3,  0,  0,  0, $12, $0
	dsprite -1,  0,  0,  0, $14, $0
	dsprite  1,  0,  0,  0, $16, $0
	dsprite -3,  0,  1,  0, $18, $0
	dsprite -1,  0,  1,  0, $1a, $0
	dsprite  1,  0,  1,  0, $1c, $0
	dsprite -1,  0,  2,  0, $1e, $0
	dsprite  1,  0,  2,  0, $20, $0
	dsprite -2,  0,  3,  0, $22, $0
	dsprite  0,  0,  3,  0, $24, $0

.OAMData_57:
	db 16
	dsprite -1,  0, -4,  0, $00, $0
	dsprite -2,  0, -3,  0, $02, $0
	dsprite  0,  0, -3,  0, $04, $0
	dsprite -1,  0, -2,  0, $26, $0
	dsprite  1,  0, -2,  0, $0a, $0
	dsprite -3,  0, -1,  0, $28, $0
	dsprite -1,  0, -1,  0, $2a, $0
	dsprite  1,  0, -1,  0, $10, $0
	dsprite -1,  0,  0,  0, $2c, $0
	dsprite  1,  0,  0,  0, $16, $0
	dsprite -1,  0,  1,  0, $30, $0
	dsprite  1,  0,  1,  0, $1c, $0
	dsprite -1,  0,  2,  0, $1e, $0
	dsprite  1,  0,  2,  0, $20, $0
	dsprite -2,  0,  3,  0, $22, $0
	dsprite  0,  0,  3,  0, $24, $0

.OAMData_58:
	db 15
	dsprite -1,  0, -4,  0, $00, $0
	dsprite -2,  0, -3,  0, $02, $0
	dsprite  0,  0, -3,  0, $32, $0
	dsprite -1,  0, -2,  0, $34, $0
	dsprite  1,  0, -2,  0, $36, $0
	dsprite -1,  0, -1,  0, $38, $0
	dsprite  1,  0, -1,  0, $3a, $0
	dsprite -1,  0,  0,  0, $3c, $0
	dsprite  1,  0,  0,  0, $3e, $0
	dsprite -1,  0,  1,  0, $30, $0
	dsprite  1,  0,  1,  0, $1c, $0
	dsprite -1,  0,  2,  0, $1e, $0
	dsprite  1,  0,  2,  0, $20, $0
	dsprite -2,  0,  3,  0, $22, $0
	dsprite  0,  0,  3,  0, $24, $0

.OAMData_59:
	db 17
	dsprite -1,  0, -4,  0, $00, $0
	dsprite -2,  0, -3,  0, $02, $0
	dsprite  0,  0, -3,  0, $04, $0
	dsprite -1,  0, -2,  0, $40, $0
	dsprite  1,  0, -2,  0, $42, $0
	dsprite  3,  0, -2,  0, $44, $0
	dsprite -1,  0, -1,  0, $46, $0
	dsprite  1,  0, -1,  0, $48, $0
	dsprite  3,  0, -1,  0, $4a, $0
	dsprite -1,  0,  0,  0, $4c, $0
	dsprite  1,  0,  0,  0, $4e, $0
	dsprite -1,  0,  1,  0, $30, $0
	dsprite  1,  0,  1,  0, $1c, $0
	dsprite -1,  0,  2,  0, $1e, $0
	dsprite  1,  0,  2,  0, $20, $0
	dsprite -2,  0,  3,  0, $22, $0
	dsprite  0,  0,  3,  0, $24, $0

.OAMData_5a:
	db 17
	dsprite -1,  0, -4,  0, $00, $0
	dsprite -2,  0, -3,  0, $02, $0
	dsprite  0,  0, -3,  0, $04, $0
	dsprite -1,  0, -2,  0, $50, $0
	dsprite  1,  0, -2,  0, $0a, $0
	dsprite -3,  0, -1,  0, $52, $0
	dsprite -1,  0, -1,  0, $54, $0
	dsprite  1,  0, -1,  0, $10, $0
	dsprite -3,  0,  0,  0, $56, $0
	dsprite -1,  0,  0,  0, $2e, $0
	dsprite  1,  0,  0,  0, $16, $0
	dsprite -1,  0,  1,  0, $30, $0
	dsprite  1,  0,  1,  0, $1c, $0
	dsprite -1,  0,  2,  0, $1e, $0
	dsprite  1,  0,  2,  0, $20, $0
	dsprite -2,  0,  3,  0, $22, $0
	dsprite  0,  0,  3,  0, $24, $0

.OAMData_1e:
	db 1
	dsprite -1,  4, -1,  4, $00, $1

.OAMData_5c:
	db 12
	dsprite  0,  0,  0,  0, $30, $0
	dsprite  0,  0,  1,  0, $31, $0
	dsprite  0,  0,  2,  0, $31, $0
	dsprite  0,  0,  3,  0, $31, $0
	dsprite  0,  0,  4,  0, $31, $0
	dsprite  0,  0,  5,  0, $32, $0
	dsprite  1,  0,  0,  0, $33, $0
	dsprite  1,  0,  1,  0, $34, $0
	dsprite  1,  0,  2,  0, $34, $0
	dsprite  1,  0,  3,  0, $34, $0
	dsprite  1,  0,  4,  0, $34, $0
	dsprite  1,  0,  5,  0, $35, $0

.OAMData_5d:
	db 1
	dsprite  0,  0,  0,  0, $ed, $0

.OAMData_5e:
	db 4
	dsprite -1,  7, -1,  7, $30, $0
	dsprite -1,  7,  0,  1, $32, $0
	dsprite  0,  1, -1,  7, $33, $0
	dsprite  0,  1,  0,  1, $35, $0

.OAMData_5f:
	db 8
	dsprite -1,  7, -1,  7, $30, $0
	dsprite -1,  7,  0,  4, $31, $0
	dsprite -1,  7,  1,  4, $31, $0
	dsprite -1,  7,  2,  1, $32, $0
	dsprite  0,  1, -1,  7, $33, $0
	dsprite  0,  1,  0,  4, $34, $0
	dsprite  0,  1,  1,  4, $34, $0
	dsprite  0,  1,  2,  1, $35, $0

.OAMData_60:
	db 1
	dsprite  0,  0,  0,  0, $34, $0

.OAMData_61:
	db 2
	dsprite  0,  0,  0,  0, $30, $0
	dsprite  1,  0,  0,  0, $33, $0

.OAMData_62:
	db 2
	dsprite  0,  0,  0,  0, $32, $0
	dsprite  1,  0,  0,  0, $35, $0

.OAMData_63:
	db 4
	dsprite -1,  0, -1,  0, $00, $1
	dsprite -1,  0,  0,  0, $01, $1
	dsprite  0,  0, -1,  0, $02, $1
	dsprite  0,  0,  0,  0, $03, $1

.OAMData_65:
	db 4
	dsprite -1,  0, -1,  0, $00, $1 | BEHIND_BG
	dsprite -1,  0,  0,  0, $01, $1 | BEHIND_BG
	dsprite  0,  0, -1,  0, $02, $1 | BEHIND_BG
	dsprite  0,  0,  0,  0, $03, $1 | BEHIND_BG

.OAMData_67:
	db 1
	dsprite -1,  4, -1,  4, $00, $2

.OAMData_6c:
	db 4
	dsprite -2,  0, -1,  4, $00, $3
	dsprite -1,  0, -1,  4, $01, $3
	dsprite  0,  0, -1,  4, $02, $3
	dsprite  1,  0, -1,  4, $03, $3

.OAMData_6d:
	db 4
	dsprite -2,  0, -1,  4, $03, $4 | Y_FLIP
	dsprite -1,  0, -1,  4, $02, $4 | Y_FLIP
	dsprite  0,  0, -1,  4, $01, $4 | Y_FLIP
	dsprite  1,  0, -1,  4, $00, $4 | Y_FLIP

.OAMData_69:
	db 4
	dsprite -1,  0, -1,  0, $00, $1
	dsprite -1,  0,  0,  0, $00, $1 | X_FLIP
	dsprite  0,  0, -1,  0, $00, $1 | Y_FLIP
	dsprite  0,  0,  0,  0, $00, $1 | X_FLIP | Y_FLIP

.OAMData_6a:
	db 8
	dsprite -2,  4, -2,  4, $00, $1
	dsprite -2,  4, -1,  4, $01, $1
	dsprite -2,  4,  0,  4, $00, $1 | X_FLIP
	dsprite -1,  4, -2,  4, $02, $1
	dsprite -1,  4,  0,  4, $02, $1 | X_FLIP
	dsprite  0,  4, -2,  4, $00, $1 | Y_FLIP
	dsprite  0,  4, -1,  4, $01, $1 | Y_FLIP
	dsprite  0,  4,  0,  4, $00, $1 | X_FLIP | Y_FLIP

.OAMData_6b:
	db 12
	dsprite -2,  0, -2,  0, $00, $1
	dsprite -2,  0, -1,  0, $01, $1
	dsprite -1,  0, -2,  0, $02, $1
	dsprite -2,  0,  0,  0, $01, $1 | X_FLIP
	dsprite -2,  0,  1,  0, $00, $1 | X_FLIP
	dsprite -1,  0,  1,  0, $02, $1 | X_FLIP
	dsprite  0,  0, -2,  0, $02, $1 | Y_FLIP
	dsprite  1,  0, -2,  0, $00, $1 | Y_FLIP
	dsprite  1,  0, -1,  0, $01, $1 | Y_FLIP
	dsprite  0,  0,  1,  0, $02, $1 | X_FLIP | Y_FLIP
	dsprite  1,  0,  0,  0, $01, $1 | X_FLIP | Y_FLIP
	dsprite  1,  0,  1,  0, $00, $1 | X_FLIP | Y_FLIP

.OAMData_6e:
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

.OAMData_6f:
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

.OAMData_70:
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

.OAMData_71:
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

.OAMData_72:
	db 25
	dsprite -3,  4, -3,  4, $00, $1 | TILE_BANK
	dsprite -3,  4, -2,  4, $01, $1 | TILE_BANK
	dsprite -3,  4, -1,  4, $02, $1 | TILE_BANK
	dsprite -3,  4,  0,  4, $03, $1 | TILE_BANK
	dsprite -3,  4,  1,  4, $04, $1 | TILE_BANK
	dsprite -2,  4, -3,  4, $10, $1 | TILE_BANK
	dsprite -2,  4, -2,  4, $11, $1 | TILE_BANK
	dsprite -2,  4, -1,  4, $12, $1 | TILE_BANK
	dsprite -2,  4,  0,  4, $13, $1 | TILE_BANK
	dsprite -2,  4,  1,  4, $14, $1 | TILE_BANK
	dsprite -1,  4, -3,  4, $20, $1 | TILE_BANK
	dsprite -1,  4, -2,  4, $21, $1 | TILE_BANK
	dsprite -1,  4, -1,  4, $22, $1 | TILE_BANK
	dsprite -1,  4,  0,  4, $23, $1 | TILE_BANK
	dsprite -1,  4,  1,  4, $24, $1 | TILE_BANK
	dsprite  0,  4, -3,  4, $30, $1 | TILE_BANK
	dsprite  0,  4, -2,  4, $31, $1 | TILE_BANK
	dsprite  0,  4, -1,  4, $32, $1 | TILE_BANK
	dsprite  0,  4,  0,  4, $33, $1 | TILE_BANK
	dsprite  0,  4,  1,  4, $34, $1 | TILE_BANK
	dsprite  1,  4, -3,  4, $40, $1 | TILE_BANK
	dsprite  1,  4, -2,  4, $41, $1 | TILE_BANK
	dsprite  1,  4, -1,  4, $42, $1 | TILE_BANK
	dsprite  1,  4,  0,  4, $43, $1 | TILE_BANK
	dsprite  1,  4,  1,  4, $44, $1 | TILE_BANK

.OAMData_75:
	db 16
	dsprite -2,  0, -3,  4, $00, $2 | TILE_BANK
	dsprite -2,  0, -2,  4, $01, $2 | TILE_BANK
	dsprite -2,  0, -1,  4, $02, $2 | TILE_BANK
	dsprite -2,  0,  0,  4, $03, $2 | TILE_BANK
	dsprite -1,  0, -3,  4, $04, $2 | TILE_BANK
	dsprite -1,  0, -2,  4, $05, $2 | TILE_BANK
	dsprite -1,  0, -1,  4, $06, $2 | TILE_BANK
	dsprite -1,  0,  0,  4, $07, $2 | TILE_BANK
	dsprite  0,  0, -3,  4, $08, $2 | TILE_BANK
	dsprite  0,  0, -2,  4, $09, $2 | TILE_BANK
	dsprite  0,  0, -1,  4, $0a, $2 | TILE_BANK
	dsprite  0,  0,  0,  4, $0b, $2 | TILE_BANK
	dsprite  1,  0, -3,  4, $0c, $2 | TILE_BANK
	dsprite  1,  0, -2,  4, $0d, $2 | TILE_BANK
	dsprite  1,  0, -1,  4, $0e, $2 | TILE_BANK
	dsprite  1,  0,  0,  4, $0f, $2 | TILE_BANK

.OAMData_76:
	db 1
	dsprite -1,  4, -1,  4, $00, $0

.OAMData_77:
	db 3
	dsprite  0,  0, -1,  0, $00, $0
	dsprite -1,  0, -1,  0, $01, $0
	dsprite -1,  0,  0,  0, $02, $0

.OAMData_78:
	db 7
	dsprite  1,  0, -2,  0, $00, $0
	dsprite  0,  0, -2,  0, $01, $0
	dsprite -1,  0, -2,  0, $02, $0
	dsprite -1,  0, -1,  0, $03, $0
	dsprite -2,  0, -1,  0, $04, $0
	dsprite -2,  0,  0,  0, $05, $0
	dsprite -2,  0,  1,  0, $06, $0

.OAMData_7a:
	db 8
	dsprite -1,  0, -2,  0, $00, $0
	dsprite -1,  0, -1,  0, $01, $0
	dsprite -1,  0,  0,  0, $01, $0 | X_FLIP
	dsprite -1,  0,  1,  0, $00, $0 | X_FLIP
	dsprite  0,  0, -2,  0, $00, $0 | Y_FLIP
	dsprite  0,  0, -1,  0, $01, $0 | Y_FLIP
	dsprite  0,  0,  0,  0, $01, $0 | X_FLIP | Y_FLIP
	dsprite  0,  0,  1,  0, $00, $0 | X_FLIP | Y_FLIP

.OAMData_7b:
	db 12
	dsprite -3,  0, -1,  0, $00, $0
	dsprite -2,  0, -1,  0, $01, $0
	dsprite -1,  0, -1,  0, $02, $0
	dsprite -3,  0,  0,  0, $00, $0 | X_FLIP
	dsprite -2,  0,  0,  0, $01, $0 | X_FLIP
	dsprite -1,  0,  0,  0, $02, $0 | X_FLIP
	dsprite  0,  0, -1,  0, $02, $0 | Y_FLIP
	dsprite  1,  0, -1,  0, $01, $0 | Y_FLIP
	dsprite  2,  0, -1,  0, $00, $0 | Y_FLIP
	dsprite  0,  0,  0,  0, $02, $0 | X_FLIP | Y_FLIP
	dsprite  1,  0,  0,  0, $01, $0 | X_FLIP | Y_FLIP
	dsprite  2,  0,  0,  0, $00, $0 | X_FLIP | Y_FLIP

.OAMData_7c:
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

.OAMData_7e:
	db 20
	dsprite  0,  0,   1,  0, $00, $1 | BEHIND_BG
	dsprite  1,  0,   2,  0, $00, $1 | BEHIND_BG
	dsprite  2,  0,   3,  0, $00, $1 | BEHIND_BG
	dsprite  3,  0,   4,  0, $00, $1 | BEHIND_BG
	dsprite  4,  0,   5,  0, $00, $1 | BEHIND_BG
	dsprite  3,  0,   6,  0, $00, $1 | BEHIND_BG
	dsprite  2,  0,   7,  0, $00, $1 | BEHIND_BG
	dsprite  1,  0,   8,  0, $00, $1 | BEHIND_BG
	dsprite  0,  0,   9,  0, $00, $1 | BEHIND_BG
	dsprite  1,  0,  10,  0, $00, $1 | BEHIND_BG
	dsprite  2,  0,  11,  0, $00, $1 | BEHIND_BG
	dsprite  3,  0,  12,  0, $00, $1 | BEHIND_BG
	dsprite  4,  0,  13,  0, $00, $1 | BEHIND_BG
	dsprite  3,  0,  14,  0, $00, $1 | BEHIND_BG
	dsprite  2,  0,  15,  0, $00, $1 | BEHIND_BG
	dsprite  1,  0,  16,  0, $00, $1 | BEHIND_BG
	dsprite  0,  0, -15,  0, $00, $1 | BEHIND_BG
	dsprite  1,  0, -14,  0, $00, $1 | BEHIND_BG
	dsprite  2,  0, -13,  0, $00, $1 | BEHIND_BG
	dsprite  3,  0, -12,  0, $00, $1 | BEHIND_BG

.OAMData_7f:
	db 4
	dsprite -1,  0, -1,  0, $00, $2
	dsprite -1,  0,  0,  0, $01, $2
	dsprite  0,  0, -1,  0, $02, $2
	dsprite  0,  0,  0,  0, $03, $2

.OAMData_81:
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

.OAMData_84:
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
; 8e706
