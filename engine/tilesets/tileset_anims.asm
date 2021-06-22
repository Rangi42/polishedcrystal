_AnimateTileset::
; Iterate over a given pointer array of
; animation functions (one per frame).

; Typically in wra1, vra0

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
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl

; Function address
	jmp IndirectHL

TilesetJohto1Anim::
	dw vTiles2 tile $14, AnimateWaterTile
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  AnimateFlowerTile
	dw WhirlpoolFrames1, AnimateWhirlpoolTile
	dw WhirlpoolFrames2, AnimateWhirlpoolTile
	dw WhirlpoolFrames3, AnimateWhirlpoolTile
	dw WhirlpoolFrames4, AnimateWhirlpoolTile
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

TilesetJohto2Anim::
	dw vTiles2 tile $14, AnimateWaterTile
	dw vTiles2 tile $1b, AnimateRainPuddleTile
	dw vTiles2 tile $1c, AnimateRainWaterTile
	dw NULL,  DoNothing
	dw NULL,  AnimateFlowerTile
	dw WhirlpoolFrames1, AnimateWhirlpoolTile
	dw WhirlpoolFrames2, AnimateWhirlpoolTile
	dw WhirlpoolFrames3, AnimateWhirlpoolTile
	dw WhirlpoolFrames4, AnimateWhirlpoolTile
	dw NULL,  DoNothing
	dw NULL,  StandingTileFrame8
	dw NULL,  DoNothing
	dw NULL,  DoneTileAnimation

TilesetJohto4Anim::
	dw vTiles2 tile $14, AnimateWaterTile
	dw vTiles2 tile $1b, AnimateRainPuddleTile
	dw vTiles2 tile $1c, AnimateRainWaterTile
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  AnimateFlowerTile
	dw WhirlpoolFrames1, AnimateWhirlpoolTile
	dw WhirlpoolFrames2, AnimateWhirlpoolTile
	dw WhirlpoolFrames3, AnimateWhirlpoolTile
	dw WhirlpoolFrames4, AnimateWhirlpoolTile
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

TilesetKanto1Anim::
	dw vTiles2 tile $14, AnimateKantoWaterTile
	dw NULL,  DoNothing
	dw vTiles2 tile $40, WriteTileToBuffer
	dw NULL,  DoNothing
	dw wTileAnimBuffer, ScrollTileDown
	dw NULL,  DoNothing
	dw wTileAnimBuffer, ScrollTileDown
	dw NULL,  DoNothing
	dw wTileAnimBuffer, ScrollTileDown
	dw NULL,  DoNothing
	dw vTiles2 tile $40, ReadTileFromBuffer
	dw NULL,  AnimateKantoFlowerTile
	dw NULL,  DoNothing
	dw NULL,  DoNothing
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

TilesetGym1Anim::
	dw NULL,  LavaBubbleAnim2
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  LavaBubbleAnim1
	dw NULL,  DoNothing
	dw NULL,  StandingTileFrame8
	dw NULL,  DoneTileAnimation

TilesetKanto2Anim::
	dw vTiles2 tile $14, AnimateKantoWaterTile
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw vTiles2 tile $20, ScrollTileUp
	dw vTiles2 tile $21, ScrollTileDown
	dw vTiles2 tile $22, ScrollTileLeft
	dw vTiles2 tile $23, ScrollTileRight
	dw NULL,  DoNothing
	dw NULL,  AnimateKantoFlowerTile
	dw NULL,  DoNothing
	dw vTiles2 tile $20, ScrollTileUp
	dw vTiles2 tile $21, ScrollTileDown
	dw vTiles2 tile $22, ScrollTileLeft
	dw vTiles2 tile $23, ScrollTileRight
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
	dw NULL,  LavaBubbleAnim4
	dw NULL,  DoNothing
	dw NULL,  LavaBubbleAnim3
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

