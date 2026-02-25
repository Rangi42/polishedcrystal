_AnimateTileset::
; Increment [hTileAnimFrame] and run that frame's function
; from the array pointed to by wTilesetAnim.

; Called in WRAM bank 1, VRAM bank 0, so map tiles
; $80 and above in VRAM bank 1 cannot be animated
; without switching to that bank themselves.

	ld hl, wTilesetAnim
	ld a, [hli]
	ld d, [hl]
	ld e, a

	ldh a, [hTileAnimFrame]
	ld l, a
	inc a
	ldh [hTileAnimFrame], a

	ld h, 0
	add hl, hl
	add hl, hl
	add hl, de

; 2-byte parameter
; All functions take input de.
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a

; Function address
	jmp IndirectHL

TilesetJohtoTraditionalAnim::
TilesetJohtoModernAnim::
TilesetJohtoOutlandsAnim::
TilesetJohtoAncientAnim::
TilesetBattleTowerOutsideAnim::
TilesetEcruteakShrineAnim::
	dw vTiles2 tile $14, AnimateWaterTile
	dw vTiles2 tile $1c, AnimateRainTiles
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw vTiles2 tile $03, AnimateFlowerTile
	dw vTiles2 tile $30, AnimateWhirlpoolTiles
	dw vTiles2 tile $1c, AnimateRainTiles
	dw NULL,  DoNothing
	dw NULL,  StandingTileFrame8
	dw vTiles2 tile $35, WriteTileToBuffer
	dw NULL,  DoNothing
	dw wTileAnimBuffer, ScrollTileDown
	dw NULL,  DoNothing
	dw wTileAnimBuffer, ScrollTileDown
	dw NULL,  DoNothing
	dw wTileAnimBuffer, ScrollTileDown
	dw NULL,  DoNothing
	dw vTiles2 tile $35, ReadTileFromBuffer
	dw NULL,  DoneTileAnimation

TilesetKantoAnim::
TilesetKantoNorthAnim::
TilesetIndigoPlateauAnim::
	dw vTiles2 tile $14, AnimateKantoWaterTile
	dw vTiles2 tile $40, WriteTileToBuffer
	dw wTileAnimBuffer, ScrollTileDown
	dw wTileAnimBuffer, ScrollTileDown
	dw wTileAnimBuffer, ScrollTileDown
	dw vTiles2 tile $40, ReadTileFromBuffer
	dw vTiles2 tile $10, ScrollTileUp
	dw vTiles2 tile $11, ScrollTileDown
	dw vTiles2 tile $12, ScrollTileLeft
	dw vTiles2 tile $13, ScrollTileRight
	dw vTiles2 tile $03, AnimateKantoFlowerTile
	dw vTiles2 tile $10, ScrollTileUp
	dw vTiles2 tile $11, ScrollTileDown
	dw vTiles2 tile $12, ScrollTileLeft
	dw vTiles2 tile $13, ScrollTileRight
	dw NULL,  StandingTileFrame8
	dw NULL,  DoneTileAnimation

TilesetPortAnim::
	dw vTiles2 tile $14, AnimateWaterTile
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  StandingTileFrame8
	dw NULL,  DoneTileAnimation

TilesetGymAnim::
	dw vTiles2 tile $38, AnimateLavaBubbleTile2
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw vTiles2 tile $5b, AnimateLavaBubbleTile1
	dw NULL,  DoNothing
	dw NULL,  StandingTileFrame8
	dw NULL,  DoneTileAnimation

TilesetTowerAnim::
	dw TowerPillarTilePointer9,  AnimateTowerPillarTile
	dw TowerPillarTilePointer10, AnimateTowerPillarTile
	dw TowerPillarTilePointer7,  AnimateTowerPillarTile
	dw TowerPillarTilePointer8,  AnimateTowerPillarTile
	dw TowerPillarTilePointer5,  AnimateTowerPillarTile
	dw TowerPillarTilePointer6,  AnimateTowerPillarTile
	dw TowerPillarTilePointer3,  AnimateTowerPillarTile
	dw TowerPillarTilePointer4,  AnimateTowerPillarTile
	dw TowerPillarTilePointer1,  AnimateTowerPillarTile
	dw TowerPillarTilePointer2,  AnimateTowerPillarTile
	dw NULL,  StandingTileFrame
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoneTileAnimation

