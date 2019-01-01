EcruteakShrineOutside_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 5 ; warp events
	warp_event  5,  3, ECRUTEAK_SHRINE_INSIDE, 1
	warp_event  4, 12, ECRUTEAK_CITY, 4
	warp_event  5, 12, ECRUTEAK_CITY, 4
	warp_event  6, 12, ECRUTEAK_CITY, 5
	warp_event  7, 12, ECRUTEAK_CITY, 5

	db 0 ; coord events

	db 2 ; bg events
	bg_event  3,  8, SIGNPOST_JUMPTEXT, EcruteakShrineOutsideStatueText
	bg_event  8,  8, SIGNPOST_JUMPTEXT, EcruteakShrineOutsideStatueText

	db 3 ; object events
	object_event  8,  4, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, EcruteakShrineOutsideTwinText, -1
	object_event  9,  4, SPRITE_HOOTHOOT, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_POKEMON, HOOTHOOT, EcruteakShrineOutsideHoothootText, -1
	object_event  2, 10, SPRITE_SAGE, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, EcruteakShrineOutsideSageText, -1

EcruteakShrineOutsideTwinText:
	text "My Hoothoot's"
	line "Foresight helps"
	cont "shoo away ghosts."
	done

EcruteakShrineOutsideHoothootText:
	text "Hoothoot: Hoot!"
	done

EcruteakShrineOutsideSageText:
	text "On New Year's Eve,"
	line "people visit this"

	para "shrine and make"
	line "wishes for their"
	cont "future."
	done

EcruteakShrineOutsideStatueText:
	text "A #mon statue…"

	para "It looks very"
	line "serene."
	done
