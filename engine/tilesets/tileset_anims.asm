_AnimateTileset::
; Iterate over a given pointer array of
; animation functions (one per frame).

; Typically in wra1, vra0

	ld a, [wTilesetAnim]
	ld e, a
	ld a, [wTilesetAnim + 1]
	ld d, a

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
	jp IndirectHL

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
	dw vTiles2 tile $40, WriteTileFromBuffer
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
	dw vTiles2 tile $40, WriteTileFromBuffer
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
	dw vTiles2 tile $40, WriteTileFromBuffer
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
	dw vTiles2 tile $25, WriteTileFromBuffer
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
	dw vTiles2 tile $26, WriteTileFromBuffer
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
	dw vTiles2 tile $10, WriteTileFromBuffer
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
	dw vTiles2 tile $40, WriteTileFromBuffer
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
	dw vTiles2 tile $26, WriteTileFromBuffer
	dw NULL,  DoNothing
	dw NULL,  AnimateLCDTile
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  DoNothing
	dw NULL,  StandingTileFrame8
	dw vTiles2 tile $30, WriteTileToBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  FlickeringCaveEntrancePalette
	dw vTiles2 tile $30, WriteTileFromBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  DoNothing
	dw NULL,  AnimateLCDTile
	dw NULL,  FlickeringCaveEntrancePalette
	dw vTiles2 tile $31, WriteTileToBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  FlickeringCaveEntrancePalette
	dw vTiles2 tile $31, WriteTileFromBuffer
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

StandingTileFrame8:
	ld a, [wTileAnimationTimer]
	inc a
	and 7
	ld [wTileAnimationTimer], a
	ret

ScrollTileRightLeft:
; Scroll right for 4 ticks, then left for 4 ticks.
	ld a, [wTileAnimationTimer]
	inc a
	and 7
	ld [wTileAnimationTimer], a
	and 4
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
;	and 7
;	ld [wTileAnimationTimer], a
;	and 4
;	jr nz, ScrollTileDown
;	; fallthrough

ScrollTileUp:
	ld h, d
	ld l, e
	ld d, [hl]
	inc hl
	ld e, [hl]
	ld bc, $e
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
	ld de, $e
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
	ld hl, .frames
	ld a, [wTileAnimationTimer]
	and 7
	add a
	; hl += a
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld sp, hl
	ld l, e
	ld h, d
	jp WriteTile

.frames
	dw .frame1
	dw .frame2
	dw .frame3
	dw .frame4
	dw .frame3
	dw .frame4
	dw .frame5
	dw .frame1

.frame1 INCBIN "gfx/tilesets/fountain/1.2bpp"
.frame2 INCBIN "gfx/tilesets/fountain/2.2bpp"
.frame3 INCBIN "gfx/tilesets/fountain/3.2bpp"
.frame4 INCBIN "gfx/tilesets/fountain/4.2bpp"
.frame5 INCBIN "gfx/tilesets/fountain/5.2bpp"

AnimateWaterTile:
; Draw a water tile for the current frame in VRAM tile at de.

; Save sp in bc (see WriteTile).
	ld hl, sp+$0
	ld b, h
	ld c, l

	ld a, [wTileAnimationTimer]

; 4 tile graphics, updated every other frame.
	and %110

; 2 x 8 = 16 bytes per tile
	add a
	add a
	add a

	add LOW(WaterTileFrames)
	ld l, a
	adc HIGH(WaterTileFrames)
	sub l
	ld h, a

; wStack now points to the start of the tile for this frame.
	ld sp, hl

	ld l, e
	ld h, d

	jp WriteTile

WaterTileFrames:
	INCBIN "gfx/tilesets/water/johto_water.2bpp"

AnimateRainPuddleTile:
; Draw a rain puddle tile for the current frame in VRAM tile at de.

; Save sp in bc (see WriteTile).
	ld hl, sp+$0
	ld b, h
	ld c, l

	ld a, [wTileAnimationTimer]

; 8 tile graphics, updated every frame.
	and %111
	swap a

	add LOW(RainPuddleTileFrames)
	ld l, a
	adc HIGH(RainPuddleTileFrames)
	sub l
	ld h, a

