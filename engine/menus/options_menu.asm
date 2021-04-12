OptionsMenu:
	ld hl, hInMenu
	ld a, [hl]
	push af
	ld [hl], $1
	call ClearBGPalettes
	hlcoord 0, 0
	lb bc, SCREEN_HEIGHT - 2, SCREEN_WIDTH - 2
	call Textbox
	hlcoord 2, 2
	ld de, StringOptions1
	rst PlaceString
	xor a
	ld [wCurOptionsPage], a
	call OptionsMenu_LoadOptions

	xor a
	ld [wJumptableIndex], a
	ld a, CGB_DIPLOMA
	call GetCGBLayout
	call SetPalettes

.joypad_loop
	call JoyTextDelay
	ldh a, [hJoyPressed]
	and START | B_BUTTON
	jr nz, .ExitOptions
	call OptionsControl
	jr c, .dpad
	call GetOptionPointer
	jr c, .ExitOptions

.dpad
	call Options_UpdateCursorPosition
	ld c, 3
	call DelayFrames
	jr .joypad_loop

.ExitOptions:
	ld de, SFX_TRANSACTION
	call PlaySFX
	call WaitSFX
	pop af
	ldh [hInMenu], a
	ret

OptionsMenu_LoadOptions:
	xor a
	ld [wJumptableIndex], a
	ldh [hJoyPressed], a
	ld c, $6 ; number of items on the menu minus 1 (for done)
.print_text_loop ; this next will display the settings of each option when the menu is opened
	push bc
	xor a
	ldh [hJoyLast], a
	call GetOptionPointer
	pop bc
	ld hl, wJumptableIndex
	inc [hl]
	dec c
	jr nz, .print_text_loop
	ld a, [wCurOptionsPage]
	and a
	call z, UpdateFrame
	ld a, 1
	ldh [hBGMapMode], a
	jmp ApplyTilemapInVBlank

StringOptions1:
	db "Text Speed<LNBRK>"
	db "        :<LNBRK>"
	db "Battle Effects<LNBRK>"
	db "        :<LNBRK>"
	db "Battle Style<LNBRK>"
	db "        :<LNBRK>"
	db "Running Shoes<LNBRK>"
	db "        :<LNBRK>"
	db "Frame<LNBRK>"
	db "        :Type<LNBRK>"
	db "Sound<LNBRK>"
	db "        :<LNBRK>"
	db "Next<LNBRK>"
	db "        <LNBRK>"
	db "Done@"

StringOptions2:
	db "Clock Format<LNBRK>"
	db "        :<LNBRK>"
	db "#dex Units<LNBRK>"
	db "        :<LNBRK>"
	db "Text Autoscroll<LNBRK>"
	db "        :<LNBRK>"
	db "Turning Speed<LNBRK>"
	db "        :<LNBRK>"
	db "Typeface<LNBRK>"
	db "        :<LNBRK>"
	db "Keyboard<LNBRK>"
	db "        :<LNBRK>"
	db "Previous<LNBRK>"
	db "        <LNBRK>"
	db "Done@"

GetOptionPointer:
	ld a, [wCurOptionsPage]
	and a
	ld a, [wJumptableIndex]
	jr z, .page1
	add 8
.page1
	call StackJumpTable

.Pointers:
	dw Options_TextSpeed
	dw Options_BattleEffects
	dw Options_BattleStyle
	dw Options_RunningShoes
	dw Options_Frame
	dw Options_Sound
	dw Options_NextPrevious
	dw Options_Done

	dw Options_ClockFormat
	dw Options_PokedexUnits
	dw Options_TextAutoscroll
	dw Options_TurningSpeed
	dw Options_Typeface
	dw Options_Keyboard
	dw Options_NextPrevious
	dw Options_Done

Options_TextSpeed:
	ld a, [wOptions1]
	and %11
	ld c, a
	ldh a, [hJoyPressed]
	dec c
	bit D_LEFT_F, a
	jr nz, .ok
	inc c
	bit D_RIGHT_F, a
	jr z, .NonePressed
	inc c
.ok
	ld a, c
	and $3
	ld c, a
	ld a, [wOptions1]
	and $fc
	or c
	ld [wOptions1], a

.NonePressed:
	ld b, 0
	ld hl, .Strings
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 11, 3
	rst PlaceString
	and a
	ret

.Strings:
	dw .Instant
	dw .Fast
	dw .Medium
	dw .Slow

.Fast:
	db "Fast   @"
.Medium:
	db "Medium @"
.Slow:
	db "Slow   @"
.Instant:
	db "Instant@"

Options_BattleEffects:
	ld hl, wOptions1
	ldh a, [hJoyPressed]
	and D_LEFT | D_RIGHT
	jr nz, .Toggle
	bit BATTLE_EFFECTS, [hl]
	jr z, .SetOff
	jr .SetOn
.Toggle
	bit BATTLE_EFFECTS, [hl]
	jr z, .SetOn
.SetOff:
	res BATTLE_EFFECTS, [hl]
	ld de, .Off
	jr .Display
.SetOn:
	set BATTLE_EFFECTS, [hl]
	ld de, .On
.Display:
	hlcoord 11, 5
	rst PlaceString
	and a
	ret

.Off:
	db "Off@"
.On:
	db "On @"

Options_BattleStyle:
	ld hl, wOptions2
	ldh a, [hJoyPressed]
	bit D_LEFT_F, a
	jr nz, .LeftPressed
	bit D_RIGHT_F, a
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
	hlcoord 11, 7
	rst PlaceString
	and a
	ret

.Set:
	db "Set    @"
.Switch:
	db "Switch @"
.Predict:
	db "Predict@"

