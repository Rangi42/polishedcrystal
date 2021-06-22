NAMINGSCREEN_BORDER EQU $60
NAMINGSCREEN_CURSOR EQU $7e

NAMINGSCREEN_MIDDLELINE EQU "′"
NAMINGSCREEN_UNDERLINE  EQU "″"

_NamingScreen:
	call DisableSpriteUpdates
	call NamingScreen
	jmp ReturnToMapWithSpeechTextbox

NamingScreen:
	ld hl, wNamingScreenDestinationPointer
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, wNamingScreenType
	ld [hl], b
	ld hl, wOptions1
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hMapAnims], a
	ldh a, [hInMenu]
	push af
	ld a, $1
	ldh [hInMenu], a
	call .SetUpNamingScreen
	call DelayFrame
.loop
	call NamingScreenJoypadLoop
	jr nc, .loop
	pop af
	ldh [hInMenu], a
	pop af
	ldh [hMapAnims], a
	pop af
	ld [wOptions1], a
	jmp ClearJoypad

.SetUpNamingScreen:
	call ClearBGPalettes
	ld a, CGB_DIPLOMA
	call GetCGBLayout
	call DisableLCD
	call LoadNamingScreenGFX
	call NamingScreen_InitText
	ld a, %11100011
	ldh [rLCDC], a
	call .GetNamingScreenSetup
	call ApplyTilemapInVBlank
	call WaitTop
	call SetPalettes
	jmp NamingScreen_InitNameEntry

.GetNamingScreenSetup:
	ld a, [wNamingScreenType]
	and 7
	call StackJumpTable

.Jumptable:
	dw .Pokemon
	dw .Player
	dw .Rival
	dw .TrendyPhrase
	dw .Box

.Pokemon:
	ld a, [wCurPartySpecies]
	ld [wTempIconSpecies], a
	farcall LoadNamingScreenMonIcon
	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndex], a
	call GetPokemonName
	hlcoord 5, 2
	rst PlaceString
	hlcoord 5, 4
	ld [hl], "/"
	farcall GetGender
	jr c, .genderless
	ld a, "♂"
	jr nz, .place_gender
	ld a, "♀"
.place_gender
	hlcoord 1, 2
	ld [hl], a
.genderless
	farcall GetShininess
	jr z, .not_shiny
	hlcoord 1, 4
	ld [hl], "★"
.not_shiny
	jmp .StoreMonIconParams

.Player:
	farcall _GetPlayerIcon
	ld a, [wPlayerGender]
	bit 0, a
	ld c, SPRITE_ANIM_INDEX_RED_WALK
	jr z, .got_player_walk
	ld c, SPRITE_ANIM_INDEX_BLUE_WALK
.got_player_walk
	call .LoadSprite
	hlcoord 5, 2
	ld de, .PlayerNameString
	rst PlaceString
	jmp .StoreSpriteIconParams

.PlayerNameString:
	db "Your name?@"

.Rival:
	ld hl, SilverSpriteGFX
	lb bc, BANK(SilverSpriteGFX), SPRITE_ANIM_INDEX_RED_WALK
	call .LoadSprite
	hlcoord 5, 2
	ld de, .RivalNameString
	rst PlaceString
	jmp .StoreSpriteIconParams

.RivalNameString:
	db "Rival's name?@"

.TrendyPhrase:
	ld hl, ArtistSpriteGFX
	lb bc, BANK(ArtistSpriteGFX), SPRITE_ANIM_INDEX_BLUE_WALK
	call .LoadSprite
	hlcoord 5, 2
	ld de, .TrendyPhraseString
	rst PlaceString
	jr .StoreSpriteIconParams

.TrendyPhraseString:
	db "What's trendy?@"

.Box:
	ld de, vTiles0 tile $00
	ld hl, BallCutFruitSpriteGFX
	lb bc, BANK(BallCutFruitSpriteGFX), 4
	call DecompressRequest2bpp
	xor a
	ld hl, wSpriteAnimDict
	ld [hli], a
	ld [hl], a
	depixel 4, 4, 4, 0
	ld a, SPRITE_ANIM_INDEX_RED_WALK
	call _InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld [hl], SPRITE_ANIM_FRAMESET_NULL
	hlcoord 5, 2
	ld de, .BoxNameString
	rst PlaceString
	jr .StoreBoxIconParams

.BoxNameString:
	db "Box name?@"

