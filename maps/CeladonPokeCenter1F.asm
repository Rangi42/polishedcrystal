CeladonPokeCenter1F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 3 ; warp events
	warp_event  5,  7, CELADON_CITY, 5
	warp_event  6,  7, CELADON_CITY, 5
	warp_event  0,  7, POKECENTER_2F, 1

	db 0 ; coord events

	db 1 ; bg events
	bg_event 10,  1, SIGNPOST_READ, PokemonJournalErikaScript

	db 5 ; object events
	pc_nurse_event  5, 1
	object_event  2,  5, SPRITE_GENTLEMAN, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_COMMAND, jumpstd, happinesschecknpc, -1
	object_event  1,  3, SPRITE_PHARMACIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonPokeCenter1FPharmacistText, -1
	object_event 11,  5, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonPokeCenter1FCooltrainerfText, -1
	object_event 11,  6, SPRITE_LASS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, CeladonPokeCenter1FLassText, -1

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
