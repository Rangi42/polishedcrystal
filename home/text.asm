ClearSpeechBox::
	hlcoord TEXTBOX_INNERX, TEXTBOX_INNERY
	lb bc, TEXTBOX_INNERH - 1, TEXTBOX_INNERW
ClearBox::
; Fill a c*b box at hl with blank tiles.
	ld a, " "
FillBoxWithByte::
.row
	push bc
	push hl
.col
	ld [hli], a
	dec c
	jr nz, .col
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .row
	ret

ClearScreen::
	ld a, PAL_BG_TEXT
	hlcoord 0, 0, wAttrMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	rst ByteFill
ClearTileMap::
; Fill wTileMap with blank tiles.
	hlcoord 0, 0
	ld a, " "
	ld bc, wTileMapEnd - wTileMap
	rst ByteFill
	; Update the BG Map.
	ldh a, [rLCDC]
	bit 7, a
	ret z
	jp ApplyTilemapInVBlank

SpeechTextbox::
; Standard textbox.
	hlcoord TEXTBOX_X, TEXTBOX_Y
	lb bc, TEXTBOX_INNERH, TEXTBOX_INNERW
Textbox::
; Draw a text box at hl with room for
; b lines of c characters each.
; Places a border around the textbox,
; then switches the palette to the
; text black-and-white scheme.
	push bc
	push hl
	call TextboxBorder
	pop hl
	pop bc
TextboxPalette::
; Fill text box width c height b at hl with pal 7
	ld de, wAttrMap - wTileMap
	add hl, de
	inc b
	inc b
	inc c
	inc c
	ld a, PAL_BG_TEXT
	jr FillBoxWithByte

TextboxBorder::
	; Top
	push hl
	ld a, "┌"
	ld [hli], a
	inc a ; "─"
	call .PlaceChars
	inc a ; "┐"
	ld [hl], a
	pop hl

	; Middle
	ld de, SCREEN_WIDTH
	add hl, de
.row
	push hl
	ld a, "│"
	ld [hli], a
	ld a, " "
	call .PlaceChars
	ld [hl], "│"
	pop hl

	ld de, SCREEN_WIDTH
	add hl, de
	dec b
	jr nz, .row

	; Bottom
	ld a, "└"
	ld [hli], a
	ld a, "─"
	call .PlaceChars
	ld [hl], "┘"

	ret

.PlaceChars:
; Place char a c times.
	ld d, c
.loop
	ld [hli], a
	dec d
	jr nz, .loop
	ret

PrintText::
	call SetUpTextbox
PrintTextNoBox::
	push hl
	call ClearSpeechBox
	pop hl
PrintTextboxText::
	bccoord TEXTBOX_INNERX, TEXTBOX_INNERY
PlaceWholeStringInBoxAtOnce::
	ld a, [wTextboxFlags]
	push af
	set 1, a
	ld [wTextboxFlags], a
	call DoTextUntilTerminator
	pop af
	ld [wTextboxFlags], a
	ret

SetUpTextbox::
	push hl
	call SpeechTextbox
	call UpdateSprites
	call ApplyTilemap
	pop hl
	ret

_PlaceString::
	push hl
PlaceNextChar::
	; charmap order: commands, then ngrams, then specials, then literals
	ld a, [de]
	cp BATTLEEXTRA_GFX_START
	jr nc, _PlaceLiteralChar
	cp "@"
	jr nc, _PlaceSpecialChar
	cp NGRAMS_START
	jr nc, _PlaceNgramChar
	dec de
	jp FinishString

SpaceChar::
	ld a, " "
_PlaceLiteralChar:
	ld [hli], a
	call PrintLetterDelay
NextChar::
	inc de
	jr PlaceNextChar

_PlaceNgramChar:
	sub NGRAMS_START
	push de
	push hl
	add a
	ld e, a
	ld d, 0
	ld hl, NgramStrings
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	jp PlaceCommandCharacter

_PlaceSpecialChar:
	sub "@"
	push hl
	add a
	ld c, a
	ld b, 0
	ld hl, SpecialCharacters
	add hl, bc
	ld a, [hli]
	ld b, [hl]
	ld c, a
	pop hl
_bc_::
	push bc
	ret

