EusinesHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, CELADON_CITY, 14
	warp_event  3,  7, CELADON_CITY, 14

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_EUSINE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonEusine, EVENT_EUSINES_HOUSE_EUSINE
	object_event  5,  3, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, EusinesHouseGrampsScript, -1

	object_const_def
	const EUSINESHOUSE_EUSINE

CeladonEusine:
	faceplayer
	opentext
	checkevent EVENT_EUSINE_SAW_HO_OH
	iftruefwd .PostHoOh
	writetext CeladonEusineText1
	promptbutton
	special SpecialBeastsCheck
	iftruefwd .HoOh
	writetext EusineNoBeastsText
	waitbutton
	closetext
	checkflag ENGINE_PLAYER_CAUGHT_RAIKOU
	iftruefwd .OwnRaikou
	showtext EusineShowsRaikouText
	reanchormap
	pokepic RAIKOU
	cry RAIKOU
	waitbutton
	closepokepic
	setmonval RAIKOU
	special SpecialSeenMon
.OwnRaikou
	checkflag ENGINE_PLAYER_CAUGHT_ENTEI
	iftruefwd .OwnEntei
	showtext EusineShowsEnteiText
	reanchormap
	pokepic ENTEI
	cry ENTEI
	waitbutton
	closepokepic
	setmonval ENTEI
	special SpecialSeenMon
.OwnEntei
	checkflag ENGINE_PLAYER_CAUGHT_SUICUNE
	iftruefwd .OwnSuicune
	showtext EusineShowsSuicuneText
	reanchormap
	pokepic SUICUNE
	cry SUICUNE
	waitbutton
	closepokepic
	setmonval SUICUNE
	special SpecialSeenMon
.OwnSuicune
	jumptext EusineQuestHintText

.PostHoOh:
	checkevent EVENT_BEAT_EUSINE_2
	iftruefwd .AlreadyRematched
	setmonval SUICUNE
	special Special_FindThatSpecies
	iftruefwd .RematchSuicune
.AlreadyRematched:
	jumpopenedtext EusinePostHoOhText

.RematchSuicune:
	writetext EusineRematchIntroText
	yesorno
	iffalsefwd .DeclineRematch
	closetext
	winlosstext EusineRematchWinText, EusineRematchLossText
	setlasttalked EUSINESHOUSE_EUSINE
	loadtrainer MYSTICALMAN, EUSINE_2
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_EUSINE_2
	opentext
	jumpopenedtext EusineRematchAfterText

.DeclineRematch:
	jumpopenedtext EusineRematchDeclineText

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
	checkevent EVENT_EUSINE_SAW_HO_OH
	iftruefwd .PostHoOhGramps
	checkevent EVENT_EUSINES_HOUSE_EUSINE
	iffalse_jumptextfaceplayer EusinesHouseGrampsGrandsonHomeText
	checkevent EVENT_FOUGHT_SUICUNE
	iffalse_jumptextfaceplayer EusinesHouseGrampsEusineSearchingForSuicuneText
	jumptextfaceplayer EusinesHouseGrampsEusineSearchingForHoOhText

.PostHoOhGramps:
	checkevent EVENT_DECO_ABRA_DOLL
	iftrue_jumptextfaceplayer EusinesHouseGrampsEusineHomeForGoodText
	; EVENT_EUSINE_SAW_HO_OH is set, so the quest is complete.
	; Always offer the Abra Doll regardless of Ho-Oh respawn state.

.AfterHoOhFight:
	faceplayer
	opentext
	writetext EusinesHouseGrampsThankYouGiftText
	waitbutton
	writetext ReceivedAbraDollText
	playsound SFX_ITEM
	pause 60
	waitbutton
	writetext AbraDollSentHomeText
	setevent EVENT_DECO_ABRA_DOLL
	waitbutton
	closetext
	end

ReceivedAbraDollText:
	text "<PLAYER> received"
	line "Abra Doll."
	done

AbraDollSentHomeText:
	text "Abra Doll"
	line "was sent home."
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

EusinePostHoOhText:
	text "Eusine: <PLAYER>!"

	para "I'm still amazed"
	line "by what happened"
	cont "at Bell Tower."

	para "Meeting Ho-Oh has"
	line "given me so much"

	para "more to study and"
	line "think about."

	para "I'm going to keep"
	line "researching and"

	para "become the best"
	line "#Maniac ever!"
	done

EusineRematchIntroText:
	text "Eusine: Oh! Is"
	line "that Suicune?"

	para "You actually"
	line "brought it along!"

	para "Seeing it makes"
	line "my heart race!"

	para "I know it's a lot"
	line "to ask, but how"
	cont "about a battle?"
	done

EusineRematchWinText:
	text "Marvelous!"

	para "You and Suicune"
	line "truly are a great"
	cont "team!"
	done

EusineRematchLossText:
	text "What a battle!"

	para "You and Suicune"
	line "will only get"
	cont "stronger!"
	done

EusineRematchAfterText:
	text "Eusine: <PLAYER>,"
	line "battling alongside"

	para "legendary #mon"
	line "is inspiring."

	para "Thank you for"
	line "showing me that!"
	done

EusineRematchDeclineText:
	text "No worries!"

	para "Come show me"
	line "Suicune whenever"
	cont "you feel like it!"
	done

EusinesHouseGrampsGrandsonHomeText:
	text "My grandson came"
	line "home!"
	cont "I'm overjoyed!"
	done

EusinesHouseGrampsEusineSearchingForSuicuneText:
	text "My grandson Eusine"
	line "is in Johto,"

	para "searching far and"
	line "wide for Suicune."

	para "I taught him all"
	line "about the legend-"
	cont "ary #mon!"
	done

EusinesHouseGrampsEusineSearchingForHoOhText:
	text "My grandson Eusine"
	line "is on another"
	cont "adventure."

	para "He left to visit"
	line "Bell Tower in"
	cont "Ecruteak City."
	done

EusinesHouseGrampsThankYouGiftText:
	text "My grandson Eusine"
	line "called."

	para "He's doing well."
	line "I'm happy for him!"

	para "Thank you for"
	line "checking on me,"
	cont "<PLAYER>!"

	para "Please take this"
	line "to show my"
	cont "appreciation."
	done

EusinesHouseGrampsEusineHomeForGoodText:
	text "Eusine is home for"
	line "good now!"

	para "He's so happy, and"
	line "so am I!"

	para "Thank you for"
	line "everything,"
	cont "<PLAYER>!"
	done
