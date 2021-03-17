Route34Coast_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events

	def_coord_events

	def_bg_events

	def_object_events
	object_event  7, 47, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSwimmermFrank, -1
	object_event 10, 21, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerSwimmermNadar, -1
	object_event  7, 61, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerSwimmermConrad, -1
	object_event  8, 43, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSwimmerfCaroline, -1
	object_event  8,  6, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSwimmerfNatalia, -1
	object_event 12, 14, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerFisherFrancis, -1
	object_event  7, 32, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerBird_keeperTony, -1
	itemball_event  4, 34, PEARL_STRING, 1, EVENT_ROUTE_34_COAST_PEARL_STRING

GenericTrainerSwimmermFrank:
	generictrainer SWIMMERM, FRANK, EVENT_BEAT_SWIMMERM_FRANK, .SeenText, .BeatenText

	text "Sea, sand, sun,"
	line "and #mon!"

	para "What more could a"
	line "guy need?"
	done

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

GenericTrainerSwimmermNadar:
	generictrainer SWIMMERM, NADAR, EVENT_BEAT_SWIMMERM_NADAR, .SeenText, .BeatenText

	text "Practice swimming,"
	line "or train with my"
	cont "#mon?"

	para "What a dilemma."
	done

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

GenericTrainerSwimmermConrad:
	generictrainer SWIMMERM, CONRAD, EVENT_BEAT_SWIMMERM_CONRAD, .SeenText, .BeatenText

	text "UV rays are refle-"
	line "cted by the waves."

	para "Always remember"
	line "sun lotion."
	done

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

GenericTrainerSwimmerfCaroline:
	generictrainer SWIMMERF, CAROLINE, EVENT_BEAT_SWIMMERF_CAROLINE, .SeenText, .BeatenText

	text "We're staying in"
	line "Goldenrod, but"

	para "this Route makes"
	line "for a lovely"
	cont "excursion!"
	done

.SeenText:
	text "My husband and I"
	line "are here on a"
	cont "vacation."
	done

.BeatenText:
	text "Oh! What a shame."
	done

GenericTrainerSwimmerfNatalia:
	generictrainer SWIMMERF, NATALIA, EVENT_BEAT_SWIMMERF_NATALIA, .SeenText, .BeatenText

	text "I think I bought"
	line "the wrong bikini."

	para "This really isn't"
	line "my color."
	done

.SeenText:
	text "I bought a new"
	line "bikini."

	para "It's the latest"
	line "fashion."
	done

.BeatenText:
	text "Bah!"
	done

GenericTrainerFisherFrancis:
	generictrainer FISHER, FRANCIS, EVENT_BEAT_FISHER_FRANCIS, .SeenText, .BeatenText

	text "It doesn't matter"
	line "if I win or lose."

	para "I just want to"
	line "have fun and keep"
	cont "fishing."
	done

.SeenText:
	text "I like fishing for"
	line "#mon in exotic"
	cont "places."
	done

.BeatenText:
	text "Oh! What a great"
	line "hit!"
	done

GenericTrainerBird_keeperTony:
	generictrainer BIRD_KEEPER, BIRD_KEEPER_TONY, EVENT_BEAT_BIRD_KEEPER_TONY, .SeenText, .BeatenText

	text "Everybody's heard"
	line "that the bird is"
	cont "the word."
	done

.SeenText:
	text "Have you heard"
	line "about the bird?"
	done

.BeatenText:
	text "Don't you know"
	line "about the bird?"
	done

