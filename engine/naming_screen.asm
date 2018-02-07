_NamingScreen: ; 0x116b7
	call DisableSpriteUpdates
	call NamingScreen
	jp ReturnToMapWithSpeechTextbox

; 0x116c1

NamingScreen: ; 116c1
	ld hl, wNamingScreenDestinationPointer
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, wNamingScreenType
	ld [hl], b
	ld hl, Options1
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	ld a, [hMapAnims]
	push af
	xor a
	ld [hMapAnims], a
	ld a, [hInMenu]
	push af
	ld a, $1
	ld [hInMenu], a
	call .SetUpNamingScreen
	call DelayFrame
.loop
	call NamingScreenJoypadLoop
	jr nc, .loop
	pop af
	ld [hInMenu], a
	pop af
	ld [hMapAnims], a
	pop af
	ld [Options1], a
	jp ClearJoypad

; 116f8

.SetUpNamingScreen: ; 116f8
	call ClearBGPalettes
	ld b, CGB_DIPLOMA
	call GetCGBLayout
	call DisableLCD
	call LoadNamingScreenGFX
	call NamingScreen_InitText
	ld a, %11100011
	ld [rLCDC], a
	call .GetNamingScreenSetup
	call WaitBGMap
	call WaitTop
	call SetPalettes
	jp NamingScreen_InitNameEntry

; 1171d

.GetNamingScreenSetup: ; 1171d
	ld a, [wNamingScreenType]
	and 7
	ld e, a
	ld d, 0
	ld hl, .Jumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

; 1172e

.Jumptable: ; 1172e (4:572e)
	dw .Pokemon
	dw .Player
	dw .Rival
	dw .TrendyPhrase
	dw .Box

.Pokemon: ; 1173e (4:573e)
	ld a, [CurPartySpecies]
	ld [wd265], a
	farcall LoadNamingScreenMonIcon
	ld a, [CurPartySpecies]
	ld [wd265], a
	call GetPokemonName
	hlcoord 5, 2
	call PlaceString
	ld l, c
	ld h, b
	ld de, .NicknameStrings
	call PlaceString
	inc de
	hlcoord 5, 4
	call PlaceString
	farcall GetGender
	jr c, .genderless
	ld a, "♂"
	jr nz, .place_gender
	ld a, "♀"
.place_gender
	hlcoord 1, 2
	ld [hl], a
.genderless
	jp .StoreMonIconParams

; 11780 (4:5780)

.NicknameStrings: ; 11780
	db "'s@"
	db "nickname?@"

; 1178d

.Player: ; 1178d (4:578d)
	farcall GetPlayerIcon
	ld a, [PlayerGender]
	bit 0, a
	ld c, SPRITE_ANIM_INDEX_RED_WALK
	jr z, .got_player_walk
	ld c, SPRITE_ANIM_INDEX_BLUE_WALK
.got_player_walk
	call .LoadSprite
	hlcoord 5, 2
	ld de, .PlayerNameString
	call PlaceString
	jp .StoreSpriteIconParams

; 117a3 (4:57a3)

.PlayerNameString: ; 117a3
	db "Your name?@"

; 117ae

.Rival: ; 117ae (4:57ae)
	ld de, SilverSpriteGFX
	lb bc, BANK(SilverSpriteGFX), SPRITE_ANIM_INDEX_RED_WALK
	call .LoadSprite
	hlcoord 5, 2
	ld de, .RivalNameString
	call PlaceString
	jp .StoreSpriteIconParams

; 117c3 (4:57c3)

.RivalNameString: ; 117c3
	db "Rival's name?@"

; 117d1

.TrendyPhrase:
	ld de, ArtistSpriteGFX
	lb bc, BANK(ArtistSpriteGFX), SPRITE_ANIM_INDEX_BLUE_WALK
	call .LoadSprite
	hlcoord 5, 2
	ld de, .TrendyPhraseString
	call PlaceString
	jp .StoreSpriteIconParams

.TrendyPhraseString:
	db "What's trendy?@"

