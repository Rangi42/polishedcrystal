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
	call ByteFill

ClearTileMap::
; Fill wTileMap with blank tiles.
	hlcoord 0, 0
	ld a, " "
	ld bc, wTileMapEnd - wTileMap
	call ByteFill

	; Update the BG Map.
	ld a, [rLCDC]
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

RadioTerminator::
	ld hl, .stop
	ret
.stop	db "@"

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

PlaceString::
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
	cp $60
	jp nc, .notDict
dict: macro
if \1 == 0
	and a
else
	cp \1
endc
	jp z, \2
endm

dict2: macro
	cp \1
	jr nz, ._\@
	ld a, \2
._\@:
endm

	dict "<START>",  NullChar
	dict "<FAR>",    TextFar
	dict "<LNBRK>",  LineBreak
	dict "<NEXT>",   NextChar
	dict "<_CONT>",  LinkButtonSound
	dict "<SCRL2>",  ScrollText
	dict "<NL>",     NextLineChar
	dict "<LINE>",   LineChar
	dict "<PARA>",   Paragraph
	dict "<PLAYER>", PrintPlayerName
	dict "<RIVAL>",  PrintRivalName
	dict "<CONT>",   ContText
	dict "<TRENDY>", PrintTrendyPhrase
	dict "<DONE>",   DoneText
	dict "<PROMPT>", PromptText
	dict "<TARGET>", PlaceMoveTargetsName
	dict "<USER>",   PlaceMoveUsersName
	dict "<ENEMY>",  PlaceEnemysName
	dict "#",        PlacePoke
	dict "le",       PlaceLe
	dict "ng",       PlaceNg
	dict "te",       PlaceTe
	dict "as",       PlaceAs
	dict "or",       PlaceOr
	dict "ou",       PlaceOu
	dict "re",       PlaceRe
	dict "in",       PlaceIn
	dict "er",       PlaceEr
	dict "on",       PlaceOn
	dict "th",       PlaceTh
	dict "and",      PlaceAnd
	dict "the",      PlaceThe
	dict "you",      PlaceYou
	dict "#mon",     PlacePokemon
	dict "to",       PlaceTo
	dict "have",     PlaceHave
	dict "that",     PlaceThat
	dict "for",      PlaceFor
	dict "with",     PlaceWith
	dict "an",       PlaceAn
	dict "ing",      PlaceIng
	dict2 "¯", " "

.notDict
	ld [hli], a
	call PrintLetterDelay
	jp NextChar

print_name: macro
	push de
	ld de, \1
	jp PlaceCommandCharacter
endm

PrintPlayerName:   print_name wPlayerName
PrintRivalName:    print_name wRivalName
PrintTrendyPhrase: print_name wTrendyPhrase

PlaceLe: print_name .LeText
.LeText: db "l", "e", "@"

PlaceNg: print_name .NgText
.NgText: db "n", "g", "@"

PlaceTe: print_name .TeText
.TeText: db "t", "e", "@"

PlaceAs: print_name .AsText
.AsText: db "a", "s", "@"

PlaceOr: print_name .OrText
.OrText: db "o", "r", "@"

PlaceOu: print_name .OuText
.OuText: db "o", "u", "@"

PlaceRe: print_name .ReText
.ReText: db "r", "e", "@"

PlaceIn: print_name .InText
.InText: db "i", "n", "@"

PlaceEr: print_name .ErText
.ErText: db "e", "r", "@"

PlaceOn: print_name .OnText
.OnText: db "o", "n", "@"

PlaceTh: print_name .ThText
.ThText: db "t", "h", "@"

PlaceAnd: print_name .AndText
.AndText: db "a", "n", "d", "@"

PlacePoke: print_name .PokeText
.PokeText: db "Poké@"

PlaceThe: print_name .TheText
.TheText: db "t", "h", "e", "@"

PlaceYou: print_name .YouText
.YouText: db "y", "o", "u", "@"

PlacePokemon: print_name .PokemonText
.PokemonText: db "Pokémon@"

PlaceTo: print_name .ToText
.ToText: db "t", "o", "@"

PlaceHave: print_name .HaveText
.HaveText: db "h", "a", "v", "e", "@"

PlaceThat: print_name .ThatText
.ThatText: db "t", "h", "a", "t", "@"

PlaceFor: print_name .ForText
.ForText: db "f", "o", "r", "@"

PlaceWith: print_name .WithText
.WithText: db "w", "i", "t", "h", "@"

PlaceAn: print_name .AnText
.AnText: db "a", "n", "@"

PlaceIng: print_name .IngText
.IngText: db "i", "n", "g", "@"

PlaceMoveTargetsName::
	ld a, [hBattleTurn]
	xor 1
	jr PlaceMoveTargetsName_5A

PlaceMoveUsersName::
	ld a, [hBattleTurn]

