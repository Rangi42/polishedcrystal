Route16West_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 1 ; warp events
	warp_event 35,  1, PSYCHIC_INVERS_HOUSE, 1

	db 0 ; coord events

	db 2 ; bg events
	bg_event 59,  2, SIGNPOST_JUMPTEXT, Route16WestSignpostText
	bg_event 24,  5, SIGNPOST_ITEM + RARE_CANDY, EVENT_ROUTE_16_WEST_HIDDEN_RARE_CANDY

	db 10 ; object events
	object_event 56,  7, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 2, TrainerLassGina, -1
	object_event 17,  7, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 5, TrainerLassAlice, -1
	object_event  9, 12, SPRITE_COSPLAYER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 2, TrainerCosplayerKuroko, -1
	object_event 40, 11, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerCooltrainerfSera, -1
	object_event  6,  2, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerBeautyNicole, -1
	itemball_event 42, 14, METRONOME_I, 1, EVENT_ROUTE_16_WEST_METRONOME
	itemball_event 51,  2, PP_UP, 1, EVENT_ROUTE_16_WEST_PP_UP
	itemball_event 21,  2, MAX_REVIVE, 1, EVENT_ROUTE_16_WEST_MAX_REVIVE
	cuttree_event  3,  7, EVENT_ROUTE_16_WEST_CUT_TREE_1
	cuttree_event 57,  2, EVENT_ROUTE_16_WEST_CUT_TREE_2

TrainerLassGina:
	trainer LASS, GINA, EVENT_BEAT_LASS_GINA, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Check out my new"
	line "outfit!"
	done

.BeatenText:
	text "If I'd spent money"
	line "on Potions instead"
	cont "of clothes…"
	done

.AfterText:
	text "My strappy sandals"
	line "look sooo cute,"
	cont "though! ♥"
	done

TrainerLassAlice:
	trainer LASS, ALICE, EVENT_BEAT_LASS_ALICE, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Our eyes met!"

	para "Now you must date"
	line "me! ♥"

	para "No wait, I mean,"
	line "we must battle!"
	done

.BeatenText:
	text "How could you be"
	line "so cruel?"
	done

.AfterText:
	text "I'm really a guy…"
	line "Don't tell anyone!"
	done

TrainerCosplayerKuroko:
	trainer COSPLAYER, KUROKO, EVENT_BEAT_COSPLAYER_KUROKO, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "See how lifelike"
	line "my cosplay is?"
	done

.BeatenText:
	text "You just don't"
	line "appreciate art!"
	done

.AfterText:
	text "One time a trainer"
	line "threw a # Ball"
	cont "at me!"
	done

TrainerCooltrainerfSera:
	trainer COOLTRAINERF, SERA, EVENT_BEAT_COOLTRAINERF_SERA, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Do you think you"
	line "can handle me?"
	done

.BeatenText:
	text "Congrats! ♥"
	done

.AfterText:
	text "I've gone out as a"
	line "a Cosplayer, but"

	para "an Ace Trainer's"
	line "outfit is more"
	cont "intimidating."
	done

TrainerBeautyNicole:
	trainer BEAUTY, BEAUTY_NICOLE, EVENT_BEAT_BEAUTY_NICOLE, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Aren't my #mon"
	line "the cutest?"
	done

.BeatenText:
	text "They're even cute"
	line "while fainted…"
	done

.AfterText:
	text "Cute #mon can"
	line "be strong too,"
	cont "you know!"
	done

Route16WestSignpostText:
	text "Route 16"
	done
