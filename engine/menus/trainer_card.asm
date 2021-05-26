TRAINERCARD_BORDERGFX_START EQU $f4

TrainerCard:
	ld a, [wVramState]
	push af
	xor a
	ld [wVramState], a
	ld hl, wOptions1
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	call .InitRAM
.loop
	call UpdateTime
	call JoyTextDelay
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .quit
	ldh a, [hJoyLast]
	and B_BUTTON
	jr nz, .quit
	ld a, [wJumptableIndex]
	ld hl, .Jumptable
	call JumpTable
	call DelayFrame
	jr .loop

.quit
	pop af
	ld [wOptions1], a
	pop af
	ld [wVramState], a
	ret

.InitRAM:
	call ClearBGPalettes
	call ClearSprites
	call ClearTileMap
	call DisableLCD

	farcall GetCardPic

	ld hl, CardBorderGFX
	ld de, vTiles1 tile (TRAINERCARD_BORDERGFX_START - $80)
	lb bc, BANK(CardBorderGFX), 12
	call DecompressRequest2bpp

	ld hl, CardDividerGFX
	ld de, vTiles2 tile $23
	ld bc, (6 + 4) tiles ; CardDividerGFX + CardStatusGFX
	ld a, BANK(CardDividerGFX) ; BANK(CardStatusGFX)
	call FarCopyBytes

	call TrainerCard_PrintBorder
	call TrainerCard_PrintTopHalfOfCard

	call EnableLCD
	call ApplyTilemapInVBlank
	ld a, CGB_TRAINER_CARD
	call GetCGBLayout
	call SetPalettes
	call ApplyTilemapInVBlank
	ld hl, wJumptableIndex
	xor a
	ld [hli], a ; wJumptableIndex
	ld [hli], a ; wTrainerCardBadgeFrameCounter
	ld [hli], a ; wTrainerCardBadgeTileID
	ld [hl], a  ; TODO: check if this is still needed
	ret

.Jumptable:
	dw TrainerCard_Page1_LoadGFX
	dw TrainerCard_Page1_Joypad
	dw TrainerCard_Page2_LoadGFX
	dw TrainerCard_Page2_Joypad
	dw TrainerCard_Page3_LoadGFX
	dw TrainerCard_Page3_Joypad
	dw TrainerCard_Quit

TrainerCard_Quit:
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

TrainerCard_Page1_LoadGFX:
	call ClearSprites
	call TrainerCardSetup_ClearBottomHalf
	call ApplyTilemapInVBlank

	ld a, CGB_TRAINER_CARD
	call GetCGBLayout
	call SetPalettes
	call ApplyTilemapInVBlank

	ld de, CardStatusGFX
	call TrainerCard_LoadHeaderGFX

	call TrainerCard_Page1_PrintDexCaught_GameTime
	; fallthrough

TrainerCard_IncrementJumptable:
	ld hl, wJumptableIndex
	inc [hl]
	ret

TrainerCard_Page1_Joypad:
	call TrainerCard_Page1_PrintGameTime
	ld hl, hJoyLast
	ld a, [hl]
	and D_RIGHT | A_BUTTON
	ret z

; pressed_right_or_a
	ld a, $2
	ld [wJumptableIndex], a
	ret

TrainerCard_Page2_LoadGFX:
	call ClearSprites
	call TrainerCardSetup_ClearBottomHalf
	call ApplyTilemapInVBlank

	ld a, CGB_TRAINER_CARD_2
	call GetCGBLayout
	call SetPalettes
	call ApplyTilemapInVBlank

	ld de, CardBadgesGFX
	call TrainerCard_LoadHeaderGFX

	ld hl, LeaderGFX
	ld de, vTiles2 tile $2f
	lb bc, BANK(LeaderGFX), $50
	call DecompressRequest2bpp

	ld hl, BadgeGFX
	ld de, vTiles0 tile $00
	lb bc, BANK(BadgeGFX), $2c
	call DecompressRequest2bpp

	ld hl, TrainerCard_JohtoBadgesOAM
	call TrainerCard_Page2_3_InitObjectsAndStrings
	jr TrainerCard_IncrementJumptable

TrainerCard_Page2_Joypad:
	ld hl, TrainerCard_JohtoBadgesOAM
	call TrainerCard_Page2_3_AnimateBadges
	ld hl, hJoyLast
	ld a, [hl]
	and D_RIGHT
	jr nz, .pressed_right
	ld a, [hl]
	and A_BUTTON
	jr nz, .pressed_a
	ld a, [hl]
	and D_LEFT
	ret z

; pressed_left
	xor a
	ld [wJumptableIndex], a
	ret

.pressed_right
	ld a, [wKantoBadges]
	and a
	ret z
	ld a, $4
	ld [wJumptableIndex], a
	ret

