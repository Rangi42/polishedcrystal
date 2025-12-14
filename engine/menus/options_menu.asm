DEF OPTIONS_PER_PAGE EQU 7
DEF BATTLE_ANIMS_OPTION_MASK EQU %11
DEF NO_RTC_SPEED_VALUE_MASK EQU %11
DEF NUM_OPTIONS EQU 15

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
	ld a, CGB_PLAIN
	call GetCGBLayout
	call SetDefaultBGPAndOBP

.joypad_loop
	call JoyTextDelay
	ldh a, [hJoyPressed]
	and PAD_START | PAD_B
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
	ld a, [wJumptableIndex]
	push af
	xor a
	ldh [hJoyPressed], a
	ldh [hJoyLast], a
	ld a, [wCurOptionsPage]
	and a
	ld de, StringOptions1
	jr z, .got_string
	cp 1
	ld de, StringOptions2
	jr z, .got_string
	ld de, StringOptions3
.got_string
	push de
	hlcoord 0, 0
	lb bc, SCREEN_HEIGHT - 2, SCREEN_WIDTH - 2
	call Textbox
	pop de
	hlcoord 2, 2
	rst PlaceString
	xor a
	ld [wJumptableIndex], a
	call Options_GetPageCount
.print_text_loop
	push bc
	call GetOptionPointer
	pop bc
	ld hl, wJumptableIndex
	inc [hl]
	dec c
	jr nz, .print_text_loop
	pop af
	ld [wJumptableIndex], a
	ld a, [wCurOptionsPage]
	and a
	call z, UpdateFrame
	ld a, 1
	ldh [hBGMapMode], a
	jmp ApplyTilemapInVBlank

StringOptions1:
	text  "Text Speed"
	next1 "        :"
	next1 "Text Autoscroll"
	next1 "        :"
	next1 "Frame"
	next1 "        :Type"
	next1 "Typeface"
	next1 "        :"
	next1 "Keyboard"
	next1 "        :"
	next1 "Sound"
	next1 "        :"
	next1 "Battle Anims"
	next1 "        :"
	done

StringOptions2:
	text  "Battle Style"
	next1 "        :"
	next1 "Running Shoes"
	next1 "        :"
	next1 "Turning Speed"
	next1 "        :"
	next1 "Clock Format"
	next1 "        :"
	next1 "#dex Units"
	next1 "        :"
	next1 "Bike/Surf Music"
	next1 "        :"
	next1 "No RTC Speed"
	next1 "        :"
	done

StringOptions3:
	text  "Nickname Prompt"
	next1 "        :"
	next1 "Done"
	next1 "        "
	done

GetOptionPointer:
	call Options_GetGlobalIndex
	call StackJumpTable

.Pointers:
	dw Options_TextSpeed
	dw Options_TextAutoscroll
	dw Options_Frame
	dw Options_Typeface
	dw Options_Keyboard
	dw Options_Sound
	dw Options_BattleAnimations
	dw Options_BattleStyle

	dw Options_RunningShoes
	dw Options_TurningSpeed
	dw Options_ClockFormat
	dw Options_PokedexUnits
	dw Options_BikeSurfMusic
	dw Options_NoRTCSpeed
	dw Options_NicknamePrompt
	dw Options_Done

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
	call Options_GetValueCoord
	rst PlaceString
	and a
	ret

.Strings:
	dw .Slow
	dw .Medium
	dw .Fast
	dw .Instant

.Slow:
	db "Slow   @"
.Medium:
	db "Medium @"
.Fast:
	db "Fast   @"
.Instant:
	db "Instant@"

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
	call Options_GetValueCoord
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
	call Options_GetValueCoord
	rst PlaceString
	and a
	ret

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
	jr nz, .RightPressed
	and a
	ret

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
UpdateFrame:
	ld a, [wTextboxFrame]
	inc a
	ld e, a
	ld d, 0
	call Options_GetFrameCoord
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
	call Options_GetValueCoord
	rst PlaceString
	and a
	ret

.Mono:
	db "Mono  @"
.Stereo:
	db "Stereo@"

Options_BattleAnimations:
	ldh a, [hJoyPressed]
	ld b, a
	ld hl, wOptions1
	ld a, [wOptions3]
	ld c, a
	ld e, 0
	bit BATTLE_EFFECTS, [hl]
	jr nz, .moves_on
	inc e ; moves off
