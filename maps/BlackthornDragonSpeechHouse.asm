BlackthornDragonSpeechHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

BlackthornDragonSpeechHouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 2, BLACKTHORN_CITY
	warp_def 7, 3, 2, BLACKTHORN_CITY

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 7, SIGNPOST_JUMPSTD, difficultbookshelf

.PersonEvents: db 2
	person_event SPRITE_GRANNY, 3, 2, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, BlackthornDragonSpeechHouseGrannyText, -1
	person_event SPRITE_DRATINI, 5, 5, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_POKEMON, DRATINI, BlackthornDragonSpeechHouseDratiniText, -1

BlackthornDragonSpeechHouseGrannyText:
	text "A clan of trainers"
	line "who can freely"

	para "command dragons"
	line "live right here in"
	cont "Blackthorn."

	para "As a result, there"
	line "are many legends"

	para "about dragons in"
	line "this town."
	done

BlackthornDragonSpeechHouseDratiniText:
	text "Dratini: Draa!"
	done