.Box: ; 117f5 (4:57f5)
	ld de, BallCutFruitSpriteGFX
	ld hl, VTiles0 tile $00
	lb bc, BANK(BallCutFruitSpriteGFX), $4
	call Request2bpp
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
	call PlaceString
	jp .StoreBoxIconParams

; 11822 (4:5822)

.BoxNameString: ; 11822
	db "Box name?@"

; 1182c

.LoadSprite: ; 11847 (4:5847)
	push bc
	push de
	ld hl, VTiles0 tile $00
	ld c, $4
	push bc
	call Request2bpp
	pop bc
	ld hl, 12 tiles
	add hl, de
	ld e, l
	ld d, h
	ld hl, VTiles0 tile $04
	call Request2bpp
	xor a
	ld hl, wSpriteAnimDict
	ld [hli], a
	ld [hl], a
	pop de
	pop bc
	ld a, c
	depixel 4, 4, 4, 0
	jp _InitSpriteAnimStruct

.StoreMonIconParams: ; 1187b (4:587b)
	ld a, PKMN_NAME_LENGTH - 1
	hlcoord 5, 6
	jr .StoreParams

.StoreSpriteIconParams: ; 11882 (4:5882)
	ld a, PLAYER_NAME_LENGTH - 1
	hlcoord 5, 6
	jr .StoreParams

.StoreBoxIconParams: ; 11889 (4:5889)
	ld a, BOX_NAME_LENGTH - 1
	hlcoord 5, 4

.StoreParams: ; 11890 (4:5890)
	ld [wNamingScreenMaxNameLength], a
	ld a, l
	ld [wNamingScreenStringEntryCoord], a
	ld a, h
	ld [wNamingScreenStringEntryCoord + 1], a
	ret

NamingScreen_IsTargetBox: ; 1189c
	push bc
	push af
	ld a, [wNamingScreenType]
	sub $4
	ld b, a
	pop af
	dec b
	pop bc
	ret

; 118a8

NamingScreen_InitText: ; 118a8
	call WaitTop
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, $60 ; border
	call ByteFill
	hlcoord 1, 1
	lb bc, 6, 18
	call NamingScreen_IsTargetBox
	jr nz, .not_box
	lb bc, 4, 18

.not_box
	call ClearBox
	ld de, NameInputUpper
NamingScreen_ApplyTextInputMode: ; 118ca
	call NamingScreen_IsTargetBox
	jr nz, .not_box
	ld hl, BoxNameInputLower - NameInputLower
	add hl, de
	ld d, h
	ld e, l

.not_box
	push de
	hlcoord 1, 8
	lb bc, 7, 18
	call NamingScreen_IsTargetBox
	jr nz, .not_box_2
	hlcoord 1, 6
	lb bc, 9, 18

.not_box_2
	call ClearBox
	hlcoord 1, 16
	lb bc, 1, 18
	call ClearBox
	pop de
	hlcoord 2, 8
	ld b, $5
	call NamingScreen_IsTargetBox
	jr nz, .row
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

; 11915

NamingScreenJoypadLoop: ; 11915
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
	farcall ClearSpriteAnims
	call ClearSprites
	xor a
	ld [hSCX], a
	ld [hSCY], a
	scf
	ret

; 11940

.UpdateStringEntry: ; 11940
	xor a
	ld [hBGMapMode], a
	hlcoord 1, 5
	call NamingScreen_IsTargetBox
	jr nz, .got_coords
	hlcoord 1, 3

.got_coords
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
	call PlaceString
	ld a, $1
	ld [hBGMapMode], a
	ret

; 11968

.RunJumptable: ; 11968
	ld a, [wJumptableIndex]
	ld e, a
	ld d, $0
	ld hl, .Jumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

; 11977

.Jumptable: ; 11977 (4:5977)
	dw .InitCursor
	dw .ReadButtons

.InitCursor: ; 1197b (4:597b)
	depixel 10, 3
	call NamingScreen_IsTargetBox
	jr nz, .got_cursor_position
	ld d, 8 * 8
