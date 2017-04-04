
_AnimateTileset:: ; fc000
; Iterate over a given pointer array of
; animation functions (one per frame).

; Typically in wra1, vra0

	ld a, [TilesetAnim]
	ld e, a
	ld a, [TilesetAnim + 1]
	ld d, a

	ld a, [hTileAnimFrame]
	ld l, a
	inc a
	ld [hTileAnimFrame], a

	ld h, 0
rept 2
	add hl, hl
endr
	add hl, de

; 2-byte parameter
; All functions take input de.
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl

; Function address
	ld a, [hli]
	ld h, [hl]
	ld l, a

	jp [hl]
; fc01b


Tileset00Anim:
Tileset01Anim:
Tileset02Anim:
Tileset04Anim:
	dw VTiles2 tile $14, AnimateWaterTile
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  AnimateFlowerTile
	dw WhirlpoolFrames1, AnimateWhirlpoolTile
	dw WhirlpoolFrames2, AnimateWhirlpoolTile
	dw WhirlpoolFrames3, AnimateWhirlpoolTile
	dw WhirlpoolFrames4, AnimateWhirlpoolTile
	dw NULL,  WaitTileAnimation
	dw NULL,  StandingTileFrame8
	dw VTiles2 tile $40, WriteTileToBuffer
	dw NULL,  WaitTileAnimation
	dw wTileAnimBuffer, ScrollTileDown
	dw NULL,  WaitTileAnimation
	dw wTileAnimBuffer, ScrollTileDown
	dw NULL,  WaitTileAnimation
	dw wTileAnimBuffer, ScrollTileDown
	dw NULL,  WaitTileAnimation
	dw VTiles2 tile $40, WriteTileFromBuffer
	dw NULL,  DoneTileAnimation

Tileset03Anim:
	dw VTiles2 tile $14, AnimateKantoWaterTile
	dw NULL,  WaitTileAnimation
	dw VTiles2 tile $40, WriteTileToBuffer
	dw NULL,  WaitTileAnimation
	dw wTileAnimBuffer, ScrollTileDown
	dw NULL,  WaitTileAnimation
	dw wTileAnimBuffer, ScrollTileDown
	dw NULL,  WaitTileAnimation
	dw wTileAnimBuffer, ScrollTileDown
	dw NULL,  WaitTileAnimation
	dw VTiles2 tile $40, WriteTileFromBuffer
	dw NULL,  AnimateKantoFlowerTile
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  StandingTileFrame8
	dw NULL,  DoneTileAnimation

Tileset09Anim:
	dw VTiles2 tile $14, AnimateWaterTile
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  StandingTileFrame8
	dw NULL,  DoneTileAnimation

Tileset15Anim:
	dw NULL,  SafariFountainAnim2
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  SafariFountainAnim1
	dw NULL,  WaitTileAnimation
	dw NULL,  StandingTileFrame8
	dw NULL,  DoneTileAnimation

Tileset20Anim:
	dw VTiles2 tile $14, AnimateKantoWaterTile
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw VTiles2 tile $20, ScrollTileUp
	dw VTiles2 tile $21, ScrollTileDown
	dw VTiles2 tile $22, ScrollTileLeft
	dw VTiles2 tile $23, ScrollTileRight
	dw NULL,  WaitTileAnimation
	dw NULL,  AnimateKantoFlowerTile
	dw NULL,  WaitTileAnimation
	dw VTiles2 tile $20, ScrollTileUp
	dw VTiles2 tile $21, ScrollTileDown
	dw VTiles2 tile $22, ScrollTileLeft
	dw VTiles2 tile $23, ScrollTileRight
	dw NULL,  WaitTileAnimation
	dw NULL,  StandingTileFrame8
	dw NULL,  DoneTileAnimation

Tileset23Anim:
	dw SproutPillarTilePointer9,  AnimateSproutPillarTile
	dw SproutPillarTilePointer10, AnimateSproutPillarTile
	dw SproutPillarTilePointer7,  AnimateSproutPillarTile
	dw SproutPillarTilePointer8,  AnimateSproutPillarTile
	dw SproutPillarTilePointer5,  AnimateSproutPillarTile
	dw SproutPillarTilePointer6,  AnimateSproutPillarTile
	dw SproutPillarTilePointer3,  AnimateSproutPillarTile
	dw SproutPillarTilePointer4,  AnimateSproutPillarTile
	dw SproutPillarTilePointer1,  AnimateSproutPillarTile
	dw SproutPillarTilePointer2,  AnimateSproutPillarTile
	dw NULL,  StandingTileFrame
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  DoneTileAnimation

