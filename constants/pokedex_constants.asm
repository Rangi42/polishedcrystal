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

	; area mode data
	const_def
	const DEXAREA_MORN
	const DEXAREA_DAY
	const DEXAREA_NITE
	const DEXAREA_SURF
DEXAREA_WILDS EQU const_value ; Areas above are handled by GetWildLocations
	const DEXAREA_FISH
	const DEXAREA_TREE
	const DEXAREA_GAME
NUM_DEXAREA EQU const_value

DEXAREA_UNKNOWN_MASK EQU %10000000
DEXAREA_REGION_MASK  EQU %01110000
DEXAREA_TYPE_MASK    EQU %00001111
DEXAREA_UNKNOWN_F EQU 7 ; literally "Area Unknown", not pret "unknown meaning"
