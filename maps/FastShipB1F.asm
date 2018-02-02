FastShipB1F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  1,  9, FAST_SHIP_1F, 11
	warp_event 27, 11, FAST_SHIP_1F, 12

	db 2 ; coord events
	coord_event 26,  5, 0, UnknownScript_0x7673c
	coord_event 27,  5, 0, UnknownScript_0x76751

	db 0 ; bg events

	db 13 ; object events
	object_event 26,  4, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, SailorScript_0x76767, EVENT_FAST_SHIP_B1F_SAILOR_LEFT
	object_event 27,  4, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, SailorScript_0x76767, EVENT_FAST_SHIP_B1F_SAILOR_RIGHT
	object_event  5,  9, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerSailorJeff, EVENT_FAST_SHIP_PASSENGERS_FIRST_TRIP
	object_event  2,  2, SPRITE_LASS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerPicnickerDebra, EVENT_FAST_SHIP_PASSENGERS_FIRST_TRIP
	object_event 22,  7, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerJugglerFritz, EVENT_FAST_SHIP_PASSENGERS_FIRST_TRIP
	object_event 10, 11, SPRITE_BAKER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 2, TrainerBakerSharyn, EVENT_FAST_SHIP_PASSENGERS_FIRST_TRIP
	object_event 13,  2, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 4, TrainerSailorGarrett, EVENT_FAST_SHIP_PASSENGERS_EASTBOUND
	object_event 21,  6, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerFisherJonah, EVENT_FAST_SHIP_PASSENGERS_EASTBOUND
	object_event 11,  9, SPRITE_BLACK_BELT, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerBlackbeltWai, EVENT_FAST_SHIP_PASSENGERS_EASTBOUND
	object_event 19,  2, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 4, TrainerSailorKenneth, EVENT_FAST_SHIP_PASSENGERS_WESTBOUND
	object_event  5,  9, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerTeacherShirley, EVENT_FAST_SHIP_PASSENGERS_WESTBOUND
	object_event 10,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerSchoolboyNate, EVENT_FAST_SHIP_PASSENGERS_WESTBOUND
	object_event 10,  9, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerSchoolboyRicky, EVENT_FAST_SHIP_PASSENGERS_WESTBOUND

	const_def 1 ; object constants
	const FASTSHIPB1F_SAILOR1
	const FASTSHIPB1F_SAILOR2

UnknownScript_0x7673c:
	checkevent EVENT_FAST_SHIP_B1F_SAILOR_RIGHT
	iftrue UnknownScript_0x76766
	applymovement FASTSHIPB1F_SAILOR2, MovementData_0x76876
	moveperson FASTSHIPB1F_SAILOR1, 26, 4
	appear FASTSHIPB1F_SAILOR1
	pause 5
	disappear FASTSHIPB1F_SAILOR2
	end

UnknownScript_0x76751:
	checkevent EVENT_FAST_SHIP_B1F_SAILOR_LEFT
	iftrue UnknownScript_0x76766
	applymovement FASTSHIPB1F_SAILOR1, MovementData_0x76871
	moveperson FASTSHIPB1F_SAILOR2, 27, 4
	appear FASTSHIPB1F_SAILOR2
	pause 5
	disappear FASTSHIPB1F_SAILOR1
UnknownScript_0x76766:
	end

SailorScript_0x76767:
	faceplayer
	opentext
	checkevent EVENT_FAST_SHIP_FIRST_TIME
	iftrue UnknownScript_0x767a0
	checkevent EVENT_FAST_SHIP_LAZY_SAILOR
	iftrue UnknownScript_0x7678d
	checkevent EVENT_FAST_SHIP_INFORMED_ABOUT_LAZY_SAILOR
	iftrue UnknownScript_0x76787
	setevent EVENT_FAST_SHIP_INFORMED_ABOUT_LAZY_SAILOR
	clearevent EVENT_FAST_SHIP_CABINS_NNW_NNE_NE_SAILOR
	jumpopenedtext UnknownText_0x7687b

UnknownScript_0x76787:
	jumpopenedtext UnknownText_0x76907

