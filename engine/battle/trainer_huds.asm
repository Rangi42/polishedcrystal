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
	ld hl, wPartyCount
	call StageBallTilesData
	; ldpixel wPlaceBallsX, 12, 12
	ld a, 12 * 8
	ld hl, wPlaceBallsX
	ld [hli], a
	ld [hl], a
	ld a, 8
	ld [wPlaceBallsDirection], a
	ld hl, wShadowOAM
	jmp LoadTrainerHudOAM

EnemySwitch_TrainerHud:
	ld a, $e4
	ldh [rOBP0], a
	call LoadBallIconGFX
	; fallthrough

ShowOTTrainerMonsRemaining:
	call DrawEnemyPartyIconHUDBorder
	ld hl, wOTPartyCount
	call StageBallTilesData
	; ldpixel wPlaceBallsX, 9, 4
	ld hl, wPlaceBallsX
	ld a, 9 * 8
	ld [hli], a
	ld [hl], 4 * 8
	ld a, -8
	ld [wPlaceBallsDirection], a
	ld hl, wShadowOAM + PARTY_LENGTH * 4
	jmp LoadTrainerHudOAM

StageBallTilesData:
	ld a, PARTY_LENGTH
	ld c, a
	sub [hl]
	ld b, a
	assert wPartyMon1Status - wPartyCount == wOTPartyMon1Status - wOTPartyCount
	ld de, wPartyMon1Status - wPartyCount
	add hl, de
	ld de, wBuffer1
.loop
	push bc
	ld a, b
	cp c
	ld b, $34 ; empty slot
	jr nc, .load

	assert MON_HP == MON_STATUS + 2
	inc hl
	inc hl ; points to w(OT)PartyMon1HP
	dec b ; $33, fainted
	ld a, [hli]
	and a
	jr nz, .got_hp
	ld a, [hl]
	and a
.got_hp
	dec hl ; dec rr doesn't affect flags
	dec hl
	dec hl
	jr z, .load

	dec b ; $32, statused
	ld a, [hl]
	and a
	jr nz, .load
	dec b ; $31, normal

.load
	ld a, b
	ld [de], a
	inc de
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	pop bc
	dec c
	jr nz, .loop
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
	ld a, [wOTPartyMon1Species]
	ld c, a
	ld a, [wOTPartyMon1Form]
	ld b, a
	call CheckCosmeticCaughtMon
	ret z
	ld a, [wBattleType]
	cp BATTLETYPE_GHOST
	ret z
	hlcoord 1, 1
	ld [hl], '<BALL>'
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
	ld hl, wPartyCount
	call StageBallTilesData
	ld hl, wPlaceBallsX
	ld a, 10 * 8
	ld [hli], a
	ld [hl], 8 * 8
	ld a, $8
	ld [wPlaceBallsDirection], a
	ld hl, wShadowOAM
	call LoadTrainerHudOAM

	ld hl, wOTPartyCount
	call StageBallTilesData
	ld hl, wPlaceBallsX
	ld a, 10 * 8
	ld [hli], a
	ld [hl], 13 * 8
	ld hl, wShadowOAM + PARTY_LENGTH * 4
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
	call LoadFrame
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
	ld a, 'V'
	ld [hli], a
	ld [hl], 'S'
	call LinkBattle_TrainerHuds
	ld a, CGB_PLAIN
	call GetCGBLayout
	call SetDefaultBGPAndOBP
	ld a, $e4
	ldh [rOBP0], a
	ret
