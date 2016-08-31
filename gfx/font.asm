FontExtra:
INCBIN "gfx/misc/font_extra.2bpp"

Font:
INCBIN "gfx/misc/font.1bpp"

FontBattleExtra:
INCBIN "gfx/misc/font_battle_extra.2bpp"

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

; TODO: Various misc graphics here.

GFX_f89b0: ; f89b0
INCBIN "gfx/unknown/0f89b0.2bpp"
; f8a90

ShinyIcon: ; f8a90
INCBIN "gfx/stats/shiny.2bpp"

GFX_f8aa0: ; f8aa0
INCBIN "gfx/unknown/0f8aa0.2bpp"
; f8ac0

EnemyHPBarBorderGFX: ; f8ac0
INCBIN "gfx/battle/enemy_hp_bar_border.1bpp"
; f8ae0

HPExpBarBorderGFX: ; f8ae0
INCBIN "gfx/battle/hp_exp_bar_border.1bpp"
; f8b10

ExpBarGFX: ; f8b10
INCBIN "gfx/battle/expbar.2bpp"
; f8ba0

TownMapGFX: ; f8ba0
INCBIN "gfx/misc/town_map.2bpp.lz"
; f8ea4

TextBoxSpaceGFX: ; f9204
INCBIN "gfx/frames/space.2bpp"
; f9214

MapEntryFrameGFX: ; f9344
INCBIN "gfx/frames/map_entry_sign.2bpp"
; f9424

Footprints: ; f9434
INCBIN "gfx/misc/footprints.1bpp"
; fb434

_LoadStandardFont:: ; fb449
	ld de, Font
	ld hl, VTiles1
	lb bc, BANK(Font), $80
	ld a, [rLCDC]
	bit 7, a
	jp z, Copy1bpp

	ld de, Font
	ld hl, VTiles1
	lb bc, BANK(Font), $20
	call Get1bpp_2
	ld de, Font + $20 * LEN_1BPP_TILE
	ld hl, VTiles1 tile $20
	lb bc, BANK(Font), $20
	call Get1bpp_2
	ld de, Font + $40 * LEN_1BPP_TILE
	ld hl, VTiles1 tile $40
	lb bc, BANK(Font), $20
	call Get1bpp_2
	ld de, Font + $60 * LEN_1BPP_TILE
	ld hl, VTiles1 tile $60
	lb bc, BANK(Font), $20
	call Get1bpp_2
	ret
; fb48a

_LoadFontsExtra:: ; fb48a
	ld de, FontExtra + 3 * LEN_2BPP_TILE
	ld hl, VTiles2 tile $63
	lb bc, BANK(FontExtra), $16
	call Get2bpp_2
	jr LoadFrame
; fb4b0

_LoadFontsBattleExtra:: ; fb4be
	ld de, FontBattleExtra
	ld hl, VTiles2 tile $60
	lb bc, BANK(FontBattleExtra), $19
	call Get2bpp_2
	jr LoadFrame
; fb4cc

LoadFrame: ; fb4cc
	ld a, [TextBoxFrame]
	and 7
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
	ld de, FontBattleExtra
	ld hl, VTiles2 tile $60
	lb bc, BANK(FontBattleExtra), $c
	call Get2bpp_2
	ld hl, VTiles2 tile $70
	ld de, FontBattleExtra + $10 * LEN_2BPP_TILE
	lb bc, BANK(FontBattleExtra), 3
	call Get2bpp_2
	call LoadFrame

LoadHPBar: ; fb50d
	ld de, EnemyHPBarBorderGFX
	ld hl, VTiles2 tile $6c
	lb bc, BANK(EnemyHPBarBorderGFX), 4
	call Get1bpp_2
	ld de, HPExpBarBorderGFX
	ld hl, VTiles2 tile $73
	lb bc, BANK(HPExpBarBorderGFX), 6
	call Get1bpp_2
	ld de, ExpBarGFX
	ld hl, VTiles2 tile $55
	lb bc, BANK(ExpBarGFX), 9
	call Get2bpp_2
	ret
; fb53e

Functionfb53e: ; fb53e
	call _LoadFontsBattleExtra
	ld de, EnemyHPBarBorderGFX
	ld hl, VTiles2 tile $6c
	lb bc, BANK(EnemyHPBarBorderGFX), 4
	call Get1bpp_2
	ld de, HPExpBarBorderGFX
	ld hl, VTiles2 tile $78
	lb bc, BANK(HPExpBarBorderGFX), 1
	call Get1bpp_2
	ld de, HPExpBarBorderGFX + 3 * LEN_1BPP_TILE
	ld hl, VTiles2 tile $76
	lb bc, BANK(HPExpBarBorderGFX), 2
	call Get1bpp_2
	ld de, ExpBarGFX
	ld hl, VTiles2 tile $55
	lb bc, BANK(ExpBarGFX), 8
	call Get2bpp_2

Functionfb571: ; fb571
	ld de, GFX_f89b0
	ld hl, VTiles2 tile $31
	lb bc, BANK(GFX_f89b0), $11
	call Get2bpp_2
	ret
; fb57e