; Stack now points to the start of the tile for this frame.
	ld sp, hl

	ld l, e
	ld h, d

	jp WriteTile

RainPuddleTileFrames:
	INCBIN "gfx/tilesets/rain/rain_puddle.2bpp"

AnimateRainWaterTile:
; Draw a rain water tile for the current frame in VRAM tile at de.

; Save sp in bc (see WriteTile).
	ld hl, sp+$0
	ld b, h
	ld c, l

	ld a, [wTileAnimationTimer]

; 8 tile graphics, updated every frame.
	and %111
	swap a

	add LOW(RainWaterTileFrames)
	ld l, a
	adc HIGH(RainWaterTileFrames)
	sub l
	ld h, a

; Stack now points to the start of the tile for this frame.
	ld sp, hl

	ld l, e
	ld h, d

	jp WriteTile

RainWaterTileFrames:
	INCBIN "gfx/tilesets/rain/rain_water.2bpp"

AnimateKantoWaterTile:
; Draw a Kanto water tile for the current frame in VRAM tile at de.

; Save sp in bc (see WriteTile).
	ld hl, sp+$0
	ld b, h
	ld c, l

	ld a, [wTileAnimationTimer]

; 4 tile graphics, updated every other frame.
	and 3 << 1

; 2 x 8 = 16 bytes per tile
	add a
	add a
	add a

	add LOW(KantoWaterTileFrames)
	ld l, a
	adc HIGH(KantoWaterTileFrames)
	sub l
	ld h, a

; wStack now points to the start of the tile for this frame.
	ld sp, hl

	ld l, e
	ld h, d

	jp WriteTile

KantoWaterTileFrames:
	INCBIN "gfx/tilesets/water/kanto_water.2bpp"

AnimateFarawayWaterTile:
; Draw a faraway water tile for the current frame in VRAM tile at de.

; Struct:
; 	VRAM address
;	Address of the first tile

; Only does one of 2 tiles at a time.

; Save sp in bc (see WriteTile).
	ld hl, sp+$0
	ld b, h
	ld c, l

; de = VRAM address
	ld l, e
	ld h, d
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
; Tile address is now at hl.

; Get the tile for this frame.
	ld a, [wTileAnimationTimer]
	and %111 ; 8 frames x2
	swap a  ; * 16 bytes per tile

	add [hl]
	inc hl
	ld h, [hl]
	ld l, a
	adc h
	sub l
	ld h, a

; wStack now points to the desired frame.
	ld sp, hl

	ld l, e
	ld h, d

	jp WriteTile

ForestTreeLeftAnimation:
; Only during the Celebi event.
	ld a, [wCelebiEvent]
	bit 2, a
	ret z

	ld hl, sp+$0
	ld b, h
	ld c, l
	ld a, [wTileAnimationTimer]
	call GetForestTreeFrame
	add a
	add a
	add a
	add LOW(ForestTreeLeftFrames)
	ld l, a
	adc HIGH(ForestTreeLeftFrames)
	sub l
	ld h, a
	ld sp, hl
	ld hl, vTiles2 tile $50
	jp WriteTile

ForestTreeRightAnimation:
; Only during the Celebi event.
	ld a, [wCelebiEvent]
	bit 2, a
	ret z

	ld hl, sp+$0
	ld b, h
	ld c, l
	ld a, [wTileAnimationTimer]
	call GetForestTreeFrame
	add a
	add a
	add a
	add LOW(ForestTreeLeftFrames)
	ld l, a
	adc HIGH(ForestTreeLeftFrames)
	sub l
	ld h, a
	push bc
	ld bc, ForestTreeRightFrames - ForestTreeLeftFrames
	add hl, bc
	pop bc
	ld sp, hl
	ld hl, vTiles2 tile $53
	jp WriteTile

ForestTreeLeftAnimation2:
; Only during the Celebi event.
	ld a, [wCelebiEvent]
	bit 2, a
	ret z

	ld hl, sp+$0
	ld b, h
	ld c, l
	ld a, [wTileAnimationTimer]
	call GetForestTreeFrame
	xor 2
	add a
	add a
	add a
	add LOW(ForestTreeLeftFrames)
	ld l, a
	adc HIGH(ForestTreeLeftFrames)
	sub l
	ld h, a
	ld sp, hl
	ld hl, vTiles2 tile $50
	jp WriteTile

