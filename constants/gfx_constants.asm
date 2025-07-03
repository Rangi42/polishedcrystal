DEF TILE_1BPP_SIZE EQU TILE_SIZE / 2 ; bytes

DEF METATILE_WIDTH EQU 4 ; tiles
DEF SCREEN_META_WIDTH  EQU 6 ; metatiles
DEF SCREEN_META_HEIGHT EQU 5 ; metatiles
DEF SURROUNDING_WIDTH  EQU SCREEN_META_WIDTH * METATILE_WIDTH ; tiles
DEF SURROUNDING_HEIGHT EQU SCREEN_META_HEIGHT * METATILE_WIDTH ; tiles
DEF MAP_CONNECTION_PADDING_WIDTH EQU 3 ; metatiles

DEF HP_BAR_LENGTH  EQU 6 ; tiles
DEF EXP_BAR_LENGTH EQU 8 ; tiles
DEF HP_BAR_LENGTH_PX  EQU HP_BAR_LENGTH  * TILE_WIDTH ; pixels
DEF EXP_BAR_LENGTH_PX EQU EXP_BAR_LENGTH * TILE_WIDTH ; pixels

; GetHPPal return values (see home/tilemap.asm)
DEF HP_GREEN  EQU 0
DEF HP_YELLOW EQU 1
DEF HP_RED    EQU 2

; Used to prevent updating the OAM's palette (0-7) during the next anim frame,
; useful when dynamically applying a palette, such as party menu sprites and overworld fly mon sprites.
DEF SPRITEOAM_SKIP_PAL_APPLY       EQU -1
DEF SPRITEOAM_SKIP_PAL_APPLY_XFLIP EQU -2 ; Same as above, but with X-flip attribute.

; PokeAnims indexes (see engine/gfx/pic_animation.asm)
	const_def
	const ANIM_MON_SLOW
	const ANIM_MON_NORMAL
	const ANIM_MON_MENU
	const ANIM_MON_TRADE
	const ANIM_MON_EVOLVE
	const ANIM_MON_HATCH
	const ANIM_MON_HOF
	const ANIM_MON_EGG1
	const ANIM_MON_EGG2

DEF OAM_YCOORD_HIDDEN EQU 160 ; hides an OAM offscreen

; VWF flags (see engine/gfx/vwf.asm)
	const_def
	const VWF_SINGLE_F
	const VWF_INVERT_F
	const VWF_OPAQUE_F

DEF VWF_SINGLE EQU 1 << VWF_SINGLE_F
DEF VWF_INVERT EQU 1 << VWF_INVERT_F
DEF VWF_OPAQUE EQU 1 << VWF_OPAQUE_F

; Dex GFX flags
	const_def
	const DEXGFX_DEFERRED ; tilemap+pal update scheduled for next input request
	const DEXGFX_TILEMAP ; includes palettes
	const DEXGFX_FRONTPIC
	const DEXGFX_POKEINFO ; non-frontpic gfx (type icons, footprint)
	const DEXGFX_ROWTILES ; icon+vwf tiles for a row update
	const DEXGFX_ICONSHAPE ; icon+body for individual mon pages

	const_def
	const DEXTILE_FROM_DEXMAP_F

DEF DEXTILE_FROM_DEXMAP EQU 1 << DEXTILE_FROM_DEXMAP_F

DEF NUM_FLYFROM_ANIM_OAMS EQU 4 + 9 ; 4 for flymon, 9 for leaves
DEF NUM_FLYTO_ANIM_OAMS   EQU 4 + 8 ; 4 for flymon, 8 for leaves