.LoadSprite:
	push bc
	ld de, vTiles0 tile $00
	ld c, 4
	call DecompressRequest2bpp
	ld de, wDecompressScratch + 12 tiles
	ld hl, vTiles0 tile $04
	lb bc, BANK(wDecompressScratch), 4
	call Request2bppInWRA6
	pop bc
	xor a
	ld hl, wSpriteAnimDict
	ld [hli], a
	ld [hl], a
	ld a, c
	depixel 4, 4, 4, 0
	jmp _InitSpriteAnimStruct

.StoreMonIconParams:
	ld a, MON_NAME_LENGTH - 1
	hlcoord 7, 4
	jr .StoreParams

.StoreSpriteIconParams:
	ld a, PLAYER_NAME_LENGTH - 1
	hlcoord 5, 4
	jr .StoreParams

.StoreBoxIconParams:
	; the terminator isn't saved, so no "- 1" is needed.
	ld a, BOX_NAME_LENGTH
	hlcoord 5, 4

.StoreParams:
	ld [wNamingScreenMaxNameLength], a
	ld a, l
	ld [wNamingScreenStringEntryCoord], a
	ld a, h
	ld [wNamingScreenStringEntryCoord + 1], a
	ret

NamingScreen_InitText:
	call WaitTop
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, NAMINGSCREEN_BORDER
	rst ByteFill
	hlcoord 1, 1
	lb bc, 4, 18
	call ClearBox
	ld a, [wOptions3]
	bit QWERTY_KEYBOARD_F, a
	ld de, NameInputUpper
	jr z, NamingScreen_ApplyTextInputMode
	ld de, NameInputUpperQwerty
NamingScreen_ApplyTextInputMode:
	push de
	hlcoord 1, 6
	lb bc, 9, 18
	call ClearBox
	hlcoord 1, 16
	lb bc, 1, 18
	call ClearBox
	pop de
	hlcoord 2, 6
	ld b, $6

.row
	ld c, $11
.col
	ld a, [de]
	ld [hli], a
	inc de
	dec c
	jr nz, .col
	push de
	ld de, 2 * SCREEN_WIDTH - $11
	add hl, de
	pop de
	dec b
	jr nz, .row
	ret

NamingScreenJoypadLoop:
	call JoyTextDelay
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .quit
	call .RunJumptable
	farcall PlaySpriteAnimationsAndDelayFrame
	call .UpdateStringEntry
	call DelayFrame
	and a
	ret

.quit
	call ClearSpriteAnims
	call ClearSprites
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	scf
	ret

.UpdateStringEntry:
	xor a
	ldh [hBGMapMode], a
	hlcoord 1, 3
	lb bc, 1, 18
	call ClearBox
	ld hl, wNamingScreenDestinationPointer
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, wNamingScreenStringEntryCoord
	ld a, [hli]
	ld h, [hl]
	ld l, a
	rst PlaceString
	ld a, $1
	ldh [hBGMapMode], a
	ret

.RunJumptable:
	call StandardStackJumpTable

.Jumptable:
	dw .InitCursor
	dw .ReadButtons

.InitCursor:
	depixel 8, 3
	ld a, SPRITE_ANIM_INDEX_NAMING_SCREEN_CURSOR
	call _InitSpriteAnimStruct
	ld a, c
	ld [wNamingScreenCursorObjectPointer], a
	ld a, b
	ld [wNamingScreenCursorObjectPointer + 1], a
	ld hl, SPRITEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld a, [hl]
	ld hl, SPRITEANIMSTRUCT_VAR3
	add hl, bc
	ld [hl], a
	ld hl, wJumptableIndex
	inc [hl]
	ret

.ReadButtons:
	ld hl, hJoyPressed
	ld a, [hl]
	and A_BUTTON
	jr nz, .a
	ld a, [hl]
	and B_BUTTON
	jr nz, .b
	ld a, [hl]
	and START
	jr nz, .start
	ld a, [hl]
	and SELECT
	jr nz, .select
	ret

.a
	call .GetCursorPosition
	cp $1
	jr z, .select
	cp $2
	jr z, .b
	cp $3
	jr z, .end
	call NamingScreen_GetLastCharacter
	call NamingScreen_TryAddCharacter
	jr c, .start
	ld a, [wNamingScreenLetterCase]
	and a ; already lowercase? (a == 1)
	ret nz
	ld a, [wNamingScreenCurNameLength]
	dec a ; first character uppercase, rest lowercase (by default)
	jr z, .select
	ret

.start
	ld hl, wNamingScreenCursorObjectPointer
	ld c, [hl]
	inc hl
	ld b, [hl]
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $8
	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], $5
	ret

