GoldenrodUndergroundEntrances_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5, 19, GOLDENROD_UNDERGROUND, 2
	warp_event  4, 23, GOLDENROD_CITY, 14
	warp_event  5, 23, GOLDENROD_CITY, 14
	warp_event  5,  5, GOLDENROD_UNDERGROUND, 1
	warp_event  4,  9, GOLDENROD_CITY, 13
	warp_event  5,  9, GOLDENROD_CITY, 13
	warp_event  5, 33, GOLDENROD_UNDERGROUND, 7
	warp_event  4, 37, GOLDENROD_CITY, 22
	warp_event  5, 37, GOLDENROD_CITY, 22

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3, 21, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodUndergroundEntrances_TeacherText, -1
	object_event  8, 20, SPRITE_SUPER_NERD, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodUndergroundEntrances_SuperNerd1Text, -1
	object_event  3,  7, SPRITE_BUG_MANIAC, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodUndergroundEntrances_SuperNerd2Text, -1
	object_event  1, 35, SPRITE_VETERAN_M, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, PAL_NPC_GRAY, OBJECTTYPE_SCRIPT, 0, GoldenrodUndergroundEntrancesVeteranMScript, -1
	object_event  8, 34, SPRITE_BEAUTY, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodUndergroundEntrances_BeautyText, -1

	object_const_def

GoldenrodUndergroundEntrancesVeteranMScript:
	checkevent EVENT_GOT_LOADED_DICE_FROM_GOLDENROD
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	promptbutton
	verbosegiveitem LOADED_DICE
	iffalse_endtext
	setevent EVENT_GOT_LOADED_DICE_FROM_GOLDENROD
	jumpthisopenedtext

.Text2:
	text "In the long run,"
	line "the house always"
	cont "wins…"
	done

.Text1:
	text "I tried to use"
	line "this item in the"

	para "Game Corner, but"
	line "they caught me."

	para "You may as well"
	line "take it."
	done

GoldenrodUndergroundEntrances_TeacherText:
	text "There are some"
	line "shops downstairs…"

	para "But there are"
	line "also trainers."

	para "I'm scared to go"
	line "down there."
	done

GoldenrodUndergroundEntrances_SuperNerd1Text:
	text "This tunnel was"
	line "originally made"
	cont "for deliveries to"

	para "the department"
	line "store."

	para "It's a nice short-"
	line "cut across the"
	cont "city too."
	done

GoldenrodUndergroundEntrances_SuperNerd2Text:
	text "I was challenged"
	line "to a battle down-"
	cont "stairs."

	para "It's rough down"
	line "there. You'd"
	cont "better be careful."
	done

GoldenrodUndergroundEntrances_BeautyText:
	text "I went on a tour"
	line "of the Radio"

	para "Tower. I saw all"
	line "three studios and"

	para "even ate in the"
	line "café."
	done