TilesetCaveAnim::
TilesetQuietCaveAnim::
	dw vTiles2 tile $3c, AnimateLavaBubbleTile2
	dw NULL,  DoNothing
	dw vTiles2 tile $3d, AnimateLavaBubbleTile1
	dw NULL,  DoNothing
	dw NULL,  StandingTileFrame8
	dw vTiles2 tile $25, WriteTileToBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw wTileAnimBuffer, ScrollTileRightLeft
	dw vTiles2 tile $4e, ScrollTileUp
	dw vTiles2 tile $4f, ScrollTileDown
	dw vTiles2 tile $5e, ScrollTileLeft
	dw vTiles2 tile $5f, ScrollTileRight
	dw NULL,  FlickeringCaveEntrancePalette
	dw vTiles2 tile $25, ReadTileFromBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  DoNothing
	dw NULL,  FlickeringCaveEntrancePalette
	dw vTiles2 tile $26, WriteTileToBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw wTileAnimBuffer, ScrollTileDown
	dw NULL,  FlickeringCaveEntrancePalette
	dw wTileAnimBuffer, ScrollTileDown
	dw NULL,  FlickeringCaveEntrancePalette
	dw vTiles2 tile $4e, ScrollTileUp
	dw vTiles2 tile $4f, ScrollTileDown
	dw vTiles2 tile $5e, ScrollTileLeft
	dw vTiles2 tile $5f, ScrollTileRight
	dw wTileAnimBuffer, ScrollTileDown
	dw NULL,  FlickeringCaveEntrancePalette
	dw vTiles2 tile $26, ReadTileFromBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  DoneTileAnimation

TilesetPeaksAnim::
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  StandingTileFrame8
	dw vTiles2 tile $25, WriteTileToBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw wTileAnimBuffer, ScrollTileRightLeft
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  FlickeringCaveEntrancePalette
	dw vTiles2 tile $25, ReadTileFromBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  DoNothing
	dw NULL,  FlickeringCaveEntrancePalette
	dw vTiles2 tile $26, WriteTileToBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw wTileAnimBuffer, ScrollTileDown
	dw NULL,  FlickeringCaveEntrancePalette
	dw wTileAnimBuffer, ScrollTileDown
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw wTileAnimBuffer, ScrollTileDown
	dw NULL,  FlickeringCaveEntrancePalette
	dw vTiles2 tile $26, ReadTileFromBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  DoneTileAnimation

TilesetParkAnim::
	dw vTiles2 tile $14, AnimateWaterTile
	dw NULL,  DoNothing
	dw vTiles2 tile $15, AnimateFountainTile
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw vTiles2 tile $03, AnimateFlowerTile
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  StandingTileFrame8
	dw NULL,  DoneTileAnimation

TilesetIcePathAnim::
	dw vTiles2 tile $10, WriteTileToBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw wTileAnimBuffer, ScrollTileRightLeft
	dw NULL,  FlickeringCaveEntrancePalette
	dw vTiles2 tile $10, ReadTileFromBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  DoNothing
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  DoneTileAnimation

TilesetForestAnim::
	dw vTiles2 tile $50, AnimateForestTreeTiles
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw vTiles2 tile $03, AnimateFlowerTile
	dw vTiles2 tile $14, AnimateWaterTile
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw vTiles2 tile $50, AnimateForestTreeTiles
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  StandingTileFrame8
	dw vTiles2 tile $40, WriteTileToBuffer
	dw NULL,  DoNothing
	dw wTileAnimBuffer, ScrollTileDown
	dw NULL,  DoNothing
	dw wTileAnimBuffer, ScrollTileDown
	dw NULL,  DoNothing
	dw wTileAnimBuffer, ScrollTileDown
	dw NULL,  DoNothing
	dw vTiles2 tile $40, ReadTileFromBuffer
	dw NULL,  DoneTileAnimation

TilesetSafariZoneAnim::
	dw vTiles2 tile $14, AnimateKantoWaterTile
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw vTiles2 tile $03, AnimateKantoFlowerTile
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  StandingTileFrame8
	dw NULL,  DoneTileAnimation

