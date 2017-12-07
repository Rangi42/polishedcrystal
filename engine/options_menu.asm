_OptionsMenu: ; e41d0
	ld hl, hInMenu
	ld a, [hl]
	push af
	ld [hl], $1
	call ClearBGPalettes
	hlcoord 0, 0
	lb bc, SCREEN_HEIGHT - 2, SCREEN_WIDTH - 2
	call TextBox
	hlcoord 2, 2
	ld de, StringOptions1
	call PlaceString
	xor a
	ld [wCurrentOptionsPage], a
	call OptionsMenu_LoadOptions

	xor a
	ld [wJumptableIndex], a
	ld b, CGB_DIPLOMA
	call GetCGBLayout
	call SetPalettes

.joypad_loop
	call JoyTextDelay
	ld a, [hJoyPressed]
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
	ld [hInMenu], a
	ret
; e4241

OptionsMenu_LoadOptions:
	xor a
	ld [wJumptableIndex], a
	ld [hJoyPressed], a
	ld c, $6 ; number of items on the menu minus 1 (for done)
.print_text_loop ; this next will display the settings of each option when the menu is opened
	push bc
	xor a
	ld [hJoyLast], a
	call GetOptionPointer
	pop bc
	ld hl, wJumptableIndex
	inc [hl]
	dec c
	jr nz, .print_text_loop
	ld a, [wCurrentOptionsPage]
	and a
	call z, UpdateFrame
	ld a, 1
	ld [hBGMapMode], a
	jp WaitBGMap

StringOptions1: ; e4241
	db "Text Speed<LNBRK>"
	db "        :<LNBRK>"
	db "Battle Scene<LNBRK>"
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
; e42d6

StringOptions2:
	db "Clock Format<LNBRK>"
	db "        :<LNBRK>"
	db "#dex Units<LNBRK>"
	db "        :<LNBRK>"
	db "Typeface<LNBRK>"
	db "        :<LNBRK>"
	db "<LNBRK>"
	db "<LNBRK>"
	db "<LNBRK>"
	db "<LNBRK>"
	db "<LNBRK>"
	db "<LNBRK>"
	db "Previous<LNBRK>"
	db "        <LNBRK>"
	db "Done@"

GetOptionPointer: ; e42d6
	ld a, [wJumptableIndex] ; load the cursor position to a
	ld e, a ; copy it to de
	ld a, [wCurrentOptionsPage]
	and a
	jr z, .page1
	ld a, $8
	add e
	ld e, a
.page1
	ld d, 0
	ld hl, .Pointers
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl ; jump to the code of the current highlighted item
; e42e5

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
	dw Options_Typeface
	dw Options_Unused
	dw Options_Unused
	dw Options_Unused
	dw Options_NextPrevious
	dw Options_Done
; e42f5


Options_TextSpeed: ; e42f5
	call GetTextSpeed
	ld a, [hJoyPressed]
	bit D_LEFT_F, a
	jr nz, .LeftPressed
	bit D_RIGHT_F, a
	jr z, .NonePressed
	ld a, c ; right pressed
	cp INST_TEXT
	jr c, .Increase
	ld c, FAST_TEXT +- 1

.Increase:
	inc c
	ld a, e
	jr .Save

.LeftPressed:
	ld a, c
	and a
	jr nz, .Decrease
	ld c, INST_TEXT + 1

.Decrease:
	dec c
	ld a, d

.Save:
	ld b, a
	ld a, [Options1]
	and $f0
	or b
	ld [Options1], a

.NonePressed:
	ld b, 0
	ld hl, .Strings
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 11, 3
	call PlaceString
	and a
	ret
; e4331

.Strings:
	dw .Fast
	dw .Medium
	dw .Slow
	dw .Instant

.Fast:
	db "Fast   @"
.Medium:
	db "Medium @"
.Slow:
	db "Slow   @"
.Instant:
	db "Instant@"
; e4346


INST_RATE EQU 0
FAST_RATE EQU 1
MED_RATE  EQU 3
SLOW_RATE EQU 5

GetTextSpeed: ; e4346
	ld a, [Options1] ; This converts the number of frames, to 0, 1, 2 representing speed
	and 7
	cp SLOW_RATE
	jr z, .slow
	cp MED_RATE
	jr z, .medium
	cp FAST_RATE
	jr z, .fast
	ld c, INST_TEXT
	lb de, SLOW_RATE, FAST_RATE
	ret

.slow
	ld c, SLOW_TEXT
	lb de, MED_RATE, INST_RATE
	ret

.medium
	ld c, MED_TEXT
	lb de, FAST_RATE, SLOW_RATE
	ret

.fast
	ld c, FAST_TEXT
	lb de, INST_RATE, MED_RATE
	ret
; e4365


Options_BattleEffects: ; e4365
	ld hl, Options1
	ld a, [hJoyPressed]
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
	call PlaceString
	and a
	ret
