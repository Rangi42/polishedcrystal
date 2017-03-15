const_value set 2
	const VERMILIONPOKECENTER1F_NURSE
	const VERMILIONPOKECENTER1F_SIGHTSEER_M
	const VERMILIONPOKECENTER1F_SAILOR
	const VERMILIONPOKECENTER1F_BUG_CATCHER

VermilionPokeCenter1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

NurseScript_0x191603:
	jumpstd pokecenternurse

SightseerMScript_0x191606:
	faceplayer
	opentext
	checkevent EVENT_FOUGHT_SNORLAX
	iftrue UnknownScript_0x191614
	writetext UnknownText_0x191620
	waitbutton
	closetext
	end

UnknownScript_0x191614:
	writetext UnknownText_0x191698
	waitbutton
	closetext
	end

SailorScript_0x19161a:
	jumptextfaceplayer UnknownText_0x1916fe

BugCatcherScript_0x19161d:
	jumptextfaceplayer UnknownText_0x19173b

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

VermilionPokeCenter1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $7, $5, 2, VERMILION_CITY
	warp_def $7, $6, 2, VERMILION_CITY
	warp_def $7, $0, 1, POKECENTER_2F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 4
	person_event SPRITE_NURSE, 1, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, NurseScript_0x191603, -1
	person_event SPRITE_SIGHTSEER_M, 2, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, SightseerMScript_0x191606, -1
	person_event SPRITE_SAILOR, 5, 2, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, SailorScript_0x19161a, -1
	person_event SPRITE_BUG_CATCHER, 4, 9, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, BugCatcherScript_0x19161d, -1
