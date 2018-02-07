ClearBox:: ; fb6
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
; fc8

ClearTileMap:: ; fc8
; Fill TileMap with blank tiles.

	hlcoord 0, 0
	ld a, " "
	ld bc, TileMapEnd - TileMap
	call ByteFill

	; Update the BG Map.
	ld a, [rLCDC]
	bit 7, a ; lcd on?
	ret z
	jp WaitBGMap
; fdb

ClearScreen:: ; fdb
	ld a, PAL_BG_TEXT
	hlcoord 0, 0, AttrMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	call ByteFill
	jr ClearTileMap
; fe8

TextBox:: ; fe8
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
; ff1

TextBoxBorder:: ; ff1

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
; 101e

.PlaceChars: ; 101e
; Place char a c times.
	ld d, c
.loop
	ld [hli], a
	dec d
	jr nz, .loop
	ret
; 1024

TextBoxPalette:: ; 1024
; Fill text box width c height b at hl with pal 7
	ld de, AttrMap - TileMap
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
; 103e

SpeechTextBox:: ; 103e
; Standard textbox.
	hlcoord TEXTBOX_X, TEXTBOX_Y
	lb bc, TEXTBOX_INNERH, TEXTBOX_INNERW
	jp TextBox
; 1048

RadioTerminator:: ; 1052
	ld hl, .stop
	ret
.stop	db "@"
; 1057

PrintText:: ; 1057
	call SetUpTextBox
BuenaPrintText:: ; 105a
	push hl
	hlcoord TEXTBOX_INNERX, TEXTBOX_INNERY
	lb bc, TEXTBOX_INNERH - 1, TEXTBOX_INNERW
	call ClearBox
	pop hl

PrintTextBoxText:: ; 1065
	bccoord TEXTBOX_INNERX, TEXTBOX_INNERY
	jp PlaceWholeStringInBoxAtOnce
; 106c

SetUpTextBox:: ; 106c
	push hl
	call SpeechTextBox
	call UpdateSprites
	call ApplyTilemap
	pop hl
	ret
; 1078

PlaceString:: ; 1078
	push hl

PlaceNextChar:: ; 1079
	ld a, [de]
	cp "@"
	jr nz, CheckDict
	ld b, h
	ld c, l
	pop hl
	ret

NextChar:: ; 1083
	inc de
	jp PlaceNextChar

CheckDict:: ; 1087
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
	dict "the",      PlaceThe
	dict "you",      PlaceYou
	dict "#mon",     PlacePokemon
	dict "to",       PlaceTo
	dict "have",     PlaceHave
	dict "that",     PlaceThat
	dict "for",      PlaceFor
	dict "with",     PlaceWith
	dict "and",      PlaceAnd
	dict "this",     PlaceThis
	dict2 "¯", " "

	ld [hli], a
	call PrintLetterDelay
	jp NextChar
; 0x117b

print_name: macro
	push de
	ld de, \1
	jp PlaceCommandCharacter
endm

PrintPlayerName:   print_name PlayerName   ; 118d
PrintRivalName:    print_name RivalName    ; 1194
PrintTrendyPhrase: print_name TrendyPhrase ; 119b

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

PlaceAnd: print_name .AndText
.AndText: db "a", "n", "d", "@"

PlaceThis: print_name .ThisText
.ThisText: db "t", "h", "i", "s", "@"

PlaceMoveTargetsName:: ; 11fd
	ld a, [hBattleTurn]
	xor 1
	jr PlaceMoveTargetsName_5A

PlaceMoveUsersName:: ; 1203
	ld a, [hBattleTurn]

PlaceMoveTargetsName_5A: ; 1205
	push de
	and a
	jr nz, .enemy

	ld de, BattleMonNick
	jr PlaceCommandCharacter

.enemy:
	ld de, .EnemyText ; Enemy
	call PlaceString
	ld h, b
	ld l, c
	ld de, EnemyMonNick
	jr PlaceCommandCharacter

.EnemyText:
	db "Foe @" ; 1295

PlaceEnemysName:: ; 121b
	push de

	ld a, [wLinkMode]
	and a
	jr nz, .linkbattle

	ld a, [TrainerClass]
	cp RIVAL1
	jr z, .rival
	cp RIVAL2
	jr z, .rival

	ld de, OTClassName
	call PlaceString
	ld h, b
	ld l, c
	ld de, .SpaceText
	call PlaceString
	push bc
	farcall Battle_GetTrainerName
	pop hl
	ld de, StringBuffer1
	jr PlaceCommandCharacter

.rival:
	ld de, OTClassName
	call PlaceString
	ld h, b
	ld l, c
	ld de, .SpaceText
	call PlaceString
	ld h, b
	ld l, c
	ld de, RivalName
	jr PlaceCommandCharacter

.linkbattle:
	ld de, OTClassName
	jr PlaceCommandCharacter

.SpaceText:
	db " @" ; 12a2

PlaceCommandCharacter:: ; 126a
	call PlaceString
	ld h, b
	ld l, c
	pop de
	jp NextChar
; 0x1273

NextLineChar:: ; 12a7
	pop hl
	ld bc, SCREEN_WIDTH * 2
	add hl, bc
	push hl
	jp NextChar
; 12b0

LineBreak:: ; 12b0
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	push hl
	jp NextChar
; 12b9

TextFar:: ; 12b9
	pop hl
	push de
	ld bc, -TileMap + $10000
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
; 12ea

LineChar:: ; 12ea
	pop hl
	hlcoord TEXTBOX_INNERX, TEXTBOX_INNERY + 2
	push hl
	jp NextChar
