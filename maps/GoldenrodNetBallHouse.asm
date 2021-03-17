GoldenrodNetBallHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, GOLDENROD_CITY, 19
	warp_event  3,  7, GOLDENROD_CITY, 19

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  4, SPRITE_BUG_MANIAC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodNetBallHouseYoungsterScript, -1
	object_event  6,  3, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodNetBallHouseBugCatcherText, -1

GoldenrodNetBallHouseYoungsterScript:
	checkevent EVENT_GOT_NET_BALL_FROM_GOLDENROD
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	promptbutton
	verbosegiveitem NET_BALL
	iffalse_endtext
	setevent EVENT_GOT_NET_BALL_FROM_GOLDENROD
	jumpthisopenedtext

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