Tileset24Anim:
Tileset30Anim:
	dw NULL,  SafariFountainAnim4
	dw NULL,  WaitTileAnimation
	dw NULL,  SafariFountainAnim3
	dw NULL,  WaitTileAnimation
	dw NULL,  StandingTileFrame8
	dw VTiles2 tile $25, WriteTileToBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw wTileAnimBuffer, ScrollTileRightLeft
	dw VTiles2 tile $4a, ScrollTileUp
	dw VTiles2 tile $4b, ScrollTileDown
	dw VTiles2 tile $5a, ScrollTileLeft
	dw VTiles2 tile $5b, ScrollTileRight
	dw NULL,  FlickeringCaveEntrancePalette
	dw VTiles2 tile $25, WriteTileFromBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  WaitTileAnimation
	dw NULL,  FlickeringCaveEntrancePalette
	dw VTiles2 tile $26, WriteTileToBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw wTileAnimBuffer, ScrollTileDown
	dw NULL,  FlickeringCaveEntrancePalette
	dw wTileAnimBuffer, ScrollTileDown
	dw NULL,  FlickeringCaveEntrancePalette
	dw VTiles2 tile $4a, ScrollTileUp
	dw VTiles2 tile $4b, ScrollTileDown
	dw VTiles2 tile $5a, ScrollTileLeft
	dw VTiles2 tile $5b, ScrollTileRight
	dw wTileAnimBuffer, ScrollTileDown
	dw NULL,  FlickeringCaveEntrancePalette
	dw VTiles2 tile $26, WriteTileFromBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  DoneTileAnimation

Tileset25Anim:
	dw VTiles2 tile $14, AnimateWaterTile
	dw NULL,  WaitTileAnimation
	dw VTiles2 tile $15, AnimateFountain
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  AnimateFlowerTile
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  StandingTileFrame8
	dw NULL,  DoneTileAnimation

Tileset29Anim:
	dw VTiles2 tile $44, WriteTileToBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw wTileAnimBuffer, ScrollTileRightLeft
	dw NULL,  FlickeringCaveEntrancePalette
	dw VTiles2 tile $44, WriteTileFromBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  WaitTileAnimation
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  DoneTileAnimation

Tileset31Anim:
	dw NULL,  ForestTreeLeftAnimation
	dw NULL,  ForestTreeRightAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  ForestTreeLeftAnimation2
	dw NULL,  ForestTreeRightAnimation2
	dw NULL,  AnimateFlowerTile
	dw VTiles2 tile $14, AnimateWaterTile
	dw NULL,  WaitTileAnimation
	dw NULL,  StandingTileFrame8
	dw VTiles2 tile $40, WriteTileToBuffer
	dw NULL,  WaitTileAnimation
	dw wTileAnimBuffer, ScrollTileDown
	dw NULL,  WaitTileAnimation
	dw wTileAnimBuffer, ScrollTileDown
	dw NULL,  WaitTileAnimation
	dw wTileAnimBuffer, ScrollTileDown
	dw NULL,  WaitTileAnimation
	dw VTiles2 tile $40, WriteTileFromBuffer
	dw NULL,  DoneTileAnimation

Tileset32Anim:
	dw VTiles2 tile $14, AnimateKantoWaterTile
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  AnimateKantoFlowerTile
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  StandingTileFrame8
	dw NULL,  DoneTileAnimation

Tileset38Anim:
	dw FarawayWaterFrames1, AnimateFarawayWaterTile
	dw FarawayWaterFrames2, AnimateFarawayWaterTile
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  StandingTileFrame8
	dw NULL,  DoneTileAnimation

Tileset39Anim:
	dw VTiles2 tile $26, WriteTileToBuffer
	dw NULL,  WaitTileAnimation
	dw wTileAnimBuffer, ScrollTileRightLeft
	dw NULL,  WaitTileAnimation
	dw VTiles2 tile $26, WriteTileFromBuffer
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  StandingTileFrame8
	dw VTiles2 tile $30, WriteTileToBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  FlickeringCaveEntrancePalette
	dw VTiles2 tile $30, WriteTileFromBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  WaitTileAnimation
	dw NULL,  FlickeringCaveEntrancePalette
	dw VTiles2 tile $31, WriteTileToBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  FlickeringCaveEntrancePalette
	dw VTiles2 tile $31, WriteTileFromBuffer
	dw NULL,  FlickeringCaveEntrancePalette
	dw NULL,  DoneTileAnimation

