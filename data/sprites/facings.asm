Facings:
	dw FacingStepDown0      ; FACING_STEP_DOWN_0
	dw FacingStepDown1      ; FACING_STEP_DOWN_1
	dw FacingStepDown2      ; FACING_STEP_DOWN_2
	dw FacingStepDown3      ; FACING_STEP_DOWN_3
	dw FacingStepUp0        ; FACING_STEP_UP_0
	dw FacingStepUp1        ; FACING_STEP_UP_1
	dw FacingStepUp2        ; FACING_STEP_UP_2
	dw FacingStepUp3        ; FACING_STEP_UP_3
	dw FacingStepLeft0      ; FACING_STEP_LEFT_0
	dw FacingStepLeft1      ; FACING_STEP_LEFT_1
	dw FacingStepLeft2      ; FACING_STEP_LEFT_2
	dw FacingStepLeft3      ; FACING_STEP_LEFT_3
	dw FacingStepRight0     ; FACING_STEP_RIGHT_0
	dw FacingStepRight1     ; FACING_STEP_RIGHT_1
	dw FacingStepRight2     ; FACING_STEP_RIGHT_2
	dw FacingStepRight3     ; FACING_STEP_RIGHT_3
	dw FacingFishDown       ; FACING_FISH_DOWN
	dw FacingFishUp         ; FACING_FISH_UP
	dw FacingFishLeft       ; FACING_FISH_LEFT
	dw FacingFishRight      ; FACING_FISH_RIGHT
	dw FacingEmote          ; FACING_EMOTE
	dw FacingShadow         ; FACING_SHADOW
	dw FacingBigDollAsym    ; FACING_BIG_DOLL_ASYM
	dw FacingBigDollSym     ; FACING_BIG_DOLL_SYM
	dw FacingWeirdTree0     ; FACING_WEIRD_TREE_0
	dw FacingWeirdTree1     ; FACING_WEIRD_TREE_1
	dw FacingWeirdTree2     ; FACING_WEIRD_TREE_2
	dw FacingWeirdTree3     ; FACING_WEIRD_TREE_3
	dw FacingBoulderDust1   ; FACING_BOULDER_DUST_1
	dw FacingBoulderDust2   ; FACING_BOULDER_DUST_2
	dw FacingGrass1         ; FACING_GRASS_1
	dw FacingGrass2         ; FACING_GRASS_2
	dw FacingSplash1        ; FACING_SPLASH_1
	dw FacingSplash2        ; FACING_SPLASH_2
	dw FacingCutTree        ; FACING_CUT_TREE
	dw FacingApricorn       ; FACING_APRICORN
	dw FacingBerry          ; FACING_BERRY
	dw FacingPickedFruit    ; FACING_PICKED_FRUIT
	dw FacingBigGyarados1   ; FACING_BIG_GYARADOS_1
	dw FacingBigGyarados2   ; FACING_BIG_GYARADOS_2
	dw FacingStepDownFlip   ; FACING_STEP_DOWN_FLIP
	dw FacingStepUpFlip     ; FACING_STEP_UP_FLIP
	dw FacingPokecomNews    ; FACING_POKECOM_NEWS
	dw FacingArchTreeDown   ; FACING_ARCH_TREE_DOWN
	dw FacingArchTreeUp     ; FACING_ARCH_TREE_UP
	dw FacingArchTreeLeft   ; FACING_ARCH_TREE_LEFT
	dw FacingArchTreeRight  ; FACING_ARCH_TREE_RIGHT
	dw FacingSailboatTop    ; FACING_SAILBOAT_TOP
	dw FacingSailboatBottom ; FACING_SAILBOAT_BOTTOM
FacingsEnd: dw 0

NUM_FACINGS EQU (FacingsEnd - Facings) / 2

; Tables used as a reference to transform OAM data.

; Format:
;	db y, x, attributes, tile index

FacingStepDown0:
FacingStepDown2:
FacingWeirdTree0:
FacingWeirdTree2:
	db 4 ; #
	db  0,  0, 0, $00
	db  0,  8, 0, $01
	db  8,  0, 2, $02
	db  8,  8, 2, $03

FacingStepDown1:
	db 4 ; #
	db  0,  0, 0, $80
	db  0,  8, 0, $81
	db  8,  0, 2, $82
	db  8,  8, 2, $83

FacingStepDown3:
	db 4 ; #
	db  0,  8, 0 | X_FLIP, $80
	db  0,  0, 0 | X_FLIP, $81
	db  8,  8, 2 | X_FLIP, $82
	db  8,  0, 2 | X_FLIP, $83

FacingStepUp0:
FacingStepUp2:
	db 4 ; #
	db  0,  0, 0, $04
	db  0,  8, 0, $05
	db  8,  0, 2, $06
	db  8,  8, 2, $07