.got_cursor_position
	ld a, SPRITE_ANIM_INDEX_NAMING_SCREEN_CURSOR
	call _InitSpriteAnimStruct
	ld a, c
	ld [wNamingScreenCursorObjectPointer], a
	ld a, b
	ld [wNamingScreenCursorObjectPointer + 1], a
	ld hl, SPRITEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld a, [hl]
	ld hl, SPRITEANIMSTRUCT_0E
	add hl, bc
	ld [hl], a
	ld hl, wJumptableIndex
	inc [hl]
	ret

.ReadButtons: ; 119a1 (4:59a1)
	ld hl, hJoyPressed ; $ffa7
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
	ld a, [wcf64]
	and a ; 0?
	ret nz
	ld a, [wNamingScreenCurrNameLength]
	dec a ; 1?
	jr z, .select
	ret

.start
	ld hl, wNamingScreenCursorObjectPointer
	ld c, [hl]
	inc hl
	ld b, [hl]
	ld hl, SPRITEANIMSTRUCT_0C
	add hl, bc
	ld [hl], $8
	ld hl, SPRITEANIMSTRUCT_0D
	add hl, bc
	ld [hl], $4
	call NamingScreen_IsTargetBox
	ret nz
	inc [hl]
	ret

.b
	jp NamingScreen_DeleteCharacter

.end
	call NamingScreen_StoreEntry
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

.select
	ld hl, wcf64
	ld a, [hl]
	xor 1
	ld [hl], a
	jr z, .upper
	ld de, NameInputLower
	jp NamingScreen_ApplyTextInputMode

.upper
	ld de, NameInputUpper
	jp NamingScreen_ApplyTextInputMode

.GetCursorPosition: ; 11a0b (4:5a0b)
	ld hl, wNamingScreenCursorObjectPointer
	ld c, [hl]
	inc hl
	ld b, [hl]

NamingScreen_GetCursorPosition: ; 11a11 (4:5a11)
	ld hl, SPRITEANIMSTRUCT_0D
	add hl, bc
	ld a, [hl]
	push bc
	ld b, $4
	call NamingScreen_IsTargetBox
	jr nz, .not_box
	inc b
.not_box
	cp b
	pop bc
	jr nz, .not_bottom_row
	ld hl, SPRITEANIMSTRUCT_0C
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

NamingScreen_AnimateCursor: ; 11a3b (4:5a3b)
	call .GetDPad
	ld hl, SPRITEANIMSTRUCT_0D
	add hl, bc
	ld a, [hl]
	ld e, a
	swap e
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], e
	ld d, $4
	call NamingScreen_IsTargetBox
	jr nz, .ok
	inc d
.ok
	cp d
	ld de, .LetterEntries
	ld a, 0 ; not xor a; preserve carry flag
	jr nz, .got_pointer
	ld de, .CaseDelEnd
	inc a
.got_pointer
	ld hl, SPRITEANIMSTRUCT_0E
	add hl, bc
	add [hl]
	ld hl, SPRITEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld [hl], a
	ld hl, SPRITEANIMSTRUCT_0C
	add hl, bc
	ld l, [hl]
	ld h, $0
	add hl, de
	ld a, [hl]
	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

; 11a79 (4:5a79)

.LetterEntries: ; 11a79
	db $00, $10, $20, $30, $40, $50, $60, $70, $80

.CaseDelEnd: ; 11a82
	db $00, $00, $00, $30, $30, $30, $60, $60, $60

; 11a8b

.GetDPad: ; 11a8b (4:5a8b)
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
	jr nz, .right
	ret

.right
	call NamingScreen_GetCursorPosition
	and a
	jr nz, .asm_11ab7
	ld hl, SPRITEANIMSTRUCT_0C
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
	ld hl, SPRITEANIMSTRUCT_0C
	add hl, bc
	ld [hl], a
	ret

.left
	call NamingScreen_GetCursorPosition
	and a
	jr nz, .asm_11ad8
	ld hl, SPRITEANIMSTRUCT_0C
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
	ld hl, SPRITEANIMSTRUCT_0C
	add hl, bc
	ld [hl], a
	ret

