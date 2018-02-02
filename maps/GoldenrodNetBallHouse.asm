GoldenrodNetBallHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, GOLDENROD_CITY, 19
	warp_event  3,  7, GOLDENROD_CITY, 19

	db 0 ; coord events

	db 0 ; bg events

	db 2 ; object events
	object_event  2,  4, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_SCRIPT, 0, GoldenrodNetBallHouseYoungsterScript, -1
	object_event  6,  3, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, GoldenrodNetBallHouseBugCatcherText, -1

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
