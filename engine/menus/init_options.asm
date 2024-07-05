DEF NUM_INITIAL_OPTIONS EQU 9

SetInitialOptions:
	ld a, $10
	ld [wMusicFade], a

	xor a ; MUSIC_NONE
	ld [wMusicFadeIDLo], a
	ld [wMusicFadeIDHi], a
	ld c, 8
	call DelayFrames

	call ClearBGPalettes
	call LoadFrame

	hlcoord 0, 0
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
	xor a
	rst ByteFill

	hlcoord 0, 0, wAttrmap
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
	xor a
	rst ByteFill

	hlcoord 1, 17, wAttrmap
	ld a, $01
	ld c, 12
.attr_loop
	ld [hli], a
	dec c
	jr nz, .attr_loop

	ld hl, .BGPalettes
	ld de, wBGPals1
	ld bc, 2 palettes
	call FarCopyColorWRAM

	ld hl, .BGTiles
	ld de, vTiles2 tile $00
	lb bc, BANK(.BGTiles), 15
	call DecompressRequest2bpp

	farcall ApplyPals

	call ApplyAttrAndTilemapInVBlank
	call SetDefaultBGPAndOBP

	ld hl, .InitialOptionsText
	call PrintText

	ld hl, hInMenu
	ld a, [hl]
	push af
	xor a
	ld [wJumptableIndex], a
	inc a
	ld [hl], a

;	call ClearBGPalettes

.rerender
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 0
	ld a, " "
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	rst ByteFill

	hlcoord 0, 0
	ld a, $01 ; left
	ld bc, SCREEN_WIDTH - 2
	ld d, SCREEN_HEIGHT
.edge_loop
	ld [hli], a
	inc a ; right
	add hl, bc
	ld [hli], a
	dec a ; left
	dec d
	jr nz, .edge_loop

	hlcoord 2, 0
	ld de, .InitialOptionsString
	rst PlaceString

	hlcoord 1, 17
	ld a, $03
	ld d, 12
.select_start_loop
	ld [hli], a
	inc a
	dec d
	jr nz, .select_start_loop

;	ld a, CGB_PLAIN
;	call GetCGBLayout
;	call SetDefaultBGPAndOBP

	ld a, [wJumptableIndex]
	push af
	xor a
	ld [wJumptableIndex], a
	ldh [hJoyPressed], a
	ld c, NUM_INITIAL_OPTIONS
.print_text_loop ; this next will display the settings of each option when the menu is opened
	push bc
	xor a
	ldh [hJoyLast], a
	call GetInitialOptionPointer
	pop bc
	ld hl, wJumptableIndex
	inc [hl]
	dec c
	jr nz, .print_text_loop
	pop af
	ld [wJumptableIndex], a

	ld a, $1
	ldh [hBGMapMode], a
	call ApplyTilemapInVBlank

.joypad_loop
	call JoyTextDelay
	ldh a, [hJoyPressed]
	bit SELECT_F, a
	jr nz, .ShowDescription
	and START | B_BUTTON
	jr nz, .ExitOptions
	call InitialOptionsControl
	jr c, .DPad
	call GetInitialOptionPointer
	jr c, .ExitOptions
	; fallthrough

.DPad:
	call InitialOptions_UpdateCursorPosition
	ld c, 3
	call DelayFrames
	jr .joypad_loop

.ExitOptions:
	ld hl, wInitialOptions2
	res RESET_INIT_OPTS, [hl]
	ld de, SFX_TRANSACTION
	call PlaySFX
	call WaitSFX
	pop af
	ldh [hInMenu], a
	ret

.ShowDescription:
	ld hl, InitialOptionDescriptions
	ld a, [wJumptableIndex]
	add a
	ld d, 0
	ld e, a
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText
	jmp .rerender

.InitialOptionsText:
	text_far _InitialOptionsText
	text_end

.BGPalettes:
INCLUDE "gfx/new_game/init_bg.pal"

.BGTiles:
INCBIN "gfx/new_game/init_bg.2bpp.lz"

.InitialOptionsString:
	text  "Natures"
	next1 "            :"
	next1 "Abilities"
	next1 "            :"
	next1 "Phys/Spcl split"
	next1 "            :"
	next1 "EV gain"
	next1 "            :"
	next1 "Exp. scaling"
	next1 "            :"
	next1 "Affection bonus"
	next1 "            :"
	next1 "Color variation"
	next1 "            :"
	next1 "Perfect stats"
	next1 "            :"
	next1 "Traded <PK><MN> obey"
	next1 "            :"
	done

