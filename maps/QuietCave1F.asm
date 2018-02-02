QuietCave1F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 6 ; warp events
	warp_event 19, 33, ROUTE_47, 5
	warp_event  5, 25, QUIET_CAVE_B1F, 1
	warp_event 27, 23, QUIET_CAVE_B1F, 2
	warp_event 21,  9, QUIET_CAVE_B1F, 3
	warp_event  3, 17, QUIET_CAVE_B1F, 4
	warp_event 31, 13, QUIET_CAVE_B1F, 5

	db 0 ; coord events

	db 0 ; bg events

	db 7 ; object events
	object_event  6,  8, SPRITE_HEX_MANIAC, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 2, TrainerHexManiacAshley, -1
	object_event 13, 17, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 2, TrainerCooltrainermHenri, -1
	object_event 23, 25, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 2, TrainerHikerGrady, -1
	object_event 29,  4, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerScientistCarl, -1
	itemball_event 10, 23, NUGGET, 1, EVENT_QUIET_CAVE_1F_NUGGET
	itemball_event 26,  4, TWISTEDSPOON, 1, EVENT_QUIET_CAVE_1F_TWISTEDSPOON
	itemball_event 14,  2, DUSK_STONE, 1, EVENT_QUIET_CAVE_1F_DUSK_STONE
	itemball_event  3,  3, DUSK_BALL, 1, EVENT_QUIET_CAVE_1F_DUSK_BALL

TrainerHexManiacAshley:
	trainer HEX_MANIAC, ASHLEY, EVENT_BEAT_HEX_MANIAC_ASHLEY, HexManiacAshleySeenText, HexManiacAshleyBeatenText, 0, HexManiacAshleyScript

HexManiacAshleyScript:
	end_if_just_battled
	jumptextfaceplayer HexManiacAshleyAfterText

TrainerCooltrainermHenri:
	trainer COOLTRAINERM, HENRI, EVENT_BEAT_COOLTRAINERM_HENRI, CooltrainermHenriSeenText, CooltrainermHenriBeatenText, 0, CooltrainermHenriScript

CooltrainermHenriScript:
	end_if_just_battled
	jumptextfaceplayer CooltrainermHenriAfterText

TrainerHikerGrady:
	trainer HIKER, GRADY, EVENT_BEAT_HIKER_GRADY, HikerGradySeenText, HikerGradyBeatenText, 0, HikerGradyScript

HikerGradyScript:
	end_if_just_battled
	jumptextfaceplayer HikerGradyAfterText

TrainerScientistCarl:
	trainer SCIENTIST, CARL, EVENT_BEAT_SCIENTIST_CARL, ScientistCarlSeenText, ScientistCarlBeatenText, 0, ScientistCarlScript

ScientistCarlScript:
	end_if_just_battled
	jumptextfaceplayer ScientistCarlAfterText

HexManiacAshleySeenText:
	text "The spirits have"
	line "shown me your"
	cont "defeat!"
	done

HexManiacAshleyBeatenText:
	text "No! The spirits"
	line "can't be wrong!"
	done

HexManiacAshleyAfterText:
	text "I see things that"
	line "others can't see…"
	done

CooltrainermHenriSeenText:
	text "Can you handle my"
	line "balanced team of"
	cont "#mon?"
	done

CooltrainermHenriBeatenText:
	text "I guess you can!"
	done

CooltrainermHenriAfterText:
	text "Having a diverse"
	line "team to support"

	para "each others' weak-"
	line "nesses is key."
	done

HikerGradySeenText:
	text "I heard you long"
	line "before I saw you!"
	done

HikerGradyBeatenText:
	text "Ach!"
	done

HikerGradyAfterText:
	text "You could hear a"
	line "pin drop in this"
	cont "place!"
	done

ScientistCarlSeenText:
	text "I'm studying the"
	line "acoustics of this"
	cont "cave system."
	done

ScientistCarlBeatenText:
	text "My studies don't"
	line "apply to battles!"
	done

ScientistCarlAfterText:
	text "It's interesting"
	line "that such a quiet"
	cont "environment can"

	para "exist right near"
	line "rushing water."
	done