.pressed_a
	ld a, [wKantoBadges]
	and a
	jr z, .quit
	ld a, $4
	ld [wJumptableIndex], a
	ret

.quit
	ld a, $6
	ld [wJumptableIndex], a
	ret

TrainerCard_Page3_LoadGFX:
	call ClearSprites
	call TrainerCardSetup_ClearBottomHalf
	call ApplyTilemapInVBlank

	ld a, CGB_TRAINER_CARD_3
	call GetCGBLayout
	call SetPalettes
	call ApplyTilemapInVBlank

	ld de, CardBadgesGFX
	call TrainerCard_LoadHeaderGFX

	ld hl, LeaderGFX2
	ld de, vTiles2 tile $2f
	lb bc, BANK(LeaderGFX2), $50
	call DecompressRequest2bpp

	ld hl, BadgeGFX2
	ld de, vTiles0 tile $00
	lb bc, BANK(BadgeGFX2), $2c
	call DecompressRequest2bpp

	ld hl, TrainerCard_KantoBadgesOAM
	call TrainerCard_Page2_3_InitObjectsAndStrings
	jmp TrainerCard_IncrementJumptable

TrainerCard_Page3_Joypad:
	ld hl, TrainerCard_KantoBadgesOAM
	call TrainerCard_Page2_3_AnimateBadges
	ld hl, hJoyLast
	ld a, [hl]
	and A_BUTTON
	jr nz, .quit
	ld a, [hl]
	and D_LEFT
	ret z

; pressed_left
	ld a, $2
	ld [wJumptableIndex], a
	ret

.quit
	ld a, $6
	ld [wJumptableIndex], a
	ret

TrainerCard_LoadHeaderGFX:
	ld hl, vTiles2 tile $29
	lb bc, BANK(CardStatusGFX), $4 ; BANK(CardBadgesGFX)
	jmp Request2bpp

TrainerCard_PrintBorder:
	hlcoord 0, 0

	ld a, TRAINERCARD_BORDERGFX_START
	ld [hli], a
	ld e, SCREEN_WIDTH - 2
	inc a ; top border
.loop1
	ld [hli], a
	dec e
	jr nz, .loop1
	inc a ; top-right corner
	ld [hli], a

	ld bc, SCREEN_WIDTH - 2
	ld e, SCREEN_HEIGHT - 2
	inc a ; left border
.loop2
	ld [hli], a
	add hl, bc
	inc a ; right border
	ld [hli], a
	dec a ; left border again
	dec e
	jr nz, .loop2

	inc a
	inc a ; bottom-left corner
	ld [hli], a
	ld e, SCREEN_WIDTH - 2
	inc a ; bottom border
.loop3
	ld [hli], a
	dec e
	jr nz, .loop3
	inc a ; bottom-right corner
	ld [hl], a

	hlcoord 1, 8
	ld a, $23
	ld [hli], a
	ld a, $29
	ld [hli], a
	inc a ; $2a
	ld [hli], a
	inc a ; $2b
	ld [hli], a
	inc a ; $2c
	ld [hli], a
	ld a, $24
	ld [hli], a

	ld e, 4
.loop4
	inc a ; $25
	ld [hli], a
	inc a ; $26
	ld [hli], a
	inc a ; $27
	ld [hli], a
	ld a, $25 - 1
	dec e
	jr nz, .loop4
	ret

TrainerCard_PrintTopHalfOfCard:
	hlcoord 1, 2
	ld de, .Top_Headings
	rst PlaceString

	hlcoord 7, 2
	ld de, wPlayerName
	rst PlaceString

	hlcoord 5, 3
	ld de, wPlayerID
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	call PrintNum

	hlcoord 14, 1
	lb bc, 5, 7
	xor a
	ldh [hGraphicStartTile], a
	predef PlaceGraphic

	hlcoord 7, 6
	lb bc, PRINTNUM_MONEY | 3, 7
	ld a, [wMoney]
	cp $f
	jr c, .not_seven_digits
	ld a, [wMoney + 1]
	cp $42
	jr c, .not_seven_digits
	ld a, [wMoney + 2]
	cp $40
	jr nc, .print_money
.not_seven_digits
	dec c
.print_money
	ld de, wMoney
	jmp PrintNum

.Top_Headings:
	db "┐Name/<LNBRK>"
	db "┐<ID>№.<LNBRK>"
	db "│└└└└└└└└└└└┘<LNBRK>"
	db "<LNBRK>"
	db " Money@"

TrainerCardSetup_ClearBottomHalf:
	hlcoord 1, 10
	lb bc, 7, 18
	jmp ClearBox

