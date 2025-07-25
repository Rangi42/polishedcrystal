OlsteetonDiner_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  8,  9, OLSTEETON, 15
	warp_event  9,  9, OLSTEETON, 15

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

	para "We're holding a"
	line "Spaghetti contest."

	para "We can't serve you"
	line "right now. Sorry."
	done

OlsteetonDinerFatGuy1:
	text "…Snarfle, chew…"
	line "Don't talk to me!"

	para "You'll break my"
	line "concentration!"
	done

OlsteetonDinerFatGuy2:
	text "…Gulp… Chew…"
	line "I take quantity"
	cont "over quality!"

	para "I'm happy when I'm"
	line "full!"
	done

OlsteetonDinerFatGuy3:
	text "Munch, munch…"
	line "The food is good"

	para "here, but Olste-"
	line "eeton has the"
	cont "best food"
	cont "anywhere."
	done

OlsteetonDinerBeauty:
	text "Crunch… Crunch…"
	line "Crunch… Crunch…"

	para "I can keep eating!"
	line "More, Chef!"
	done

OlsteetonDinerBakerText:
	text "I'm working here"
	line "'cause I get to"

	para "eat any time I"
	line "want. Simple."
	done

OlsteetonDinerPosterText:
	text "Spaghetti Contest!"
	line "No time limit!"

	para "A battle without"
	line "end! The biggest"

	para "muncher gets it"
	line "all for free!"
	done

OlsteetonDinerTrashCanText:
	text "The trash is full"
	line "of Spaghetti left-"
	cont "overs…"
	done