.down
	ld hl, SPRITEANIMSTRUCT_0D
	add hl, bc
	ld a, [hl]
	call NamingScreen_IsTargetBox
	jr nz, .asm_11af9
	cp $5
	jr nc, .asm_11aff
	inc [hl]
	ret

.asm_11af9
	cp $4
	jr nc, .asm_11aff
	inc [hl]
	ret

.asm_11aff
	ld [hl], $0
	ret

.up
	ld hl, SPRITEANIMSTRUCT_0D
	add hl, bc
	ld a, [hl]
	and a
	jr z, .asm_11b0c
	dec [hl]
	ret

.asm_11b0c
	ld [hl], $4
	call NamingScreen_IsTargetBox
	ret nz
	inc [hl]
	ret

NamingScreen_TryAddCharacter: ; 11b14 (4:5b14)
MailComposition_TryAddCharacter: ; 11b17 (4:5b17)
	ld a, [wNamingScreenMaxNameLength]
	ld c, a
	ld a, [wNamingScreenCurrNameLength]
	cp c
	ret nc

	ld a, [wNamingScreenLastCharacter]
	call NamingScreen_GetTextCursorPosition
	ld [hl], a
	ld hl, wNamingScreenCurrNameLength
	inc [hl]
	call NamingScreen_GetTextCursorPosition
	ld a, [hl]
	cp "@"
	jr z, .end_of_string
	ld [hl], "<_>"
	and a
	ret

.end_of_string
	scf
	ret

; 11b39 (4:5b39)

NamingScreen_DeleteCharacter: ; 11bbc (4:5bbc)
	ld hl, wNamingScreenCurrNameLength
	ld a, [hl]
	and a
	ret z
	dec [hl]
	call NamingScreen_GetTextCursorPosition
	ld [hl], "<_>"
	inc hl
	ld a, [hl]
	cp "<_>"
	ret nz
	ld [hl], "<—>"
	ret

NamingScreen_GetTextCursorPosition: ; 11bd0 (4:5bd0)
	push af
	ld hl, wNamingScreenDestinationPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wNamingScreenCurrNameLength]
	ld e, a
	ld d, 0
	add hl, de
	pop af
	ret

; 11be0

NamingScreen_InitNameEntry: ; 11be0
; load "<_>", ("<—>" * [wNamingScreenMaxNameLength]), "@" into the dw address at wNamingScreenDestinationPointer
	ld hl, wNamingScreenDestinationPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld [hl], "<_>"
	inc hl
	ld a, [wNamingScreenMaxNameLength]
	dec a
	ld c, a
	ld a, "<—>"
.loop
	ld [hli], a
	dec c
	jr nz, .loop
	ld [hl], "@"
	ret

; 11bf7

NamingScreen_StoreEntry: ; 11bf7 (4:5bf7)
	ld hl, wNamingScreenDestinationPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wNamingScreenMaxNameLength]
	ld c, a
.loop
	ld a, [hl]
	cp "<—>"
	jr z, .terminator
	cp "<_>"
	jr nz, .not_terminator
.terminator
	ld [hl], "@"
.not_terminator
	inc hl
	dec c
	jr nz, .loop
	ret

NamingScreen_GetLastCharacter: ; 11c11 (4:5c11)
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
	srl a
	srl a
	srl a
	ld e, a
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	add [hl]
	sub $10
	srl a
	srl a
	srl a
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

LoadNamingScreenGFX: ; 11c51
	call ClearSprites
	farcall ClearSpriteAnims
	call LoadStandardFont
	call LoadFontsExtra

	ld de, VTiles2 tile $60
	ld hl, NamingScreenGFX_Border
	ld bc, 1 tiles
	ld a, BANK(NamingScreenGFX_Border)
	call FarCopyBytes

	ld de, VTiles0 tile $7e
	ld hl, NamingScreenGFX_Cursor
	ld bc, 2 tiles
	ld a, BANK(NamingScreenGFX_Cursor)
	call FarCopyBytes

	ld a, $5
	ld hl, wSpriteAnimDict + 9 * 2
	ld [hli], a
	ld [hl], $7e
	xor a
	ld [hSCY], a
	ld [wGlobalAnimYOffset], a
	ld [hSCX], a
	ld [wGlobalAnimXOffset], a
	ld [wJumptableIndex], a
	ld [wcf64], a
	ld [hBGMapMode], a
	ld [wNamingScreenCurrNameLength], a
	ld a, $7
	ld [hWX], a
	ret

