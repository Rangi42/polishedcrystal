_TypeChart:
	ldh a, [hInMenu]
	push af
	ld a, $1
	ldh [hInMenu], a

	ld a, [wVramState]
	push af
	xor a
	ld [wVramState], a

	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
	call DisableLCD

	ld hl, TypeChartPalettes
	ld de, wBGPals1
	ld bc, 12 palettes
	call FarCopyColorWRAM

	ld a, $1
	ldh [rVBK], a
	ld hl, TypeChartBG0GFX
	ld de, vTiles4
	lb bc, BANK(TypeChartBG0GFX), 255
	call DecompressRequest2bpp
	xor a
	ldh [rVBK], a

	ld hl, TypeChartBG1GFX
	ld de, vTiles2
	lb bc, BANK(TypeChartBG1GFX), 30
	call DecompressRequest2bpp

	ld hl, TypeChartOBGFX
	ld de, vTiles0
	lb bc, BANK(TypeChartOBGFX), 32
	call DecompressRequest2bpp

	call ClearSpriteAnims

	ld hl, TypeChartOAMData
	ld de, wVirtualOAM
	ld bc, 40 * 4
	rst CopyBytes

	ld a, 8
	call SkipMusic

	ld a, %11100111
	ldh [rLCDC], a

	xor a
	ldh [hBGMapMode], a

	ld hl, TypeChartTilemap
	decoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	rst CopyBytes

	ld hl, TypeChartAttrmap
	decoord 0, 0, wAttrMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	rst CopyBytes

	call ApplyAttrAndTilemapInVBlank

	call SetPalettes

	ld a, %11100100
	call DmgToCgbObjPal0

	call DelayFrame

.loop
	call JoyTextDelay
	ld hl, hJoyPressed
	ld a, [hl]
	and A_BUTTON | B_BUTTON
	jr nz, .done
	call DelayFrame
	jr .loop

.done
	ld a, %11100011
	ldh [rLCDC], a

	pop af
	ld [wVramState], a

	pop af
	ldh [hInMenu], a

	jmp ClearBGPalettes

TypeChartPalettes:
if !DEF(MONOCHROME)
; BG 0
	RGB 31, 31, 31
	RGB 27, 27, 27 ; off-white
	RGB 00, 19, 00 ; super effective (green)
	RGB 31, 00, 00 ; not very effective + ATK (red)
; BG 1
	RGB 31, 31, 31
	RGB 27, 27, 27 ; off-white
	RGB 21, 21, 14 ; NORMAL
	RGB 27, 04, 02 ; FIGHTING
; BG 2
	RGB 31, 31, 31
	RGB 29, 24, 12 ; GROUND
	RGB 22, 07, 19 ; POISON
	RGB 22, 17, 30 ; FLYING
; BG 3
	RGB 31, 31, 31
	RGB 29, 24, 12 ; GROUND
	RGB 24, 20, 07 ; ROCK
	RGB 21, 23, 06 ; BUG
; BG 4
	RGB 31, 31, 31
	RGB 11, 25, 11 ; GRASS
	RGB 11, 18, 30 ; WATER
	RGB 31, 15, 04 ; FIRE
; BG 5
	RGB 31, 31, 31
	RGB 11, 25, 11 ; GRASS
	RGB 31, 24, 06 ; ELECTRIC
	RGB 31, 09, 15 ; PSYCHIC
; BG 6
	RGB 31, 31, 31
	RGB 15, 07, 31 ; DRAGON
	RGB 16, 27, 27 ; ICE
	RGB 31, 09, 15 ; PSYCHIC
; BG 7
	RGB 31, 31, 31
	RGB 15, 07, 31 ; DRAGON
	RGB 15, 11, 09 ; DARK
	RGB 31, 20, 29 ; FAIRY
; OB 0
	RGB 31, 31, 31
	RGB 22, 22, 24 ; notebook rings (gray)
	RGB 20, 13, 06 ; notebook binding (brown)
	RGB 07, 07, 07 ; notebook border (black)