.b
	call NamingScreen_DeleteCharacter
	ld a, [wNamingScreenLetterCase]
	and a ; already uppercase? (a == 0)
	ret z
	ld a, [wNamingScreenCurNameLength]
	and a ; ; first character uppercase, rest lowercase (by default)
	ret nz
	; fallthrough

.select
	ld hl, wNamingScreenLetterCase
	ld a, [hl]
	xor 1
	ld [hl], a
	jr z, .upper
	ld a, [wOptions3]
	bit QWERTY_KEYBOARD_F, a
	ld de, NameInputLower
	jr z, .ready
	ld de, NameInputLowerQwerty
	jr .ready

.end
	call NamingScreen_StoreEntry
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

.upper
	ld a, [wOptions3]
	bit QWERTY_KEYBOARD_F, a
	ld de, NameInputUpper
	jr z, .ready
	ld de, NameInputUpperQwerty
.ready
	jmp NamingScreen_ApplyTextInputMode

.GetCursorPosition:
	ld hl, wNamingScreenCursorObjectPointer
	ld c, [hl]
	inc hl
	ld b, [hl]

NamingScreen_GetCursorPosition:
	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	cp $5
	jr nz, .not_bottom_row
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cp $3
	jr c, .case_switch
	cp $6
	jr c, .delete
	ld a, $3
	ret

.case_switch
	ld a, $1
	ret

.delete
	ld a, $2
	ret

.not_bottom_row
	xor a
	ret

NamingScreen_AnimateCursor:
	call .GetDPad
	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	ld e, a
	swap e
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], e
	cp $5
	ld de, .LetterEntries
	ld a, 0
	jr nz, .got_pointer
	ld de, .CaseDelEnd
	inc a
.got_pointer
	ld hl, SPRITEANIMSTRUCT_VAR3
	add hl, bc
	add [hl]
	ld hl, SPRITEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld [hl], a
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld l, [hl]
	ld h, $0
	add hl, de
	ld a, [hl]
	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

.LetterEntries:
	db $00, $10, $20, $30, $40, $50, $60, $70, $80

.CaseDelEnd:
	db $00, $00, $00, $30, $30, $30, $60, $60, $60

.GetDPad:
	ld hl, hJoyLast
	ld a, [hl]
	and D_UP
	jr nz, .up
	ld a, [hl]
	and D_DOWN
	jr nz, .down
	ld a, [hl]
	and D_LEFT
	jr nz, .left
	ld a, [hl]
	and D_RIGHT
	ret z

; right
	call NamingScreen_GetCursorPosition
	and a
	jr nz, .asm_11ab7
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cp $8
	jr nc, .asm_11ab4
	inc [hl]
	ret

.asm_11ab4
	ld [hl], $0
	ret

.asm_11ab7
	cp $3
	jr nz, .asm_11abc
	xor a
.asm_11abc
	ld e, a
	add a
	add e
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], a
	ret

.left
	call NamingScreen_GetCursorPosition
	and a
	jr nz, .asm_11ad8
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	and a
	jr z, .asm_11ad5
	dec [hl]
	ret

.asm_11ad5
	ld [hl], $8
	ret

.asm_11ad8
	cp $1
	jr nz, .asm_11ade
	ld a, $4
.asm_11ade
	dec a
	dec a
	ld e, a
	add a
	add e
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], a
	ret

.down
	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	cp $5
	jr nc, .asm_11aff
	inc [hl]
	ret

.asm_11aff
	ld [hl], $0
	ret

.up
	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	and a
	jr z, .asm_11b0c
	dec [hl]
	ret

.asm_11b0c
	ld [hl], $5
	ret

NamingScreen_TryAddCharacter:
MailComposition_TryAddCharacter:
	ld a, [wNamingScreenMaxNameLength]
	ld c, a
	ld a, [wNamingScreenCurNameLength]
	cp c
	ret nc

	ld a, [wNamingScreenLastCharacter]
	call NamingScreen_GetTextCursorPosition
	ld [hl], a
	ld hl, wNamingScreenCurNameLength
	inc [hl]
	call NamingScreen_GetTextCursorPosition
	ld a, [hl]
	cp "@"
	jr z, .end_of_string
	ld [hl], NAMINGSCREEN_UNDERLINE
	and a
	ret

.end_of_string
	scf
	ret

