MystriStage_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  6, 19, SINJOH_RUINS, 1
	warp_event  7, 19, SINJOH_RUINS, 1

	def_coord_events
	coord_event  6, 11, 1, MystriStageTrigger1Script
	coord_event  7, 11, 1, MystriStageTrigger2Script

	def_bg_events

	def_object_events
	object_event  6, 10, SPRITE_CYNTHIA, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MystriStageCynthiaSafeguardScript, EVENT_LISTENED_TO_CYNTHIA_INTRO
	object_event  7,  7, SPRITE_CYNTHIA, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MystriStageCynthiaScript, EVENT_MYSTRI_STAGE_CYNTHIA
	object_event  6,  8, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, EGG, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, MystriStageEggScript, EVENT_MYSTRI_STAGE_EGG

	object_const_def
	const MYSTRISTAGE_CYNTHIA1
	const MYSTRISTAGE_CYNTHIA2
	const MYSTRISTAGE_EGG

MystriStageTrigger2Script:
	applyonemovement PLAYER, step_up
MystriStageTrigger1Script:
	faceobject PLAYER, MYSTRISTAGE_CYNTHIA1
	pause 10
	showemote EMOTE_SHOCK, MYSTRISTAGE_CYNTHIA1, 15
	pause 10
	faceobject MYSTRISTAGE_CYNTHIA1, PLAYER
MystriStageCynthiaSafeguardScript:
	showtext MystriStageCynthiaIntroText
	follow MYSTRISTAGE_CYNTHIA1, PLAYER
	applymovement MYSTRISTAGE_CYNTHIA1, MystriStageMovementData_CynthiaStepsUp
	stopfollow
	turnobject MYSTRISTAGE_CYNTHIA1, LEFT
	turnobject PLAYER, RIGHT
	showtext MystriStageCynthiaSpeechText
	showemote EMOTE_SHOCK, MYSTRISTAGE_CYNTHIA1, 15
	opentext
	writetext MystriStageCynthiaLeadText2
	waitbutton
	closetext
	pause 10
	appear MYSTRISTAGE_CYNTHIA2
	disappear MYSTRISTAGE_CYNTHIA1
	setlasttalked MYSTRISTAGE_CYNTHIA2
	setevent EVENT_LISTENED_TO_CYNTHIA_INTRO
	setscene $0
	; fallthrough

MystriStageCynthiaScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_CYNTHIA
	iftrue MystriStageBeatCynthiaScript
	writetext MystriStageCynthiaIdeaText
	waitbutton
	checkevent EVENT_BEAT_ELITE_FOUR
	iffalse_jumpopenedtext MystriStageCynthiaNotNowText
	writetext MystriStageCynthiaChallengeText
	yesorno
	iffalse_jumpopenedtext MystriStageCynthiaNoText
	writetext MystriStageCynthiaYesText
	waitbutton
	closetext
	winlosstext MystriStageCynthiaWinText, 0
	setlasttalked MYSTRISTAGE_CYNTHIA2
	loadtrainer CYNTHIA, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_CYNTHIA
	opentext
MystriStageBeatCynthiaScript:
	checkevent EVENT_GOT_WISE_GLASSES_FROM_CYNTHIA
	iftrue_jumpopenedtext MystriStageCynthiaFinalText
	writetext MystriStageCynthiaItemText
	waitbutton
	verbosegiveitem WISE_GLASSES
	iffalse_endtext
	setevent EVENT_GOT_WISE_GLASSES_FROM_CYNTHIA
	writetext MystriStageCynthiaAfterText
	waitbutton
	closetext
	pause 15
	showemote EMOTE_SHOCK, MYSTRISTAGE_CYNTHIA2, 15
	special Special_FadeOutMusic
	pause 15
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	pause 15
	playsound SFX_UNKNOWN_60
	waitsfx
	pause 20
	playsound SFX_METRONOME
	waitsfx
	special Special_FadeInQuickly
	pause 10
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	playsound SFX_PROTECT
	waitsfx
	special Special_FadeInQuickly
	pause 10
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	pause 20
	playsound SFX_EGG_HATCH
	waitsfx
	appear MYSTRISTAGE_EGG
	faceplayer
	pause 30
	special RestartMapMusic
	special Special_FadeInQuickly
	pause 20
	turnobject MYSTRISTAGE_CYNTHIA2, DOWN
	pause 40
	jumptextfaceplayer MystriStageCynthiaEggText