; OB 1
	RGB 31, 31, 31
	RGB 23, 23, 25 ; STEEL
	RGB 15, 11, 18 ; GHOST
	RGB 05, 06, 07 ; ineffective (black)
; OB 2
	RGB 31, 31, 31
	RGB 23, 23, 25 ; STEEL
	RGB 00, 19, 00 ; super effective (green)
	RGB 31, 00, 00 ; not very effective (red)
; OB 3
	RGB 31, 31, 31
	RGB 27, 27, 27 ; off-white
	RGB 31, 00, 31 ; unused
	RGB 00, 05, 31 ; DEF (blue)
else
endc

TypeChartBG0GFX:
INCBIN "gfx/type_chart/bg0.2bpp.lz"

TypeChartBG1GFX:
INCBIN "gfx/type_chart/bg.2bpp.vram2p.lz"

TypeChartOBGFX:
INCBIN "gfx/type_chart/ob.2bpp.lz"

TypeChartTilemap:
INCBIN "gfx/type_chart/type_chart.tilemap"

TypeChartAttrmap:
INCBIN "gfx/type_chart/type_chart.attrmap"

TypeChartOAMData:
oamdata: MACRO
	; x, y, tile id, attributes
	db (\2) + 16, (\1) + 8, (\3), (\4)
ENDM
	; binding
	oamdata   0,   0, $00, 0
	oamdata   0,  16, $00, 0
	oamdata   0,  32, $00, 0
	oamdata   0,  48, $00, 0
	oamdata   0,  64, $00, 0
	oamdata   0,  80, $00, 0
	oamdata   0,  96, $00, 0
	oamdata   0, 112, $00, 0
	oamdata   0, 128, $00, 0
	; DEF
	oamdata  16,   0, $02, 3
	oamdata  24,   0, $04, 3
	; top Ghost+Steel
	oamdata  82,   0, $06, 1
	oamdata  90,   0, $08, 1
	oamdata  82,  16, $0a, 1 ; Normal x0 Ghost, Fighting x0 Ghost
	oamdata  90,  16, $0c, 2 ; Normal x0.5 Steel
	; left Ghost+Steel
	oamdata   8,  66, $0e, 1
	oamdata  16,  66, $10, 1
	oamdata  24,  66, $12, 1
	oamdata  32,  66, $14, 1
	; ineffective
	oamdata  90,  31, $16, 1 ; Poison x0 Steel
	oamdata  48,  38, $16, 1 ; Ground x0 Flying
	oamdata  34,  59, $16, 1 ; Ghost x0 Normal
	oamdata  62,  94, $16, 1 ; Electric x0 Ground
	oamdata 146, 101, $16, 1 ; Psychic x0 Dark
	oamdata 153, 115, $16, 1 ; Dragon x0 Fairy
	; not very effective
	oamdata  69,  18, $18, 2 ; Normal x0.5 Rock
	; super effective
	oamdata 32,   25, $1a, 2 ; Fighting x2 Normal
	; top off-white
	oamdata  54,   8, $1c, 3 ; Normal x1 Poison
	oamdata  96,   8, $1c, 3 ; Normal x1 Fire
	oamdata 110,   8, $1c, 3 ; Normal x1 Grass
	oamdata 124,   8, $1c, 3 ; Normal x1 Psychic
	oamdata 138,   8, $1c, 3 ; Normal x1 Dragon
	oamdata 152,   8, $1c, 3 ; Normal x1 Fairy
	; left off-white
	oamdata  32,  30, $1e, 3 ; Poison x1 Normal
	oamdata  32,  44, $1e, 3 ; Rock x1 Normal
	oamdata  32,  72, $1e, 3 ; Fire x1 Normal
	oamdata  32,  86, $1e, 3 ; Grass x1 Normal
	oamdata  32, 100, $1e, 3 ; Psychic x1 Normal
	oamdata  32, 114, $1e, 3 ; Dragon x1 Normal
	oamdata  32, 128, $1e, 3 ; Fairy x1 Normal
