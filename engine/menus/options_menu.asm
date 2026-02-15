OptionsMenu:
	ldh a, [hInMenu]
	push af
	ld a, TRUE
	ldh [hInMenu], a

	xor a
	ld [wBattleMenuFlags], a

	call ClearBGPalettes

	ld a, CGB_PLAIN
	call GetCGBLayout

	ld hl, .BGPalettes
	ld de, wBGPals1
	ld bc, 1 palettes
	call FarCopyColorWRAM

	call LoadFrame
	call OptionsShared_LoadEdgeTiles

	farcall ApplyPals

	call SetDefaultBGPAndOBP

	ld hl, MenuDataHeader_Options
	call CopyMenuHeader

	xor a
	ldh [hBGMapMode], a

	call InitScrollingMenu

	xor a ; FALSE
	ld [wOptionsMenuIsInitial], a
	call OptionsShared_RunLoop

	pop af
	ldh [hInMenu], a
	ret

.BGPalettes:
INCLUDE "gfx/options/options_bg.pal"

DEF NUM_OPTIONS EQU 12

OptionsMenu_CallOptionRoutine:
	ld a, [wMenuSelection]
	dec a
	call StackJumpTable

.Pointers:
	table_width 2
	dw Options_TextSpeed
	dw Options_TextAutoscroll
	dw Options_Frame
	dw Options_Typeface
	dw Options_Keyboard
	dw Options_Sound
	dw Options_BattleEffects
	dw Options_BattleStyle
	dw Options_RunningShoes
	dw Options_TurningSpeed
	dw Options_ClockFormat
	dw Options_PokedexUnits
	dw Options_Done
	assert_table_length NUM_OPTIONS + 1 ; include "Done"

MenuDataHeader_Options:
	db MENU_BACKUP_TILES
	menu_coords 1, 0, 18, 11
	dw .MenuData2
	db 1 ; default option
	db 0

.MenuData2:
	db SCROLLINGMENU_CALL_FUNCTION1_CANCEL | SCROLLINGMENU_ENABLE_LEFT | SCROLLINGMENU_ENABLE_RIGHT | SCROLLINGMENU_DISPLAY_ARROWS | SCROLLINGMENU_ENABLE_FUNCTION3 | SCROLLINGMENU_ENABLE_START ; flags
	db 5, OPTIONS_SHARED_VALUE_OFFSET ; rows, columns
	db SCROLLINGMENU_ITEMS_NORMAL ; horizontal spacing
	dba OptionsMenuItems ; text pointer
	dba OptionsShared_PlaceOptionName
	dba OptionsShared_PlaceOptionValue
	dba OptionsShared_ResetSelectionDescription

OptionsMenuItems:
	db NUM_OPTIONS
for n, NUM_OPTIONS
	db n + 1
endr
	db -1 ; terminator ("Done")

INCLUDE "data/options/option_names.asm"

OptionsMenu_GetTextSpeedFlag:
; Returns C = 0 for instant text, C != 0 for configured text speed.
; Text Speed option (wMenuSelection == 1) uses configured speed.
	ld c, 0
	ld a, [wMenuSelection]
	dec a
	ret nz
	inc c
	ret

OptionsMenu_AdvanceSelectionDescription:
; Text Speed: always redraw from the start using current speed.
	call OptionsMenu_GetTextSpeedFlag
	ld a, c
	and a
	jmp z, OptionsShared_SimpleAdvanceDescription
	; TextSpeed special case: redraw from start with configured speed
	call OptionsShared_DispatchLookupDescription
	xor a
	ld [wOptionsMenuDescriptionState], a
	call SetUpTextbox
	ld c, 1
	jmp OptionsShared_PlaceDescriptionText

Options_TextSpeed:
	ld a, [wOptions1]
	and TEXT_DELAY_MASK
	ld c, a
	ldh a, [hJoyPressed]
	dec c
	bit B_PAD_LEFT, a
	jr nz, .ok
	inc c
	bit B_PAD_RIGHT, a
	jr z, .NonePressed
	inc c
.ok
	ld a, c
	and TEXT_DELAY_MASK
	ld c, a
	ld a, [wOptions1]
	and ~TEXT_DELAY_MASK
	or c
	ld [wOptions1], a
.NonePressed:
	ld b, 0
	ld hl, .Strings
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
	jmp OptionsShared_PlaceStringAtValueCoord

.Strings:
	table_width 2
	dw .Slow
	dw .Medium
	dw .Fast
	dw .Instant
	assert_table_length TEXT_DELAY_MASK >> TZCOUNT(TEXT_DELAY_MASK) + 1

.Slow:
	db "Slow   @"
.Medium:
	db "Medium @"
.Fast:
	db "Fast   @"
.Instant:
	db "Instant@"

Options_BattleEffects:
	ld hl, wOptions1
	ldh a, [hJoyPressed]
	and PAD_LEFT | PAD_RIGHT
	jr nz, .Toggle
	bit BATTLE_EFFECTS, [hl]
	jr z, .SetOff
	jr .SetOn

.Toggle
	bit BATTLE_EFFECTS, [hl]
	jr z, .SetOn