GetInitialOptionPointer:
	call StandardStackJumpTable

; These are in the same order as InitialOptionDescriptions,
; not the *_OPT bit order!
.Pointers:
	table_width 2, GetInitialOptionPointer.Pointers
	dw InitialOptions_Natures
	dw InitialOptions_Abilities
	dw InitialOptions_PSS
	dw InitialOptions_EVs
	dw InitialOptions_ExpScaling
	dw InitialOptions_AffectionBonus
	dw InitialOptions_ColorVariation
	dw InitialOptions_PerfectIVs
	dw InitialOptions_TradedMon
	assert_table_length NUM_INITIAL_OPTIONS

InitialOptions_Natures:
	ld hl, wInitialOptions
	ldh a, [hJoyPressed]
	and D_LEFT | D_RIGHT | A_BUTTON
	jr nz, .Toggle
	bit NATURES_OPT, [hl]
	jr z, .SetNo
	jr .SetYes
.Toggle
	bit NATURES_OPT, [hl]
	jr z, .SetYes
.SetNo:
	res NATURES_OPT, [hl]
	ld de, NoString
	jr .Display
.SetYes:
	set NATURES_OPT, [hl]
	ld de, YesString
.Display:
	hlcoord 15, 1
	rst PlaceString
	and a
	ret

InitialOptions_Abilities:
	ld hl, wInitialOptions
	ldh a, [hJoyPressed]
	and D_LEFT | D_RIGHT | A_BUTTON
	jr nz, .Toggle
	bit ABILITIES_OPT, [hl]
	jr z, .SetNo
	jr .SetYes
.Toggle
	bit ABILITIES_OPT, [hl]
	jr z, .SetYes
.SetNo:
	res ABILITIES_OPT, [hl]
	ld de, NoString
	jr .Display
.SetYes:
	set ABILITIES_OPT, [hl]
	ld de, YesString
.Display:
	hlcoord 15, 3
	rst PlaceString
	and a
	ret

InitialOptions_PSS:
	ld hl, wInitialOptions
	ldh a, [hJoyPressed]
	and D_LEFT | D_RIGHT | A_BUTTON
	jr nz, .Toggle
	bit PSS_OPT, [hl]
	jr z, .SetNo
	jr .SetYes
.Toggle
	bit PSS_OPT, [hl]
	jr z, .SetYes
.SetNo:
	res PSS_OPT, [hl]
	ld de, NoString
	jr .Display
.SetYes:
	set PSS_OPT, [hl]
	ld de, YesString
.Display:
	hlcoord 15, 5
	rst PlaceString
	and a
	ret

InitialOptions_EVs:
	ld hl, wInitialOptions2
	push bc
	ld b, EV_OPTMASK
	ldh a, [hJoyPressed]
	ld c, a
	and D_LEFT | D_RIGHT | A_BUTTON
	jr z, .input_done
	ld a, [hl]
.redo
	inc a
	bit D_LEFT_F, c
	jr z, .finish_change
	dec a
	dec a
.finish_change
	and b
	cp b
	jr z, .redo
	ld c, a
	ld a, [hl]
	and b
	xor [hl]
	or c
	ld [hl], a
.input_done
	pop bc
	ld a, [hl]
	ld de, AllString
	rrca
	jr c, .Display
	rrca
	ld de, ModernString
	jr c, .Display
	ld de, NoString
.Display:
	hlcoord 15, 7
	rst PlaceString
	and a
	ret

InitialOptions_ExpScaling:
	ld hl, wInitialOptions
	ldh a, [hJoyPressed]
	and D_LEFT | D_RIGHT | A_BUTTON
	jr nz, .Toggle
	bit SCALED_EXP_OPT, [hl]
	jr z, .SetNo
	jr .SetYes
.Toggle
	bit SCALED_EXP_OPT, [hl]
	jr z, .SetYes
.SetNo:
	res SCALED_EXP_OPT, [hl]
	ld de, NoString
	jr .Display
.SetYes:
	set SCALED_EXP_OPT, [hl]
	ld de, YesString
