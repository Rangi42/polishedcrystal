FontTiles::
	table_width 114 * TILE_1BPP_SIZE
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
FontMICR:
INCBIN "gfx/font/micr.1bpp"
FontChicago:
INCBIN "gfx/font/chicago.1bpp"
FontUnown:
INCBIN "gfx/font/unown.1bpp"
	assert_table_length NUM_FONTS

FontCommon:
INCBIN "gfx/font/common.1bpp"
TextboxSpaceGFX::
INCBIN "gfx/font/space.vwf.1bpp"

Frames:
	table_width TEXTBOX_FRAME_TILES * TILE_1BPP_SIZE
INCBIN "gfx/frames/1.1bpp"
INCBIN "gfx/frames/2.1bpp"
INCBIN "gfx/frames/3.1bpp"
INCBIN "gfx/frames/4.1bpp"
INCBIN "gfx/frames/5.1bpp"
INCBIN "gfx/frames/6.1bpp"
INCBIN "gfx/frames/7.1bpp"
INCBIN "gfx/frames/8.1bpp"
INCBIN "gfx/frames/9.1bpp"
INCBIN "gfx/frames/10.1bpp"
INCBIN "gfx/frames/11.1bpp"
INCBIN "gfx/frames/12.1bpp"
INCBIN "gfx/frames/13.1bpp"
INCBIN "gfx/frames/14.1bpp"
INCBIN "gfx/frames/15.1bpp"
INCBIN "gfx/frames/16.1bpp"
INCBIN "gfx/frames/17.1bpp"
INCBIN "gfx/frames/18.1bpp"
INCBIN "gfx/frames/19.1bpp"
INCBIN "gfx/frames/20.1bpp"
	assert_table_length NUM_FRAMES

BattleExtrasGFX:
INCBIN "gfx/battle/hpexpbars.2bpp.lz"

SummaryStatusIconGFX:
INCBIN "gfx/stats/status.2bpp"

StatusIconGFX:
INCBIN "gfx/battle/status.2bpp"

EnemyStatusIconGFX:
INCBIN "gfx/battle/status-enemy.2bpp"

TypeIconGFX:
	table_width 4 * TILE_1BPP_SIZE
INCBIN "gfx/battle/types.1bpp"
	assert_table_length NUM_TYPES + 1

CategoryIconGFX:
	table_width 2 tiles
INCBIN "gfx/battle/categories.2bpp"
	assert_table_length NUM_CATEGORIES

PaintingFrameGFX:
INCBIN "gfx/signs/painting.2bpp"
