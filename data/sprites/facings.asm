Facings:
; entries correspond to FACING_* constants (see constants/map_object_constants.asm)
	table_width 2
	dw FacingStepDown0        ; FACING_STEP_DOWN_0
	dw FacingStepDown1        ; FACING_STEP_DOWN_1
	dw FacingStepDown2        ; FACING_STEP_DOWN_2
	dw FacingStepDown3        ; FACING_STEP_DOWN_3
	dw FacingStepUp0          ; FACING_STEP_UP_0
	dw FacingStepUp1          ; FACING_STEP_UP_1
	dw FacingStepUp2          ; FACING_STEP_UP_2
	dw FacingStepUp3          ; FACING_STEP_UP_3
	dw FacingStepLeft0        ; FACING_STEP_LEFT_0
	dw FacingStepLeft1        ; FACING_STEP_LEFT_1
	dw FacingStepLeft2        ; FACING_STEP_LEFT_2
	dw FacingStepLeft3        ; FACING_STEP_LEFT_3
	dw FacingStepRight0       ; FACING_STEP_RIGHT_0
	dw FacingStepRight1       ; FACING_STEP_RIGHT_1
	dw FacingStepRight2       ; FACING_STEP_RIGHT_2
	dw FacingStepRight3       ; FACING_STEP_RIGHT_3
	dw FacingFishDown         ; FACING_FISH_DOWN
	dw FacingFishUp           ; FACING_FISH_UP
	dw FacingFishLeft         ; FACING_FISH_LEFT
	dw FacingFishRight        ; FACING_FISH_RIGHT
	dw FacingEmote            ; FACING_EMOTE
	dw FacingShadow           ; FACING_SHADOW
	dw FacingBigDollAsym      ; FACING_BIG_DOLL_ASYM
	dw FacingBigDollSym       ; FACING_BIG_DOLL_SYM
	dw FacingWeirdTree0       ; FACING_WEIRD_TREE_0
	dw FacingWeirdTree1       ; FACING_WEIRD_TREE_1
	dw FacingWeirdTree2       ; FACING_WEIRD_TREE_2
	dw FacingWeirdTree3       ; FACING_WEIRD_TREE_3
	dw FacingBoulderDust1     ; FACING_BOULDER_DUST_1
	dw FacingBoulderDust2     ; FACING_BOULDER_DUST_2
	dw FacingGrass1           ; FACING_GRASS_1
	dw FacingGrass2           ; FACING_GRASS_2
	dw FacingSplash1          ; FACING_SPLASH_1
	dw FacingSplash2          ; FACING_SPLASH_2
	dw FacingCutTree          ; FACING_CUT_TREE
	dw FacingApricorn         ; FACING_APRICORN
	dw FacingBerry            ; FACING_BERRY
	dw FacingPickedFruit      ; FACING_PICKED_FRUIT
	dw FacingBigGyarados1     ; FACING_BIG_GYARADOS_1
	dw FacingBigGyarados2     ; FACING_BIG_GYARADOS_2
	dw FacingStepDownFlip     ; FACING_STEP_DOWN_FLIP
	dw FacingStepUpFlip       ; FACING_STEP_UP_FLIP
	dw FacingPokecomNews      ; FACING_POKECOM_NEWS
	dw FacingMuseumDrillDown  ; FACING_MUSEUM_DRILL_DOWN
	dw FacingMuseumDrillUp    ; FACING_MUSEUM_DRILL_UP
	dw FacingArchTreeLeft     ; FACING_ARCH_TREE_LEFT
	dw FacingArchTreeRight    ; FACING_ARCH_TREE_RIGHT
	dw FacingSailboatTop      ; FACING_SAILBOAT_TOP
	dw FacingSailboatBottom   ; FACING_SAILBOAT_BOTTOM
	dw FacingAlolanExeggutor0 ; FACING_ALOLAN_EXEGGUTOR_0
	dw FacingAlolanExeggutor1 ; FACING_ALOLAN_EXEGGUTOR_1
	dw FacingAlolanExeggutor2 ; FACING_ALOLAN_EXEGGUTOR_2
	dw FacingAlolanExeggutor3 ; FACING_ALOLAN_EXEGGUTOR_3
	dw FacingTinyWindows0     ; FACING_TINY_WINDOWS_0
	dw FacingTinyWindows1     ; FACING_TINY_WINDOWS_1
	dw FacingTinyWindows2     ; FACING_TINY_WINDOWS_2
	dw FacingTinyWindows3     ; FACING_TINY_WINDOWS_3
	dw FacingTinyWindows4     ; FACING_TINY_WINDOWS_4
	dw FacingTinyWindows5     ; FACING_TINY_WINDOWS_5
	dw FacingTinyWindows6     ; FACING_TINY_WINDOWS_6
	dw FacingMicrophone       ; FACING_MICROPHONE
	assert_table_length NUM_FACINGS
	dw 0 ; end

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
	db  8,  0, RELATIVE_ATTRIBUTES, $02
	db  8,  8, RELATIVE_ATTRIBUTES, $03

