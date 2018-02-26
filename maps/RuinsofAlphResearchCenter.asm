RuinsofAlphResearchCenter_MapScriptHeader:
	db 2 ; scene scripts
	scene_script RuinsofAlphResearchCenterTrigger0
	scene_script RuinsofAlphResearchCenterTrigger1

	db 1 ; callbacks
	callback MAPCALLBACK_OBJECTS, UnknownScript_0x59185

	db 2 ; warp events
	warp_event  2,  7, RUINS_OF_ALPH_OUTSIDE, 6
	warp_event  3,  7, RUINS_OF_ALPH_OUTSIDE, 6

	db 0 ; coord events

	db 4 ; bg events
	bg_event  6,  5, SIGNPOST_JUMPTEXT, UnknownText_0x59886
	bg_event  3,  4, SIGNPOST_READ, MapRuinsofAlphResearchCenterSignpost1Script
	bg_event  7,  1, SIGNPOST_JUMPTEXT, UnknownText_0x5980e
	bg_event  5,  0, SIGNPOST_JUMPTEXT, UnknownText_0x59848

	db 3 ; object events
	object_event  4,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, ScientistScript_0x591e5, -1
	object_event  5,  2, SPRITE_SCIENTIST, SPRITEMOVEDATA_WANDER, 1, 2, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, ScientistScript_0x59214, -1
	object_event  2,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, ScientistScript_0x591d1, EVENT_RUINS_OF_ALPH_RESEARCH_CENTER_SCIENTIST

	const_def 1 ; object constants
	const RUINSOFALPHRESEARCHCENTER_SCIENTIST1
	const RUINSOFALPHRESEARCHCENTER_SCIENTIST2
	const RUINSOFALPHRESEARCHCENTER_SCIENTIST3

RuinsofAlphResearchCenterTrigger1:
	priorityjump UnknownScript_0x59192
RuinsofAlphResearchCenterTrigger0:
	end

UnknownScript_0x59185:
	checkscene
	ifequal $1, UnknownScript_0x5918b
	return

UnknownScript_0x5918b:
	moveobject RUINSOFALPHRESEARCHCENTER_SCIENTIST3, 3, 7
	appear RUINSOFALPHRESEARCHCENTER_SCIENTIST3
	return

UnknownScript_0x59192:
	applymovement RUINSOFALPHRESEARCHCENTER_SCIENTIST3, MovementData_0x5926f
	playsound SFX_BOOT_PC
	pause 60
	playsound SFX_SWITCH_POKEMON
	pause 30
	playsound SFX_TALLY
	pause 30
	playsound SFX_TRANSACTION
	pause 30
	turnobject RUINSOFALPHRESEARCHCENTER_SCIENTIST3, DOWN
	showtext UnknownText_0x59278
	applyonemovement RUINSOFALPHRESEARCHCENTER_SCIENTIST3, step_down
	opentext
	writetext UnknownText_0x592fa
	playsound SFX_ITEM
	waitsfx
	setflag ENGINE_UNOWN_DEX
	writetext UnknownText_0x59311
	waitbutton
	closetext
	applyonemovement RUINSOFALPHRESEARCHCENTER_SCIENTIST3, step_up
	setscene $0
	special RestartMapMusic
	end

ScientistScript_0x591d1:
	faceplayer
	opentext
	checkevent EVENT_RUINS_OF_ALPH_CLIMAX_DONE
	iftrue .Conclusion
	checkcode VAR_UNOWNCOUNT
	ifequal NUM_UNOWN, UnknownScript_0x591df
	jumpopenedtext UnknownText_0x59311

.Conclusion:
	jumpopenedtext RuinsofAlphResearchCenterScientistConclusionText

UnknownScript_0x591df:
	writetext UnknownText_0x5935f
	buttonsound
	setevent EVENT_DECO_UNOWN_DOLL
	writetext GotUnownDollText
	playsound SFX_ITEM
	pause 60
	waitbutton
	writetext UnownDollSentText
	buttonsound
	writetext RuinsofAlphResearchCenterScientistRewardText
	buttonsound
	writetext RuinsofAlphResearchCenterScientistInterruptedText
	pause 30
	closetext
	pause 15
	playsound SFX_EMBER
	earthquake 60
	waitsfx
	setevent EVENT_DOOR_OPENED_IN_RUINS_OF_ALPH
	showemote EMOTE_SHOCK, PLAYER, 15
	showemote EMOTE_SHOCK, RUINSOFALPHRESEARCHCENTER_SCIENTIST3, 15
	showemote EMOTE_SHOCK, RUINSOFALPHRESEARCHCENTER_SCIENTIST1, 15
	showemote EMOTE_SHOCK, RUINSOFALPHRESEARCHCENTER_SCIENTIST2, 15
	showtext RuinsofAlphResearchCenterScientistShockedText
	checkcode VAR_FACING
	ifequal UP, .GoAround
	follow RUINSOFALPHRESEARCHCENTER_SCIENTIST3, PLAYER
	applymovement RUINSOFALPHRESEARCHCENTER_SCIENTIST3, RuinsofAlphResearchCenterLeave2MovementData
	stopfollow
	jump .Continue
