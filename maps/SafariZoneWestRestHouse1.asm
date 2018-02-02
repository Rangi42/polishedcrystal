SafariZoneWestRestHouse1_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, SAFARI_ZONE_WEST, 7
	warp_event  3,  7, SAFARI_ZONE_WEST, 7

	db 0 ; coord events

	db 4 ; bg events
	bg_event  4,  1, SIGNPOST_READ, PokemonJournalKogaScript
	bg_event  5,  1, SIGNPOST_READ, PokemonJournalKogaScript
	bg_event  6,  1, SIGNPOST_READ, PokemonJournalKogaScript
	bg_event  7,  1, SIGNPOST_READ, PokemonJournalKogaScript

	db 0 ; object events