SpecialCharacters:
	dw FinishString     ; "@"
	dw SpaceChar        ; "¯"
	dw LineBreak        ; "<LNBRK>"
	dw NextLineChar     ; "<NEXT>"
	dw LineChar         ; "<LINE>"
	dw ContText         ; "<CONT>"
	dw Paragraph        ; "<PARA>"
	dw DoneText         ; "<DONE>"
	dw PromptText       ; "<PROMPT>"
	dw PlaceTargetsName ; "<TARGET>"
	dw PlaceUsersName   ; "<USER>"
	dw PlaceEnemysName  ; "<ENEMY>"

NextLineChar::
	ld a, [wTextboxFlags]
	bit NO_LINE_SPACING, a
	ld bc, SCREEN_WIDTH * 2
	jr z, LineBreak.ok
LineBreak::
	ld bc, SCREEN_WIDTH
.ok
	pop hl
	add hl, bc
	push hl
	jp NextChar

LineChar::
	pop hl
	hlcoord TEXTBOX_INNERX, TEXTBOX_INNERY + 2
	push hl
	jp NextChar

ContText::
	ld a, [wLinkMode]
	or a
	call z, LoadBlinkingCursor
	call Text_WaitBGMap
	push de
	call ButtonSound
	ld a, [wLinkMode]
	or a
	call z, UnloadBlinkingCursor
	call TextScroll
	call TextScroll
	hlcoord TEXTBOX_INNERX, TEXTBOX_INNERY + 2
	pop de
	jp NextChar

Paragraph::
	push de
	ld a, [wLinkMode]
	cp LINK_COLOSSEUM
	call nz, LoadBlinkingCursor
	call Text_WaitBGMap
	call ButtonSound
	call ClearSpeechBox
	call UnloadBlinkingCursor
	ld a, [wOptions1]
	and AUTOSCROLL_MASK
	cp AUTOSCROLL_AORB
	ld c, 20
	jr z, .got_delay
	bit NO_TEXT_SCROLL, a
	jr nz, .got_delay
	and %11
	jr z, .got_delay
	ld c, 5
.loop
	dec a
	jr z, .got_delay
	sla c
	jr .loop
.got_delay
	call DelayFrames
	hlcoord TEXTBOX_INNERX, TEXTBOX_INNERY
	pop de
	jp NextChar

PromptText::
	push de
	ld a, [wLinkMode]
	cp LINK_COLOSSEUM
	call nz, LoadBlinkingCursor
	call Text_WaitBGMap
	call ButtonSound
	ld a, [wLinkMode]
	cp LINK_COLOSSEUM
	call nz, UnloadBlinkingCursor
	pop de
	; fallthrough

DoneText::
	pop hl
	dec de
	ret

PlaceTargetsName::
	ldh a, [hBattleTurn]
	xor 1
	jr _PlaceBattleNickname

PlaceUsersName::
	ldh a, [hBattleTurn]
	; fallthrough

_PlaceBattleNickname:
	push de
	ld de, wBattleMonNick
	and a
	jr z, PlaceCommandCharacter
	ld de, .EnemyText
	rst PlaceString
	ld h, b
	ld l, c
	ld de, wEnemyMonNick
	jr PlaceCommandCharacter

.EnemyText:
	db "Foe" ; fallthrough, no " @"
SpaceText::
	db " " ; fallthrough, no "@"
EmptyString::
	db "@"

PlaceEnemysName::
	push de
	ld de, wOTClassName
	ld a, [wLinkMode]
	and a
	jr nz, PlaceCommandCharacter
	rst PlaceString
	ld h, b
	ld l, c
	ld de, SpaceText
	rst PlaceString
	push bc
	farcall Battle_GetTrainerName
	pop hl
	ld de, wStringBuffer1
	; fallthrough

PlaceCommandCharacter::
	rst PlaceString
	ld h, b
	ld l, c
	pop de
	jp NextChar

TextScroll::
	hlcoord TEXTBOX_INNERX, TEXTBOX_INNERY
	decoord TEXTBOX_INNERX, TEXTBOX_INNERY - 1
	ld a, TEXTBOX_INNERH - 1
.col
	push af
	ld c, TEXTBOX_INNERW
.row
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .row
	inc de
	inc de
	inc hl
	inc hl
	pop af
	dec a
	jr nz, .col
	hlcoord TEXTBOX_INNERX, TEXTBOX_INNERY + 2
	ld a, " "
	ld bc, TEXTBOX_INNERW
	rst ByteFill
	ld c, 5
	jp DelayFrames