.SetOff:
	res BATTLE_EFFECTS, [hl]
	ld de, OffString
	jmp OptionsShared_PlaceStringAtValueCoord

.SetOn:
	set BATTLE_EFFECTS, [hl]
	ld de, OnString
	jmp OptionsShared_PlaceStringAtValueCoord

Options_BattleStyle:
	ld hl, wOptions2
	ldh a, [hJoyPressed]
	bit B_PAD_LEFT, a
	jr nz, .LeftPressed
	bit B_PAD_RIGHT, a
	jr nz, .RightPressed
	bit BATTLE_SWITCH, [hl]
	jr nz, .SetSwitch
	bit BATTLE_PREDICT, [hl]
	jr nz, .SetPredict
.SetSet:
	res BATTLE_SWITCH, [hl]
	res BATTLE_PREDICT, [hl]
	ld de, .Set
	jr .Display

.LeftPressed:
	bit BATTLE_SWITCH, [hl]
	jr nz, .SetSet
	bit BATTLE_PREDICT, [hl]
	jr nz, .SetSwitch
	jr .SetPredict

.RightPressed:
	bit BATTLE_SWITCH, [hl]
	jr nz, .SetPredict
	bit BATTLE_PREDICT, [hl]
	jr nz, .SetSet
.SetSwitch:
	set BATTLE_SWITCH, [hl]
	res BATTLE_PREDICT, [hl]
	ld de, .Switch
	jr .Display

.SetPredict:
	res BATTLE_SWITCH, [hl]
	set BATTLE_PREDICT, [hl]
	ld de, .Predict
.Display:
	jmp OptionsShared_PlaceStringAtValueCoord

.Set:
	db "Set    @"
.Switch:
	db "Switch @"
.Predict:
	db "Predict@"

Options_RunningShoes:
	ld hl, wOptions2
	ldh a, [hJoyPressed]
	and PAD_LEFT | PAD_RIGHT
	jr nz, .Toggle
	bit RUNNING_SHOES, [hl]
	jr z, .SetOff
	jr .SetOn

.Toggle
	bit RUNNING_SHOES, [hl]
	jr z, .SetOn
.SetOff:
	res RUNNING_SHOES, [hl]
	ld de, OffString
	jr .Display

.SetOn:
	set RUNNING_SHOES, [hl]
	ld de, OnString
.Display:
	jmp OptionsShared_PlaceStringAtValueCoord

OffString:
	db "Off@"
OnString:
	db "On @"

Options_Frame:
	ld hl, wTextboxFrame
	ldh a, [hJoyPressed]
	bit B_PAD_LEFT, a
	jr nz, .LeftPressed
	bit B_PAD_RIGHT, a
	jr z, .UpdateFrame
.RightPressed:
	ld a, [hl]
	inc a
	cp NUM_FRAMES
	jr nz, .Save
	xor a
	jr .Save

.LeftPressed:
	ld a, [hl]
	dec a
	cp -1
	jr nz, .Save
	ld a, NUM_FRAMES - 1
.Save:
	ld [hl], a
.UpdateFrame:
	ld a, [wTextboxFrame]
	inc a
	ld e, a
	ld d, 0
	call OptionsShared_GetValueCoord
	inc hl
	ld a, ' '
	ld [hld], a
	lb bc, PRINTNUM_LEFTALIGN, 2
	call PrintNumFromReg
	call LoadFrame
	and a
	ret

Options_Sound:
	ld hl, wOptions1
	ldh a, [hJoyPressed]
	and PAD_LEFT | PAD_RIGHT
	jr nz, .Toggle
	bit STEREO, [hl]
	jr z, .SetMono
	jr .SetStereo

.Toggle
	bit STEREO, [hl]
	jr z, .SetStereo
.SetMono:
	res STEREO, [hl]
	ld de, .Mono
	jr .Display

.SetStereo:
	set STEREO, [hl]
	ld de, .Stereo
.Display:
	jmp OptionsShared_PlaceStringAtValueCoord

.Mono:
	db "Mono  @"
.Stereo:
	db "Stereo@"

Options_ClockFormat:
	ld hl, wOptions2
	ldh a, [hJoyPressed]
	and PAD_LEFT | PAD_RIGHT
	jr nz, .Toggle
	bit CLOCK_FORMAT, [hl]
	jr z, .Set12Hour
	jr .Set24Hour

.Toggle
	bit CLOCK_FORMAT, [hl]
	jr z, .Set24Hour
.Set12Hour:
	res CLOCK_FORMAT, [hl]
	ld de, .Twelve
	jr .Display

.Set24Hour:
	set CLOCK_FORMAT, [hl]
	ld de, .TwentyFour
.Display:
	jmp OptionsShared_PlaceStringAtValueCoord

.Twelve:
	db "12-hour@"
.TwentyFour:
	db "24-hour@"

Options_PokedexUnits:
	ld hl, wOptions2
	ldh a, [hJoyPressed]
	and PAD_LEFT | PAD_RIGHT
	jr nz, .Toggle
	bit POKEDEX_UNITS, [hl]
	jr z, .SetImperial
	jr .SetMetric

