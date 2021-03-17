RockyBeach_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 25, 20, ROCKY_BEACH_HOUSE, 1
	warp_event 29, 10, NOISY_FOREST, 1
	warp_event 29, 11, NOISY_FOREST, 2

	def_coord_events

	def_bg_events
	bg_event 22, 24, BGEVENT_JUMPTEXT, RockyBeachSign1Text
	bg_event 24, 10, BGEVENT_JUMPTEXT, RockyBeachSign2Text

	def_object_events
	object_event 21, 21, SPRITE_SIGHTSEER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSightseermBlaise, -1
	object_event 11, 22, SPRITE_BEAUTY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerBeautyIoana, -1
	object_event  2, 21, SPRITE_LADY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerSightseerfKamila, -1
	object_event 15, 18, SPRITE_AROMA_LADY, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerAromaLadyHeather, -1
	object_event 15, 13, SPRITE_BREEDER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerBreederBrenda, -1
	object_event 14,  7, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerSwimmermEzra, -1
	object_event 23, 10, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, RockyBeachYoungsterScript, EVENT_NOISY_FOREST_PIKABLU
	itemball_event 21,  5, FULL_HEAL, 1, EVENT_ROCKY_BEACH_FULL_HEAL
	itemball_event 32,  3, PEARL_STRING, 1, EVENT_ROCKY_BEACH_PEARL_STRING
	object_event 20, 32, SPRITE_FAT_GUY, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, (1 << DAY), PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, ShamoutiIslandFisherText, -1
	object_event 23, 32, SPRITE_FAT_GUY, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, (1 << DAY), PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, ShamoutiIslandFisherText, -1

RockyBeachSign1Text:
	text "Rocky Beach"
	done

RockyBeachSign2Text:
	text "Noisy Forest"
	line "Ahead"

	para "Thru to"
	line "Shrine Ruins"
	done

GenericTrainerSightseermBlaise:
	generictrainer SIGHTSEERM, BLAISE, EVENT_BEAT_SIGHTSEERM_BLAISE, .SeenText, .BeatenText

	text "Je fais le tour"
	line "du monde avec mon"
	cont "#mon."
	done

.SeenText:
	text "Allons-y!"
	done

.BeatenText:
	text "Sacre bleu!"
	done

GenericTrainerBeautyIoana:
	generictrainer BEAUTY, IOANA, EVENT_BEAT_BEAUTY_IOANA, .SeenText, .BeatenText

	text "I have a naturally"
	line "pale complexion,"

	para "so I have to be"
	line "careful in the"
	cont "sun."
	done

.SeenText:
	text "I come here every"
	line "year to work on"
	cont "my tan."
	done

.BeatenText:
	text "I just got"
	line "burned!"
	done

GenericTrainerSightseerfKamila:
	generictrainer SIGHTSEERF, KAMILA, EVENT_BEAT_SIGHTSEERF_KAMILA, .SeenText, .BeatenText

	text "Alola is an archi-"
	line "pelago located far"
	cont "away from here."

	para "You should visit"
	line "it someday!"
	done

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

GenericTrainerAromaLadyHeather:
	generictrainer AROMA_LADY, HEATHER, EVENT_BEAT_AROMA_LADY_HEATHER, .SeenText, .BeatenText

	text "I studied flower"
	line "arranging with"

	para "Erika at Celadon"
	line "University."

	para "She praised this"
	line "island for its"
	cont "local fauna."
	done

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

GenericTrainerBreederBrenda:
	generictrainer BREEDER, BRENDA, EVENT_BEAT_BREEDER_BRENDA, .SeenText, .BeatenText

	text "To hatch an Egg,"
	line "you have to walk"
	cont "a lot."

	para "Where better than"
	line "sunny Shamouti?"
	done

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

GenericTrainerSwimmermEzra:
	generictrainer SWIMMERM, EZRA, EVENT_BEAT_SWIMMERM_EZRA, .SeenText, .BeatenText

	text "I like to go scuba"
	line "diving here."

	para "It's so amazing to"
	line "breathe while"
	cont "underwater!"
	done

.SeenText:
	text "Have you ever won-"
	line "dered what it's"

	para "like to breathe"
	line "underwater?"
	done

.BeatenText:
	text "Ran out of air!"
	done

RockyBeachYoungsterScript:
	generictrainer 0, 0, EVENT_TOLD_ABOUT_PIKABLU, .Text1, 0

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
