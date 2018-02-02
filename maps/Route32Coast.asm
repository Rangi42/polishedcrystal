Route32Coast_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event 4, 57, UNION_CAVE_B1F_SOUTH, 4
	warp_event 17, 51, ROUTE_32_COAST_HOUSE, 1

	db 0 ; coord events

	db 4 ; bg events
	bg_event 15, 29, SIGNPOST_JUMPTEXT, Route32CoastTrainerTipsText
	bg_event 5, 59, SIGNPOST_JUMPTEXT, Route32CoastUnionCaveSignText
	bg_event 17, 34, SIGNPOST_ITEM + LEVEL_BALL, EVENT_ROUTE_32_COAST_HIDDEN_LEVEL_BALL
	bg_event 5, 45, SIGNPOST_ITEM + HYPER_POTION, EVENT_ROUTE_32_COAST_HIDDEN_HYPER_POTION

	db 15 ; object events
	object_event 9, 5, SPRITE_GUIDE_GENT, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 4, TrainerSwimmermMichel, -1
	object_event 18, 67, SPRITE_GUIDE_GENT, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 4, TrainerSwimmermLucas, -1
	object_event 20, 8, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 4, TrainerSwimmerfAlison, -1
	object_event 23, 17, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 4, TrainerSwimmerfStephanie, -1
	object_event 18, 23, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 5, TrainerBird_keeperPowell, -1
	object_event 14, 62, SPRITE_COSPLAYER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerCosplayerChloe, -1
	object_event 24, 62, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerFisherKiley, -1
	object_event 6, 22, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 2, TrainerCamperCraig, -1
	object_event 11, 45, SPRITE_NEW_BARK_LYRA, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 2, TrainerLassLayla, -1
	object_event 25, 35, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerCoupleFoxandrae1, -1
	object_event 25, 36, SPRITE_NEW_BARK_LYRA, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerCoupleFoxandrae2, -1
	object_event 6, 61, SPRITE_NEW_BARK_LYRA, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, Route32CoastLassText, -1
	fruittree_event 21, 51, FRUITTREE_ROUTE_32_COAST, ASPEAR_BERRY
	itemball_event 5, 18, WHITE_HERB, 1, EVENT_ROUTE_32_COAST_WHITE_HERB
	itemball_event 22, 63, SOFT_SAND, 1, EVENT_ROUTE_32_COAST_SOFT_SAND

TrainerSwimmermMichel:
	trainer SWIMMERM, MICHEL, EVENT_BEAT_SWIMMERM_MICHEL, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "I was waiting"
	line "for you!"

	para "Let's battle!"
	line "Now!"
	done

.BeatenText:
	text "Oh, ouch!"
	line "I got a cramp!"
	done

.AfterText:
	text "Lesson learned--"
	line "do warm-up exer-"
	cont "cises."
	done

TrainerSwimmermLucas:
	trainer SWIMMERM, LUCAS, EVENT_BEAT_SWIMMERM_LUCAS, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Reflecting and re-"
	line "fracting light"

	para "through water"
	line "droplets creates"
	cont "a rainbow."
	done

.BeatenText:
	text "That battle was"
	line "full of color!"
	done

.AfterText:
	text "Rainbows caused by"
	line "sunlight appear"

	para "opposite the sun"
	line "in the sky."

	para "Interesting, huh?"
	done

TrainerSwimmerfAlison:
	trainer SWIMMERF, ALISON, EVENT_BEAT_SWIMMERF_ALISON, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Before battling"
	line "you must breathe"
	cont "deeply."
	done

.BeatenText:
	text "Glub… I inhaled"
	line "some seawater…"
	done

.AfterText:
	text "Inhale…"
	line "Exhale…"

	para "Isn't this"
	line "refreshing?"
	done

TrainerSwimmerfStephanie:
	trainer SWIMMERF, STEPHANIE, EVENT_BEAT_SWIMMERF_STEPHANIE, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Did you hear that?"
	done

.BeatenText:
	text "Boo!"
	done

.AfterText:
	text "Sound travels"
	line "faster in water"
	cont "than in air."

	para "Neat, isn't it?"
	done

TrainerBird_keeperPowell:
	trainer BIRD_KEEPER, POWELL, EVENT_BEAT_BIRD_KEEPER_POWELL, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "I can't swim, so"
	line "I flew here on my"
	cont "#mon."
	done

.BeatenText:
	text "Oh no! My"
	line "#mon!"
	done

.AfterText:
	text "My Pokemon can"
	line "use Fly even while"

	para "fainted, so I can"
	line "still get home."

	para "Convenient, eh?"
	done

TrainerCosplayerChloe:
	trainer COSPLAYER, CHLOE, EVENT_BEAT_COSPLAYER_CHLOE, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Like my costume?"
	line "It's super-effect-"
	cont "ive!"
	done

.BeatenText:
	text "Well, that wasn't"
	line "very effective…"
	done

.AfterText:
	text "When I'm dressed"
	line "like this, people"
	para "say I'm the cutest"
	line "wherever I go."
	done

TrainerFisherKiley:
	trainer FISHER, KILEY, EVENT_BEAT_FISHER_KILEY, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Heh, I'm on a roll"
	line "today. How about a"
	cont "battle, kid?"
	done

.BeatenText:
	text "Oof. I wasn't"
	line "lucky that time."
	done

.AfterText:
	text "You have to have a"
	line "good Rod if you"

	para "want to catch good"
	line "#mon."
	done

TrainerCamperCraig:
	trainer CAMPER, CRAIG, EVENT_BEAT_CAMPER_CRAIG, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Nothing beats the"
	line "great outdoors!"
	done

.BeatenText:
	text "I'm one happy"
	line "Camper."
	done

.AfterText:
	text "Adventure lives"
	line "outside your tent,"

	para "so get out there"
	line "and have a blast!"
	done

TrainerLassLayla:
	trainer LASS, LAYLA, EVENT_BEAT_LASS_LAYLA, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "If you had one"
	line "wish, what would"
	cont "it be?"
	done

.BeatenText:
	text "Don't tell me your"
	line "wish, though!"
	done

.AfterText:
	text "If you make a wish"
	line "and tell someone"
	cont "what it is, it"
	cont "won't come true!"
	done

TrainerCoupleFoxandrae1:
	trainer COUPLE, FOXANDRAE1, EVENT_BEAT_COUPLE_FOX_AND_RAE, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Fox: Come on, Rae,"
	line "let's battle!"
	done

.BeatenText:
	text "Fox: You beat Rae"
	line "and me…"
	done

.AfterText:
	text "Fox: Our teamwork"
	line "as a Couple wasn't"
	cont "enough this time."
	done

TrainerCoupleFoxandrae2:
	trainer COUPLE, FOXANDRAE2, EVENT_BEAT_COUPLE_FOX_AND_RAE, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Rae: Hey Fox, why"
	line "don't we have a"
	cont "battle?"
	done

.BeatenText:
	text "Rae: How could you"
	line "beat Fox and me?"
	done

.AfterText:
	text "Rae: We lost, but"
	line "we're still a"
	cont "happy Couple."
	done

Route32CoastLassText:
	text "Pant, pant…"

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
	text "Trainer Tips"

	para "A #mon with the"
	line "Pickup ability"

	para "might hold an item"
	line "after a battle!"
	done

Route32CoastUnionCaveSignText:
	text "Union Cave"
	line "Ahead"
	done
