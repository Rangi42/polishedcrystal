OlsteetonAbandonedMill_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  8, 17, OLSTEETON_ABANDONED_MILL_OUTSIDE, 1
	warp_event  9, 17, OLSTEETON_ABANDONED_MILL_OUTSIDE, 1

	def_coord_events

	def_bg_events

	def_object_events
	itemball_event 13, 10, ETHER, 1, EVENT_GOLDENROD_DEPT_STORE_B1F_ETHER
	itemball_event  0, 12, METAL_COAT, 1, EVENT_GOLDENROD_DEPT_STORE_B1F_METAL_COAT
	itemball_event 13,  4, BURN_HEAL, 1, EVENT_GOLDENROD_DEPT_STORE_B1F_BURN_HEAL
	itemball_event  2,  7, ULTRA_BALL, 1, EVENT_GOLDENROD_DEPT_STORE_B1F_ULTRA_BALL
	object_event  3, 12, SPRITE_BLACK_BELT, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonAbandonedMillBlackBelt1Text, -1
	object_event 11,  5, SPRITE_ENGINEER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonAbandonedMillBlackBelt2Text, -1
	object_event 15, 12, SPRITE_FIREBREATHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonAbandonedMillBlackBelt3Text, -1
	pokemon_event  2,  5, MACHOKE, SPRITEMOVEDATA_POKEMON, -1, PAL_NPC_GRAY, OlsteetonAbandonedMillMachokeText, -1

OlsteetonAbandonedMillBlackBelt1Text:
	text "We're not"
	line "givin' up"
	cont "on the mill!"

	para "This is where"
	line "my pappy worked"

	para "and his pappy"
	line "before him."

	para "I don't give"
	line "a Hoot-Hoot"

	para "what Rusty or"
	line "any of those"

	para "Megacorp grunts"
	line "have to say!"
	done
;come back and add event script to make him keep yappin bout his pappies
OlsteetonAbandonedMillBlackBelt2Text:
	text "What in"
	line "tarnation are you"
	cont "doing here?"

	para "Nobody is"
	line "supposed to know"
	cont "we're here..."
	done

OlsteetonAbandonedMillBlackBelt3Text:
	text "Oohah! Oohah!"

	para "The stuff on the"
	line "ground's junk."

	para "Take it if you"
	line "want it!"
	done

OlsteetonAbandonedMillMachokeText:
	text "Machoke: Maaacho!"
	done
