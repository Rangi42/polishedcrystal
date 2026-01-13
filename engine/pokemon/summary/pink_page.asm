SummaryScreen_PinkPage:
	ld a, SUMMARY_TILE_OAM_EXP_TITLE
	call SummaryScreen_UpdateTabTitle
	; Place pokerus
	ld a, [wTempMonPokerusStatus]
	and POKERUS_MASK
	jr z, .pokerusDone
	ld e, SUMMARY_TILE_POKERUS
	cp POKERUS_CURED
	jr nz, .placePokerus
	assert SUMMARY_TILE_POKERUS + 1 == SUMMARY_TILE_POKERUS_CURED
	inc e
.placePokerus
	hlbgcoord 0, 5, wSummaryScreenWindowBuffer
	ld [hl], e
	hlbgcoord 16, 5, wSummaryScreenWindowBuffer
	ld [hl], SUMMARY_PAL_SHINY_POKERUS
.pokerusDone
	; Place shiny
	ld bc, wTempMonShiny
	farcall CheckShininess
	jr nc, .shinyDone
	hlbgcoord 10, 0, wSummaryScreenWindowBuffer
	ld [hl], '★'
	hlbgcoord 16 + 10, 0, wSummaryScreenWindowBuffer
	ld [hl], SUMMARY_PAL_SHINY_POKERUS
.shinyDone
	ld a, [wTextboxFlags]
	set USE_BG_MAP_WIDTH_F, a
	ld [wTextboxFlags], a

	; Place dex number
	ld a, [wCurPartySpecies]
	ld [wTempSpecies], a
	ld [wCurSpecies], a
	ld c, a
	ld a, [wCurForm]
	ld b, a
	call GetPokedexNumber
	ld d, b
	ld e, c
	hlbgcoord 0, 0, wSummaryScreenWindowBuffer
	ld a, '№'
	ld [hli], a
	ld a, '.'
	ld [hli], a
	lb bc, PRINTNUM_LEADINGZEROS | 2, 3
	call PrintNumFromReg ; sets de

	; Place name
	ld hl, wTempMonNickname
	call CopyNickname
	hlbgcoord 0, 1, wSummaryScreenWindowBuffer
	rst PlaceString
	hlbgcoord 1, 2, wSummaryScreenWindowBuffer
	ld a, '/'
	ld [hli], a
	push hl
	call GetPartyPokemonName
	pop hl
	rst PlaceString

	; Place ball
	hlbgcoord 8, 3, wSummaryScreenWindowBuffer
	ld a, SUMMARY_TILE_BALL_SIDE_BORDER
	ld [hli], a
	ld a, SUMMARY_TILE_BALL
	ld [hli], a
	ld a, SUMMARY_TILE_BALL_SIDE_BORDER
	ld [hli], a

	hlbgcoord 25, 3, wSummaryScreenWindowBuffer
	ld a, SUMMARY_PAL_POKEBALL
	ld [hli], a

	hlbgcoord 26, 3, wSummaryScreenWindowBuffer
	ld [hl], OAM_XFLIP | SUMMARY_PAL_SIDE_WINDOW

	ld hl, .BallSprites
	ld bc, 8
	ld de, wSummaryScreenOAMSprite12
	rst CopyBytes

	ld hl, .StatusSprites
	ld bc, 8
	ld de, wSummaryScreenOAMSprite14
	rst CopyBytes

	ld c, 4
	call DelayFrames

	ld d, 0 | 8
	ld a, [wBaseType1]
	lb bc, 72, 76
	ld hl, wSummaryScreenOAMSprite04
	call SummaryScreen_PlaceTypeOBJ
	debgcoord 0, 3, wSummaryScreenWindowBuffer
	call SummaryScreen_PlaceTypeBG

	; Place types
	ld a, [wBaseType1]
	ld e, a
	ld a, [wBaseType2]
	cp e
	jr z, .doneTypes
	ld d, 1 | 8
	lb bc, 104, 76
	ld hl, wSummaryScreenOAMSprite08
	call SummaryScreen_PlaceTypeOBJ
	debgcoord 4, 3, wSummaryScreenWindowBuffer
	call SummaryScreen_PlaceTypeBG