PlaceMoveTargetsName_5A:
	push de
	and a
	jr nz, .enemy

	ld de, wBattleMonNick
	jr PlaceCommandCharacter

.enemy:
	ld de, .EnemyText
	call PlaceString
	ld h, b
	ld l, c
	ld de, wEnemyMonNick
	jr PlaceCommandCharacter

.EnemyText:
	db "Foe @"

PlaceEnemysName::
	push de

	ld a, [wLinkMode]
	and a
	jr nz, .linkbattle

	ld de, wOTClassName
	call PlaceString
	ld h, b
	ld l, c
	ld de, .SpaceText
	call PlaceString
	push bc
	farcall Battle_GetTrainerName
	pop hl
	ld de, wStringBuffer1
	jr PlaceCommandCharacter

.linkbattle:
	ld de, wOTClassName
	jr PlaceCommandCharacter

.SpaceText:
	db " @"

PlaceCommandCharacter::
	call PlaceString
	ld h, b
	ld l, c
	pop de
	jp NextChar

NextLineChar::
	ld a, [wTextBoxFlags]
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

LinkButtonSound::
	ld a, [wLinkMode]
	or a
	jr nz, .communication
	call LoadBlinkingCursor

.communication
	call Text_WaitBGMap

	push de
	call ButtonSound
	pop de

	ld a, [wLinkMode]
	or a
	call z, UnloadBlinkingCursor

ScrollText::
	push de
	call TextScroll
	call TextScroll
	hlcoord TEXTBOX_INNERX, TEXTBOX_INNERY + 2
	pop de
	jp NextChar

ContText::
	push de
	ld de, .cont
	ld b, h
	ld c, l
	call PlaceString
	ld h, b
	ld l, c
	pop de
	jp NextChar

.cont	db "<_CONT>@"

PromptText::
	ld a, [wLinkMode]
	cp LINK_COLOSSEUM
	jr z, .ok
	call LoadBlinkingCursor

.ok
	call Text_WaitBGMap
	call ButtonSound
	ld a, [wLinkMode]
	cp LINK_COLOSSEUM
	jr z, DoneText
	call UnloadBlinkingCursor

DoneText::
	pop hl
	ld de, .stop
	dec de
	ret
.stop	db "@"

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
	call ByteFill
	ld c, 5
	jp DelayFrames

Text_WaitBGMap::
	push bc
	ld a, [hOAMUpdate]
	push af
	ld a, 1
	ld [hOAMUpdate], a

	call ApplyTilemapInVBlank

	pop af
	ld [hOAMUpdate], a
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
	ld a, [hROMBank]
	push af

	ld a, b
	rst Bankswitch
	call PlaceString

	pop af
	rst Bankswitch
	ret

PlaceWholeStringInBoxAtOnce::
	ld a, [wTextBoxFlags]
	push af
	set 1, a
	ld [wTextBoxFlags], a

	call DoTextUntilTerminator

	pop af
	ld [wTextBoxFlags], a
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
	dw Text_Start          ; $00 <START>
	dw Text_FromRAM        ; $01 <RAM>
	dw Text_BCD            ; $02 <BCD>
	dw Text_Move           ; $03 <MOVE>
	dw Text_Box            ; $04 <BOX>
	dw Text_Low            ; $05 <LOW>
	dw Text_WaitButton     ; $06 <WAIT>
	dw Text_Scroll         ; $07 <SCROLL>
	dw Text_ASM            ; $08 <ASM>
	dw Text_PrintNum       ; $09 <NUM>
	dw Text_Exit           ; $0a <EXIT>
	dw Text_PlaySound      ; $0b <DEX2>
	dw Text_Dots           ; $0c <DOTS>
	dw Text_ButtonSound    ; $0d <LINK>
	dw Text_PlaySound      ; $0e <DEX1>
	dw Text_PlaySound      ; $0f <ITEM>
	dw Text_PlaySound      ; $10 <CAUGHT>
	dw Text_PlaySound      ; $11 <DEX3>
	dw Text_PlaySound      ; $12 <BEEP>
	dw Text_PlaySound      ; $13 <SLOTS>
	dw Text_StringBuffer   ; $14 <BUFFER>
	dw Text_WeekDay        ; $15 <DAY>
	dw Text_Jump           ; $16 <FAR>

Text_Start::
; write text until "@"
; [$00]["...@"]

	ld d, h
	ld e, l
	ld h, b
	ld l, c
	call PlaceString
	ld h, d
	ld l, e
	inc hl
	ret

Text_FromRAM::
; text_from_ram
; write text from a ram address
; little endian
; [$01][addr]

	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	push hl
	ld h, b
	ld l, c
	call PlaceString
	pop hl
	ret