FacingStepDown1:
	db 4 ; #
	db  0,  0, 0, $80
	db  0,  8, 0, $81
	db  8,  0, RELATIVE_ATTRIBUTES, $82
	db  8,  8, RELATIVE_ATTRIBUTES, $83

FacingStepDown3:
	db 4 ; #
	db  0,  8, OAM_XFLIP, $80
	db  0,  0, OAM_XFLIP, $81
	db  8,  8, RELATIVE_ATTRIBUTES | OAM_XFLIP, $82
	db  8,  0, RELATIVE_ATTRIBUTES | OAM_XFLIP, $83

FacingStepUp0:
FacingStepUp2:
	db 4 ; #
	db  0,  0, 0, $04
	db  0,  8, 0, $05
	db  8,  0, RELATIVE_ATTRIBUTES, $06
	db  8,  8, RELATIVE_ATTRIBUTES, $07

FacingStepUp1:
	db 4 ; #
	db  0,  0, 0, $84
	db  0,  8, 0, $85
	db  8,  0, RELATIVE_ATTRIBUTES, $86
	db  8,  8, RELATIVE_ATTRIBUTES, $87

FacingStepUp3:
	db 4 ; #
	db  0,  8, OAM_XFLIP, $84
	db  0,  0, OAM_XFLIP, $85
	db  8,  8, RELATIVE_ATTRIBUTES | OAM_XFLIP, $86
	db  8,  0, RELATIVE_ATTRIBUTES | OAM_XFLIP, $87

FacingStepLeft0:
FacingStepLeft2:
	db 4 ; #
	db  0,  0, 0, $08
	db  0,  8, 0, $09
	db  8,  0, RELATIVE_ATTRIBUTES, $0a
	db  8,  8, RELATIVE_ATTRIBUTES, $0b

FacingStepRight0:
FacingStepRight2:
	db 4 ; #
	db  0,  8, OAM_XFLIP, $08
	db  0,  0, OAM_XFLIP, $09
	db  8,  8, RELATIVE_ATTRIBUTES | OAM_XFLIP, $0a
	db  8,  0, RELATIVE_ATTRIBUTES | OAM_XFLIP, $0b

FacingStepLeft1:
FacingStepLeft3:
	db 4 ; #
	db  0,  0, 0, $88
	db  0,  8, 0, $89
	db  8,  0, RELATIVE_ATTRIBUTES, $8a
	db  8,  8, RELATIVE_ATTRIBUTES, $8b

FacingStepRight1:
FacingStepRight3:
	db 4 ; #
	db  0,  8, OAM_XFLIP, $88
	db  0,  0, OAM_XFLIP, $89
	db  8,  8, RELATIVE_ATTRIBUTES | OAM_XFLIP, $8a
	db  8,  0, RELATIVE_ATTRIBUTES | OAM_XFLIP, $8b

FacingFishDown:
	db 5 ; #
	db  0,  0, 0, $00
	db  0,  8, 0, $01
	db  8,  0, RELATIVE_ATTRIBUTES, $02
	db  8,  8, RELATIVE_ATTRIBUTES, $03
	db 16,  0, ABSOLUTE_TILE_ID, $7a

FacingFishUp:
	db 5 ; #
	db  0,  0, 0, $04
	db  0,  8, 0, $05
	db  8,  0, RELATIVE_ATTRIBUTES, $06
	db  8,  8, RELATIVE_ATTRIBUTES, $07
	db -8,  0, ABSOLUTE_TILE_ID, $7a

FacingFishLeft:
	db 5 ; #
	db  0,  0, 0, $08
	db  0,  8, 0, $09
	db  8,  0, RELATIVE_ATTRIBUTES, $0a
	db  8,  8, RELATIVE_ATTRIBUTES, $0b
	db  5, -8, ABSOLUTE_TILE_ID | OAM_XFLIP, $7b