TrainerCard_Page1_PrintDexCaught_GameTime:
	hlcoord 2, 10
	ld de, .Dex_PlayTime_BP
	rst PlaceString

	ld hl, wPokedexCaught
	ld b, wEndPokedexCaught - wPokedexCaught
	call CountSetBits
	ld de, wNumSetBits
	hlcoord 15, 10
	lb bc, 1, 3
	call PrintNum

	ld de, wBattlePoints
	hlcoord 13, 14
	lb bc, 2, 5
	call PrintNum

	call TrainerCard_Page1_PrintGameTime

	ld a, [wStatusFlags] ; pokedex
	bit 0, a
	jr nz, .have_pokedex
	hlcoord 2, 10
	lb bc, 1, 16
	call ClearBox
.have_pokedex
	ld a, [wBattlePoints]
	ld c, a
	ld a, [wBattlePoints + 1]
	or c
	jr nz, .have_bp
	hlcoord 2, 14
	lb bc, 1, 16
	call ClearBox
.have_bp

; trainer stars
	ld c, VAR_TRAINER_STARS
	farcall _GetVarAction
	ld a, [wStringBuffer2]
	hlcoord 2, 16
.star_loop
	dec a
	cp -1
	ret z
	ld [hl], $28 ; no-optimize *hl++|*hl-- = N
	inc hl
	jr .star_loop

.Dex_PlayTime_BP:
	db   "#dex"
	next "Play Time"
	next "Battle Pts"
	next "          Badges▶@"

TrainerCard_Page1_PrintGameTime:
	hlcoord 11, 12
	ld de, wGameTimeHours
	lb bc, 2, 4
	call PrintNum
	inc hl
	ld de, wGameTimeMinutes
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
	ldh a, [hVBlankCounter]
	and $1f
	ret nz
	hlcoord 15, 12
	ld a, [hl]
	cp ":"
	ld a, ":"
	jr nz, .ok
	ld a, " "
.ok
	ld [hl], a
	ret

TrainerCard_Page2_3_InitObjectsAndStrings:
	push hl
	hlcoord 2, 10
	ld a, $2f
	ld c, 4
.loop
	call TrainerCard_Page2_3_PlaceLeadersFaces
rept 4
	inc hl
endr
	dec c
	jr nz, .loop

	hlcoord 2, 13
	ld a, $57
	ld c, 4
.loop2
	call TrainerCard_Page2_3_PlaceLeadersFaces
rept 4
	inc hl
endr
	dec c
	jr nz, .loop2

	xor a
	ld [wTrainerCardBadgeFrameCounter], a
	pop hl
	jr TrainerCard_Page2_3_OAMUpdate

TrainerCard_Page2_3_PlaceLeadersFaces:
	push de
	push hl
	ld de, SCREEN_WIDTH - 3
rept 4
	ld [hli], a
	inc a
endr
	add hl, de
rept 3
	ld [hli], a
	inc a
endr
	add hl, de
rept 3
	ld [hli], a
	inc a
endr
	pop hl
	pop de
	ret

TrainerCard_Page2_3_AnimateBadges:
	ldh a, [hVBlankCounter]
	and $7
	ret nz
	ld a, [wTrainerCardBadgeFrameCounter]
	inc a
	and $7
	ld [wTrainerCardBadgeFrameCounter], a
TrainerCard_Page2_3_OAMUpdate:
; copy flag array pointer
	ld a, [hli]
	ld e, a
	ld a, [hli]
; get flag array
	ld d, a
	ld a, [de]
	ld c, a
	ld de, wVirtualOAM
	ld b, 8
.loop
	srl c
	push bc
	jr nc, .skip_badge
	push hl
	ld a, [hli] ; y
	ld b, a
	ld a, [hli] ; x
	ld c, a
	ld a, h
	ld [wTrainerCardBadgePaletteAddr], a
	ld a, l
	ld [wTrainerCardBadgePaletteAddr + 1], a
rept 4
	inc hl
endr
	ld a, [wTrainerCardBadgeFrameCounter]
	; hl += a
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	ld a, [hl]
	ld [wTrainerCardBadgeTileID], a
	call .PrepOAM
	pop hl
.skip_badge
	ld bc, $e ; 6 + 2 * 4
	add hl, bc
	pop bc
	dec b
	jr nz, .loop
	ret

.PrepOAM:
	ld a, [wTrainerCardBadgeTileID]
	and $80
	jr nz, .xflip
	ld hl, .facing1
	jr .loop2

.xflip
	ld hl, .facing2
.loop2
	ld a, [hli]
	cp $ff
	ret z
	add b
	ld [de], a
	inc de

	ld a, [hli]
	add c
	ld [de], a
	inc de

	ld a, [wTrainerCardBadgeTileID]
	and $7f
	add [hl]
	ld [de], a
	inc hl
	inc de
	push hl
	push bc
	ld hl, wTrainerCardBadgePaletteAddr + 1
	ld a, [hld]
	ld h, [hl]
	ld l, a
	ld a, [hli]
	ld b, a
	ld a, h
	ld [wTrainerCardBadgePaletteAddr], a
	ld a, l
	ld [wTrainerCardBadgePaletteAddr + 1], a
	ld a, b
	pop bc
	pop hl
	add [hl]
	ld [de], a
	inc hl
	inc de
	jr .loop2