NamingScreen_DeleteCharacter:
	ld hl, wNamingScreenCurNameLength
	ld a, [hl]
	and a
	ret z
	dec [hl]
	call NamingScreen_GetTextCursorPosition
	ld a, NAMINGSCREEN_UNDERLINE
	ld [hli], a
	ld a, [hl]
	cp NAMINGSCREEN_UNDERLINE
	ret nz
	ld [hl], NAMINGSCREEN_MIDDLELINE
	ret

NamingScreen_GetTextCursorPosition:
	push af
	ld hl, wNamingScreenDestinationPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wNamingScreenCurNameLength]
	ld e, a
	ld d, 0
	add hl, de
	pop af
	ret

NamingScreen_InitNameEntry:
; load NAMINGSCREEN_UNDERLINE, (NAMINGSCREEN_MIDDLELINE * [wNamingScreenMaxNameLength]), "@" into the dw address at wNamingScreenDestinationPointer
	ld hl, wNamingScreenDestinationPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, NAMINGSCREEN_UNDERLINE
	ld [hli], a
	ld a, [wNamingScreenMaxNameLength]
	dec a
	ld c, a
	ld a, NAMINGSCREEN_MIDDLELINE
.loop
	ld [hli], a
	dec c
	jr nz, .loop
	ld [hl], "@"
	ret

NamingScreen_StoreEntry:
	ld hl, wNamingScreenDestinationPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wNamingScreenMaxNameLength]
	ld c, a
.loop
	ld a, [hl]
	cp NAMINGSCREEN_MIDDLELINE
	jr z, .terminator
	cp NAMINGSCREEN_UNDERLINE
	jr nz, .not_terminator
.terminator
	ld [hl], "@"
.not_terminator
	inc hl
	dec c
	jr nz, .loop
	ret

NamingScreen_GetLastCharacter:
	ld hl, wNamingScreenCursorObjectPointer
	ld c, [hl]
	inc hl
	ld b, [hl]
	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld a, [hl]
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	add [hl]
	sub $8
	rrca
	rrca
	rrca
	and %00011111
	ld e, a
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	add [hl]
	sub $10
	rrca
	rrca
	rrca
	and %00011111
	ld d, a
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH
.loop
	ld a, d
	and a
	jr z, .done
	add hl, bc
	dec d
	jr .loop

.done
	add hl, de
	ld a, [hl]
	ld [wNamingScreenLastCharacter], a
	ret

LoadNamingScreenGFX:
	call ClearSprites
	call ClearSpriteAnims
	call LoadStandardFont
	call LoadFontsExtra

	ld de, vTiles2 tile NAMINGSCREEN_BORDER
	ld hl, NamingScreenGFX_Border
	ld bc, 1 tiles
	ld a, BANK(NamingScreenGFX_Border)
	call FarCopyBytes

	ld de, vTiles0 tile NAMINGSCREEN_CURSOR
	ld hl, NamingScreenGFX_Cursor
	ld bc, 2 tiles
	ld a, BANK(NamingScreenGFX_Cursor)
	call FarCopyBytes

	ld de, vTiles0 tile NAMINGSCREEN_MIDDLELINE
	ld hl, NamingScreenGFX_Lines
	ld bc, 2 tiles
	ld a, BANK(NamingScreenGFX_Lines)
	call FarCopyBytes

	ld a, $5
	ld hl, wSpriteAnimDict + 9 * 2
	ld [hli], a
	ld [hl], NAMINGSCREEN_CURSOR
	xor a
	ldh [hSCY], a
	ld [wGlobalAnimYOffset], a
	ldh [hSCX], a
	ld [wGlobalAnimXOffset], a
	ld [wJumptableIndex], a
	ld [wNamingScreenLetterCase], a
	ldh [hBGMapMode], a
	ld [wNamingScreenCurNameLength], a
	ld a, $7
	ldh [hWX], a
	ret

NamingScreenGFX_Border:
INCBIN "gfx/naming_screen/naming_border.2bpp"

NamingScreenGFX_Cursor:
INCBIN "gfx/naming_screen/naming_cursor.2bpp"

NamingScreenGFX_Lines:
INCBIN "gfx/naming_screen/lines.2bpp"

INCLUDE "data/text/input_chars.asm"

_ComposeMailMessage:
	ld hl, wNamingScreenDestinationPointer
	ld [hl], e
	inc hl
	ld [hl], d
	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hMapAnims], a
	ldh a, [hInMenu]
	push af
	ld a, $1
	ldh [hInMenu], a
	call .InitBlankMail
	call DelayFrame

.loop
	call .DoMailEntry
	jr nc, .loop

	pop af
	ldh [hInMenu], a
	pop af
	ldh [hMapAnims], a
	ret

