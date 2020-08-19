InitClock:
; Ask the player to set the time.
	ldh a, [hInMenu]
	push af
	ld a, $1
	ldh [hInMenu], a

	xor a
	ld [wSpriteUpdatesEnabled], a
	ld a, $10
	ld [wMusicFade], a
	xor a ; MUSIC_NONE
	ld [wMusicFadeIDLo], a
	ld [wMusicFadeIDHi], a
	ld c, 31
	call FadeToBlack
	call ClearTileMap
	call ClearSprites
	ld a, CGB_DIPLOMA
	call GetCGBLayout
	xor a
	ldh [hBGMapMode], a
	call LoadStandardFont
	ld de, TimesetBackgroundGFX
	ld hl, vTiles2 tile $00
	lb bc, BANK(TimesetBackgroundGFX), 1
	call Request1bpp
	call .ClearScreen
	call ApplyTilemapInVBlank
	call SetPalettes
	ld c, 10
	call DelayFrames
if !DEF(DEBUG)
	ld hl, Text_WokeUpOak
	call PrintText
endc
	ld hl, wTimeSetBuffer
	ld bc, 50
	xor a
	rst ByteFill
	ld a, $a
	ld [wInitHourBuffer], a

.loop
	ld hl, Text_WhatTimeIsIt
	call PrintText
	hlcoord 1, 7
	lb bc, 2, 17
	call TextBox
	hlcoord 10, 7
	ld [hl], "▲"
	hlcoord 10, 10
	ld [hl], "▼"
	hlcoord 2, 9
	call DisplayHourOClock
	ld c, 10
	call DelayFrames

.SetHourLoop:
	call JoyTextDelay
	call SetHour
	jr nc, .SetHourLoop

	ld a, [wInitHourBuffer]
	ld [wStringBuffer2 + 1], a
	call .ClearScreen
	ld hl, Text_WhatHrs
	call PrintText
	call YesNoBox
	jr nc, .HourIsSet
	call .ClearScreen
	jr .loop

.HourIsSet:
	ld hl, Text_HowManyMinutes
	call PrintText
	hlcoord 11, 7
	lb bc, 2, 7
	call TextBox
	hlcoord 15, 7
	ld [hl], "▲"
	hlcoord 15, 10
	ld [hl], "▼"
	hlcoord 12, 9
	call DisplayMinutesWithMinString
	ld c, 10
	call DelayFrames

.SetMinutesLoop:
	call JoyTextDelay
	call SetMinutes
	jr nc, .SetMinutesLoop

	ld a, [wInitMinuteBuffer]
	ld [wStringBuffer2 + 2], a
	call .ClearScreen
	ld hl, Text_WhoaMins
	call PrintText
	call YesNoBox
	jr nc, .MinutesAreSet
	call .ClearScreen
	jr .HourIsSet

.MinutesAreSet:
	call SetTimeOfDay
	ld hl, OakText_ResponseToSetTime
	call PrintText
	call WaitPressAorB_BlinkCursor
	pop af
	ldh [hInMenu], a
	ret

.ClearScreen:
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 0
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
	xor a
	rst ByteFill
	ld a, $1
	ldh [hBGMapMode], a
	ret

SetHour:
	ldh a, [hJoyPressed]
	and A_BUTTON
	jr nz, .Confirm

	ld hl, hJoyLast
	ld a, [hl]
	and D_UP
	jr nz, .up
	ld a, [hl]
	and D_DOWN
	jr nz, .down
	call DelayFrame
	and a
	ret

.down
	ld hl, wInitHourBuffer
	ld a, [hl]
	and a
	jr nz, .DecreaseThroughMidnight
	ld a, 23 + 1
.DecreaseThroughMidnight:
	dec a
	ld [hl], a
	jr .okay

.up
	ld hl, wInitHourBuffer
	ld a, [hl]
	cp 23
	jr c, .AdvanceThroughMidnight
	ld a, -1
.AdvanceThroughMidnight:
	inc a
	ld [hl], a

.okay
	hlcoord 2, 9
	ld a, " "
	ld bc, 17
	rst ByteFill
	hlcoord 2, 9
	call DisplayHourOClock
	call ApplyTilemapInVBlank
	and a
	ret

.Confirm:
	scf
	ret

DisplayHourOClock:
	push hl
	ld a, [wInitHourBuffer]
	ld c, a
	ld e, l
	ld d, h
	call PrintHour
	inc hl
	ld de, String_oclock
	rst PlaceString
	pop hl
	ret

SetMinutes:
	ldh a, [hJoyPressed]
	and A_BUTTON
	jr nz, .a_button
	ld hl, hJoyLast
	ld a, [hl]
	and D_UP
	jr nz, .d_up
	ld a, [hl]
	and D_DOWN
	jr nz, .d_down
	call DelayFrame
	and a
	ret

.d_down
	ld hl, wInitMinuteBuffer
	ld a, [hl]
	and a
	jr nz, .decrease
	ld a, 59 + 1
.decrease
	dec a
	ld [hl], a
	jr .finish_dpad

.d_up
	ld hl, wInitMinuteBuffer
	ld a, [hl]
	cp 59
	jr c, .increase
	ld a, -1
