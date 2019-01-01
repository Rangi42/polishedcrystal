VioletOutskirts_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 0 ; warp events

	db 0 ; coord events

	db 0 ; bg events

	db 5 ; object events
	object_event 11,  2, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerPokemaniacShane, -1
	object_event 16, -2, SPRITE_ROUTE_30_RATTATA, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_SAW_SUICUNE_ON_ROUTE_42
	fruittree_event 17, -2, FRUITTREE_ROUTE_42_1, PNK_APRICORN
	fruittree_event 18, -2, FRUITTREE_ROUTE_42_2, GRN_APRICORN
	fruittree_event 19, -2, FRUITTREE_ROUTE_42_3, YLW_APRICORN

GenericTrainerPokemaniacShane:
	generictrainer POKEMANIAC, SHANE, EVENT_BEAT_POKEMANIAC_SHANE, .SeenText, .BeatenText

	text "You're working on"
	line "a #dex?"

	para "Wow, you must know"
	line "some pretty rare"
	cont "#mon!"

	para "May I please see"
	line "it. Please?"
	done

.SeenText:
	text "HEY!"

	para "This is my secret"
	line "place! Get lost,"
	cont "you outsider!"
	done

.BeatenText:
	text "I should have used"
	line "my Moon Stone…"
	done
