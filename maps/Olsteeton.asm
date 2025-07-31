Olsteeton_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4, 18, ROUTE_102_OLSTEETON_GATE, 3
	warp_event  4, 19, ROUTE_102_OLSTEETON_GATE, 4
	warp_event  6,  9, OLSTEETON_GYM_1F, 1
	warp_event 13, 15, OLSTEETON_POKE_CENTER, 1
	warp_event 11,  9, OLSTEETON_MALL_1, 1
	warp_event 14,  9, OLSTEETON_MALL_2, 1
	warp_event 17,  9, OLSTEETON_MALL_3, 1
	warp_event 21,  9, OLSTEETON_MART, 1
	warp_event 29, 18, RIVERFRONT_APT_1F, 1
	warp_event 29, 19, RIVERFRONT_APT_1F, 2
	warp_event 34, 18, RIVERFRONT_APT_1F, 3
	warp_event 34, 19, RIVERFRONT_APT_1F, 4
	warp_event  7, 15, OLSTEETON_DINER, 1
	warp_event 28, 11, OLSTEETON_ARCADE, 1
	warp_event  6, 23, OLSTEETON_TRAIN_STATION, 1
	warp_event 27, 29, OLSTEETON_NAME_RATER, 1
	warp_event  5, 27, OLSTEETON_FISHER_HOUSE, 1
	warp_event 29, 33, OLSTEETON_QUICK_HOUSE, 1
	warp_event 11, 33, OLSTEETON_GYM_HOUSE, 1
	warp_event 19, 31, OLSTEETON_FOREST_GATE, 1
	warp_event 20, 31, OLSTEETON_FOREST_GATE, 2
	warp_event 35, 10, OLSTEETON_UNI_GATE, 1
	warp_event 35, 11, OLSTEETON_UNI_GATE, 2
	warp_event 33, 26, OLSTEETON_ROUTE_103_GATE, 1
	warp_event 33, 27, OLSTEETON_ROUTE_103_GATE, 2

	def_coord_events

	def_bg_events
	bg_event 16, 28, BGEVENT_JUMPTEXT, OlsteetonSignText
	bg_event  4, 10, BGEVENT_JUMPTEXT, OlsteetonGymSignText
	bg_event  4, 28, BGEVENT_JUMPTEXT, OlsteetonFishingGuruSignText
	bg_event 25, 29, BGEVENT_JUMPTEXT, OlsteetonNameRaterSignText
	bg_event 35,  9, BGEVENT_JUMPTEXT, OlsteetonUniversitySignText
	bg_event 12,  9, BGEVENT_JUMPTEXT, OlsteetonDeptStoreSignText
	bg_event 22,  9, BGEVENT_JUMPTEXT, OlsteetonMartSignText
	bg_event 14, 15, BGEVENT_JUMPTEXT, OlsteetonPokeCenterSignText
	bg_event 16, 10, BGEVENT_JUMPTEXT, OlsteetonHomeDecorStoreSignText
	bg_event 36,  1, BGEVENT_JUMPTEXT, OlsteetonBoatText
	bg_event 30, 10, BGEVENT_JUMPTEXT, OlsteetonGameCornerSignText
	bg_event 17, 31, BGEVENT_JUMPTEXT, OlsteetonForestSignText
	bg_event 10, 15, BGEVENT_JUMPTEXT, OlsteetonCafeSignText
	bg_event 29, 17, BGEVENT_JUMPTEXT, OlsteetonHotelSignText
	bg_event  4, 17, BGEVENT_JUMPTEXT, OlsteetonRoute102Text
	bg_event 32, 23, BGEVENT_JUMPTEXT, OlsteetonRoute103Text
	bg_event  7, 24, BGEVENT_JUMPTEXT, OlsteetonTrainSignText

	; bg_event  3, 24, BGEVENT_ITEM + PP_UP, EVENT_Olsteeton_CITY_HIDDEN_PP_UP

	def_object_events
	object_event 32,  1, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonFisherText, -1
	pokemon_event 31,  1, WARTORTLE, SPRITEMOVEDATA_POKEMON, -1, PAL_NPC_BLUE, OlsteetonPoliwrathText, -1
	object_event 10, 17, SPRITE_POKEFAN_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonTeacher1Text, -1
	object_event 25, 23, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonGramps1Text, -1
	object_event 25, 17, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonGramps2Text, -1
	object_event 18,  3, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonYoungster1Text, -1
	object_event 10, 24, SPRITE_CAMPER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonYoungster2Text, -1
	object_event 24, 32, SPRITE_TEACHER, SPRITEMOVEDATA_WANDER, 2, 2, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonTeacher2Text, -1
	object_event  8, 32, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonLassText_PCC, -1
	object_event 21, 17, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonLassText, -1
	object_event 20, 14, SPRITE_ROCKER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonBandRocker1Text, -1
	object_event 22, 14, SPRITE_ROCKER, SPRITEMOVEDATA_STANDING_DOWN, 1, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonBandRocker2Text, -1
	object_event 24, 14, SPRITE_ROCKER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 1, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonBandRocker3Text, -1
	object_event 23, 16, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonBandCooltrainerFText, -1
	; itemball_event 39,  7, MAX_ETHER, 1, EVENT_Olsteeton_CITY_MAX_ETHER
	; cuttree_event 33, 34, EVENT_Olsteeton_CITY_CUT_TREE
	; cuttree_event -5, 24, EVENT_ROUTE_16_CUT_TREE