TilesetFarawayIslandAnim::
	dw vTiles2 tile $14, AnimateFarawayWaterTiles
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  StandingTileFrame8
	dw NULL,  DoneTileAnimation

TilesetTraditionalHouseAnim::
	dw vTiles2 tile $6d, AnimateFireTiles
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  StandingTileFrame8
	dw NULL,  DoneTileAnimation

TilesetTunnelAnim::
	dw vTiles2 tile $26, WriteTileToBuffer
	dw NULL,  DoNothing
	dw wTileAnimBuffer, ScrollTileRightLeft
	dw NULL,  DoNothing
	dw vTiles2 tile $26, ReadTileFromBuffer
	dw NULL,  DoNothing
	dw vTiles2 tile $5e, AnimateLCDTile
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  StandingTileFrame8
	dw vTiles2 tile $30, WriteTileToBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  FlickeringCaveEntrancePalette
	dw vTiles2 tile $30, ReadTileFromBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  DoNothing
	dw vTiles2 tile $5e, AnimateLCDTile
	dw NULL,  FlickeringCaveEntrancePalette
	dw vTiles2 tile $31, WriteTileToBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  FlickeringCaveEntrancePalette
	dw vTiles2 tile $31, ReadTileFromBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  DoneTileAnimation

TilesetShamoutiIslandAnim::
TilesetValenciaIslandAnim::
	dw vTiles2 tile $14, AnimateFarawayWaterTiles
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw vTiles2 tile $03, AnimateFlowerTile
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  StandingTileFrame8
	dw NULL,  DoneTileAnimation

TilesetSnowtopMountainAnim::
	dw vTiles2 tile $0a, AnimateTinyWaterTiles
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  StandingTileFrame8
	dw NULL,  DoneTileAnimation

TilesetHideoutAnim::
	dw vTiles2 tile $08, AnimateSpinnerTile
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  StandingTileFrame8
	dw NULL,  DoneTileAnimation

TilesetJohtoHouseAnim::
TilesetKantoHouseAnim::
TilesetPokeCenterAnim::
TilesetGateAnim::
TilesetLabAnim::
TilesetFacilityAnim::
TilesetMartAnim::
TilesetMansionAnim::
TilesetGameCornerAnim::
TilesetMagnetTrainAnim::
TilesetChampionsRoomAnim::
TilesetLighthouseAnim::
TilesetUndergroundAnim::
TilesetPokeComCenterAnim::
TilesetBattleTowerInsideAnim::
TilesetRuinsOfAlphAnim::
TilesetRadioTowerAnim::
TilesetPokemonMansionAnim::
TilesetDecorAnim::
TilesetMuseumAnim::
TilesetHotelAnim::
TilesetBattleFactoryAnim::
TilesetHiddenGrottoAnim::
TilesetKantoGymAnim::
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoneTileAnimation

DoneTileAnimation:
; Reset the animation command loop.
	xor a
	ldh [hTileAnimFrame], a
	ret

StandingTileFrame:
; Tick the wTileAnimationTimer.
	ld hl, wTileAnimationTimer
	inc [hl]
	ret

StandingTileFrame8:
; Tick the wTileAnimationTimer, wrapping from 7 to 0.
	ld a, [wTileAnimationTimer]
	inc a
	maskbits 8
	ld [wTileAnimationTimer], a
	ret

ScrollTileRightLeft:
; Scroll right for 4 ticks, then left for 4 ticks.
	ld a, [wTileAnimationTimer]
	inc a
	and %111
	ld [wTileAnimationTimer], a
	and %100
	jr nz, ScrollTileLeft
	; fallthrough

ScrollTileRight:
	ld h, d
	ld l, e
	ld c, TILE_SIZE / 4
.loop
rept 4
	ld a, [hl]
	rrca
	ld [hli], a
endr
	dec c
	jr nz, .loop
	ret

ScrollTileLeft:
	ld h, d
	ld l, e
	ld c, TILE_SIZE / 4
.loop
rept 4
	ld a, [hl]
	rlca
	ld [hli], a
endr
	dec c
	jr nz, .loop
	ret

