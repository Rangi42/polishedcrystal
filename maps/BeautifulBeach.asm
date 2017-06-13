const_value set 2
	const BEAUTIFULBEACH_LADY1
	const BEAUTIFULBEACH_SIGHTSEER_M
	const BEAUTIFULBEACH_COOLTRAINER_M
	const BEAUTIFULBEACH_LADY2
	const BEAUTIFULBEACH_SWIMMER_GIRL
	const BEAUTIFULBEACH_ARTIST
	const BEAUTIFULBEACH_POKE_BALL1
	const BEAUTIFULBEACH_POKE_BALL2

BeautifulBeach_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TrainerAromaLadyBryony:
	trainer EVENT_BEAT_AROMA_LADY_BRYONY, AROMA_LADY, BRYONY, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

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

.AfterText:
	text "I am always in-"
	line "vigorated by the"
	cont "scents here."
	done

TrainerSightseermJaska:
	trainer EVENT_BEAT_SIGHTSEERM_JASKA, SIGHTSEERM, JASKA, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

.SeenText:
	text "My lucky socks"
	line "keep me safe dur-"
	cont "ing my travels."
	done

.BeatenText:
	text "They don't help"
	line "me win battles…"
	done

.AfterText:
	text "I know it's silly,"
	line "but I feel safer"

	para "travelling with a"
	line "good-luck charm."
	done

TrainerTamerVince:
	trainer EVENT_BEAT_TAMER_VINCE, TAMER, VINCE, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

.SeenText:
	text "My roaring spirit"
	line "shall never be"
	cont "tamed!"
	done

.BeatenText:
	text "Nyuh?! ROAR!"
	done

.AfterText:
	text "My #mon are"
	line "expertly tamed,"

	para "but I remain as"
	line "wild as ever!"
	done

TrainerSightseerfRosie:
	trainer EVENT_BEAT_SIGHTSEERF_ROSIE, SIGHTSEERF, ROSIE, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

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

.AfterText:
	text "Shamouti Island"
	line "has so much"
	cont "history!"

	para "I can't wait to"
	line "photograph it."
	done

TrainerSwimmerfRachel:
	trainer EVENT_BEAT_SWIMMERF_RACHEL, SWIMMERF, RACHEL, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

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

.AfterText:
	text "I could spend all"
	line "day in this water."
	done

TrainerArtistMarlene:
	trainer EVENT_BEAT_ARTIST_MARLENE, ARTIST, MARLENE, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	opentext
	writetext .AfterText
	waitbutton
	closetext
	end

.SeenText:
	text "My Smeargle trio"
	line "can paint any"
	cont "scene!"
	done

.BeatenText:
	text "They couldn't win"
	line "a battle…"
	done

.AfterText:
	text "The three primary"
	line "colors of paint"

	para "are red, blue,"
	line "and yellow."

	para "But for light"
	line "they're red, blue,"
	cont "and green."
	done

BeautifulBeachLuxuryBall:
	itemball LUXURY_BALL

BeautifulBeachFullRestore:
	itemball FULL_RESTORE

BeautifulBeachWelcomeSign:
	jumptext .Text

.Text:
	text "Welcome to"
	line "Shamouti Island!"

	para "The main island"
	line "is just east."
	done

BeautifulBeachVillaSign:
	jumptext .Text

.Text:
	text "Island Villa"
	done

BeautifulBeach_MapEventHeader:
.Warps:
	db 3
	warp_def $17, $b, 1, SEAGALLOP_FERRY_SHAMOUTI_GATE
	warp_def $17, $c, 1, SEAGALLOP_FERRY_SHAMOUTI_GATE
	warp_def $12, $1b, 1, BEAUTIFUL_BEACH_VILLA

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 21, 14, SIGNPOST_READ, BeautifulBeachWelcomeSign
	signpost 19, 29, SIGNPOST_READ, BeautifulBeachVillaSign

.PersonEvents:
	db 8
	person_event SPRITE_LADY, 18, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerAromaLadyBryony, -1
	person_event SPRITE_SIGHTSEER_M, 26, 26, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerSightseermJaska, -1
	person_event SPRITE_COOLTRAINER_M, 23, 33, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 2, TrainerTamerVince, -1
	person_event SPRITE_LADY, 22, 5, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerSightseerfRosie, -1
	person_event SPRITE_SWIMMER_GIRL, 13, 12, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 2, TrainerSwimmerfRachel, -1
	person_event SPRITE_ARTIST, 13, 27, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerArtistMarlene, -1
	person_event SPRITE_BALL_CUT_FRUIT, 19, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, BeautifulBeachLuxuryBall, EVENT_BEAUTIFUL_BEACH_LUXURY_BALL
	person_event SPRITE_BALL_CUT_FRUIT, 20, 36, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, BeautifulBeachFullRestore, EVENT_BEAUTIFUL_BEACH_FULL_RESTORE
