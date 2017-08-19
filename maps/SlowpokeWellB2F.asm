SlowpokeWellB2F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

SlowpokeWellB2F_MapEventHeader:

.Warps: db 1
	warp_def 11, 9, 2, SLOWPOKE_WELL_B1F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 2
	person_event SPRITE_GYM_GUY, 4, 5, SPRITEMOVEDATA_WANDER, 2, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 1, GymGuyScript_0x5ad0b, -1
	itemball_event 5, 15, DAMP_ROCK, 1, EVENT_SLOWPOKE_WELL_B2F_DAMP_ROCK

GymGuyScript_0x5ad0b:
	checkevent EVENT_GOT_KINGS_ROCK_IN_SLOWPOKE_WELL
	iftrue_jumptextfaceplayer UnknownText_0x5adf2
	faceplayer
	opentext
	writetext UnknownText_0x5ad2a
	buttonsound
	verbosegiveitem KINGS_ROCK
	iffalse_endtext
	setevent EVENT_GOT_KINGS_ROCK_IN_SLOWPOKE_WELL
	endtext

UnknownText_0x5ad2a:
	text "I'm waiting to see"
	line "Slowpoke's moment"
	cont "of evolution."

	para "Through observa-"
	line "tion, I made a new"
	cont "discovery."

	para "A Slowpoke with a"
	line "King's Rock often"

	para "gets bitten by a"
	line "Shellder."

	para "Here, I'll share a"
	line "King's Rock with"
	cont "you."
	done

UnknownText_0x5adf2:
	text "I'm going to be"
	line "like Slowpoke."

	para "I'll wait patient-"
	line "ly, so I can see"
	cont "one evolve."
	done
