SafariZoneEastRestHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

SafariZoneEastRestHouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 5, SAFARI_ZONE_EAST
	warp_def 7, 3, 5, SAFARI_ZONE_EAST

.XYTriggers: db 0

.Signposts: db 4
	signpost 1, 4, SIGNPOST_READ, PokemonJournalKogaScript
	signpost 1, 5, SIGNPOST_READ, PokemonJournalKogaScript
	signpost 1, 6, SIGNPOST_READ, PokemonJournalKogaScript
	signpost 1, 7, SIGNPOST_READ, PokemonJournalKogaScript

.PersonEvents: db 0