UnknownScript_0x7678d:
	writetext UnknownText_0x7692e
	checkevent EVENT_FAST_SHIP_FOUND_GIRL
	iffalse UnknownScript_0x76799
	waitendtext

UnknownScript_0x76799:
	buttonsound
	jumpopenedtext UnknownText_0x7696d

UnknownScript_0x767a0:
	jumpopenedtext UnknownText_0x7699d

TrainerSailorJeff:
	trainer SAILOR, JEFF, EVENT_BEAT_SAILOR_JEFF, SailorJeffSeenText, SailorJeffBeatenText, 0, SailorJeffScript

SailorJeffScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x76a38

TrainerPicnickerDebra:
	trainer PICNICKER, DEBRA, EVENT_BEAT_PICNICKER_DEBRA, PicnickerDebraSeenText, PicnickerDebraBeatenText, 0, PicnickerDebraScript

PicnickerDebraScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x76a99

TrainerJugglerFritz:
	trainer JUGGLER, FRITZ, EVENT_BEAT_JUGGLER_FRITZ, JugglerFritzSeenText, JugglerFritzBeatenText, 0, JugglerFritzScript

JugglerFritzScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x76b02

TrainerBakerSharyn:
	trainer BAKER, SHARYN, EVENT_BEAT_BAKER_SHARYN, BakerSharynSeenText, BakerSharynBeatenText, 0, BakerSharynScript

BakerSharynScript:
	end_if_just_battled
	jumptextfaceplayer BakerSharynAfterText

TrainerSailorGarrett:
	trainer SAILOR, GARRETT, EVENT_BEAT_SAILOR_GARRETT, SailorGarrettSeenText, SailorGarrettBeatenText, 0, SailorGarrettScript

SailorGarrettScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x76b7a

TrainerFisherJonah:
	trainer FISHER, JONAH, EVENT_BEAT_FISHER_JONAH, FisherJonahSeenText, FisherJonahBeatenText, 0, FisherJonahScript

FisherJonahScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x76c22

TrainerBlackbeltWai:
	trainer BLACKBELT_T, WAI, EVENT_BEAT_BLACKBELT_WAI, BlackbeltWaiSeenText, BlackbeltWaiBeatenText, 0, BlackbeltWaiScript

BlackbeltWaiScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x76c9e

TrainerSailorKenneth:
	trainer SAILOR, KENNETH, EVENT_BEAT_SAILOR_KENNETH, SailorKennethSeenText, SailorKennethBeatenText, 0, SailorKennethScript

SailorKennethScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x76d5f

TrainerTeacherShirley:
	trainer TEACHER, SHIRLEY, EVENT_BEAT_TEACHER_SHIRLEY, TeacherShirleySeenText, TeacherShirleyBeatenText, 0, TeacherShirleyScript

TeacherShirleyScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x76de1

TrainerSchoolboyNate:
	trainer SCHOOLBOY, NATE, EVENT_BEAT_SCHOOLBOY_NATE, SchoolboyNateSeenText, SchoolboyNateBeatenText, 0, SchoolboyNateScript

SchoolboyNateScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x76e3d

TrainerSchoolboyRicky:
	trainer SCHOOLBOY, RICKY, EVENT_BEAT_SCHOOLBOY_RICKY, SchoolboyRickySeenText, SchoolboyRickyBeatenText, 0, SchoolboyRickyScript

SchoolboyRickyScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x76eb6

MovementData_0x76871:
	fix_facing
	big_step_right
	remove_fixed_facing
	turn_head_down
	step_end

MovementData_0x76876:
	fix_facing
	big_step_left
	remove_fixed_facing
	turn_head_down
	step_end

UnknownText_0x7687b:
	text "Hey, kid. Could I"
	line "get you to look"
	cont "for my buddy?"

	para "He's goofing off"
	line "somewhere, that"
	cont "lazy bum!"

	para "I want to go find"
	line "him, but I'm on"
	cont "duty right now."
	done

UnknownText_0x76907:
	text "Oh, gee…"

	para "The Captain will"
	line "be furious…"
	done

UnknownText_0x7692e:
	text "Thanks, kid!"
	line "I chewed him out"

	para "good so he'll quit"
	line "slacking off!"
	done

