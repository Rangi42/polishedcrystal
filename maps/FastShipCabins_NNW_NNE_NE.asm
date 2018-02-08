FastShipCabins_NNW_NNE_NE_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 3 ; warp events
	warp_event  2,  0, FAST_SHIP_1F, 2
	warp_event  2, 12, FAST_SHIP_1F, 3
	warp_event  2, 24, FAST_SHIP_1F, 4

	db 0 ; coord events

	db 0 ; bg events

	db 8 ; object events
	object_event  4, 26, SPRITE_SAILOR, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, SailorScript_0x755f1, EVENT_FAST_SHIP_CABINS_NNW_NNE_NE_SAILOR
	object_event  4,  5, SPRITE_PI, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerPILooker, EVENT_FAST_SHIP_PASSENGERS_FIRST_TRIP
	object_event  4,  3, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_GENERICTRAINER, 2, GenericTrainerCooltrainermSean, EVENT_FAST_SHIP_PASSENGERS_EASTBOUND
	object_event  1,  5, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerCooltrainerfCarol, EVENT_FAST_SHIP_PASSENGERS_EASTBOUND
	object_event  1,  5, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerPokemaniacEthan, EVENT_FAST_SHIP_PASSENGERS_WESTBOUND
	object_event  4, 17, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerHikerNoland, EVENT_FAST_SHIP_PASSENGERS_FIRST_TRIP
	object_event  7, 30, SPRITE_GENTLEMAN, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerGentlemanEdward, EVENT_FAST_SHIP_PASSENGERS_EASTBOUND
	object_event  2, 30, SPRITE_PHARMACIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_GENERICTRAINER, 4, GenericTrainerBurglarCorey, EVENT_FAST_SHIP_PASSENGERS_WESTBOUND

	const_def 1 ; object constants
	const FASTSHIPCABINS_NNW_NNE_NE_SAILOR

GenericTrainerPILooker:
	generictrainer PI, LOOKER, EVENT_BEAT_PI_LOOKER, PILookerSeenText, PILookerBeatenText

	text "My code name,"
	line "it is Looker."

	para "It is what they"
	line "all call me."

	para "I am on the look-"
	line "out for members"
	cont "of Team Rocket."

	para "What?! You defeat-"
	line "ed them?"

	para "Bravo!"
	done

GenericTrainerCooltrainermSean:
	generictrainer COOLTRAINERM, SEAN, EVENT_BEAT_COOLTRAINERM_SEAN, CooltrainermSeanSeenText, CooltrainermSeanBeatenText

	text "Trainers from"
	line "Johto can battle"

	para "with Kanto Gym"
	line "Leaders."
	done

GenericTrainerCooltrainerfCarol:
	generictrainer COOLTRAINERF, CAROL, EVENT_BEAT_COOLTRAINERF_CAROL, CooltrainerfCarolSeenText, CooltrainerfCarolBeatenText

	text "I'm going to beat"
	line "you someday!"
	done

GenericTrainerPokemaniacEthan:
	generictrainer POKEMANIAC, ETHAN, EVENT_BEAT_POKEMANIAC_ETHAN, PokemaniacEthanSeenText, PokemaniacEthanBeatenText

	text "Lily's nice, but"
	line "Mary's the best!"

	para "I want to check"
	line "out Johto's radio"
	cont "programs!"
	done

GenericTrainerHikerNoland:
	generictrainer HIKER, NOLAND, EVENT_BEAT_HIKER_NOLAND, HikerNolandSeenText, HikerNolandBeatenText

	text "I wonder if there"
	line "are any mountains"

	para "worth climbing in"
	line "Kanto?"
	done

GenericTrainerGentlemanEdward:
	generictrainer GENTLEMAN, EDWARD, EVENT_BEAT_GENTLEMAN_EDWARD, GentlemanEdwardSeenText, GentlemanEdwardBeatenText

	text "I give up."
	line "You don't have to"

	para "look. Just forget"
	line "about it!"
	done

