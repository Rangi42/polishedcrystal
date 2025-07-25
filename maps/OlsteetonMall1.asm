OlsteetonMall1_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  8,  7, OLSTEETON, 5
	warp_event  7,  7, OLSTEETON, 5
	warp_event 15,  5, OLSTEETON_MALL_2, 3
	warp_event 15,  4, OLSTEETON_MALL_2, 4
	; warp_event  9,  0, GOLDENROD_DEPT_STORE_ELEVATOR, 1

	def_coord_events

	def_bg_events
	bg_event  8,  0, BGEVENT_JUMPTEXT, OlsteetonMall1DirectoryText

	def_object_events
	object_event 10,  3, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, pokemart, MARTTYPE_BARGAIN, 0, -1
	object_event 11,  3, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, pokemart, MARTTYPE_BARGAIN, 0, -1
	object_event 11,  7, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonMall1YoungsterText, -1
	object_event  2,  7, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonMall1CooltrainerFText, -1
	object_event  1,  3, SPRITE_GENTLEMAN, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonMall1GentlemanText, -1

OlsteetonMall1YoungsterText: ;needs new dialogue
	text "#gear has no"
	line "storage limit."

	para "But getting too"
	line "many phone calls"
	cont "can be annoying."
	done

OlsteetonMall1CooltrainerFText:
	text "I need"
	line "dialogue."
	done

OlsteetonMall1GentlemanText:
	text "Good sir, I"
	line "need some text."
	done

OlsteetonMall1DirectoryText:
	text "Employees Only"
	line "Beyond This"
	cont "Point!"
	done
