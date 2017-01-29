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

	ld hl, CardStatusGFX
	ld de, VTiles2 tile $29
	ld bc, 5 tiles
	ld a, BANK(CardStatusGFX)
	call FarCopyBytes

	call TrainerCard_PrintTopHalfOfCard

	hlcoord 0, 8
	ld d, 6
	call TrainerCard_InitBorder

	call EnableLCD
	call WaitBGMap
	ld b, SCGB_TRAINER_CARD
	call GetSGBLayout
	call SetPalettes
	call WaitBGMap
	ld hl, wJumptableIndex
	xor a
rept 3
	ld [hli], a
endr
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
	hlcoord 0, 8
	ld d, 6
	call TrainerCard_InitBorder
	call WaitBGMap
	ld de, CardStatusGFX
	ld hl, VTiles2 tile $29
	lb bc, BANK(CardStatusGFX), 5
	call Request2bpp
	call TrainerCard_Page1_PrintDexCaught_GameTime
	call TrainerCard_IncrementJumptable
	ret

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
	hlcoord 0, 8
	ld d, 6
	call TrainerCard_InitBorder
	call WaitBGMap

	ld b, SCGB_TRAINER_CARD
	call GetSGBLayout
	call SetPalettes
	call WaitBGMap

	ld de, LeaderGFX
	ld hl, VTiles2 tile $29
	lb bc, BANK(LeaderGFX), $56
	call Request2bpp
	ld de, BadgeGFX
	ld hl, VTiles0 tile $00
	lb bc, BANK(BadgeGFX), $2c
	call Request2bpp
	call TrainerCard_Page2_InitObjectsAndStrings
	call TrainerCard_IncrementJumptable
	ret

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
	hlcoord 0, 8
	ld d, 6
	call TrainerCard_InitBorder
	call WaitBGMap

	ld b, SCGB_TRAINER_CARD_2
	call GetSGBLayout
	call SetPalettes
	call WaitBGMap

	ld de, LeaderGFX2
	ld hl, VTiles2 tile $29
	lb bc, BANK(LeaderGFX2), $56
	call Request2bpp
	ld de, BadgeGFX2
	ld hl, VTiles0 tile $00
	lb bc, BANK(BadgeGFX2), $2c
	call Request2bpp
	call TrainerCard_Page3_InitObjectsAndStrings
	call TrainerCard_IncrementJumptable
	ret

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

TrainerCard_PrintTopHalfOfCard: ; 25299 (9:5299)
	hlcoord 0, 0
	ld d, 5
	call TrainerCard_InitBorder

	hlcoord 2, 2
	ld de, .Name_Money
	call PlaceString

	hlcoord 2, 4
	ld de, .ID_No
	call PlaceString

	hlcoord 7, 2
	ld de, PlayerName
	call PlaceString

	hlcoord 5, 4
	ld de, PlayerID
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	call PrintNum

	hlcoord 1, 3
	ld de, .HorizontalDivider
	call TrainerCardSetup_PlaceTilemapString

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
	call PrintNum

	ret

; 252ec (9:52ec)

.Name_Money: ; 252ec
	db   "Name/"
	next ""
	next "Money@"

.ID_No: ; 252f9
	db "<ID>№.@"

.HorizontalDivider: ; 252fc
	db $25, $25, $25, $25, $25, $25, $25, $25, $25, $25, $25, $25, $26, $ff ; ____________>
; 2530a

TrainerCard_Page1_PrintDexCaught_GameTime: ; 2530a (9:530a)
	hlcoord 2, 10
	ld de, .Dex_PlayTime_BP
	call PlaceString

	hlcoord 12, 16
	ld de, .Badges
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

	hlcoord 2, 8
	ld de, .StatusTilemap
	call TrainerCardSetup_PlaceTilemapString

	ld a, [StatusFlags] ; pokedex
	bit 0, a
	jr nz, .have_pokedex
	hlcoord 1, 9
	lb bc, 2, 17
	call ClearBox
.have_pokedex
	ld a, [BattlePoints]
	and a
	ret nz
	hlcoord 1, 13
	lb bc, 2, 17
	call ClearBox
	ret

.Dex_PlayTime_BP:
	db   "#dex"
	next "Play Time"
	next "Battle Pts@@"

.Badges:
	db "Badges▶@"

.StatusTilemap: ; 25366
	db $29, $2a, $2b, $2c, $2d, $ff
; 2536c

TrainerCard_Page2_InitObjectsAndStrings: ; 2536c (9:536c)
	hlcoord 2, 8
	ld de, .BadgesTilemap
	call TrainerCardSetup_PlaceTilemapString
	hlcoord 2, 10
	ld a, $29
	ld c, 4
.loop
	call TrainerCard_Page2_3_PlaceLeadersFaces
rept 4
	inc hl
endr
	dec c
	jr nz, .loop
	hlcoord 2, 13
	ld a, $51
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
	ld hl, TrainerCard_JohtoBadgesOAM
	call TrainerCard_Page2_3_AnimateBadges
	ret

; 253a2 (9:53a2)

.BadgesTilemap: ; 253a2
	db $79, $7a, $7b, $7c, $7d, $ff ; "BADGES"
; 253a8

TrainerCard_Page3_InitObjectsAndStrings:
	hlcoord 2, 8
	ld de, .BadgesTilemap
	call TrainerCardSetup_PlaceTilemapString
	hlcoord 2, 10
	ld a, $29
	ld c, 4
.loop
	call TrainerCard_Page2_3_PlaceLeadersFaces
rept 4
	inc hl
