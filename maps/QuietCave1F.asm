QuietCave1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

QuietCave1F_MapEventHeader:

.Warps: db 6
	warp_def 33, 19, 5, ROUTE_47
	warp_def 25, 5, 1, QUIET_CAVE_B1F
	warp_def 23, 27, 2, QUIET_CAVE_B1F
	warp_def 9, 21, 3, QUIET_CAVE_B1F
	warp_def 17, 3, 4, QUIET_CAVE_B1F
	warp_def 13, 31, 5, QUIET_CAVE_B1F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 7
	person_event SPRITE_HEX_MANIAC, 8, 6, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 2, TrainerHexManiacAshley, -1
	person_event SPRITE_COOLTRAINER_M, 17, 13, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 2, TrainerCooltrainermHenri, -1
	person_event SPRITE_POKEFAN_M, 25, 23, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 2, TrainerHikerGrady, -1
	person_event SPRITE_SCIENTIST, 4, 29, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerScientistCarl, -1
	itemball_event 23, 10, NUGGET, 1, EVENT_QUIET_CAVE_1F_NUGGET
	itemball_event 4, 26, TWISTEDSPOON, 1, EVENT_QUIET_CAVE_1F_TWISTEDSPOON
	itemball_event 2, 14, DUSK_STONE, 1, EVENT_QUIET_CAVE_1F_DUSK_STONE
	itemball_event 3, 3, DUSK_BALL, 1, EVENT_QUIET_CAVE_1F_DUSK_BALL

TrainerHexManiacAshley:
	trainer EVENT_BEAT_HEX_MANIAC_ASHLEY, HEX_MANIAC, ASHLEY, HexManiacAshleySeenText, HexManiacAshleyBeatenText, 0, HexManiacAshleyScript

HexManiacAshleyScript:
	end_if_just_battled
	jumptextfaceplayer HexManiacAshleyAfterText

TrainerCooltrainermHenri:
	trainer EVENT_BEAT_COOLTRAINERM_HENRI, COOLTRAINERM, HENRI, CooltrainermHenriSeenText, CooltrainermHenriBeatenText, 0, CooltrainermHenriScript

CooltrainermHenriScript:
	end_if_just_battled
	jumptextfaceplayer CooltrainermHenriAfterText

TrainerHikerGrady:
	trainer EVENT_BEAT_HIKER_GRADY, HIKER, GRADY, HikerGradySeenText, HikerGradyBeatenText, 0, HikerGradyScript

HikerGradyScript:
	end_if_just_battled
	jumptextfaceplayer HikerGradyAfterText

TrainerScientistCarl:
	trainer EVENT_BEAT_SCIENTIST_CARL, SCIENTIST, CARL, ScientistCarlSeenText, ScientistCarlBeatenText, 0, ScientistCarlScript

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
