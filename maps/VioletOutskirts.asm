VioletOutskirts_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

VioletOutskirts_MapEventHeader:

.Warps: db 0

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 5
	person_event SPRITE_SUPER_NERD, 2, 11, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerPokemaniacShane, -1
	person_event SPRITE_ROUTE_30_RATTATA, -2, 16, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_SAW_SUICUNE_ON_ROUTE_42
	fruittree_event -2, 17, FRUITTREE_ROUTE_42_1, PNK_APRICORN
	fruittree_event -2, 18, FRUITTREE_ROUTE_42_2, GRN_APRICORN
	fruittree_event -2, 19, FRUITTREE_ROUTE_42_3, YLW_APRICORN

GenericTrainerPokemaniacShane:
	generictrainer EVENT_BEAT_POKEMANIAC_SHANE, POKEMANIAC, SHANE, .SeenText, .BeatenText

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
