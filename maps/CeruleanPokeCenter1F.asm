CeruleanPokeCenter1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeruleanPokeCenter1F_MapEventHeader:

.Warps: db 3
	warp_def 7, 5, 4, CERULEAN_CITY
	warp_def 7, 6, 4, CERULEAN_CITY
	warp_def 7, 0, 1, POKECENTER_2F

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 10, SIGNPOST_READ, PokemonJournalMistyScript

.PersonEvents: db 3
	pc_nurse_event 1, 5
	person_event SPRITE_GYM_GUY, 5, 1, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, CeruleanPokeCenter1FGymGuyScript, -1
	person_event SPRITE_SUPER_NERD, 4, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, CeruleanPokeCenter1FSuperNerdText, -1

PokemonJournalMistyScript:
	setflag ENGINE_READ_MISTY_JOURNAL
	thistext

	text "#mon Journal"

	para "Special Feature:"
	line "Leader Misty!"

	para "Misty is said to"
	line "worship Lorelei,"

	para "a former member of"
	line "the Elite Four."
	done

CeruleanPokeCenter1FGymGuyScript:
	checkunits
	iftrue_jumptextfaceplayer .MetricText
	thistextfaceplayer

	text "The Magnet Train"
	line "travels at over"

	para "340 mph. It goes"
	line "between Kanto and"

	para "Johto in almost no"
	line "time at all."

	para "It really makes"
	line "Johto accessible."
	done

.MetricText:
	text "The Magnet Train"
	line "travels at over"

	para "550 kph. It goes"
	line "between Kanto and"

	para "Johto in almost no"
	line "time at all."

	para "It really makes"
	line "Johto accessible."
	done

CeruleanPokeCenter1FSuperNerdText:
	text "For battles, I'd"
	line "much rather use"

	para "#mon I've been"
	line "raising, even if"

	para "they're weaker"
	line "than some newly"
	cont "caught #mon."
	done