ForestTreeRightAnimation2:
; Only during the Celebi event.
	ld a, [wCelebiEvent]
	bit 2, a
	ret z

	ld hl, sp+$0
	ld b, h
	ld c, l
	ld a, [wTileAnimationTimer]
	call GetForestTreeFrame
	xor 2
	add a
	add a
	add a
	add LOW(ForestTreeLeftFrames)
	ld l, a
	adc HIGH(ForestTreeLeftFrames)
	sub l
	ld h, a
	push bc
	ld bc, ForestTreeRightFrames - ForestTreeLeftFrames
	add hl, bc
	pop bc
	ld sp, hl
	ld hl, vTiles2 tile $53
	jp WriteTile

ForestTreeLeftFrames:
	INCBIN "gfx/tilesets/forest-tree/1.2bpp"
	INCBIN "gfx/tilesets/forest-tree/2.2bpp"
ForestTreeRightFrames:
	INCBIN "gfx/tilesets/forest-tree/3.2bpp"
	INCBIN "gfx/tilesets/forest-tree/4.2bpp"

ForestTree2LeftAnimation:
; Only during the Celebi event.
	ld a, [wCelebiEvent]
	bit 2, a
	ret z

	ld hl, sp+$0
	ld b, h
	ld c, l
	ld a, [wTileAnimationTimer]
	call GetForestTreeFrame
	add a
	add a
	add a
	add LOW(ForestTree2LeftFrames)
	ld l, a
	adc HIGH(ForestTree2LeftFrames)
	sub l
	ld h, a
	ld sp, hl
	ld hl, vTiles2 tile $5c
	jp WriteTile

ForestTree2RightAnimation:
; Only during the Celebi event.
	ld a, [wCelebiEvent]
	bit 2, a
	ret z

	ld hl, sp+$0
	ld b, h
	ld c, l
	ld a, [wTileAnimationTimer]
	call GetForestTreeFrame
	add a
	add a
	add a
	add LOW(ForestTree2LeftFrames)
	ld l, a
	adc HIGH(ForestTree2LeftFrames)
	sub l
	ld h, a
	push bc
	ld bc, ForestTree2RightFrames - ForestTree2LeftFrames
	add hl, bc
	pop bc
	ld sp, hl
	ld hl, vTiles2 tile $5f
	jp WriteTile

ForestTree2LeftAnimation2:
; Only during the Celebi event.
	ld a, [wCelebiEvent]
	bit 2, a
	ret z

	ld hl, sp+$0
	ld b, h
	ld c, l
	ld a, [wTileAnimationTimer]
	call GetForestTreeFrame
	xor 2
	add a
	add a
	add a
	add LOW(ForestTree2LeftFrames)
	ld l, a
	adc HIGH(ForestTree2LeftFrames)
	sub l
	ld h, a
	ld sp, hl
	ld hl, vTiles2 tile $5c
	jp WriteTile

ForestTree2RightAnimation2:
; Only during the Celebi event.
	ld a, [wCelebiEvent]
	bit 2, a
	ret z

	ld hl, sp+$0
	ld b, h
	ld c, l
	ld a, [wTileAnimationTimer]
	call GetForestTreeFrame
	xor 2
	add a
	add a
	add a
	add LOW(ForestTree2LeftFrames)
	ld l, a
	adc HIGH(ForestTree2LeftFrames)
	sub l
	ld h, a
	push bc
	ld bc, ForestTree2RightFrames - ForestTree2LeftFrames
	add hl, bc
	pop bc
	ld sp, hl
	ld hl, vTiles2 tile $5f
	jp WriteTile

ForestTree2LeftFrames:
	INCBIN "gfx/tilesets/forest-tree-2/1.2bpp"
	INCBIN "gfx/tilesets/forest-tree-2/2.2bpp"
ForestTree2RightFrames:
	INCBIN "gfx/tilesets/forest-tree-2/3.2bpp"
	INCBIN "gfx/tilesets/forest-tree-2/4.2bpp"

GetForestTreeFrame:
; Return 0 if a is even, or 2 if odd.
	and 1
	sla a
	ret

AnimateFlowerTile:
; No parameters.