;ScrollTileUpDown:
;; Scroll up for 4 ticks, then down for 4 ticks.
;	ld a, [wTileAnimationTimer]
;	inc a
;	and %111
;	ld [wTileAnimationTimer], a
;	and %100
;	jr nz, ScrollTileDown
;	; fallthrough

ScrollTileUp:
	ld h, d
	ld l, e
	ld a, [hli]
	ld e, [hl]
	ld d, a
	ld bc, TILE_SIZE - 2
	add hl, bc
	ld a, TILE_SIZE / 4
.loop
	ld c, [hl]
	ld [hl], e ; no-optimize *hl++|*hl-- = b|c|d|e (a is the .loop counter)
	dec hl
	ld b, [hl]
	ld [hl], d ; no-optimize *hl++|*hl-- = b|c|d|e (a is the .loop counter)
	dec hl
	ld e, [hl]
	ld [hl], c ; no-optimize *hl++|*hl-- = b|c|d|e (a is the .loop counter)
	dec hl
	ld d, [hl]
	ld [hl], b ; no-optimize *hl++|*hl-- = b|c|d|e (a is the .loop counter)
	dec hl
	dec a
	jr nz, .loop
	ret

ScrollTileDown:
	ld h, d
	ld l, e
	ld de, TILE_SIZE - 2
	push hl
	add hl, de
	ld a, [hli]
	ld e, [hl]
	ld d, a
	pop hl
	ld a, TILE_SIZE / 4
.loop
	ld b, [hl]
	ld [hl], d ; no-optimize *hl++|*hl-- = b|c|d|e (a is the .loop counter)
	inc hl
	ld c, [hl]
	ld [hl], e ; no-optimize *hl++|*hl-- = b|c|d|e (a is the .loop counter)
	inc hl
	ld d, [hl]
	ld [hl], b ; no-optimize *hl++|*hl-- = b|c|d|e (a is the .loop counter)
	inc hl
	ld e, [hl]
	ld [hl], c ; no-optimize *hl++|*hl-- = b|c|d|e (a is the .loop counter)
	inc hl
	dec a
	jr nz, .loop
	ret

AnimateFountainTile:
	ld hl, sp + 0
	ld b, h
	ld c, l

	; period 8, offset to pointer table (2 bytes)
	ld a, [wTileAnimationTimer]
	maskbits 8
	add a

	add LOW(.FountainTilePointers)
	ld l, a
	adc HIGH(.FountainTilePointers)
	sub l
	ld h, a

	ld sp, hl
	pop hl

	jmp WriteTileHLToDE

.FountainTilePointers:
	dw .FountainTileFrames + 0 tiles ; 0
	dw .FountainTileFrames + 1 tiles ; 1
	dw .FountainTileFrames + 2 tiles ; 2
	dw .FountainTileFrames + 3 tiles ; 3
	dw .FountainTileFrames + 2 tiles ; 4
	dw .FountainTileFrames + 3 tiles ; 5
	dw .FountainTileFrames + 4 tiles ; 6
	dw .FountainTileFrames + 0 tiles ; 7

.FountainTileFrames:
INCBIN "gfx/tilesets/animations/fountain.2bpp"

AnimateWaterTile:
	ld hl, sp + 0
	ld b, h
	ld c, l

	; period 4, every 2 frames, offset to 1 tile (16 bytes)
	ld a, [wTileAnimationTimer]
	maskbits 4, 1
	add a
	add a
	add a

	add LOW(.WaterTileFrames)
	ld l, a
	adc HIGH(.WaterTileFrames)
	sub l
	ld h, a

	jmp WriteTileHLToDE

.WaterTileFrames:
INCBIN "gfx/tilesets/animations/water_johto.2bpp"

AnimateRainTiles:
	ld hl, sp + 0
	ld b, h
	ld c, l

	; period 8, offset to 2 tiles (32 bytes)
	ld a, [wTileAnimationTimer]
	maskbits 8
	swap a
	add a

	add LOW(.RainTileFrames)
	ld l, a
	adc HIGH(.RainTileFrames)
	sub l
	ld h, a

	jmp WriteTwoTilesHLToDE

.RainTileFrames:
INCBIN "gfx/tilesets/animations/rain.2bpp"

