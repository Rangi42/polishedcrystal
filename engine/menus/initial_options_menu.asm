DEF NUM_INITIAL_MENU_OPTIONS EQU 11

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

	; Load custom BG palettes (blue theme)
	ld hl, .BGPalettes
	ld de, wBGPals1
	ld bc, 2 palettes
	call FarCopyColorWRAM

	; Load custom BG tiles (edge borders)
	call OptionsShared_LoadEdgeTiles

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
	call OptionsShared_DrawEdges

	; initialize cursor position
	xor a
	ld [wOptionsMenuScrollPosition], a
	ld a, 1
	ld [wOptionsMenuCursor], a

	ld a, $ff
	ld [wOptionsMenuLastSelection], a

	ld a, 1 ; OPTIONS_MENU_TYPE_INITIAL
	ld [wOptionsMenuType], a

	call OptionsShared_RunLoop

	pop af
	ldh [hInMenu], a
	ret

.InitialOptionsText:
	text_far _InitialOptionsText
	text_end

.BGPalettes:
INCLUDE "gfx/new_game/init_bg.pal"

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
	menu_coords 1, 0, 18, 11
	dw .MenuData2
	db 1 ; default option
	db 0

.MenuData2:
	db SCROLLINGMENU_CALL_FUNCTION1_CANCEL | SCROLLINGMENU_ENABLE_LEFT | SCROLLINGMENU_ENABLE_RIGHT | SCROLLINGMENU_DISPLAY_ARROWS | SCROLLINGMENU_ENABLE_FUNCTION3 | SCROLLINGMENU_ENABLE_START ; flags
	db 5, OPTIONS_SHARED_VALUE_OFFSET ; rows, columns
	db SCROLLINGMENU_ITEMS_NORMAL ; horizontal spacing
	dba InitialOptionsMenuItems ; text pointer
	dba OptionsShared_PlaceOptionName
	dba OptionsShared_PlaceOptionValue
	dba OptionsShared_ResetSelectionDescription

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

INCLUDE "data/options/initial_option_names.asm"

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
