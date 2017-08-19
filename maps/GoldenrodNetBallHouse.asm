GoldenrodNetBallHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

GoldenrodNetBallHouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 19, GOLDENROD_CITY
	warp_def 7, 3, 19, GOLDENROD_CITY

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 2
	person_event SPRITE_YOUNGSTER, 4, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, GoldenrodNetBallHouseYoungsterScript, -1
	person_event SPRITE_BUG_CATCHER, 3, 6, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, GoldenrodNetBallHouseBugCatcherText, -1

GoldenrodNetBallHouseYoungsterScript:
	checkevent EVENT_GOT_NET_BALL_FROM_GOLDENROD
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	buttonsound
	verbosegiveitem NET_BALL
	iffalse_endtext
	setevent EVENT_GOT_NET_BALL_FROM_GOLDENROD
	thisopenedtext

.Text2:
	text "Sometimes you get"
	line "really lucky and"
	cont "catch a #mon at"

	para "full HP. I love"
	line "that feeling."
	done

.Text1:
	text "I stocked up on"
	line "Net Balls to catch"
	cont "a Pineco, but got"

	para "it with my very"
	line "first one!"

	para "I won't be needing"
	line "this anymore."
	done

GoldenrodNetBallHouseBugCatcherText:
	text "They hold Bug-"
	line "Catching Contests"

	para "in National Park"
	line "on Route 35."

	para "Sometimes even"
	line "Bugsy competes."
	done