AnimateKantoWaterTile:
	ld hl, sp + 0
	ld b, h
	ld c, l

	; period 4, every 2 frames, offset to 1 tile (16 bytes)
	ld a, [wTileAnimationTimer]
	maskbits 4, 1
	add a
	add a
	add a

	add LOW(.KantoWaterTileFrames)
	ld l, a
	adc HIGH(.KantoWaterTileFrames)
	sub l
	ld h, a

	jmp WriteTileHLToDE

.KantoWaterTileFrames:
INCBIN "gfx/tilesets/animations/water_kanto.2bpp"

AnimateFarawayWaterTiles:
	ld hl, sp + 0
	ld b, h
	ld c, l

	; period 8, offset to 2 tiles (32 bytes)
	ld a, [wTileAnimationTimer]
	maskbits 8
	swap a
	add a

	add LOW(.FarawayWaterTileFrames)
	ld l, a
	adc HIGH(.FarawayWaterTileFrames)
	sub l
	ld h, a

	jmp WriteTwoTilesHLToDE

.FarawayWaterTileFrames:
INCBIN "gfx/tilesets/animations/water_faraway.2bpp"

AnimateSpinnerTile:
	ld hl, sp + 0
	ld b, h
	ld c, l

	ld a, [wSpinning]
	and a
	jr z, .ok

	; period 2, every 2 frames, offset to 1 tile (16 bytes)
	ld a, [wTileAnimationTimer]
	maskbits 2, 1
	add a
	add a
	add a

.ok
	add LOW(.SpinnerTileFrames)
	ld l, a
	adc HIGH(.SpinnerTileFrames)
	sub l
	ld h, a

	jmp WriteTileHLToDE

.SpinnerTileFrames:
INCBIN "gfx/tilesets/animations/spinner.2bpp"

AnimateForestTreeTiles:
	ld a, [wCelebiEvent]
	bit CELEBIEVENT_FOREST_IS_RESTLESS_F, a
	ret z

	ld hl, sp + 0
	ld b, h
	ld c, l

	; period 2, offset to 4 tiles (64 bytes)
	ld a, [wTileAnimationTimer]
	maskbits 2
	swap a
	add a
	add a

	add LOW(.ForestTreeTileFrames)
	ld l, a
	adc HIGH(.ForestTreeTileFrames)
	sub l
	ld h, a

	jmp WriteFourTilesHLToDE

.ForestTreeTileFrames:
INCBIN "gfx/tilesets/animations/forest_tree.2bpp"

AnimateFlowerTile:
	ld hl, sp + 0
	ld b, h
	ld c, l

	; period 2, every 2 frames, offset to 1 tile (16 bytes)
	ld a, [wTileAnimationTimer]
	maskbits 2, 1
	add a
	add a
	add a

	add LOW(.FlowerTileFrames)
	ld l, a
	adc HIGH(.FlowerTileFrames)
	sub l
	ld h, a

	jmp WriteTileHLToDE

.FlowerTileFrames:
INCBIN "gfx/tilesets/animations/flower_johto.2bpp"

AnimateKantoFlowerTile:
	ld hl, sp + 0
	ld b, h
	ld c, l

	; period 4, every 2 frames, offset to 1 tile (16 bytes)
	ld a, [wTileAnimationTimer]
	maskbits 4, 1
	add a
	add a
	add a

	add LOW(.KantoFlowerTileFrames)
	ld l, a
	adc HIGH(.KantoFlowerTileFrames)
	sub l
	ld h, a

	jmp WriteTileHLToDE

.KantoFlowerTileFrames:
INCBIN "gfx/tilesets/animations/flower_kanto.2bpp"

AnimateLavaBubbleTile1:
	ld hl, sp + 0
	ld b, h
	ld c, l

	; period 4, phase shift 2, every 2 frames, offset to 1 tile (16 bytes)
	ld a, [wTileAnimationTimer]
	maskbits 4, 1
	srl a
	inc a
	inc a
	maskbits 4
	swap a

	jr _FinishAnimateLavaBubbleTile

AnimateLavaBubbleTile2:
	ld hl, sp + 0
	ld b, h
	ld c, l

	; period 4, every 2 frames, offset to 1 tile (16 bytes)
	ld a, [wTileAnimationTimer]
	maskbits 4, 1
	add a
	add a
	add a
	; fallthrough

