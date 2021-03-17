PewterMart_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, PEWTER_CITY, 3
	warp_event  3,  7, PEWTER_CITY, 3

	def_coord_events

	def_bg_events

	def_object_events
	mart_clerk_event  1,  3, MARTTYPE_STANDARD, MART_PEWTER
	object_event  9,  2, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, PewterMartYoungsterText, -1
	object_event  6,  6, SPRITE_POKEMANIAC, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, PewterMartSuperNerdText, -1

PewterMartYoungsterText:
	text "Hi! Check out my"
	line "Gyarados!"

	para "I raised it from a"
	line "Magikarp. I can't"

	para "believe how strong"
	line "it has become."
	done

PewterMartSuperNerdText:
	text "There once was a"
	line "weird old man who"
	cont "sold Magikarp."

	para "He was saying the"
	line "Magikarp from the"

	para "Lake of Rage were"
	line "excellent."
	done
