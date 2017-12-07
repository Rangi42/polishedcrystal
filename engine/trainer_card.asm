TRAINERCARD_BORDERGFX_START EQU $f4

TrainerCard: ; 25105
	ld a, [VramState]
	push af
	xor a
	ld [VramState], a
	ld hl, Options1
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
	ld a, [hJoyLast]
	and B_BUTTON
	jr nz, .quit
	call .RunJumptable
	call DelayFrame
	jr .loop

.quit
	pop af
	ld [Options1], a
	pop af
	ld [VramState], a
	ret

.InitRAM: ; 2513b (9:513b)
	call ClearBGPalettes
	call ClearSprites
	call ClearTileMap
	call DisableLCD

	farcall GetCardPic

	ld hl, CardBorderGFX
	ld de, VTiles1 tile (TRAINERCARD_BORDERGFX_START - $80)
	ld bc, 12 tiles
	ld a, BANK(CardBorderGFX)
	call FarCopyBytes

	ld hl, CardDividerGFX
	ld de, VTiles2 tile $23
	ld bc, (6 + 4) tiles ; CardDividerGFX + CardStatusGFX
	ld a, BANK(CardDividerGFX) ; BANK(CardStatusGFX)
	call FarCopyBytes

	call TrainerCard_PrintBorder
	call TrainerCard_PrintTopHalfOfCard

	call EnableLCD
	call WaitBGMap
	ld b, CGB_TRAINER_CARD
	call GetCGBLayout
	call SetPalettes
	call WaitBGMap
	ld hl, wJumptableIndex
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ret

.RunJumptable: ; 2518e (9:518e)
	jumptable .Jumptable, wJumptableIndex

.Jumptable: ; 2519d (9:519d)
	dw TrainerCard_Page1_LoadGFX
	dw TrainerCard_Page1_Joypad
	dw TrainerCard_Page2_LoadGFX
	dw TrainerCard_Page2_Joypad
	dw TrainerCard_Page3_LoadGFX
	dw TrainerCard_Page3_Joypad
	dw TrainerCard_Quit

TrainerCard_IncrementJumptable: ; 251ab (9:51ab)
	ld hl, wJumptableIndex
	inc [hl]
	ret

TrainerCard_Quit: ; 251b0 (9:51b0)
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

TrainerCard_Page1_LoadGFX: ; 251b6 (9:51b6)
	call ClearSprites
	call TrainerCardSetup_ClearBottomHalf
	call WaitBGMap

	ld b, CGB_TRAINER_CARD
	call GetCGBLayout
	call SetPalettes
	call WaitBGMap

	ld de, CardStatusGFX
	call TrainerCard_LoadHeaderGFX

	call TrainerCard_Page1_PrintDexCaught_GameTime
	jp TrainerCard_IncrementJumptable

TrainerCard_Page1_Joypad: ; 251d7 (9:51d7)
	call TrainerCard_Page1_PrintGameTime
	ld hl, hJoyLast
	ld a, [hl]
	and D_RIGHT | A_BUTTON
	jr nz, .pressed_right_a
	ret

.pressed_right_a
	ld a, $2
	ld [wJumptableIndex], a
	ret

; 251f4

TrainerCard_Page2_LoadGFX: ; 251f4 (9:51f4)
	call ClearSprites
	call TrainerCardSetup_ClearBottomHalf
	call WaitBGMap

	ld b, CGB_TRAINER_CARD_2
	call GetCGBLayout
	call SetPalettes
	call WaitBGMap

	ld de, CardBadgesGFX
	call TrainerCard_LoadHeaderGFX

	ld de, LeaderGFX
	ld hl, VTiles2 tile $2f
	lb bc, BANK(LeaderGFX), $50
	call Request2bpp

	ld de, BadgeGFX
	ld hl, VTiles0 tile $00
	lb bc, BANK(BadgeGFX), $2c
	call Request2bpp

	call TrainerCard_Page2_3_InitObjectsAndStrings
	jp TrainerCard_IncrementJumptable

TrainerCard_Page2_Joypad: ; 25221 (9:5221)
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
	jr nz, .d_left
	ret

.pressed_right
	ld a, [KantoBadges]
	and a
	ret z
	ld a, $4
	ld [wJumptableIndex], a
	ret

.pressed_a
	ld a, [KantoBadges]
	and a
	jr z, .quit
	ld a, $4
	ld [wJumptableIndex], a
	ret

