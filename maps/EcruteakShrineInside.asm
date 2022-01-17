EcruteakShrineInside_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5, 11, ECRUTEAK_SHRINE_OUTSIDE, 1
	warp_event  6, 11, ECRUTEAK_SHRINE_OUTSIDE, 1

	def_coord_events

	def_bg_events
	bg_event  5,  6, BGEVENT_JUMPTEXT, EcruteakShrineInsideAltarText
	bg_event  6,  6, BGEVENT_JUMPTEXT, EcruteakShrineInsideAltarText

	def_object_events
	object_event  7,  6, SPRITE_SABRINA, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakShrineInsideReiScript, -1
	object_event  3,  8, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, EcruteakShrineInsideGrampsText, -1
	object_event 10,  5, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, EcruteakShrineInsideSageText, -1
	object_event  1,  6, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, EcruteakShrineInsideGrannyText, -1
	pokemon_event 10,  3, FURRET, SPRITEMOVEDATA_POKEMON, -1, -1, PAL_NPC_BROWN, ObjectEvent, -1

	object_const_def
	const ECRUTEAKSHRINEINSIDE_REI

EcruteakShrineInsideReiScript:
	faceplayer
	opentext
	checkflag ENGINE_DAILY_SHRINE_VISIT
	iftrue .ReiDone
	writetext EcruteakShrineInsideReiGreetingText
	loadmenu .ReiMenuDataHeader
	verticalmenu
	closewindow
	ifequal $1, .ReiBless
	ifequal $2, .ReiBattle
	sjump .ReiCancel

.ReiBless
	writetext EcruteakShrineInsideReiBlessText
	promptbutton
	special Special_ReiBlessing
	ifequal $0, .ReiCancel
	ifequal $1, .EggBlessing
	setflag ENGINE_DAILY_SHRINE_VISIT
	writetext EcruteakShrineInsideReiBlessingText
	special PlayCurMonCry
	waitbutton
	writetext EcruteakShrineInsideHappinessText
	waitbutton
	sjump .ReiDone

.ReiBattle
	writetext EcruteakShrineInsideReiBattleText
	waitbutton
	closetext
	setflag ENGINE_DAILY_SHRINE_VISIT
	winlosstext EcruteakShrineInsideReiBeatenText, 0
	setlasttalked ECRUTEAKSHRINEINSIDE_REI
	readvar VAR_BADGES
	ifequal 16, .Battle3
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .Battle2
	loadtrainer REI, 1
	startbattle
	reloadmapafterbattle
	sjump .AfterRematch

.Battle2:
	loadtrainer REI, 2
	startbattle
	reloadmapafterbattle
	sjump .AfterRematch

.Battle3:
	loadtrainer REI, 3
	startbattle
	reloadmapafterbattle
	; fallthrough

.AfterRematch:
	opentext
	; fallthrough

.ReiDone
	jumpopenedtext EcruteakShrineInsideReiComeAgainText

.ReiCancel
	jumpopenedtext EcruteakShrineInsideReiCancelText

.EggBlessing
	jumpopenedtext EcruteakShrineInsideReiBlessEggText

.ReiMenuDataHeader:
	db $40 ; flags
	db 04, 00 ; start coords
	db 11, 11 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 3 ; items
	db "Blessing@"
	db "Battle@"
	db "Cancel@"

EcruteakShrineInsideReiGreetingText:
	ctxt "Rei: Oh, hello."
	line "Welcome to our"
	cont "shrine."

	para "Did you come to"
	line "have me bless one"
	cont "of your #mon?"

	para "Or would you like"
	line "to battle?"
	done

EcruteakShrineInsideReiBlessText:
	ctxt "Rei: OK, which"
	line "#mon should I"
	cont "bless?"
	done

EcruteakShrineInsideReiBlessingText:
	ctxt "Rei: May you be"
	line "at ease, and find"
	cont "peace."
	done

EcruteakShrineInsideHappinessText:
	text_ram wStringBuffer3
	ctxt " looks"
	line "content."
	done

EcruteakShrineInsideReiBlessEggText:
	ctxt "Rei: I can't"
	line "bless an Egg."
	done

EcruteakShrineInsideReiBattleText:
	ctxt "Rei: Very well."
	line "Evil spirits,"
	cont "begone!"
	done

EcruteakShrineInsideReiBeatenText:
	ctxt "I admit defeat!"
	done

EcruteakShrineInsideReiComeAgainText:
	ctxt "Rei: Please come"
	line "again tomorrow."
	done

EcruteakShrineInsideReiCancelText:
	ctxt "Rei: Please come"
	line "back if you change"
	cont "your mind."
	done

EcruteakShrineInsideGrampsText:
	ctxt "The shrine maiden"
	line "here is my grand-"
	cont "daughter."
	done

EcruteakShrineInsideSageText:
	ctxt "Most of us here at"
	line "the shrine train"

	para "Hoothoot and"
	line "Sentret to battle"
	cont "ghosts."

	para "Rei is unique."
	line "She uses Fire and"
	cont "Psychic types."
	done

EcruteakShrineInsideGrannyText:
	ctxt "I'm glad they didn't"
	line "approve a stop in"
	cont "Ecruteak for the"
	cont "Magnet Train."

	para "It would ruin our"
	line "traditional land-"
	cont "scape."
	done

EcruteakShrineInsideAltarText:
	ctxt "Please show honor"
	line "and respect while"
	cont "visiting."
	done