MystriStageEggScript:
	special GiveMystriEgg
	iffalse_jumptext MystriStageNoRoomText
	disappear MYSTRISTAGE_EGG
	opentext
	writetext MystriStageEggText
	playsound SFX_KEY_ITEM
	waitsfx
	ifequal 1, .InParty
	special Special_CurBoxFullCheck
	iffalse .BoxNotFull
	farwritetext _CurBoxFullText
.BoxNotFull
	special GetCurBoxName
	farwritetext _EggSentToPCText
.InParty
	waitendtext

MystriStageCynthiaIntroText:
	text "My name is"
	line "Cynthia. I am a"
	cont "#mon trainer."

	para "And you are?"

	para "…I see. The power"
	line "of the Unown"
	cont "brought you here."
	done

MystriStageCynthiaSpeechText:
	text "Cynthia: These are"
	line "the Sinjoh Ruins."

	para "A long time ago…"
	line "people came from"

	para "Sinnoh, my home"
	line "region, to live"
	cont "here."

	para "They must have"
	line "longed for home,"

	para "and built this"
	line "temple to honor"
	cont "their traditions."

	para "We are standing on"
	line "the Mystri Stage."

	para "People once cele-"
	line "brated here with"
	cont "music and dance."

	para "Cynthia: I study"
	line "myths about"

	para "ancient sites like"
	line "the Sinjoh Ruins."

	para "One claims that"
	line "this stage is"

	para "imbued with the"
	line "power of creation."

	para "It speaks of when"
	line "“the lead enters"

	para "the Mystri Stage"
	line "at last…”"
	done

MystriStageCynthiaLeadText2:
	text "Cynthia: What?"
	line "You read that"

	para "phrase in the"
	line "Ruins of Alph?"

	para "That is very"
	line "intriguing."

	para "Could “the lead”"
	line "be a #mon?"
	cont "Or a person?"
	done

MystriStageCynthiaIdeaText:
	text "Cynthia: …I have"
	line "an idea. Call it"

	para "a trainer's"
	line "intuition."

	para "When you and I"
	line "battle on this"

	para "stage, something"
	line "will happen."
	done

MystriStageCynthiaNotNowText:
	text "Cynthia: But I"
	line "don't think we"

	para "should battle now."
	line "You aren't ready."

	para "Come back when"
	line "you've beaten the"
	cont "Elite Four."
	done

MystriStageCynthiaChallengeText:
	text "Cynthia: Are you"
	line "prepared to be my"
	cont "opponent?"
	done

MystriStageCynthiaNoText:
	text "Cynthia: Come back"
	line "when you're ready."
	done

MystriStageCynthiaYesText:
	text "Cynthia: Before"
	line "I send out my"
	cont "#mon,"

	para "my heart always"
	line "begins to race…"
	done

MystriStageCynthiaWinText:
	text "I can't remember"
	line "the last time I"

	para "was outclassed"
	line "like this!"
	done

MystriStageCynthiaItemText:
	text "Cynthia: That was"
	line "beyond my expec-"
	cont "tation!"

	para "What an excep-"
	line "tional battle!"

	para "Please take this"
	line "item. I believe"

	para "you will know how"
	line "to use it well."
	done

MystriStageCynthiaAfterText:
	text "Cynthia: But did"
	line "our battle affect"
	cont "the Mystri Stage?"
	done

MystriStageCynthiaEggText:
	text "Cynthia: Could it"
	line "be… an Egg?"

	para "Did we just"
	line "witness the very"

	para "moment an Egg was"
	line "brought to this"
	cont "world?"

	para "A moment no one"
	line "has ever seen?"
	done

MystriStageCynthiaFinalText:
	text "Cynthia: An Egg"
	line "is the cradle of"
	cont "every being."

	para "The planet itself"
	line "is an Egg in a"
	cont "sense…"

	para "Life that comes"
	line "from an Egg will"
	cont "come to an end in"

	para "due course… to"
	line "begin anew…"
	done

MystriStageEggText:
	text "<PLAYER> received"
	line "a mysterious Egg!"
	done

MystriStageNoRoomText:
	text "You don't have"
	line "room for this,"
	cont "even in your box!"
	done

MystriStageMovementData_CynthiaStepsUp:
	step_up
	step_up
	step_up
	step_right
	step_end
