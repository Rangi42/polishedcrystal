const_value set 2

LuckyIsland_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1

	; callbacks

	dbw MAPCALLBACK_TILES, Script_ChangeLuckyIslandMap

Script_ChangeLuckyIslandMap:
	callasm CheckIfTrendyPhraseIsLucky
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

CheckIfTrendyPhraseIsLucky:
	xor a
	ld [ScriptVar], a
	ld hl, TrendyPhrase
	ld bc, .KeyPhrase
	ld d, 6
.loop
	ld a, [bc]
	ld e, a
	ld a, [hli]
	cp e
	ret nz
	inc bc
	dec d
	jr nz, .loop
	ld a, 1
	ld [ScriptVar], a
	ret

.KeyPhrase:
	db "Lucky@"