FacingFishRight:
	db 5 ; #
	db  0,  8, OAM_XFLIP, $08
	db  0,  0, OAM_XFLIP, $09
	db  8,  8, RELATIVE_ATTRIBUTES | OAM_XFLIP, $0a
	db  8,  0, RELATIVE_ATTRIBUTES | OAM_XFLIP, $0b
	db  5, 16, ABSOLUTE_TILE_ID, $7b

FacingEmote:
	db 4 ; #
	db  0,  0, ABSOLUTE_TILE_ID, $60
	db  0,  8, ABSOLUTE_TILE_ID, $61
	db  8,  0, ABSOLUTE_TILE_ID, $62
	db  8,  8, ABSOLUTE_TILE_ID, $63

FacingShadow:
	db 2 ; #
	db  0,  0, ABSOLUTE_TILE_ID, $7c
	db  0,  8, ABSOLUTE_TILE_ID | OAM_XFLIP, $7c

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
	db  0, 24, OAM_XFLIP, $00
	db  0, 16, OAM_XFLIP, $01
	db  8, 24, OAM_XFLIP, $02
	db  8, 16, OAM_XFLIP, $03
	db 16, 24, OAM_XFLIP, $04
	db 16, 16, OAM_XFLIP, $05
	db 24, 24, OAM_XFLIP, $06
	db 24, 16, OAM_XFLIP, $07

FacingWeirdTree1:
	db 4 ; #
	db  0,  0, 0, $04
	db  0,  8, 0, $05
	db  8,  0, 0, $06
	db  8,  8, 0, $07

FacingWeirdTree3:
	db 4 ; #
	db  0,  8, OAM_XFLIP, $04
	db  0,  0, OAM_XFLIP, $05
	db  8,  8, OAM_XFLIP, $06
	db  8,  0, OAM_XFLIP, $07

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
	db  8, 24, OAM_XFLIP, $02
	db  8, 16, 0, $06
	db 16, 24, 0, $09
	db 16, 16, 0, $08
	db 24, 24, OAM_XFLIP, $04
	db 24, 16, 0, $0b

FacingBoulderDust1:
	db 4 ; #
	db  0,  0, ABSOLUTE_TILE_ID, $7e
	db  0,  8, ABSOLUTE_TILE_ID, $7e
	db  8,  0, ABSOLUTE_TILE_ID, $7e
	db  8,  8, ABSOLUTE_TILE_ID, $7e

FacingBoulderDust2:
	db 4 ; #
	db  0,  0, ABSOLUTE_TILE_ID, $7f
	db  0,  8, ABSOLUTE_TILE_ID, $7f
	db  8,  0, ABSOLUTE_TILE_ID, $7f
	db  8,  8, ABSOLUTE_TILE_ID, $7f

FacingGrass1:
	db 2 ; #
	db  8,  0, ABSOLUTE_TILE_ID, $7d
	db  8,  8, ABSOLUTE_TILE_ID | OAM_XFLIP, $7d

FacingGrass2:
	db 2 ; #
	db  9, -1, ABSOLUTE_TILE_ID, $7d
	db  9,  9, ABSOLUTE_TILE_ID | OAM_XFLIP, $7d

FacingSplash1:
	db 2 ; #
	db  8,  0, ABSOLUTE_TILE_ID, $6f
	db  8,  8, ABSOLUTE_TILE_ID | OAM_XFLIP, $6f

FacingSplash2:
	db 2 ; #
	db  9, -1, ABSOLUTE_TILE_ID, $6f
	db  9,  9, ABSOLUTE_TILE_ID | OAM_XFLIP, $6f

FacingCutTree:
	db 4 ; #
	db  4,  0, 0, $04
	db  4,  8, 0, $05
	db 12,  0, RELATIVE_ATTRIBUTES, $06
	db 12,  8, RELATIVE_ATTRIBUTES, $07

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
	db  0,  0, OAM_XFLIP, $01
	db  0,  8, OAM_XFLIP, $00
	db  8,  0, RELATIVE_ATTRIBUTES | OAM_XFLIP, $03
	db  8,  8, RELATIVE_ATTRIBUTES | OAM_XFLIP, $02

