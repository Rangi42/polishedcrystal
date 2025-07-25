OlsteetonQuickHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, OLSTEETON, 19
	warp_event  3,  7, OLSTEETON, 19

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  4, SPRITE_BUG_MANIAC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, OlsteetonQuickHouseYoungsterScript, -1
	object_event  6,  3, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonQuickHouseBugCatcherText, -1

OlsteetonQuickHouseYoungsterScript:
	checkevent EVENT_GOT_NET_BALL_FROM_GOLDENROD
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	promptbutton
	verbosegiveitem QUICK_BALL
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
	line "Quick Balls to"
	cont "catch #mon"

	para "as quickly as"
	line "possible!"

	para "Here, quickly!"
	line "Take one!"
	done

OlsteetonQuickHouseBugCatcherText:
	text "Not as many"
	line "Bug #mon"

	para "in Jolly Sods"
	line "since that company"

	para "started logging"
	line "operations there."
	done
