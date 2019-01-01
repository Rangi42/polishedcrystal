SproutTower1F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 5 ; warp events
	warp_event  7, 15, VIOLET_CITY, 7
	warp_event  8, 15, VIOLET_CITY, 7
	warp_event  4,  4, SPROUT_TOWER_2F, 1
	warp_event  0,  6, SPROUT_TOWER_2F, 2
	warp_event 15,  3, SPROUT_TOWER_2F, 3

	db 0 ; coord events

	db 2 ; bg events
	bg_event  5, 15, SIGNPOST_JUMPTEXT, UnknownText_0x1846d6
	bg_event 10, 15, SIGNPOST_JUMPTEXT, UnknownText_0x1846d6

	db 6 ; object events
	object_event  5,  4, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1845d8, -1
	object_event  4,  7, SPRITE_SAGE, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x18460a, -1
	object_event  9, 12, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, GrannyScript_0x184504, -1
	object_event  7,  9, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x18469d, -1
	object_event  1,  5, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_GENERICTRAINER, 4, GenericTrainerSageChow, -1
	itemball_event 14,  7, PARLYZ_HEAL, 1, EVENT_SPROUT_TOWER1F_PARLYZ_HEAL

GrannyScript_0x184504:
	checkunits
	iftrue .metric
	jumptextfaceplayer UnknownText_0x184649_Imperial
.metric
	jumptextfaceplayer UnknownText_0x184649_Metric

GenericTrainerSageChow:
	generictrainer SAGE, CHOW, EVENT_BEAT_SAGE_CHOW, SageChowSeenText, SageChowBeatenText

	text "All living beings"
	line "coexist through"
	cont "cooperation."

	para "We must always be"
	line "thankful for this."
	done

SageChowSeenText:
	text "We stand guard in"
	line "this tower."

	para "Here, we express"
	line "our gratitude to"
	cont "honor all #mon."
	done

SageChowBeatenText:
	text "Th-Thank you!"
	done

UnknownText_0x1845d8:
	text "Only if you reach"
	line "the top will you"
	cont "obtain a TM."
	done

UnknownText_0x18460a:
	text "Sprout Tower was"
	line "built long ago"

	para "as a place for"
	line "#mon training."
	done

UnknownText_0x184649_Imperial:
	text "A Bellsprout over"
	line "100 feet tall…"

	para "People say that it"
	line "became the center"
	cont "pillar here."
	done

UnknownText_0x184649_Metric:
	text "A Bellsprout over"
	line "30 meters tall…"

	para "People say that it"
	line "became the center"
	cont "pillar here."
	done

UnknownText_0x18469d:
	text "See the pillar"
	line "shaking?"

	para "People are train-"
	line "ing upstairs."
	done

UnknownText_0x1846d6:
	text "A #mon statue…"

	para "It looks very"
	line "distinguished."
	done
