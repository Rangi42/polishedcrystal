ViridianPokeCenter1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

ViridianPokeCenter1F_MapEventHeader:

.Warps: db 3
	warp_def 7, 5, 5, VIRIDIAN_CITY
	warp_def 7, 6, 5, VIRIDIAN_CITY
	warp_def 7, 0, 1, POKECENTER_2F

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 10, SIGNPOST_READ, PokemonJournalBlueScript

.PersonEvents: db 4
	pc_nurse_event 1, 5
	person_event SPRITE_COOLTRAINER_M, 4, 2, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ViridianPokeCenter1FCooltrainermScript, -1
	person_event SPRITE_COOLTRAINER_F, 4, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, ViridianPokeCenter1FCooltrainerfText, -1
	person_event SPRITE_BUG_CATCHER, 6, 3, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, ViridianPokeCenter1FBugCatcherText, -1

PokemonJournalBlueScript:
	setflag ENGINE_READ_BLUE_JOURNAL
	thistext

	text "#mon Journal"

	para "Special Feature:"
	line "Leader Blue!"

	para "Blue supposedly"
	line "visits his cher-"
	cont "ished #mon"

	para "every year in the"
	line "House of Memories."
	done

ViridianPokeCenter1FCooltrainermScript:
	checkevent EVENT_BLUE_IN_CINNABAR
	iftrue_jumptextfaceplayer .BlueText
	thistextfaceplayer

	text "Where in the world"
	line "is Viridian's Gym"

	para "Leader? I wanted"
	line "to challenge him."
	done

.BlueText:
	text "There are strong"
	line "Gym Trainers at"
	cont "the Viridian Gym."

	para "Someday I'm going"
	line "to join them!"
	done

ViridianPokeCenter1FCooltrainerfText:
	text "I heard that the"
	line "Gym in Cinnabar is"
	cont "gone."

	para "I wonder what be-"
	line "came of Blaine,"
	cont "the Gym Leader."
	done

ViridianPokeCenter1FBugCatcherText:
	text "My dream is to be-"
	line "come a Gym Leader."
	done