endr
	dec c
	jr nz, .loop
	hlcoord 2, 13
	ld a, $51
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
	call TrainerCard_Page2_3_OAMUpdate
	ret

.BadgesTilemap:
	db $79, $7a, $7b, $7c, $7d, $ff ; "BADGES"

TrainerCardSetup_PlaceTilemapString: ; 253a8 (9:53a8)
.loop
	ld a, [de]
	cp $ff
	ret z
	ld [hli], a
	inc de
	jr .loop

TrainerCard_InitBorder: ; 253b0 (9:53b0)
	ld e, 20
.loop1
	ld a, $23
	ld [hli], a
	dec e
	jr nz, .loop1

	ld a, $23
	ld [hli], a
	ld e, 17
	ld a, " "
.loop2
	ld [hli], a
	dec e
	jr nz, .loop2

	ld a, $27
	ld [hli], a
	ld a, $23
	ld [hli], a
.loop3
	ld a, $23
	ld [hli], a

	ld e, 18
	ld a, " "
.loop4
	ld [hli], a
	dec e
	jr nz, .loop4

	ld a, $23
	ld [hli], a
	dec d
	jr nz, .loop3

	ld a, $23
	ld [hli], a
	ld a, $24
	ld [hli], a

	ld e, 17
	ld a, " "
.loop5
	ld [hli], a
	dec e
	jr nz, .loop5
	ld a, $23
	ld [hli], a
	ld e, 20
.loop6
	ld a, $23
	ld [hli], a
	dec e
	jr nz, .loop6
	ret

TrainerCard_Page2_3_PlaceLeadersFaces: ; 253f4 (9:53f4)
	push de
	push hl
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld de, SCREEN_WIDTH - 3
	add hl, de
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld de, SCREEN_WIDTH - 3
	add hl, de
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	pop hl
	pop de
	ret

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

TrainerCard_Page2_3_AnimateBadges: ; 25438 (9:5438)
	ld a, [hVBlankCounter]
	and $7
	ret nz
	ld a, [wcf64]
	inc a
	and $7
	ld [wcf64], a
	jr TrainerCard_Page2_3_OAMUpdate

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
	ld a, [hli] ; pal
	ld [wcf66], a
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
	ld bc, $b ; 3 + 2 * 4
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

	ld a, [wcf66]
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
	; y, x, palette
	; cycle 1: face tile, in1 tile, in2 tile, in3 tile
	; cycle 2: face tile, in1 tile, in2 tile, in3 tile

	dw JohtoBadges

	; Zephyr Badge
	db $68, $18, 0
	db $00, $20, $24, $20 | $80
	db $00, $20, $24, $20 | $80

	; Hive Badge
	db $68, $38, 1
	db $04, $20, $24, $20 | $80
	db $04, $20, $24, $20 | $80

	; Plain Badge
	db $68, $58, 2
	db $08, $20, $24, $20 | $80
	db $08, $20, $24, $20 | $80

	; Fog Badge
	db $68, $78, 3
	db $0c, $20, $24, $20 | $80
	db $0c | $80, $20, $24, $20 | $80

	; Mineral Badge
	db $80, $38, 5
	db $10, $20, $24, $20 | $80
	db $10, $20, $24, $20 | $80

	; Storm Badge
	db $80, $18, 4
	db $14, $20, $24, $20 | $80
	db $14 | $80, $20, $24, $20 | $80

	; Glacier Badge
	db $80, $58, 6
	db $18, $20, $24, $20 | $80
	db $18, $20, $24, $20 | $80

	; Rising Badge
	db $80, $78, 7
	db $1c, $20, $24, $20 | $80
	db $1c, $20, $24, $20 | $80
; 25523

TrainerCard_KantoBadgesOAM:
; Template OAM data for each badge on the trainer card.
; Format:
	; y, x, palette
	; cycle 1: face tile, in1 tile, in2 tile, in3 tile
	; cycle 2: face tile, in1 tile, in2 tile, in3 tile

	dw KantoBadges

	; Boulder Badge
	db $80, $38, 0
	db $00, $20, $24, $20 | $80
	db $00, $20, $24, $20 | $80

	; Cascade Badge
	db $68, $58, 1
	db $04, $20, $24, $20 | $80
	db $04, $20, $24, $20 | $80

	; Thunder Badge
	db $68, $18, 2
	db $08, $20, $24, $20 | $80
	db $08, $20, $24, $20 | $80

	; Rainbow Badge
	db $68, $78, 3
	db $0c, $20, $24, $20 | $80
	db $0c, $20, $24, $20 | $80

	; Soul Badge
	db $80, $18, 4
	db $10, $20, $24, $20 | $80
	db $10, $20, $24, $20 | $80

	; Marsh Badge
	db $68, $38, 5
	db $14, $20, $24, $20 | $80
	db $14, $20, $24, $20 | $80

	; Volcano Badge
	db $80, $58, 6
	db $18, $20, $24, $20 | $80
	db $18, $20, $24, $20 | $80

	; Earth Badge
	db $80, $78, 7
	db $1c, $20, $24, $20 | $80
	db $1c | $80, $20, $24, $20 | $80

CardStatusGFX: INCBIN "gfx/misc/card_status.2bpp"

LeaderGFX:  INCBIN "gfx/misc/johto_leaders.w40.2bpp"
LeaderGFX2: INCBIN "gfx/misc/kanto_leaders.w40.2bpp"
BadgeGFX:   INCBIN "gfx/misc/johto_badges.w16.2bpp"
BadgeGFX2:  INCBIN "gfx/misc/kanto_badges.w16.2bpp"
