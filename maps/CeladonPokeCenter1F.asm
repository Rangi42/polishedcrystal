const_value set 2
	const CELADONPOKECENTER1F_NURSE
	const CELADONPOKECENTER1F_GENTLEMAN
	const CELADONPOKECENTER1F_PHARMACIST
	const CELADONPOKECENTER1F_COOLTRAINER_F
	const CELADONPOKECENTER1F_EUSINE

CeladonPokeCenter1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

NurseScript_0x71e22:
	jumpstd pokecenternurse

GentlemanScript_0x71e25:
	jumpstd happinesschecknpc

CooltrainerFScript_0x71e28:
	jumptextfaceplayer UnknownText_0x71e70

PharmacistScript_0x71e2b:
	jumptextfaceplayer UnknownText_0x71ec1

CeladonEusine:
	faceplayer
	opentext
	writetext CeladonEusineText1
	buttonsound
	special SpecialBeastsCheck
	iftrue .HoOh
	writetext NoBeastsText1
	waitbutton
	closetext
	refreshscreen $0
	pokepic RAIKOU
	cry RAIKOU
	waitbutton
	closepokepic
	sawpokemon RAIKOU
	opentext
	writetext NoBeastsText2
	waitbutton
	closetext
	refreshscreen $0
	pokepic ENTEI
	cry ENTEI
	waitbutton
	closepokepic
	sawpokemon ENTEI
	opentext
	writetext NoBeastsText3
	waitbutton
	closetext
	refreshscreen $0
	pokepic SUICUNE
	cry SUICUNE
	waitbutton
	closepokepic
	sawpokemon SUICUNE
	opentext
	writetext NoBeastsText4
	waitbutton
	closetext
	end

.HoOh:
	writetext EusineLeavesCeladonText
	waitbutton
	closetext
	checkcode VAR_FACING
	if_equal $1, .Location1
	applymovement CELADONPOKECENTER1F_EUSINE, .Movement1
	jump .Continue

.Location1:
	applymovement CELADONPOKECENTER1F_EUSINE, .Movement2
.Continue:
	disappear CELADONPOKECENTER1F_EUSINE
	playsound SFX_EXIT_BUILDING
	waitsfx
	end

.Movement2:
	step_left
	step_down
	step_down
	step_down
	step_down
	step_end

.Movement1:
	step_down
	step_down
	step_down
	step_down
	step_end

UnknownText_0x71e70:
	text "Erika is a master"
	line "of grass #mon."

	para "She'll make you"
	line "pay if you don't"
	cont "watch yourself."
	done

UnknownText_0x71ec1:
	text "Team Rocket's"
	line "hideout is in the"

	para "basement of the"
	line "Game Corner."

	para "Oh, wait. That was"
	line "three years ago."
	done

CeladonEusineText1:
	text "Eusine: Hi!"

	para "I'm back visiting"
	line "my hometown."

	para "It's been quite a"
	line "while."
	done

EusineLeavesCeladonText:
	text "<PLAYER>, have you"
	line "heard?"

	para "There have been"
	line "fresh rumors of a"

	para "rainbow-colored"
	line "#mon appearing"
	cont "at Bell Tower."

	para "I've just had my"
	line "party healed, so"

	para "now I'm headed to"
	line "Ecruteak."

	para "I'll be seeing"
	line "you, <PLAYER>!"
	done

NoBeastsText1:
	text "Oh, by the way,"
	line "<PLAYER>."

	para "Have you caught"
	line "the legendary"
	cont "beast #mon?"

	para $56, $56, $56

	para "Okay…"

	para "Let me give you"
	line "my research notes."

	para "This is Raikou:"
	done

NoBeastsText2:
	text "This is Entei:"
	done

NoBeastsText3:
	text "And this, of"
	line "course, is Sui-"
	cont "cune."
	done

NoBeastsText4:
	text "If you catch even"
	line "one, I hope that"
	cont "you'll inform me."

	para "I'm counting on"
	line "you, <PLAYER>!"
	done

CeladonPokeCenter1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $7, $3, 5, CELADON_CITY
	warp_def $7, $4, 5, CELADON_CITY
	warp_def $7, $0, 1, POKECENTER_2F

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 5
	person_event SPRITE_NURSE, 1, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, NurseScript_0x71e22, -1
	person_event SPRITE_GENTLEMAN, 5, 1, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, GentlemanScript_0x71e25, -1
	person_event SPRITE_PHARMACIST, 3, 0, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, PharmacistScript_0x71e2b, -1
	person_event SPRITE_COOLTRAINER_F, 6, 8, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, CooltrainerFScript_0x71e28, -1
	person_event SPRITE_SUPER_NERD, 3, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeladonEusine, EVENT_SET_WHEN_FOUGHT_HO_OH
