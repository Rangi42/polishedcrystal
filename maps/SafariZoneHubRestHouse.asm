SafariZoneHubRestHouse_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

SafariZoneHubRestHouse_MapEventHeader:
	db 2 ; warps
	warp_def 7, 2, 9, SAFARI_ZONE_HUB
	warp_def 7, 3, 9, SAFARI_ZONE_HUB

	db 0 ; xy triggers

	db 4 ; signposts
	signpost 1, 4, SIGNPOST_READ, PokemonJournalKogaScript
	signpost 1, 5, SIGNPOST_READ, PokemonJournalKogaScript
	signpost 1, 6, SIGNPOST_READ, PokemonJournalKogaScript
	signpost 1, 7, SIGNPOST_READ, PokemonJournalKogaScript

	db 0 ; person events

PokemonJournalKogaScript:
	setflag ENGINE_READ_KOGA_JOURNAL
	jumptext PokemonJournalKogaText

PokemonJournalKogaText:
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
