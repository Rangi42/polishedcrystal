Route10PokeCenter1F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 3 ; warp events
	warp_event  5,  7, ROUTE_10_NORTH, 1
	warp_event  6,  7, ROUTE_10_NORTH, 1
	warp_event  0,  7, POKECENTER_2F, 1

	db 0 ; coord events

	db 1 ; bg events
	bg_event 10,  1, SIGNPOST_READ, PokemonJournalAgathaScript

	db 4 ; object events
	pc_nurse_event  5, 1
	object_event  8,  2, SPRITE_GYM_GUY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, Route10PokeCenter1FGymGuyScript, -1
	object_event  9,  4, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, Route10PokeCenter1FGentlemanText, -1
	object_event  2,  3, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, Route10PokeCenter1FCooltrainerfText, -1

PokemonJournalAgathaScript:
	setflag ENGINE_READ_AGATHA_JOURNAL
	thistext

	text "#mon Journal"

	para "Special Feature:"
	line "Ex-Elite Agatha!"

	para "In their youth,"
	line "Agatha and Prof."
	cont "Oak were rivals"

	para "who vied for supr-"
	line "emacy as trainers."
	done

Route10PokeCenter1FGymGuyScript:
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue_jumptextfaceplayer .Text2
	thistextfaceplayer

	text "The Power Plant's"
	line "Manager is looking"

	para "for a strong #-"
	line "mon trainer."

	para "He needs help"
	line "getting back"

	para "something that"
	line "was stolen."
	done

.Text2:
	text "I hear Team Rocket"
	line "got back together"

	para "in Johto but fell"
	line "apart right away."

	para "I didn't know any-"
	line "thing about that."
	done

Route10PokeCenter1FGentlemanText:
	text "A #mon Center"
	line "near a cave?"

	para "That's mighty"
	line "convenient."
	done

Route10PokeCenter1FCooltrainerfText:
	text "When you go out-"
	line "side, you can see"

	para "the roof of a big"
	line "building."

	para "That's the Power"
	line "Plant."
	done
