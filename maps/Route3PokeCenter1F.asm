Route3PokeCenter1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route3PokeCenter1F_MapEventHeader:

.Warps: db 3
	warp_def 7, 5, 2, ROUTE_3
	warp_def 7, 6, 2, ROUTE_3
	warp_def 7, 0, 1, POKECENTER_2F

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 10, SIGNPOST_READ, PokemonJournalKarenScript

.PersonEvents: db 4
	pc_nurse_event 1, 5
	person_event SPRITE_POKEFAN_M, 4, 9, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, Route3PokeCenter1FPokefanM1Text, -1
	person_event SPRITE_POKEFAN_M, 5, 2, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, Route3PokeCenter1FPokefanM2Text, -1
	person_event SPRITE_YOUNGSTER, 3, 11, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, Route3PokeCenter1FYoungsterText, -1

PokemonJournalKarenScript:
	setflag ENGINE_READ_KAREN_JOURNAL
	thistext

	text "#mon Journal"

	para "Special Feature:"
	line "Elite Four Karen!"

	para "Karen supposedly"
	line "began training"

	para "Dark-type #mon"
	line "to help overcome"

	para "their sinister"
	line "reputation."
	done

Route3PokeCenter1FPokefanM1Text:
	text "A few years ago"
	line "I sold a weird-"

	para "colored Magikarp"
	line "to this boy…"

	para "I thought there"
	line "was something"
	cont "wrong with it."

	para "Turns out it was"
	line "a rare shiny"
	cont "#mon!"

	para "I could have made"
	line "a lot more money!"
	done

Route3PokeCenter1FPokefanM2Text:
	text "I remember there"
	line "was nothing built"

	para "here when I climb-"
	line "ed the mountain."

	para "Things are more"
	line "convenient now."
	done

Route3PokeCenter1FYoungsterText:
	text "Many trainers are"
	line "on the mountain."

	para "Many wild #mon"
	line "too."

	para "You never know who"
	line "or what you'll en-"
	cont "counter."
	done