.Display:
	hlcoord 15, 9
	rst PlaceString
	and a
	ret

InitialOptions_AffectionBonus:
	ld hl, wInitialOptions
	ldh a, [hJoyPressed]
	and D_LEFT | D_RIGHT | A_BUTTON
	jr nz, .Toggle
	bit AFFECTION_OPT, [hl]
	jr z, .SetNo
	jr .SetYes
.Toggle
	bit AFFECTION_OPT, [hl]
	jr z, .SetYes
.SetNo:
	res AFFECTION_OPT, [hl]
	ld de, NoString
	jr .Display
.SetYes:
	set AFFECTION_OPT, [hl]
	ld de, YesString
.Display:
	hlcoord 15, 11
	rst PlaceString
	and a
	ret

InitialOptions_ColorVariation:
	ld hl, wInitialOptions
	ldh a, [hJoyPressed]
	and D_LEFT | D_RIGHT | A_BUTTON
	jr nz, .Toggle
	bit COLOR_VARY_OPT, [hl]
	jr z, .SetNo
	jr .SetYes
.Toggle
	bit COLOR_VARY_OPT, [hl]
	jr z, .SetYes
.SetNo:
	res COLOR_VARY_OPT, [hl]
	ld de, NoString
	jr .Display
.SetYes:
	set COLOR_VARY_OPT, [hl]
	ld de, YesString
.Display:
	hlcoord 15, 13
	rst PlaceString
	and a
	ret

InitialOptions_PerfectIVs:
	ld hl, wInitialOptions
	ldh a, [hJoyPressed]
	and D_LEFT | D_RIGHT | A_BUTTON
	jr nz, .Toggle
	bit PERFECT_IVS_OPT, [hl]
	jr z, .SetNo
	jr .SetYes
.Toggle
	bit PERFECT_IVS_OPT, [hl]
	jr z, .SetYes
.SetNo:
	res PERFECT_IVS_OPT, [hl]
	ld de, NoString
	jr .Display
.SetYes:
	set PERFECT_IVS_OPT, [hl]
	ld de, YesString
.Display:
	hlcoord 15, 15
	rst PlaceString
	and a
	ret

InitialOptions_TradedMon:
	ld hl, wInitialOptions
	ldh a, [hJoyPressed]
	and D_LEFT | D_RIGHT | A_BUTTON
	jr nz, .Toggle
	bit TRADED_AS_OT_OPT, [hl]
	jr z, .SetNo
	jr .SetYes
.Toggle
	bit TRADED_AS_OT_OPT, [hl]
	jr z, .SetYes
.SetNo:
	res TRADED_AS_OT_OPT, [hl]
	ld de, NoString
	jr .Display
.SetYes:
	set TRADED_AS_OT_OPT, [hl]
	ld de, YesString
.Display:
	hlcoord 15, 17
	rst PlaceString
	and a
	ret

NoString:
	db "No @"
YesString:
	db "Yes@"
AllString:
	db "All@"
ModernString:
	db "{-3d:MODERN_EV_LIMIT}@"

InitialOptionsControl:
	ld hl, wJumptableIndex
	ldh a, [hJoyLast]
	cp D_DOWN
	jr z, .DownPressed
	cp D_UP
	jr z, .UpPressed
	and a
	ret

.DownPressed:
	ld a, [hl] ; load the cursor position to a
	cp NUM_INITIAL_OPTIONS - 1
	jr nz, .Increase
	ld [hl], -1
.Increase:
	inc [hl]
	scf
	ret

.UpPressed:
	ld a, [hl]
	and a
	jr nz, .Decrease
	ld [hl], NUM_INITIAL_OPTIONS
.Decrease:
	dec [hl]
	scf
	ret

InitialOptions_UpdateCursorPosition:
	hlcoord 1, 0
	ld de, SCREEN_WIDTH
	ld c, SCREEN_HEIGHT - 1
.loop
	ld [hl], " "
	add hl, de
	dec c
	jr nz, .loop
	; hlcoord 1, [wJumptableIndex] * 2
	ld a, [wJumptableIndex]
	add a
	ld hl, wTilemap
	ld bc, SCREEN_WIDTH
	rst AddNTimes
	inc hl
	ld [hl], "▶"
	ret

INCLUDE "data/options/descriptions.asm"