Text_WaitBGMap::
	push bc
	ldh a, [hOAMUpdate]
	push af
	ld a, 1
	ldh [hOAMUpdate], a
	call ApplyTilemapInVBlank
	pop af
	ldh [hOAMUpdate], a
	pop bc
	ret

LoadBlinkingCursor::
	ld a, "▼"
	ldcoord_a 18, 17
	ret

UnloadBlinkingCursor::
	lda_coord 17, 17
	ldcoord_a 18, 17
	ret

FarString::
	ld b, a
	ldh a, [hROMBank]
	push af
	ld a, b
	rst Bankswitch
	rst PlaceString
	pop af
	rst Bankswitch
	ret

DoTextUntilTerminator::
	ld a, [hli]
	cp "@"
	ret z
	cp "<DONE>"
	ret z
	cp "<PROMPT>"
	ret z
	call .TextCommand
	jr DoTextUntilTerminator

.TextCommand:
	cp NGRAMS_START
	jr nc, Text_Started
	push hl
	ld e, a
	ld d, 0
	ld hl, TextCommands
	add hl, de
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop hl
	; jp de
	push de
	ret

TextCommands::
	dw Text_Start      ; $00 <START>
	dw Text_FromRAM    ; $01 <RAM>
	dw Text_WaitButton ; $02 <WAIT>
	dw Text_ASM        ; $03 <ASM>
	dw Text_PrintNum   ; $04 <NUM>
	dw Text_Exit       ; $05 <EXIT>
	dw Text_PlaySound  ; $06 <SOUND>
	dw Text_WeekDay    ; $07 <DAY>
	dw Text_Jump       ; $08 <FAR>

Text_Started:
	dec hl
Text_Start::
; write text until "@"
	ld d, h
	ld e, l
	ld h, b
	ld l, c
	rst PlaceString
	ld h, d
	ld l, e
	inc hl
	ret

Text_FromRAM::
; text_from_ram
; write text from a ram address
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	push hl
	ld h, b
	ld l, c
	rst PlaceString
	pop hl
	ret

Text_Jump::
; text_jump
; write text from a different bank
	ldh a, [hROMBank]
	push af

	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	rst Bankswitch

	push hl
	ld h, d
	ld l, e
	call DoTextUntilTerminator
	pop hl

	pop af
	rst Bankswitch
	ret

Text_WaitButton::
; wait for button press
; show arrow
	push hl
	ld a, [wLinkMode]
	cp LINK_COLOSSEUM
	call nz, LoadBlinkingCursor
	push bc
	call ButtonSound
	pop bc
	ld a, [wLinkMode]
	cp LINK_COLOSSEUM
	call nz, UnloadBlinkingCursor
	pop hl
	ret

Text_ASM::
	bit 7, h
	jr nz, .not_rom
	jp hl

.not_rom
	ld [hl], "@"
	ret

Text_PrintNum::
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	push hl
	ld h, b
	ld l, c
	ld b, a
	and $f
	ld c, a
	ld a, b
	and $f0
	swap a
	set PRINTNUM_LEFTALIGN_F, a
	ld b, a
	call PrintNum
FinishString:
	ld b, h
	ld c, l
	pop hl
	ret

Text_Exit::
	push hl
	push bc
	call GetJoypad
	ldh a, [hJoyDown]
	and A_BUTTON | B_BUTTON
	jr nz, .done
	ld c, 30
	call DelayFrames
.done
	pop bc
	pop hl
	ret

Text_PlaySound::
	ld a, [hli]
	push hl
	push de
	push bc
	ld e, a
	ld d, 0
	call PlaySFX
	call WaitSFX
	jp PopBCDEHL

Text_WeekDay::
	call GetWeekday
PrintDayOfWeek::
	push hl
	push bc
	ld c, a
	ld b, 0
	ld hl, .Days
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld d, h
	ld e, l
	pop hl
	rst PlaceString
	ld h, b
	ld l, c
	ld de, .Day
	rst PlaceString
	pop hl
	ret

.Days:
	dw .Sun
	dw .Mon
	dw .Tues
	dw .Wednes
	dw .Thurs
	dw .Fri
	dw .Satur

.Sun:    db "Sun@"
.Mon:    db "Mon@"
.Tues:   db "Tues@"
.Wednes: db "Wednes@"
.Thurs:  db "Thurs@"
.Fri:    db "Fri@"
.Satur:  db "Satur@"
.Day:    db "day@"

ClearText::
	text_start
	done
