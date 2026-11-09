Route13_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events

	def_coord_events

	def_bg_events
	bg_event 35, 13, BGEVENT_JUMPTEXT, Route13TrainerTips1Text
	bg_event 53,  5, BGEVENT_JUMPTEXT, Route13TrainerTips2Text
	bg_event 51, 11, BGEVENT_JUMPTEXT, Route13SignText
	bg_event 17, 13, BGEVENT_JUMPTEXT, Route13DirectionsSignText
	bg_event 36, 13, BGEVENT_ITEM + CALCIUM, EVENT_ROUTE_13_HIDDEN_CALCIUM
	bg_event  5, 15, BGEVENT_ITEM + OVAL_STONE, EVENT_ROUTE_13_HIDDEN_OVAL_STONE

	def_object_events
	object_event  5,  5, SPRITE_CAMPER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerCamperClark, -1
	object_event 16,  6, SPRITE_PICNICKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerPicnickerGinger, -1
	object_event 60, 11, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerBird_keeperPerry, -1
	object_event 64,  1, SPRITE_BIRD_KEEPER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBird_keeperBret, -1
	object_event 34,  5, SPRITE_CAMPER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerCamperTanner, -1
	object_event 65,  9, SPRITE_PICNICKER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerPicnickerPiper, -1
	object_event 52,  6, SPRITE_COOL_DUDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerCoupleTimandsue1, -1
	object_event 53,  6, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerCoupleTimandsue2, -1
	object_event 38,  8, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerPokefanmJoshua, -1
	object_event 14, 10, SPRITE_HIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerHikerKenny, -1
	object_event 25,  6, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerPokefanmAlex, -1
	object_event 21, 13, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, Route13GrampsScript, -1
	cuttree_event 54,  4, EVENT_ROUTE_13_CUT_TREE

Route13GrampsScript:
	special CheckIfTrendyPhraseIsLucky
	iftruefwd .lucky
	jumpthistextfaceplayer

	text "I can't see Lucky"
	line "Island today…"

	para "But I know it's"
	line "appeared before!"
	done

.lucky
	jumpthistextfaceplayer

	text "I can see Lucky"
	line "Island today!"
	cont "What a spectacle!"
	done

GenericTrainerCamperClark:
	generictrainer CAMPER, CLARK, EVENT_BEAT_CAMPER_CLARK, .SeenText, .BeatenText

	text "It doesn't matter"
	line "what kind of prep"
	cont "work you've done."

	para "If you lose, you"
	line "lose."
	done

.SeenText:
	text "Collect water!"
	line "Don't let the fire"
	cont "go out!"

	para "Look out for wild"
	line "#mon!"

	para "Let's go,"
	line "Campfire!"
	done

.BeatenText:
	text "Pfuuuuhh…"
	done

GenericTrainerPicnickerGinger:
	generictrainer PICNICKER, GINGER, EVENT_BEAT_PICNICKER_GINGER, .SeenText, .BeatenText

	text "You can communi-"
	line "cate with #mon"

	para "through whistling"
	line "instead of words!"
	done

.SeenText:
	text "Why do I always"
	line "get the urge to"
	cont "whistle outdoors?"
	done

.BeatenText:
	text "Tweeee!"
	done

GenericTrainerBird_keeperPerry:
	generictrainer BIRD_KEEPER, PERRY, EVENT_BEAT_BIRD_KEEPER_PERRY, Bird_keeperPerrySeenText, Bird_keeperPerryBeatenText

	text "Your #mon are"
	line "remarkably well-"
	cont "trained."
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

GenericTrainerBird_keeperBret:
	generictrainer BIRD_KEEPER, BRET, EVENT_BEAT_BIRD_KEEPER_BRET, Bird_keeperBretSeenText, Bird_keeperBretBeatenText

	text "If you groom them,"
	line "#mon get happy."
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

GenericTrainerCamperTanner:
	generictrainer CAMPER, TANNER, EVENT_BEAT_CAMPER_TANNER, .SeenText, .BeatenText

	text "I figured it would"
	line "be easy to knock"
	cont "you out…"
	done

