GoldenrodDeptStore3F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 12,  0, GOLDENROD_DEPT_STORE_2F, 1
	warp_event 15,  0, GOLDENROD_DEPT_STORE_4F, 2
	warp_event  2,  0, GOLDENROD_DEPT_STORE_ELEVATOR, 1

	def_coord_events

	def_bg_events
	bg_event 14,  0, BGEVENT_JUMPTEXT, GoldenrodDeptStore3FDirectoryText

	def_object_events
	object_event  6,  1, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, pokemart, MARTTYPE_STANDARD, MART_GOLDENROD_3F, -1
	object_event 12,  5, SPRITE_POKEMANIAC, SPRITEMOVEDATA_SPINRANDOM_FAST, 1, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodDeptStore3FSuperNerdText, -1
	object_event  2,  5, SPRITE_ROCKER, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodDeptStore3FRockerText, -1

GoldenrodDeptStore3FSuperNerdText:
	text "I, I, I'm really"
	line "impatient!"

	para "I use X Speed in"
	line "battle to speed up"
	cont "my #mon."
	done

GoldenrodDeptStore3FRockerText:
	text "Hey! When you bat-"
	line "tle, do you use X"
	cont "Spcl.Atk?"

	para "It's awesome. It"
	line "really jacks up"
	cont "Special Attack!"
	done

GoldenrodDeptStore3FDirectoryText:
	text "For Victory"
	line "Seekers"

	para "3F Battle"
	line "   Collection"
	done