.Toggle
	bit POKEDEX_UNITS, [hl]
	jr z, .SetMetric
.SetImperial:
	res POKEDEX_UNITS, [hl]
	ld de, .Imperial
	jr .Display

.SetMetric:
	set POKEDEX_UNITS, [hl]
	ld de, .Metric
.Display:
	jmp OptionsShared_PlaceStringAtValueCoord

.Imperial:
	db "Imperial@"
.Metric:
	db "Metric  @"

Options_TextAutoscroll:
	ldh a, [hJoyPressed]
	ld b, a
	ld a, [wOptions1]
	and AUTOSCROLL_MASK
	sub 4
	bit B_PAD_LEFT, b
	jr nz, .ok
	add 4
	bit B_PAD_RIGHT, b
	jr z, .not_changing
	add 4
.ok
	and AUTOSCROLL_MASK
	ld c, a
	ld a, [wOptions1]
	and ~AUTOSCROLL_MASK
	or c
	ld [wOptions1], a
	ld a, c
.not_changing
rept TZCOUNT(AUTOSCROLL_MASK) - 1
	rrca
endr
	ld b, 0
	ld c, a
	ld hl, .Strings
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
	jmp OptionsShared_PlaceStringAtValueCoord

.Strings:
	table_width 2
	dw .None
	dw .Start
	dw .B
	dw .AorB
	assert_table_length (AUTOSCROLL_MASK >> TZCOUNT(AUTOSCROLL_MASK)) + 1

.None:
	db "None  @"
.Start:
	db "Start @"
.B:
	db "B     @"
.AorB:
	db "A or B@"

Options_TurningSpeed:
	ldh a, [hJoyPressed]
	and PAD_LEFT | PAD_RIGHT
	ld a, [wOptions1]
	jr z, .not_changing
	xor TURNING_SPEED_MASK
	ld [wOptions1], a
.not_changing
	and TURNING_SPEED_MASK
rept TZCOUNT(TURNING_SPEED_MASK) - 1
	rrca
endr
	ld b, 0
	ld c, a
	ld hl, .Strings
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
	jmp OptionsShared_PlaceStringAtValueCoord

.Strings:
	table_width 2
	dw .Slow
	dw .Fast
	assert_table_length (TURNING_SPEED_MASK >> TZCOUNT(TURNING_SPEED_MASK)) + 1

.Slow:
	db "Slow@"
.Fast:
	db "Fast@"

Options_Typeface:
	ld hl, wOptions2
	ld a, [hl]
	and FONT_MASK
	ld c, a
	ld b, 0
	ldh a, [hJoyPressed]
	bit B_PAD_LEFT, a
	jr nz, .LeftPressed
	bit B_PAD_RIGHT, a
	jr z, .NonePressed
	ld a, c ; right pressed
	cp UNOWN_FONT
	jr c, .Increase
	ld c, NORMAL_FONT - 1
.Increase:
	inc c
	jr .Save

.LeftPressed:
	ld a, c
	and a
	jr nz, .Decrease
	ld c, UNOWN_FONT + 1
.Decrease:
	dec c
.Save:
	push hl
	push bc
	call .NonePressed
	pop bc
	pop hl
	ld a, [hl]
	and ~FONT_MASK
	or c
	ld [hl], a
	call .NonePressed
	call ApplyTilemapInVBlank
	jmp LoadStandardFont

.NonePressed:
	ld b, 0
	ld hl, .Strings
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
	jmp OptionsShared_PlaceStringAtValueCoord

.Strings:
	table_width 2
	dw .Normal
	dw .Narrow
	dw .Bold
	dw .Italic
	dw .Serif
	dw .Chicago
	dw .MICR
	dw .Unown
	assert_table_length NUM_FONTS

.Normal:
	db "Normal @"
.Narrow:
	db "Narrow @"
.Bold:
	db "Bold   @"
.Italic:
	db "Italic @"
.Serif:
	db "Serif  @"
.Chicago:
	db "Chicago@"
.MICR:
	db "MICR   @"
.Unown:
	db "Unown  @"

Options_Keyboard:
	ld hl, wOptions3
	ldh a, [hJoyPressed]
	and PAD_LEFT | PAD_RIGHT
	jr nz, .Toggle
	bit QWERTY_KEYBOARD_F, [hl]
	jr z, .SetABC
	jr .SetQWERTY

.Toggle
	bit QWERTY_KEYBOARD_F, [hl]
	jr z, .SetQWERTY
.SetABC:
	res QWERTY_KEYBOARD_F, [hl]
	ld de, .ABC
	jr .Display

.SetQWERTY:
	set QWERTY_KEYBOARD_F, [hl]
	ld de, .QWERTY
.Display:
	jmp OptionsShared_PlaceStringAtValueCoord

.ABC:
	db "ABCDEF@"
.QWERTY:
	db "QWERTY@"

Options_Done:
	ldh a, [hJoyPressed]
	and PAD_A
	jr nz, .Exit
	and a
	ret

.Exit:
	scf
	ret

INCLUDE "data/options/options_descriptions.asm"
