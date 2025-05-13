DEF NUM_INITIAL_OPTIONS_PER_PAGE EQU 7

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

	hlcoord 1, 16, wAttrmap
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

	hlcoord 2, 1
	ld de, InitialOptionsString1
	rst PlaceString

	hlcoord 1, 16
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
	xor a
	ld [wCurOptionsPage], a
	call InitialOptionsMenu_LoadOptions

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
	ld d, a
	ld a, [wCurOptionsPage]
	and a
	ld a, d
	jr z, .page1
	add NUM_INITIAL_OPTIONS_PER_PAGE
.page1
	add a
	ld d, 0
	ld e, a
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText
	call InitialOptions_ReRender
	ld a, [wCurOptionsPage]
	and a
	ld de, InitialOptionsString1
	jr z, .Display
	ld de, InitialOptionsString2
.Display
	hlcoord 2, 1
	rst PlaceString
	call InitialOptionsMenu_LoadOptions
	jr .joypad_loop

.InitialOptionsText:
	text_far _InitialOptionsText
	text_end

.BGPalettes:
INCLUDE "gfx/new_game/init_bg.pal"

.BGTiles:
INCBIN "gfx/new_game/init_bg.2bpp.lz"

InitialOptionsString1:
	text  "Natures"
	next1 "            :"
	next1 "Abilities"
	next1 "            :"
	next1 "Phys/Spcl split"
	next1 "            :"
	next1 "EV gain"
	next1 "            :"
	next1 "Experience gain"
	next1 "            :"
	next1 "Affection bonus"
	next1 "            :"
	next1 "Next"
	done

InitialOptionsString2:
	text  "Real-time clock"
	next1 "            :"
	next1 "Perfect stats"
	next1 "            :"
	next1 "Traded <PK><MN> obey"
	next1 "            :"
	next1 "Evolve in battle"
	next1 "            :"
	next1 "Color variation"
	next1 "            :"
	next1 "            " ; no-optimize trailing string space
	next1 "            " ; no-optimize trailing string space
	next1 "Previous"
	done

InitialOptionsMenu_LoadOptions:
	ld a, [wJumptableIndex]
	push af
	xor a
	ld [wJumptableIndex], a
	ldh [hJoyPressed], a
	ld c, NUM_INITIAL_OPTIONS_PER_PAGE
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
	jmp ApplyTilemapInVBlank

GetInitialOptionPointer:
	ld a, [wCurOptionsPage]
	and a
	ld a, [wJumptableIndex]
	jr z, .page1
	add NUM_INITIAL_OPTIONS_PER_PAGE
.page1
	call StackJumpTable

; These are in the same order as InitialOptionDescriptions,
; not the *_OPT bit order!
.Pointers:
	table_width 2
	dw InitialOptions_Natures
	dw InitialOptions_Abilities
	dw InitialOptions_PSS
	dw InitialOptions_EVs
	dw InitialOptions_ExpScaling
	dw InitialOptions_AffectionBonus
	dw InitialOptions_Next

	dw InitialOptions_RTC
	dw InitialOptions_PerfectIVs
	dw InitialOptions_TradedMon
	dw InitialOptions_EvolveInBattle
	dw InitialOptions_ColorVariation
	dw DoNothing
	dw InitialOptions_Previous
	assert_table_length NUM_INITIAL_OPTIONS_PER_PAGE * 2

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
	hlcoord 15, 2
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
	hlcoord 15, 4
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
	hlcoord 15, 6
	rst PlaceString
	and a
	ret

InitialOptions_EVs:
	ld hl, wInitialOptions2
	ld d, EV_OPTMASK
	ldh a, [hJoyPressed]
	ld e, a
	and D_LEFT | D_RIGHT | A_BUTTON
	jr z, .input_done
	ld a, [hl]
.redo
	inc a
	bit D_LEFT_F, e
	jr z, .finish_change
	dec a
	dec a
.finish_change
	and d
	cp d
	jr z, .redo
	ld e, a
	ld a, [hl]
	and d
	xor [hl]
	or e
	ld [hl], a
.input_done
	ld a, [hl]
	ld de, AllString
	rrca
	jr c, .Display
	rrca
	ld de, ModernString
	jr c, .Display
	ld de, NoString
.Display:
	hlcoord 15, 8
	rst PlaceString
	and a
	ret

InitialOptions_ExpScaling:
	; set e to a sequential value for exp
	; 1 = old (unscaled), 2 = new (scaled), 3 = no
	ld e, 3
	ld hl, wInitialOptions2
	bit NO_EXP_OPT, [hl]
	dec hl
	jr nz, .got_value
	dec e ; 2
	assert wInitialOptions2 - 1 == wInitialOptions
	bit SCALED_EXP_OPT, [hl]
	jr nz, .got_value
	dec e ; 1
.got_value
	; check input
	ldh a, [hJoyPressed]
	and D_LEFT | D_RIGHT | A_BUTTON
	jr z, .no_input
	bit D_LEFT_F, a
	jr nz, .left_input
	; input right or A
	dec e
	jr z, .SetScaled ; from right, 1->2
.left_input
	dec e
	jr z, .SetNo ; from left, 1->3; from right, 2->3
