FontNormal:
INCBIN "gfx/font/normal.1bpp"
FontNarrow:
INCBIN "gfx/font/narrow.1bpp"
FontBold:
INCBIN "gfx/font/bold.1bpp"
FontItalic:
INCBIN "gfx/font/italic.1bpp"
FontSerif:
INCBIN "gfx/font/serif.1bpp"
FontUnown:
INCBIN "gfx/font/unown.1bpp"

Frames: ; f8800
INCBIN "gfx/frames/1.1bpp"
INCBIN "gfx/frames/2.1bpp"
INCBIN "gfx/frames/3.1bpp"
INCBIN "gfx/frames/4.1bpp"
INCBIN "gfx/frames/5.1bpp"
INCBIN "gfx/frames/6.1bpp"
INCBIN "gfx/frames/7.1bpp"
INCBIN "gfx/frames/8.1bpp"
INCBIN "gfx/frames/9.1bpp"
; f89b0

; Various misc graphics here.

BarsGFX:
INCBIN "gfx/battle/bars.2bpp"

BattleExtrasGFX:
INCBIN "gfx/battle/extras.2bpp"

GFX_Stats: ; f89b0
INCBIN "gfx/misc/stats.2bpp"
; f8ac0

StatusIconGFX:
INCBIN "gfx/battle/status.2bpp"

EnemyStatusIconGFX:
INCBIN "gfx/battle/status-enemy.2bpp"

TypeIconGFX:
INCBIN "gfx/battle/types.2bpp"

CategoryIconGFX:
INCBIN "gfx/battle/categories.2bpp"

TownMapGFX: ; f8ba0
INCBIN "gfx/misc/town_map.2bpp.lz"
; f8ea4

JohtoKantoGFX:
INCBIN "gfx/misc/johto-kanto.2bpp"

TextBoxSpaceGFX: ; f9204
INCBIN "gfx/frames/space.1bpp"
; Duplicate graphic (eight 00 bytes) fixes sprite animation bug introduced by
; 6103314190c1a3b87be8a5b8b9d90789c3006755
INCBIN "gfx/frames/space.1bpp"
; f9214

MapEntryFrameGFX: ; f9344
INCBIN "gfx/frames/map_entry_sign.2bpp"
; f9424

_LoadStandardFont:: ; fb449
	call LoadStandardFontPointer
	ld d, h
	ld e, l
	ld hl, VTiles1
	lb bc, BANK(FontNormal), $80
	ld a, [rLCDC]
	bit 7, a
	jp z, Copy1bpp

	call LoadStandardFontPointer
	ld d, h
	ld e, l
	ld hl, VTiles1
	lb bc, BANK(FontNormal), $20
	call Get1bpp_2
	call LoadStandardFontPointer
	ld de, $20 * LEN_1BPP_TILE
	add hl, de
	ld d, h
	ld e, l
	ld hl, VTiles1 tile $20
	lb bc, BANK(FontNormal), $20
	call Get1bpp_2
	call LoadStandardFontPointer
	ld de, $40 * LEN_1BPP_TILE
	add hl, de
	ld d, h
	ld e, l
	ld hl, VTiles1 tile $40
	lb bc, BANK(FontNormal), $20
	call Get1bpp_2
	call LoadStandardFontPointer
	ld de, $60 * LEN_1BPP_TILE
	add hl, de
	ld d, h
	ld e, l
	ld hl, VTiles1 tile $60
	lb bc, BANK(FontNormal), $20
	call Get1bpp_2
	ret
; fb48a

LoadStandardFontPointer::
	ld hl, .PopupFontPointers
	ld a, [Options2]
	and FONT_MASK
	ld d, 0
	ld e, a
rept 2
	add hl, de
endr
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld h, d
	ld l, e
	ret

.PopupFontPointers:
	dw FontNormal
	dw FontNarrow
	dw FontBold
	dw FontItalic
	dw FontSerif
	dw FontUnown
	dw FontNormal
	dw FontNormal

_LoadFontsBattleExtra:: ; fb4be
	ld de, BattleExtrasGFX
	ld hl, VTiles2 tile $55
	lb bc, BANK(BattleExtrasGFX), 2
	call Get2bpp_2
	ld de, BarsGFX
	ld hl, VTiles2 tile $61
	lb bc, BANK(BarsGFX), 24
	call Get2bpp_2
; fb4cc

LoadFrame:: ; fb4cc
	ld a, [TextBoxFrame]
	ld bc, TILES_PER_FRAME * LEN_1BPP_TILE
	ld hl, Frames
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, VTiles2 tile $79
	lb bc, BANK(Frames), TILES_PER_FRAME
	call Get1bpp_2
	ld hl, VTiles2 tile $7f
	ld de, TextBoxSpaceGFX
	lb bc, BANK(TextBoxSpaceGFX), 1
	call Get1bpp_2
	ret
; fb4f2

LoadBattleFontsHPBar: ; fb4f2
	call _LoadFontsBattleExtra

LoadStatusIcons: ; fb50d
	call LoadPlayerStatusIcon
	call LoadEnemyStatusIcon
	call InstantReloadPaletteHack
	ret
; fb53e

LoadPlayerStatusIcon:
	push de
	ld a, [PlayerSubStatus2]
	ld de, BattleMonStatus
	farcall GetStatusConditionIndex
	ld a, b
	ld hl, StatusIconGFX
	ld de, 2 tiles
.loop
	and a
	jr z, .done
	add hl, de
	dec a
	jr .loop
.done
	ld d, h
	ld e, l
	ld hl, VTiles2 tile $57
	lb bc, BANK(StatusIconGFX), 2
	call Request2bpp
	farcall LoadPlayerStatusIconPalette
	pop de
	ret

LoadEnemyStatusIcon:
	push de
	ld a, [EnemySubStatus2]
	ld de, EnemyMonStatus
	farcall GetStatusConditionIndex
	ld a, b
	ld hl, EnemyStatusIconGFX
	ld de, 2 tiles
.loop
	and a
	jr z, .done
	add hl, de
	dec a
	jr .loop
.done
	ld d, h
	ld e, l
	ld hl, VTiles2 tile $59
	lb bc, BANK(EnemyStatusIconGFX), 2
	call Request2bpp
	farcall LoadEnemyStatusIconPalette
	pop de
	ret

InstantReloadPaletteHack:
; Hack to make the palette load instantly
	ld a, [rSVBK]
	push af
	push de
	ld a, $5 ; gfx
	ld [rSVBK], a
; copy & reorder bg pal buffer
	ld hl, BGPals + 5 palettes ; to
	ld de, UnknBGPals + 5 palettes ; from
; order
	ld a, [rBGP]
	ld b, a
; 1 pal
	ld c, 1
	call CopyPals
; request pal update
	ld a, 1
	ld [hCGBPalUpdate], a
	pop de
	pop af
	ld [rSVBK], a
	ret

LoadStatsScreenGFX: ; fb53e
	call _LoadFontsBattleExtra

LoadStatsGFX: ; fb571
	ld de, GFX_Stats
	ld hl, VTiles2 tile $31
	lb bc, BANK(GFX_Stats), 14
	call Get2bpp_2
	ret
; fb57e
