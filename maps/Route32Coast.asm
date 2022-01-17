Route32Coast_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4, 57, UNION_CAVE_B1F_SOUTH, 4
	warp_event 17, 51, ROUTE_32_COAST_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event 15, 29, BGEVENT_JUMPTEXT, Route32CoastTrainerTipsText
	bg_event  5, 59, BGEVENT_JUMPTEXT, Route32CoastUnionCaveSignText
	bg_event 17, 34, BGEVENT_ITEM + LEVEL_BALL, EVENT_ROUTE_32_COAST_HIDDEN_LEVEL_BALL
	bg_event  5, 45, BGEVENT_ITEM + HYPER_POTION, EVENT_ROUTE_32_COAST_HIDDEN_HYPER_POTION
	bg_event 14,  8, BGEVENT_ITEM + HYPER_POTION, EVENT_ROUTE_32_COAST_HIDDEN_ELIXIR

	def_object_events
	object_event  9,  5, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerSwimmermMichel, -1
	object_event 18, 67, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerSwimmermLucas, -1
	object_event 20,  8, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerSwimmerfAlison, -1
	object_event 23, 17, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerSwimmerfStephanie, -1
	object_event 18, 23, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerBird_keeperPowell, -1
	object_event 24, 62, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerFisherKiley, -1
	object_event  6, 22, SPRITE_CAMPER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerCamperCraig, -1
	object_event 11, 45, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerLassLayla, -1
	object_event 25, 35, SPRITE_COOL_DUDE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerCoupleFoxandrae1, -1
	object_event 25, 36, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerCoupleFoxandrae2, -1
	object_event  6, 61, SPRITE_LASS, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, Route32CoastLassText, -1
	fruittree_event 21, 51, FRUITTREE_ROUTE_32_COAST, ASPEAR_BERRY, PAL_NPC_BROWN
	itemball_event  5, 18, WHITE_HERB, 1, EVENT_ROUTE_32_COAST_WHITE_HERB
	itemball_event 22, 63, SOFT_SAND, 1, EVENT_ROUTE_32_COAST_SOFT_SAND

GenericTrainerSwimmermMichel:
	generictrainer SWIMMERM, MICHEL, EVENT_BEAT_SWIMMERM_MICHEL, .SeenText, .BeatenText

	ctxt "Lesson learned--"
	line "do warm-up exer-"
	cont "cises."
	done

.SeenText:
	ctxt "I was waiting"
	line "for you!"

	para "Let's battle!"
	line "Now!"
	done

.BeatenText:
	ctxt "Oh, ouch!"
	line "I got a cramp!"
	done

GenericTrainerSwimmermLucas:
	generictrainer SWIMMERM, LUCAS, EVENT_BEAT_SWIMMERM_LUCAS, .SeenText, .BeatenText

	ctxt "Rainbows caused by"
	line "sunlight appear"

	para "opposite the sun"
	line "in the sky."

	para "Interesting, huh?"
	done

.SeenText:
	ctxt "Reflecting and re-"
	line "fracting light"

	para "through water"
	line "droplets creates"
	cont "a rainbow."
	done

.BeatenText:
	ctxt "That battle was"
	line "full of color!"
	done

GenericTrainerSwimmerfAlison:
	generictrainer SWIMMERF, ALISON, EVENT_BEAT_SWIMMERF_ALISON, .SeenText, .BeatenText

	ctxt "Inhale…"
	line "Exhale…"

	para "Isn't this"
	line "refreshing?"
	done

.SeenText:
	ctxt "Before battling"
	line "you must breathe"
	cont "deeply."
	done

.BeatenText:
	ctxt "Glub… I inhaled"
	line "some seawater…"
	done

GenericTrainerSwimmerfStephanie:
	generictrainer SWIMMERF, STEPHANIE, EVENT_BEAT_SWIMMERF_STEPHANIE, .SeenText, .BeatenText

	ctxt "Sound travels"
	line "faster in water"
	cont "than in air."

	para "Neat, isn't it?"
	done

.SeenText:
	ctxt "Did you hear that?"
	done

.BeatenText:
	ctxt "Boo!"
	done