.moves_on
	bit BATTLE_INTRO_ANIMS, c
	jr z, .got_index
	ld a, e
	add 2
	ld e, a
.got_index
	ld a, b
	and PAD_LEFT | PAD_RIGHT
	jr z, .apply
	bit B_PAD_LEFT, b
	jr z, .right
	dec e
	jr .wrap
.right
	inc e
.wrap
	ld a, e
	and BATTLE_ANIMS_OPTION_MASK
	ld e, a
.apply
	ld a, e
	and 1
	jr nz, .disable_moves
	set BATTLE_EFFECTS, [hl]
	jr .intro_check
.disable_moves
	res BATTLE_EFFECTS, [hl]
.intro_check
	ld a, e
	and 2
	ld hl, wOptions3
	jr z, .intro_on
	set BATTLE_INTRO_ANIMS, [hl]
	jr .display
.intro_on
	res BATTLE_INTRO_ANIMS, [hl]
.display
	ld hl, .Strings
	ld d, 0
	ld a, e
	add a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
	call Options_GetValueCoord
	rst PlaceString
	and a
	ret

.Strings:
	dw .All
	dw .IntroOnly
	dw .MovesOnly
	dw .None

.All:
	db "All  @"
.IntroOnly:
	db "Intro@"
.MovesOnly:
	db "Moves@"
.None:
	db "None @"

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
	call Options_GetValueCoord
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
	call Options_GetValueCoord
	rst PlaceString
	and a
	ret

.Imperial:
	db "Imperial@"
.Metric:
	db "Metric  @"

Options_BikeSurfMusic:
	ld hl, wOptions3
	ldh a, [hJoyPressed]
	and PAD_LEFT | PAD_RIGHT
	jr nz, .Toggle
	bit BIKE_SURF_MUSIC_OFF_F, [hl]
	jr z, .SetOn
	jr .SetOff
.Toggle
	bit BIKE_SURF_MUSIC_OFF_F, [hl]
	jr z, .SetOff
.SetOn:
	res BIKE_SURF_MUSIC_OFF_F, [hl]
	ld de, OnString
	jr .Display
.SetOff:
	set BIKE_SURF_MUSIC_OFF_F, [hl]
	ld de, OffString
.Display:
	call Options_GetValueCoord
	rst PlaceString
	and a
	ret

Options_NoRTCSpeed:
	ld hl, wOptions3
	ldh a, [hJoyPressed]
	ld b, a
	and PAD_LEFT | PAD_RIGHT
	jr z, .no_change
	ld a, [hl]
	and NO_RTC_SPEED_MASK
	rrca
	rrca
	rrca
	rrca
	ld c, a
	bit B_PAD_LEFT, b
	jr z, .inc
	dec c
	jr .wrap
.inc
	inc c
.wrap
	ld a, c
	and NO_RTC_SPEED_VALUE_MASK
	swap a
	and NO_RTC_SPEED_MASK
	ld b, a
	ld a, [hl]
	and ~NO_RTC_SPEED_MASK
	or b
	ld [hl], a
.no_change
	ld a, [hl]
	and NO_RTC_SPEED_MASK
	swap a
	and NO_RTC_SPEED_VALUE_MASK
	ld hl, .Strings
	ld d, 0
	add a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
	call Options_GetValueCoord
	rst PlaceString
	and a
	ret

.Strings:
	dw .One
	dw .Two
	dw .Four
	dw .Six

.One:
	db "1s/min@"
.Two:
	db "2s/min@"
.Four:
	db "4s/min@"
.Six:
	db "6s/min@"

Options_NicknamePrompt:
	ld hl, wOptions3
	ldh a, [hJoyPressed]
	and PAD_LEFT | PAD_RIGHT
	jr nz, .Toggle
	bit DISABLE_NICKNAME_PROMPT_F, [hl]
	jr z, .SetOn
	jr .SetOff
.Toggle
	bit DISABLE_NICKNAME_PROMPT_F, [hl]
	jr z, .SetOff
.SetOn:
	res DISABLE_NICKNAME_PROMPT_F, [hl]
	ld de, OnString
	jr .Display
