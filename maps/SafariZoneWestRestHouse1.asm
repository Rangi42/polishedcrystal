SafariZoneWestRestHouse1_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

SafariZoneWestRestHouse1_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 7, SAFARI_ZONE_WEST
	warp_def 7, 3, 7, SAFARI_ZONE_WEST

.XYTriggers: db 0

.Signposts: db 4
	signpost 1, 4, SIGNPOST_READ, PokemonJournalKogaScript
	signpost 1, 5, SIGNPOST_READ, PokemonJournalKogaScript
	signpost 1, 6, SIGNPOST_READ, PokemonJournalKogaScript
	signpost 1, 7, SIGNPOST_READ, PokemonJournalKogaScript

.PersonEvents: db 0