.doneTypes
	call .PlaceOTInfo
	ld a, [wTextboxFlags]
	res USE_BG_MAP_WIDTH_F, a
	ld [wTextboxFlags], a
	hlcoord 9, 8
	ld de, SCREEN_WIDTH
	ld b, 10

	ld de, .ExpPointStr
	hlcoord 1, 13
	rst PlaceString
	hlcoord 12, 13
	lb bc, 3, 7
	ld de, wTempMonExp
	call PrintNum
	call .CalcExpToNextLevel
	hlcoord 12, 15
	lb bc, 3, 7
	ld de, wBuffer1
	call PrintNum
	ld de, .LevelUpStr
	hlcoord 1, 15
	rst PlaceString
	ld de, .ToStr
	hlcoord 13, 17
	rst PlaceString
	hlcoord 16, 17
	call .PrintNextLevel
	hlcoord 2, 17
	ld a, [wTempMonLevel]
	ld b, a
	ld de, wTempMonExp + 2
	farcall FillInExpBar
	hlcoord 1, 17
	ld a, '<XP1>'
	ld [hli], a
	ld [hl], '<XP2>'
	hlcoord 9, 17
	ld [hl], '<XPEND>'

	ld hl, .PinkPalettes
	ld bc, 1 palettes
	ld de, wSummaryScreenPals palette SUMMARY_PAL_LOWER_WINDOW
	rst CopyBytes
	ld bc, 1 palettes
	ld de, wSummaryScreenPals palette SUMMARY_PAL_SIDE_WINDOW
	rst CopyBytes
	ld bc, 1 palettes
	ld de, wSummaryScreenPals palette SUMMARY_PAL_SHINY_POKERUS
	rst CopyBytes

	ld hl, CaughtBallPals
	ld bc, 2 colors
	ld a, [wTempMonCaughtBall]
	and CAUGHT_BALL_MASK
	rst AddNTimes
	ld de, wSummaryScreenPals palette SUMMARY_PAL_POKEBALL
	farjp LoadPalette_White_Col1_Col2_Black

.PrintNextLevel:
	ld a, [wTempMonLevel]
	push af
	cp MAX_LEVEL
	jr z, .atMaxLevel
	inc a
	ld [wTempMonLevel], a
.atMaxLevel
	call PrintLevel
	pop af
	ld [wTempMonLevel], a
	ret

.CalcExpToNextLevel:
	ld a, [wTempMonLevel]
	cp MAX_LEVEL
	jr z, .AlreadyAtMaxLevel
	inc a
	ld d, a
	farcall CalcExpAtLevel
	ld hl, wTempMonExp + 2
	ldh a, [hQuotient + 2]
	sub [hl]
	dec hl
	ld [wBuffer3], a
	ldh a, [hQuotient + 1]
	sbc [hl]
	dec hl
	ld [wBuffer2], a
	ldh a, [hQuotient]
	sbc [hl]
	ld [wBuffer1], a
	ret

.AlreadyAtMaxLevel:
	ld hl, wBuffer1
	xor a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ret

.PlaceOTInfo:
	; for rental mons, replace the whole thing with "Rental #mon"
	farcall BT_InRentalMode
	hlbgcoord 0, 4, wSummaryScreenWindowBuffer
	jr nz, .not_rental_mon
	ld de, .Rental_OT
	rst PlaceString
	ret

.not_rental_mon
	ld de, .OTStr
	rst PlaceString
	ld de, .IDStr
	hlbgcoord 2, 5, wSummaryScreenWindowBuffer
	rst PlaceString
	hlbgcoord 5, 5, wSummaryScreenWindowBuffer
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	ld de, wTempMonID
	call PrintNum
	ld hl, wTempMonOT
	call CopyNickname
	hlbgcoord 4, 4, wSummaryScreenWindowBuffer
	rst PlaceString
	ret

.PinkPalettes:
INCLUDE "gfx/stats/pink_page.pal"

.BallSprites:
	db 68, 144, SUMMARY_TILE_OAM_BALL_TOP_BORDER, OAM_YFLIP
	db 84, 144, SUMMARY_TILE_OAM_BALL_TOP_BORDER, 0

.StatusSprites:
	db 31, 120, SUMMARY_TILE_OAM_STATUS + 0, 5
	db 31, 128, SUMMARY_TILE_OAM_STATUS + 1, 5

.OTStr:
	text "OT/"
	done

.IDStr
	text "<ID>№."
	done

.Rental_OT:
	text  "Rental"
	next1 "  #mon"
	done

.ExpPointStr:
	db "Exp.Points@"

.LevelUpStr:
	db "Level Up@"

.ToStr:
	db "to@"

CopyNickname:
	ld de, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	push de
	rst CopyBytes
	pop de
	ret