Tileset41Anim:
	dw FarawayWaterFrames1, AnimateFarawayWaterTile
	dw FarawayWaterFrames2, AnimateFarawayWaterTile
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  AnimateFlowerTile
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  StandingTileFrame8
	dw NULL,  DoneTileAnimation

Tileset05Anim:
Tileset06Anim:
Tileset07Anim:
Tileset08Anim:
Tileset10Anim:
Tileset11Anim:
Tileset12Anim:
Tileset13Anim:
Tileset14Anim:
Tileset16Anim:
Tileset17Anim:
Tileset18Anim:
Tileset19Anim:
Tileset21Anim:
Tileset22Anim:
Tileset26Anim:
Tileset27Anim:
Tileset28Anim:
Tileset33Anim:
Tileset34Anim:
Tileset35Anim:
Tileset36Anim:
Tileset37Anim:
Tileset40Anim:
Tileset42Anim:
Tileset43Anim:
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  DoneTileAnimation


TilesetAnimfc0d7: ; 0xfc0d7
	dw VTiles2 tile $03, WriteTileToBuffer
	dw wTileAnimBuffer, ScrollTileRightLeft
	dw VTiles2 tile $03, WriteTileFromBuffer
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  AnimateFlowerTile
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  DoneTileAnimation
; 0xfc103

TilesetAnimfc103: ; 0xfc103
	dw VTiles2 tile $14, WriteTileToBuffer
	dw wTileAnimBuffer, ScrollTileRightLeft
	dw VTiles2 tile $14, WriteTileFromBuffer
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  DoneTileAnimation
; 0xfc12f

TilesetAnimfc17f: ; 0xfc17f
	dw VTiles2 tile $53, WriteTileToBuffer
	dw wTileAnimBuffer, ScrollTileDown
	dw wTileAnimBuffer, ScrollTileDown
	dw VTiles2 tile $53, WriteTileFromBuffer
	dw VTiles2 tile $03, WriteTileToBuffer
	dw wTileAnimBuffer, ScrollTileRightLeft
	dw VTiles2 tile $03, WriteTileFromBuffer
	dw VTiles2 tile $53, WriteTileToBuffer
	dw wTileAnimBuffer, ScrollTileDown
	dw wTileAnimBuffer, ScrollTileDown
	dw VTiles2 tile $53, WriteTileFromBuffer
	dw NULL,  DoneTileAnimation
; 0xfc1af

TilesetAnimfc1af: ; 0xfc1af
	dw VTiles2 tile $54, WriteTileToBuffer
	dw wTileAnimBuffer, ScrollTileDown
	dw wTileAnimBuffer, ScrollTileDown
	dw VTiles2 tile $54, WriteTileFromBuffer
	dw NULL,  WaitTileAnimation
	dw VTiles2 tile $03, WriteTileToBuffer
	dw wTileAnimBuffer, ScrollTileRightLeft
	dw VTiles2 tile $03, WriteTileFromBuffer
	dw NULL,  WaitTileAnimation
	dw VTiles2 tile $54, WriteTileToBuffer
	dw wTileAnimBuffer, ScrollTileDown
	dw wTileAnimBuffer, ScrollTileDown
	dw VTiles2 tile $54, WriteTileFromBuffer
	dw NULL,  DoneTileAnimation
; 0xfc1e7

TilesetAnimfc2bf: ; 0xfc2bf
	dw VTiles2 tile $4f, WriteTileToBuffer
	dw wTileAnimBuffer, ScrollTileRightLeft
	dw VTiles2 tile $4f, WriteTileFromBuffer
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  WaitTileAnimation
	dw NULL,  DoneTileAnimation
; 0xfc2e7


DoneTileAnimation: ; fc2fb
; Reset the animation command loop.
	xor a
	ld [hTileAnimFrame], a

WaitTileAnimation: ; fc2fe
; Do nothing this frame.
	ret
; fc2ff

StandingTileFrame8: ; fc2ff
	ld a, [TileAnimationTimer]
	inc a
	and a, 7
	ld [TileAnimationTimer], a
	ret
; fc309


