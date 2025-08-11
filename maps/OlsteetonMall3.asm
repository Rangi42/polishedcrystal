OlsteetonMall3_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  6,  9, OLSTEETON, 7
	warp_event  5,  9, OLSTEETON, 7
	warp_event  0,  4, OLSTEETON_MALL_2, 5
	warp_event  0,  5, OLSTEETON_MALL_2, 6

	def_coord_events

	def_bg_events
	bg_event  3,  7, BGEVENT_JUMPTEXT, OlsteetonMall3DirectoryText
	bg_event  7,  1, BGEVENT_JUMPTEXT, OlsteetonMall3TVText
	bg_event  4,  3, BGEVENT_JUMPTEXT, OlsteetonMall3TVText
	bg_event  4,  1, BGEVENT_JUMPTEXT, OlsteetonMall3DirectoryText
	bg_event  7,  3, BGEVENT_JUMPTEXT, OlsteetonMall3DirectoryText
	bg_event 10,  0, BGEVENT_JUMPTEXT, OlsteetonMall3SignText





	def_object_events
	object_event  2,  8, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_COMMAND, pokemart, MARTTYPE_STANDARD, MART_GOLDENROD_3F, -1
	object_event  4,  2, SPRITE_POKEMANIAC, SPRITEMOVEDATA_SPINRANDOM_FAST, 1, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonMall3SuperNerdText, -1
	object_event  3,  5, SPRITE_ROCKER, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonMall3RockerText, -1
	object_event 11,  1, SPRITE_PI, SPRITEMOVEDATA_STANDING_DOWN, 1, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonMall3MegacorpText, -1

OlsteetonMall3SuperNerdText:
	text "I'm supple-"
	line "menting my"

	para "#mon's diet"
	line "with carbos"
	cont "to make it"
	cont "faster!"
	done

OlsteetonMall3SignText:
	text "AUTHORIZED"
	line "PERSONNEL"
	cont "ONLY"
	done
OlsteetonMall3RockerText:
	text "I got kicked"
	line "out of my band"

	para "Do you think"
	line "X Defense"
	cont "protects against"
	cont "sad feelings?"

	para "<PLAYER>: Uhh"
	line "Spec. Guard"
	cont "your heart?"

	para "..."
	line "..."
	done

OlsteetonMall3MegacorpText:
	text "I can't let"
	line "you past."

	para "Keep it"
	line "movin' pal"
	done

OlsteetonMall3DirectoryText:
	text "Bob's Battle"
	line "Emporium"

	para "Winners"
	line "shop here."
	done

	OlsteetonMall3TVText:
	text "They're showing"
	line "re-runs of old"

	para "champion battles"
	line "on the tv."
	done