FacingStepUp1:
	db 4 ; #
	db  0,  0, 0, $84
	db  0,  8, 0, $85
	db  8,  0, 2, $86
	db  8,  8, 2, $87

FacingStepUp3:
	db 4 ; #
	db  0,  8, 0 | X_FLIP, $84
	db  0,  0, 0 | X_FLIP, $85
	db  8,  8, 2 | X_FLIP, $86
	db  8,  0, 2 | X_FLIP, $87

FacingStepLeft0:
FacingStepLeft2:
	db 4 ; #
	db  0,  0, 0, $08
	db  0,  8, 0, $09
	db  8,  0, 2, $0a
	db  8,  8, 2, $0b

FacingStepRight0:
FacingStepRight2:
	db 4 ; #
	db  0,  8, 0 | X_FLIP, $08
	db  0,  0, 0 | X_FLIP, $09
	db  8,  8, 2 | X_FLIP, $0a
	db  8,  0, 2 | X_FLIP, $0b

FacingStepLeft1:
FacingStepLeft3:
	db 4 ; #
	db  0,  0, 0, $88
	db  0,  8, 0, $89
	db  8,  0, 2, $8a
	db  8,  8, 2, $8b

FacingStepRight1:
FacingStepRight3:
	db 4 ; #
	db  0,  8, 0 | X_FLIP, $88
	db  0,  0, 0 | X_FLIP, $89
	db  8,  8, 2 | X_FLIP, $8a
	db  8,  0, 2 | X_FLIP, $8b

FacingFishDown:
	db 5 ; #
	db  0,  0, 0, $00
	db  0,  8, 0, $01
	db  8,  0, 2, $02
	db  8,  8, 2, $03
	db 16,  0, 4, $7a

FacingFishUp:
	db 5 ; #
	db  0,  0, 0, $04
	db  0,  8, 0, $05
	db  8,  0, 2, $06
	db  8,  8, 2, $07
	db -8,  0, 4, $7a

FacingFishLeft:
	db 5 ; #
	db  0,  0, 0, $08
	db  0,  8, 0, $09
	db  8,  0, 2, $0a
	db  8,  8, 2, $0b
	db  5, -8, 4 | X_FLIP, $7b

FacingFishRight:
	db 5 ; #
	db  0,  8, 0 | X_FLIP, $08
	db  0,  0, 0 | X_FLIP, $09
	db  8,  8, 2 | X_FLIP, $0a
	db  8,  0, 2 | X_FLIP, $0b
	db  5, 16, 4, $7b

FacingEmote:
	db 4 ; #
	db  0,  0, 4, $60
	db  0,  8, 4, $61
	db  8,  0, 4, $62
	db  8,  8, 4, $63

FacingShadow:
	db 2 ; #
	db  0,  0, 4, $7c
	db  0,  8, 4 | X_FLIP, $7c

FacingBigDollSym: ; big snorlax or lapras doll
	db 16 ; #
	db  0,  0, 0, $00
	db  0,  8, 0, $01
	db  8,  0, 0, $02
	db  8,  8, 0, $03
	db 16,  0, 0, $04
	db 16,  8, 0, $05
	db 24,  0, 0, $06
	db 24,  8, 0, $07
	db  0, 24, 0 | X_FLIP, $00
	db  0, 16, 0 | X_FLIP, $01
	db  8, 24, 0 | X_FLIP, $02
	db  8, 16, 0 | X_FLIP, $03
	db 16, 24, 0 | X_FLIP, $04
	db 16, 16, 0 | X_FLIP, $05
	db 24, 24, 0 | X_FLIP, $06
	db 24, 16, 0 | X_FLIP, $07

FacingWeirdTree1:
	db 4 ; #
	db  0,  0, 0, $04
	db  0,  8, 0, $05
	db  8,  0, 0, $06
	db  8,  8, 0, $07

FacingWeirdTree3:
	db 4 ; #
	db  0,  8, 0 | X_FLIP, $04
	db  0,  0, 0 | X_FLIP, $05
	db  8,  8, 0 | X_FLIP, $06
	db  8,  0, 0 | X_FLIP, $07

FacingBigDollAsym: ; big onix doll
	db 14 ; #
	db  0,  0, 0, $00
	db  0,  8, 0, $01
	db  8,  0, 0, $04
	db  8,  8, 0, $05
	db 16,  8, 0, $07
	db 24,  8, 0, $0a
	db  0, 24, 0, $03
	db  0, 16, 0, $02
	db  8, 24, 0 | X_FLIP, $02
	db  8, 16, 0, $06
	db 16, 24, 0, $09
	db 16, 16, 0, $08
	db 24, 24, 0 | X_FLIP, $04
	db 24, 16, 0, $0b

