DEF OPTIONS_MENU_VALUE_OFFSET EQU 9

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
	call SetDefaultBGPAndOBP

	ld a, [wOptionsMenuCursor]
	and a
	jr nz, .have_cursor
	inc a ; 1
	ld [wOptionsMenuCursor], a
.have_cursor

	ld hl, MenuDataHeader_Options
	call CopyMenuHeader
	xor a
	ldh [hBGMapMode], a
	call InitScrollingMenu

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
	jr z, .exit
	cp PAD_LEFT
	jr z, .apply_left
	cp PAD_RIGHT
	jr z, .apply_right
	cp PAD_A
	jr nz, .loop
	; fallthrough

; apply a
	; PAD_A already selects the highlighted row inside ScrollingMenu
	call OptionsMenu_SetValueCoordFromCursor
	ldh a, [hJoyPressed]
	push af
	ld a, PAD_RIGHT
	ldh [hJoyPressed], a
	ld a, [wMenuSelection]
	and a ; 0?
	jr z, .restore_a
	inc a ; -1?
	jr z, .restore_a
	call OptionsMenu_CallOptionRoutine
	call ApplyTilemapInVBlank
.restore_a
	pop af
	ldh [hJoyPressed], a
	xor a
	ldh [hJoyPressed], a
	call OptionsMenu_WaitDPadRelease
	jr .loop

.apply_left
	ldh a, [hJoyPressed]
	and PAD_LEFT
	jr z, .loop
	ld a, PAD_LEFT
	jr .apply_left_right

.apply_right
	ldh a, [hJoyPressed]
	and PAD_RIGHT
	jr z, .loop
	ld a, PAD_RIGHT
	; fallthrough

