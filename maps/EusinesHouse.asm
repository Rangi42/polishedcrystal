EusinesHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, CELADON_CITY, 14
	warp_event  3,  7, CELADON_CITY, 14

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_EUSINE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonEusine, EVENT_SET_WHEN_FOUGHT_HO_OH
	object_event  5,  3, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EusinesHouseGrampsScript, -1

	object_const_def
	const EUSINESHOUSE_EUSINE

CeladonEusine:
	faceplayer
	opentext
	writetext CeladonEusineText1
	promptbutton
	special SpecialBeastsCheck
	iftrue .HoOh
	writetext EusineNoBeastsText
	waitbutton
	closetext
	setval RAIKOU
	special SpecialMonCheck
	iftrue .OwnRaikou
	showtext EusineShowsRaikouText
	refreshscreen
	pokepic RAIKOU
	cry RAIKOU
	waitbutton
	closepokepic
	setval RAIKOU
	special SpecialSeenMon
.OwnRaikou
	setval ENTEI
	special SpecialMonCheck
	iftrue .OwnEntei
	showtext EusineShowsEnteiText
	refreshscreen
	pokepic ENTEI
	cry ENTEI
	waitbutton
	closepokepic
	setval ENTEI
	special SpecialSeenMon
.OwnEntei
	setval SUICUNE
	special SpecialMonCheck
	iftrue .OwnSuicune
	showtext EusineShowsSuicuneText
	refreshscreen
	pokepic SUICUNE
	cry SUICUNE
	waitbutton
	closepokepic
	setval SUICUNE
	special SpecialSeenMon
.OwnSuicune
	jumptext EusineQuestHintText

.HoOh:
	writetext EusineLeavesCeladonText
	waitbutton
	closetext
	readvar VAR_FACING
	ifnotequal UP, .PathClear
	applymovement PLAYER, .PlayerStepsAsideMovement
.PathClear:
	applymovement EUSINESHOUSE_EUSINE, .EusineLeavesMovement
	disappear EUSINESHOUSE_EUSINE
	playsound SFX_EXIT_BUILDING
	waitsfx
	end

.PlayerStepsAsideMovement:
	step_left
	turn_head_right
	step_end

.EusineLeavesMovement:
	step_down
	step_down
	step_down
	step_down
	step_end

EusinesHouseGrampsScript:
	checkevent EVENT_SET_WHEN_FOUGHT_HO_OH
	iftrue_jumptextfaceplayer EusinesHouseGrampsText2
	jumptextfaceplayer EusinesHouseGrampsText1

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

EusineNoBeastsText:
	text "Oh, by the way,"
	line "<PLAYER>."

	para "Have you caught"
	line "the legendary"
	cont "beast #mon?"

	para "………………"

	para "OK…"

	para "Let me give you"
	line "my research notes."
	done

EusineShowsRaikouText:
	text "This is Raikou:"
	done

EusineShowsEnteiText:
	text "This is Entei:"
	done

EusineShowsSuicuneText:
	text "This, of course,"
	line "is Suicune:"
	done

EusineQuestHintText:
	text "If you catch even"
	line "one, I hope that"
	cont "you'll inform me."

	para "I'm counting on"
	line "you, <PLAYER>!"
	done

EusinesHouseGrampsText1:
	text "My grandson came"
	line "home!"
	cont "I'm overjoyed!"
	done

EusinesHouseGrampsText2:
	text "My grandson Eusine"
	line "is in Johto,"

	para "searching far and"
	line "wide for Suicune."

	para "I taught him all"
	line "about the legend-"
	cont "ary #mon!"
	done
