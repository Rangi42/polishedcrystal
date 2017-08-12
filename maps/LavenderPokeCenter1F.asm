LavenderPokeCenter1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

LavenderPokeCenter1F_MapEventHeader:

.Warps: db 3
	warp_def $7, $5, 1, LAVENDER_TOWN
	warp_def $7, $6, 1, LAVENDER_TOWN
	warp_def $7, $0, 1, POKECENTER_2F

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 10, SIGNPOST_READ, PokemonJournalMrFujiScript

.PersonEvents: db 4
	person_event SPRITE_NURSE, 1, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumpstd, pokecenternurse, 0, -1
	person_event SPRITE_YOUNGSTER, 5, 1, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, LavenderPokeCenter1FYoungsterScript, -1
	person_event SPRITE_GENTLEMAN, 6, 11, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, LavenderPokeCenter1FGentlemanText, -1
	person_event SPRITE_TEACHER, 3, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, LavenderPokeCenter1FTeacherText, -1

PokemonJournalMrFujiScript:
	setflag ENGINE_READ_MR_FUJI_JOURNAL
	thistext

	text "#mon Journal"

	para "Editor: The shy"
	line "Mr.Fuji turned"

	para "down our interview"
	line "requests."

	para "He is a kindly man"
	line "who is adored and"

	para "respected in Lav-"
	line "ender Town."
	done

LavenderPokeCenter1FYoungsterScript:
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue_jumptextfaceplayer .Text2
	thistextfaceplayer

	text "If the Power Plant"
	line "isn't running, the"

	para "Magnet Train won't"
	line "run either…"

	para "It also means the"
	line "Radio Station"
	cont "can't broadcast…"
	done

.Text2:
	text "The Director of"
	line "the Radio Station"
	cont "sure was happy."

	para "He said they're"
	line "back on the air"

	para "because the Power"
	line "Plant is running"
	cont "smoothly again."
	done

LavenderPokeCenter1FGentlemanText:
	text "To the north of"
	line "Lavender is Rock"

	para "Tunnel. Go through"
	line "it to get to the"
	cont "Power Plant."
	done

LavenderPokeCenter1FTeacherText:
	text "There's a radio"
	line "program that plays"
	cont "# Flute music."

	para "Oh? Ah, your radio"
	line "needs an Expn.Card"
	cont "to tune into it."
	done