.GoAround:
	applymovement RUINSOFALPHRESEARCHCENTER_SCIENTIST3, RuinsofAlphResearchCenterScientistStepAsideMovementData
	follow RUINSOFALPHRESEARCHCENTER_SCIENTIST3, PLAYER
	applyonemovement RUINSOFALPHRESEARCHCENTER_SCIENTIST3, step_down
	stopfollow
.Continue:
	playsound SFX_EXIT_BUILDING
	disappear RUINSOFALPHRESEARCHCENTER_SCIENTIST3
	applyonemovement PLAYER, step_down
	playsound SFX_EXIT_BUILDING
	disappear PLAYER
	special FadeOutPalettes
	setevent EVENT_RUINS_OF_ALPH_OUTSIDE_TOURIST_YOUNGSTERS
	clearevent EVENT_RUINS_OF_ALPH_RESEARCH_CENTER_SCIENTIST
	clearevent EVENT_RUINS_OF_ALPH_OUTSIDE_SCIENTIST_CLIMAX
	setevent EVENT_DO_RUINS_OF_ALPH_CLIMAX
	pause 15
	warpfacing DOWN, RUINS_OF_ALPH_OUTSIDE, 19, 18
	end

RuinsofAlphResearchCenterScientistStepAsideMovementData:
	step_right
	step_down
	step_end

RuinsofAlphResearchCenterLeave2MovementData:
	step_down
	step_down
	step_end

ScientistScript_0x591e5:
	faceplayer
	opentext
	checkcode VAR_UNOWNCOUNT
	ifequal NUM_UNOWN, UnknownScript_0x5920b
	checkflag ENGINE_UNOWN_DEX
	iftrue UnknownScript_0x59205
	checkevent EVENT_MADE_UNOWN_APPEAR_IN_RUINS
	iftrue UnknownScript_0x591ff
	jumpopenedtext UnknownText_0x593ed

UnknownScript_0x591ff:
	jumpopenedtext UnknownText_0x59478

UnknownScript_0x59205:
	jumpopenedtext UnknownText_0x59445

UnknownScript_0x5920b:
	writetext UnknownText_0x594cb
	waitbutton
	closetext
	clearevent EVENT_RUINS_OF_ALPH_OUTSIDE_TOURIST_YOUNGSTERS
	end

ScientistScript_0x59214:
	faceplayer
	opentext
	checkcode VAR_UNOWNCOUNT
	ifgreater 3, UnknownScript_0x5922e
	checkevent EVENT_MADE_UNOWN_APPEAR_IN_RUINS
	iftrue UnknownScript_0x59228
	jumpopenedtext UnknownText_0x5954f

UnknownScript_0x59228:
	jumpopenedtext UnknownText_0x595cb

UnknownScript_0x5922e:
	checkcode VAR_UNOWNCOUNT
	ifequal NUM_UNOWN, ResearchCompleteScript_0x596d3
	checkcode VAR_UNOWNCOUNT
	ifgreater 10, ResearchOngoingScript_0x59669
	jumpopenedtext UnknownText_0x59769

ResearchCompleteScript_0x596d3:
	writetext UnknownText_0x596d3
	waitbutton
	closetext
	clearevent EVENT_RUINS_OF_ALPH_OUTSIDE_TOURIST_YOUNGSTERS
	end

ResearchOngoingScript_0x59669:
	jumpopenedtext UnknownText_0x59669

MapRuinsofAlphResearchCenterSignpost1Script:
	opentext
	checkevent EVENT_RUINS_OF_ALPH_RESEARCH_CENTER_SCIENTIST
	iffalse UnknownScript_0x59241
	checkevent EVENT_DECO_UNOWN_DOLL
	iftrue UnknownScript_0x59241
	jumpopenedtext UnknownText_0x597b6

UnknownScript_0x59241:
	checkcode VAR_UNOWNCOUNT
	jumpopenedtext UnknownText_0x597d9