ScrollTileRightLeft: ; fc309
; Scroll right for 4 ticks, then left for 4 ticks.
	ld a, [TileAnimationTimer]
	inc a
	and 7
	ld [TileAnimationTimer], a
	and 4
	jr nz, ScrollTileLeft
	jr ScrollTileRight
; fc318

ScrollTileUpDown: ; fc318
; Scroll up for 4 ticks, then down for 4 ticks.
	ld a, [TileAnimationTimer]
	inc a
	and 7
	ld [TileAnimationTimer], a
	and 4
	jr nz, ScrollTileDown
	jr ScrollTileUp
; fc327

ScrollTileLeft: ; fc327
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
; fc33b

ScrollTileRight: ; fc33b
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
; fc34f

ScrollTileUp: ; fc34f
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
; fc36a

ScrollTileDown: ; fc36a
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
; fc387


AnimateFountain: ; fc387
	ld hl, [sp+0]
	ld b, h
	ld c, l
	ld hl, .frames
	ld a, [TileAnimationTimer]
	and 7
	add a
	add l
	ld l, a
	jr nc, .okay
	inc h
.okay
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
; fc402


AnimateWaterTile: ; fc402
; Draw a water tile for the current frame in VRAM tile at de.

; Save sp in bc (see WriteTile).
	ld hl, [sp+0]
	ld b, h
	ld c, l

	ld a, [TileAnimationTimer]

; 4 tile graphics, updated every other frame.
	and 3 << 1

; 2 x 8 = 16 bytes per tile
rept 3
	add a
endr

	add WaterTileFrames % $100
	ld l, a
	ld a, 0 ; not xor a; preserve carry flag?
	adc WaterTileFrames / $100
	ld h, a

; Stack now points to the start of the tile for this frame.
	ld sp, hl

	ld l, e
	ld h, d

	jp WriteTile
; fc41c

WaterTileFrames: ; fc41c
	INCBIN "gfx/tilesets/water/johto_water.2bpp"
; fc45c


AnimateKantoWaterTile:
; Draw a Kanto water tile for the current frame in VRAM tile at de.

; Save sp in bc (see WriteTile).
	ld hl, [sp+0]
	ld b, h
	ld c, l

	ld a, [TileAnimationTimer]

; 4 tile graphics, updated every other frame.
	and 3 << 1

; 2 x 8 = 16 bytes per tile
rept 3
	add a
endr

	add KantoWaterTileFrames % $100
	ld l, a
	ld a, 0 ; not xor a; preserve carry flag?
	adc KantoWaterTileFrames / $100
	ld h, a

; Stack now points to the start of the tile for this frame.
	ld sp, hl

	ld l, e
	ld h, d

	jp WriteTile
; fc41c

KantoWaterTileFrames:
	INCBIN "gfx/tilesets/water/kanto_water.2bpp"


AnimateFarawayWaterTile:
; Draw a faraway water tile for the current frame in VRAM tile at de.

; Struct:
; 	VRAM address
;	Address of the first tile

; Only does one of 2 tiles at a time.

; Save sp in bc (see WriteTile).
	ld hl, [sp+0]
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
	ld a, [TileAnimationTimer]
	and %111 ; 8 frames x2
	swap a  ; * 16 bytes per tile

	add [hl]
	inc hl
	ld h, [hl]
	ld l, a
	ld a, 0 ; not xor a; preserve carry flag?
	adc h
	ld h, a

; Stack now points to the desired frame.
	ld sp, hl

	ld l, e
	ld h, d

	jp WriteTile


ForestTreeLeftAnimation: ; fc45c
	ld hl, [sp+0]
	ld b, h
	ld c, l

; Only during the Celebi event.
	ld a, [wCelebiEvent]
	bit 2, a
	jr nz, .asm_fc46c
	ld hl, ForestTreeLeftFrames
	jr .asm_fc47d

.asm_fc46c
	ld a, [TileAnimationTimer]
	call GetForestTreeFrame
rept 3
	add a
endr
	add ForestTreeLeftFrames % $100
	ld l, a
	ld a, 0 ; not xor a; preserve carry flag?
	adc ForestTreeLeftFrames / $100
	ld h, a

.asm_fc47d
	ld sp, hl
	ld hl, VTiles2 tile $05
	jp WriteTile
; fc484


ForestTreeLeftFrames: ; fc484
	INCBIN "gfx/tilesets/forest-tree/1.2bpp"
	INCBIN "gfx/tilesets/forest-tree/2.2bpp"
