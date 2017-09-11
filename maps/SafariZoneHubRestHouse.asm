SafariZoneHubRestHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

SafariZoneHubRestHouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 9, SAFARI_ZONE_HUB
	warp_def 7, 3, 9, SAFARI_ZONE_HUB

.XYTriggers: db 0

.Signposts: db 4
	signpost 1, 4, SIGNPOST_READ, PokemonJournalKogaScript
	signpost 1, 5, SIGNPOST_READ, PokemonJournalKogaScript
	signpost 1, 6, SIGNPOST_READ, PokemonJournalKogaScript
	signpost 1, 7, SIGNPOST_READ, PokemonJournalKogaScript

.PersonEvents: db 0

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
