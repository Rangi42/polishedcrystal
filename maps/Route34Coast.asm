Route34Coast_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 0 ; warp events

	db 0 ; coord events

	db 0 ; bg events

	db 8 ; object events
	object_event  7, 45, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerSwimmermFrank, -1
	object_event  9, 19, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 4, TrainerSwimmermNadar, -1
	object_event  8, 61, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 5, TrainerSwimmermConrad, -1
	object_event  8, 42, SPRITE_GOLDENROD_LYRA, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerSwimmerfCaroline, -1
	object_event  8,  6, SPRITE_GOLDENROD_LYRA, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerSwimmerfNatalia, -1
	object_event  8, 29, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerFisherFrancis, -1
	object_event  6, 32, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 2, TrainerBird_keeperTony, -1
	itemball_event  4, 34, PEARL_STRING, 1, EVENT_ROUTE_34_COAST_PEARL_STRING

TrainerSwimmermFrank:
	trainer SWIMMERM, FRANK, EVENT_BEAT_SWIMMERM_FRANK, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "I'm vacationing"
	line "with my wife, but"
	cont "OK--I'll battle"
	cont "you."
	done

.BeatenText:
	text "I don't care,"
	line "I'm on vacation!"
	done

.AfterText:
	text "Sea, sand, sun,"
	line "and #mon!"

	para "What more could a"
	line "guy need?"
	done

TrainerSwimmermNadar:
	trainer SWIMMERM, NADAR, EVENT_BEAT_SWIMMERM_NADAR, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Swimming is my"
	line "speciality!"

	para "#mon battles"
	line "are too!"
	done

.BeatenText:
	text "I lost at my own"
	line "speciality?"
	done

.AfterText:
	text "Practice swimming,"
	line "or train with my"
	cont "#mon?"

	para "What a dilemma."
	done

TrainerSwimmermConrad:
	trainer SWIMMERM, CONRAD, EVENT_BEAT_SWIMMERM_CONRAD, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Lotion on, goggles"
	line "down… I'm all"

	para "fired up to hit"
	line "the waves!"
	done

.BeatenText:
	text "Oof! The waves"
	line "hit me this time."
	done

.AfterText:
	text "UV rays are refle-"
	line "cted by the waves."

	para "Always remember"
	line "sun lotion."
	done

TrainerSwimmerfCaroline:
	trainer SWIMMERF, CAROLINE, EVENT_BEAT_SWIMMERF_CAROLINE, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "My husband and I"
	line "are here on a"
	cont "vacation."
	done

.BeatenText:
	text "Oh! What a shame."
	done

.AfterText:
	text "We're staying in"
	line "Goldenrod, but"

	para "this Route makes"
	line "for a lovely"
	cont "excursion!"
	done

TrainerSwimmerfNatalia:
	trainer SWIMMERF, NATALIA, EVENT_BEAT_SWIMMERF_NATALIA, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "I bought a new"
	line "bikini."

	para "It's the latest"
	line "fashion."
	done

.BeatenText:
	text "Bah!"
	done

.AfterText:
	text "I think I bought"
	line "the wrong bikini."

	para "This really isn't"
	line "my color."
	done

TrainerFisherFrancis:
	trainer FISHER, FRANCIS, EVENT_BEAT_FISHER_FRANCIS, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "I like fishing for"
	line "#mon in exotic"
	cont "places."
	done

.BeatenText:
	text "Oh! What a great"
	line "hit!"
	done

.AfterText:
	text "It doesn't matter"
	line "if I win or lose."

	para "I just want to"
	line "have fun and keep"
	cont "fishing."
	done

TrainerBird_keeperTony:
	trainer BIRD_KEEPER, BIRD_KEEPER_TONY, EVENT_BEAT_BIRD_KEEPER_TONY, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Have you heard"
	line "about the bird?"
	done

.BeatenText:
	text "Don't you know"
	line "about the bird?"
	done

.AfterText:
	text "Everybody's heard"
	line "that the bird is"
	cont "the word."
	done