FacingBoulderDust1:
	db 4 ; #
	db  0,  0, 4, $7e
	db  0,  8, 4, $7e
	db  8,  0, 4, $7e
	db  8,  8, 4, $7e

FacingBoulderDust2:
	db 4 ; #
	db  0,  0, 4, $7f
	db  0,  8, 4, $7f
	db  8,  0, 4, $7f
	db  8,  8, 4, $7f

FacingGrass1:
	db 2 ; #
	db  8,  0, 4, $7d
	db  8,  8, 4 | X_FLIP, $7d

FacingGrass2:
	db 2 ; #
	db  9, -1, 4, $7d
	db  9,  9, 4 | X_FLIP, $7d

FacingSplash1:
	db 2 ; #
	db  8,  0, 4, $6f
	db  8,  8, 4 | X_FLIP, $6f

FacingSplash2:
	db 2 ; #
	db  9, -1, 4, $6f
	db  9,  9, 4 | X_FLIP, $6f

FacingCutTree:
	db 4 ; #
	db  4,  0, 0, $04
	db  4,  8, 0, $05
	db 12,  0, 2, $06
	db 12,  8, 2, $07

FacingApricorn:
	db 1 ; #
	db  0,  4, 0, $09

FacingBerry:
	db 1 ; #
	db 10,  3, 0, $08

FacingPickedFruit:
	db 1 ; #
	db  0,  0, 0, $0b

FacingBigGyarados1:
	db 16 ; #
	db  0,  0, 0, $00
	db  0,  8, 0, $01
	db  8,  0, 0, $02
	db  8,  8, 0, $03
	db  0, 16, 0, $04
	db  0, 24, 0, $05
	db  8, 16, 0, $06
	db  8, 24, 0, $07
	db 16,  0, 0, $08
	db 16,  8, 0, $09
	db 24,  0, 0, $0a
	db 24,  8, 0, $0b
	db 16, 16, 0, $0c
	db 16, 24, 0, $0d
	db 24, 16, 0, $0e
	db 24, 24, 0, $80

FacingBigGyarados2:
	db 16 ; #
	db  0,  0, 0, $00
	db  0,  8, 0, $01
	db  8,  0, 0, $81
	db  8,  8, 0, $82
	db  0, 16, 0, $83
	db  0, 24, 0, $84
	db  8, 16, 0, $85
	db  8, 24, 0, $86
	db 16,  0, 0, $87
	db 16,  8, 0, $88
	db 24,  0, 0, $89
	db 24,  8, 0, $8a
	db 16, 16, 0, $8b
	db 16, 24, 0, $8c
	db 24, 16, 0, $8d
	db 24, 24, 0, $8e

FacingStepDownFlip:
	db 4 ; #
	db  0,  0, 0 | X_FLIP, $01
	db  0,  8, 0 | X_FLIP, $00
	db  8,  0, 2 | X_FLIP, $03
	db  8,  8, 2 | X_FLIP, $02

FacingStepUpFlip:
	db 4 ; #
	db  0,  0, 0 | X_FLIP, $05
	db  0,  8, 0 | X_FLIP, $04
	db  8,  0, 2 | X_FLIP, $07
	db  8,  8, 2 | X_FLIP, $06

FacingPokecomNews:
	db 4 ; #
	db  4,  0, 0, $08
	db  4,  8, 0, $09
	db 12,  0, 0, $0a
	db 12,  8, 0, $0b

FacingArchTreeDown:
	db 2 ; #
	db 12, 0, 0, $08
	db 12, 8, 0, $0b

FacingArchTreeUp:
	db 2 ; #
	db 12, 0, 0, $0a
	db 12, 8, 0, $09

FacingArchTreeLeft:
	db 1 ; #
	db 12, 8, 0, $09

FacingArchTreeRight:
	db 1 ; #
	db 12, 0, 0, $08

FacingSailboatTop:
	db 12 ; #
	db  0,   8, 0, $00
	db  0,  16, 0, $01
	db  8,   8, 0, $02
	db  8,  16, 0, $03
	db  0,  24, 0, $04
	db  0,  32, 0, $05
	db  8,  24, 0, $06
	db  8,  32, 0, $07
	db -8,  16, 0, $08
	db -8,  24, 0, $09
	db  8,  -8, 0, $0a
	db  8,   0, 0, $0b

FacingSailboatBottom:
	db 12 ; #
	db 16,   8, 0, $80
	db 16,  16, 0, $81
	db 24,   8, 0, $82
	db 24,  16, 0, $83
	db 16,  -8, 0, $84
	db 16,   0, 0, $85
	db 24,  -8, 0, $86
	db 24,   0, 0, $87
	db 16,  24, 0, $88
	db 16,  32, 0, $89
	db 24,  24, 0, $8a
	db 24,  32, 0, $8b
