const_value set 2
	const FUCHSIAPOKECENTER1F_NURSE
	const FUCHSIAPOKECENTER1F_COOLTRAINER_M
	const FUCHSIAPOKECENTER1F_COOLTRAINER_F
	const FUCHSIAPOKECENTER1F_JANINE_IMPERSONATOR

FuchsiaPokeCenter1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

NurseScript_0x196459:
	jumpstd pokecenternurse

CooltrainerMScript_0x19645c:
	jumptextfaceplayer UnknownText_0x196494

CooltrainerFScript_0x19645f:
	jumptextfaceplayer UnknownText_0x1964dc

JanineImpersonatorScript_0x196462:
	faceplayer
	opentext
	writetext UnknownText_0x19652e
	waitbutton
	closetext
	applymovement FUCHSIAPOKECENTER1F_JANINE_IMPERSONATOR, MovementData_0x196486
	faceplayer
	variablesprite SPRITE_JANINE_IMPERSONATOR, SPRITE_JANINE
	special RunCallback_04
	opentext
	writetext UnknownText_0x19654e
	waitbutton
	closetext
	applymovement FUCHSIAPOKECENTER1F_JANINE_IMPERSONATOR, MovementData_0x196486
	faceplayer
	variablesprite SPRITE_JANINE_IMPERSONATOR, SPRITE_LASS
	special RunCallback_04
	end

PokemonJournalJanineScript:
	setflag ENGINE_READ_JANINE_JOURNAL
	jumptext PokemonJournalJanineText

MovementData_0x196486:
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	turn_head_down
	step_end

UnknownText_0x196494:
	text "Hey! You have a"
	line "brand new kind of"
	cont "#dex."

	para "Did Prof.Oak give"
	line "that to you?"
	done

UnknownText_0x1964dc:
	text "I got quite a"
	line "shock at the Gym."

	para "There were all"
	line "these girls who"
	cont "looked identical."
	done

UnknownText_0x19652e:
	text "I'm Janine! Hocus-"
	line "pocus… Poof!"
	done

UnknownText_0x19654e:
	text "See? I look just"
	line "like her now!"
	done

PokemonJournalJanineText:
	text "#mon Journal"

	para "Special Feature:"
	line "Leader Janine!"

	para "Janine was said to"
	line "be a fan of the"

	para "#mon zoo in"
	line "Fuchsia City"
	cont "as a child."
	done

FuchsiaPokeCenter1F_MapEventHeader:
.Warps:
	db 3
	warp_def $7, $5, 4, FUCHSIA_CITY
	warp_def $7, $6, 4, FUCHSIA_CITY
	warp_def $7, $0, 1, POKECENTER_2F

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 1, 10, SIGNPOST_READ, PokemonJournalJanineScript

.PersonEvents:
	db 4
	person_event SPRITE_NURSE, 1, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, NurseScript_0x196459, -1
	person_event SPRITE_COOLTRAINER_M, 4, 9, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CooltrainerMScript_0x19645c, -1
	person_event SPRITE_COOLTRAINER_F, 4, 1, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CooltrainerFScript_0x19645f, -1
	person_event SPRITE_JANINE_IMPERSONATOR, 3, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, JanineImpersonatorScript_0x196462, -1