.SeenText:
	text "I can fit in a"
	line "quick battle while"
	cont "preparing a meal!"
	done

.BeatenText:
	text "Oh, I'm hungry…"
	done

GenericTrainerPicnickerPiper:
	generictrainer PICNICKER, PIPER, EVENT_BEAT_PICNICKER_PIPER, .SeenText, .BeatenText

	text "The way you were"
	line "walking made me"
	cont "think I could win."
	done

.SeenText:
	text "How about we bring"
	line "out your #mon"

	para "and mine for a"
	line "battle?"
	done

.BeatenText:
	text "Oh, that's too"
	line "bad…"
	done

GenericTrainerCoupleTimandsue1:
	generictrainer COUPLE, TIMANDSUE1, EVENT_BEAT_COUPLE_TIM_AND_SUE, .SeenText, .BeatenText

	text "Tim: If you've"
	line "beaten her, you"
	cont "must be strong!"
	done

.SeenText:
	text "Tim: I'll give you"
	line "a little hint."

	para "My girlfriend's"
	line "stronger than me!"
	done

.BeatenText:
	text "Tim: You're the"
	line "strongest!"
	done

GenericTrainerCoupleTimandsue2:
	generictrainer COUPLE, TIMANDSUE2, EVENT_BEAT_COUPLE_TIM_AND_SUE, .SeenText, .BeatenText

	text "Sue: That strength"
	line "of yours…"
	cont "I've got it!"

	para "Are you in love?"
	done

.SeenText:
	text "Sue: Women who"
	line "don't take love"

	para "seriously might"
	line "get hurt."
	done

.BeatenText:
	text "Sue: Wa ha…"
	done

GenericTrainerPokefanmAlex:
	generictrainer POKEFANM, ALEX, EVENT_BEAT_POKEFANM_ALEX, PokefanmAlexSeenText, PokefanmAlexBeatenText

	text "Doesn't everyone"
	line "wish to someday be"
	cont "a king?"
	done

PokefanmAlexSeenText:
	text "Bow down before my"
	line "regal #mon!"
	done

PokefanmAlexBeatenText:
	text "How… How dare you"
	line "mock royalty!"
	done

GenericTrainerPokefanmJoshua:
	generictrainer POKEFANM, JOSHUA, EVENT_BEAT_POKEFANM_JOSHUA, PokefanmJoshuaSeenText, PokefanmJoshuaBeatenText

	text "You look like you"
	line "have many #mon,"

	para "but Pikachu is"
	line "still the best."
	done

PokefanmJoshuaSeenText:
	text "Nihihi! Would you"
	line "like to battle my"
	cont "Pikachu gang?"
	done

PokefanmJoshuaBeatenText:
	text "Pi-Pikachu!"
	done

GenericTrainerHikerKenny:
	generictrainer HIKER, KENNY, EVENT_BEAT_HIKER_KENNY, HikerKennySeenText, HikerKennyBeatenText

	text "Geological fea-"
	line "tures don't appear"
	cont "to change."

	para "But they actually"
	line "change, little by"
	cont "little."
	done

HikerKennySeenText:
	text "I should go to"
	line "Rock Tunnel to get"
	cont "myself an Onix."
	done

HikerKennyBeatenText:
	text "I lost…"
	done

Route13TrainerTips1Text:
	text "Trainer Tips"

	para "Look! Right there,"
	line "at the left side"
	cont "of the post."
	done

Route13TrainerTips2Text:
	text "Trainer Tips"

	para "Some #mon need"
	line "items to evolve."

	para "If you're lucky,"
	line "a wild #mon can"

	para "be found holding"
	line "its own evolution"
	cont "item!"
	done

Route13SignText:
	text "Route 13"

	para "North to Silence"
	line "Bridge"
	done

Route13DirectionsSignText:
	text "North to Lavender"
	line "Town"

	para "West to Fuchsia"
	line "City"
	done