; 0x12f2

Paragraph:: ; 12f2
	push de

	ld a, [wLinkMode]
	cp LINK_COLOSSEUM
	jr z, .linkbattle
	call LoadBlinkingCursor

.linkbattle
	call Text_WaitBGMap
	call ButtonSound
	hlcoord TEXTBOX_INNERX, TEXTBOX_INNERY
	lb bc, TEXTBOX_INNERH - 1, TEXTBOX_INNERW
	call ClearBox
	call UnloadBlinkingCursor
	ld c, 20
	call DelayFrames
	hlcoord TEXTBOX_INNERX, TEXTBOX_INNERY
	pop de
	jp NextChar
; 131f

LinkButtonSound:: ; 131f
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

ScrollText:: ; 1337
	push de
	call TextScroll
	call TextScroll
	hlcoord TEXTBOX_INNERX, TEXTBOX_INNERY + 2
	pop de
	jp NextChar
; 1345

ContText:: ; 1345
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
; 1356

PromptText:: ; 135a
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

DoneText:: ; 137c
	pop hl
	ld de, .stop
	dec de
	ret
.stop	db "@"
; 1383

NullChar:: ; 1383
	ld a, "?"
	ld [hli], a
	call PrintLetterDelay
	jp NextChar
; 138c

TextScroll:: ; 138c
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
; 13b6

Text_WaitBGMap:: ; 13b6
	push bc
	ld a, [hOAMUpdate]
	push af
	ld a, 1
	ld [hOAMUpdate], a

	call WaitBGMap

	pop af
	ld [hOAMUpdate], a
	pop bc
	ret
; 13c6

LoadBlinkingCursor:: ; 13c7
	ld a, "▼"
	ldcoord_a 18, 17
	ret
; 13cd

UnloadBlinkingCursor:: ; 13cd
	lda_coord 17, 17
	ldcoord_a 18, 17
	ret
; 13d4

FarString:: ; 13d4
	ld b, a
	ld a, [hROMBank]
	push af

	ld a, b
	rst Bankswitch
	call PlaceString

	pop af
	rst Bankswitch
	ret
; 13e0

PlaceWholeStringInBoxAtOnce:: ; 13e5
	ld a, [TextBoxFlags]
	push af
	set 1, a
	ld [TextBoxFlags], a

	call DoTextUntilTerminator

	pop af
	ld [TextBoxFlags], a
	ret
; 13f6

DoTextUntilTerminator:: ; 13f6
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
; 1410

TextCommands:: ; 1410
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
; 143e

Text_Start:: ; 143e
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
; 1449

Text_FromRAM:: ; 1449
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
; 1455

Text_Jump:: ; 1455
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
; 1470

Text_BCD:: ; 1470
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
; 1480

Text_Move:: ; 1480
; move to a new tile
; [$03][addr]

	ld a, [hli]
	ld [wMenuScrollPosition + 2], a
	ld c, a
	ld a, [hli]
	ld [wMenuScrollPosition + 2 + 1], a
	ld b, a
	ret
; 148b

Text_Box:: ; 148b
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
; 149b

Text_Low:: ; 149b
; write text at (1,16)
; [$05]

	bccoord TEXTBOX_INNERX, TEXTBOX_INNERY + 2
	ret
; 149f

Text_WaitButton:: ; 149f
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
; 14ba

Text_Scroll:: ; 14ba
; pushes text up two lines and sets the BC cursor to the border tile
; below the first character column of the text box.
	push hl
	call UnloadBlinkingCursor
	call TextScroll
	call TextScroll
	pop hl
	bccoord TEXTBOX_INNERX, TEXTBOX_INNERY + 2
	ret
; 14c9

Text_ASM:: ; 14c9
	bit 7, h
	jr nz, .not_rom
	jp hl

.not_rom
	ld a, "@"
	ld [hl], a
	ret
; 14d2

Text_PrintNum:: ; 14d2
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
	set PRINTNUM_RIGHTALIGN_F, a
	ld b, a
	call PrintNum
	ld b, h
	ld c, l
	pop hl
	ret
; 14ed

Text_Exit:: ; 14ed
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
; 1500

Text_PlaySound:: ; 1500
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
; 1522

TextSFX:: ; 152d
	dbw "<DEX2>",   SFX_DEX_FANFARE_50_79
	dbw "<BEEP>",   SFX_FANFARE
	dbw "<DEX1>",   SFX_DEX_FANFARE_20_49
	dbw "<ITEM>",   SFX_ITEM
	dbw "<CAUGHT>", SFX_CAUGHT_MON
	dbw "<DEX3>",   SFX_DEX_FANFARE_80_109
	dbw "<SLOTS>",  SFX_SLOT_MACHINE_START
	db -1
; 1543

Text_Dots:: ; 1543
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
; 1562

Text_ButtonSound:: ; 1562
; wait for key down
; display arrow
	push hl
	push bc
	call ButtonSound
	pop bc
	pop hl
	ret
; 156a

Text_StringBuffer:: ; 156a
; Print a string from one of the following:
; 0: StringBuffer3
; 1: StringBuffer4
; 2: StringBuffer5
; 3: StringBuffer2
; 4: StringBuffer1
; 5: EnemyMonNick
; 6: BattleMonNick
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

.StringBufferPointers:: ; 24000
	dw StringBuffer3
	dw StringBuffer4
	dw StringBuffer5
	dw StringBuffer2
	dw StringBuffer1
	dw EnemyMonNick
	dw BattleMonNick
; 1582

Text_WeekDay:: ; 1582
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

.Days: ; 15a2
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
; 15d8