TilesetParkAnim::
	dw vTiles2 tile $14, AnimateWaterTile
	dw NULL,  DoNothing
	dw vTiles2 tile $15, AnimateFountain
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  AnimateFlowerTile
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
	dw NULL,  ForestTreeLeftAnimation
	dw NULL,  ForestTreeRightAnimation
	dw NULL,  ForestTree2LeftAnimation
	dw NULL,  ForestTree2RightAnimation
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  ForestTreeLeftAnimation2
	dw NULL,  ForestTreeRightAnimation2
	dw NULL,  ForestTree2LeftAnimation2
	dw NULL,  ForestTree2RightAnimation2
	dw NULL,  AnimateFlowerTile
	dw vTiles2 tile $14, AnimateWaterTile
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

TilesetSafariAnim::
	dw vTiles2 tile $14, AnimateKantoWaterTile
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  AnimateKantoFlowerTile
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  StandingTileFrame8
	dw NULL,  DoneTileAnimation

TilesetFarawayAnim::
	dw FarawayWaterFrames1, AnimateFarawayWaterTile
	dw FarawayWaterFrames2, AnimateFarawayWaterTile
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

TilesetTunnelAnim::
	dw vTiles2 tile $26, WriteTileToBuffer
	dw NULL,  DoNothing
	dw wTileAnimBuffer, ScrollTileRightLeft
	dw NULL,  DoNothing
	dw vTiles2 tile $26, ReadTileFromBuffer
	dw NULL,  DoNothing
	dw NULL,  AnimateLCDTile
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
	dw NULL,  AnimateLCDTile
	dw NULL,  FlickeringCaveEntrancePalette
	dw vTiles2 tile $31, WriteTileToBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  FlickeringCaveEntrancePalette
	dw vTiles2 tile $31, ReadTileFromBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  DoneTileAnimation

TilesetShamoutiAnim::
TilesetValenciaAnim::
	dw FarawayWaterFrames1, AnimateFarawayWaterTile
	dw FarawayWaterFrames2, AnimateFarawayWaterTile
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  AnimateFlowerTile
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  StandingTileFrame8
	dw NULL,  DoneTileAnimation

TilesetJohto3Anim::
TilesetHouse1Anim::
TilesetHouse2Anim::
TilesetPokeCenterAnim::
TilesetGateAnim::
TilesetLabAnim::
TilesetFacilityAnim::
TilesetMartAnim::
TilesetMansionAnim::
TilesetGameCornerAnim::
TilesetHouse3Anim::
TilesetGym2Anim::
TilesetGym3Anim::
TilesetLighthouseAnim::
TilesetPokeComAnim::
TilesetBattleTowerAnim::
TilesetRuinsAnim::
TilesetRadioTowerAnim::
TilesetWarehouseAnim::
TilesetAlphAnim::
TilesetPokemonMansionAnim::
TilesetDecorAnim::
TilesetMuseumAnim::
TilesetHotelAnim::
TilesetBattleFactoryAnim::
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
	ld hl, wTileAnimationTimer
	inc [hl]
	ret

StandingTileFrame8:
	ld a, [wTileAnimationTimer]
	inc a
	and %111
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
	ld c, 4
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
	ld c, 4
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
	ld d, [hl]
	inc hl
	ld e, [hl]
	ld bc, 14
	add hl, bc
	ld a, 4
.loop
	ld c, [hl]
	ld [hl], e
	dec hl
	ld b, [hl]
	ld [hl], d
	dec hl
	ld e, [hl]
	ld [hl], c
	dec hl
	ld d, [hl]
	ld [hl], b
	dec hl
	dec a
	jr nz, .loop
	ret

ScrollTileDown:
	ld h, d
	ld l, e
	ld de, 14
	push hl
	add hl, de
	ld d, [hl]
	inc hl
	ld e, [hl]
	pop hl
	ld a, 4
.loop
	ld b, [hl]
	ld [hl], d
	inc hl
	ld c, [hl]
	ld [hl], e
	inc hl
	ld d, [hl]
	ld [hl], b
	inc hl
	ld e, [hl]
	ld [hl], c
	inc hl
	dec a
	jr nz, .loop
	ret

AnimateFountain:
	ld hl, sp+$0
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

	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld sp, hl
	jmp WriteTileToDE

.FountainTilePointers:
	dw .FountainTile1
	dw .FountainTile2
	dw .FountainTile3
	dw .FountainTile4
	dw .FountainTile3
	dw .FountainTile4
	dw .FountainTile5
	dw .FountainTile1

