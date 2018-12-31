FastShipCabins_NNW_NNE_NE_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

FastShipCabins_NNW_NNE_NE_MapEventHeader:

.Warps: db 3
	warp_def 0, 2, 2, FAST_SHIP_1F
	warp_def 12, 2, 3, FAST_SHIP_1F
	warp_def 24, 2, 4, FAST_SHIP_1F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 8
	person_event SPRITE_SAILOR, 26, 4, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, SailorScript_0x755f1, EVENT_FAST_SHIP_CABINS_NNW_NNE_NE_SAILOR
	person_event SPRITE_PI, 5, 4, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerPILooker, EVENT_FAST_SHIP_PASSENGERS_FIRST_TRIP
	person_event SPRITE_COOLTRAINER_M, 3, 4, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 2, TrainerCooltrainermSean, EVENT_FAST_SHIP_PASSENGERS_EASTBOUND
	person_event SPRITE_COOLTRAINER_F, 5, 1, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerCooltrainerfCarol, EVENT_FAST_SHIP_PASSENGERS_EASTBOUND
	person_event SPRITE_SUPER_NERD, 5, 1, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 3, TrainerPokemaniacEthan, EVENT_FAST_SHIP_PASSENGERS_WESTBOUND
	person_event SPRITE_POKEFAN_M, 17, 4, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerHikerNoland, EVENT_FAST_SHIP_PASSENGERS_FIRST_TRIP
	person_event SPRITE_GENTLEMAN, 30, 7, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerGentlemanEdward, EVENT_FAST_SHIP_PASSENGERS_EASTBOUND
	person_event SPRITE_PHARMACIST, 30, 2, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 4, TrainerBurglarCorey, EVENT_FAST_SHIP_PASSENGERS_WESTBOUND

const_value set 1
	const FASTSHIPCABINS_NNW_NNE_NE_SAILOR

TrainerPILooker:
	trainer EVENT_BEAT_PI_LOOKER, PI, LOOKER, PILookerSeenText, PILookerBeatenText, 0, PILookerScript

PILookerScript:
	end_if_just_battled
	jumptextfaceplayer PILookerAfterText

TrainerCooltrainermSean:
	trainer EVENT_BEAT_COOLTRAINERM_SEAN, COOLTRAINERM, SEAN, CooltrainermSeanSeenText, CooltrainermSeanBeatenText, 0, CooltrainermSeanScript

CooltrainermSeanScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x7567b

TrainerCooltrainerfCarol:
	trainer EVENT_BEAT_COOLTRAINERF_CAROL, COOLTRAINERF, CAROL, CooltrainerfCarolSeenText, CooltrainerfCarolBeatenText, 0, CooltrainerfCarolScript

CooltrainerfCarolScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x756f7

TrainerPokemaniacEthan:
	trainer EVENT_BEAT_POKEMANIAC_ETHAN, POKEMANIAC, ETHAN, PokemaniacEthanSeenText, PokemaniacEthanBeatenText, 0, PokemaniacEthanScript

PokemaniacEthanScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x7574b

TrainerHikerNoland:
	trainer EVENT_BEAT_HIKER_NOLAND, HIKER, NOLAND, HikerNolandSeenText, HikerNolandBeatenText, 0, HikerNolandScript

HikerNolandScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x757d4

TrainerGentlemanEdward:
	trainer EVENT_BEAT_GENTLEMAN_EDWARD, GENTLEMAN, EDWARD, GentlemanEdwardSeenText, GentlemanEdwardBeatenText, 0, GentlemanEdwardScript

GentlemanEdwardScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x75937

TrainerBurglarCorey:
	trainer EVENT_BEAT_BURGLAR_COREY, BURGLAR, COREY, BurglarCoreySeenText, BurglarCoreyBeatenText, 0, BurglarCoreyScript

BurglarCoreyScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x75996

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
	domaptrigger FAST_SHIP_B1F, $1
	checkcode VAR_FACING
	if_equal $3, UnknownScript_0x75629
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

PILookerAfterText:
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

CooltrainermSeanSeenText:
	text "I'm going to Kanto"
	line "to test my skills."
	done

CooltrainermSeanBeatenText:
	text "I wanted to win!"
	done

UnknownText_0x7567b:
	text "Trainers from"
	line "Johto can battle"

	para "with Kanto Gym"
	line "Leaders."
	done

CooltrainerfCarolSeenText:
	text "I'm training to"
	line "become the Champ!"
	done

CooltrainerfCarolBeatenText:
	text "What's so differ-"
	line "ent between us?"
	done

UnknownText_0x756f7:
	text "I'm going to beat"
	line "you someday!"
	done

PokemaniacEthanSeenText:
	text "Do you know Lily?"
	line "She's a hot DJ in"
	cont "Kanto."
	done

PokemaniacEthanBeatenText:
	text "Gyaaaah!"
	done

UnknownText_0x7574b:
	text "Lily's nice, but"
	line "Mary's the best!"

	para "I want to check"
	line "out Johto's radio"
	cont "programs!"
	done

HikerNolandSeenText:
	text "Are you alone?"
	line "Then let's battle!"
	done

HikerNolandBeatenText:
	text "That's too much to"
	line "handle!"
	done

UnknownText_0x757d4:
	text "I wonder if there"
	line "are any mountains"

	para "worth climbing in"
	line "Kanto?"
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

UnknownText_0x75937:
	text "I give up."
	line "You don't have to"

	para "look. Just forget"
	line "about it!"
	done

BurglarCoreySeenText:
	text "Yeehaw!"
	line "Lucky!"
	done

BurglarCoreyBeatenText:
	text "How unlucky!"
	line "I lost!"
	done

UnknownText_0x75996:
	text "I found a pretty"
	line "coin here."

	para "Someone must have"
	line "lost it…"
	done
