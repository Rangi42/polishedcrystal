SafariZoneEastRestHouse_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

SafariZoneEastRestHouse_MapEventHeader:
	db 2 ; warps
	warp_def 7, 2, 5, SAFARI_ZONE_EAST
	warp_def 7, 3, 5, SAFARI_ZONE_EAST

	db 0 ; xy triggers

	db 4 ; signposts
	signpost 1, 4, SIGNPOST_READ, PokemonJournalKogaScript
	signpost 1, 5, SIGNPOST_READ, PokemonJournalKogaScript
	signpost 1, 6, SIGNPOST_READ, PokemonJournalKogaScript
	signpost 1, 7, SIGNPOST_READ, PokemonJournalKogaScript

	db 0 ; person events
