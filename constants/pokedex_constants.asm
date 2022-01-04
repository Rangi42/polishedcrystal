	const_def
	const DEXDISP_MAIN
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

	; wCurDexMode::
	; Also defines menu options for the dex mode menu.
	const_def
	; Valid for wCurDexMode
	const DEXMODE_NEW
	const DEXMODE_OLD
DEXMODE_ABC EQU const_value ; Only used as a search option, not a proper mode.
	; Other options
	const DEXMODE_UNOWN
	const DEXMODE_CANCEL
NUM_DEXMODE EQU const_value

	; area data
	const_def
	const DEXAREA_MORNING
	const DEXAREA_DAY
	const DEXAREA_NIGHT
	const DEXAREA_SURFING
DEXAREA_WILDS EQU const_value ; Areas above are handled by GetWildLocations
	const DEXAREA_OLD_ROD
	const DEXAREA_GOOD_ROD
	const DEXAREA_SUPER_ROD
DEXAREA_FISH EQU const_value ; Areas above are handled by GetFishLocations
	const DEXAREA_HEADBUTT
	const DEXAREA_ROCK_SMASH
	const DEXAREA_CONTEST
NUM_DEXAREAS EQU const_value

DEXAREA_UNKNOWN_MASK EQU %10000000
DEXAREA_REGION_MASK  EQU %01110000
DEXAREA_TYPE_MASK    EQU %00001111
DEXAREA_UNKNOWN_F EQU 7 ; literally "Area Unknown", not pret "unknown meaning"

POKEDEX_SCROLLTILE_TOP EQU $75
POKEDEX_SCROLLTILE_BAR EQU $76