.InitBlankMail:
	call ClearBGPalettes
	call DisableLCD
	call LoadNamingScreenGFX
	ld hl, .MailIcon
	ld de, vTiles0 tile $00
	lb bc, BANK(.MailIcon), 8
	call DecompressRequest2bpp
	xor a
	ld hl, wSpriteAnimDict
	ld [hli], a
	ld [hl], a

	; init mail icon
	depixel 3, 2
	ld a, SPRITE_ANIM_INDEX_PARTY_MON
	call _InitSpriteAnimStruct

	ld hl, SPRITEANIMSTRUCT_ANIM_SEQ_ID
	add hl, bc
	ld [hl], $0
	call .InitCharset
	ld a, %11100011
	ldh [rLCDC], a
	call .initwNamingScreenMaxNameLength
	ld a, CGB_DIPLOMA
	call GetCGBLayout
	call ApplyTilemapInVBlank
	call WaitTop
	ld a, %11100100
	call DmgToCgbBGPals
	ld a, %11100100
	call DmgToCgbObjPal0
	call NamingScreen_InitNameEntry
	ld hl, wNamingScreenDestinationPointer
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, $10
	add hl, de
	ld [hl], "<NEXT>"
	ret

.MailIcon:
INCBIN "gfx/icons/mail2.2bpp.lz"

.initwNamingScreenMaxNameLength
	ld a, MAIL_MSG_LENGTH + 1
	ld [wNamingScreenMaxNameLength], a
	ret

.InitCharset:
	call WaitTop
	hlcoord 0, 0
	ld bc, 6 * SCREEN_WIDTH
	ld a, NAMINGSCREEN_BORDER
	rst ByteFill
	hlcoord 0, 6
	ld bc, 12 * SCREEN_WIDTH
	ld a, " "
	rst ByteFill
	hlcoord 1, 1
	lb bc, 4, SCREEN_WIDTH - 2
	call ClearBox
	ld a, [wOptions3]
	bit QWERTY_KEYBOARD_F, a
	ld de, MailEntry_Uppercase
	jr z, .PlaceMailCharset
	ld de, MailEntryQwerty_Uppercase

.PlaceMailCharset:
	hlcoord 1, 7
	ld b, 6
.next
	ld c, SCREEN_WIDTH - 1
.loop_
	ld a, [de]
	ld [hli], a
	inc de
	dec c
	jr nz, .loop_
	push de
	ld de, SCREEN_WIDTH + 1
	add hl, de
	pop de
	dec b
	jr nz, .next
	ret

.DoMailEntry:
	call JoyTextDelay
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .exit_mail
	call .DoJumptable
	farcall PlaySpriteAnimationsAndDelayFrame
	call .Update
	call DelayFrame
	and a
	ret

.exit_mail
	call ClearSpriteAnims
	call ClearSprites
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	scf
	ret

.Update:
	xor a
	ldh [hBGMapMode], a
	hlcoord 1, 1
	lb bc, 4, 18
	call ClearBox
	ld hl, wNamingScreenDestinationPointer
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 2, 2
	rst PlaceString
	ld a, $1
	ldh [hBGMapMode], a
	ret

.DoJumptable:
	call StandardStackJumpTable

.Jumptable:
	dw .init_blinking_cursor
	dw .process_joypad

.init_blinking_cursor
	depixel 9, 2
	ld a, SPRITE_ANIM_INDEX_COMPOSE_MAIL_CURSOR
	call _InitSpriteAnimStruct
	ld a, c
	ld [wNamingScreenCursorObjectPointer], a
	ld a, b
	ld [wNamingScreenCursorObjectPointer + 1], a
	ld hl, SPRITEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld a, [hl]
	ld hl, SPRITEANIMSTRUCT_VAR3
	add hl, bc
	ld [hl], a
	ld hl, wJumptableIndex
	inc [hl]
	ret

.process_joypad
	ld hl, hJoyPressed
	ld a, [hl]
	and A_BUTTON
	jr nz, .a
	ld a, [hl]
	and B_BUTTON
	jr nz, .b
	ld a, [hl]
	and START
	jr nz, .start
	ld a, [hl]
	and SELECT
	jr nz, .select
	ret

