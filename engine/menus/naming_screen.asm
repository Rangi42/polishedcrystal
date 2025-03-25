DEF NAMINGSCREEN_BORDER EQU $60
DEF NAMINGSCREEN_MALE EQU $6b
DEF NAMINGSCREEN_FEMALE EQU $6c
DEF NAMINGSCREEN_CURSOR EQU $7e

DEF NAMINGSCREEN_MIDDLELINE EQU "′"
DEF NAMINGSCREEN_UNDERLINE  EQU "″"

_NamingScreen:
	call DisableSpriteUpdates
	call NamingScreen
	jmp ReturnToMapWithSpeechTextbox

NamingScreen:
	ld hl, wNamingScreenDestinationPointer
	ld a, e
	ld [hli], a
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
	ld a, CGB_NAMING_SCREEN
	call GetCGBLayout
	call DisableLCD
	call LoadNamingScreenGFX
	call NamingScreen_InitText
	ld a, LCDC_DEFAULT
	ldh [rLCDC], a
	call .GetNamingScreenSetup
	call ApplyTilemapInVBlank
	call WaitTop
	call SetDefaultBGPAndOBP
	jmp NamingScreen_InitNameEntry

.GetNamingScreenSetup:
	ld a, [wNamingScreenType]
	call StackJumpTable

NamingScreenJumptable:
	table_width 2
	dw .Pokemon
	dw .Player
	dw .Rival
	dw .TrendyPhrase
	dw .Box
	assert_table_length NUM_NAMING_SCREEN_TYPES

.Pokemon:
	ld a, [wCurPartySpecies]
	ld [wTempIconSpecies], a
	farcall LoadNamingScreenMonMini
	call GetPartyPokemonName
	hlcoord 5, 2
	rst PlaceString
	hlcoord 5, 4
	ld [hl], "/"
	farcall GetGender
	jr c, .genderless
	ld a, NAMINGSCREEN_MALE
	jr nz, .place_gender
	ld a, NAMINGSCREEN_FEMALE
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
	ld c, SPRITE_ANIM_INDEX_RED_WALK
	and a ; PLAYER_MALE
	jr z, .got_player_walk
	ld c, SPRITE_ANIM_INDEX_BLUE_WALK
	dec a ; PLAYER_FEMALE
	jr z, .got_player_walk
	; PLAYER_ENBY
	ld c, SPRITE_ANIM_INDEX_GREEN_WALK
.got_player_walk
	call .LoadSprite
	hlcoord 5, 2
	ld de, .PlayerNameString
	rst PlaceString
	jmp .StoreSpriteIconParams

.PlayerNameString:
	db "Your name?@"

.Rival:
	ld hl, RivalSpriteGFX
	lb bc, BANK(RivalSpriteGFX), SPRITE_ANIM_INDEX_RED_WALK
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
	call InitSpriteAnimStruct
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
	ld c, 4
	call Request2bppInWRA6
	pop bc
	xor a
	ld hl, wSpriteAnimDict
	ld [hli], a
	ld [hl], a
	ld a, c
	depixel 4, 4, 4, 0
	jmp InitSpriteAnimStruct

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
	call NamingScreen_DrawBorders
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
	pop de
	hlcoord 2, 6
	ld b, 5
.row
	ld c, 9
.col
	ld a, [de]
	ld [hli], a
	inc hl
	inc de
	dec c
	jr nz, .col
	push de
	ld de, (SCREEN_WIDTH - 9) * 2
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
	ld a, [hli]
	ld d, [hl]
	ld e, a
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
	ld d, SPRITE_ANIM_INDEX_NAMING_SCREEN_CURSOR
	ld a, [wNamingScreenType]
	cp $4 ; box?
	jr nz, .got_cursor
	farcall GetBoxTheme
	ld d, SPRITE_ANIM_INDEX_NAMING_SCREEN_CURSOR_BLUE
	cp THEME_TRUTH
	jr z, .got_cursor
	cp THEME_FIRE
	jr z, .got_cursor
	cp THEME_ELECTRIC
	jr z, .got_cursor
	cp THEME_FAIRY
	jr z, .got_cursor
	ld d, SPRITE_ANIM_INDEX_NAMING_SCREEN_CURSOR
.got_cursor
	ld a, d
	depixel 8, 3
	call InitSpriteAnimStruct
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
	call NamingScreen_PressedA_GetCursorCommand
	dec a ; 1?
	jr z, .select
	dec a ; 2?
	jr z, .b
	dec a ; 3?
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
	ld a, [hli]
	ld b, [hl]
	ld c, a
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

NamingScreen_PressedA_GetCursorCommand:
	ld hl, wNamingScreenCursorObjectPointer
	ld a, [hli]
	ld b, [hl]
	ld c, a
	; fallthrough
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
	ld a, $8
	call NamingScreen_GetDPad
	ld hl, .LetterEntries
	ld de, .CaseDelEnd
	jr NamingScreen_MoveCursor

.LetterEntries:
	db $00, $10, $20, $30, $40, $50, $60, $70, $80

.CaseDelEnd:
	db $00, $00, $00, $30, $30, $30, $60, $60, $60

ComposeMail_AnimateCursor:
	ld a, $9
	call NamingScreen_GetDPad
	ld hl, .LetterEntries
	ld de, .CaseDelEnd
	jr NamingScreen_MoveCursor

.LetterEntries:
	db $00, $10, $20, $30, $40, $50, $60, $70, $80, $90