.FountainTile1: INCBIN "gfx/tilesets/fountain/1.2bpp"
.FountainTile2: INCBIN "gfx/tilesets/fountain/2.2bpp"
.FountainTile3: INCBIN "gfx/tilesets/fountain/3.2bpp"
.FountainTile4: INCBIN "gfx/tilesets/fountain/4.2bpp"
.FountainTile5: INCBIN "gfx/tilesets/fountain/5.2bpp"

AnimateWaterTile:
	ld hl, sp+$0
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

	ld sp, hl
	jmp WriteTileToDE

.WaterTileFrames:
INCBIN "gfx/tilesets/water/johto_water.2bpp"

AnimateRainPuddleTile:
	ld hl, sp+$0
	ld b, h
	ld c, l

	; period 8, offset to 1 tile (16 bytes)
	ld a, [wTileAnimationTimer]
	maskbits 8
	swap a

	add LOW(.RainPuddleTileFrames)
	ld l, a
	adc HIGH(.RainPuddleTileFrames)
	sub l
	ld h, a

	ld sp, hl
	jmp WriteTileToDE

.RainPuddleTileFrames:
INCBIN "gfx/tilesets/rain/rain_puddle.2bpp"

AnimateRainWaterTile:
	ld hl, sp+$0
	ld b, h
	ld c, l

	; period 8, offset to 1 tile (16 bytes)
	ld a, [wTileAnimationTimer]
	maskbits 8
	swap a

	add LOW(.RainWaterTileFrames)
	ld l, a
	adc HIGH(.RainWaterTileFrames)
	sub l
	ld h, a

	ld sp, hl
	jmp WriteTileToDE

.RainWaterTileFrames:
INCBIN "gfx/tilesets/rain/rain_water.2bpp"

AnimateKantoWaterTile:
	ld hl, sp+$0
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

	ld sp, hl
	jmp WriteTileToDE

.KantoWaterTileFrames:
INCBIN "gfx/tilesets/water/kanto_water.2bpp"

AnimateFarawayWaterTile:
	ld hl, sp+$0
	ld b, h
	ld c, l

	ld l, e
	ld h, d
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl

	; period 8, offset to 1 tile (16 bytes)
	ld a, [wTileAnimationTimer]
	maskbits 8
	swap a

	add [hl]
	inc hl
	ld h, [hl]
	ld l, a
	adc h
	sub l
	ld h, a

	ld sp, hl
	jmp WriteTileToDE

ForestTreeLeftAnimation:
	ld a, [wCelebiEvent]
	bit 2, a
	ret z

	ld hl, sp+$0
	ld b, h
	ld c, l

	; period 2, offset to 1 tile (16 bytes)
	ld a, [wTileAnimationTimer]
	maskbits 2
	swap a

	add LOW(ForestTreeLeftFrames)
	ld l, a
	adc HIGH(ForestTreeLeftFrames)
	sub l
	ld h, a

	ld sp, hl
	ld hl, vTiles2 tile $50
	jmp WriteTile

ForestTreeRightAnimation:
	ld a, [wCelebiEvent]
	bit 2, a
	ret z

	ld hl, sp+$0
	ld b, h
	ld c, l

	; period 2, offset to 1 tile (16 bytes)
	ld a, [wTileAnimationTimer]
	maskbits 2
	swap a

	add LOW(ForestTreeRightFrames)
	ld l, a
	adc HIGH(ForestTreeRightFrames)
	sub l
	ld h, a

	ld sp, hl
	ld hl, vTiles2 tile $53
	jmp WriteTile

ForestTreeLeftAnimation2:
	ld a, [wCelebiEvent]
	bit 2, a
	ret z

	ld hl, sp+$0
	ld b, h
	ld c, l

	; period 2, phase shift 1, offset to 1 tile (16 bytes)
	ld a, [wTileAnimationTimer]
	maskbits 2
	xor 1
	swap a

	add LOW(ForestTreeLeftFrames)
	ld l, a
	adc HIGH(ForestTreeLeftFrames)
	sub l
	ld h, a

	ld sp, hl
	ld hl, vTiles2 tile $50
	jmp WriteTile

