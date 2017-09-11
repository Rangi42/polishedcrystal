BeautifulBeach_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

BeautifulBeach_MapEventHeader:

.Warps: db 3
	warp_def 23, 11, 1, SEAGALLOP_FERRY_SHAMOUTI_GATE
	warp_def 23, 12, 1, SEAGALLOP_FERRY_SHAMOUTI_GATE
	warp_def 18, 27, 1, BEAUTIFUL_BEACH_VILLA

.XYTriggers: db 0

.Signposts: db 2
	signpost 21, 14, SIGNPOST_JUMPTEXT, BeautifulBeachWelcomeSignText
	signpost 19, 29, SIGNPOST_JUMPTEXT, BeautifulBeachVillaSignText

.PersonEvents: db 9
	person_event SPRITE_LADY, 18, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerAromaLadyBryony, -1
	person_event SPRITE_SIGHTSEER_M, 26, 26, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerSightseermJaska, -1
	person_event SPRITE_COOLTRAINER_M, 23, 33, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_GENERICTRAINER, 2, GenericTrainerTamerVince, -1
	person_event SPRITE_LADY, 22, 5, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerSightseerfRosie, -1
	person_event SPRITE_SWIMMER_GIRL, 13, 12, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_GENERICTRAINER, 2, GenericTrainerSwimmerfRachel, -1
	person_event SPRITE_ARTIST, 13, 27, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerArtistMarlene, -1
	itemball_event 19, 6, LUXURY_BALL, 1, EVENT_BEAUTIFUL_BEACH_LUXURY_BALL
	itemball_event 20, 36, FULL_RESTORE, 1, EVENT_BEAUTIFUL_BEACH_FULL_RESTORE
	person_event SPRITE_BALL_CUT_FRUIT, 13, -2, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1

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
	generictrainer EVENT_BEAT_AROMA_LADY_BRYONY, AROMA_LADY, BRYONY, .SeenText, .BeatenText

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
	generictrainer EVENT_BEAT_SIGHTSEERM_JASKA, SIGHTSEERM, JASKA, .SeenText, .BeatenText

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
	generictrainer EVENT_BEAT_TAMER_VINCE, TAMER, VINCE, .SeenText, .BeatenText

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
	generictrainer EVENT_BEAT_SIGHTSEERF_ROSIE, SIGHTSEERF, ROSIE, .SeenText, .BeatenText

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
	generictrainer EVENT_BEAT_SWIMMERF_RACHEL, SWIMMERF, RACHEL, .SeenText, .BeatenText

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
	generictrainer EVENT_BEAT_ARTIST_MARLENE, ARTIST, MARLENE, .SeenText, .BeatenText

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
