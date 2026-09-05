; hScriptVar: 0 = up/left to Mt. Moon, 1 = down/right to Route 4.
; Called after stepping onto the station warp, just like the Magnet Train.
; The caller reloads the destination map immediately after this returns.
Special_CableCar:
	ldh a, [hScriptVar]
	and a
	ld a, -1
	jr z, .direction
	ld a, 1
.direction
	ld [wCableCarDirection], a
	ldh a, [hVBlank]
	ld b, a
	ldh a, [hBGMapMode]
	ld c, a
	push bc
	ldh a, [hSCX]
	ld b, a
	ldh a, [hSCY]
	ld c, a
	push bc
	ldh a, [hWY]
	ld b, a
	ldh a, [hOAMUpdate]
	ld c, a
	push bc
	ldh a, [rWBK]
	push af
	ldh a, [rLCDC]
	push af
	call ClearBGPalettes
	call DisableLCD
	call ClearSprites
	xor a
	ldh [hBGMapMode], a
	ldh [hOAMUpdate], a
	ldh [rVBK], a
	; Keep the viewport inside the 256x256 hillside throughout the trip.
	ld a, [wCableCarDirection]
	inc a
	ld a, 64
	jr z, .scroll
	xor a
.scroll
	ldh [hSCX], a
	ldh [hSCY], a
	ld hl, CableCarBGGFX
	ld de, vTiles2
	ld bc, CableCarBGGFXEnd - CableCarBGGFX
	rst CopyBytes
	ld hl, CableCarGFX
	ld de, vTiles0 tile $10
	ld bc, 16 tiles
	rst CopyBytes
	ld hl, CableCarFrontGFX
	ld de, vTiles0 tile $20
	ld bc, 4 tiles
	rst CopyBytes
	ld hl, CableCarTilemap
	debgcoord 0, 0
	ld bc, TILEMAP_WIDTH * TILEMAP_HEIGHT
	rst CopyBytes
	ld a, 1
	ldh [rVBK], a
	ld hl, CableCarAttrmap
	debgcoord 0, 0
	ld bc, TILEMAP_WIDTH * TILEMAP_HEIGHT
	rst CopyBytes
	xor a
	ldh [rVBK], a
	ld a, SCREEN_HEIGHT_PX
	ldh [hWY], a
	ld a, 1
	ldh [hVBlank], a
	call EnableLCD
	; Use 8x8 sprites for the cabin and the player's two head tiles.
	ldh a, [rLCDC]
	res B_LCDC_OBJ_SIZE, a
	ldh [rLCDC], a
	farcall GetPlayerIcon
	ld hl, vTiles0
	ld c, 4
	call Request2bppInWRA6
	call CableCar_LoadPalettes
	ld de, MUSIC_MT_MOON_SQUARE
	call PlayMusic
	ld de, SFX_ELEVATOR
	call PlaySFX
	xor a
	ld [wCableCarFrame], a
.loop
	call CableCar_DrawSprites
	ld c, 2
	call DelayFrames
	ld a, [wCableCarFrame]
	and 3
	jr nz, .next
	ld a, [wCableCarDirection]
	ld b, a
	ldh a, [hSCX]
	add b
	ldh [hSCX], a
	ldh [hSCY], a
.next
	ld hl, wCableCarFrame
	inc [hl]
	jr nz, .loop
	call ClearBGPalettes
	call ClearSprites
	call DisableLCD
	pop af
	res B_LCDC_ENABLE, a
	ldh [rLCDC], a
	pop af
	ldh [rWBK], a
	pop bc
	ld a, b
	ldh [hWY], a
	ld a, c
	ldh [hOAMUpdate], a
	pop bc
	ld a, b
	ldh [hSCX], a
	ld a, c
	ldh [hSCY], a
	pop bc
	ld a, b
	ldh [hVBlank], a
	ld a, c
	ldh [hBGMapMode], a
	call EnableLCD
	ld de, SFX_ELEVATOR_END
	jmp PlaySFX

CableCar_DrawSprites:
	; 96 steps entering, 64 cruising, 96 leaving; two frames per step.
	ld a, [wCableCarFrame]
	cp 96
	jr c, .enter
	cp 160
	ld a, 0 ; no-optimize a = 0 (preserve carry from cp)
	jr c, .offset
	ld a, [wCableCarFrame]
	sub 160
	jr .offset