; e4398

.Off:
	db "Off@"
.On:
	db "On @"
; e43a0


Options_BattleStyle: ; e43a0
	ld hl, Options2
	ld a, [hJoyPressed]
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
	call PlaceString
	and a
	ret
; e43d1

.Set:
	db "Set    @"
.Switch:
	db "Switch @"
.Predict:
	db "Predict@"
; e43dd


Options_RunningShoes: ; e44c1
	ld hl, Options2
	ld a, [hJoyPressed]
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
	call PlaceString
	and a
	ret
; e44f2

.Off:
	db "Off@"
.On:
	db "On @"
; e44fa


Options_Frame: ; e44fa
	ld hl, TextBoxFrame
	ld a, [hJoyPressed]
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
UpdateFrame: ; e4512
	ld a, [TextBoxFrame]
	hlcoord 16, 11 ; where on the screen the number is drawn
	add "1"
	ld [hl], a
	call LoadFontsExtra
	and a
	ret
; e4520


Options_Sound: ; e43dd
	ld hl, Options1
	ld a, [hJoyPressed]
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
	ld a, [hJoyPressed]
	and D_LEFT | D_RIGHT
	jr z, .DontRestartMapMusic
	call RestartMapMusic
.DontRestartMapMusic
	hlcoord 11, 13
	call PlaceString
	and a
	ret
; e4416

.Mono:
	db "Mono  @"
.Stereo:
	db "Stereo@"
; e4424


Options_ClockFormat:
	ld hl, Options2
	ld a, [hJoyPressed]
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
	call PlaceString
	and a
	ret

.Twelve:
	db "12-hour@"
.TwentyFour:
	db "24-hour@"


Options_PokedexUnits:
	ld hl, Options2
	ld a, [hJoyPressed]
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
	call PlaceString
	and a
	ret

.Imperial:
	db "Imperial@"
.Metric:
	db "Metric  @"


Options_Typeface:
	ld hl, Options2
	ld a, [hl]
	and FONT_MASK
	ld c, a
	ld b, 0
	ld a, [hJoyPressed]
	bit D_LEFT_F, a
	jr nz, .LeftPressed
	bit D_RIGHT_F, a
	jr z, .NonePressed
	ld a, c ; right pressed
	cp UNOWN_FONT
	jr c, .Increase
	ld c, NORMAL_FONT +- 1

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
	ld a, [hl]
	and $ff - FONT_MASK
	or c
	ld [hl], a
	push bc
	call LoadStandardFont
	pop bc

.NonePressed:
	ld b, 0
	ld hl, .Strings
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 11, 7
	call PlaceString
	and a
	ret

.Strings:
	dw .Normal
	dw .Narrow
	dw .Bold
	dw .Italic
	dw .Serif
	dw .Unown

.Normal:
	db "Normal@"
.Narrow:
	db "Narrow@"
.Bold:
	db "Bold  @"
.Italic:
	db "Italic@"
.Serif:
	db "Serif @"
.Unown:
	db "Unown @"


Options_Unused:
	and a
	ret


Options_NextPrevious:
	ld hl, wCurrentOptionsPage
	ld a, [hJoyPressed]
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
	call TextBox
	pop de
	hlcoord 2, 2
	call PlaceString
	call OptionsMenu_LoadOptions
	ld a, $6
	ld [wJumptableIndex], a
.NonePressed:
	and a
	ret

Options_Done: ; e4520
	ld a, [hJoyPressed]
	and A_BUTTON
	jr nz, .Exit
	and a
	ret

.Exit:
	scf
	ret
; e452a

OptionsControl: ; e452a
	ld hl, wJumptableIndex
	ld a, [hJoyLast]
	cp D_DOWN
	jr z, .DownPressed
	cp D_UP
	jr z, .UpPressed
	and a
	ret

.DownPressed:
	ld a, [hl] ; load the cursor position to a

	cp $2
	jr nz, .DownOK
	ld a, [wCurrentOptionsPage]
	and a
	jr z, .DownOK
	ld [hl], $6 ; skip missing options on page 2
	scf
	ret
.DownOK

	cp $7 ; maximum number of items in option menu
	jr nz, .Increase
	ld [hl], -1
.Increase:
	inc [hl]
	scf
	ret

.UpPressed:
	ld a, [hl]

	cp $6
	jr nz, .UpOK
	ld a, [wCurrentOptionsPage]
	and a
	ld a, [hl]
	jr z, .UpOK
	ld [hl], $2 ; skip missing options on page 2
	scf
	ret
.UpOK

	and a
	jr nz, .Decrease
	ld [hl], $8 ; number of option items + 1
.Decrease:
	dec [hl]
	scf
	ret
; e455c

Options_UpdateCursorPosition: ; e455c
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
	call AddNTimes
	ld [hl], "▶"
	ret
; e4579