.quit
	ld a, $6
	ld [wJumptableIndex], a
	ret

.d_left
	xor a
	ld [wJumptableIndex], a
	ret

TrainerCard_Page3_LoadGFX: ; 2524c (9:524c)
	call ClearSprites
	call TrainerCardSetup_ClearBottomHalf
	call WaitBGMap

	ld b, CGB_TRAINER_CARD_3
	call GetCGBLayout
	call SetPalettes
	call WaitBGMap

	ld de, CardBadgesGFX
	call TrainerCard_LoadHeaderGFX

	ld de, LeaderGFX2
	ld hl, VTiles2 tile $2f
	lb bc, BANK(LeaderGFX2), $50
	call Request2bpp

	ld de, BadgeGFX2
	ld hl, VTiles0 tile $00
	lb bc, BANK(BadgeGFX2), $2c
	call Request2bpp

	call TrainerCard_Page2_3_InitObjectsAndStrings
	jp TrainerCard_IncrementJumptable

TrainerCard_Page3_Joypad: ; 25279 (9:5279)
	ld hl, TrainerCard_KantoBadgesOAM
	call TrainerCard_Page2_3_AnimateBadges
	ld hl, hJoyLast
	ld a, [hl]
	and A_BUTTON
	jr nz, .quit
	ld a, [hl]
	and D_LEFT
	jr nz, .d_left
	ret

.quit
	ld a, $6
	ld [wJumptableIndex], a
	ret

.d_left
	ld a, $2
	ld [wJumptableIndex], a
	ret

TrainerCard_LoadHeaderGFX:
	ld hl, VTiles2 tile $29
	lb bc, BANK(CardStatusGFX), $4 ; BANK(CardBadgesGFX)
	jp Request2bpp

TrainerCard_PrintBorder: ; 253b0 (9:53b0)
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

TrainerCard_PrintTopHalfOfCard: ; 25299 (9:5299)
	hlcoord 1, 2
	ld de, .Top_Headings
	call PlaceString

	hlcoord 7, 2
	ld de, PlayerName
	call PlaceString

	hlcoord 5, 3
	ld de, PlayerID
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	call PrintNum

	hlcoord 14, 1
	lb bc, 5, 7
	xor a
	ld [hGraphicStartTile], a
	predef PlaceGraphic

	ld a, [Money]
	cp $f
	jr c, .not_seven_digits
	ld a, [Money + 1]
	cp $42
	jr c, .not_seven_digits
	ld a, [Money + 2]
	cp $40
	jr c, .not_seven_digits
	hlcoord 7, 6
	jr .print_money
.not_seven_digits
	hlcoord 6, 6
.print_money
	ld de, Money
	lb bc, PRINTNUM_MONEY | 3, 7
	jp PrintNum

; 252ec (9:52ec)

.Top_Headings: ; 252ec
	db "┐Name/<LNBRK>"
	db "┐<ID>№.<LNBRK>"
	db "│└└└└└└└└└└└┘<LNBRK>"
	db "<LNBRK>"
	db " Money@"

TrainerCardSetup_ClearBottomHalf:
	hlcoord 1, 10
	lb bc, 7, 18
	jp ClearBox

TrainerCard_Page1_PrintDexCaught_GameTime: ; 2530a (9:530a)
	hlcoord 2, 10
	ld de, .Dex_PlayTime_BP
	call PlaceString

	ld hl, PokedexCaught
	ld b, EndPokedexCaught - PokedexCaught
	call CountSetBits
	ld de, wd265
	hlcoord 15, 10
	lb bc, 1, 3
	call PrintNum

	ld de, BattlePoints
	hlcoord 15, 14
	lb bc, 1, 3
	call PrintNum

	call TrainerCard_Page1_PrintGameTime

	ld a, [StatusFlags] ; pokedex
	bit 0, a
	jr nz, .have_pokedex
	hlcoord 2, 10
	lb bc, 1, 16
	call ClearBox
.have_pokedex
	ld a, [BattlePoints]
	and a
	jr nz, .have_bp
	hlcoord 2, 14
	lb bc, 1, 16
	call ClearBox
.have_bp

; trainer stars
	ld c, VAR_TRAINER_STARS
	farcall _GetVarAction
	ld a, [StringBuffer2]
	hlcoord 2, 16
.star_loop
	dec a
	cp -1
	ret z
	ld [hl], $28
	inc hl
	jr .star_loop