OlsteetonFlyPoint:
	setflag ENGINE_FLYPOINT_OLSTEETON
	endcallback

OlsteetonBandRocker1Text: ;Needs new dialogue
	text "I need"
	line "dialogue."
	done

OlsteetonBandRocker2Text: ;Needs new dialogue
	text "I need"
	line "dialogue."
	done

OlsteetonBandRocker3Text: ;Needs new dialogue
	text "I need"
	line "dialogue."
	done

OlsteetonBandCooltrainerFText:
	text "write me some"
	line "dialogue pls"
	done

OlsteetonFisherText:
	text "This Wartortle is"
	line "my partner."

	para "It rescued me"
	line "from a boating"

	para "accident when I"
	line "was just a lad."

	para "It's the"
	line "bestest swimmer!"
	done

OlsteetonPoliwrathText:
	text "Wartortle: WArrrr!"
	done

OlsteetonTeacher1Text:
	text "I lost my"
	line "high score on"
	line "#mon Pinball"
	cont "again…"
	done

OlsteetonGramps1Text:
	text "Nihihi! I'm an"
	line "ol' coot!"
	done

OlsteetonGramps2Text:
	text "THIS BAND ROCKS!!"
	line "WOOOOO!"

	para "HELL YEAH!"
	line "Maybe I should"
	cont "crowd surf!"
	done

OlsteetonYoungster1Text:
	text "Want to know a"
	line "secret?"

	para "One of the shops"
	line "has a hidden back"
	cont "door."
	done

OlsteetonYoungster2Text:
	text "The restaurant's"
	line "specialty is"
	cont "spaghetti,"

	para "but if you ask me,"
	line "I think it's"
	cont "just alright."
	done

OlsteetonTeacher2Text:
	text "Olsteeton Mall."
	line "has a wide"
	cont "variety and"

	para "best selection"
	line "of merchandise"
	cont "in the area!"

	para "But nothing beats"
	line "Sunset Mountain"
	cont "Shopping Center"
	done

OlsteetonLassText_PCC:
	text "I love being"
	line "woken by the"
	cont "train at night!"

	para "..."
	line "NOT!"
	done

OlsteetonLassText:
	text "#mon are offer-"
	line "ed as prizes at"
	cont "the Arcade..."

	para "Kinda unethical"
	line "if you ask me."
	done

OlsteetonSignText:
	text "Olsteeton"

	para "The City of"
	line "Old Industry"
	done

OlsteetonGymSignText:
	text "Olsteeton"
	line "#mon Gym"
	cont "Leader: Rusty"

	para "The Wrecking Ball"
	line "OPEN SOON"
	done

OlsteetonUniversitySignText:
	text "Olsteeton University"

	para "“Growth Through"
	line "Intense Study”"
	done

OlsteetonDeptStoreSignText:
	text "Find What You"
	line "Need at Olsteeton"
	cont "Mall!"
	done

OlsteetonMartSignText:
	text "Olsteeton Mart"
	line "Standard trainer"
	cont "goods sold here!"
	done

OlsteetonPokeCenterSignText:
	text "#Center"

	para "We heal hurt"
	line "#mon!"
	done
OlsteetonFishingGuruSignText:
	text "Seeking promising"
	line "young fisher."
	cont "Inquire within!"
	done
OlsteetonHomeDecorStoreSignText:
	text "Olsteeton Mall"
	line "Have you Herb?"
	done

OlsteetonBoatText:
	text "It's a boat."
	done

OlsteetonGameCornerSignText:
	text "The Playground for"
	line "All--Olsteeton"
	cont "Arcade"
	done

OlsteetonCafeSignText:
	text "Olsteeton Diner"

	para "Our spaghetti is"
	line "to di(n)e for!"
	done

OlsteetonHotelSignText:
	text "Riverside Apartments"

	para "Now leasing"
	line "1 BR apartments!"
	done

OlsteetonTrainSignText:
	text "Olsteeton Train"
	line "Station"

	para "We'll get ya"
	line "there eventually."
	done

OlsteetonRoute102Text:
	text "Welcome to"
	line "Olsteeton!"

	para "WEST: Route 102"
	done

OlsteetonRoute103Text:
	text "WEST: Olsteeton"
	line "EAST: Route 103"
	done

OlsteetonNameRaterSignText:
	text "Name Rater's"
	line "House"
	done
OlsteetonForestSignText:
	text "SOUTH: Jolly Sods"
	line "Regional Park"

	para "NORTH: Olsteeton"
	done