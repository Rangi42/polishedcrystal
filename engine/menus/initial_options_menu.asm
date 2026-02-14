DEF NUM_INITIAL_MENU_OPTIONS EQU 11
DEF INITIAL_OPTIONS_VALUE_OFFSET EQU 9

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

	; Clear tilemap and attrmap
	hlcoord 0, 0
	ld bc, SCREEN_AREA
	xor a
	rst ByteFill

	hlcoord 0, 0, wAttrmap
	ld bc, SCREEN_AREA
	xor a
	rst ByteFill

	; Use palette 1 for the SEL/HELP and START/DONE strip.
	hlcoord 1, 16, wAttrmap
	ld a, $01
	ld c, 12
.attr_loop
	ld [hli], a
	dec c
	jr nz, .attr_loop

	; Load custom BG palettes (blue theme)
	ld hl, .BGPalettes
	ld de, wBGPals1
	ld bc, 2 palettes
	call FarCopyColorWRAM

	; Load custom BG tiles (edge borders)
	ld hl, .BGTiles
	ld de, vTiles2 tile $00
	lb bc, BANK(.BGTiles), 15
	call DecompressRequest2bpp

	farcall ApplyPals

	call ApplyAttrAndTilemapInVBlank
	call SetDefaultBGPAndOBP

	ld hl, .InitialOptionsText
	call PrintText

	ldh a, [hInMenu]
	push af
	ld a, TRUE
	ldh [hInMenu], a

	xor a
	ld [wBattleMenuFlags], a

	ld hl, MenuDataHeader_InitialOptions
	call CopyMenuHeader
	xor a
	ldh [hBGMapMode], a
	call InitialOptions_DrawEdges
	call InitialOptions_DrawBottomPrompts

	; initialize cursor position
	xor a
	ld [wOptionsMenuScrollPosition], a
	ld a, 1
	ld [wOptionsMenuCursor], a

.loop
	ld hl, wMenuScrollPosition
	ld a, [wOptionsMenuScrollPosition]
	ld [hli], a
	xor a
	ld [hli], a
	ld [hli], a
	ld [hl], a

	ld hl, wMenuCursorBuffer
	ld a, [wOptionsMenuCursor]
	ld [hli], a
	xor a
	ld [hl], a

	call ScrollingMenu
	ld a, TRUE
	ldh [hInMenu], a

	ld a, [wMenuScrollPosition]
	ld [wOptionsMenuScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wOptionsMenuCursor], a

	ld a, [wMenuJoypad]
	cp PAD_B
	jp z, .exit
	cp PAD_START
	jp z, .exit
	cp PAD_SELECT
	jp z, .show_description
	cp PAD_LEFT
	jp z, .apply_left
	cp PAD_RIGHT
	jp z, .apply_right
	cp PAD_A
	jr nz, .loop
	; fallthrough

; apply a
	call OptionsShared_SetValueCoordFromCursor
	ldh a, [hJoyPressed]
	push af
	ld a, PAD_RIGHT
	ldh [hJoyPressed], a
	ld a, [wMenuSelection]
	and a ; 0?
	jr z, .restore_a
	inc a ; -1?
	jr z, .restore_a
	call InitialOptions_CallOptionRoutine
	call ApplyTilemapInVBlank
.restore_a
	pop af
	ldh [hJoyPressed], a
	xor a
	ldh [hJoyPressed], a
	call OptionsShared_WaitDPadRelease
	jr .loop

.show_description
	call InitialOptions_ShowSelectionDescription
	call InitialOptions_DrawEdges
	call InitialOptions_DrawBottomPrompts
	call ApplyAttrAndTilemapInVBlank
	jr .loop

.apply_left
	ldh a, [hJoyPressed]
	and PAD_LEFT
	jp z, .loop
	ld a, PAD_LEFT
	jr .apply_left_right

.apply_right
	ldh a, [hJoyPressed]
	and PAD_RIGHT
	jp z, .loop
	ld a, PAD_RIGHT
	; fallthrough

.apply_left_right
	push af ; save direction (PAD_LEFT or PAD_RIGHT)
	call OptionsShared_SetValueCoordFromCursor
	call OptionsShared_SetSelectionFromCursor
	ld a, [wMenuSelection]
	and a ; 0?
	jr z, .skip_left_right
	inc a ; -1?
	jr z, .skip_left_right
	pop bc ; restore direction into B
	ldh a, [hJoyPressed]
	push af
	ld a, b
	ldh [hJoyPressed], a
	call InitialOptions_CallOptionRoutine
	call ApplyTilemapInVBlank
	pop af
	ldh [hJoyPressed], a
	xor a
	ldh [hJoyPressed], a
	call OptionsShared_WaitDPadRelease
	jmp .loop

.skip_left_right
	pop af ; discard saved direction
	jmp .loop

.exit
	ld hl, wInitialOptions2
	res RESET_INIT_OPTS, [hl]
	ld de, SFX_TRANSACTION
	call PlaySFX
	call WaitSFX
	pop af
	ldh [hInMenu], a
	ret

.InitialOptionsText:
	text_far _InitialOptionsText
	text_end

