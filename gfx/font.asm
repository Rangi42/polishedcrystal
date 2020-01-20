FontTiles::
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
FontBraille:
INCBIN "gfx/font/braille.1bpp"
FontUnown:
INCBIN "gfx/font/unown.1bpp"
FontCommon:
INCBIN "gfx/font/common.1bpp"

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

BattleExtrasGFX:
INCBIN "gfx/battle/hpexpbars.2bpp"

GFX_Stats: ; f89b0
INCBIN "gfx/stats/stats.2bpp"
; f8ac0

StatusIconGFX:
INCBIN "gfx/battle/status.2bpp"

EnemyStatusIconGFX:
INCBIN "gfx/battle/status-enemy.2bpp"

TypeIconGFX:
INCBIN "gfx/battle/types.1bpp"

CategoryIconGFX:
INCBIN "gfx/battle/categories.2bpp"

TownMapGFX: ; f8ba0
INCBIN "gfx/town_map/town_map.2bpp.lz"
; f8ea4

TextBoxSpaceGFX:: ; f9204
INCBIN "gfx/frames/space.1bpp"
; f9214

MapEntryFrameGFX: ; f9344
INCBIN "gfx/frames/map_entry_sign.2bpp"
; f9424

PaintingFrameGFX:
INCBIN "gfx/frames/painting.2bpp"
