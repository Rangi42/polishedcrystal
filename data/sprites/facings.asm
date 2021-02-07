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
	dw FacingSailboat       ; FACING_SAILBOAT
FacingsEnd: dw 0

NUM_FACINGS EQU (FacingsEnd - Facings) / 2

; Tables used as a reference to transform OAM data.

; Format:
;	db y, x, attributes, tile index

FacingStepDown0:
FacingStepDown2:
FacingWeirdTree0:
FacingWeirdTree2:
	db 2 ; #
	db  0,  0, 0, $00
	db  0,  8, 0, $02

FacingStepDown1:
	db 2 ; #
	db  0,  0, 0, $80
	db  0,  8, 0, $82

FacingStepDown3:
	db 2 ; #
	db  0,  8, 0 | X_FLIP, $80
	db  0,  0, 0 | X_FLIP, $82

FacingStepUp0:
FacingStepUp2:
	db 2 ; #
	db  0,  0, 0, $04
	db  0,  8, 0, $06

FacingStepUp1:
	db 2 ; #
	db  0,  0, 0, $84
	db  0,  8, 0, $86

FacingStepUp3:
	db 2 ; #
	db  0,  8, 0 | X_FLIP, $84
	db  0,  0, 0 | X_FLIP, $86

FacingStepLeft0:
FacingStepLeft2:
	db 2 ; #
	db  0,  0, 0, $08
	db  0,  8, 0, $0a

FacingStepRight0:
FacingStepRight2:
	db 2 ; #
	db  0,  8, 0 | X_FLIP, $08
	db  0,  0, 0 | X_FLIP, $0a

FacingStepLeft1:
FacingStepLeft3:
	db 2 ; #
	db  0,  0, 0, $88
	db  0,  8, 0, $8a

FacingStepRight1:
FacingStepRight3:
	db 2 ; #
	db  0,  8, 0 | X_FLIP, $88
	db  0,  0, 0 | X_FLIP, $8a

FacingFishDown:
	db 3 ; #
	db  0,  0, 0, $00
	db  0,  8, 0, $02
	db 16,  0, 4, $7a ; XXX

FacingFishUp:
	db 3 ; #
	db  0,  0, 0, $04
	db  0,  8, 0, $06
	db -8,  0, 4, $7a ; XXX

FacingFishLeft:
	db 3 ; #
	db  0,  0, 0, $08
	db  0,  8, 0, $0a
	db  5, -8, 4 | X_FLIP, $7b ; XXX

FacingFishRight:
	db 3 ; #
	db  0,  8, 0 | X_FLIP, $08
	db  0,  0, 0 | X_FLIP, $0a
	db  5, 16, 4, $7b ; XXX

FacingEmote:
	db 2 ; #
	db  0,  0, 4, $60
	db  0,  8, 4, $62

FacingShadow:
	db 2 ; #
	db  0,  0, 4, $76
	db  0,  8, 4 | X_FLIP, $76

FacingBigDollSym: ; big snorlax or lapras doll
	db 8 ; #
	db  0,  0, 0, $00
	db  0,  8, 0, $02
	db 16,  0, 0, $04
	db 16,  8, 0, $06
	db  0, 24, 0 | X_FLIP, $00
	db  0, 16, 0 | X_FLIP, $02
	db 16, 24, 0 | X_FLIP, $04
	db 16, 16, 0 | X_FLIP, $06

FacingWeirdTree1:
	db 2 ; #
	db  0,  0, 0, $04
	db  0,  8, 0, $06

FacingWeirdTree3:
	db 2 ; #
	db  0,  8, 0 | X_FLIP, $04
	db  0,  0, 0 | X_FLIP, $06

FacingBigDollAsym: ; big onix doll
	db 7 ; #
	db  0,  0, 0, $00
	db  0,  8, 0, $02
	db  0, 16, 0, $04
	db  0, 24, 0, $06
	db 16,  8, 0, $08
	db 16, 16, 0, $0a
	db 16, 24, 0, $80

FacingBoulderDust1:
	db 2 ; #
	db  0,  0, 4, $7c
	db  0,  8, 4, $7c

FacingBoulderDust2:
	db 2 ; #
	db  0,  0, 4, $7e
	db  0,  8, 4, $7e

FacingGrass1:
	db 2 ; #
	db  0,  0, 4, $78
	db  0,  8, 4 | X_FLIP, $78

FacingGrass2:
	db 2 ; #
	db  1, -1, 4, $78
	db  1,  9, 4 | X_FLIP, $78

FacingSplash1:
	db 2 ; #
	db  0,  0, 4, $7a
	db  0,  8, 4 | X_FLIP, $7a

FacingSplash2:
	db 2 ; #
	db  1, -1, 4, $7a
	db  1,  9, 4 | X_FLIP, $7a

FacingCutTree:
	db 2 ; #
	db  4,  0, 0, $04
	db  4,  8, 0, $06

FacingApricorn:
	db 1 ; #
	db  0,  4, 0, $0a

FacingBerry:
	db 1 ; #
	db 10,  3, 0, $08

FacingPickedFruit:
	db 0 ; #

FacingBigGyarados1:
	db 8 ; #
	db  0,  0, 0, $00
	db  0,  8, 0, $02
	db  0, 16, 0, $04
	db  0, 24, 0, $06
	db 16,  0, 0, $08
	db 16,  8, 0, $0a
	db 16, 16, 0, $0c
	db 16, 24, 0, $0e

FacingBigGyarados2:
	db 8 ; #
	db  0,  0, 0, $80
	db  0,  8, 0, $82
	db  0, 16, 0, $84
	db  0, 24, 0, $86
	db 16,  0, 0, $88
	db 16,  8, 0, $8a
	db 16, 16, 0, $8c
	db 16, 24, 0, $8e

FacingStepDownFlip:
	db 2 ; #
	db  0,  0, 0 | X_FLIP, $02
	db  0,  8, 0 | X_FLIP, $00

FacingStepUpFlip:
	db 2 ; #
	db  0,  0, 0 | X_FLIP, $06
	db  0,  8, 0 | X_FLIP, $04

FacingPokecomNews:
	db 2 ; #
	db  4,  0, 0, $08
	db  4,  8, 0, $0a

FacingArchTreeDown: ; XXX
	db 2 ; #
	db 12, 0, 0, $08
	db 12, 8, 0, $0b

FacingArchTreeUp: ; XXX
	db 2 ; #
	db 12, 0, 0, $0a
	db 12, 8, 0, $09

FacingArchTreeLeft: ; XXX
	db 1 ; #
	db 12, 8, 0, $09

FacingArchTreeRight: ; XXX
	db 1 ; #
	db 12, 0, 0, $08

FacingSailboat:
	db 9 ; #
	db -16, 16, 0, $00
	db   0,  0, 0, $02
	db   0,  8, 0, $04
	db   0, 16, 0, $06
	db   0, 24, 0, $08
	db  16,  0, 0, $0a
	db  16,  8, 0, $80
	db  16, 16, 0, $82
	db  16, 24, 0, $84