Options_RunningShoes:
	ld hl, wOptions2
	ldh a, [hJoyPressed]
	and D_LEFT | D_RIGHT
	jr nz, .Toggle
	bit RUNNING_SHOES, [hl]
	jr z, .SetOff
	jr .SetOn
.Toggle
	bit RUNNING_SHOES, [hl]
	jr z, .SetOn
.SetOff:
	res RUNNING_SHOES, [hl]
	ld de, .Off
	jr .Display
.SetOn:
	set RUNNING_SHOES, [hl]
	ld de, .On
.Display:
	hlcoord 11, 9
	rst PlaceString
	and a
	ret

.Off:
	db "Off@"
.On:
	db "On @"

Options_Frame:
	ld hl, wTextboxFrame
	ldh a, [hJoyPressed]
	bit D_LEFT_F, a
	jr nz, .LeftPressed
	bit D_RIGHT_F, a
	jr nz, .RightPressed
	and a
	ret

.RightPressed:
	ld a, [hl]
	inc a
	cp $9
	jr nz, .Save
	xor a
	jr .Save

.LeftPressed:
	ld a, [hl]
	dec a
	cp $ff
	jr nz, .Save
	ld a, $8

.Save:
	ld [hl], a
UpdateFrame:
	ld a, [wTextboxFrame]
	hlcoord 16, 11 ; where on the screen the number is drawn
	add "1"
	ld [hl], a
	call LoadFontsExtra
	and a
	ret

Options_Sound:
	ld hl, wOptions1
	ldh a, [hJoyPressed]
	and D_LEFT | D_RIGHT
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
	ldh a, [hJoyPressed]
	and D_LEFT | D_RIGHT
	call nz, RestartMapMusic
	hlcoord 11, 13
	rst PlaceString
	and a
	ret

.Mono:
	db "Mono  @"
.Stereo:
	db "Stereo@"

Options_ClockFormat:
	ld hl, wOptions2
	ldh a, [hJoyPressed]
	and D_LEFT | D_RIGHT
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
	hlcoord 11, 3
	rst PlaceString
	and a
	ret

.Twelve:
	db "12-hour@"
.TwentyFour:
	db "24-hour@"

Options_PokedexUnits:
	ld hl, wOptions2
	ldh a, [hJoyPressed]
	and D_LEFT | D_RIGHT
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
	hlcoord 11, 5
	rst PlaceString
	and a
	ret

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
	bit D_LEFT_F, b
	jr nz, .ok
	add 4
	bit D_RIGHT_F, b
	jr z, .not_changing
	add 4
.ok
	and AUTOSCROLL_MASK
	ld c, a
	ld a, [wOptions1]
	and $f3
	or c
	ld [wOptions1], a
	ld a, c

.not_changing
	rrca
	ld b, 0
	ld c, a
	ld hl, .Strings
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 11, 7
	rst PlaceString
	and a
	ret

.Strings:
	dw .None
	dw .Start
	dw .AandB
	dw .AorB

.None:
	db "None   @"
.Start:
	db "Start  @"
.AandB:
	db "A and B@"
.AorB:
	db "A or B @"

Options_TurningSpeed:
	ldh a, [hJoyPressed]
	and D_LEFT | D_RIGHT
	ld a, [wOptions1]
	jr z, .not_changing
	xor TURNING_SPEED_MASK
	ld [wOptions1], a

.not_changing
	and TURNING_SPEED_MASK
	rrca
	rrca
	rrca
	ld b, 0
	ld c, a
	ld hl, .Strings
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 11, 9
	rst PlaceString
	and a
	ret

.Strings:
	dw .Slow
	dw .Fast

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
	bit D_LEFT_F, a
	jr nz, .LeftPressed
	bit D_RIGHT_F, a
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
	and $ff - FONT_MASK
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
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 11, 11
	rst PlaceString
	and a
	ret

.Strings:
	dw .Normal
	dw .Narrow
	dw .Bold
	dw .Italic
	dw .Serif
	dw .Chicago
	dw .MICR
	dw .Unown

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
	and D_LEFT | D_RIGHT
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
	hlcoord 11, 13
	rst PlaceString
	and a
	ret

.ABC:
	db "ABCDEF@"
.QWERTY:
	db "QWERTY@"

Options_NextPrevious:
	ld hl, wCurOptionsPage
	ldh a, [hJoyPressed]
	and A_BUTTON | D_LEFT | D_RIGHT
	jr z, .NonePressed
	bit 0, [hl]
	jr z, .Page2
;.Page1:
	res 0, [hl]
	ld de, StringOptions1
	jr .Display
.Page2:
	set 0, [hl]
	ld de, StringOptions2
.Display:
	push de
	hlcoord 0, 0
	lb bc, 16, 18
	call Textbox
	pop de
	hlcoord 2, 2
	rst PlaceString
	call OptionsMenu_LoadOptions
	ld a, $6
	ld [wJumptableIndex], a
.NonePressed:
	and a
	ret

Options_Done:
	ldh a, [hJoyPressed]
	and A_BUTTON
	jr nz, .Exit
	and a
	ret

.Exit:
	scf
	ret

OptionsControl:
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
	cp $7 ; maximum number of items in option menu
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
	ld [hl], $8 ; number of option items + 1
.Decrease:
	dec [hl]
	scf
	ret

Options_UpdateCursorPosition:
	hlcoord 1, 1
	ld de, SCREEN_WIDTH
	ld c, $10
.loop
	ld [hl], " "
	add hl, de
	dec c
	jr nz, .loop
	hlcoord 1, 2
	ld bc, 2 * SCREEN_WIDTH
	ld a, [wJumptableIndex]
	rst AddNTimes
	ld [hl], "▶"
	ret
