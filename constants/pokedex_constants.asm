	const_def
	const DEXDISP_MAIN
	const DEXDISP_UNOWN
DEF DEXDISP_SPRITEANIM_OK EQU const_value ; Display modes with sprite anim cursor.
	const DEXDISP_MODE
	const DEXDISP_NEWDESC
	; These below (starting from DEXDISP_SEARCH) have OAM data.
	const DEXDISP_SEARCH
	const DEXDISP_DESC
	const DEXDISP_BIO
	const DEXDISP_STATS
	const DEXDISP_AREA

	const_def
	const DEXPOS_MONS
	const DEXPOS_DEXNO
	const DEXPOS_ICON_TILES
	const DEXPOS_VWF_TILES
	const DEXPOS_ICON_VTILES
	const DEXPOS_VWF_VTILES
	const DEXPOS_ICONTILE_OFFSET
	const DEXPOS_VWFTILE_OFFSET
	const DEXPOS_TILEMAP
	const DEXPOS_ATTRMAP
	const DEXPOS_PALCOPY

	; Note that wPokedex_SearchData starts with Type1.
	const_def
	const DEXSEARCH_ORDER
	const DEXSEARCH_TYPE1
	const DEXSEARCH_TYPE2
	const DEXSEARCH_GROUP1
	const DEXSEARCH_GROUP2
	const DEXSEARCH_COLOR
	const DEXSEARCH_SHAPE
DEF NUM_DEXSEARCH EQU const_value

	; wCurDexMode::
	; Also defines menu options for the dex mode menu.
	const_def
	; Valid for wCurDexMode
	const DEXMODE_NEW
	const DEXMODE_OLD
DEF DEXMODE_ABC EQU const_value ; Only used as a search option, not a proper mode.
	; Other options
	const DEXMODE_UNOWN
	const DEXMODE_CANCEL
DEF NUM_DEXMODE EQU const_value

	; area data
	const_def
	const DEXAREA_MORNING
	const DEXAREA_DAY
	const DEXAREA_NIGHT
	const DEXAREA_SURFING
DEF DEXAREA_WILDS EQU const_value ; Areas above are handled by GetWildLocations
	const DEXAREA_OLD_ROD
	const DEXAREA_GOOD_ROD
	const DEXAREA_SUPER_ROD
DEF DEXAREA_FISH EQU const_value ; Areas above are handled by GetFishLocations
	const DEXAREA_HEADBUTT
	const DEXAREA_ROCK_SMASH
	const DEXAREA_CONTEST
	const DEXAREA_ROAMING
DEF NUM_DEXAREAS EQU const_value

DEF DEXAREA_UNKNOWN_MASK EQU %10000000
DEF DEXAREA_REGION_MASK  EQU %01110000
DEF DEXAREA_TYPE_MASK    EQU %00001111
DEF DEXAREA_UNKNOWN_F EQU 7 ; literally "Area Unknown", not pret "unknown meaning"

DEF DEXLIST_WIDTH EQU 5

DEF POKEDEX_SCROLLTILE_TOP EQU $75
DEF POKEDEX_SCROLLTILE_BAR EQU $76
