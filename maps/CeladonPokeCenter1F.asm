const_value set 2
	const CELADONPOKECENTER1F_NURSE
	const CELADONPOKECENTER1F_GENTLEMAN
	const CELADONPOKECENTER1F_PHARMACIST
	const CELADONPOKECENTER1F_COOLTRAINER_F
	const CELADONPOKECENTER1F_LASS

CeladonPokeCenter1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

NurseScript_0x71e22:
	jumpstd pokecenternurse

GentlemanScript_0x71e25:
	jumpstd happinesschecknpc

CooltrainerFScript_0x71e28:
	jumptextfaceplayer UnknownText_0x71e70

CeladonPokeCenter1FLassScript:
	jumptextfaceplayer CeladonPokeCenter1FLassText

PharmacistScript_0x71e2b:
	jumptextfaceplayer UnknownText_0x71ec1

PokemonJournalErikaScript:
	setflag ENGINE_READ_ERIKA_JOURNAL
	jumptext PokemonJournalErikaText

UnknownText_0x71e70:
	text "Erika is a master"
	line "of grass #mon."

	para "She'll make you"
	line "pay if you don't"
	cont "watch yourself."
	done

CeladonPokeCenter1FLassText:
	text "Erika isn't just"
	line "a Gym Leader."

	para "She also lectures"
	line "at the university."
	done

UnknownText_0x71ec1:
	text "Team Rocket's"
	line "hideout is in the"

	para "basement of the"
	line "Game Corner."

	para "Oh, wait. That was"
	line "three years ago."
	done

PokemonJournalErikaText:
	text "#mon Journal"

	para "Special Feature:"
	line "Leader Erika!"

	para "Rumor has it that"
	line "if you peek into"
	cont "Celadon Gym, you"

	para "can often see"
	line "Erika snoozing."
	done

CeladonPokeCenter1F_MapEventHeader:
.Warps:
	db 3
	warp_def $7, $5, 5, CELADON_CITY
	warp_def $7, $6, 5, CELADON_CITY
	warp_def $7, $0, 1, POKECENTER_2F

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 1, 10, SIGNPOST_READ, PokemonJournalErikaScript

.PersonEvents:
	db 5
	person_event SPRITE_NURSE, 1, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, NurseScript_0x71e22, -1
	person_event SPRITE_GENTLEMAN, 5, 2, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, GentlemanScript_0x71e25, -1
	person_event SPRITE_PHARMACIST, 3, 1, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, PharmacistScript_0x71e2b, -1
	person_event SPRITE_COOLTRAINER_F, 5, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, CooltrainerFScript_0x71e28, -1
	person_event SPRITE_LASS, 6, 11, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CeladonPokeCenter1FLassScript, -1
