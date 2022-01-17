Route21_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events

	def_coord_events

	def_bg_events
	bg_event 12, 37, BGEVENT_ITEM + STARDUST, EVENT_ROUTE_21_HIDDEN_STARDUST_1
	bg_event  5, 66, BGEVENT_ITEM + STARDUST, EVENT_ROUTE_21_HIDDEN_STARDUST_2

	def_object_events
	object_event  8, 13, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSwimmerfNikki, -1
	object_event  3, 29, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerSwimmerfChelan, -1
	object_event  5, 45, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSwimmerfKendra, -1
	object_event 16, 72, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerSwimmermEsteban, -1
	object_event 15, 85, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSwimmermDuane, -1
	object_event  2, 89, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerSwimmermSeth, -1
	object_event  5, 21, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerFisherMurphy, -1
	object_event 15, 25, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerFisherArnold, -1
	object_event  7, 36, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerFisherLiam, -1
	object_event  5, 56, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerFisherGideon, -1
	object_event 15, 62, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerBird_keeperKinsley, -1
	object_event  7, 83, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerBird_keeperEaston, -1
	itemball_event 13, 26, STAR_PIECE, 1, EVENT_ROUTE_21_STAR_PIECE

GenericTrainerSwimmerfNikki:
	generictrainer SWIMMERF, NIKKI, EVENT_BEAT_SWIMMERF_NIKKI, SwimmerfNikkiSeenText, SwimmerfNikkiBeatenText

	ctxt "I have to watch"
	line "out for blemishes"
	cont "caused by the sun."
	done

SwimmerfNikkiSeenText:
	ctxt "If I win, you have"
	line "to help me with my"
	cont "suntan lotion!"
	done

SwimmerfNikkiBeatenText:
	ctxt "I'm worried about"
	line "sunburn…"
	done

GenericTrainerSwimmerfChelan:
	generictrainer SWIMMERF, CHELAN, EVENT_BEAT_SWIMMERF_CHELAN, .SeenText, .BeatenText

	ctxt "I suppose an elec-"
	line "tric bikini would"
	cont "give you a shock!"
	done

.SeenText:
	ctxt "I love bikinis!"

	para "If I had an elec-"
	line "tric bikini, I"

	para "could wear it even"
	line "in winter!"
	done

.BeatenText:
	ctxt "Awww…"
	done

GenericTrainerSwimmerfKendra:
	generictrainer SWIMMERF, KENDRA, EVENT_BEAT_SWIMMERF_KENDRA, .SeenText, .BeatenText

	ctxt "I wonder if any"
	line "place sells swim-"
	cont "suits for #-"
	cont "mon?"
	done

.SeenText:
	ctxt "Hey, trainer!"
	line "How about you put"
	cont "on a swimsuit too?"
	done

.BeatenText:
	ctxt "I didn't want to"
	line "lose…"
	done

GenericTrainerSwimmermEsteban:
	generictrainer SWIMMERM, ESTEBAN, EVENT_BEAT_SWIMMERM_ESTEBAN, .SeenText, .BeatenText

	ctxt "We called our"
	line "teacher Professor"
	cont "Poliwhirl!"
	done

.SeenText:
	ctxt "My swimming teach-"
	line "er had a face just"
	cont "like a Poliwhirl."
	done

.BeatenText:
	ctxt "I'm sorry,"
	line "Teacher…"
	done

GenericTrainerSwimmermDuane:
	generictrainer SWIMMERM, DUANE, EVENT_BEAT_SWIMMERM_DUANE, .SeenText, .BeatenText

	ctxt "To win more, I"
	line "need to work on"
	cont "my stamina!"
	done

.SeenText:
	ctxt "Swimming is full-"
	line "body exercise."

	para "It really builds"
	line "your strength!"
	done

.BeatenText:
	ctxt "My #mon and I"
	line "have no strength…"
	done

GenericTrainerSwimmermSeth:
	generictrainer SWIMMERM, SETH, EVENT_BEAT_SWIMMERM_SETH, SwimmermSethSeenText, SwimmermSethBeatenText

	ctxt "This arrogant guy"
	line "was at Cinnabar's"
	cont "volcano."
	done

SwimmermSethSeenText:
	ctxt "Land ho! Gotta"
	line "keep going!"
	done

SwimmermSethBeatenText:
	ctxt "Glug…"
	done

GenericTrainerFisherMurphy:
	generictrainer FISHER, MURPHY, EVENT_BEAT_FISHER_MURPHY, .SeenText, .BeatenText

	ctxt "The #mon that"
	line "escaped me was"
	cont "huge."

	para "It's the truth!"
	done

.SeenText:
	ctxt "Huh? I've caught"
	line "a trainer instead"
	cont "of a #mon!"
	done

.BeatenText:
	ctxt "My fishing line"
	line "got cut!"
	done

GenericTrainerFisherArnold:
	generictrainer FISHER, ARNOLD, EVENT_BEAT_FISHER_ARNOLD, FisherArnoldSeenText, FisherArnoldBeatenText

	ctxt "I'll just go back"
	line "to fishing…"
	done

FisherArnoldSeenText:
	ctxt "I'm bored by fish-"
	line "ing. Let's battle!"
	done

FisherArnoldBeatenText:
	ctxt "Utter failure…"
	done

GenericTrainerFisherLiam:
	generictrainer FISHER, LIAM, EVENT_BEAT_FISHER_LIAM, .SeenText, .BeatenText

	ctxt "I should've asked"
	line "you to wait until"

	para "I reeled that"
	line "#mon in…"
	done

.SeenText:
	ctxt "Whoa! A nibble!"

	para "…Huh?"
	line "A battle?"

	para "OK, let's go!"
	done

.BeatenText:
	ctxt "If you chase two"
	line "#mon, you"

	para "won't catch either"
	line "one!"
	done

GenericTrainerFisherGideon:
	generictrainer FISHER, GIDEON, EVENT_BEAT_FISHER_GIDEON, .SeenText, .BeatenText

	ctxt "What's the reason"
	line "you became a"
	cont "#mon trainer?"
	done

.SeenText:
	ctxt "Did I become a"
	line "Fisherman because"
	cont "I'm patient, or"

	para "did I get more"
	line "patient because"
	cont "I'm a Fisherman?"
	done

.BeatenText:
	ctxt "Ummm… Hmmm…"
	done

GenericTrainerBird_keeperKinsley:
	generictrainer BIRD_KEEPER, KINSLEY, EVENT_BEAT_BIRD_KEEPER_KINSLEY, .SeenText, .BeatenText

	ctxt "I just need to"
	line "practice flapping"
	cont "my wings more!"
	done

.SeenText:
	ctxt "Someday I might be"
	line "able to fly like"
	cont "my bird #mon!"
	done

.BeatenText:
	ctxt "I couldn't fly…"
	done

GenericTrainerBird_keeperEaston:
	generictrainer BIRD_KEEPER, EASTON, EVENT_BEAT_BIRD_KEEPER_EASTON, .SeenText, .BeatenText

	ctxt "We think we're"
	line "using #mon."

	para "But at some point,"
	line "the #mon start-"
	cont "ed using us…"
	done

.SeenText:
	ctxt "Bird Keepers are"
	line "so wonderful with"
	cont "their bird #-"
	cont "mon!"
	done

.BeatenText:
	ctxt "I couldn't handle"
	line "it…"
	done

