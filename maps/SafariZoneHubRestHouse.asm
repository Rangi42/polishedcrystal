SafariZoneHubRestHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, SAFARI_ZONE_HUB, 9
	warp_event  3,  7, SAFARI_ZONE_HUB, 9

	db 0 ; coord events

	db 4 ; bg events
	bg_event  4,  1, SIGNPOST_READ, PokemonJournalKogaScript
	bg_event  5,  1, SIGNPOST_READ, PokemonJournalKogaScript
	bg_event  6,  1, SIGNPOST_READ, PokemonJournalKogaScript
	bg_event  7,  1, SIGNPOST_READ, PokemonJournalKogaScript

	db 0 ; object events

PokemonJournalKogaScript:
	setflag ENGINE_READ_KOGA_JOURNAL
	thistext

	text "#mon Journal"

	para "Special Feature:"
	line "Elite Four Koga!"

	para "Koga is said to"
	line "have a thorough"

	para "knowledge of"
	line "medicine."

	para "He even concocts"
	line "medicine to nurse"

	para "his #mon to"
	line "health."
	done
