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
	hlcoord 0, 0, wAttrmap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	rst ByteFill
ClearTileMap::
; Fill wTilemap with blank tiles.
	ld a, " "
FillTileMap::
	hlcoord 0, 0
	ld bc, wTilemapEnd - wTilemap
	rst ByteFill
	; Update the BG Map.
	ldh a, [rLCDC]
	bit rLCDC_ENABLE, a
	ret z
	jr ApplyTilemapInVBlank

BlackOutScreen::
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 0
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
	ld a, "<BLACK>"
	rst ByteFill
	ld a, $1
	ldh [hBGMapMode], a
	ret

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
	; fallthrough
TextboxPalette::
; Fill text box width c height b at hl with pal 7
	ld de, wAttrmap - wTilemap
	add hl, de
	inc b
	inc b
	inc c
	inc c
	ld a, PAL_BG_TEXT
	jr FillBoxWithByte

TextBoxCharacters:
	rawchar "┌─┐" ; top
	rawchar "│ ┃" ; middle
	rawchar "└━┘" ; bottom

TextboxBorder::
	ld de, TextBoxCharacters
	; fallthrough
CreateBoxBorders::
	ld a, SCREEN_WIDTH

	; Top
	call .PlaceRow
	jr .row

.row_loop
	dec de
	dec de
	dec de
.row
	call .PlaceRow
	dec b
	jr nz, .row_loop

	; Bottom row (fallthrough)

.PlaceRow:
	push af
	push hl
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	inc de
	call .PlaceChars
	ld a, [de]
	inc de
	ld [hl], a
	pop hl
	pop af
	push bc
	ld b, 0
	ld c, a
	add hl, bc
	pop bc
	ret

.PlaceChars:
; Place char a c times.
	push bc
.loop
	ld [hli], a
	dec c
	jr nz, .loop
	pop bc
	ret

MenuTextbox::
	push hl
	call LoadMenuTextbox
	pop hl
	; fallthrough

PrintText::
; input: hl = string, bc = coords
; output: hl = advanced string, bc = advanced coords
; Clobbers de
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

PlaceSubstring:
; input: de = string, hl = current coords, bc = starting coords
; output: de = advanced string, hl = starting coords advanced by "<NEXT>"/"<LNBRK>", bc = advanced coords
	push bc
	jr PlaceNextChar

_PlaceString::
; input: de = string, hl = coords
; output: de = advanced string, hl = starting coords advanced by "<NEXT>"/"<LNBRK>", bc = advanced coords
	push hl
	jr PlaceNextChar

SpaceChar::
	ld a, " "
_PlaceLiteralChar:
	ld [hli], a
	call PrintLetterDelay
NextChar::
	inc de
PlaceNextChar::
	; charmap order: commands, then ngrams, then specials, then literals
	ld a, [de]
	cp BATTLEEXTRA_GFX_START
	jr nc, _PlaceLiteralChar
	cp SPECIALS_START
	jr nc, _PlaceSpecialChar
	cp NGRAMS_START
	jr nc, _PlaceNgramChar
	dec de
	jmp FinishString


_PlaceNgramChar:
	sub NGRAMS_START
	push de
	push hl
	ld e, a
	ld d, 0
	ld hl, NgramStrings
	add hl, de
	ld e, [hl]
	add hl, de
	cp NGRAMS_VAR_START - NGRAMS_START
	jr c, .done
	; These are pointers to strings
	ld a, [hli]
	ld h, [hl]
	ld l, a
.done
	ld d, h
	ld e, l
	pop hl
	jmp PlaceCommandCharacter

_PlaceSpecialChar:
	sub SPECIALS_START
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
	dw DoneText         ; "<DONE>"
	dw FinishString     ; "@"
	dw PromptText       ; "<PROMPT>"
	dw LineBreak        ; "<LNBRK>"
	dw NextLineChar     ; "<NEXT>"
	dw LineChar         ; "<LINE>"
	dw ContText         ; "<CONT>"
	dw Paragraph        ; "<PARA>"
	dw PlaceTargetsName ; "<TARGET>"
	dw PlaceUsersName   ; "<USER>"
	dw PlaceEnemysName  ; "<ENEMY>"
	dw DecompressString ; "<CTXT>"
	dw SpaceChar        ; "¯"

NextLineChar::
	ld b, 0
	jr HandleLineBreak

LineBreak:
	ld b, 1 << NO_LINE_SPACING_F
	; fallthrough
HandleLineBreak:
	ld a, [wTextboxFlags]
	or b
	bit USE_BG_MAP_WIDTH_F, a
	ld bc, SCREEN_WIDTH
	jr z, .got_screen_width
	ld c, BG_MAP_WIDTH

.got_screen_width
	bit NO_LINE_SPACING_F, a
	jr nz, .ok
	sla c

