; TODO redo the entire egg screen
EggSummaryScreen:
	xor a
	ldh [hBGMapMode], a
	ld hl, wCurHPPal
	call SetHPPal
	ld a, CGB_SUMMARY_SCREEN_HP_PALS
	call GetCGBLayout
	call SummaryScreen_PlaceEggDivider
	ld de, EggString
	hlcoord 8, 1
	rst PlaceString
	ld a, [wTempMonHappiness] ; egg status
	ld de, EggSoonString
	cp $6
	jr c, .picked
	ld de, EggCloseString
	cp $b
	jr c, .picked
	ld de, EggMoreTimeString
	cp $29
	jr c, .picked
	ld de, EggALotMoreTimeString
.picked
	hlcoord 1, 9
	rst PlaceString
	ld hl, wSummaryScreenFlags
	set 5, [hl]
	call SetDefaultBGPAndOBP ; pals
	call DelayFrame
	hlcoord 0, 0
	call PrepMonFrontpic
	farcall HDMATransferTileMapToWRAMBank3
	call SummaryScreen_AnimateEgg

	ld a, [wTempMonHappiness]
	cp 6
	ret nc
	ld de, SFX_2_BOOPS
	jmp PlaySFX

SummaryScreen_PlaceEggDivider:
	hlcoord 0, 7
	ld b, SCREEN_WIDTH
	ld a, $3e
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ret

EggString:
	text "Egg"
	next "OT/?????"
	next "<ID>№.?????"
	done

EggSoonString:
	text "It's making sounds"
	next "inside. It's going"
	next "to hatch soon!"
	done

EggCloseString:
	text "It moves around"
	next "inside sometimes."
	next "It must be close"
	next "to hatching."
	done

EggMoreTimeString:
	text "Wonder what's"
	next "inside? It needs"
	next "more time, though."
	done

EggALotMoreTimeString:
	text "This Egg needs a"
	next "lot more time to"
	next "hatch."
	done

SummaryScreen_AnimateEgg:
	call SummaryScreen_GetAnimationParam
	ret nc
	ld a, [wTempMonHappiness]
	ld e, $7
	cp 6
	jr c, .animate
	ld e, $8
	cp 11
	ret nc
.animate
	push de
	ld a, $1
	ld [wBoxAlignment], a
	call SummaryScreen_LoadTextboxSpaceGFX
	ld de, vTiles2 tile $00
	predef FrontpicPredef
	pop de
	hlcoord 0, 0
	ld d, $0
	predef LoadMonAnimation
	ld hl, wSummaryScreenFlags
	set 6, [hl]
	ret