_FinishAnimateLavaBubbleTile:
	add LOW(.LavaBubbleFrames)
	ld l, a
	adc HIGH(.LavaBubbleFrames)
	sub l
	ld h, a

	jmp WriteTileHLToDE

.LavaBubbleFrames:
INCBIN "gfx/tilesets/animations/lava.2bpp"

AnimateTowerPillarTile:
	ld hl, sp + 0
	ld b, h
	ld c, l

	; period 8, offset to index table (1 byte)
	ld a, [wTileAnimationTimer]
	maskbits 8

	add LOW(.TowerPillarTileFrameIndexes)
	ld l, a
	adc HIGH(.TowerPillarTileFrameIndexes)
	sub l
	ld h, a
	ld a, [hl]

	ld l, e
	ld h, d
	ld e, [hl] ; no-optimize b|c|d|e = *hl++|*hl--
	inc hl
	ld d, [hl] ; no-optimize b|c|d|e = *hl++|*hl--
	inc hl

	add [hl]
	inc hl
	ld h, [hl]
	ld l, a
	adc h
	sub l
	ld h, a

	jmp WriteTileHLToDE

.TowerPillarTileFrameIndexes:
	db 0 tiles ; 0
	db 1 tiles ; 1
	db 2 tiles ; 2
	db 3 tiles ; 3
	db 4 tiles ; 4
	db 3 tiles ; 5
	db 2 tiles ; 6
	db 1 tiles ; 7

TowerPillarTilePointer1:  dw vTiles2 tile $2d, TowerPillarTileFrames + 5 * 0 tiles
TowerPillarTilePointer2:  dw vTiles2 tile $2f, TowerPillarTileFrames + 5 * 1 tiles
TowerPillarTilePointer3:  dw vTiles2 tile $3d, TowerPillarTileFrames + 5 * 2 tiles
TowerPillarTilePointer4:  dw vTiles2 tile $3f, TowerPillarTileFrames + 5 * 3 tiles
TowerPillarTilePointer5:  dw vTiles2 tile $3c, TowerPillarTileFrames + 5 * 4 tiles
TowerPillarTilePointer6:  dw vTiles2 tile $2c, TowerPillarTileFrames + 5 * 5 tiles
TowerPillarTilePointer7:  dw vTiles2 tile $4d, TowerPillarTileFrames + 5 * 6 tiles
TowerPillarTilePointer8:  dw vTiles2 tile $4f, TowerPillarTileFrames + 5 * 7 tiles
TowerPillarTilePointer9:  dw vTiles2 tile $5d, TowerPillarTileFrames + 5 * 8 tiles
TowerPillarTilePointer10: dw vTiles2 tile $5f, TowerPillarTileFrames + 5 * 9 tiles

TowerPillarTileFrames:
INCBIN "gfx/tilesets/animations/tower_pillar.2bpp"
	
AnimateWhirlpoolTiles:
	ld hl, sp + 0
	ld b, h
	ld c, l

	; period 4, offset to 4 tiles (64 bytes)
	ld a, [wTileAnimationTimer]
	maskbits 4
	swap a
	add a
	add a

	add LOW(.WhirlpoolTileFrames)
	ld l, a
	adc HIGH(.WhirlpoolTileFrames)
	sub l
	ld h, a

	jmp WriteFourTilesHLToDE

.WhirlpoolTileFrames:
INCBIN "gfx/tilesets/animations/whirlpool.2bpp"

AnimateTinyWaterTiles:
	; period 2, every 2 frames, offset to 3 tiles (48 bytes)
	ld a, [wTileAnimationTimer]
	maskbits 2, 1
	add a
	add a
	add a
	ld b, a
	add a
	add b

	ld hl, sp + 0
	ld b, h
	ld c, l

	add LOW(.TinyWaterTileFrames)
	ld l, a
	adc HIGH(.TinyWaterTileFrames)
	sub l
	ld h, a

	jmp WriteThreeTilesHLToDE

.TinyWaterTileFrames:
INCBIN "gfx/tilesets/animations/tiny_water.2bpp"

