DisplayCaughtContestMonStats:
	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
	call LoadFontsBattleExtra

	ld hl, wOptions1
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]

	hlcoord 0, 0
	lb bc, 4, 13
	call Textbox

	hlcoord 0, 6
	lb bc, 4, 13
	call Textbox

	hlcoord 2, 0
	ld de, .Stock
	rst PlaceString

	hlcoord 2, 6
	ld de, .This
	rst PlaceString

	hlcoord 5, 4
	ld de, .Health
	rst PlaceString

	hlcoord 5, 10
	ld de, .Health
	rst PlaceString

	ld a, [wContestMon]
	ld [wd265], a
	call GetPokemonName
	ld de, wStringBuffer1
	hlcoord 1, 2
	rst PlaceString

	ld h, b
	ld l, c
	ld a, [wContestMonLevel]
	ld [wTempMonLevel], a
	call PrintLevel

	ld de, wEnemyMonNick
	hlcoord 1, 8
	rst PlaceString

	ld h, b
	ld l, c
	ld a, [wEnemyMonLevel]
	ld [wTempMonLevel], a
	call PrintLevel

	hlcoord 11, 4
	ld de, wContestMonMaxHP
	lb bc, 2, 3
	call PrintNum

	hlcoord 11, 10
	ld de, wEnemyMonMaxHP
	call PrintNum

	ld hl, SwitchMonText
	call PrintText

	pop af
	ld [wOptions1], a

	call ApplyTilemapInVBlank
	ld a, CGB_DIPLOMA
	call GetCGBLayout
	jp SetPalettes

.Health:
	db "Health@"
.Stock:
	db " Stock <PK><MN> @"
.This:
	db " This <PK><MN>  @"

SwitchMonText:
	; Switch #MON?
	text_jump _ContestAskSwitchText
	text_end