; Save sp in bc (see WriteTile).
	ld hl, sp+$0
	ld b, h
	ld c, l

; Alternate tile graphic every other frame
	ld a, [wTileAnimationTimer]
	and %10
	srl a

	swap a ; << 4 (16 bytes)
	ld e, a
	ld d, 0
	ld hl, FlowerTileFrames
	add hl, de
	ld sp, hl

	ld hl, vTiles2 tile $03

	jp WriteTile

FlowerTileFrames:
	INCBIN "gfx/tilesets/flower/1.2bpp"
	INCBIN "gfx/tilesets/flower/2.2bpp"

AnimateKantoFlowerTile:
; No parameters.

; Save sp in bc (see WriteTile).
	ld hl, sp+$0
	ld b, h
	ld c, l

; Alternate tile graphic every other frame
	ld a, [wTileAnimationTimer]
	and %110
	srl a

	swap a ; << 4 (16 bytes)
	ld e, a
	ld d, 0
	ld hl, KantoFlowerTileFrames
	add hl, de
	ld sp, hl

	ld hl, vTiles2 tile $03

	jp WriteTile

KantoFlowerTileFrames:
	INCBIN "gfx/tilesets/kanto-flower/1.2bpp"
	INCBIN "gfx/tilesets/kanto-flower/2.2bpp"
	INCBIN "gfx/tilesets/kanto-flower/3.2bpp"
	INCBIN "gfx/tilesets/kanto-flower/1.2bpp"

LavaBubbleAnim1:
; Splash in the bottom-right corner of the fountain.
	ld hl, sp+$0
	ld b, h
	ld c, l
	ld a, [wTileAnimationTimer]
	and 6
	srl a
	inc a
	inc a
	and 3
	swap a
	ld e, a
	ld d, 0
	ld hl, LavaBubbleFrames
	add hl, de
	ld sp, hl
	ld hl, vTiles2 tile $5b
	jp WriteTile

LavaBubbleAnim2:
; Splash in the top-left corner of the fountain.
	ld hl, sp+$0
	ld b, h
	ld c, l
	ld a, [wTileAnimationTimer]
	and 6
	add a
	add a
	add a
	ld e, a
	ld d, 0
	ld hl, LavaBubbleFrames
	add hl, de
	ld sp, hl
	ld hl, vTiles2 tile $38
	jp WriteTile

LavaBubbleAnim3:
; Splash in the bottom-right corner of the fountain.
	ld hl, sp+$0
	ld b, h
	ld c, l
	ld a, [wTileAnimationTimer]
	and 6
	srl a
	inc a
	inc a
	and 3
	swap a
	ld e, a
	ld d, 0
	ld hl, LavaBubbleFrames
	add hl, de
	ld sp, hl
	ld hl, vTiles2 tile $3d
	jp WriteTile

LavaBubbleAnim4:
; Splash in the top-left corner of the fountain.
	ld hl, sp+$0
	ld b, h
	ld c, l
	ld a, [wTileAnimationTimer]
	and 6
	add a
	add a
	add a
	ld e, a
	ld d, 0
	ld hl, LavaBubbleFrames
	add hl, de
	ld sp, hl
	ld hl, vTiles2 tile $3c
	jp WriteTile

LavaBubbleFrames:
	INCBIN "gfx/tilesets/lava/1.2bpp"
	INCBIN "gfx/tilesets/lava/2.2bpp"
	INCBIN "gfx/tilesets/lava/3.2bpp"
	INCBIN "gfx/tilesets/lava/4.2bpp"

AnimateTowerPillarTile:
; Read from struct at de:
; 	Destination (VRAM)
;	Address of the first tile in the frame array

	ld hl, sp+$0
	ld b, h
	ld c, l

	ld a, [wTileAnimationTimer]
	and 7

; Get frame index a
	; a = [.frames + a]
	add LOW(.frames)
	ld l, a
	adc HIGH(.frames)
	sub l
	ld h, a
	ld a, [hl]

; Destination
	ld l, e
	ld h, d
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl

; Add the frame index to the starting address
	add [hl]
	inc hl
	ld h, [hl]
	ld l, a
	adc h
	sub l
	ld h, a

	ld sp, hl
	ld l, e
	ld h, d
	jp WriteTile

