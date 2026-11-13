SafariZoneNorthRestHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, SAFARI_ZONE_NORTH, 7
	warp_event  3,  7, SAFARI_ZONE_NORTH, 7

	def_coord_events

	def_bg_events
	bg_event  4,  1, BGEVENT_READ, PokemonJournalKogaScript
	bg_event  5,  1, BGEVENT_READ, PokemonJournalKogaScript
	bg_event  6,  1, BGEVENT_READ, PokemonJournalKogaScript
	bg_event  7,  1, BGEVENT_READ, PokemonJournalKogaScript

	def_object_events
	object_event  2,  1, SPRITE_COOL_DUDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerCoupleErikandsara1, -1
	object_event  3,  1, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerCoupleErikandsara2, -1

GenericTrainerCoupleErikandsara1:
	generictrainer COUPLE, ERIKANDSARA1, EVENT_BEAT_COUPLE_ERIK_AND_SARA, .SeenText, .BeatenText

	text "Erik: I used to"
	line "get lost in the"
	cont "Safari Zone."

	para "Now it's become"
	line "our favorite"
	cont "quiet spot."
	done

.SeenText:
	text "Erik: You found"
	line "our secret spot?!"
	done

.BeatenText:
	text "Erik: Not so"
	line "secret now…"
	done

GenericTrainerCoupleErikandsara2:
	generictrainer COUPLE, ERIKANDSARA2, EVENT_BEAT_COUPLE_ERIK_AND_SARA, .SeenText, .BeatenText

	text "Sara: We had our"
	line "first date at the"
	cont "Safari Zone."

	para "It's been three"
	line "years now!"
	done

.SeenText:
	text "Sara: You found"
	line "our secret spot?!"
	done

.BeatenText:
	text "Sara: Not so"
	line "secret now…"
	done
