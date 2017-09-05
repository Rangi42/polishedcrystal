SproutTower1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

SproutTower1F_MapEventHeader:

.Warps: db 5
	warp_def 15, 7, 7, VIOLET_CITY
	warp_def 15, 8, 7, VIOLET_CITY
	warp_def 4, 4, 1, SPROUT_TOWER_2F
	warp_def 6, 0, 2, SPROUT_TOWER_2F
	warp_def 3, 15, 3, SPROUT_TOWER_2F

.XYTriggers: db 0

.Signposts: db 2
	signpost 15, 5, SIGNPOST_JUMPTEXT, UnknownText_0x1846d6
	signpost 15, 10, SIGNPOST_JUMPTEXT, UnknownText_0x1846d6

.PersonEvents: db 6
	person_event SPRITE_SAGE, 4, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1845d8, -1
	person_event SPRITE_SAGE, 7, 4, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x18460a, -1
	person_event SPRITE_GRANNY, 12, 9, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, GrannyScript_0x184504, -1
	person_event SPRITE_TEACHER, 9, 7, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x18469d, -1
	person_event SPRITE_SAGE, 5, 1, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 4, TrainerSageChow, -1
	itemball_event 7, 14, PARLYZ_HEAL, 1, EVENT_SPROUT_TOWER1F_PARLYZ_HEAL

GrannyScript_0x184504:
	checkunits
	iftrue .metric
	jumptextfaceplayer UnknownText_0x184649_Imperial
.metric
	jumptextfaceplayer UnknownText_0x184649_Metric

TrainerSageChow:
	trainer EVENT_BEAT_SAGE_CHOW, SAGE, CHOW, SageChowSeenText, SageChowBeatenText, 0, SageChowScript

SageChowScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x184583

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

UnknownText_0x184583:
	text "All living beings"
	line "coexist through"
	cont "cooperation."

	para "We must always be"
	line "thankful for this."
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