GenericTrainerBurglarCorey:
	generictrainer BURGLAR, COREY, EVENT_BEAT_BURGLAR_COREY, BurglarCoreySeenText, BurglarCoreyBeatenText

	text "I found a pretty"
	line "coin here."

	para "Someone must have"
	line "lost it…"
	done

SailorScript_0x755f1:
	special SaveMusic
	playmusic MUSIC_HIKER_ENCOUNTER
	showtextfaceplayer UnknownText_0x75812
	winlosstext UnknownText_0x75897, UnknownText_0x75897
	loadtrainer SAILOR, STANLY
	writecode VAR_BATTLETYPE, BATTLETYPE_CANLOSE
	startbattle
	reloadmap
	special HealParty
	setevent EVENT_BEAT_SAILOR_STANLY
	showtext UnknownText_0x758b1
	setevent EVENT_FAST_SHIP_LAZY_SAILOR
	setmapscene FAST_SHIP_B1F, $1
	checkcode VAR_FACING
	ifequal $3, UnknownScript_0x75629
	applymovement FASTSHIPCABINS_NNW_NNE_NE_SAILOR, MovementData_0x75637
	playsound SFX_EXIT_BUILDING
	disappear FASTSHIPCABINS_NNW_NNE_NE_SAILOR
	waitsfx
	end

UnknownScript_0x75629:
	applymovement FASTSHIPCABINS_NNW_NNE_NE_SAILOR, MovementData_0x7563c
	playsound SFX_EXIT_BUILDING
	disappear FASTSHIPCABINS_NNW_NNE_NE_SAILOR
	waitsfx
	end

MovementData_0x75637:
	step_left
	step_left
	step_up
	step_up
	step_end

MovementData_0x7563c:
	step_down
	step_left
	step_left
	step_up
	step_up
	step_up
	step_end

PILookerSeenText:
	text "WHAAAT?!"

	para "…How did you know?"
	line "How did you unmask"

	para "me as a member of"
	line "the International"
	cont "Police?!"
	done

PILookerBeatenText:
	text "Quite admirable,"
	line "you are!"
	done

CooltrainermSeanSeenText:
	text "I'm going to Kanto"
	line "to test my skills."
	done

CooltrainermSeanBeatenText:
	text "I wanted to win!"
	done

CooltrainerfCarolSeenText:
	text "I'm training to"
	line "become the Champ!"
	done

CooltrainerfCarolBeatenText:
	text "What's so differ-"
	line "ent between us?"
	done

PokemaniacEthanSeenText:
	text "Do you know Lily?"
	line "She's a hot DJ in"
	cont "Kanto."
	done

PokemaniacEthanBeatenText:
	text "Gyaaaah!"
	done

HikerNolandSeenText:
	text "Are you alone?"
	line "Then let's battle!"
	done

HikerNolandBeatenText:
	text "That's too much to"
	line "handle!"
	done

UnknownText_0x75812:
	text "Yeah, I'm a sail-"
	line "or, all right."

	para "I wasn't goofing"
	line "off!"

	para "This cabin was"
	line "vacant, so I just"
	cont "took a quick nap!"

	para "Ah, forget it!"
	line "Let's battle!"
	done

UnknownText_0x75897:
	text "Sorry! It's all my"
	line "fault!"
	done

UnknownText_0x758b1:
	text "Being a sailor, I"
	line "have to do phys-"
	cont "ical labor. It's"
	cont "exhausting!"
	done

GentlemanEdwardSeenText:
	text "Oh, no. I've lost"
	line "something that's"
	cont "very important."
	done

GentlemanEdwardBeatenText:
	text "I… I can't find"
	line "it…"
	done

BurglarCoreySeenText:
	text "Yeehaw!"
	line "Lucky!"
	done

BurglarCoreyBeatenText:
	text "How unlucky!"
	line "I lost!"
	done

