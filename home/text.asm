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

SpeechTextBox::
; Standard textbox.
	hlcoord TEXTBOX_X, TEXTBOX_Y
	lb bc, TEXTBOX_INNERH, TEXTBOX_INNERW

TextBox::
; Draw a text box at hl with room for
; b lines of c characters each.
; Places a border around the textbox,
; then switches the palette to the
; text black-and-white scheme.
	push bc
	push hl
	call TextBoxBorder
	pop hl
	pop bc
	jr TextBoxPalette

TextBoxBorder::

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

TextBoxPalette::
; Fill text box width c height b at hl with pal 7
	ld de, wAttrMap - wTileMap
	add hl, de
	inc b
	inc b
	inc c
	inc c
	ld a, PAL_BG_TEXT
.col
	push bc
	push hl
.row
	ld [hli], a
	dec c
	jr nz, .row
	pop hl
	ld de, SCREEN_WIDTH
	add hl, de
	pop bc
	dec b
	jr nz, .col
	ret

PrintText::
	call SetUpTextBox
PrintTextNoBox::
	push hl
	call ClearSpeechBox
	pop hl

PrintTextBoxText::
	bccoord TEXTBOX_INNERX, TEXTBOX_INNERY
	jp PlaceWholeStringInBoxAtOnce

SetUpTextBox::
	push hl
	call SpeechTextBox
	call UpdateSprites
	call ApplyTilemap
	pop hl
	ret

_PlaceString::
	push hl

PlaceNextChar::
	ld a, [de]
	cp "@"
	jr nz, CheckDict
	ld b, h
	ld c, l
	pop hl
	ret

NextChar::
	inc de
	jr PlaceNextChar

CheckDict::
	cp NGRAMS_START
	jr c, .notNgram
	cp NGRAMS_END + 1
	jr nc, .notNgram
	push de
	push hl
	sub NGRAMS_START
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

.notNgram
	cp BATTLEEXTRA_GFX_START
	jr nc, .notDict

	and a ; "<START>"
	jp z, NullChar
	cp "<FAR>" ; TODO: is this case necessary?
	jp z, TextFar
	sub "<ENEMY>"
	jr z, PlaceEnemysName
	inc a ; "<USER>"
	jr z, PlaceMoveUsersName
	inc a ; "<TARGET>"
	jr z, PlaceMoveTargetsName
	inc a ; "<PROMPT>"
	jp z, PromptText
	inc a ; "<DONE>"
	jp z, DoneText
	inc a ; "<PARA>"
	jp z, Paragraph
	inc a ; "<CONT>"
	jp z, ContText
	inc a ; "<LINE>"
	jp z, LineChar
	inc a ; "<NEXT>"
	jp z, NextLineChar
	inc a ; "<LNBRK>"
	jp z, LineBreak
	inc a ; "¯"
	jr nz, .adjust
	ld a, " " - "<ENEMY>" + 10

.adjust
	add "<ENEMY>" - 10

.notDict
	ld [hli], a
	call PrintLetterDelay
	jp NextChar

PlaceMoveTargetsName::
	ldh a, [hBattleTurn]
	xor 1
	jr _PlaceBattleNickname

PlaceMoveUsersName::
	ldh a, [hBattleTurn]

_PlaceBattleNickname:
	push de
	and a
	jr nz, .enemy

	ld de, wBattleMonNick
	jr PlaceCommandCharacter

.enemy:
	ld de, .EnemyText
	rst PlaceString
	ld h, b
	ld l, c
	ld de, wEnemyMonNick
	jr PlaceCommandCharacter

.EnemyText:
	db "Foe" ; no @
SpaceText:
	db " @"

PlaceEnemysName::
	push de

	ld a, [wLinkMode]
	and a
	jr nz, .linkbattle

	ld de, wOTClassName
	rst PlaceString
	ld h, b
	ld l, c
	ld de, SpaceText
	rst PlaceString
	push bc
	farcall Battle_GetTrainerName
	pop hl
	ld de, wStringBuffer1
	jr PlaceCommandCharacter

.linkbattle:
	ld de, wOTClassName
	; fallthrough

PlaceCommandCharacter::
	rst PlaceString
	ld h, b
	ld l, c
	pop de
	jp NextChar

NextLineChar::
	ld a, [wTextboxFlags]
	bit NO_LINE_SPACING, a
	jr nz, LineBreak
	pop hl
	ld bc, SCREEN_WIDTH * 2
	add hl, bc
	push hl
	jp NextChar

LineBreak::
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	push hl
	jp NextChar

TextFar::
	pop hl
	push de
	ld bc, -wTileMap + $10000
	add hl, bc
	ld de, -SCREEN_WIDTH
	ld c, 1
.loop
	ld a, h
	and a
	jr nz, .next
	ld a, l
	cp SCREEN_WIDTH
	jr c, .done

.next
	add hl, de
	inc c
	jr .loop

.done
	hlcoord 0, 0
	ld de, SCREEN_WIDTH
	ld a, c
.loop2
	and a
	jr z, .done2
	add hl, de
	dec a
	jr .loop2

.done2
	pop de
	inc de
	ld a, [de]
	ld c, a
	ld b, 0
	add hl, bc
	push hl
	jp NextChar

LineChar::
	pop hl
	hlcoord TEXTBOX_INNERX, TEXTBOX_INNERY + 2
	push hl
	jp NextChar

Paragraph::
	push de

	ld a, [wLinkMode]
	cp LINK_COLOSSEUM
	jr z, .linkbattle
	call LoadBlinkingCursor
.linkbattle
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

ContText::
	ld a, [wLinkMode]
	or a
	jr nz, .communication
	call LoadBlinkingCursor

.communication
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

PromptText::
	ld a, [wLinkMode]
	cp LINK_COLOSSEUM
	jr z, .linkbattle
	call LoadBlinkingCursor
.linkbattle
	call Text_WaitBGMap
	call ButtonSound
	ld a, [wLinkMode]
	cp LINK_COLOSSEUM
	jr z, DoneText
	call UnloadBlinkingCursor

DoneText::
	pop hl
	ld de, EmptyString
	dec de
	ret

EmptyString::
	db "@"

NullChar::
	ld a, "?"
	ld [hli], a
	call PrintLetterDelay
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

PlaceWholeStringInBoxAtOnce::
	ld a, [wTextboxFlags]
	push af
	set 1, a
	ld [wTextboxFlags], a

	call DoTextUntilTerminator

	pop af
	ld [wTextboxFlags], a
	ret

DoTextUntilTerminator::
	ld a, [hli]
	cp "@"
	ret z
	call .TextCommand
	jr DoTextUntilTerminator

.TextCommand:
	push hl
	push bc
	ld c, a
	ld b, 0
	ld hl, TextCommands
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop bc
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
	jr z, .linkbattle
	call LoadBlinkingCursor
	push bc
	call ButtonSound
	pop bc
	call UnloadBlinkingCursor
	pop hl
	ret

.linkbattle:
	push bc
	call ButtonSound
	pop bc
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