.increase
	inc a
	ld [hl], a
.finish_dpad
	hlcoord 12, 9
	ld a, " "
	ld bc, 7
	rst ByteFill
	hlcoord 12, 9
	call DisplayMinutesWithMinString
	call ApplyTilemapInVBlank
	and a
	ret
.a_button
	scf
	ret

DisplayMinutesWithMinString:
	ld de, wInitMinuteBuffer
	call PrintTwoDigitNumberRightAlign
	inc hl
	ld de, String_min
	rst PlaceString
	ret

PrintTwoDigitNumberRightAlign:
	push hl
	ld a, " "
	ld [hli], a
	ld [hl], a
	pop hl
	lb bc, PRINTNUM_LEFTALIGN | 1, 2
	jp PrintNum

Text_WokeUpOak:
	; Zzz… Hm? Wha…? You woke me up! Will you check the clock for me?
	text_jump UnknownText_0x1bc29c
	text_end

Text_WhatTimeIsIt:
	; What time is it?
	text_jump UnknownText_0x1bc2eb
	text_end

String_oclock:
	db "o'clock@"

Text_WhatHrs:
	; What?@ @
	text_jump UnknownText_0x1bc2fd
	start_asm
	hlcoord 1, 16
	call DisplayHourOClock
	ld hl, .QuestionMark
	ret

.QuestionMark:
	; ?
	text_jump UnknownText_0x1bc305
	text_end

Text_HowManyMinutes:
	; How many minutes?
	text_jump UnknownText_0x1bc308
	text_end

String_min:
	db "min.@"

Text_WhoaMins:
	; Whoa!@ @
	text_jump UnknownText_0x1bc31b
	start_asm
	hlcoord 7, 14
	call DisplayMinutesWithMinString
	ld hl, .QuestionMark
	ret

.QuestionMark:
	; ?
	text_jump UnknownText_0x1bc323
	text_end

OakText_ResponseToSetTime:
	start_asm
	decoord 1, 14
	ld a, [wInitHourBuffer]
	ld c, a
	call PrintHour
	ld [hl], ":"
	inc hl
	ld de, wInitMinuteBuffer
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
	ld b, h
	ld c, l
	ld a, [wInitHourBuffer]
	cp MORN_HOUR
	jr c, .NITE
	cp DAY_HOUR
	jr c, .MORN
	cp EVE_HOUR
	jr c, .DAY
	cp NITE_HOUR
	jr c, .EVE
.NITE:
	ld hl, .sodark
	ret
.MORN:
	ld hl, .overslept
	ret
.DAY:
	ld hl, .yikes
	ret
.EVE:
	ld hl, .napped
	ret

.overslept
	; ! I overslept!
	text_jump UnknownText_0x1bc326
	text_end

.yikes
	; ! Yikes! I over- slept!
	text_jump UnknownText_0x1bc336
	text_end

.napped
	text_jump ProfElmNappedText
	text_end

.sodark
	; ! No wonder it's so dark!
	text_jump UnknownText_0x1bc34f
	text_end

TimesetBackgroundGFX:
INCBIN "gfx/new_game/timeset_bg.1bpp"

Special_SetDayOfWeek:
	ldh a, [hInMenu]
	push af
	xor a
	ld [wTempDayOfWeek], a
	inc a
	ldh [hInMenu], a
.loop
	hlcoord 0, 12
	lb bc, 4, 18
	call TextBox
	call LoadStandardMenuHeader
	ld hl, .WhatDayIsItText
	call PrintText
	hlcoord 9, 3
	lb bc, 2, 9
	call TextBox
	hlcoord 14, 3
	ld [hl], "▲"
	hlcoord 14, 6
	ld [hl], "▼"
	hlcoord 10, 5
	call .PlaceWeekdayString
	call ApplyTilemap
	ld c, 10
	call DelayFrames
.loop2
	call JoyTextDelay
	call .GetJoypadAction
	jr nc, .loop2
	call ExitMenu
	call UpdateSprites
	ld hl, .ConfirmWeekdayText
	call PrintText
	call YesNoBox
	jr c, .loop
	ld a, [wTempDayOfWeek]
	ld [wStringBuffer2], a
	call SetDayOfWeek
	call LoadStandardFont
	pop af
	ldh [hInMenu], a
	ret

.GetJoypadAction:
	ldh a, [hJoyPressed]
	and A_BUTTON
	jr z, .not_A
	scf
	ret

.not_A
	ld hl, hJoyLast
	ld a, [hl]
	and D_UP
	jr nz, .d_up
	ld a, [hl]
	and D_DOWN
	jr nz, .d_down
	call DelayFrame
	and a
	ret

.d_down
	ld hl, wTempDayOfWeek
	ld a, [hl]
	and a
	jr nz, .decrease
	ld a, 6 + 1

.decrease
	dec a
	ld [hl], a
	jr .finish_dpad

.d_up
	ld hl, wTempDayOfWeek
	ld a, [hl]
	cp 6
	jr c, .increase
	ld a, -1

.increase
	inc a
	ld [hl], a

