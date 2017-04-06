const_value set 2
	const ROUTE8_BIKER1
	const ROUTE8_BIKER2
	const ROUTE8_BIKER3
	const ROUTE8_SUPER_NERD1
	const ROUTE8_SUPER_NERD2
	const ROUTE8_GENTLEMAN
	const ROUTE8_POKEMANIAC
	const ROUTE8_CUT_TREE1
	const ROUTE8_CUT_TREE2
	const ROUTE8_FRUIT_TREE
	const ROUTE8_BIKER4
	const ROUTE8_BIKER5
	const ROUTE8_BIKER6

Route8_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

Route8BikerDwayneScript:
	jumptextfaceplayer Route8BikerDwayneProtestText

Route8BikerHarrisScript:
	jumptextfaceplayer Route8BikerHarrisProtestText

Route8BikerZekeScript:
	jumptextfaceplayer Route8BikerZekeProtestText

TrainerBikerDwayne:
	trainer EVENT_BEAT_BIKER_DWAYNE, BIKER, DWAYNE, BikerDwayneSeenText, BikerDwayneBeatenText, 0, BikerDwayneScript

BikerDwayneScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x6c0c8
	waitbutton
	closetext
	end

TrainerBikerHarris:
	trainer EVENT_BEAT_BIKER_HARRIS, BIKER, HARRIS, BikerHarrisSeenText, BikerHarrisBeatenText, 0, BikerHarrisScript

BikerHarrisScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x6c143
	waitbutton
	closetext
	end

TrainerBikerZeke:
	trainer EVENT_BEAT_BIKER_ZEKE, BIKER, ZEKE, BikerZekeSeenText, BikerZekeBeatenText, 0, BikerZekeScript

BikerZekeScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x6c1a3
	waitbutton
	closetext
	end

TrainerSupernerdSam:
	trainer EVENT_BEAT_SUPER_NERD_SAM, SUPER_NERD, SAM, SupernerdSamSeenText, SupernerdSamBeatenText, 0, SupernerdSamScript

SupernerdSamScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x6c219
	waitbutton
	closetext
	end

TrainerSupernerdTom:
	trainer EVENT_BEAT_SUPER_NERD_TOM, SUPER_NERD, TOM, SupernerdTomSeenText, SupernerdTomBeatenText, 0, SupernerdTomScript

SupernerdTomScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x6c27e
	waitbutton
	closetext
	end

TrainerGentlemanMilton:
	trainer EVENT_BEAT_GENTLEMAN_MILTON, GENTLEMAN, MILTON, GentlemanMiltonSeenText, GentlemanMiltonBeatenText, 0, GentlemanMiltonScript

GentlemanMiltonScript:
	end_if_just_battled
	opentext
	writetext GentlemanMiltonAfterText
	waitbutton
	closetext
	end

TrainerPokemaniacMoe:
	trainer EVENT_BEAT_POKEMANIAC_MOE, POKEMANIAC, MOE, PokemaniacMoeSeenText, PokemaniacMoeBeatenText, 0, PokemaniacMoeScript

PokemaniacMoeScript:
	end_if_just_battled
	opentext
	writetext PokemaniacMoeAfterText
	waitbutton
	closetext
	end

Route8LockedDoor:
	jumptext Route8LockedDoorText

Route8UndergroundPathSign:
	jumptext Route8UndergroundPathSignText

FruitTreeScript_0x6c06c:
	fruittree FRUITTREE_ROUTE_8

Route8CutTree:
	jumpstd cuttree

Route8BikerDwayneProtestText:
	text "We're the Kanto"
	line "#mon Federation"
	cont "trainer group."

	para "We're holding a"
	line "protest!"
	done

Route8BikerZekeProtestText:
	text "We're the Kanto"
	line "#mon Federa-"
	cont "tion!"

	para "The cops can't"
	line "stop us from"

	para "using the Under-"
	line "ground Path!"
	done

BikerDwayneSeenText:
	text "We're the Kanto"
	line "#mon Federation"
	cont "trainer group."

	para "We'll drive you"
	line "under our wheels!"
	done

BikerDwayneBeatenText:
	text "S-sorry!"
	done

UnknownText_0x6c0c8:
	text "The Kanto #mon"
	line "Federation will"
	cont "never fall!"
	done