AnimateLCDTile:
	ld hl, sp + 0
	ld b, h
	ld c, l

	; period 8, offset to 1 tile (16 bytes)
	ld a, [wTileAnimationTimer]
	maskbits 8
	swap a

	add LOW(.LCDTileFrames)
	ld l, a
	adc HIGH(.LCDTileFrames)
	sub l
	ld h, a

	jmp WriteTileHLToDE

.LCDTileFrames:
INCBIN "gfx/tilesets/animations/lcd.2bpp"

AnimateFireTiles:
	ld hl, sp + 0
	ld b, h
	ld c, l

	; period 4, offset to 2 tiles (32 bytes)
	ld a, [wTileAnimationTimer]
	maskbits 4
	swap a
	add a

	add LOW(.FireTileFrames)
	ld l, a
	adc HIGH(.FireTileFrames)
	sub l
	ld h, a

	jmp WriteTwoTilesHLToDE

.FireTileFrames:
INCBIN "gfx/tilesets/animations/fire.2bpp"

WriteFourTilesHLToDE:
	ld sp, hl
	ld l, e
	ld h, d
	; fallthrough

WriteFourTiles:
	pop de
	ld [hl], e ; no-optimize *hl++|*hl-- = b|c|d|e
	inc hl
	ld [hl], d
rept 8
	pop de
	inc hl
	ld [hl], e ; no-optimize *hl++|*hl-- = b|c|d|e
	inc hl
	ld [hl], d
endr

	jr _FinishWritingThreeTiles

WriteThreeTilesHLToDE:
	ld sp, hl
	ld l, e
	ld h, d
	; fallthrough

WriteThreeTiles:
	pop de
	ld [hl], e ; no-optimize *hl++|*hl-- = b|c|d|e
	inc hl
	ld [hl], d
_FinishWritingThreeTiles:
rept 8
	pop de
	inc hl
	ld [hl], e ; no-optimize *hl++|*hl-- = b|c|d|e
	inc hl
	ld [hl], d
endr

	jr _FinishWritingTwoTiles

WriteTwoTilesHLToDE:
	ld sp, hl
	ld l, e
	ld h, d
	; fallthrough

WriteTwoTiles:
	pop de
	ld [hl], e ; no-optimize *hl++|*hl-- = b|c|d|e
	inc hl
	ld [hl], d
_FinishWritingTwoTiles:
rept 8
	pop de
	inc hl
	ld [hl], e ; no-optimize *hl++|*hl-- = b|c|d|e
	inc hl
	ld [hl], d
endr

	jr _FinishWritingOneTile

WriteTileToBuffer:
	ld hl, sp + 0
	ld b, h
	ld c, l

	ld h, d
	ld l, e
	ld sp, hl

	ld hl, wTileAnimBuffer
	jr WriteTile

ReadTileFromBuffer:
	ld hl, sp + 0
	ld b, h
	ld c, l

	ld hl, wTileAnimBuffer
	; fallthrough

WriteTileHLToDE:
	ld sp, hl
	ld l, e
	ld h, d
	; fallthrough

WriteTile:
	pop de
	ld [hl], e ; no-optimize *hl++|*hl-- = b|c|d|e
	inc hl
	ld [hl], d
_FinishWritingOneTile:
rept 7
	pop de
	inc hl
	ld [hl], e ; no-optimize *hl++|*hl-- = b|c|d|e
	inc hl
	ld [hl], d
endr

	ld h, b
	ld l, c
	ld sp, hl
	ret

FlickeringCaveEntrancePalette:
	ldh a, [rBGP]
	cp %11100100
	ret nz

	ld a, [wTimeOfDayPalset]
	cp DARKNESS_PALSET
	ret nz

	ldh a, [rWBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rWBK], a

	ld a, BGPI_AUTOINC | (0 palette 4)
	ldh [rBGPI], a

	ldh a, [hVBlankCounter]
	and %10
	ld hl, wBGPals1 palette PAL_BG_YELLOW
	jr z, .okay
	inc hl
	inc hl
.okay

	ld a, [hli]
	ldh [rBGPD], a
	ld a, [hli]
	ldh [rBGPD], a

	pop af
	ldh [rWBK], a
	ret
