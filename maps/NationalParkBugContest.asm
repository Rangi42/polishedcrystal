NationalParkBugContest_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

NationalParkBugContest_MapEventHeader:

.Warps: db 4
	warp_def 18, 35, 1, ROUTE_36_NATIONAL_PARK_GATE
	warp_def 19, 35, 1, ROUTE_36_NATIONAL_PARK_GATE
	warp_def 47, 12, 1, ROUTE_35_NATIONAL_PARK_GATE
	warp_def 47, 13, 1, ROUTE_35_NATIONAL_PARK_GATE

.XYTriggers: db 0

.Signposts: db 4
	signpost 44, 16, SIGNPOST_JUMPTEXT, UnknownText_0x5c750
	signpost 31, 29, SIGNPOST_JUMPTEXT, UnknownText_0x5c771
	signpost 4, 14, SIGNPOST_JUMPTEXT, UnknownText_0x5c7c6
	signpost 47, 8, SIGNPOST_ITEM + FULL_HEAL, EVENT_NATIONAL_PARK_HIDDEN_FULL_HEAL

.PersonEvents: db 12
	person_event SPRITE_BUG_CATCHER, 29, 21, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, BugCatcherScript_0x5c8ec, EVENT_BUG_CATCHING_CONTESTANT_1A
	person_event SPRITE_BUG_MANIAC, 22, 30, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, BugManiacScript_0x5c8f4, EVENT_BUG_CATCHING_CONTESTANT_2A
	person_event SPRITE_COOLTRAINER_M, 18, 11, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CooltrainerMScript_0x5c8fc, EVENT_BUG_CATCHING_CONTESTANT_3A
	person_event SPRITE_POKEFAN_M, 13, 9, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, PokefanMScript_0x5c904, EVENT_BUG_CATCHING_CONTESTANT_4A
	person_event SPRITE_BUG_CATCHER, 9, 25, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, BugCatcherScript_0x5c90c, EVENT_BUG_CATCHING_CONTESTANT_5A
	person_event SPRITE_YOUNGSTER, 13, 29, SPRITEMOVEDATA_WANDER, 3, 3, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, YoungsterScript_0x5c914, EVENT_BUG_CATCHING_CONTESTANT_6A
	person_event SPRITE_LASS, 23, 9, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, LassScript_0x5c91c, EVENT_BUG_CATCHING_CONTESTANT_7A
	person_event SPRITE_BUG_CATCHER, 27, 13, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, BugCatcherScript_0x5c924, EVENT_BUG_CATCHING_CONTESTANT_8A
	person_event SPRITE_YOUNGSTER, 8, 18, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, YoungsterScript_0x5c92c, EVENT_BUG_CATCHING_CONTESTANT_9A
	person_event SPRITE_YOUNGSTER, 34, 19, SPRITEMOVEDATA_WANDER, 3, 3, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, YoungsterScript_0x5c934, EVENT_BUG_CATCHING_CONTESTANT_10A
	itemball_event 12, 37, SHINY_STONE, 1, EVENT_NATIONAL_PARK_SHINY_STONE
	tmhmball_event 43, 3, TM_DIG, EVENT_NATIONAL_PARK_TM_DIG

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
