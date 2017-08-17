CeladonPokeCenter1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeladonPokeCenter1F_MapEventHeader:

.Warps: db 3
	warp_def 7, 5, 5, CELADON_CITY
	warp_def 7, 6, 5, CELADON_CITY
	warp_def 7, 0, 1, POKECENTER_2F

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 10, SIGNPOST_READ, PokemonJournalErikaScript

.PersonEvents: db 5
	pc_nurse_event 1, 5
	person_event SPRITE_GENTLEMAN, 5, 2, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_COMMAND, jumpstd, happinesschecknpc, -1
	person_event SPRITE_PHARMACIST, 3, 1, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonPokeCenter1FPharmacistText, -1
	person_event SPRITE_COOLTRAINER_F, 5, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonPokeCenter1FCooltrainerfText, -1
	person_event SPRITE_LASS, 6, 11, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonPokeCenter1FLassText, -1

PokemonJournalErikaScript:
	setflag ENGINE_READ_ERIKA_JOURNAL
	thistext

	text "#mon Journal"

	para "Special Feature:"
	line "Leader Erika!"

	para "Rumor has it that"
	line "if you peek into"
	cont "Celadon Gym, you"

	para "can often see"
	line "Erika snoozing."
	done

CeladonPokeCenter1FPharmacistText:
	text "Team Rocket's"
	line "hideout is in the"

	para "basement of the"
	line "Game Corner."

	para "Oh, wait. That was"
	line "three years ago."
	done

CeladonPokeCenter1FCooltrainerfText:
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
