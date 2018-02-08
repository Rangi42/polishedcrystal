AzaleaPokeCenter1F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 3 ; warp events
	warp_event  5,  7, AZALEA_TOWN, 1
	warp_event  6,  7, AZALEA_TOWN, 1
	warp_event  0,  7, POKECENTER_2F, 1

	db 0 ; coord events

	db 1 ; bg events
	bg_event 10,  1, SIGNPOST_READ, PokemonJournalBugsyScript

	db 5 ; object events
	pc_nurse_event  5, 1
	object_event  8,  4, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, AzaleaPokeCenter1FCooltrainermScript, -1
	object_event 11,  6, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, AzaleaPokeCenter1FGentlemanText, -1
	object_event  8,  1, SPRITE_SIGHTSEER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, AzaleaPokeCenter1FSightseermText, -1
	object_event  2,  5, SPRITE_POKEFAN_F, SPRITEMOVEDATA_WANDER, 2, 1, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, AzaleaPokeCenter1FPokefanfText, -1

PokemonJournalBugsyScript:
	setflag ENGINE_READ_BUGSY_JOURNAL
	thistext

	text "#mon Journal"

	para "Special Feature:"
	line "Leader Bugsy!"

	para "Bugsy is reported"
	line "to have won the"

	para "Bug-Catching Con-"
	line "test so often that"

	para "he no longer par-"
	line "ticipates."
	done

AzaleaPokeCenter1FCooltrainermScript:
	checktime 1 << NITE
	iftrue_jumptextfaceplayer .NiteText
	thistextfaceplayer

	text "For a guy who"
	line "makes # Balls,"

	para "Kurt isn't much of"
	line "a trainer."

	para "He does have a"
	line "#mon, but he"

	para "doesn't use it"
	line "much."
	done

.NiteText:
	text "Kurt and Prof.Oak"
	line "are old friends."

	para "They're also close"
	line "with Agatha, a"

	para "former member of"
	line "the Elite Four."
	done

AzaleaPokeCenter1FGentlemanText:
	text "Do your #mon"
	line "know HM moves?"

	para "Those moves can"
	line "be used even if"

	para "your #mon has"
	line "fainted."
	done

AzaleaPokeCenter1FSightseermText:
	text "This Bill guy"
	line "created the system"

	para "for storing"
	line "#mon in a PC."

	para "Bill's PC can"
	line "store up to 20"
	cont "#mon per Box."
	done

AzaleaPokeCenter1FPokefanfText:
	text "Do you know about"
	line "Apricorns?"

	para "Crack one open,"
	line "hollow it out and"

	para "fit it with a"
	line "special device."

	para "Then you can catch"
	line "#mon with it."

	para "Before # Balls"
	line "were invented,"

	para "everyone used"
	line "Apricorns."
	done