.ok
	pop hl
	add hl, bc
	push hl
	jr NextChar

LineChar::
	pop hl
	hlcoord TEXTBOX_INNERX, TEXTBOX_INNERY + 2
	push hl
	jr NextChar

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
	jmp NextChar

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
	jmp NextChar

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
	ld de, wBattleMonNickname
	and a
	jr z, PlaceCommandCharacter
	ld de, .EnemyText
	rst PlaceString
	ld h, b
	ld l, c
	ld a, [wBattleType]
	cp BATTLETYPE_GHOST
	ld de, wEnemyMonNickname
	jr nz, PlaceCommandCharacter
	ld de, GhostNicknameText
	jr PlaceCommandCharacter

.EnemyText:
	db "Foe" ; fallthrough, no " @"
SpaceText::
	db " " ; fallthrough, no "@"
EmptyString::
	db "@"

GhostNicknameText:
	db "Ghost@"

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
	jmp NextChar

TextCommand_PLURAL:
; Pluralize the last word. Might perform edits on it (Candy -> Candies).
	; If wItemQuantityBuffer is 1, do nothing.
	ld a, [wItemQuantityChangeBuffer]
	dec a
	ret z

	; Try to pattern match the previous string with the plural table below.
	push hl
	push bc

	ld hl, PluralTable

.check_match_loop
	; Iterate until the pattern no longer matches our string.
	dec bc
	ld a, [bc]

	; If we find a terminator in the input string, we must have gone past it
	; into other data. Handle this separately. The reason for this is that
	; otherwise, if the plural table is also at a terminator, we'll misalign the
	; parser into reading output as input and vice versa.
	cp "@"
	jr nz, .not_at_start
	cp [hl]
	jr nz, .no_match
	inc hl
	jr .match

.not_at_start
	cp [hl]
	ld a, [hli] ; To check if we found the terminator.
	jr z, .check_match_loop

	; Did we hit the terminator?
	cp "@"
	jr nz, .no_match

.match
	; We have a match. Print out the adjusted string.
	inc bc
	ld d, h
	ld e, l
	ld h, b
	ld l, c
	pop bc
	call PlaceString
	inc hl
	ld [hl], "@"
	pop hl
	ret

.no_match
	ld b, 2
.no_match_loop
	ld a, [hli]
	cp "@"
	jr nz, .no_match_loop
	dec b
	jr nz, .no_match_loop
	pop bc
	push bc
	jr .check_match_loop

INCLUDE "data/text/plural_table.asm"

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
	jmp DelayFrames

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
	xor a
	ldh [hStopPrintingString], a
.loop
	ldh a, [hStopPrintingString]
	and a
	ret nz
	ld a, [hli]
	call CheckTerminatorChar
	ret z
	call .TextCommand
	jr .loop

.TextCommand:
	cp NGRAMS_START
	jr nc, _ImplicitlyStartedText
	push hl
	ld e, a
	ld d, 0
	ld hl, TextCommands
	add hl, de
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	push de
	ret

TextCommands::
	table_width 2
	dw TextCommand_START         ; $00 <START>
	dw TextCommand_RAM           ; $01 <RAM>
	dw TextCommand_PROMPT_BUTTON ; $02 <WAIT>
	dw TextCommand_ASM           ; $03 <ASM>
	dw TextCommand_DECIMAL       ; $04 <NUM>
	dw TextCommand_PAUSE         ; $05 <PAUSE>
	dw TextCommand_SOUND         ; $06 <SOUND>
	dw TextCommand_DAY           ; $07 <DAY>
	dw TextCommand_FAR           ; $08 <FAR>
	dw TextCommand_PLURAL        ; $09 <PLURAL>
	assert_table_length NGRAMS_START

_ImplicitlyStartedText:
	dec hl
TextCommand_START::
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

TextCommand_RAM::
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

TextCommand_FAR::
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

TextCommand_PROMPT_BUTTON::
; wait for button press; show arrow
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

TextCommand_ASM::
	bit 7, h
	jr nz, .not_rom
	jp hl

.not_rom
	ld [hl], "@"
	ret

TextCommand_DECIMAL::
; print a decimal number
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
	or PRINTNUM_DELAY | PRINTNUM_LEFTALIGN
	ld b, a
	call PrintNum
FinishString:
	ld b, h
	ld c, l
	pop hl
	ret

TextCommand_PAUSE::
; wait for button press or 30 frames
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

TextCommand_SOUND::
; play a sound effect
	ld a, [hli]
	push hl
	push de
	push bc
	ld e, a
	ld d, 0
	call PlaySFX
	call WaitSFX
	jmp PopBCDEHL

TextCommand_DAY::
; print the day of the week
	call GetWeekday
