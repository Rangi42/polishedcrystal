VermilionPokeCenter1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

VermilionPokeCenter1F_MapEventHeader:

.Warps: db 3
	warp_def $7, $5, 2, VERMILION_CITY
	warp_def $7, $6, 2, VERMILION_CITY
	warp_def $7, $0, 1, POKECENTER_2F

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 10, SIGNPOST_READ, PokemonJournalLtSurgeScript

.PersonEvents: db 4
	person_event SPRITE_NURSE, 1, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_JUMPSTD, 0, pokecenternurse, -1
	person_event SPRITE_SIGHTSEER_M, 2, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, SightseerMScript_0x191606, -1
	person_event SPRITE_SAILOR, 5, 2, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_JUMPTEXTFP, 0, UnknownText_0x1916fe, -1
	person_event SPRITE_BUG_CATCHER, 4, 9, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_JUMPTEXTFP, 0, UnknownText_0x19173b, -1

SightseerMScript_0x191606:
	faceplayer
	opentext
	checkevent EVENT_VERMILION_CITY_SNORLAX
	iftrue UnknownScript_0x191614
	jumpopenedtext UnknownText_0x191620

UnknownScript_0x191614:
	jumpopenedtext UnknownText_0x191698

PokemonJournalLtSurgeScript:
	setflag ENGINE_READ_LT_SURGE_JOURNAL
	jumptext PokemonJournalLtSurgeText

UnknownText_0x191620:
	text "A sleeping #mon"
	line "is lying in front"
	cont "of Diglett's Cave."

	para "It's a fantastic"
	line "opportunity to get"

	para "it, but how do you"
	line "wake it up?"
	done

UnknownText_0x191698:
	text "There used to be a"
	line "sleeping #mon"

	para "lying in front of"
	line "Diglett's Cave."

	para "But it seems to"
	line "have disappeared."
	done

UnknownText_0x1916fe:
	text "The Fast Ship is a"
	line "great place to"

	para "meet and battle"
	line "trainers."
	done

UnknownText_0x19173b:
	text "Oh? You have some"
	line "Badges I've never"
	cont "seen before."

	para "Oh, I get it. You"
	line "got them in Johto."
	done

PokemonJournalLtSurgeText:
	text "#mon Journal"

	para "Special Feature:"
	line "Leader Lt.Surge!"

	para "Lt.Surge is rumor-"
	line "ed to have been a"

	para "pilot while home"
	line "in America."

	para "He used the elec-"
	line "tricity generated"

	para "by #mon to pow-"
	line "er his plane."
	done
