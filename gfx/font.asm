FontExtra:
INCBIN "gfx/misc/font_extra.2bpp"

Font:
INCBIN "gfx/misc/font.1bpp"
FontBold:
INCBIN "gfx/misc/font_bold.1bpp"
FontItalic:
INCBIN "gfx/misc/font_italic.1bpp"
FontUnown:
INCBIN "gfx/misc/font_unown.1bpp"

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

; Various misc graphics here.

GFX_Stats: ; f89b0
INCBIN "gfx/misc/stats.2bpp"
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

OverworldPhoneIconGFX: ; f8f24
INCBIN "gfx/misc/overworld_phone_icon.2bpp"
; f8f34

TextBoxSpaceGFX: ; f9204
INCBIN "gfx/frames/space.2bpp"
; f9214

MapEntryFrameGFX: ; f9344
INCBIN "gfx/frames/map_entry_sign.2bpp"
; f9424

UpArrowGFX: ; f9424
INCBIN "gfx/misc/font_up_arrow.2bpp"
; f9434

Footprints: ; f9434
INCBIN "gfx/misc/footprints.w128.1bpp"
; fb434

_LoadStandardFont:: ; fb449
	call LoadStandardFontPointer
	ld d, h
	ld e, l
	ld hl, VTiles1
	lb bc, BANK(Font), $80
	ld a, [rLCDC]
	bit 7, a
	jp z, Copy1bpp

	call LoadStandardFontPointer
	ld d, h
	ld e, l
	ld hl, VTiles1
	lb bc, BANK(Font), $20
	call Get1bpp_2
	call LoadStandardFontPointer
	ld de, $20 * LEN_1BPP_TILE
	add hl, de
	ld d, h
	ld e, l
	ld hl, VTiles1 tile $20
	lb bc, BANK(Font), $20
	call Get1bpp_2
	call LoadStandardFontPointer
	ld de, $40 * LEN_1BPP_TILE
	add hl, de
	ld d, h
	ld e, l
	ld hl, VTiles1 tile $40
	lb bc, BANK(Font), $20
	call Get1bpp_2
	call LoadStandardFontPointer
	ld de, $60 * LEN_1BPP_TILE
	add hl, de
	ld d, h
	ld e, l
	ld hl, VTiles1 tile $60
	lb bc, BANK(Font), $20
	call Get1bpp_2
	ret
; fb48a

LoadStandardFontPointer::
	ld a, [Options2]
	and $60
	ld hl, Font
	cp FONT_NORMAL
	ret z
	ld hl, FontBold
	cp FONT_BOLD
	ret z
	ld hl, FontItalic
	cp FONT_ITALIC
	ret z
	ld hl, FontUnown
	ret

_LoadFontsExtra1:: ; fb48a
	ld de, OverworldPhoneIconGFX
	ld hl, VTiles2 tile $62
	lb bc, BANK(OverworldPhoneIconGFX), 1
	call Get2bpp_2
	ld de, FontExtra + 3 * LEN_2BPP_TILE
	ld hl, VTiles2 tile $63
	lb bc, BANK(FontExtra), $16
	call Get2bpp_2
	jr LoadFrame
; fb4b0

_LoadFontsExtra2:: ; fb4b0
	ld de, UpArrowGFX
	ld hl, VTiles2 tile $61
	ld b, BANK(UpArrowGFX)
	ld c, 1
	call Get2bpp_2
	ret
; fb4be

_LoadFontsBattleExtra:: ; fb4be
	ld de, FontBattleExtra
	ld hl, VTiles2 tile $60
	lb bc, BANK(FontBattleExtra), $19
	call Get2bpp_2
	jr LoadFrame
; fb4cc

LoadFrame: ; fb4cc
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
	lb bc, BANK(ExpBarGFX), 10
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
	ld de, GFX_Stats
	ld hl, VTiles2 tile $31
	lb bc, BANK(GFX_Stats), $11
	call Get2bpp_2
	ret
; fb57e