.SetOff:
	set DISABLE_NICKNAME_PROMPT_F, [hl]
	ld de, OffString
.Display:
	call Options_GetValueCoord
	rst PlaceString
	and a
	ret

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
	rrca
	ld b, 0
	ld c, a
	ld hl, .Strings
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
	call Options_GetValueCoord
	rst PlaceString
	and a
	ret

.Strings:
	dw .None
	dw .Start
	dw .B
	dw .AorB

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
	rrca
	rrca
	rrca
	ld b, 0
	ld c, a
	ld hl, .Strings
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
	call Options_GetValueCoord
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
	call Options_GetValueCoord
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
	call Options_GetValueCoord
	rst PlaceString
	and a
	ret

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

OptionsControl:
	ldh a, [hJoyLast]
	cp PAD_DOWN
	jr z, .DownPressed
	cp PAD_UP
	jr z, .UpPressed
	and a
	ret

.DownPressed:
	ld a, [wCurOptionsPage]
	ld d, a
	call Options_GetGlobalIndex
	cp NUM_OPTIONS
	jr nc, .wrap_down
	inc a
	jr .update
.wrap_down
	xor a
.update
	call Options_SetPageAndIndexFromGlobal
	ld a, [wCurOptionsPage]
	cp d
	jr z, .no_reload_down
	call OptionsMenu_LoadOptions
.no_reload_down
	call Options_GetPageCount
	ld a, [wJumptableIndex]
	cp c
	jr c, .down_ok
	ld a, c
	dec a
	ld [wJumptableIndex], a
.down_ok
	scf
	ret

.UpPressed:
	ld a, [wCurOptionsPage]
	ld d, a
	call Options_GetGlobalIndex
	and a
	jr nz, .not_first
	ld a, NUM_OPTIONS
	jr .update_up
.not_first
	dec a
.update_up
	call Options_SetPageAndIndexFromGlobal
	ld a, [wCurOptionsPage]
	cp d
	jr z, .no_reload_up
	call OptionsMenu_LoadOptions
.no_reload_up
	call Options_GetPageCount
	ld a, [wJumptableIndex]
	cp c
	jr c, .up_ok
	ld a, c
	dec a
	ld [wJumptableIndex], a
.up_ok
	scf
	ret

Options_UpdateCursorPosition:
	hlcoord 1, 1
	ld de, SCREEN_WIDTH
	ld c, SCREEN_HEIGHT - 2
.loop
	ld [hl], ' '
	add hl, de
	dec c
	jr nz, .loop
	hlcoord 1, 2
	ld bc, 2 * SCREEN_WIDTH
	ld a, [wJumptableIndex]
	rst AddNTimes
	ld [hl], '▶'
	ret

Options_GetGlobalIndex:
	ld a, [wCurOptionsPage]
	ld b, a
	add a
	add a
	add b
	add b
	add b ; page * 7
	ld b, a
	ld a, [wJumptableIndex]
	add b
	ret

Options_SetPageAndIndexFromGlobal:
	ld b, 0
.loop
	cp OPTIONS_PER_PAGE
	jr c, .done
	sub OPTIONS_PER_PAGE
	inc b
	jr .loop
.done
	ld [wJumptableIndex], a
	ld a, b
	ld [wCurOptionsPage], a
	ret

Options_GetBaseCoord:
	hlcoord 0, 0
	ld a, [wJumptableIndex]
	add a
	add 2
	ld bc, SCREEN_WIDTH
	rst AddNTimes
	ret

Options_GetValueCoord:
	call Options_GetBaseCoord
	ld bc, SCREEN_WIDTH + 11
	add hl, bc
	ret

Options_GetFrameCoord:
	call Options_GetBaseCoord
	ld bc, SCREEN_WIDTH + 17
	add hl, bc
	ret

Options_GetPageCount:
	ld a, [wCurOptionsPage]
	ld b, a
	add a
	add a
	add b
	add b
	add b ; page * 7
	ld e, a
	ld a, NUM_OPTIONS + 1
	sub e
	ld c, a
	ld a, OPTIONS_PER_PAGE
	cp c
	jr nc, .use_c
	ld c, OPTIONS_PER_PAGE
.use_c
	ret