ForestTreeRightAnimation2:
	ld a, [wCelebiEvent]
	bit 2, a
	ret z

	ld hl, sp+$0
	ld b, h
	ld c, l

	; period 2, phase shift 1, offset to 1 tile (16 bytes)
	ld a, [wTileAnimationTimer]
	maskbits 2
	xor 1
	swap a

	add LOW(ForestTreeRightFrames)
	ld l, a
	adc HIGH(ForestTreeRightFrames)
	sub l
	ld h, a

	ld sp, hl
	ld hl, vTiles2 tile $53
	jmp WriteTile

ForestTreeLeftFrames:
INCBIN "gfx/tilesets/forest-tree/1.2bpp"
INCBIN "gfx/tilesets/forest-tree/2.2bpp"

ForestTreeRightFrames:
INCBIN "gfx/tilesets/forest-tree/3.2bpp"
INCBIN "gfx/tilesets/forest-tree/4.2bpp"

ForestTree2LeftAnimation:
	ld a, [wCelebiEvent]
	bit 2, a
	ret z

	ld hl, sp+$0
	ld b, h
	ld c, l

	; period 2, offset to 1 tile (16 bytes)
	ld a, [wTileAnimationTimer]
	maskbits 2
	swap a

	add LOW(ForestTree2LeftFrames)
	ld l, a
	adc HIGH(ForestTree2LeftFrames)
	sub l
	ld h, a

	ld sp, hl
	ld hl, vTiles2 tile $5c
	jmp WriteTile

ForestTree2RightAnimation:
	ld a, [wCelebiEvent]
	bit 2, a
	ret z

	ld hl, sp+$0
	ld b, h
	ld c, l

	; period 2, offset to 1 tile (16 bytes)
	ld a, [wTileAnimationTimer]
	maskbits 2
	swap a

	add LOW(ForestTree2RightFrames)
	ld l, a
	adc HIGH(ForestTree2RightFrames)
	sub l
	ld h, a

	ld sp, hl
	ld hl, vTiles2 tile $5f
	jmp WriteTile

ForestTree2LeftAnimation2:
	ld a, [wCelebiEvent]
	bit 2, a
	ret z

	ld hl, sp+$0
	ld b, h
	ld c, l

	; period 2, phase shift 1, offset to 1 tile (16 bytes)
	ld a, [wTileAnimationTimer]
	maskbits 2
	xor 1
	swap a

	add LOW(ForestTree2LeftFrames)
	ld l, a
	adc HIGH(ForestTree2LeftFrames)
	sub l
	ld h, a

	ld sp, hl
	ld hl, vTiles2 tile $5c
	jmp WriteTile

ForestTree2RightAnimation2:
	ld a, [wCelebiEvent]
	bit 2, a
	ret z

	ld hl, sp+$0
	ld b, h
	ld c, l

	; period 2, phase shift 1, offset to 1 tile (16 bytes)
	ld a, [wTileAnimationTimer]
	maskbits 2
	xor 1
	swap a

	add LOW(ForestTree2RightFrames)
	ld l, a
	adc HIGH(ForestTree2RightFrames)
	sub l
	ld h, a

	ld sp, hl
	ld hl, vTiles2 tile $5f
	jmp WriteTile

ForestTree2LeftFrames:
INCBIN "gfx/tilesets/forest-tree-2/1.2bpp"
INCBIN "gfx/tilesets/forest-tree-2/2.2bpp"

ForestTree2RightFrames:
INCBIN "gfx/tilesets/forest-tree-2/3.2bpp"
INCBIN "gfx/tilesets/forest-tree-2/4.2bpp"

AnimateFlowerTile:
	ld hl, sp+$0
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

	ld sp, hl
	ld hl, vTiles2 tile $03
	jmp WriteTile

.FlowerTileFrames:
INCBIN "gfx/tilesets/flower/1.2bpp"
INCBIN "gfx/tilesets/flower/2.2bpp"

