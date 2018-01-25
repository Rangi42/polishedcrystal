BattleStart_TrainerHuds: ; 2c000
	ld a, $e4
	ld [rOBP0], a
	call LoadBallIconGFX
	call ShowPlayerMonsRemaining
	ld a, [wBattleMode]
	dec a
	ret z
	jp ShowOTTrainerMonsRemaining
; 2c012

EnemySwitch_TrainerHud: ; 2c012
	ld a, $e4
	ld [rOBP0], a
	call LoadBallIconGFX
	jp ShowOTTrainerMonsRemaining
; 2c01c

ShowPlayerMonsRemaining: ; 2c01c
	call DrawPlayerPartyIconHUDBorder
	ld hl, PartyMon1HP
	ld de, PartyCount
	call StageBallTilesData
	; ldpixel wPlaceBallsX, 12, 12
	ld a, 12 * 8
	ld hl, wPlaceBallsX
	ld [hli], a
	ld [hl], a
	ld a, 8
	ld [wPlaceBallsDirection], a
	ld hl, Sprites
	jp LoadTrainerHudOAM
; 2c03a

ShowOTTrainerMonsRemaining: ; 2c03a
	call DrawEnemyPartyIconHUDBorder
	ld hl, OTPartyMon1HP
	ld de, OTPartyCount
	call StageBallTilesData
	; ldpixel wPlaceBallsX, 9, 4
	ld hl, wPlaceBallsX
	ld a, 9 * 8
	ld [hli], a
	ld [hl], 4 * 8
	ld a, -8
	ld [wPlaceBallsDirection], a
	ld hl, Sprites + PARTY_LENGTH * 4
	jp LoadTrainerHudOAM
; 2c059

StageBallTilesData: ; 2c059
	ld a, [de]
	push af
	ld de, Buffer1
	ld c, PARTY_LENGTH
	ld a, $34 ; empty slot
.loop1
	ld [de], a
	inc de
	dec c
	jr nz, .loop1
	pop af
	ld de, Buffer1
.loop2
	push af
	call .GetHUDTile
	inc de
	pop af
	dec a
	jr nz, .loop2
	ret
; 2c075

.GetHUDTile: ; 2c075
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
; 2c095

DrawPlayerHUDBorder: ; 2c095
	hlcoord 19, 11
	ld [hl], "<XPEND>"
	hlcoord 10, 11
	ld [hl], "<XP1>"
	inc hl
	ld [hl], "<XP2>"
	ret

DrawPlayerPartyIconHUDBorder: ; 2c0ad
	ld hl, .tiles
	ld de, wTrainerHUDTiles
	ld bc, 4
	call CopyBytes
	hlcoord 19, 11
	ld de, -1 ; start on right
	jr PlaceHUDBorderTiles

.tiles
	db "—" ; past right
	db "—" ; right end
	db "—" ; bar
	db "◢" ; left end
; 2c0c5

DrawEnemyPartyIconHUDBorder:
	ld hl, .tiles
	ld de, wTrainerHUDTiles
	ld bc, 4
	call CopyBytes
	hlcoord 0, 3
	ld de, 1 ; start on left
	call PlaceHUDBorderTiles
	jr DrawEnemyHUDBorder

.tiles
	db "—" ; past left
	db "—" ; left end
	db "—" ; bar
	db "◣" ; right end

DrawEnemyHUDBorder: ; 2c0c5
	ld a, [wBattleMode]
	dec a
	ret nz
	call DoesNuzlockeModePreventCapture
	jr c, .nuzlocke
	ld a, [TempEnemyMonSpecies]
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
; 2c0f1

PlaceHUDBorderTiles: ; 2c0f1
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
; 2c10d

LinkBattle_TrainerHuds: ; 2c10d
	call LoadBallIconGFX
	ld hl, PartyMon1HP
	ld de, PartyCount
	call StageBallTilesData
	ld hl, wPlaceBallsX
	ld a, 10 * 8
	ld [hli], a
	ld [hl], 8 * 8
	ld a, $8
	ld [wPlaceBallsDirection], a
	ld hl, Sprites
	call LoadTrainerHudOAM

	ld hl, OTPartyMon1HP
	ld de, OTPartyCount
	call StageBallTilesData
	ld hl, wPlaceBallsX
	ld a, 10 * 8
	ld [hli], a
	ld [hl], 13 * 8
	ld hl, Sprites + PARTY_LENGTH * 4
	; fallthrough

LoadTrainerHudOAM: ; 2c143
	ld de, Buffer1
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
; 2c165

LoadBallIconGFX: ; 2c165
	ld de, .gfx
	ld hl, VTiles0 tile $31
	lb bc, BANK(LoadBallIconGFX), 4
	jp Get2bpp_2
; 2c172

.gfx ; 2c172
INCBIN "gfx/battle/balls.2bpp"
; 2c1b2

_ShowLinkBattleParticipants: ; 2c1b2
	call ClearBGPalettes
	call LoadFontsExtra
	hlcoord 2, 3
	lb bc, 9, 14
	call TextBox
	hlcoord 4, 5
	ld de, PlayerName
	call PlaceString
	hlcoord 4, 10
	ld de, OTPlayerName
	call PlaceString
	hlcoord 9, 8
	ld a, "V"
	ld [hli], a
	ld [hl], "S"
	call LinkBattle_TrainerHuds
	ld b, CGB_DIPLOMA
	call GetCGBLayout
	call SetPalettes
	ld a, $e4
	ld [rOBP0], a
	ret
; 2c1ef

DoesNuzlockeModePreventCapture:
	; Is nuzlocke mode on?
	ld a, [InitialOptions]
	bit NUZLOCKE_MODE, a
	jr z, .no

	; Is enemy shiny?
	farcall BattleCheckEnemyShininess
	jr c, .no

	; Is location already done?
	ld a, [MapGroup]
	ld b, a
	ld a, [MapNumber]
	ld c, a
	call GetWorldMapLocation
	ld c, a
	ld hl, NuzlockeLandmarkFlags
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
