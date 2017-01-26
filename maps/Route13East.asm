const_value set 2
	const ROUTE13EAST_YOUNGSTER1
	const ROUTE13EAST_YOUNGSTER2
	const ROUTE13EAST_POKEFAN_M1
	const ROUTE13EAST_POKEFAN_M2
	const ROUTE13EAST_CUT_TREE

Route13East_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TrainerPokefanmAlex:
	trainer EVENT_BEAT_POKEFANM_ALEX, POKEFANM, ALEX, PokefanmAlexSeenText, PokefanmAlexBeatenText, 0, PokefanmAlexScript

PokefanmAlexScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1a24e3
	waitbutton
	closetext
	end

TrainerPokefanmJoshua:
	trainer EVENT_BEAT_POKEFANM_JOSHUA, POKEFANM, JOSHUA, PokefanmJoshuaSeenText, PokefanmJoshuaBeatenText, 0, PokefanmJoshuaScript

PokefanmJoshuaScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1a254f
	waitbutton
	closetext
	end

TrainerBird_keeperPerry:
	trainer EVENT_BEAT_BIRD_KEEPER_PERRY, BIRD_KEEPER, PERRY, Bird_keeperPerrySeenText, Bird_keeperPerryBeatenText, 0, Bird_keeperPerryScript

Bird_keeperPerryScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1a25db
	waitbutton
	closetext
	end

TrainerBird_keeperBret:
	trainer EVENT_BEAT_BIRD_KEEPER_BRET, BIRD_KEEPER, BRET, Bird_keeperBretSeenText, Bird_keeperBretBeatenText, 0, Bird_keeperBretScript

Bird_keeperBretScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1a2662
	waitbutton
	closetext
	end

Route13CutTree:
	jumpstd cuttree

Route13TrainerTips:
	jumptext Route13TrainerTipsText

Route13Sign:
	jumptext Route13SignText

Route13HiddenCalcium:
	dwb EVENT_ROUTE_13_HIDDEN_CALCIUM, CALCIUM

PokefanmAlexSeenText:
	text "Bow down before my"
	line "regal #mon!"
	done

PokefanmAlexBeatenText:
	text "How… How dare you"
	line "mock royalty!"
	done

UnknownText_0x1a24e3:
	text "Doesn't everyone"
	line "wish to someday be"
	cont "a king?"
	done

PokefanmJoshuaSeenText:
	text "Nihihi! Would you"
	line "like to battle my"
	cont "Pikachu gang?"
	done

PokefanmJoshuaBeatenText:
	text "Pi-Pikachu!"
	done

UnknownText_0x1a254f:
	text "You look like you"
	line "have many #mon,"

	para "but Pikachu is"
	line "still the best."
	done

Bird_keeperPerrySeenText:
	text "Agility is the key"
	line "attribute of bird"
	cont "#mon."
	done

Bird_keeperPerryBeatenText:
	text "You beat me with"
	line "your speed…"
	done

UnknownText_0x1a25db:
	text "Your #mon are"
	line "remarkably well-"
	cont "trained."
	done

Bird_keeperBretSeenText:
	text "Check out my #-"
	line "mon. Just look at"

	para "their coloring and"
	line "their plumage."
	done

Bird_keeperBretBeatenText:
	text "Shoot!"
	line "Not good enough!"
	done

UnknownText_0x1a2662:
	text "If you groom them,"
	line "#mon get happy."
	done

Route13TrainerTipsText:
	text "Trainer Tips"

	para "Look! Right there,"
	line "at the left side"
	cont "of the post."
	done

Route13SignText:
	text "Route 13"

	para "North to Silence"
	line "Bridge"
	done

Route13East_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 0

.XYTriggers:
	db 0

.Signposts:
	db 3
	signpost 13, 5, SIGNPOST_READ, Route13TrainerTips
	signpost 11, 17, SIGNPOST_READ, Route13Sign
	signpost 13, 6, SIGNPOST_ITEM, Route13HiddenCalcium

.PersonEvents:
	db 5
	person_event SPRITE_YOUNGSTER, 6, 18, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 2, TrainerBird_keeperPerry, -1
	person_event SPRITE_YOUNGSTER, 6, 19, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 2, TrainerBird_keeperBret, -1
	person_event SPRITE_POKEFAN_M, 8, 8, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerPokefanmJoshua, -1
	person_event SPRITE_POKEFAN_M, 6, 1, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 4, TrainerPokefanmAlex, -1
	person_event SPRITE_CUT_TREE, 4, 20, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route13CutTree, EVENT_ROUTE_13_CUT_TREE
