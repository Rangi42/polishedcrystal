BattleStart_TrainerHuds:
	ld a, $e4
	ldh [rOBP0], a
	call LoadBallIconGFX
	call ShowPlayerMonsRemaining
	ld a, [wBattleMode]
	dec a
	ret z
	jr ShowOTTrainerMonsRemaining

ShowPlayerMonsRemaining:
	call DrawPlayerPartyIconHUDBorder
	ld hl, wPartyMon1HP
	ld de, wPartyCount
	call StageBallTilesData
	; ldpixel wPlaceBallsX, 12, 12
	ld a, 12 * 8
	ld hl, wPlaceBallsX
	ld [hli], a
	ld [hl], a
	ld a, 8
	ld [wPlaceBallsDirection], a
	ld hl, wVirtualOAM
	jmp LoadTrainerHudOAM

EnemySwitch_TrainerHud:
	ld a, $e4
	ldh [rOBP0], a
	call LoadBallIconGFX
	; fallthrough

ShowOTTrainerMonsRemaining:
	call DrawEnemyPartyIconHUDBorder
	ld hl, wOTPartyMon1HP
	ld de, wOTPartyCount
	call StageBallTilesData
	; ldpixel wPlaceBallsX, 9, 4
	ld hl, wPlaceBallsX
	ld a, 9 * 8
	ld [hli], a
	ld [hl], 4 * 8
	ld a, -8
	ld [wPlaceBallsDirection], a
	ld hl, wVirtualOAM + PARTY_LENGTH * 4
	jmp LoadTrainerHudOAM

StageBallTilesData:
	ld a, [de]
	push af
	ld de, wBuffer1
	ld c, PARTY_LENGTH
	ld a, $34 ; empty slot
.loop1
	ld [de], a
	inc de
	dec c
	jr nz, .loop1
	pop af
	ld de, wBuffer1
.loop2
	push af
	call .GetHUDTile
	inc de
	pop af
	dec a
	jr nz, .loop2
	ret

.GetHUDTile:
	ld a, [hli]
	and a
	jr nz, .got_hp
	ld a, [hl]
	and a
	ld b, $33 ; fainted
	jr z, .fainted

.got_hp
	dec hl
	dec hl
	dec hl
	ld a, [hl]
	and a
	ld b, $32 ; statused
	jr nz, .load
	dec b ; $31 ; normal
	jr .load

.fainted
	dec hl
	dec hl
	dec hl

.load
	ld a, b
	ld [de], a
	ld bc, PARTYMON_STRUCT_LENGTH + MON_HP - MON_STATUS
	add hl, bc
	ret

DrawPlayerPartyIconHUDBorder:
	ld hl, .tiles
	ld de, wTrainerHUDTiles
	ld bc, 4
	rst CopyBytes
	hlcoord 19, 11
	ld de, -1 ; start on right
	jr PlaceHUDBorderTiles

.tiles
	db "—" ; past right
	db "—" ; right end
	db "—" ; bar
	db "◢" ; left end

DrawEnemyPartyIconHUDBorder:
	ld hl, .tiles
	ld de, wTrainerHUDTiles
	ld bc, 4
	rst CopyBytes
	hlcoord 0, 3
	ld de, 1 ; start on left
	call PlaceHUDBorderTiles
	jr DrawEnemyHUDBorder

.tiles
	db "—" ; past left
	db "—" ; left end
	db "—" ; bar
	db "◣" ; right end

DrawEnemyHUDBorder:
	ld a, [wBattleMode]
	dec a
	ret nz
	call DoesNuzlockeModePreventCapture
	jr c, .nuzlocke
	ld a, [wTempEnemyMonSpecies]
	dec a
	call CheckCaughtMon
	ret z
	hlcoord 1, 1
	ld [hl], "<BALL>"
	ret

.nuzlocke
	hlcoord 1, 1
	ld [hl], "<NONO>"
	ret

PlaceHUDBorderTiles:
	ld a, [wTrainerHUDTiles]
	ld [hl], a
	ld b, $8
.loop
	add hl, de
	ld a, [wTrainerHUDTiles + 1]
	ld [hl], a
	dec b
	jr nz, .loop
	add hl, de
	ld a, [wTrainerHUDTiles + 2]
	ld [hl], a
	add hl, de
	ld a, [wTrainerHUDTiles + 3]
	ld [hl], a
	ret

LinkBattle_TrainerHuds:
	call LoadBallIconGFX
	ld hl, wPartyMon1HP
	ld de, wPartyCount
	call StageBallTilesData
	ld hl, wPlaceBallsX
	ld a, 10 * 8
	ld [hli], a
	ld [hl], 8 * 8
	ld a, $8
	ld [wPlaceBallsDirection], a
	ld hl, wVirtualOAM
	call LoadTrainerHudOAM

	ld hl, wOTPartyMon1HP
	ld de, wOTPartyCount
	call StageBallTilesData
	ld hl, wPlaceBallsX
	ld a, 10 * 8
	ld [hli], a
	ld [hl], 13 * 8
	ld hl, wVirtualOAM + PARTY_LENGTH * 4
	; fallthrough

LoadTrainerHudOAM:
	ld de, wBuffer1
	ld c, PARTY_LENGTH
.loop
	ld a, [wPlaceBallsY]
	ld [hli], a
	ld a, [wPlaceBallsX]
	ld [hli], a
	ld a, [de]
	ld [hli], a
	ld a, PAL_BATTLE_OB_YELLOW
	ld [hli], a
	ld a, [wPlaceBallsX]
	ld b, a
	ld a, [wPlaceBallsDirection]
	add b
	ld [wPlaceBallsX], a
	inc de
	dec c
	jr nz, .loop
	ret

LoadBallIconGFX:
	ld de, .gfx
	ld hl, vTiles0 tile $31
	lb bc, BANK(LoadBallIconGFX), 4
	jmp Get2bpp

.gfx
INCBIN "gfx/battle/balls.2bpp"

_ShowLinkBattleParticipants:
	call ClearBGPalettes
	call LoadFontsExtra
	hlcoord 2, 3
	lb bc, 9, 14
	call Textbox
	hlcoord 4, 5
	ld de, wPlayerName
	rst PlaceString
	hlcoord 4, 10
	ld de, wOTPlayerName
	rst PlaceString
	hlcoord 9, 8
	ld a, "V"
	ld [hli], a
	ld [hl], "S"
	call LinkBattle_TrainerHuds
	ld a, CGB_DIPLOMA
	call GetCGBLayout
	call SetPalettes
	ld a, $e4
	ldh [rOBP0], a
	ret

DoesNuzlockeModePreventCapture:
	; Is nuzlocke mode on?
	ld a, [wInitialOptions]
	bit NUZLOCKE_MODE, a
	jr z, .no

	; Is tutorial battle?
	ld a, [wBattleType]
	cp BATTLETYPE_TUTORIAL
	jr z, .no

	; Is enemy shiny?
	farcall BattleCheckEnemyShininess
	jr c, .no

	; Is location already done?
	call GetCurrentLandmark
	ld c, a
	ld hl, wNuzlockeLandmarkFlags
	; Use landmark as index into flag array
	ld b, CHECK_FLAG
	ld d, $0
	predef FlagPredef
	ld a, c
	and a
	jr z, .no

	scf
	ret

.no
	xor a
	ret