.BGPalettes:
INCLUDE "gfx/new_game/init_bg.pal"

.BGTiles:
INCBIN "gfx/new_game/init_bg.2bpp.lzp"

InitialOptions_DrawEdges:
	hlcoord 0, 0
	ld a, $01 ; left edge tile
	ld bc, SCREEN_WIDTH - 2
	ld d, SCREEN_HEIGHT
.edge_loop
	ld [hli], a
	inc a ; $02 = right edge tile
	add hl, bc
	ld [hli], a
	dec a ; $01 = left edge tile
	dec d
	jr nz, .edge_loop

	; Restore edge attributes (palette 0) across the full screen.
	hlcoord 0, 0, wAttrmap
	ld bc, SCREEN_WIDTH - 2
	ld d, SCREEN_HEIGHT
	xor a
.edge_attr_loop
	ld [hli], a
	inc a ; keep A non-zero while moving right edge
	add hl, bc
	xor a
	ld [hli], a
	dec d
	jr nz, .edge_attr_loop
	ret

InitialOptions_DrawBottomPrompts:
	hlcoord 1, 16
	ld a, $03
	ld d, 12
.bottom_loop
	ld [hli], a
	inc a
	dec d
	jr nz, .bottom_loop

	; Clear anything to the right of the START/DONE graphic.
	ld a, ' '
	ld c, 6
.bottom_clear_right_loop
	ld [hli], a
	dec c
	jr nz, .bottom_clear_right_loop

	; Clear the bottom-most interior row to remove lingering textbox border tiles.
	hlcoord 1, 17
	ld a, ' '
	ld c, 18
.bottom_clear_last_row_loop
	ld [hli], a
	dec c
	jr nz, .bottom_clear_last_row_loop

	hlcoord 1, 16, wAttrmap
	ld a, $01
	ld c, 12
.bottom_attr_loop
	ld [hli], a
	dec c
	jr nz, .bottom_attr_loop

	; Restore default palette for the rest of row 16.
	xor a
	ld c, 6
.bottom_attr_clear_right_loop
	ld [hli], a
	dec c
	jr nz, .bottom_attr_clear_right_loop

	; Restore default palette for row 17.
	hlcoord 1, 17, wAttrmap
	xor a
	ld c, 18
.bottom_attr_clear_last_row_loop
	ld [hli], a
	dec c
	jr nz, .bottom_attr_clear_last_row_loop
	ret

InitialOptions_ShowSelectionDescription:
	ld a, [wMenuSelection]
	inc a ; -1? (Done)
	jr z, .done_item
	dec a
	dec a ; 0-indexed (items are 1-based)
	add a ; × 2 for pointer table
	ld c, a
	ld b, 0
	ld hl, InitialOptionDescriptions
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jmp PrintText

.done_item
	ld hl, InitialOptionDescriptions.Done
	jmp PrintText

InitialOptions_CallOptionRoutine:
	ld a, [wMenuSelection]
	dec a
	call StackJumpTable

.Pointers:
	table_width 2
	dw InitialOptions_Natures
	dw InitialOptions_Abilities
	dw InitialOptions_PSS
	dw InitialOptions_EVs
	dw InitialOptions_ExpScaling
	dw InitialOptions_AffectionBonus
	dw InitialOptions_RTC
	dw InitialOptions_PerfectIVs
	dw InitialOptions_TradedMon
	dw InitialOptions_EvolveInBattle
	dw InitialOptions_ColorVariation
	assert_table_length NUM_INITIAL_MENU_OPTIONS

MenuDataHeader_InitialOptions:
	db MENU_BACKUP_TILES
	menu_coords 1, 0, 18, 15
	dw .MenuData2
	db 1 ; default option
	db 0

.MenuData2:
	db SCROLLINGMENU_CALL_FUNCTION1_CANCEL | SCROLLINGMENU_ENABLE_LEFT | SCROLLINGMENU_ENABLE_RIGHT | SCROLLINGMENU_DISPLAY_ARROWS | SCROLLINGMENU_ENABLE_START | SCROLLINGMENU_ENABLE_SELECT ; flags
	db 7, INITIAL_OPTIONS_VALUE_OFFSET ; rows, columns
	db SCROLLINGMENU_ITEMS_NORMAL ; horizontal spacing
	dba InitialOptionsMenuItems ; text pointer
	dba InitialOptions_PlaceOptionName
	dba InitialOptions_PlaceOptionValue
	dba InitialOptions_PlaceOptionValue

InitialOptionsMenuItems:
	db NUM_INITIAL_MENU_OPTIONS
	db 1  ; Natures
	db 2  ; Abilities
	db 3  ; Phys/Spcl split
	db 4  ; EV gain
	db 5  ; Experience gain
	db 6  ; Affection bonus
	db 7  ; Real-time clock
	db 8  ; Perfect stats
	db 9  ; Traded PKMn obey
	db 10 ; Evolve in battle
	db 11 ; Color variation
	db -1 ; Done