; 11cb7

NamingScreenGFX_Border: ; 11cb7
INCBIN "gfx/naming_screen/naming_border.2bpp"
; 11cc7

NamingScreenGFX_Cursor: ; 11cc7
INCBIN "gfx/naming_screen/naming_cursor.2bpp"
; 11ce7

INCLUDE "data/text/input_chars.asm"

; 122c1

_ComposeMailMessage: ; 11e75 (mail?)
	ld hl, wNamingScreenDestinationPointer
	ld [hl], e
	inc hl
	ld [hl], d
	ld a, [hMapAnims]
	push af
	xor a
	ld [hMapAnims], a
	ld a, [hInMenu]
	push af
	ld a, $1
	ld [hInMenu], a
	call .InitBlankMail
	call DelayFrame

.loop
	call .DoMailEntry
	jr nc, .loop

	pop af
	ld [hInMenu], a
	pop af
	ld [hMapAnims], a
	ret

.InitBlankMail: ; 11e9a (4:5e9a)
	call ClearBGPalettes
	call DisableLCD
	call LoadNamingScreenGFX
	ld de, VTiles0 tile $00
	ld hl, .MailIcon
	ld bc, 8 tiles
	ld a, BANK(.MailIcon)
	call FarCopyBytes
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
	ld [rLCDC], a
	call .initwNamingScreenMaxNameLength
	ld b, CGB_DIPLOMA
	call GetCGBLayout
	call WaitBGMap
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
	ld [hl], "<NL>"
	ret

; 11ef4 (4:5ef4)

.MailIcon: ; 11ef4
INCBIN "gfx/icons/mail2.2bpp"
; 11f74

.initwNamingScreenMaxNameLength ; 11f74 (4:5f74)
	ld a, MAIL_MSG_LENGTH + 1
	ld [wNamingScreenMaxNameLength], a
	ret

; 11f7a (4:5f7a)

.InitCharset: ; 11f84 (4:5f84)
	call WaitTop
	hlcoord 0, 0
	ld bc, 6 * SCREEN_WIDTH
	ld a, $60 ; border
	call ByteFill
	hlcoord 0, 6
	ld bc, 12 * SCREEN_WIDTH
	ld a, " "
	call ByteFill
	hlcoord 1, 1
	lb bc, 4, SCREEN_WIDTH - 2
	call ClearBox
	ld de, MailEntry_Uppercase

.PlaceMailCharset: ; 11fa9 (4:5fa9)
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

.DoMailEntry: ; 11fc0 (4:5fc0)
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
	farcall ClearSpriteAnims
	call ClearSprites
	xor a
	ld [hSCX], a
	ld [hSCY], a
	scf
	ret

.Update: ; 11feb (4:5feb)
	xor a
	ld [hBGMapMode], a
	hlcoord 1, 1
	lb bc, 4, 18
	call ClearBox
	ld hl, wNamingScreenDestinationPointer
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 2, 2
	call PlaceString
	ld a, $1
	ld [hBGMapMode], a
	ret

.DoJumptable: ; 12008 (4:6008)
	ld a, [wJumptableIndex]
	ld e, a
	ld d, 0
	ld hl, .Jumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.Jumptable: ; 12017 (4:6017)
	dw .init_blinking_cursor
	dw .process_joypad

.init_blinking_cursor ; 1201b (4:601b)
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
	ld hl, SPRITEANIMSTRUCT_0E
	add hl, bc
	ld [hl], a
	ld hl, wJumptableIndex
	inc [hl]
	ret