AnimateKantoFlowerTile:
	ld hl, sp+$0
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

	ld sp, hl
	ld hl, vTiles2 tile $03
	jmp WriteTile

.KantoFlowerTileFrames:
INCBIN "gfx/tilesets/kanto-flower/1.2bpp"
INCBIN "gfx/tilesets/kanto-flower/2.2bpp"
INCBIN "gfx/tilesets/kanto-flower/3.2bpp"
INCBIN "gfx/tilesets/kanto-flower/1.2bpp"

LavaBubbleAnim1:
	ld hl, sp+$0
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

	add LOW(LavaBubbleFrames)
	ld l, a
	adc HIGH(LavaBubbleFrames)
	sub l
	ld h, a

	ld sp, hl
	ld hl, vTiles2 tile $5b
	jmp WriteTile

LavaBubbleAnim2:
	ld hl, sp+$0
	ld b, h
	ld c, l

	; period 4, every 2 frames, offset to 1 tile (16 bytes)
	ld a, [wTileAnimationTimer]
	maskbits 4, 1
	add a
	add a
	add a

	add LOW(LavaBubbleFrames)
	ld l, a
	adc HIGH(LavaBubbleFrames)
	sub l
	ld h, a

	ld sp, hl
	ld hl, vTiles2 tile $38
	jmp WriteTile

LavaBubbleAnim3:
	ld hl, sp+$0
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

	add LOW(LavaBubbleFrames)
	ld l, a
	adc HIGH(LavaBubbleFrames)
	sub l
	ld h, a

	ld sp, hl
	ld hl, vTiles2 tile $3d
	jmp WriteTile

LavaBubbleAnim4:
	ld hl, sp+$0
	ld b, h
	ld c, l

	; period 4, every 2 frames, offset to 1 tile (16 bytes)
	ld a, [wTileAnimationTimer]
	maskbits 4, 1
	add a
	add a
	add a

	add LOW(LavaBubbleFrames)
	ld l, a
	adc HIGH(LavaBubbleFrames)
	sub l
	ld h, a

	ld sp, hl
	ld hl, vTiles2 tile $3c
	jmp WriteTile

LavaBubbleFrames:
INCBIN "gfx/tilesets/lava/1.2bpp"
INCBIN "gfx/tilesets/lava/2.2bpp"
INCBIN "gfx/tilesets/lava/3.2bpp"
INCBIN "gfx/tilesets/lava/4.2bpp"

AnimateTowerPillarTile:
	ld hl, sp+$0
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
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl

	add [hl]
	inc hl
	ld h, [hl]
	ld l, a
	adc h
	sub l
	ld h, a

	ld sp, hl
	jmp WriteTileToDE

.TowerPillarTileFrameIndexes:
	db $00, $10, $20, $30, $40, $30, $20, $10

AnimateWhirlpoolTile:
	ld hl, sp+$0
	ld b, h
	ld c, l

	ld l, e
	ld h, d
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl

	; period 4, offset to 1 tile (16 bytes)
	ld a, [wTileAnimationTimer]
	maskbits 4
	swap a

	add [hl]
	inc hl
	ld h, [hl]
	ld l, a
	adc h
	sub l
	ld h, a

	ld sp, hl
	jmp WriteTileToDE

AnimateLCDTile:
	ld hl, sp+$0
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

	ld sp, hl
	ld hl, vTiles2 tile $6f
	jmp WriteTile

.LCDTileFrames:
INCBIN "gfx/tilesets/lcd/1.2bpp"
INCBIN "gfx/tilesets/lcd/2.2bpp"
INCBIN "gfx/tilesets/lcd/3.2bpp"
INCBIN "gfx/tilesets/lcd/4.2bpp"
INCBIN "gfx/tilesets/lcd/5.2bpp"
INCBIN "gfx/tilesets/lcd/6.2bpp"
INCBIN "gfx/tilesets/lcd/7.2bpp"
INCBIN "gfx/tilesets/lcd/8.2bpp"

WriteTileToBuffer:
	ld hl, sp+$0
	ld b, h
	ld c, l

	ld h, d
	ld l, e
	ld sp, hl

	ld hl, wTileAnimBuffer
	jr WriteTile