InitialOptions_PlaceOptionName:
	push de
	ld de, InitialOptionNames.Done
	ld a, [wMenuSelection]
	inc a ; -1?
	jr z, .got_name
	add a
	ld c, a
	ld b, 0
	ld hl, InitialOptionNames - 2 * 2
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
.got_name
	pop hl
	rst PlaceString
	ret

INCLUDE "data/options/initial_option_names.asm"

InitialOptions_PlaceOptionValue:
	ld a, [wMenuSelection]
	inc a ; -1?
	ret z
	ld hl, SCREEN_WIDTH
	add hl, de
	call OptionsShared_StartValue
	ldh a, [hJoyPressed]
	push af
	xor a
	ldh [hJoyPressed], a
	call InitialOptions_CallOptionRoutine
	pop af
	ldh [hJoyPressed], a
	ret

InitialOptions_Natures:
	ld hl, wInitialOptions
	ldh a, [hJoyPressed]
	and PAD_LEFT | PAD_RIGHT
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
	jmp OptionsShared_PlaceStringAtValueCoord
.SetYes:
	set NATURES_OPT, [hl]
	ld de, YesString
	jmp OptionsShared_PlaceStringAtValueCoord

InitialOptions_Abilities:
	ld hl, wInitialOptions
	ldh a, [hJoyPressed]
	and PAD_LEFT | PAD_RIGHT
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
	jmp OptionsShared_PlaceStringAtValueCoord
.SetYes:
	set ABILITIES_OPT, [hl]
	ld de, YesString
	jmp OptionsShared_PlaceStringAtValueCoord

InitialOptions_PSS:
	ld hl, wInitialOptions
	ldh a, [hJoyPressed]
	and PAD_LEFT | PAD_RIGHT
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
	jmp OptionsShared_PlaceStringAtValueCoord
.SetYes:
	set PSS_OPT, [hl]
	ld de, YesString
	jmp OptionsShared_PlaceStringAtValueCoord

InitialOptions_EVs:
	ld hl, wInitialOptions2
	ld d, EV_OPTMASK
	ldh a, [hJoyPressed]
	ld e, a
	and PAD_LEFT | PAD_RIGHT
	jr z, .input_done
	ld a, [hl]
.redo
	inc a
	bit B_PAD_LEFT, e
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
	jmp OptionsShared_PlaceStringAtValueCoord

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
	and PAD_LEFT | PAD_RIGHT
	jr z, .no_input
	bit B_PAD_LEFT, a
	jr nz, .left_input
	; input right
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
	jmp OptionsShared_PlaceStringAtValueCoord

.Old:
	db "Old@"
.New:
	db "New@"

InitialOptions_AffectionBonus:
	ld hl, wInitialOptions
	ldh a, [hJoyPressed]
	and PAD_LEFT | PAD_RIGHT
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
	jmp OptionsShared_PlaceStringAtValueCoord
.SetYes:
	set AFFECTION_OPT, [hl]
	ld de, YesString
	jmp OptionsShared_PlaceStringAtValueCoord

InitialOptions_RTC:
	ld hl, wInitialOptions2
	ldh a, [hJoyPressed]
	and PAD_LEFT | PAD_RIGHT
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
	jmp OptionsShared_PlaceStringAtValueCoord
.SetYes:
	set RTC_OPT, [hl]
	ld de, YesString
	jmp OptionsShared_PlaceStringAtValueCoord

InitialOptions_PerfectIVs:
	ld hl, wInitialOptions
	ldh a, [hJoyPressed]
	and PAD_LEFT | PAD_RIGHT
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
	jmp OptionsShared_PlaceStringAtValueCoord
.SetYes:
	set PERFECT_IVS_OPT, [hl]
	ld de, YesString
	jmp OptionsShared_PlaceStringAtValueCoord

InitialOptions_TradedMon:
	ld hl, wInitialOptions
	ldh a, [hJoyPressed]
	and PAD_LEFT | PAD_RIGHT
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
	jmp OptionsShared_PlaceStringAtValueCoord
.SetYes:
	set TRADED_AS_OT_OPT, [hl]
	ld de, YesString
	jmp OptionsShared_PlaceStringAtValueCoord

InitialOptions_EvolveInBattle:
	ld hl, wInitialOptions2
	ldh a, [hJoyPressed]
	and PAD_LEFT | PAD_RIGHT
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
	jmp OptionsShared_PlaceStringAtValueCoord
.SetYes:
	set EVOLVE_IN_BATTLE_OPT, [hl]
	ld de, YesString
	jmp OptionsShared_PlaceStringAtValueCoord

InitialOptions_ColorVariation:
	ld hl, wInitialOptions
	ldh a, [hJoyPressed]
	and PAD_LEFT | PAD_RIGHT
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
	jmp OptionsShared_PlaceStringAtValueCoord
.SetYes:
	set COLOR_VARY_OPT, [hl]
	ld de, YesString
	jmp OptionsShared_PlaceStringAtValueCoord

NoString:
	db "No @"
YesString:
	db "Yes@"
AllString:
	db "All@"
ModernString:
	db "{-3d:MODERN_EV_LIMIT}@"

INCLUDE "data/options/initial_options_descriptions.asm"