; fc4a4

ForestTreeRightFrames: ; fc4a4
	INCBIN "gfx/tilesets/forest-tree/3.2bpp"
	INCBIN "gfx/tilesets/forest-tree/4.2bpp"
; fc4c4


ForestTreeRightAnimation: ; fc4c4
	ld hl, [sp+0]
	ld b, h
	ld c, l

; Only during the Celebi event.
	ld a, [wCelebiEvent]
	bit 2, a
	jr nz, .asm_fc4d4
	ld hl, ForestTreeRightFrames
	jr .asm_fc4eb

.asm_fc4d4
	ld a, [TileAnimationTimer]
	call GetForestTreeFrame
rept 3
	add a
endr
	add ForestTreeLeftFrames % $100
	ld l, a
	ld a, 0 ; not xor a; preserve carry flag?
	adc ForestTreeLeftFrames / $100
	ld h, a
	push bc
	ld bc, ForestTreeRightFrames - ForestTreeLeftFrames
	add hl, bc
	pop bc

.asm_fc4eb
	ld sp, hl
	ld hl, VTiles2 tile $06
	jp WriteTile
; fc4f2


ForestTreeLeftAnimation2: ; fc4f2
	ld hl, [sp+0]
	ld b, h
	ld c, l

; Only during the Celebi event.
	ld a, [wCelebiEvent]
	bit 2, a
	jr nz, .asm_fc502
	ld hl, ForestTreeLeftFrames
	jr .asm_fc515

.asm_fc502
	ld a, [TileAnimationTimer]
	call GetForestTreeFrame
	xor 2
rept 3
	add a
endr
	add ForestTreeLeftFrames % $100
	ld l, a
	ld a, 0 ; not xor a; preserve carry flag?
	adc ForestTreeLeftFrames / $100
	ld h, a

.asm_fc515
	ld sp, hl
	ld hl, VTiles2 tile $05
	jp WriteTile
; fc51c


ForestTreeRightAnimation2: ; fc51c
	ld hl, [sp+0]
	ld b, h
	ld c, l

; Only during the Celebi event.
	ld a, [wCelebiEvent]
	bit 2, a
	jr nz, .asm_fc52c
	ld hl, ForestTreeRightFrames
	jr .asm_fc545

.asm_fc52c
	ld a, [TileAnimationTimer]
	call GetForestTreeFrame
	xor 2
rept 3
	add a
endr
	add ForestTreeLeftFrames % $100
	ld l, a
	ld a, 0 ; not xor a; preserve carry flag?
	adc ForestTreeLeftFrames / $100
	ld h, a
	push bc
	ld bc, ForestTreeRightFrames - ForestTreeLeftFrames
	add hl, bc
	pop bc

.asm_fc545
	ld sp, hl
	ld hl, VTiles2 tile $06
	jp WriteTile
; fc54c


GetForestTreeFrame: ; fc54c
; Return 0 if a is even, or 2 if odd.
	and 1
	sla a
	ret
; fc56d


AnimateFlowerTile: ; fc56d
; No parameters.

; Save sp in bc (see WriteTile).
	ld hl, [sp+0]
	ld b, h
	ld c, l

; Alternate tile graphic every other frame
	ld a, [TileAnimationTimer]
	and %10
	srl a

	swap a ; << 4 (16 bytes)
	ld e, a
	ld d, 0
	ld hl, FlowerTileFrames
	add hl, de
	ld sp, hl

	ld hl, VTiles2 + $30 ; tile 4

	jp WriteTile
; fc58c

FlowerTileFrames: ; fc58c
	INCBIN "gfx/tilesets/flower/1.2bpp"
	INCBIN "gfx/tilesets/flower/2.2bpp"
; fc5cc


AnimateKantoFlowerTile:
; No parameters.

; Save sp in bc (see WriteTile).
	ld hl, [sp+0]
	ld b, h
	ld c, l

; Alternate tile graphic every other frame
	ld a, [TileAnimationTimer]
	and %110
	srl a

	swap a ; << 4 (16 bytes)
	ld e, a
	ld d, 0
	ld hl, KantoFlowerTileFrames
	add hl, de
	ld sp, hl

	ld hl, VTiles2 + $30 ; tile 4

	jp WriteTile

KantoFlowerTileFrames:
	INCBIN "gfx/tilesets/kanto-flower/1.2bpp"
	INCBIN "gfx/tilesets/kanto-flower/2.2bpp"
	INCBIN "gfx/tilesets/kanto-flower/3.2bpp"
	INCBIN "gfx/tilesets/kanto-flower/1.2bpp"