Text_Jump::
; text_jump
; write text from a different bank
; little endian
; [$16][addr][bank]

	ld a, [hROMBank]
	push af

	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]

	ld [hROMBank], a
	ld [MBC3RomBank], a

	push hl
	ld h, d
	ld l, e
	call DoTextUntilTerminator
	pop hl

	pop af
	ld [hROMBank], a
	ld [MBC3RomBank], a
	ret

Text_BCD::
; write bcd from address, typically ram
; [$02][addr][flags]
; flags: see PrintBCDNumber

	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	push hl
	ld h, b
	ld l, c
	ld c, a
	call PrintBCDNumber
	ld b, h
	ld c, l
	pop hl
	ret

Text_Move::
; move to a new tile
; [$03][addr]

	ld a, [hli]
	ld [wMenuScrollPosition + 2], a
	ld c, a
	ld a, [hli]
	ld [wMenuScrollPosition + 2 + 1], a
	ld b, a
	ret

Text_Box::
; draw a box
; little endian
; [$04][addr][height][width]

	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	push hl
	ld h, d
	ld l, e
	call TextBox
	pop hl
	ret

Text_Low::
; write text at (1,16)
; [$05]

	bccoord TEXTBOX_INNERX, TEXTBOX_INNERY + 2
	ret

Text_WaitButton::
; wait for button press
; show arrow
; [$06]

	ld a, [wLinkMode]
	cp LINK_COLOSSEUM
	jp z, Text_ButtonSound

	push hl
	call LoadBlinkingCursor
	push bc
	call ButtonSound
	pop bc
	call UnloadBlinkingCursor
	pop hl
	ret

Text_Scroll::
; pushes text up two lines and sets the BC cursor to the border tile
; below the first character column of the text box.
	push hl
	call UnloadBlinkingCursor
	call TextScroll
	call TextScroll
	pop hl
	bccoord TEXTBOX_INNERX, TEXTBOX_INNERY + 2
	ret

Text_ASM::
	bit 7, h
	jr nz, .not_rom
	jp hl

.not_rom
	ld a, "@"
	ld [hl], a
	ret

Text_PrintNum::
; [$09][addr][hi:bytes lo:digits]
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
	ld a, [hJoyDown]
	and A_BUTTON | B_BUTTON
	jr nz, .done
	ld c, 30
	call DelayFrames
.done
	pop bc
	pop hl
	ret

Text_PlaySound::
; chars:
;   $0b, $0e, $0f, $10, $11, $12, $13
; see TextSFX

	push bc
	dec hl
	ld a, [hli]
	ld b, a
	push hl
	ld hl, TextSFX
.loop
	ld a, [hli]
	cp -1
	jr z, .done
	cp b
	jr z, .play
	inc hl
	inc hl
	jr .loop

.play
	push de
	ld e, [hl]
	inc hl
	ld d, [hl]
	call PlaySFX
	call WaitSFX
	pop de

.done
	pop hl
	pop bc
	ret

TextSFX::
	dbw "<DEX2>",   SFX_DEX_FANFARE_50_79
	dbw "<BEEP>",   SFX_FANFARE
	dbw "<DEX1>",   SFX_DEX_FANFARE_20_49
	dbw "<ITEM>",   SFX_ITEM
	dbw "<CAUGHT>", SFX_CAUGHT_MON
	dbw "<DEX3>",   SFX_DEX_FANFARE_80_109
	dbw "<SLOTS>",  SFX_SLOT_MACHINE_START
	db -1

Text_Dots::
; [$0C][num]
	ld a, [hli]
	ld d, a
	push hl
	ld h, b
	ld l, c

.loop
	push de
	ld a, "…"
	ld [hli], a
	call GetJoypad
	ld a, [hJoyDown]
	and A_BUTTON | B_BUTTON
	jr nz, .next
	ld c, 10
	call DelayFrames
.next
	pop de
	dec d
	jr nz, .loop

	ld b, h
	ld c, l
	pop hl
	ret

Text_ButtonSound::
; wait for key down
; display arrow
	push hl
	push bc
	call ButtonSound
	pop bc
	pop hl
	ret

Text_StringBuffer::
; Print a string from one of the following:
; 0: wStringBuffer3
; 1: wStringBuffer4
; 2: wStringBuffer5
; 3: wStringBuffer2
; 4: wStringBuffer1
; 5: wEnemyMonNick
; 6: wBattleMonNick
; [$14][id]

	ld a, [hli]
	push hl
	ld e, a
	ld d, 0
	ld hl, .StringBufferPointers
	add hl, de
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ld h, b
	ld l, c
	call PlaceString
	pop hl
	ret

.StringBufferPointers::
	dw wStringBuffer3
	dw wStringBuffer4
	dw wStringBuffer5
	dw wStringBuffer2
	dw wStringBuffer1
	dw wEnemyMonNick
	dw wBattleMonNick

Text_WeekDay::
	call GetWeekday
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
	call PlaceString
	ld h, b
	ld l, c
	ld de, .Day
	call PlaceString
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
