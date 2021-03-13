NationalParkBugContest_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 35, 18, ROUTE_36_NATIONAL_PARK_GATE, 1
	warp_event 35, 19, ROUTE_36_NATIONAL_PARK_GATE, 1
	warp_event 12, 47, ROUTE_35_NATIONAL_PARK_GATE, 1
	warp_event 13, 47, ROUTE_35_NATIONAL_PARK_GATE, 1

	def_coord_events

	def_bg_events
	bg_event 16, 44, BGEVENT_JUMPTEXT, NationalParkRelaxationSquareText
	bg_event 29, 31, BGEVENT_JUMPTEXT, NationalParkBattleNoticeText
	bg_event 14,  4, BGEVENT_JUMPTEXT, NationalParkTrainerTipsText
	bg_event  8, 47, BGEVENT_ITEM + FULL_HEAL, EVENT_NATIONAL_PARK_HIDDEN_FULL_HEAL

	def_object_events
	object_event 21, 29, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant1AScript, EVENT_BUG_CATCHING_CONTESTANT_1A
	object_event 30, 22, SPRITE_BUG_MANIAC, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant2AScript, EVENT_BUG_CATCHING_CONTESTANT_2A
	object_event 11, 18, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant3AScript, EVENT_BUG_CATCHING_CONTESTANT_3A
	object_event  9, 13, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant4AScript, EVENT_BUG_CATCHING_CONTESTANT_4A
	object_event 25,  9, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant5AScript, EVENT_BUG_CATCHING_CONTESTANT_5A
	object_event 29, 13, SPRITE_CAMPER, SPRITEMOVEDATA_WANDER, 3, 3, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant6AScript, EVENT_BUG_CATCHING_CONTESTANT_6A
	object_event  9, 23, SPRITE_PICNICKER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant7AScript, EVENT_BUG_CATCHING_CONTESTANT_7A
	object_event 13, 27, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant8AScript, EVENT_BUG_CATCHING_CONTESTANT_8A
	object_event 18,  8, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant9AScript, EVENT_BUG_CATCHING_CONTESTANT_9A
	object_event 19, 34, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 3, 3, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BugCatchingContestant10AScript, EVENT_BUG_CATCHING_CONTESTANT_10A
	itemball_event 37, 12, SHINY_STONE, 1, EVENT_NATIONAL_PARK_SHINY_STONE
	tmhmball_event  3, 43, TM_DIG, EVENT_NATIONAL_PARK_TM_DIG

BugCatchingContestant1AScript:
	faceplayer
	jumptext BugCatchingContestant1AText

BugCatchingContestant2AScript:
	faceplayer
	jumptext BugCatchingContestant2AText

BugCatchingContestant3AScript:
	faceplayer
	jumptext BugCatchingContestant3AText

BugCatchingContestant4AScript:
	faceplayer
	jumptext BugCatchingContestant4AText

BugCatchingContestant5AScript:
	faceplayer
	jumptext BugCatchingContestant5AText

BugCatchingContestant6AScript:
	faceplayer
	jumptext BugCatchingContestant6AText

BugCatchingContestant7AScript:
	faceplayer
	jumptext BugCatchingContestant7AText

BugCatchingContestant8AScript:
	faceplayer
	jumptext BugCatchingContestant8AText

BugCatchingContestant9AScript:
	faceplayer
	jumptext BugCatchingContestant9AText

BugCatchingContestant10AScript:
	faceplayer
	jumptext BugCatchingContestant10AText

BugCatchingContestant1AText:
	text "Don: I'm going to"
	line "win! Don't bother"
	cont "me."
	done

BugCatchingContestant2AText:
	text "Lou: My Parasect"
	line "puts #mon to"
	cont "sleep with Spore."
	done

BugCatchingContestant3AText:
	text "Nick: I'm raising"
	line "fast #mon for"
	cont "battles."
	done

BugCatchingContestant4AText:
	text "William: I'm not"
	line "concerned about"
	cont "winning."

	para "I'm just looking"
	line "for rare #mon."
	done

BugCatchingContestant5AText:
	text "Benny: Ssh! You'll"
	line "scare off Scyther."

	para "I'll talk to you"
	line "later."
	done

BugCatchingContestant6AText:
	text "Barry: You should"
	line "weaken Bug #mon"

	para "first, then throw"
	line "a Ball."
	done

BugCatchingContestant7AText:
	text "Cindy: I love Bug"
	line "#mon."

	para "I guess you must"
	line "like them too."
	done

BugCatchingContestant8AText:
	text "Josh: I've been"
	line "collecting Bug"

	para "#mon since I"
	line "was just a baby."

	para "There's no way I'm"
	line "going to lose!"
	done

BugCatchingContestant9AText:
	text "Johnny: If you've"
	line "got the time to"

	para "chat, go find some"
	line "Bug #mon."
	done

BugCatchingContestant10AText:
	text "Kipp: I've studied"
	line "about Bug #mon"
	cont "a lot."

	para "I'm going to win"
	line "for sure."
	done