.frames
	db $00, $10, $20, $30, $40, $30, $20, $10

StandingTileFrame:
	ld hl, wTileAnimationTimer
	inc [hl]
	ret

AnimateWhirlpoolTile:
; Update whirlpool tile using struct at de.

; Struct:
; 	VRAM address
;	Address of the first tile

; Only does one of 4 tiles at a time.

; Save sp in bc (see WriteTile).
	ld hl, sp+$0
	ld b, h
	ld c, l

; de = VRAM address
	ld l, e
	ld h, d
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
; Tile address is now at hl.

; Get the tile for this frame.
	ld a, [wTileAnimationTimer]
	and %11 ; 4 frames x2
	swap a  ; * 16 bytes per tile

	add [hl]
	inc hl
	ld h, [hl]
	ld l, a
	adc h
	sub l
	ld h, a

; wStack now points to the desired frame.
	ld sp, hl

	ld l, e
	ld h, d

	jp WriteTile

AnimateLCDTile:
; No parameters.

; Save sp in bc (see WriteTile).
	ld hl, sp+$0
	ld b, h
	ld c, l

; Alternate tile graphic every frame
	ld a, [wTileAnimationTimer]
	and %111

	swap a ; << 4 (16 bytes)
	ld e, a
	ld d, 0
	ld hl, LCDTileFrames
	add hl, de
	ld sp, hl

	ld hl, vTiles2 tile $6f

	jp WriteTile

LCDTileFrames:
	INCBIN "gfx/tilesets/lcd/1.2bpp"
	INCBIN "gfx/tilesets/lcd/2.2bpp"
	INCBIN "gfx/tilesets/lcd/3.2bpp"
	INCBIN "gfx/tilesets/lcd/4.2bpp"
	INCBIN "gfx/tilesets/lcd/5.2bpp"
	INCBIN "gfx/tilesets/lcd/6.2bpp"
	INCBIN "gfx/tilesets/lcd/7.2bpp"
	INCBIN "gfx/tilesets/lcd/8.2bpp"

WriteTileFromBuffer:
; Write tiledata at wTileAnimBuffer to de.
; wTileAnimBuffer is loaded to sp for WriteTile.

	ld hl, sp+$0
	ld b, h
	ld c, l

	ld hl, wTileAnimBuffer
	ld sp, hl

	ld h, d
	ld l, e
	jr WriteTile

WriteTileToBuffer:
; Write tiledata de to wTileAnimBuffer.
; de is loaded to sp for WriteTile.

	ld hl, sp+$0
	ld b, h
	ld c, l

	ld h, d
	ld l, e
	ld sp, hl

	ld hl, wTileAnimBuffer

	; fallthrough

WriteTile:
; Write one 8x8 tile ($10 bytes) from sp to hl.

; Warning: sp is saved in bc so we can abuse pop.
; sp is restored to address bc. Save sp in bc before calling.

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

; restore sp
	ld h, b
	ld l, c
	ld sp, hl
	ret

FlickeringCaveEntrancePalette:
; We don't want to mess with non-standard palettes.
	ldh a, [rBGP]
	cp %11100100
	ret nz
; We only want to be here if we're in a dark cave.
	ld a, [wTimeOfDayPalset]
	cp DARKNESS_PALSET
	ret nz

	ldh a, [rSVBK]
	push af
	ld a, 5 ; wra5: gfx
	ldh [rSVBK], a
; Ready for BGPD input...
	ld a, %10100000 ; auto-increment, index $20 (pal 4 color 0)
	ldh [rBGPI], a
	ldh a, [hVBlankCounter]
	and %00000010
	jr nz, .bit1set
	ld hl, wBGPals1 palette PAL_BG_YELLOW
	jr .okay

.bit1set
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

LCDFrames: dw vTiles2 tile $6d, LCDTiles

LCDTiles:

FarawayWaterFrames1: dw vTiles2 tile $14, FarawayWaterTiles1
FarawayWaterFrames2: dw vTiles2 tile $15, FarawayWaterTiles2

FarawayWaterTiles1: INCBIN "gfx/tilesets/water/faraway_water_1.2bpp"
FarawayWaterTiles2: INCBIN "gfx/tilesets/water/faraway_water_2.2bpp"
