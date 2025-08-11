OlsteetonDiner_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  8,  9, OLSTEETON, 13
	warp_event  9,  9, OLSTEETON, 13

	def_coord_events

	def_bg_events
	bg_event  0,  0, BGEVENT_JUMPTEXT, OlsteetonDinerPosterText
	bg_event  1,  1, BGEVENT_JUMPTEXT, OlsteetonDinerTrashCanText

	def_object_events
	object_event 15,  1, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonDinerBeauty, -1
	object_event 14,  8, SPRITE_ENGINEER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonDinerFatGuy1, -1
	object_event  1,  3, SPRITE_FAT_GUY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonDinerFatGuy2, -1
	object_event 12,  1, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonDinerFatGuy3, -1
	object_event 10,  2, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, ChefText_Spaghetti, -1
	object_event  6,  2, SPRITE_BAKER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonDinerBakerText, -1

	object_const_def


ChefText_Spaghetti:
	text "Hi!"

	para "We're hosting a"
	line "private party."

	para "We can't serve you"
	line "right now. Sorry."
	done

OlsteetonDinerFatGuy1:
	text "…Snarfle, chew…"
	line "Who even are you!"
	done

OlsteetonDinerFatGuy2:
	text "…Gulp… Chew…"
	line "Who invited"
	cont "the kid?"
	done

OlsteetonDinerFatGuy3:
	text "Munch, munch…"
	line "The food is good"

	para "here, but the"
	line "service leaves"
	cont "something to be"
	cont "desired..."
	done

OlsteetonDinerBeauty:
	text "Crunch… Crunch…"
	line "Crunch… Crunch…"

	para "More garlic"
	line "bread, waiter!"
	done

OlsteetonDinerBakerText:
	text "I knew I should"
	line "have called off"
	cont "today."
	done

OlsteetonDinerPosterText:
	text "Olsteeton Diner!"
	line "The very best"

	para "spaghetti that"
	line "money can buy!"
	done

OlsteetonDinerTrashCanText:
	text "The trash is full"
	line "of Spaghetti left-"
	cont "overs…"
	done