.facing1
	; y, x, tile, OAM attributes
	db 0, 0, 0, 0
	db 0, 8, 1, 0
	db 8, 0, 2, 0
	db 8, 8, 3, 0
	db -1

.facing2
	db 0, 0, 1, X_FLIP
	db 0, 8, 0, X_FLIP
	db 8, 0, 3, X_FLIP
	db 8, 8, 2, X_FLIP
	db -1

TrainerCard_JohtoBadgesOAM:
; Template OAM data for each badge on the trainer card.
; Format:
	; y, x, palette1, palette2, palette3, palette4
	; cycle 1: face tile, in1 tile, in2 tile, in3 tile
	; cycle 2: face tile, in1 tile, in2 tile, in3 tile

	dw wJohtoBadges

	; Zephyr Badge
	db $68, $18, 0, 0, 0, 0
	db $00, $20, $24, $20 | $80
	db $00, $20, $24, $20 | $80

	; Hive Badge
	db $68, $38, 1, 1, 1, 1
	db $04, $20, $24, $20 | $80
	db $04, $20, $24, $20 | $80

	; Plain Badge
	db $68, $58, 2, 2, 2, 2
	db $08, $20, $24, $20 | $80
	db $08, $20, $24, $20 | $80

	; Fog Badge
	db $68, $78, 3, 3, 3, 3
	db $0c, $20, $24, $20 | $80
	db $0c | $80, $20, $24, $20 | $80

	; Mineral Badge
	db $80, $38, 5, 5, 5, 5
	db $10, $20, $24, $20 | $80
	db $10, $20, $24, $20 | $80

	; Storm Badge
	db $80, $18, 4, 4, 4, 4
	db $14, $20, $24, $20 | $80
	db $14 | $80, $20, $24, $20 | $80

	; Glacier Badge
	db $80, $58, 6, 6, 6, 6
	db $18, $20, $24, $20 | $80
	db $18, $20, $24, $20 | $80

	; Rising Badge
	db $80, $78, 7, 7, 7, 7
	db $1c, $20, $24, $20 | $80
	db $1c, $20, $24, $20 | $80

TrainerCard_KantoBadgesOAM:
; Template OAM data for each badge on the trainer card.
; Format:
	; y, x, palette1, palette2, palette3, palette4
	; cycle 1: face tile, in1 tile, in2 tile, in3 tile
	; cycle 2: face tile, in1 tile, in2 tile, in3 tile

	dw wKantoBadges

	; Boulder Badge
	db $80, $38, 0, 0, 0, 0
	db $00, $20, $24, $20 | $80
	db $00, $20, $24, $20 | $80

	; Cascade Badge
	db $68, $58, 1, 1, 1, 1
	db $04, $20, $24, $20 | $80
	db $04, $20, $24, $20 | $80

	; Thunder Badge
	db $68, $18, 2, 2, 2, 2
	db $08, $20, $24, $20 | $80
	db $08, $20, $24, $20 | $80

	; Rainbow Badge
	db $68, $78, 6, 2, 1, 3
	db $0c, $20, $24, $20 | $80
	db $0c, $20, $24, $20 | $80

	; Soul Badge
	db $80, $18, 4, 4, 4, 4
	db $10, $20, $24, $20 | $80
	db $10, $20, $24, $20 | $80

	; Marsh Badge
	db $68, $38, 5, 5, 5, 5
	db $14, $20, $24, $20 | $80
	db $14, $20, $24, $20 | $80

	; Volcano Badge
	db $80, $58, 6, 6, 6, 6
	db $18, $20, $24, $20 | $80
	db $18, $20, $24, $20 | $80

	; Earth Badge
	db $80, $78, 7, 7, 7, 7
	db $1c, $20, $24, $20 | $80
	db $1c | $80, $20, $24, $20 | $80

CardBorderGFX:  INCBIN "gfx/trainer_card/border.2bpp.lz"
CardDividerGFX: INCBIN "gfx/trainer_card/divider.2bpp"
CardStatusGFX:  INCBIN "gfx/trainer_card/status.2bpp" ; must come after CardDividerGFX
CardBadgesGFX:  INCBIN "gfx/trainer_card/badges.2bpp"

LeaderGFX:  INCBIN "gfx/trainer_card/johto_leaders.2bpp.lz"
LeaderGFX2: INCBIN "gfx/trainer_card/kanto_leaders.2bpp.lz"
BadgeGFX:   INCBIN "gfx/trainer_card/johto_badges.2bpp.lz"
BadgeGFX2:  INCBIN "gfx/trainer_card/kanto_badges.2bpp.lz"
