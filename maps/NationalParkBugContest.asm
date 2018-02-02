NationalParkBugContest_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event 35, 18, ROUTE_36_NATIONAL_PARK_GATE, 1
	warp_event 35, 19, ROUTE_36_NATIONAL_PARK_GATE, 1
	warp_event 12, 47, ROUTE_35_NATIONAL_PARK_GATE, 1
	warp_event 13, 47, ROUTE_35_NATIONAL_PARK_GATE, 1

	db 0 ; coord events

	db 4 ; bg events
	bg_event 16, 44, SIGNPOST_JUMPTEXT, UnknownText_0x5c750
	bg_event 29, 31, SIGNPOST_JUMPTEXT, UnknownText_0x5c771
	bg_event 14,  4, SIGNPOST_JUMPTEXT, UnknownText_0x5c7c6
	bg_event  8, 47, SIGNPOST_ITEM + FULL_HEAL, EVENT_NATIONAL_PARK_HIDDEN_FULL_HEAL

	db 12 ; object events
	object_event 21, 29, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, PAL_NPC_BROWN, PERSONTYPE_SCRIPT, 0, BugCatcherScript_0x5c8ec, EVENT_BUG_CATCHING_CONTESTANT_1A
	object_event 30, 22, SPRITE_BUG_MANIAC, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, BugManiacScript_0x5c8f4, EVENT_BUG_CATCHING_CONTESTANT_2A
	object_event 11, 18, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, CooltrainerMScript_0x5c8fc, EVENT_BUG_CATCHING_CONTESTANT_3A
	object_event  9, 13, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, PokefanMScript_0x5c904, EVENT_BUG_CATCHING_CONTESTANT_4A
	object_event 25,  9, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_SCRIPT, 0, BugCatcherScript_0x5c90c, EVENT_BUG_CATCHING_CONTESTANT_5A
	object_event 29, 13, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 3, 3, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, YoungsterScript_0x5c914, EVENT_BUG_CATCHING_CONTESTANT_6A
	object_event  9, 23, SPRITE_LASS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, LassScript_0x5c91c, EVENT_BUG_CATCHING_CONTESTANT_7A
	object_event 13, 27, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BROWN, PERSONTYPE_SCRIPT, 0, BugCatcherScript_0x5c924, EVENT_BUG_CATCHING_CONTESTANT_8A
	object_event 18,  8, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, YoungsterScript_0x5c92c, EVENT_BUG_CATCHING_CONTESTANT_9A
	object_event 19, 34, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 3, 3, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, YoungsterScript_0x5c934, EVENT_BUG_CATCHING_CONTESTANT_10A
	itemball_event 37, 12, SHINY_STONE, 1, EVENT_NATIONAL_PARK_SHINY_STONE
	tmhmball_event  3, 43, TM_DIG, EVENT_NATIONAL_PARK_TM_DIG

BugCatcherScript_0x5c8ec:
	faceplayer
	jumptext UnknownText_0x5c94c

BugManiacScript_0x5c8f4:
	faceplayer
	jumptext UnknownText_0x5c973

CooltrainerMScript_0x5c8fc:
	faceplayer
	jumptext UnknownText_0x5c9a3

PokefanMScript_0x5c904:
	faceplayer
	jumptext UnknownText_0x5c9cc

BugCatcherScript_0x5c90c:
	faceplayer
	jumptext UnknownText_0x5ca15

YoungsterScript_0x5c914:
	faceplayer
	jumptext UnknownText_0x5ca52

LassScript_0x5c91c:
	faceplayer
	jumptext UnknownText_0x5ca8f

BugCatcherScript_0x5c924:
	faceplayer
	jumptext UnknownText_0x5cac8

YoungsterScript_0x5c92c:
	faceplayer
	jumptext UnknownText_0x5cb25

YoungsterScript_0x5c934:
	faceplayer
	jumptext UnknownText_0x5cb64

UnknownText_0x5c94c:
	text "Don: I'm going to"
	line "win! Don't bother"
	cont "me."
	done

UnknownText_0x5c973:
	text "Lou: My Parasect"
	line "puts #mon to"
	cont "sleep with Spore."
	done

UnknownText_0x5c9a3:
	text "Nick: I'm raising"
	line "fast #mon for"
	cont "battles."
	done

UnknownText_0x5c9cc:
	text "William: I'm not"
	line "concerned about"
	cont "winning."

	para "I'm just looking"
	line "for rare #mon."
	done

UnknownText_0x5ca15:
	text "Benny: Ssh! You'll"
	line "scare off Scyther."

	para "I'll talk to you"
	line "later."
	done

UnknownText_0x5ca52:
	text "Barry: You should"
	line "weaken Bug #mon"

	para "first, then throw"
	line "a Ball."
	done

UnknownText_0x5ca8f:
	text "Cindy: I love Bug"
	line "#mon."

	para "I guess you must"
	line "like them too."
	done

UnknownText_0x5cac8:
	text "Josh: I've been"
	line "collecting Bug"

	para "#mon since I"
	line "was just a baby."

	para "There's no way I'm"
	line "going to lose!"
	done

UnknownText_0x5cb25:
	text "Johnny: If you've"
	line "got the time to"

	para "chat, go find some"
	line "Bug #mon."
	done

UnknownText_0x5cb64:
	text "Kipp: I've studied"
	line "about Bug #mon"
	cont "a lot."

	para "I'm going to win"
	line "for sure."
	done
