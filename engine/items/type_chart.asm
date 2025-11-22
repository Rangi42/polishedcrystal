_TypeChart:
	ldh a, [hInMenu]
	push af
	ld a, $1
	ldh [hInMenu], a

	ld a, [wStateFlags]
	push af
	xor a
	ld [wStateFlags], a

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
	ld de, wShadowOAM
	ld bc, 40 * 4
	rst CopyBytes

	ld a, 8
	call SkipMusic

	ld a, LCDC_ON | LCDC_WIN_9C00 | LCDC_WIN_ON | LCDC_BLOCK21 | LCDC_BG_9800 | LCDC_OBJ_16 | LCDC_OBJ_ON | LCDC_PRIO_ON
	ldh [rLCDC], a

	xor a
	ldh [hBGMapMode], a

	ld hl, TypeChartTilemap
	decoord 0, 0
	call Decompress

	ld hl, TypeChartAttrmap
	decoord 0, 0, wAttrmap
	call Decompress

	call ApplyAttrAndTilemapInVBlank

	call SetDefaultBGPAndOBP

	ld a, %11100100
	call DmgToCgbObjPal0

	call DelayFrame

.loop
	call JoyTextDelay
	ld hl, hJoyPressed
	ld a, [hl]
	and PAD_A | PAD_B
	jr nz, .done
	call DelayFrame
	jr .loop

.done
	ld a, LCDC_DEFAULT
	ldh [rLCDC], a

	pop af
	ld [wStateFlags], a

	pop af
	ldh [hInMenu], a

	jmp ClearBGPalettes

TypeChartPalettes:
INCLUDE "gfx/type_chart/type_chart.pal"

TypeChartBG0GFX:
INCBIN "gfx/type_chart/bg0.2bpp.lz"

TypeChartBG1GFX:
INCBIN "gfx/type_chart/bg.2bpp.vram2p.lz"

TypeChartOBGFX:
INCBIN "gfx/type_chart/ob.2bpp.lz"

TypeChartTilemap:
INCBIN "gfx/type_chart/type_chart.tilemap.lz"

TypeChartAttrmap:
INCBIN "gfx/type_chart/type_chart.attrmap.lz"

TypeChartOAMData:
MACRO oamdata
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