GenericTrainerBird_keeperPowell:
	generictrainer BIRD_KEEPER, POWELL, EVENT_BEAT_BIRD_KEEPER_POWELL, .SeenText, .BeatenText

	ctxt "My #mon can"
	line "use Fly even while"

	para "fainted, so I can"
	line "still get home."

	para "Convenient, eh?"
	done

.SeenText:
	ctxt "I can't swim, so"
	line "I flew here on my"
	cont "#mon."
	done

.BeatenText:
	ctxt "Oh no! My"
	line "#mon!"
	done

<<<<<<< HEAD
=======
GenericTrainerCosplayerChloe:
	generictrainer COSPLAYER, CHLOE, EVENT_BEAT_COSPLAYER_CHLOE, .SeenText, .BeatenText

	ctxt "When I'm dressed"
	line "like this, people"
	para "say I'm the cutest"
	line "wherever I go."
	done

.SeenText:
	ctxt "Like my costume?"
	line "It's super effect-"
	cont "ive!"
	done

.BeatenText:
	ctxt "Well, that wasn't"
	line "very effective…"
	done

>>>>>>> a0f2dd10f66795468601166436c9ccef9b074e9d
GenericTrainerFisherKiley:
	generictrainer FISHER, KILEY, EVENT_BEAT_FISHER_KILEY, .SeenText, .BeatenText

	ctxt "You have to have a"
	line "good Rod if you"

	para "want to catch good"
	line "#mon."
	done

.SeenText:
	ctxt "Heh, I'm on a roll"
	line "today. How about a"
	cont "battle, kid?"
	done

.BeatenText:
	ctxt "Oof. I wasn't"
	line "lucky that time."
	done

GenericTrainerCamperCraig:
	generictrainer CAMPER, CRAIG, EVENT_BEAT_CAMPER_CRAIG, .SeenText, .BeatenText

	ctxt "Adventure lives"
	line "outside your tent,"

	para "so get out there"
	line "and have a blast!"
	done

.SeenText:
	ctxt "Nothing beats the"
	line "great outdoors!"
	done

.BeatenText:
	ctxt "I'm one happy"
	line "Camper."
	done

GenericTrainerLassLayla:
	generictrainer LASS, LAYLA, EVENT_BEAT_LASS_LAYLA, .SeenText, .BeatenText

	ctxt "If you make a wish"
	line "and tell someone"
	cont "what it is, it"
	cont "won't come true!"
	done

.SeenText:
	ctxt "If you had one"
	line "wish, what would"
	cont "it be?"
	done

.BeatenText:
	ctxt "Don't tell me your"
	line "wish, though!"
	done

GenericTrainerCoupleFoxandrae1:
	generictrainer COUPLE, FOXANDRAE1, EVENT_BEAT_COUPLE_FOX_AND_RAE, .SeenText, .BeatenText

	ctxt "Fox: Our teamwork"
	line "as a Couple wasn't"
	cont "enough this time."
	done

.SeenText:
	ctxt "Fox: Come on, Rae,"
	line "let's battle!"
	done

.BeatenText:
	ctxt "Fox: You beat Rae"
	line "and me…"
	done

GenericTrainerCoupleFoxandrae2:
	generictrainer COUPLE, FOXANDRAE2, EVENT_BEAT_COUPLE_FOX_AND_RAE, .SeenText, .BeatenText

	ctxt "Rae: We lost, but"
	line "we're still a"
	cont "happy Couple."
	done

.SeenText:
	ctxt "Rae: Hey Fox, why"
	line "don't we have a"
	cont "battle?"
	done

.BeatenText:
	ctxt "Rae: How could you"
	line "beat Fox and me?"
	done

Route32CoastLassText:
	ctxt "Pant, pant…"

	para "I finally got"
	line "through that cave."

	para "It was much bigger"
	line "than I'd expected."

	para "I got too tired to"
	line "explore the whole"

	para "thing, so I came"
	line "outside."
	done

Route32CoastTrainerTipsText:
	ctxt "Trainer Tips"

	para "A #mon with the"
	line "Pickup ability"

	para "might hold an item"
	line "after a battle!"
	done

Route32CoastUnionCaveSignText:
	ctxt "Union Cave"
	line "Ahead"
	done