.CaseDelEnd:
	db $08, $08, $08, $38, $38, $38, $68, $68, $68, $68

NamingScreen_MoveCursor:
	push hl
	push de
	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	ld e, a
	swap e
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], e
	pop de
	pop hl
	cp $5
	jr nc, .got_pointer
	ld d, h
	ld e, l
.got_pointer
	; a = carry ? 0 ? 1
	sbc a
	inc a
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

NamingScreen_GetDPad:
	ld [wNamingScreenKeyboardWidth], a
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
	jr nz, .case_del_done_right
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [wNamingScreenKeyboardWidth]
	ld e, a
	ld a, [hl]
	cp e
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
	call NamingScreen_GetCursorPosition
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
	ld a, [wNamingScreenKeyboardWidth]
	ld [hl], a
	ret

.caps_del_done_left
	dec a
	jr nz, .wrap_around_command_left
	ld a, $3
.wrap_around_command_left
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

NamingScreen_TryAddCharacter:
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
	ld a, [hli]
	ld b, [hl]
	ld c, a
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
	call LoadFrame

	ld hl, NamingScreenGFX_Border
	ld de, vTiles2 tile NAMINGSCREEN_BORDER
	call Decompress

	; Gender symbols
	ld hl, BattleExtrasGFX
	ld de, vTiles2 tile NAMINGSCREEN_MALE
	lb bc, BANK(BattleExtrasGFX), 2
	call DecompressRequest2bpp

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
INCBIN "gfx/naming_screen/naming_border.2bpp.lz"

NamingScreenGFX_Cursor:
INCBIN "gfx/naming_screen/naming_cursor.2bpp"

NamingScreenGFX_Lines:
INCBIN "gfx/naming_screen/lines.2bpp"

INCLUDE "data/text/input_chars.asm"

_ComposeMailMessage:
	ld hl, wNamingScreenDestinationPointer
	ld a, e
	ld [hli], a
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
	call InitSpriteAnimStruct

	ld hl, SPRITEANIMSTRUCT_ANIM_SEQ_ID
	add hl, bc
	ld [hl], $0
	call .InitCharset
	ld a, LCDC_DEFAULT
	ldh [rLCDC], a
	call .initwNamingScreenMaxNameLength
	ld a, CGB_MAIL
	call GetCGBLayout
	call ApplyTilemapInVBlank
	call WaitTop
	call SetDefaultBGPAndOBP
	call NamingScreen_InitNameEntry
	ld hl, wNamingScreenDestinationPointer
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ld hl, $10
	add hl, de
	ld [hl], "<NEXT>"
	ret

.MailIcon:
INCBIN "gfx/naming_screen/mail.2bpp.lz"

.initwNamingScreenMaxNameLength
	ld a, MAIL_MSG_LENGTH + 1
	ld [wNamingScreenMaxNameLength], a
	ret

.InitCharset:
	call WaitTop
	call NamingScreen_DrawBorders
	ld a, [wOptions3]
	bit QWERTY_KEYBOARD_F, a
	ld de, MailEntry_Uppercase
	jr z, .PlaceMailCharset
	ld de, MailEntryQwerty_Uppercase

.PlaceMailCharset:
	hlcoord 1, 6
	ld b, 5
.row
	ld c, 10
.col
	ld a, [de]
	ld [hli], a
	inc hl
	inc de
	dec c
	jr nz, .col
	push de
	ld de, (SCREEN_WIDTH - 10) * 2
	add hl, de
	pop de
	dec b
	jr nz, .row
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
	ld a, [hli]
	ld d, [hl]
	ld e, a
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
	ld d, SPRITE_ANIM_INDEX_COMPOSE_MAIL_CURSOR_BLUE
	ld a, [wCurItem]
	cp LITEBLUEMAIL
	jr z, .got_cursor
	cp EON_MAIL
	jr z, .got_cursor
	ld d, SPRITE_ANIM_INDEX_COMPOSE_MAIL_CURSOR
.got_cursor
	ld a, d
	depixel 8, 2
	call InitSpriteAnimStruct
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
	dec a ; 1?
	jr z, .select
	dec a ; 2?
	jr z, .b
	dec a ; 3?
	jr z, .finished
	call NamingScreen_GetLastCharacter
	call NamingScreen_TryAddCharacter
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
	ld a, [hli]
	ld b, [hl]
	ld c, a
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

NamingScreen_DrawBorders:
	; message area
	hlcoord 0, 0
	lb bc, 4, SCREEN_WIDTH - 2
	call .DrawBox

	; input characters
	ld a, " "
	hlcoord 0, 6
	ld bc, SCREEN_WIDTH * 9
	rst ByteFill

	; Shift/Del/End
	hlcoord 0, SCREEN_HEIGHT - 3
	lb bc, 1, SCREEN_WIDTH - 2
	call .DrawBox
	hlcoord 2, SCREEN_HEIGHT - 2
	ld de, .ShiftDelEnd
	rst PlaceString
	ret

.DrawBox:
	ld de, .Frame
	jmp CreateBoxBorders

.Frame:
	db NAMINGSCREEN_BORDER
	db NAMINGSCREEN_BORDER + 1
	db NAMINGSCREEN_BORDER + 2
	db NAMINGSCREEN_BORDER + 3
	db " "
	db NAMINGSCREEN_BORDER + 4
	db NAMINGSCREEN_BORDER + 5
	db NAMINGSCREEN_BORDER + 6
	db NAMINGSCREEN_BORDER + 7

.ShiftDelEnd:
	db "Shift  Del   End@"