.Dex_PlayTime_BP:
	db   "#dex"
	next "Play Time"
	next "Battle Pts"
	next "          Badges▶@"

TrainerCard_Page1_PrintGameTime: ; 25415 (9:5415)
	hlcoord 11, 12
	ld de, GameTimeHours
	lb bc, 2, 4
	call PrintNum
	inc hl
	ld de, GameTimeMinutes
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
	ld a, [hVBlankCounter]
	and $1f
	ret nz
	hlcoord 15, 12
	ld a, [hl]
	cp ":"
	jr z, .space
	ld a, ":"
	jr .ok
.space
	ld a, " "
.ok
	ld [hl], a
	ret

TrainerCard_Page2_3_InitObjectsAndStrings: ; 2536c (9:536c)
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
	ld [wcf64], a
	ld hl, TrainerCard_KantoBadgesOAM
	jp TrainerCard_Page2_3_OAMUpdate

TrainerCard_Page2_3_PlaceLeadersFaces: ; 253f4 (9:53f4)
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

TrainerCard_Page2_3_AnimateBadges: ; 25438 (9:5438)
	ld a, [hVBlankCounter]
	and $7
	ret nz
	ld a, [wcf64]
	inc a
	and $7
	ld [wcf64], a
TrainerCard_Page2_3_OAMUpdate: ; 25448 (9:5448)
; copy flag array pointer
	ld a, [hli]
	ld e, a
	ld a, [hli]
; get flag array
	ld d, a
	ld a, [de]
	ld c, a
	ld de, Sprites
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
	ld a, [wcf64]
	add l
	ld l, a
	ld a, 0 ; not xor a; preserve carry flag?
	adc h
	ld h, a
	ld a, [hl]
	ld [wcf65], a
	call .PrepOAM
	pop hl
.skip_badge
	ld bc, $e ; 6 + 2 * 4
	add hl, bc
	pop bc
	dec b
	jr nz, .loop
	ret

.PrepOAM: ; 2547b (9:547b)
	ld a, [wcf65]
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

	ld a, [wcf65]
	and $7f
	add [hl]
	ld [de], a
	inc hl
	inc de
	push hl
	push bc
	ld a, [wTrainerCardBadgePaletteAddr]
	ld h, a
	ld a, [wTrainerCardBadgePaletteAddr + 1]
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

; 254a7 (9:54a7)

.facing1 ; 254a7
	; y, x, tile, OAM attributes
	db 0, 0, 0, 0
	db 0, 8, 1, 0
	db 8, 0, 2, 0
	db 8, 8, 3, 0
	db -1

.facing2 ; 254b8
	db 0, 0, 1, X_FLIP
	db 0, 8, 0, X_FLIP
	db 8, 0, 3, X_FLIP
	db 8, 8, 2, X_FLIP
	db -1

TrainerCard_JohtoBadgesOAM: ; 254c9
; Template OAM data for each badge on the trainer card.
; Format:
	; y, x, palette1, palette2, palette3, palette4
	; cycle 1: face tile, in1 tile, in2 tile, in3 tile
	; cycle 2: face tile, in1 tile, in2 tile, in3 tile

	dw JohtoBadges

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
; 25523

TrainerCard_KantoBadgesOAM:
; Template OAM data for each badge on the trainer card.
; Format:
	; y, x, palette1, palette2, palette3, palette4
	; cycle 1: face tile, in1 tile, in2 tile, in3 tile
	; cycle 2: face tile, in1 tile, in2 tile, in3 tile

	dw KantoBadges

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

CardBorderGFX:  INCBIN "gfx/trainer_card/border.2bpp"
CardDividerGFX: INCBIN "gfx/trainer_card/divider.2bpp"
CardStatusGFX:  INCBIN "gfx/trainer_card/status.2bpp" ; must come after CardDividerGFX
CardBadgesGFX:  INCBIN "gfx/trainer_card/badges.2bpp"

LeaderGFX:  INCBIN "gfx/trainer_card/johto_leaders.w40.2bpp"
LeaderGFX2: INCBIN "gfx/trainer_card/kanto_leaders.w40.2bpp"
BadgeGFX:   INCBIN "gfx/trainer_card/johto_badges.w16.2bpp"
BadgeGFX2:  INCBIN "gfx/trainer_card/kanto_badges.w16.2bpp"