.a
	call NamingScreen_PressedA_GetCursorCommand
	cp $1
	jr z, .select
	cp $2
	jr z, .b
	cp $3
	jr z, .finished
	call NamingScreen_GetLastCharacter
	call MailComposition_TryAddLastCharacter
	jr c, .start
	ld hl, wNamingScreenCurNameLength
	ld a, [hl]
	cp $10
	ret nz
	inc [hl]
	call NamingScreen_GetTextCursorPosition
	ld a, NAMINGSCREEN_UNDERLINE
	ld [hld], a
	ld [hl], "<NEXT>"
	ret

.start
	ld hl, wNamingScreenCursorObjectPointer
	ld c, [hl]
	inc hl
	ld b, [hl]
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $9
	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], $5
	ret

.b
	call NamingScreen_DeleteCharacter
	ld hl, wNamingScreenCurNameLength
	ld a, [hl]
	cp $10
	ret nz
	dec [hl]
	call NamingScreen_GetTextCursorPosition
	ld a, NAMINGSCREEN_UNDERLINE
	ld [hli], a
	ld [hl], "<NEXT>"
	ret

.finished
	call NamingScreen_StoreEntry
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

.select
	ld hl, wNamingScreenLetterCase
	ld a, [hl]
	xor $1
	ld [hl], a
	jr nz, .switch_to_lowercase
	ld a, [wOptions3]
	bit QWERTY_KEYBOARD_F, a
	ld de, MailEntry_Uppercase
	jr z, .ready
	ld de, MailEntryQwerty_Uppercase
	jr .ready

.switch_to_lowercase
	ld a, [wOptions3]
	bit QWERTY_KEYBOARD_F, a
	ld de, MailEntry_Lowercase
	jr z, .ready
	ld de, MailEntryQwerty_Lowercase
.ready
	jmp .PlaceMailCharset

; called from engine/sprite_anims.asm

ComposeMail_AnimateCursor:
	call .GetDPad
	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	ld e, a
	swap e
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], e
	cp $5
	ld de, .LetterEntries
	ld a, 0
	jr nz, .got_pointer
	ld de, .CaseDelEnd
	inc a
.got_pointer
	ld hl, SPRITEANIMSTRUCT_VAR3
	add hl, bc
	add [hl]
	ld hl, SPRITEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld [hl], a
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld l, [hl]
	ld h, $0
	add hl, de
	ld a, [hl]
	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

.LetterEntries:
	db $00, $10, $20, $30, $40, $50, $60, $70, $80, $90

.CaseDelEnd:
	db $00, $00, $00, $30, $30, $30, $60, $60, $60, $60

.GetDPad:
	ld hl, hJoyLast
	ld a, [hl]
	and D_UP
	jr nz, .up
	ld a, [hl]
	and D_DOWN
	jr nz, .down
	ld a, [hl]
	and D_LEFT
	jr nz, .left
	ld a, [hl]
	and D_RIGHT
	ret z

; right
	call ComposeMail_GetCursorPosition
	and a
	jr nz, .case_del_done_right
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cp $9
	jr nc, .wrap_around_letter_right
	inc [hl]
	ret

.wrap_around_letter_right
	ld [hl], $0
	ret

.case_del_done_right
	cp $3
	jr nz, .wrap_around_command_right
	xor a
.wrap_around_command_right
	ld e, a
	add a
	add e
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], a
	ret

.left
	call ComposeMail_GetCursorPosition
	and a
	jr nz, .caps_del_done_left
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	and a
	jr z, .wrap_around_letter_left
	dec [hl]
	ret

.wrap_around_letter_left
	ld [hl], $9
	ret

.caps_del_done_left
	cp $1
	jr nz, .wrap_around_command_left
	ld a, $4
.wrap_around_command_left
	dec a
	dec a
	ld e, a
	add a
	add e
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], a
	ret

.down
	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	cp $5
	jr nc, .wrap_around_down
	inc [hl]
	ret

.wrap_around_down
	ld [hl], $0
	ret

.up
	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	and a
	jr z, .wrap_around_up
	dec [hl]
	ret

.wrap_around_up
	ld [hl], $5
	ret

NamingScreen_PressedA_GetCursorCommand:
	ld hl, wNamingScreenCursorObjectPointer
	ld c, [hl]
	inc hl
	ld b, [hl]

ComposeMail_GetCursorPosition:
	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	cp $5
	jr nz, .letter
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cp $3
	jr c, .case
	cp $6
	jr c, .del
	ld a, $3
	ret

.case
	ld a, $1
	ret

.del
	ld a, $2
	ret

.letter
	xor a
	ret

MailComposition_TryAddLastCharacter:
	ld a, [wNamingScreenLastCharacter]
	jmp MailComposition_TryAddCharacter

