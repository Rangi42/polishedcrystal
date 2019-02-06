SwapTextboxPalettes::
	hlcoord 0, 0
	decoord 0, 0, wAttrMap
	ld b, SCREEN_HEIGHT
.loop
	push bc
	ld c, SCREEN_WIDTH
.innerloop
	ld a, [hl]
	push hl
	ld hl, wTilesetPalettes
	add [hl]
	ld l, a
	ld a, [wTilesetPalettes + 1]
	adc 0
	ld h, a
	ld a, [hl]
	pop hl
	ld [de], a
	res 7, [hl]
	inc hl
	inc de
	dec c
	jr nz, .innerloop
	pop bc
	dec b
	jr nz, .loop
	ret

ScrollBGMapPalettes::
	ld a, [wTilesetPalettes + 1]
	ld [hTilesetPalettesHigh], a
	ld a, [wTilesetPalettes]
	ld b, a
	ld hl, wBGMapBuffer
	ld de, wBGMapPalBuffer
	and a
.loop
	push de
	ld a, [hTilesetPalettesHigh]
	ld d, a
	ld a, [hl]
	add b
	ld e, a
	jr nc, .noCarry
	inc d
.noCarry
	ld a, [de]
	pop de
	res 7, [hl]
	ld [de], a
	inc hl
	inc de
	dec c
	jr nz, .loop
	ret

INCLUDE "data/tileset_palette_maps.asm"

INCLUDE "data/collision_permissions.asm"