SafariFountainAnim1: ; fc5cc
; Splash in the bottom-right corner of the fountain.
	ld hl, [sp+0]
	ld b, h
	ld c, l
	ld a, [TileAnimationTimer]
	and 6
	srl a
rept 2
	inc a
endr
	and 3
	swap a
	ld e, a
	ld d, 0
	ld hl, SafariFountainFrames
	add hl, de
	ld sp, hl
	ld hl, VTiles2 tile $5b
	jp WriteTile
; fc5eb


SafariFountainAnim2: ; fc5eb
; Splash in the top-left corner of the fountain.
	ld hl, [sp+0]
	ld b, h
	ld c, l
	ld a, [TileAnimationTimer]
	and 6
rept 3
	add a
endr
	ld e, a
	ld d, 0
	ld hl, SafariFountainFrames
	add hl, de
	ld sp, hl
	ld hl, VTiles2 tile $38
	jp WriteTile
; fc605


SafariFountainAnim3:
; Splash in the bottom-right corner of the fountain.
	ld hl, [sp+0]
	ld b, h
	ld c, l
	ld a, [TileAnimationTimer]
	and 6
	srl a
rept 2
	inc a
endr
	and 3
	swap a
	ld e, a
	ld d, 0
	ld hl, SafariFountainFrames
	add hl, de
	ld sp, hl
	ld hl, VTiles2 tile $3d
	jp WriteTile


SafariFountainAnim4:
; Splash in the top-left corner of the fountain.
	ld hl, [sp+0]
	ld b, h
	ld c, l
	ld a, [TileAnimationTimer]
	and 6
rept 3
	add a
endr
	ld e, a
	ld d, 0
	ld hl, SafariFountainFrames
	add hl, de
	ld sp, hl
	ld hl, VTiles2 tile $3c
	jp WriteTile


SafariFountainFrames: ; fc605
	INCBIN "gfx/tilesets/safari/1.2bpp"
	INCBIN "gfx/tilesets/safari/2.2bpp"
	INCBIN "gfx/tilesets/safari/3.2bpp"
	INCBIN "gfx/tilesets/safari/4.2bpp"
; fc645


AnimateSproutPillarTile: ; fc645
; Read from struct at de:
; 	Destination (VRAM)
;	Address of the first tile in the frame array

	ld hl, [sp+0]
	ld b, h
	ld c, l

	ld a, [TileAnimationTimer]
	and 7

; Get frame index a
	ld hl, .frames
	add l
	ld l, a
	ld a, 0 ; not xor a; preserve carry flag?
	adc h
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
	ld a, 0 ; not xor a; preserve carry flag?
	adc h
	ld h, a

	ld sp, hl
	ld l, e
	ld h, d
	jr WriteTile

.frames
	db $00, $10, $20, $30, $40, $30, $20, $10
; fc673


StandingTileFrame: ; fc673
	ld hl, TileAnimationTimer
	inc [hl]
	ret
; fc678


AnimateWhirlpoolTile: ; fc678
; Update whirlpool tile using struct at de.

; Struct:
; 	VRAM address
;	Address of the first tile

; Only does one of 4 tiles at a time.

; Save sp in bc (see WriteTile).
	ld hl, [sp+0]
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
	ld a, [TileAnimationTimer]
	and %11 ; 4 frames x2
	swap a  ; * 16 bytes per tile

	add [hl]
	inc hl
	ld h, [hl]
	ld l, a
	ld a, 0 ; not xor a; preserve carry flag?
	adc h
	ld h, a

; Stack now points to the desired frame.
	ld sp, hl

	ld l, e
	ld h, d

	jr WriteTile
; fc696


WriteTileFromBuffer: ; fc696
; Write tiledata at wTileAnimBuffer to de.
; wTileAnimBuffer is loaded to sp for WriteTile.

	ld hl, [sp+0]
	ld b, h
	ld c, l

	ld hl, wTileAnimBuffer
	ld sp, hl

	ld h, d
	ld l, e
	jr WriteTile
; fc6a2


WriteTileToBuffer: ; fc6a2
; Write tiledata de to wTileAnimBuffer.
; de is loaded to sp for WriteTile.

	ld hl, [sp+0]
	ld b, h
	ld c, l

	ld h, d
	ld l, e
	ld sp, hl

	ld hl, wTileAnimBuffer

	; fallthrough