Route8BikerHarrisProtestText:
BikerHarrisSeenText:
	text "The cops shut down"
	line "our Underground"

	para "Path! That really"
	line "fries me!"
	done

BikerHarrisBeatenText:
	text "F-forgive me!"
	done

UnknownText_0x6c143:
	text "Wiped out by some"
	line "punk from Johto…"
	done

BikerZekeSeenText:
	text "We're the Kanto"
	line "#mon Federa-"
	cont "tion!"
	cont "Right on!"
	done

BikerZekeBeatenText:
	text "Yikes! Sorry!"
	done

UnknownText_0x6c1a3:
	text "We'll try not to"
	line "disturb anyone"
	cont "from now on…"
	done

SupernerdSamSeenText:
	text "How does the Mag-"
	line "net Train work?"
	done

SupernerdSamBeatenText:
	text "I just want to see"
	line "the Magnet Train…"
	done

UnknownText_0x6c219:
	text "The power of mag-"
	line "nets is awesome!"
	done

SupernerdTomSeenText:
	text "Hm… You've got"
	line "many Gym Badges."
	done

SupernerdTomBeatenText:
	text "Just as I thought…"
	line "You're tough!"
	done

UnknownText_0x6c27e:
	text "Gym Badges are"
	line "proof of your"
	cont "skill at battles."
	done

GentlemanMiltonSeenText:
	text "Would you care to"
	line "join me in a"
	cont "quick contest?"
	done

GentlemanMiltonBeatenText:
	text "You were very"
	line "skillful."
	done

GentlemanMiltonAfterText:
	text "Stopping in the"
	line "road for a battle"
	cont "isn't rude."

	para "No matter what,"
	line "I am a gentleman"
	cont "first!"
	done

PokemaniacMoeSeenText:
	text "Do I look weak?"
	line "Don't make me"
	cont "laugh!"
	done

PokemaniacMoeBeatenText:
	text "Uwaaaahhh…"
	done

PokemaniacMoeAfterText:
	text "In short, you're"
	line "just too strong…"
	done

Route8LockedDoorText:
	text "It's locked…"
	done

Route8UndergroundPathSignText:
	text "The flyer's torn."

	para "It's impossible to"
	line "read…"
	done

Route8_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $a, $4, 3, ROUTE_8_SAFFRON_GATE
	warp_def $b, $4, 4, ROUTE_8_SAFFRON_GATE

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 9, 11, SIGNPOST_READ, Route8UndergroundPathSign
	signpost 7, 10, SIGNPOST_READ, Route8LockedDoor

.PersonEvents:
	db 13
	person_event SPRITE_BIKER, 10, 10, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 5, TrainerBikerDwayne, EVENT_SAFFRON_TRAIN_STATION_POPULATION
	person_event SPRITE_BIKER, 11, 10, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 5, TrainerBikerHarris, EVENT_SAFFRON_TRAIN_STATION_POPULATION
	person_event SPRITE_BIKER, 12, 10, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 5, TrainerBikerZeke, EVENT_SAFFRON_TRAIN_STATION_POPULATION
	person_event SPRITE_SUPER_NERD, 4, 26, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerSupernerdSam, -1
	person_event SPRITE_SUPER_NERD, 9, 32, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerSupernerdTom, -1
	person_event SPRITE_GENTLEMAN, 14, 43, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerGentlemanMilton, -1
	person_event SPRITE_SUPER_NERD, 9, 17, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 3, TrainerPokemaniacMoe, -1
	person_event SPRITE_BALL_CUT_FRUIT, 14, 21, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route8CutTree, EVENT_ROUTE_8_CUT_TREE_1
	person_event SPRITE_BALL_CUT_FRUIT, 12, 32, SPRITEMOVEDATA_CUTTABLE_TREE, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Route8CutTree, EVENT_ROUTE_8_CUT_TREE_2
	person_event SPRITE_BALL_CUT_FRUIT, 7, 45, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, FruitTreeScript_0x6c06c, -1
	person_event SPRITE_BIKER, 9, 6, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, Route8BikerDwayneScript, EVENT_RETURNED_MACHINE_PART
	person_event SPRITE_BIKER, 10, 7, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, Route8BikerHarrisScript, EVENT_RETURNED_MACHINE_PART
	person_event SPRITE_BIKER, 11, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route8BikerZekeScript, EVENT_RETURNED_MACHINE_PART