UnknownText_0x7696d:
	text "A little girl?"

	para "I may have seen"
	line "her go by here."
	done

UnknownText_0x7699d:
	text "The dining room is"
	line "up ahead."

	para "The stairs at the"
	line "end lead to the"
	cont "Captain's cabin."
	done

SailorJeffSeenText:
	text "Nothing beats a"
	line "battle when I'm"
	cont "on my break."
	done

SailorJeffBeatenText:
	text "Win or lose, my"
	line "break's over!"
	done

UnknownText_0x76a38:
	text "I guess I can't"
	line "win if I don't get"
	cont "serious."
	done

PicnickerDebraSeenText:
	text "I'm so bored."
	line "Want to battle?"
	done

PicnickerDebraBeatenText:
	text "Yow! You're too"
	line "strong!"
	done

UnknownText_0x76a99:
	text "Saffron, Celadon…"
	line "I hear there are"

	para "many big cities"
	line "in Kanto."
	done

JugglerFritzSeenText:
	text "Urrf…"
	line "I'm seasick!"
	done

JugglerFritzBeatenText:
	text "I can't move any-"
	line "more…"
	done

UnknownText_0x76b02:
	text "No more ships for"
	line "me. Next time,"

	para "I'm taking the"
	line "Magnet Train."
	done

BakerSharynSeenText:
	text "As I bake bread,"
	line "I will bake your"
	cont "#mon, too!"
	done

BakerSharynBeatenText:
	text "At least my bread"
	line "is a winner."
	done

BakerSharynAfterText:
	text "I may not be the"
	line "best at battles,"

	para "but people love"
	line "my baking."
	done

SailorGarrettSeenText:
	text "This is where we"
	line "sailors work!"
	done

SailorGarrettBeatenText:
	text "I lost on my home"
	line "field…"
	done

UnknownText_0x76b7a:
	text "We get different"
	line "passengers from"

	para "Vermilion City to"
	line "Olivine City."
	done

FisherJonahSeenText:
	text "Even though we're"
	line "out on the sea, I"
	cont "can't fish!"

	para "This is boring!"
	line "Let's battle!"
	done

FisherJonahBeatenText:
	text "I… I'm not bored"
	line "anymore…"
	done

UnknownText_0x76c22:
	text "I plan to fish off"
	line "Vermilion's pier."
	done

BlackbeltWaiSeenText:
	text "I'm building up my"
	line "legs by bracing"

	para "against the ship's"
	line "rocking!"
	done

BlackbeltWaiBeatenText:
	text "Rocked and rolled"
	line "over!"
	done

UnknownText_0x76c9e:
	text "I couldn't find"
	line "the Karate King in"
	cont "Johto."

	para "He's supposed to"
	line "be training in a"
	cont "cave somewhere."
	done

SailorKennethSeenText:
	text "I'm a sailor man!"

	para "But I'm training"
	line "#mon, so I can"
	cont "become the Champ!"
	done

SailorKennethBeatenText:
	text "My lack of train-"
	line "ing is obvious…"
	done

UnknownText_0x76d5f:
	text "Eight Badges!"
	line "They must prove"

	para "that you've beaten"
	line "Gym Leaders."

	para "No wonder you're"
	line "so good!"
	done

TeacherShirleySeenText:
	text "Don't lay a finger"
	line "on my students!"
	done

TeacherShirleyBeatenText:
	text "Aaack!"
	done

UnknownText_0x76de1:
	text "We're on a field"
	line "trip to the ruins"
	cont "outside Violet."
	done

SchoolboyNateSeenText:
	text "Do you know the"
	line "Ruins of Alph?"
	done

SchoolboyNateBeatenText:
	text "Yaargh!"
	done

UnknownText_0x76e3d:
	text "Radios pick up"
	line "strange signals"
	cont "inside the ruins."
	done

SchoolboyRickySeenText:
	text "There are some odd"
	line "stone panels in"
	cont "the Ruins of Alph."
	done

SchoolboyRickyBeatenText:
	text "I was done in!"
	done

UnknownText_0x76eb6:
	text "I read in a #-"
	line "mon Journal that"

	para "there are four of"
	line "those stone panels"
	cont "in the ruins."
	done
