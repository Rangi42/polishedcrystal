const_value set 2

LuckyIsland_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1

	; callbacks

	dbw MAPCALLBACK_TILES, Script_ChangeLuckyIslandMap

Script_ChangeLuckyIslandMap:
	special CheckIfTrendyPhraseIsLucky
	iftrue .show
	changemap BANK(LuckyIslandHidden_BlockData), LuckyIslandHidden_BlockData
	setevent EVENT_LUCKY_ISLAND_CIVILIANS
	return

.show
	changemap BANK(LuckyIsland_BlockData), LuckyIsland_BlockData
	clearevent EVENT_LUCKY_ISLAND_CIVILIANS
	return

LuckyIsland_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 0

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