ReadTileFromBuffer:
	ld hl, sp+$0
	ld b, h
	ld c, l

	ld hl, wTileAnimBuffer
	ld sp, hl
	; fallthrough

WriteTileToDE:
	ld l, e
	ld h, d
	; fallthrough

WriteTile:
	pop de
	ld [hl], e
	inc hl
	ld [hl], d
rept 7
	pop de
	inc hl
	ld [hl], e
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

	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rSVBK], a

	ld a, %10100000 ; auto-increment, index $20 (pal 4 color 0)
	ldh [rBGPI], a

	ldh a, [hVBlankCounter]
	and %10
	ld hl, wBGPals1 palette PAL_BG_YELLOW
	jr z, .okay
	ld hl, wBGPals1 palette PAL_BG_YELLOW + 2
.okay

	ld a, [hli]
	ldh [rBGPD], a
	ld a, [hli]
	ldh [rBGPD], a

	pop af
	ldh [rSVBK], a
	ret

TowerPillarTilePointer1:  dw vTiles2 tile $2d, TowerPillarTile1
TowerPillarTilePointer2:  dw vTiles2 tile $2f, TowerPillarTile2
TowerPillarTilePointer3:  dw vTiles2 tile $3d, TowerPillarTile3
TowerPillarTilePointer4:  dw vTiles2 tile $3f, TowerPillarTile4
TowerPillarTilePointer5:  dw vTiles2 tile $3c, TowerPillarTile5
TowerPillarTilePointer6:  dw vTiles2 tile $2c, TowerPillarTile6
TowerPillarTilePointer7:  dw vTiles2 tile $4d, TowerPillarTile7
TowerPillarTilePointer8:  dw vTiles2 tile $4f, TowerPillarTile8
TowerPillarTilePointer9:  dw vTiles2 tile $5d, TowerPillarTile9
TowerPillarTilePointer10: dw vTiles2 tile $5f, TowerPillarTile10

TowerPillarTile1:  INCBIN "gfx/tilesets/tower-pillar/1.2bpp"
TowerPillarTile2:  INCBIN "gfx/tilesets/tower-pillar/2.2bpp"
TowerPillarTile3:  INCBIN "gfx/tilesets/tower-pillar/3.2bpp"
TowerPillarTile4:  INCBIN "gfx/tilesets/tower-pillar/4.2bpp"
TowerPillarTile5:  INCBIN "gfx/tilesets/tower-pillar/5.2bpp"
TowerPillarTile6:  INCBIN "gfx/tilesets/tower-pillar/6.2bpp"
TowerPillarTile7:  INCBIN "gfx/tilesets/tower-pillar/7.2bpp"
TowerPillarTile8:  INCBIN "gfx/tilesets/tower-pillar/8.2bpp"
TowerPillarTile9:  INCBIN "gfx/tilesets/tower-pillar/9.2bpp"
TowerPillarTile10: INCBIN "gfx/tilesets/tower-pillar/10.2bpp"

WhirlpoolFrames1: dw vTiles2 tile $32, WhirlpoolTiles1
WhirlpoolFrames2: dw vTiles2 tile $33, WhirlpoolTiles2
WhirlpoolFrames3: dw vTiles2 tile $42, WhirlpoolTiles3
WhirlpoolFrames4: dw vTiles2 tile $43, WhirlpoolTiles4

WhirlpoolTiles1: INCBIN "gfx/tilesets/whirlpool/1.2bpp"
WhirlpoolTiles2: INCBIN "gfx/tilesets/whirlpool/2.2bpp"
WhirlpoolTiles3: INCBIN "gfx/tilesets/whirlpool/3.2bpp"
WhirlpoolTiles4: INCBIN "gfx/tilesets/whirlpool/4.2bpp"

FarawayWaterFrames1: dw vTiles2 tile $14, FarawayWaterTiles1
FarawayWaterFrames2: dw vTiles2 tile $15, FarawayWaterTiles2

FarawayWaterTiles1: INCBIN "gfx/tilesets/water/faraway_water_1.2bpp"
FarawayWaterTiles2: INCBIN "gfx/tilesets/water/faraway_water_2.2bpp"