.enter
	sub 96
.offset
	ld b, a
	ld a, [wCableCarDirection]
	inc a
	ld a, b
	jr nz, .position
	cpl
	inc a
.position
	add 64
	ld c, a
	ld hl, wShadowOAM
	ld de, CableCarOAM
	ld b, (CableCarOAMEnd - CableCarOAM) / OBJ_SIZE
.sprite
	ld a, [de]
	inc de
	add c
	ld [hli], a
	ld a, [de]
	inc de
	add c
	ld [hli], a
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	inc de
	ld [hli], a
	dec b
	jr nz, .sprite
	ret

CableCarOAM:
	; OAM priority: window frame, rider, then cabin/glass behind the rider.
	; At most 2 frame + 2 head + 4 cabin sprites share a scanline (8 < 10).
	; Coordinates include the hardware's +16 Y / +8 X offsets.
	db 16 +  8, 8 +  8, $20, 0
	db 16 +  8, 8 + 16, $21, 0
	db 16 + 16, 8 +  8, $22, 0
	db 16 + 16, 8 + 16, $23, 0
	db 16 + 15, 8 +  8, $00, 1
	db 16 + 15, 8 + 16, $01, 1
for y, 4
for x, 4
	db 16 + y * 8, 8 + x * 8, $10 + y * 4 + x, 0
endr
endr
CableCarOAMEnd:
	assert (CableCarOAMEnd - CableCarOAM) / OBJ_SIZE == 22

CableCar_LoadPalettes:
	ldh a, [rWBK]
	push af
	ld a, BANK(wTimeOfDay)
	ldh [rWBK], a
	ld a, [wTimeOfDay]
	maskbits NUM_DAYTIMES
	cp NITE
	ld hl, CableCarPalettes
	jr nz, .day
	ld hl, CableCarNightPalettes
.day
	push hl
	ld a, BANK(wBGPals2)
	ldh [rWBK], a
	; Keep the player's current outfit palette from the departure station.
	ld hl, wOBPals1
	ld de, wOBPals2 palette 1
	ld bc, 1 palettes
	rst CopyBytes
	pop hl
	ld de, wBGPals2
	ld bc, 2 palettes
	rst CopyBytes
	ld hl, CableCarCabinPalette
	ld de, wOBPals2
	ld bc, 1 palettes
	rst CopyBytes
	pop af
	ldh [rWBK], a
	ld a, 1
	ldh [hCGBPalUpdate], a
	ret

CableCarPalettes:
	RGB 27, 31, 24, 15, 24, 10, 6, 16, 8, 2, 7, 6 ; trees
	RGB 31, 29, 22, 25, 21, 14, 17, 13, 9, 8, 7, 6 ; mountain
CableCarCabinPalette:
	INCLUDE "gfx/overworld/cable_car.pal"
CableCarNightPalettes:
	RGB 13, 17, 22, 8, 13, 15, 4, 9, 11, 2, 4, 8 ; trees
	RGB 18, 19, 24, 13, 13, 18, 9, 9, 14, 4, 4, 8 ; mountain

CableCarGFX:
	INCBIN "gfx/overworld/cable_car.2bpp"
	assert @ - CableCarGFX == 16 tiles
CableCarFrontGFX:
	INCBIN "gfx/overworld/cable_car_front.2bpp"
	assert @ - CableCarFrontGFX == 4 tiles
CableCarBGGFX:
	INCBIN "gfx/overworld/cable_car_bg.2bpp"
CableCarBGGFXEnd:
	assert CableCarBGGFXEnd - CableCarBGGFX <= 128 tiles
CableCarTilemap:
	INCBIN "gfx/overworld/cable_car_bg.tilemap"
	assert @ - CableCarTilemap == TILEMAP_WIDTH * TILEMAP_HEIGHT
CableCarAttrmap:
	INCBIN "gfx/overworld/cable_car_bg.attrmap"
	assert @ - CableCarAttrmap == TILEMAP_WIDTH * TILEMAP_HEIGHT