MovementData_0x5926f:
	step_up
	step_up
	step_left
	turn_head_up
	step_end

UnknownText_0x59278:
	text "Done!"

	para "I modified your"
	line "#dex."

	para "I added an"
	line "optional #dex"

	para "to store Unown"
	line "data."

	para "It records them in"
	line "the sequence that"
	cont "they were caught."
	done

UnknownText_0x592fa:
	text "<PLAYER>'s #dex"
	line "was upgraded."
	done

UnknownText_0x59311:
	text "The Unown you"
	line "catch will all be"
	cont "recorded."

	para "Check to see how"
	line "many kinds exist."

	para "You're doing a"
	line "favor for us, so"

	para "I'll give you some-"
	line "thing nice if you"
	cont "find all of them."
	done

UnknownText_0x5935f:
	text "You caught all the"
	line "Unown variations?"

	para "That's a great"
	line "achievement!"

	para "You've been very"
	line "helpful to our"
	cont "research."

	para "Let me give you"
	line "this."
	done

GotUnownDollText:
	text "<PLAYER> received"
	line "Unown Doll."
	done

UnownDollSentText:
	text "Unown Doll"
	line "was sent home."
	done

RuinsofAlphResearchCenterScientistRewardText:
	text "I designed that"
	line "doll myself!"
	done

RuinsofAlphResearchCenterScientistInterruptedText:
	text "You can--"
	done

RuinsofAlphResearchCenterScientistShockedText:
	text "What was THAT?!"
	done

RuinsofAlphResearchCenterScientistConclusionText:
	text "We're going to"
	line "gradually study"

	para "the chamber that"
	line "opened up."

	para "We have to take"
	line "care not to"
	cont "disturb the site."
	done

UnknownText_0x593ed:
	text "The ruins are"
	line "about 1,500 years"
	cont "old."

	para "But it's not known"
	line "why they were"
	cont "built--or by whom."
	done

UnknownText_0x59445:
	text "I wonder how many"
	line "kinds of #mon"
	cont "are in the ruins?"
	done

UnknownText_0x59478:
	text "#mon appeared"
	line "in the ruins?"

	para "That's incredible"
	line "news!"

	para "We'll need to"
	line "investigate this."
	done

UnknownText_0x594cb:
	text "Our investigation,"
	line "with your help, is"

	para "giving us insight"
	line "into the ruins."

	para "The ruins appear"
	line "to have been built"

	para "as a habitat for"
	line "#mon."
	done

UnknownText_0x5954f:
	text "There are odd pat-"
	line "terns drawn on the"

	para "walls of the"
	line "ruins."

	para "They must be the"
	line "keys for unravel-"
	cont "ing the mystery"
	cont "of the ruins."
	done

UnknownText_0x595cb:
	text "The strange #-"
	line "mon you saw in the"
	cont "ruins?"

	para "They appear to be"
	line "very much like the"

	para "drawings on the"
	line "walls there."

	para "Hmm…"

	para "That must mean"
	line "there are many"
	cont "kinds of them…"
	done

UnknownText_0x59669:
	text "We think something"
	line "caused the cryptic"

	para "patterns to appear"
	line "in the ruins."

	para "We've focused our"
	line "studies on that."
	done

UnknownText_0x596d3:
	text "According to my"
	line "research…"

	para "Those mysterious"
	line "patterns appeared"

	para "when the #Com"
	line "Center was built."

	para "It must mean that"
	line "radio waves have"

	para "some sort of a"
	line "link…"
	done

UnknownText_0x59769:
	text "Why did those"
	line "ancient patterns"

	para "appear on the wall"
	line "now?"

	para "The mystery"
	line "deepens…"
	done

UnknownText_0x597b6:
	text "Ruins of Alph"

	para "Exploration"
	line "Year 10"
	done

UnknownText_0x597d9:
	text "Mystery #mon"
	line "Name: Unown"

	para "A total of @"
	deciram ScriptVar, 1, 2
	text ""
	line "kinds found."
	done

UnknownText_0x5980e:
	text "It's a printer."
	line "The display says"
	cont "“PC LOAD LETTER”."

	para "…What does that"
	line "mean?"
	done

UnknownText_0x59848:
	text "It's a photo of"
	line "the Research"

	para "Center's founder,"
	line "Prof.Silktree."
	done

UnknownText_0x59886:
	text "There are many"
	line "academic books."

	para "Ancient Ruins…"
	line "Mysteries of the"
	cont "Ancients…"
	done