.finish_dpad
	xor a
	ldh [hBGMapMode], a
	hlcoord 10, 4
	lb bc, 2, 9
	call ClearBox
	hlcoord 10, 5
	call .PlaceWeekdayString
	call ApplyTilemapInVBlank
	and a
	ret

.PlaceWeekdayString:
	push hl
	ld a, [wTempDayOfWeek]
	ld e, a
	ld d, 0
	ld hl, .WeekdayStrings
	add hl, de
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	rst PlaceString
	ret

.WeekdayStrings:
	dw .Sunday
	dw .Monday
	dw .Tuesday
	dw .Wednesday
	dw .Thursday
	dw .Friday
	dw .Saturday
	dw .Sunday

.Sunday:    db " Sunday@"
.Monday:    db " Monday@"
.Tuesday:   db " Tuesday@"
.Wednesday: db "Wednesday@"
.Thursday:  db "Thursday@"
.Friday:    db " Friday@"
.Saturday:  db "Saturday@"

.WhatDayIsItText:
	; What day is it?
	text_jump UnknownText_0x1bc369
	text_end

.ConfirmWeekdayText:
	start_asm
	hlcoord 1, 14
	call .PlaceWeekdayString
	ld hl, .IsIt
	ret

.IsIt:
	; , is it?
	text_jump UnknownText_0x1bc37a
	text_end

Special_InitialSetDSTFlag:
	ld a, [wDST]
	set 7, a
	ld [wDST], a
	call ClearSpeechBox
	ld hl, .Text
	jp PlaceWholeStringInBoxAtOnce

.Text:
	start_asm
	call UpdateTime
	ldh a, [hHours]
	ld b, a
	ldh a, [hMinutes]
	ld c, a
	decoord 1, 14
	call PrintHoursMins
	ld hl, .DSTIsThatOK
	ret

.DSTIsThatOK:
	; DST, is that OK?
	text_jump Text_DSTIsThatOK
	text_end

Special_InitialClearDSTFlag:
	ld a, [wDST]
	res 7, a
	ld [wDST], a
	call ClearSpeechBox
	ld hl, .Text
	jp PlaceWholeStringInBoxAtOnce

.Text:
	start_asm
	call UpdateTime
	ldh a, [hHours]
	ld b, a
	ldh a, [hMinutes]
	ld c, a
	decoord 1, 14
	call PrintHoursMins
	ld hl, .IsThatOK
	ret

.IsThatOK:
	; , is that OK?
	text_jump UnknownText_0x1c5ff1
	text_end

PrintHour:
	ld l, e
	ld h, d
	push bc
	call GetTimeOfDayString
	rst PlaceString
	ld l, c
	ld h, b
	inc hl
	pop bc
	call AdjustHourForAMorPM
	ld [wd265], a
	ld de, wd265
	jp PrintTwoDigitNumberRightAlign

GetTimeOfDayString:
	ld a, c
	cp MORN_HOUR
	ld de, NITE_String
	ret c
	cp DAY_HOUR
	ld de, MORN_String
	ret c
	cp EVE_HOUR
	ld de, DAY_String
	ret c
	cp NITE_HOUR
	ld de, EVE_String
	ret c
	ld de, NITE_String
	ret

NITE_String: db "Night@"
MORN_String: db "Morning@"
DAY_String:  db "Day@"
EVE_String:  db "Evening@"

PlaceCaughtTimeOfDayString::
	and CAUGHTTIME_MASK
	ld de, EVE_String
	jr z, .print
	rlca
	rlca
	rlca
	cp DAY + 1
	ld de, MORN_String
	jr c, .print
	ld de, DAY_String
	jr z, .print
	ld de, NITE_String
.print
	rst PlaceString
	ret

AdjustHourForAMorPM:
; Convert the hour stored in c (0-23) to a 1-12 value
	ld a, [wOptions2]
	bit CLOCK_FORMAT, a
	ld a, c
	ret nz
	or a
	jr z, .midnight
	cp 12
	ret c
	ret z
	sub 12
	ret

.midnight
	ld a, 12
	ret

PrintHoursMins:
; Hours in b, minutes in c
	ld a, [wOptions2]
	bit CLOCK_FORMAT, a
	ld a, b
	jr nz, .h24
	cp 12
	push af
	jr c, .AM
	jr z, .PM
	sub 12
	jr .PM
.AM:
	or a
	jr nz, .PM
	ld a, 12
.PM:
	ld b, a
.h24:
; Crazy stuff happening with the stack
	push bc
	ld hl, sp+$1
	push de
	push hl
	pop de
	pop hl
	ld [hl], " "
	lb bc, 1, 2
	call PrintNum
	ld [hl], ":"
	inc hl
	ld d, h
	ld e, l
	ld hl, sp+$0
	push de
	push hl
	pop de
	pop hl
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
	pop bc
	ld a, [wOptions2]
	bit CLOCK_FORMAT, a
	ret nz
	ld de, .String_AM
	pop af
	jr c, .place_am_pm
	ld de, .String_PM
.place_am_pm
	inc hl
	rst PlaceString
	ret

.String_AM: db "AM@"
.String_PM: db "PM@"