WriteTile: ; fc6ac
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
; fc6d7


FlickeringCaveEntrancePalette: ; fc71e
; We don't want to mess with non-standard palettes.
	ld a, [rBGP]
	cp %11100100
	ret nz
; We only want to be here if we're in a dark cave.
	ld a, [wTimeOfDayPalset]
	cp $ff ; 3,3,3,3
	ret nz

	ld a, [rSVBK]
	push af
	ld a, 5 ; wra5: gfx
	ld [rSVBK], a
; Ready for BGPD input...
	ld a, %10100000 ; auto-increment, index $20 (pal 4 color 0)
	ld [rBGPI], a
	ld a, [hVBlankCounter]
	and %00000010
	jr nz, .bit1set
	ld hl, UnknBGPals + 4 palettes
	jr .okay

.bit1set
	ld hl, UnknBGPals + 4 palettes + 2

.okay
	ld a, [hli]
	ld [rBGPD], a
	ld a, [hli]
	ld [rBGPD], a

	pop af
	ld [rSVBK], a
	ret
; fc750


SproutPillarTilePointer1:  dw VTiles2 tile $2d, SproutPillarTile1
SproutPillarTilePointer2:  dw VTiles2 tile $2f, SproutPillarTile2
SproutPillarTilePointer3:  dw VTiles2 tile $3d, SproutPillarTile3
SproutPillarTilePointer4:  dw VTiles2 tile $3f, SproutPillarTile4
SproutPillarTilePointer5:  dw VTiles2 tile $3c, SproutPillarTile5
SproutPillarTilePointer6:  dw VTiles2 tile $2c, SproutPillarTile6
SproutPillarTilePointer7:  dw VTiles2 tile $4d, SproutPillarTile7
SproutPillarTilePointer8:  dw VTiles2 tile $4f, SproutPillarTile8
SproutPillarTilePointer9:  dw VTiles2 tile $5d, SproutPillarTile9
SproutPillarTilePointer10: dw VTiles2 tile $5f, SproutPillarTile10

SproutPillarTile1:  INCBIN "gfx/tilesets/sprout-pillar/1.2bpp"
SproutPillarTile2:  INCBIN "gfx/tilesets/sprout-pillar/2.2bpp"
SproutPillarTile3:  INCBIN "gfx/tilesets/sprout-pillar/3.2bpp"
SproutPillarTile4:  INCBIN "gfx/tilesets/sprout-pillar/4.2bpp"
SproutPillarTile5:  INCBIN "gfx/tilesets/sprout-pillar/5.2bpp"
SproutPillarTile6:  INCBIN "gfx/tilesets/sprout-pillar/6.2bpp"
SproutPillarTile7:  INCBIN "gfx/tilesets/sprout-pillar/7.2bpp"
SproutPillarTile8:  INCBIN "gfx/tilesets/sprout-pillar/8.2bpp"
SproutPillarTile9:  INCBIN "gfx/tilesets/sprout-pillar/9.2bpp"
SproutPillarTile10: INCBIN "gfx/tilesets/sprout-pillar/10.2bpp"
; fca98


WhirlpoolFrames1: dw VTiles2 tile $32, WhirlpoolTiles1
WhirlpoolFrames2: dw VTiles2 tile $33, WhirlpoolTiles2
WhirlpoolFrames3: dw VTiles2 tile $42, WhirlpoolTiles3
WhirlpoolFrames4: dw VTiles2 tile $43, WhirlpoolTiles4
; fcaa8

WhirlpoolTiles1: INCBIN "gfx/tilesets/whirlpool/1.2bpp"
WhirlpoolTiles2: INCBIN "gfx/tilesets/whirlpool/2.2bpp"
WhirlpoolTiles3: INCBIN "gfx/tilesets/whirlpool/3.2bpp"
WhirlpoolTiles4: INCBIN "gfx/tilesets/whirlpool/4.2bpp"
; fcba8


FarawayWaterFrames1: dw VTiles2 tile $14, FarawayWaterTiles1
FarawayWaterFrames2: dw VTiles2 tile $59, FarawayWaterTiles2

FarawayWaterTiles1: INCBIN "gfx/tilesets/water/faraway_water_1.2bpp"
FarawayWaterTiles2: INCBIN "gfx/tilesets/water/faraway_water_2.2bpp"