.no_input
	dec e
	jr z, .SetUnscaled ; from none, is 1; from left, 2->1; from right, 3->1
	dec e
	jr z, .SetScaled ; from none, is 2; from left, 3->2
	; fallthrough; from none, is 3
.SetNo:
	res SCALED_EXP_OPT, [hl]
	inc hl
	set NO_EXP_OPT, [hl]
	ld de, NoString
	jr .Display
.SetUnscaled:
	res SCALED_EXP_OPT, [hl]
	inc hl
	res NO_EXP_OPT, [hl]
	ld de, .Old
	jr .Display
.SetScaled:
	set SCALED_EXP_OPT, [hl]
	inc hl
	res NO_EXP_OPT, [hl]
	ld de, .New
.Display:
	hlcoord 15, 10
	rst PlaceString
	and a
	ret

.Old:
	db "Old@"
.New:
	db "New@"

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
	hlcoord 15, 12
	rst PlaceString
	and a
	ret

InitialOptions_EvolveInBattle:
	ld hl, wInitialOptions2
	ldh a, [hJoyPressed]
	and D_LEFT | D_RIGHT | A_BUTTON
	jr nz, .Toggle
	bit EVOLVE_IN_BATTLE_OPT, [hl]
	jr z, .SetNo
	jr .SetYes
.Toggle
	bit EVOLVE_IN_BATTLE_OPT, [hl]
	jr z, .SetYes
.SetNo:
	res EVOLVE_IN_BATTLE_OPT, [hl]
	ld de, NoString
	jr .Display
.SetYes:
	set EVOLVE_IN_BATTLE_OPT, [hl]
	ld de, YesString
.Display:
	hlcoord 15, 8
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
	hlcoord 15, 10
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
	hlcoord 15, 4
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
	hlcoord 15, 6
	rst PlaceString
	and a
	ret

InitialOptions_RTC:
	ld hl, wInitialOptions2
	ldh a, [hJoyPressed]
	and D_LEFT | D_RIGHT | A_BUTTON
	jr nz, .Toggle
	bit RTC_OPT, [hl]
	jr z, .SetNo
	jr .SetYes
.Toggle
	bit RTC_OPT, [hl]
	jr z, .SetYes
.SetNo:
	res RTC_OPT, [hl]
	ld de, NoString
	jr .Display
.SetYes:
	set RTC_OPT, [hl]
	ld de, YesString
.Display:
	hlcoord 15, 2
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

InitialOptions_Next:
	ldh a, [hJoyPressed]
	and A_BUTTON | D_LEFT | D_RIGHT
	jr z, .NonePressed
	call InitialOptions_ReRender
	ld de, InitialOptionsString2
	hlcoord 2, 1
	rst PlaceString
	ld a, 1
	ld [wCurOptionsPage], a
	call InitialOptionsMenu_LoadOptions
	ld a, NUM_INITIAL_OPTIONS_PER_PAGE - 1
	ld [wJumptableIndex], a
.NonePressed:
	and a
	ret

InitialOptions_Previous:
	ldh a, [hJoyPressed]
	and A_BUTTON | D_LEFT | D_RIGHT
	jr z, .NonePressed
	call InitialOptions_ReRender
	ld de, InitialOptionsString1
	hlcoord 2, 1
	rst PlaceString
	xor a
	ld [wCurOptionsPage], a
	call InitialOptionsMenu_LoadOptions
	ld a, NUM_INITIAL_OPTIONS_PER_PAGE - 1
	ld [wJumptableIndex], a
.NonePressed:
	and a
	ret

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
	cp NUM_INITIAL_OPTIONS_PER_PAGE - 1
	jr nz, .Increase
	ld [hl], -1
.Increase:
	inc [hl]
	call CheckSkipPage2Item5
	jr nz, .no_skip_inc
	inc [hl]
.no_skip_inc
	scf
	ret

.UpPressed:
	ld a, [hl]
	and a
	jr nz, .Decrease
	ld [hl], NUM_INITIAL_OPTIONS_PER_PAGE
.Decrease:
	dec [hl]
	call CheckSkipPage2Item5
	jr nz, .no_skip_dec
	dec [hl]
.no_skip_dec
	scf
	ret

CheckSkipPage2Item5:
	ld a, [wCurOptionsPage]
	dec a
	ret nz ; no skip
	ld a, [hl] ; [wJumptableIndex]
	cp 5
	ret

InitialOptions_UpdateCursorPosition:
	hlcoord 1, 1
	ld de, SCREEN_WIDTH
	ld c, NUM_INITIAL_OPTIONS_PER_PAGE * 2
.loop
	ld [hl], " "
	add hl, de
	dec c
	jr nz, .loop
	; hlcoord 1, [wJumptableIndex] * 2 + 1
	ld a, [wJumptableIndex]
	add a
	hlcoord 0, 1
	ld bc, SCREEN_WIDTH
	rst AddNTimes
	inc hl
	ld [hl], "▶"
	ret

InitialOptions_ReRender:
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

	hlcoord 1, 16
	ld a, $03
	ld d, 12
.select_start_loop
	ld [hli], a
	inc a
	dec d
	jr nz, .select_start_loop
	ret

INCLUDE "data/options/descriptions.asm"
