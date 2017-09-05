Route10PokeCenter1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route10PokeCenter1F_MapEventHeader:

.Warps: db 3
	warp_def 7, 5, 1, ROUTE_10_NORTH
	warp_def 7, 6, 1, ROUTE_10_NORTH
	warp_def 7, 0, 1, POKECENTER_2F

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 10, SIGNPOST_READ, PokemonJournalAgathaScript

.PersonEvents: db 4
	pc_nurse_event 1, 5
	person_event SPRITE_GYM_GUY, 2, 8, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, Route10PokeCenter1FGymGuyScript, -1
	person_event SPRITE_GENTLEMAN, 4, 9, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, Route10PokeCenter1FGentlemanText, -1
	person_event SPRITE_COOLTRAINER_F, 3, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, Route10PokeCenter1FCooltrainerfText, -1

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
