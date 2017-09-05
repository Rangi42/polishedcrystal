RockyBeach_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_OBJECTS, RockyBeachRebattleBreeder

RockyBeach_MapEventHeader:

.Warps: db 3
	warp_def 20, 25, 1, ROCKY_BEACH_HOUSE
	warp_def 10, 29, 1, NOISY_FOREST
	warp_def 11, 29, 2, NOISY_FOREST

.XYTriggers: db 0

.Signposts: db 2
	signpost 24, 22, SIGNPOST_JUMPTEXT, RockyBeachSign1Text
	signpost 10, 24, SIGNPOST_JUMPTEXT, RockyBeachSign2Text

.PersonEvents: db 11
	person_event SPRITE_SIGHTSEER_M, 21, 21, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerSightseermBlaise, -1
	person_event SPRITE_BEAUTY, 22, 11, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerBeautyIoana, -1
	person_event SPRITE_LADY, 21, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 4, TrainerSightseerfKamila, -1
	person_event SPRITE_LADY, 18, 15, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerAromaLadyHeather, -1
	person_event SPRITE_BREEDER, 13, 15, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 4, TrainerBreederBrenda, -1
	person_event SPRITE_SWIMMER_GUY, 7, 14, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 2, TrainerSwimmermEzra, -1
	person_event SPRITE_YOUNGSTER, 10, 23, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_GENERICTRAINER, 1, RockyBeachYoungsterScript, EVENT_NOISY_FOREST_PIKABLU
	itemball_event 5, 21, FULL_HEAL, 1, EVENT_ROCKY_BEACH_FULL_HEAL
	itemball_event 3, 32, PEARL_STRING, 1, EVENT_ROCKY_BEACH_PEARL_STRING
	person_event SPRITE_FISHER, 32, 20, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, (1 << DAY), (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, ShamoutiIslandFisherText, -1
	person_event SPRITE_FISHER, 32, 23, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, (1 << DAY), (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, ShamoutiIslandFisherText, -1

RockyBeachRebattleBreeder:
	clearevent EVENT_BEAT_BREEDER_BRENDA
	return

RockyBeachSign1Text:
	text "Rocky Beach"
	done

RockyBeachSign2Text:
	text "Noisy Forest"
	line "Ahead"

	para "Thru to"
	line "Shrine Ruins"
	done

TrainerSightseermBlaise:
	trainer EVENT_BEAT_SIGHTSEERM_BLAISE, SIGHTSEERM, BLAISE, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Allons-y!"
	done

.BeatenText:
	text "Sacre bleu!"
	done

.AfterText:
	text "Je voyage autour"
	line "du monde avec mon"
	cont "#mon."
	done

TrainerBeautyIoana:
	trainer EVENT_BEAT_BEAUTY_IOANA, BEAUTY, IOANA, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "I come here every"
	line "year to work on"
	cont "my tan."
	done

.BeatenText:
	text "I just got"
	line "burned!"
	done

.AfterText:
	text "I have a naturally"
	line "pale complexion,"

	para "so I have to be"
	line "careful in the"
	cont "sun."
	done

TrainerSightseerfKamila:
	trainer EVENT_BEAT_SIGHTSEERF_KAMILA, SIGHTSEERF, KAMILA, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Alola!"

	para "That's how we greet"
	line "each other in my"
	cont "region."
	done

.BeatenText:
	text "Cheehoo! You're"
	line "pretty good!"
	done

.AfterText:
	text "Alola is an archi-"
	line "pelago located far"
	cont "away from here."

	para "You should visit"
	line "it someday!"
	done

TrainerAromaLadyHeather:
	trainer EVENT_BEAT_AROMA_LADY_HEATHER, AROMA_LADY, HEATHER, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "A deep red flower"
	line "grows all over"
	cont "this island."

	para "Have you noticed?"
	done

.BeatenText:
	text "A lovely battle,"
	line "but what about"
	cont "the flowers?"
	done

.AfterText:
	text "I studied flower"
	line "arranging with"

	para "Erika at Celadon"
	line "University."

	para "She praised this"
	line "island for its"
	cont "local fauna."
	done

TrainerBreederBrenda:
	trainer EVENT_BEAT_BREEDER_BRENDA, BREEDER, BRENDA, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "The key to good"
	line "#mon breeding"

	para "is a good enviro-"
	line "nment."

	para "There's no place"
	line "better than here!"
	done

.BeatenText:
	text "Your #mon are"
	line "well-bred."
	done

.AfterText:
	text "To hatch an Egg,"
	line "you have to walk"
	cont "a lot."

	para "Where better than"
	line "sunny Shamouti?"
	done

TrainerSwimmermEzra:
	trainer EVENT_BEAT_SWIMMERM_EZRA, SWIMMERM, EZRA, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Have you ever won-"
	line "dered what it's"

	para "like to breathe"
	line "underwater?"
	done

.BeatenText:
	text "Ran out of air!"
	done

.AfterText:
	text "I like to go scuba"
	line "diving here."

	para "It's so amazing to"
	line "breathe while"
	cont "underwater!"
	done

RockyBeachYoungsterScript:
	generictrainer EVENT_TOLD_ABOUT_PIKABLU, 0, 0, .Text1, 0

.Text1
	text "Oh, no. Oh, no…"

	para "My Pikablu is"
	line "missing."

	para "No… It couldn't"
	line "have gone into"
	cont "Noisy Forest."

	para "I'll never find"
	line "it in the trees…"

	para "Oh, what should I"
	line "do…?"
	done