FacingStepUpFlip:
	db 4 ; #
	db  0,  0, OAM_XFLIP, $05
	db  0,  8, OAM_XFLIP, $04
	db  8,  0, RELATIVE_ATTRIBUTES | OAM_XFLIP, $07
	db  8,  8, RELATIVE_ATTRIBUTES | OAM_XFLIP, $06

FacingPokecomNews:
FacingMicrophone:
	db 4 ; #
	db  4,  0, 0, $08
	db  4,  8, 0, $09
	db 12,  0, 0, $0a
	db 12,  8, 0, $0b

FacingMuseumDrillDown:
	db 2 ; #
	db 12, 0, 0, $08
	db 12, 8, 0, $0b

FacingMuseumDrillUp:
	db 2 ; #
	db 12, 0, 0, $0a
	db 12, 8, 0, $09

FacingArchTreeLeft:
	db 2 ; #
	db  4,  0, 0, $08
	db 12,  0, 0, $0a

FacingArchTreeRight:
	db 2 ; #
	db  4,  8, 0, $09
	db 12,  8, 0, $0b

FacingSailboatTop:
	db 8 ; #
	db -8, 16, 0, $00
	db  0,  8, 0, $01
	db  8,  0, 0, $02
	db  8,  8, 0, $03
	db  0, 16, 0, $04
	db  0, 24, 0, $05
	db  8, 16, 0, $06
	db  8, 24, 0, $07

FacingSailboatBottom:
	db 8 ; #
	db 16,  0, 0, $08
	db 16,  8, 0, $09
	db 24,  0, 0, $0a
	db 24,  8, 0, $0b
	db 16, 16, 0, $80
	db 16, 24, 0, $81
	db 24, 16, 0, $82
	db 24, 24, 0, $83

FacingAlolanExeggutor0:
FacingAlolanExeggutor2:
	db 7 ; #
	db  0,  0, NEXT_PALETTE, $00
	db  0,  8, NEXT_PALETTE, $01
	db  8,  0, NEXT_PALETTE, $02
	db  8,  8, NEXT_PALETTE, $03
	db -8,  0, 0, $0c
	db -8,  8, 0, $0d
	db  0,  8, 0, $0e

FacingAlolanExeggutor1:
	db 7 ; #
	db  0,  0, NEXT_PALETTE, $04
	db  0,  8, NEXT_PALETTE, $05
	db  8,  0, NEXT_PALETTE, $06
	db  8,  8, NEXT_PALETTE, $07
	db -8,  0, 0, $0c
	db -8,  8, 0, $0d
	db  0,  8, 0, $80

FacingAlolanExeggutor3:
	db 7 ; #
	db  0,  0, NEXT_PALETTE, $08
	db  0,  8, NEXT_PALETTE, $09
	db  8,  0, NEXT_PALETTE, $0a
	db  8,  8, NEXT_PALETTE, $0b
	db -8,  0, OAM_XFLIP, $0d
	db -8,  8, OAM_XFLIP, $0c
	db  0,  8, 0, $80

FacingTinyWindows0:
	db 2 ; #
	db 12,  8, 0, $85
	db  4, 20, 0, $84

FacingTinyWindows1:
	db 3 ; #
	db 12, -12, 0, $84
	db 12,   4, 0, $84
	db 12,  20, 0, $84

FacingTinyWindows2:
	db 2 ; #
	db  8,  4, 0, $84
	db  8, 20, 0, $84

FacingTinyWindows3:
	db 2 ; #
	db 20,  4, 0, $84
	db 20, 20, 0, $84

FacingTinyWindows4:
	db 6 ; #
	db  4, -16, 0, $86
	db  4,   8, OAM_XFLIP, $86
	db 12, -16, 0, $88
	db 12,  -8, 0, $87
	db 12,   0, OAM_XFLIP, $87
	db 12,   8, OAM_XFLIP, $88

FacingTinyWindows5:
	db 6 ; #
	db  8, -12, 0, $84
	db  8,  -4, 0, $84
	db  8,   4, 0, $84
	db 24, -12, 0, $84
	db 24,  -4, 0, $84
	db 24,   4, 0, $84

FacingTinyWindows6:
	db 6 ; #
	db  8, -12, 0, $84
	db  8,  -4, 0, $84
	db  8,   4, 0, $84
	db 20, -12, 0, $84
	db 20,  -4, 0, $84
	db 20,   4, 0, $84