.apply_left_right
	push af ; save direction (PAD_LEFT or PAD_RIGHT)
	call OptionsMenu_SetValueCoordFromCursor
	call OptionsMenu_SetSelectionFromCursor
	ld a, [wMenuSelection]
	and a ; 0?
	jr z, .skip_left_right
	inc a ; -1?
	jr z, .skip_left_right
	pop bc ; restore direction into B (we'll use it below)
	ldh a, [hJoyPressed]
	push af
	ld a, b
	ldh [hJoyPressed], a
	call OptionsMenu_CallOptionRoutine
	call ApplyTilemapInVBlank
	pop af
	ldh [hJoyPressed], a
	xor a
	ldh [hJoyPressed], a
	call OptionsMenu_WaitDPadRelease
	jmp .loop

.skip_left_right
	pop af ; discard saved direction
	jmp .loop

.exit
	ld de, SFX_TRANSACTION
	call PlaySFX
	call WaitSFX
	pop af
	ldh [hInMenu], a
	ret

OptionsMenu_SetSelectionFromCursor:
; Set [wMenuSelection] based on current cursor/scroll position.
; Calculate absolute list index ([wMenuScrollPosition] + [wMenuCursorY] - 1)
	ld a, [wMenuCursorY]
	dec a
	ld b, a
	ld a, [wMenuScrollPosition]
	add b
; [wMenuSelection] = absolute list index (for later use)
	ld [wMenuSelection], a
; c = absolute list index
	ld c, a
; hl = [wMenuData_ItemsPointerAddr]
	ld hl, wMenuData_ItemsPointerAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
; b = [wMenuData_ItemsPointerBank]
	ld a, [wMenuData_ItemsPointerBank]
	ld b, a
; d = list size (first byte at items pointer)
	call GetFarByte
	ld d, a
; Check if index >= list size
	ld a, c
	cp d
	jr c, .valid_index
	ld a, -1
	ld [wMenuSelection], a
	ret

.valid_index
	inc hl ; skip count byte, point to first item
; Calculate offset: index * stride
	ld a, [wMenuData_ScrollingMenuSpacing]
	cp SCROLLINGMENU_ITEMS_QUANTITY
	ld a, 1
	jr nz, .got_stride
	inc a ; 2
.got_stride
	push bc ; save [wMenuData_ItemsPointerBank] from b
; hl += [wMenuSelection] * stride, so hl == (absolute list index)th item
	ld b, 0
	ld c, a
	ld a, [wMenuSelection]
	rst AddNTimes
	pop af ; a = [wMenuData_ItemsPointerBank]
; [wMenuSelection] = [(absolute list index)th item]
	call GetFarByte
	ld [wMenuSelection], a
	ret

OptionsMenu_SetValueCoordFromCursor:
	call MenuBoxCoord2Tile
	ld a, [wMenuFlags]
	bit 7, a
	ld bc, SCREEN_WIDTH + 1
	jr z, .gotOffset
	ld c, 1
.gotOffset
	add hl, bc
	ld bc, 2 * SCREEN_WIDTH
	ld a, [wMenuCursorY]
	dec a
	rst AddNTimes
	ld bc, SCREEN_WIDTH + OPTIONS_MENU_VALUE_OFFSET
	add hl, bc
	jmp OptionsMenu_StartValue

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
	menu_coords 1, 1, 18, 16
	dw .MenuData2
	db 1 ; default option
	db 0

.MenuData2:
	db SCROLLINGMENU_CALL_FUNCTION1_CANCEL | SCROLLINGMENU_ENABLE_LEFT | SCROLLINGMENU_ENABLE_RIGHT | SCROLLINGMENU_DISPLAY_ARROWS ; flags
	db 7, OPTIONS_MENU_VALUE_OFFSET ; rows, columns
	db SCROLLINGMENU_ITEMS_NORMAL ; horizontal spacing
	dba OptionsMenuItems ; text pointer
	dba OptionsMenu_PlaceOptionName
	dba OptionsMenu_PlaceOptionValue
	dba NULL

OptionsMenuItems:
	db NUM_OPTIONS
for n, NUM_OPTIONS
	db n + 1
endr
	db -1 ; terminator ("Done")

OptionsMenu_PlaceOptionName:
	push de
	ld de, OptionNames.Done
	ld a, [wMenuSelection]
	inc a ; -1?
	jr z, .got_name
	add a
	ld c, a
	ld b, 0
	ld hl, OptionNames - 2 * 2 ; offset nstead of `dec a :: dec a`
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
.got_name
	pop hl
	rst PlaceString
	ret

INCLUDE "data/options/names.asm"

OptionsMenu_PlaceOptionValue:
	ld a, [wMenuSelection]
	inc a ; -1?
	ret z
	ld hl, SCREEN_WIDTH
	add hl, de
	call OptionsMenu_StartValue
	ldh a, [hJoyPressed]
	push af
	xor a
	ldh [hJoyPressed], a
	call OptionsMenu_CallOptionRoutine
	pop af
	ldh [hJoyPressed], a
	ret

OptionsMenu_StartValue:
	ld a, l
	ld [wOptionsMenuValueCoord], a
	ld a, h
	ld [wOptionsMenuValueCoord + 1], a
	; Place ":" prefix immediately before the value.
	dec hl
	ld a, ':'
	ld [hli], a
	ret

OptionsMenu_WaitDPadRelease:
; Prevent D-pad autorepeat from immediately applying the same option twice.
.loop
	call JoyTextDelay
	ldh a, [hJoyDown]
	and PAD_LEFT | PAD_RIGHT
	jr nz, .loop
	ret

OptionsMenu_GetValueCoord:
	ld hl, wOptionsMenuValueCoord
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

OptionsMenu_PlaceStringAtValueCoord:
	call OptionsMenu_GetValueCoord
	rst PlaceString
	and a
	ret

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
	jr OptionsMenu_PlaceStringAtValueCoord

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
	jr OptionsMenu_PlaceStringAtValueCoord

.SetOn:
	set BATTLE_EFFECTS, [hl]
	ld de, OnString
	jr OptionsMenu_PlaceStringAtValueCoord

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
	jmp OptionsMenu_PlaceStringAtValueCoord

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
	jmp OptionsMenu_PlaceStringAtValueCoord

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
	call OptionsMenu_GetValueCoord
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
	jmp OptionsMenu_PlaceStringAtValueCoord

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
	jmp OptionsMenu_PlaceStringAtValueCoord

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
	jmp OptionsMenu_PlaceStringAtValueCoord

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
	jmp OptionsMenu_PlaceStringAtValueCoord

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
	jmp OptionsMenu_PlaceStringAtValueCoord

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
	jmp OptionsMenu_PlaceStringAtValueCoord

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
	jmp OptionsMenu_PlaceStringAtValueCoord

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