PrintDayOfWeek::
	push hl
	push bc
	ld c, a
	ld b, 0
	ld hl, .Days
	add hl, bc
	ld c, [hl]
	add hl, bc
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
	dr .Sun
	dr .Mon
	dr .Tues
	dr .Wednes
	dr .Thurs
	dr .Fri
	dr .Satur

.Sun:    db "Sun@"
.Mon:    db "Mon@"
.Tues:   db "Tues@"
.Wednes: db "Wednes@"
.Thurs:  db "Thurs@"
.Fri:    db "Fri@"
.Satur:  db "Satur@"
.Day:    db "day@"

DecompressString::
	; save starting coords
	pop bc
	push bc
	ld a, c
	ldh [hPlaceStringCoords], a
	ld a, b
	ldh [hPlaceStringCoords+1], a

	call SwapHLDE ; hl = string, de = current coords

	inc hl ; skip "<CTXT>"

	; terminate buffer for printing each character
	ld a, "@"
	ldh [hCompressedTextBuffer+1], a

	ld b, 1 ; start with no bits to read a byte right away
.character_loop

	push de ; push current coords

	call ReadHuffmanChar

	; buffer character for printing
	ldh [hCompressedTextBuffer], a

	pop de ; pop current coords

	push hl ; push string position
	push bc ; push bit-reading state

	; hl = current coords
	ld h, d
	ld l, e

	; read saved starting coords
	ldh a, [hPlaceStringCoords]
	ld c, a
	ldh a, [hPlaceStringCoords+1]
	ld b, a

	ld de, hCompressedTextBuffer
	ld a, [de]
	push af

	; print string de at coord hl, having started from coord bc
	call PlaceSubstring

	; write updated starting coords
	ld a, l
	ldh [hPlaceStringCoords], a
	ld a, h
	ldh [hPlaceStringCoords+1], a

	; update current coords
	ld d, b
	ld e, c

	pop af

	pop bc ; pop bit-reading state
	pop hl ; pop string position

	; check for characters that signal end of compression
	; (same ones that finish PlaceString)
	sub "<DONE>"
	jr z, .done
	assert "<DONE>" + 1 == "@"
	dec a
	jr z, .end
	assert "@" + 1 == "<PROMPT>"
	dec a
	jr nz, .character_loop

.done
	inc a ; ld a, 1 since it's zero
	ldh [hStopPrintingString], a

.end
	pop bc ; pop starting coords

	; update current coords
	ld b, d
	ld c, e

	; update string position
	ld d, h
	ld e, l
	dec de

	; restore starting coords
	ldh a, [hPlaceStringCoords]
	ld l, a
	ldh a, [hPlaceStringCoords+1]
	ld h, a
	ret

DecompressStringToRAM::
; input: hl = string, de = destination

	ld a, [hl]
	cp "<CTXT>"
	jr nz, .copy_loop

	inc hl ; skip "<CTXT>"

	ld b, 1 ; start with no bits to read a byte right away
.character_loop

	push de
	call ReadHuffmanChar
	pop de
	; check for characters that signal end of compression
	; (same ones that finish PlaceString)
	call CheckTerminatorChar
	jr z, .append_terminator

	; Store decompressed char to WRAM and advance
	ld [de], a
	inc de
	jr .character_loop

.copy_loop
	ld a, [hli]
	call CheckTerminatorChar
	jr z, .append_terminator
	ld [de], a
	inc de
	jr .copy_loop

.append_terminator
	ld [de], a
	ret

ReadHuffmanChar:
	assert ROOT_NODE_ID == $00
	xor a
.tree_loop
	; "c = [hli]" when b reaches 0, then carry = next bit from c
	dec b
	jr nz, .no_reload
	ld c, [hl] ; no-optimize b|c|d|e = *hl++|*hl--
	inc hl
	ld b, 8
.no_reload
	sla c
	; de = TextCompressionHuffmanTree[node=a][branch=carry]
	adc a
	add LOW(TextCompressionHuffmanTree)
	ld e, a
	adc HIGH(TextCompressionHuffmanTree)
	sub e
	ld d, a
	; keep traversing the tree until a leaf node
	ld a, [de]
	cp FIRST_LEAF_NODE_ID
	jr c, .tree_loop

	; shifted leaf node IDs correspond to lesser characters
	; (since node IDs below the first leaf node ID must be parent nodes)
	cp FIRST_SHIFTED_LEAF_NODE_ID
	ret c
	sub FIRST_SHIFTED_LEAF_NODE_ID - FIRST_SHIFTED_LEAF_CHAR_ID
	ret

CheckTerminatorChar:
; check for a character that terminates `_dchr` Huffman compression
	cp "@"
	ret z
	cp "<DONE>"
	ret z
	cp "<PROMPT>"
	ret
