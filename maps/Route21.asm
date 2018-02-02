Route21_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 0 ; warp events

	db 0 ; coord events

	db 2 ; bg events
	bg_event 12, 37, SIGNPOST_ITEM + STARDUST, EVENT_ROUTE_21_HIDDEN_STARDUST_1
	bg_event  5, 66, SIGNPOST_ITEM + STARDUST, EVENT_ROUTE_21_HIDDEN_STARDUST_2

	db 13 ; object events
	object_event  8, 13, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerSwimmerfNikki, -1
	object_event  3, 29, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 4, TrainerSwimmerfChelan, -1
	object_event  5, 45, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerSwimmerfKendra, -1
	object_event 16, 72, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 5, TrainerSwimmermEsteban, -1
	object_event 15, 85, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerSwimmermDuane, -1
	object_event  2, 89, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 4, TrainerSwimmermSeth, -1
	object_event  5, 21, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerFisherMurphy, -1
	object_event 15, 25, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerFisherArnold, -1
	object_event  7, 36, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerFisherLiam, -1
	object_event  5, 56, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerFisherGideon, -1
	object_event 15, 62, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerBird_keeperKinsley, -1
	object_event  7, 83, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerBird_keeperEaston, -1
	itemball_event 13, 26, STAR_PIECE, 1, EVENT_ROUTE_21_STAR_PIECE

TrainerSwimmerfNikki:
	trainer SWIMMERF, NIKKI, EVENT_BEAT_SWIMMERF_NIKKI, SwimmerfNikkiSeenText, SwimmerfNikkiBeatenText, 0, SwimmerfNikkiScript

SwimmerfNikkiScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1ac8f1

SwimmerfNikkiSeenText:
	text "If I win, you have"
	line "to help me with my"
	cont "suntan lotion!"
	done

SwimmerfNikkiBeatenText:
	text "I'm worried about"
	line "sunburn…"
	done

UnknownText_0x1ac8f1:
	text "I have to watch"
	line "out for blemishes"
	cont "caused by the sun."
	done

TrainerSwimmerfChelan:
	trainer SWIMMERF, CHELAN, EVENT_BEAT_SWIMMERF_CHELAN, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "I love bikinis!"

	para "If I had an elec-"
	line "tric bikini, I"

	para "could wear it even"
	line "in winter!"
	done

.BeatenText:
	text "Awww…"
	done

.AfterText:
	text "I suppose an elec-"
	line "tric bikini would"
	cont "give you a shock!"
	done

TrainerSwimmerfKendra:
	trainer SWIMMERF, KENDRA, EVENT_BEAT_SWIMMERF_KENDRA, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Hey, trainer!"
	line "How about you put"
	cont "on a swimsuit too?"
	done

.BeatenText:
	text "I didn't want to"
	line "lose…"
	done

.AfterText:
	text "I wonder if any"
	line "place sells swim-"
	cont "suits for #-"
	cont "mon?"
	done

TrainerSwimmermEsteban:
	trainer SWIMMERM, ESTEBAN, EVENT_BEAT_SWIMMERM_ESTEBAN, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "My swimming teach-"
	line "er had a face just"
	cont "like a Poliwhirl."
	done

.BeatenText:
	text "I'm sorry,"
	line "Teacher…"
	done

.AfterText:
	text "We called our"
	line "teacher Professor"
	cont "Poliwhirl!"
	done

TrainerSwimmermDuane:
	trainer SWIMMERM, DUANE, EVENT_BEAT_SWIMMERM_DUANE, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Swimming is full-"
	line "body exercise."

	para "It really builds"
	line "your strength!"
	done

.BeatenText:
	text "My #mon and I"
	line "have no strength…"
	done

.AfterText:
	text "To win more, I"
	line "need to work on"
	cont "my stamina!"
	done

TrainerSwimmermSeth:
	trainer SWIMMERM, SETH, EVENT_BEAT_SWIMMERM_SETH, SwimmermSethSeenText, SwimmermSethBeatenText, 0, SwimmermSethScript

SwimmermSethScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1ac873

SwimmermSethSeenText:
	text "Land ho! Gotta"
	line "keep going!"
	done

SwimmermSethBeatenText:
	text "Glug…"
	done

UnknownText_0x1ac873:
	text "This arrogant guy"
	line "was at Cinnabar's"
	cont "volcano."
	done

TrainerFisherMurphy:
	trainer FISHER, MURPHY, EVENT_BEAT_FISHER_MURPHY, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Huh? I've caught"
	line "a trainer instead"
	cont "of a #mon!"
	done

.BeatenText:
	text "My fishing line"
	line "got cut!"
	done

.AfterText:
	text "The #mon that"
	line "escaped me was"
	cont "huge."

	para "It's the truth!"
	done

TrainerFisherArnold:
	trainer FISHER, ARNOLD, EVENT_BEAT_FISHER_ARNOLD, FisherArnoldSeenText, FisherArnoldBeatenText, 0, FisherArnoldScript

FisherArnoldScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1ac95c

FisherArnoldSeenText:
	text "I'm bored by fish-"
	line "ing. Let's battle!"
	done

FisherArnoldBeatenText:
	text "Utter failure…"
	done

UnknownText_0x1ac95c:
	text "I'll just go back"
	line "to fishing…"
	done

TrainerFisherLiam:
	trainer FISHER, LIAM, EVENT_BEAT_FISHER_LIAM, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Whoa! A nibble!"

	para "…Huh?"
	line "A battle?"

	para "OK, let's go!"
	done

.BeatenText:
	text "If you chase two"
	line "#mon, you"

	para "won't catch either"
	line "one!"
	done

.AfterText:
	text "I should've asked"
	line "you to wait until"

	para "I reeled that"
	line "#mon in…"
	done

TrainerFisherGideon:
	trainer FISHER, GIDEON, EVENT_BEAT_FISHER_GIDEON, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Did I become a"
	line "Fisherman because"
	cont "I'm patient, or"

	para "did I get more"
	line "patient because"
	cont "I'm a Fisherman?"
	done

.BeatenText:
	text "Ummm… Hmmm…"
	done

.AfterText:
	text "What's the reason"
	line "you became a"
	cont "#mon trainer?"
	done

TrainerBird_keeperKinsley:
	trainer BIRD_KEEPER, KINSLEY, EVENT_BEAT_BIRD_KEEPER_KINSLEY, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Someday I might be"
	line "able to fly like"
	cont "my bird #mon!"
	done

.BeatenText:
	text "I couldn't fly…"
	done

.AfterText:
	text "I just need to"
	line "practice flapping"
	cont "my wings more!"
	done

TrainerBird_keeperEaston:
	trainer BIRD_KEEPER, EASTON, EVENT_BEAT_BIRD_KEEPER_EASTON, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Bird Keepers are"
	line "so wonderful with"
	cont "their bird #-"
	cont "mon!"
	done

.BeatenText:
	text "I couldn't handle"
	line "it…"
	done

.AfterText:
	text "We think we're"
	line "using #mon."

	para "But at some point,"
	line "the #mon start-"
	cont "ed using us…"
	done
