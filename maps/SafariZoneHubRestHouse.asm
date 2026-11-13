SafariZoneHubRestHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, SAFARI_ZONE_HUB, 9
	warp_event  3,  7, SAFARI_ZONE_HUB, 9

	def_coord_events

	def_bg_events
	bg_event  4,  1, BGEVENT_READ, PokemonJournalKogaScript
	bg_event  5,  1, BGEVENT_READ, PokemonJournalKogaScript
	bg_event  6,  1, BGEVENT_READ, PokemonJournalKogaScript
	bg_event  7,  1, BGEVENT_READ, PokemonJournalKogaScript

	def_object_events
	object_event  2,  3, SPRITE_BURGLAR, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBurglarPierce, -1

GenericTrainerBurglarPierce:
	generictrainer BURGLAR, PIERCE, EVENT_BEAT_BURGLAR_PIERCE, .SeenText, .BeatenText

	text "There's nothing"
	line "worth stealing"
	cont "here anyway."
	done

.SeenText:
	text "Hey!"
	line "Get outta here!"
	cont "This is my turf!"
	done

.BeatenText:
	text "I'm sorry!"
	done

PokemonJournalKogaScript:
	setflag ENGINE_READ_KOGA_JOURNAL
	jumpthistext

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