.process_joypad ; 1203a (4:603a)
	ld hl, hJoyPressed ; $ffa7
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
	ld hl, wNamingScreenCurrNameLength
	ld a, [hl]
	cp $10
	ret nz
	inc [hl]
	call NamingScreen_GetTextCursorPosition
	ld [hl], "<_>"
	dec hl
	ld [hl], "<NL>"
	ret

.start
	ld hl, wNamingScreenCursorObjectPointer
	ld c, [hl]
	inc hl
	ld b, [hl]
	ld hl, SPRITEANIMSTRUCT_0C
	add hl, bc
	ld [hl], $9
	ld hl, SPRITEANIMSTRUCT_0D
	add hl, bc
	ld [hl], $5
	ret

.b
	call NamingScreen_DeleteCharacter
	ld hl, wNamingScreenCurrNameLength
	ld a, [hl]
	cp $10
	ret nz
	dec [hl]
	call NamingScreen_GetTextCursorPosition
	ld [hl], "<_>"
	inc hl
	ld [hl], "<NL>"
	ret

.finished
	call NamingScreen_StoreEntry
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

.select
	ld hl, wcf64
	ld a, [hl]
	xor $1
	ld [hl], a
	jr nz, .switch_to_lowercase
	ld de, MailEntry_Uppercase
	jp .PlaceMailCharset

.switch_to_lowercase
	ld de, MailEntry_Lowercase
	jp .PlaceMailCharset

; called from engine/sprite_anims.asm

ComposeMail_AnimateCursor: ; 120c1 (4:60c1)
	call .GetDPad
	ld hl, SPRITEANIMSTRUCT_0D
	add hl, bc
	ld a, [hl]
	ld e, a
	swap e
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], e
	cp $5
	ld de, .LetterEntries
	ld a, 0 ; not xor a; preserve carry flag
	jr nz, .got_pointer
	ld de, .CaseDelEnd
	inc a
.got_pointer
	ld hl, SPRITEANIMSTRUCT_0E
	add hl, bc
	add [hl]
	ld hl, SPRITEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld [hl], a
	ld hl, SPRITEANIMSTRUCT_0C
	add hl, bc
	ld l, [hl]
	ld h, $0
	add hl, de
	ld a, [hl]
	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

; 120f8 (4:60f8)

.LetterEntries: ; 120f8
	db $00, $10, $20, $30, $40, $50, $60, $70, $80, $90

.CaseDelEnd: ; 12102
	db $00, $00, $00, $30, $30, $30, $60, $60, $60, $60

; 1210c

.GetDPad: ; 1210c (4:610c)
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
	jr nz, .right
	ret

.right
	call ComposeMail_GetCursorPosition
	and a
	jr nz, .case_del_done_right
	ld hl, SPRITEANIMSTRUCT_0C
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
	ld hl, SPRITEANIMSTRUCT_0C
	add hl, bc
	ld [hl], a
	ret

.left
	call ComposeMail_GetCursorPosition
	and a
	jr nz, .caps_del_done_left
	ld hl, SPRITEANIMSTRUCT_0C
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
	ld hl, SPRITEANIMSTRUCT_0C
	add hl, bc
	ld [hl], a
	ret

.down
	ld hl, SPRITEANIMSTRUCT_0D
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
	ld hl, SPRITEANIMSTRUCT_0D
	add hl, bc
	ld a, [hl]
	and a
	jr z, .wrap_around_up
	dec [hl]
	ret

.wrap_around_up
	ld [hl], $5
	ret

NamingScreen_PressedA_GetCursorCommand: ; 12185 (4:6185)
	ld hl, wNamingScreenCursorObjectPointer
	ld c, [hl]
	inc hl
	ld b, [hl]

ComposeMail_GetCursorPosition: ; 1218b (4:618b)
	ld hl, SPRITEANIMSTRUCT_0D
	add hl, bc
	ld a, [hl]
	cp $5
	jr nz, .letter
	ld hl, SPRITEANIMSTRUCT_0C
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

MailComposition_TryAddLastCharacter: ; 121ac (4:61ac)
	ld a, [wNamingScreenLastCharacter]
	jp MailComposition_TryAddCharacter

; 121b2 (4:61b2)
