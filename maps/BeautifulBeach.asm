BeautifulBeach_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 11, 23, SEAGALLOP_FERRY_SHAMOUTI_GATE, 1
	warp_event 12, 23, SEAGALLOP_FERRY_SHAMOUTI_GATE, 1
	warp_event 27, 18, BEAUTIFUL_BEACH_VILLA, 1

	def_coord_events

	def_bg_events
	bg_event 14, 21, BGEVENT_JUMPTEXT, BeautifulBeachWelcomeSignText
	bg_event 29, 19, BGEVENT_JUMPTEXT, BeautifulBeachVillaSignText

	def_object_events
	object_event 11, 18, SPRITE_AROMA_LADY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerAromaLadyBryony, -1
	object_event 26, 26, SPRITE_SIGHTSEER_M, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSightseermJaska, -1
	object_event 33, 23, SPRITE_TAMER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerTamerVince, -1
	object_event  5, 22, SPRITE_LADY, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerSightseerfRosie, -1
	object_event 12, 13, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerSwimmerfRachel, -1
	object_event 27, 13, SPRITE_ARTIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerArtistMarlene, -1
	itemball_event  6, 19, LUXURY_BALL, 1, EVENT_BEAUTIFUL_BEACH_LUXURY_BALL
	itemball_event 36, 20, FULL_RESTORE, 1, EVENT_BEAUTIFUL_BEACH_FULL_RESTORE
	fruittree_event -2, 13, FRUITTREE_SHAMOUTI_ISLAND, FIGY_BERRY, PAL_NPC_BROWN

BeautifulBeachWelcomeSignText:
	text "Welcome to"
	line "Shamouti Island!"

	para "The main island"
	line "is just east."
	done

BeautifulBeachVillaSignText:
	text "Island Villa"
	done

GenericTrainerAromaLadyBryony:
	generictrainer AROMA_LADY, BRYONY, EVENT_BEAT_AROMA_LADY_BRYONY, .SeenText, .BeatenText

	text "I am always in-"
	line "vigorated by the"
	cont "scents here."
	done

.SeenText:
	text "Tropical flowers,"
	line "a sea breeze…"

	para "Shamouti Island"
	line "is full of del-"
	cont "icious scents!"
	done

.BeatenText:
	text "Did the island's"
	line "scent inspire you"
	cont "to win?"
	done

GenericTrainerSightseermJaska:
	generictrainer SIGHTSEERM, JASKA, EVENT_BEAT_SIGHTSEERM_JASKA, .SeenText, .BeatenText

	text "I know it's silly,"
	line "but I feel safer"

	para "traveling with a"
	line "good-luck charm."
	done

.SeenText:
	text "My lucky socks"
	line "keep me safe dur-"
	cont "ing my travels."
	done

.BeatenText:
	text "They don't help"
	line "me win battles…"
	done

GenericTrainerTamerVince:
	generictrainer TAMER, VINCE, EVENT_BEAT_TAMER_VINCE, .SeenText, .BeatenText

	text "My #mon are"
	line "expertly tamed,"

	para "but I remain as"
	line "wild as ever!"
	done

.SeenText:
	text "My roaring spirit"
	line "shall never be"
	cont "tamed!"
	done

.BeatenText:
	text "Nyuh?! ROAR!"
	done

GenericTrainerSightseerfRosie:
	generictrainer SIGHTSEERF, ROSIE, EVENT_BEAT_SIGHTSEERF_ROSIE, .SeenText, .BeatenText

	text "Shamouti Island"
	line "has so much"
	cont "history!"

	para "I can't wait to"
	line "photograph it."
	done

.SeenText:
	text "The shrine, the"
	line "three temples,"
	cont "the old ruins…"
	cont "Where to first?"
	done

.BeatenText:
	text "I guess the #-"
	line "mon Center is"
	cont "first."
	done

GenericTrainerSwimmerfRachel:
	generictrainer SWIMMERF, RACHEL, EVENT_BEAT_SWIMMERF_RACHEL, .SeenText, .BeatenText

	text "I could spend all"
	line "day in this water."
	done

.SeenText:
	text "White sand and"
	line "blue water…"

	para "Beautiful Beach"
	line "lives up to its"
	cont "nickname!"
	done

.BeatenText:
	text "You fight"
	line "beautifully!"
	done

GenericTrainerArtistMarlene:
	generictrainer ARTIST, MARLENE, EVENT_BEAT_ARTIST_MARLENE, .SeenText, .BeatenText

	text "The three primary"
	line "colors of paint"

	para "are red, blue,"
	line "and yellow."

	para "But for light"
	line "they're red, blue,"
	cont "and green."
	done

.SeenText:
	text "My Smeargle trio"
	line "can paint any"
	cont "scene!"
	done

.BeatenText:
	text "They couldn't win"
	line "a battle…"
	done
