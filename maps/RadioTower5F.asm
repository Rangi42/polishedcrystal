RadioTower5F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  0,  0, RADIO_TOWER_4F, 1
	warp_event 12,  0, RADIO_TOWER_4F, 3

	def_coord_events
	coord_event  0,  3, 0, FakeDirectorScript
	coord_event 16,  5, 1, RadioTower5FRocketBossTrigger

	def_bg_events
	bg_event  3,  0, BGEVENT_JUMPTEXT, SignpostRadioTower5FOffice
	bg_event 11,  0, BGEVENT_JUMPTEXT, SignpostRadioTower5FStudio
	bg_event 15,  0, BGEVENT_JUMPTEXT, SignpostRadioTower5FStudio

	def_object_events
	object_event  3,  6, SPRITE_GENTLEMAN, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, RadioTower5FDirectorText, EVENT_RADIO_TOWER_DIRECTOR
	object_event  0,  4, SPRITE_PETREL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Petrel1Script, EVENT_RADIO_TOWER_PETREL
	object_event 13,  5, SPRITE_ARCHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 17,  2, SPRITE_ARIANA, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerAriana1, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 13,  5, SPRITE_ROCKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, BenText, EVENT_RADIO_TOWER_CIVILIANS_AFTER
	itemball_event  8,  5, ULTRA_BALL, 1, EVENT_RADIO_TOWER_5F_ULTRA_BALL

	object_const_def
	const RADIOTOWER5F_DIRECTOR
	const RADIOTOWER5F_PETREL
	const RADIOTOWER5F_ARCHER
	const RADIOTOWER5F_ARIANA

FakeDirectorScript:
	turnobject RADIOTOWER5F_DIRECTOR, UP
	showemote EMOTE_SHOCK, RADIOTOWER5F_DIRECTOR, 15
	showtext FakeDirectorTextBefore1
	applymovement RADIOTOWER5F_DIRECTOR, FakeDirectorMovement
	special SaveMusic
	playmusic MUSIC_ROCKET_ENCOUNTER
	showtext FakeDirectorTextBefore2
	applymovement RADIOTOWER5F_DIRECTOR, FakeDirectorSpinMovement
	appear RADIOTOWER5F_PETREL
	disappear RADIOTOWER5F_DIRECTOR
	turnobject RADIOTOWER5F_PETREL, UP
	pause 10
Petrel1Script:
	checkevent EVENT_BEAT_PETREL_1
	iftrue_jumptextfaceplayer FakeDirectorTextAfter
	setscene $1
	faceplayer
	showtext FakeDirectorTextBefore3
	winlosstext FakeDirectorWinText, 0
	setlasttalked RADIOTOWER5F_PETREL
	loadtrainer PETREL, PETREL1
	startbattle
	reloadmapafterbattle
	opentext
	writetext FakeDirectorTextAfter
	buttonsound
	verbosegivekeyitem BASEMENT_KEY
	closetext
	setevent EVENT_BEAT_PETREL_1
	end

GenericTrainerAriana1:
	generictrainer ARIANA, ARIANA1, EVENT_BEAT_ARIANA_1, Ariana1SeenText, Ariana1BeatenText

	text "<PLAYER>, isn't it?"

	para "A brat like you"
	line "won't appreciate"

	para "the magnificence"
	line "of Team Rocket."

	para "That's too bad."
	line "I really admire"
	cont "your power."
	done

RadioTower5FRocketBossTrigger:
	applymovement PLAYER, RadioTower5FPlayerTwoStepsLeftMovement
	playmusic MUSIC_ROCKET_ENCOUNTER
	turnobject RADIOTOWER5F_ARCHER, RIGHT
	showtext RadioTower5FRocketBossBeforeText
	winlosstext RadioTower5FRocketBossWinText, 0
	setlasttalked RADIOTOWER5F_ARCHER
	loadtrainer ARCHER, ARCHER1
	startbattle
	reloadmapafterbattle
	showtext RadioTower5FRocketBossAfterText
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear RADIOTOWER5F_ARCHER
	disappear RADIOTOWER5F_ARIANA
	pause 15
	special Special_FadeInQuickly
	setevent EVENT_BEAT_ARCHER_1
	setevent EVENT_CLEARED_RADIO_TOWER
	clearflag ENGINE_ROCKETS_IN_RADIO_TOWER
	setevent EVENT_GOLDENROD_CITY_ROCKET_SCOUT
	setevent EVENT_GOLDENROD_CITY_ROCKET_TAKEOVER
	setevent EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	clearevent EVENT_MAHOGANY_MART_OWNERS
	clearflag ENGINE_ROCKETS_IN_MAHOGANY
	clearevent EVENT_GOLDENROD_CITY_CIVILIANS
	clearevent EVENT_RADIO_TOWER_CIVILIANS_AFTER
	setevent EVENT_BLACKTHORN_CITY_DRAGON_TAMER_BLOCKS_GYM
	clearevent EVENT_BLACKTHORN_CITY_DRAGON_TAMER_DOES_NOT_BLOCK_GYM
	special PlayMapMusic
	disappear RADIOTOWER5F_PETREL
	disappear RADIOTOWER5F_DIRECTOR
	moveobject RADIOTOWER5F_DIRECTOR, 12, 0
	appear RADIOTOWER5F_DIRECTOR
	applymovement RADIOTOWER5F_DIRECTOR, RadioTower5FDirectorWalksIn
	turnobject PLAYER, RIGHT
	opentext
	writetext RadioTower5FDirectorThankYouText
	buttonsound
	verbosegivekeyitem CLEAR_BELL
	writetext RadioTower5FDirectorDescribeClearBellText
	waitbutton
	closetext
	setscene $2
	setmapscene ECRUTEAK_HOUSE, $0
	setevent EVENT_GOT_CLEAR_BELL
	setevent EVENT_TEAM_ROCKET_DISBANDED
	applymovement RADIOTOWER5F_DIRECTOR, RadioTower5FDirectorWalksOut
	playsound SFX_EXIT_BUILDING
	disappear RADIOTOWER5F_DIRECTOR
	moveobject RADIOTOWER5F_DIRECTOR, 3, 6
	appear RADIOTOWER5F_DIRECTOR
	end

FakeDirectorMovement:
	step_left
	step_left
	step_left
	step_up
	step_up
	step_end

FakeDirectorSpinMovement:
	turn_head_left
	turn_head_down
	turn_head_right
	turn_head_up
	turn_head_left
	turn_head_down
	turn_head_right
	turn_head_up
	turn_head_left
	turn_head_down
	turn_head_right
	turn_head_up
	step_sleep 8
	step_end

RadioTower5FDirectorWalksIn:
	step_down
	step_down
	step_right
	step_right
	step_right
	step_right
	step_down
	step_down
	step_down
	step_left
	step_end

RadioTower5FDirectorWalksOut:
	step_right
	step_up
	step_up
	step_up
	step_left
	step_left
	step_left
	step_left
	step_up
	step_up
	step_end

RadioTower5FPlayerTwoStepsLeftMovement:
	step_left
	step_left
	step_end

FakeDirectorTextBefore1:
	text "Y-you! You came to"
	line "rescue me?"
	done

FakeDirectorTextBefore2:
	text "Is that what you"
	line "were expecting?"

	para "Wrong!"
	line "I'm an imposter!"
	done

FakeDirectorTextBefore3:
	text "I pretended to be"
	line "the real thing to"

	para "prepare for our"
	line "takeover."

	para "Do you want to"
	line "know where we hid"
	cont "the real Director?"

	para "Sure, I'll tell"
	line "you. But only if"
	cont "you can beat me!"
	done

FakeDirectorWinText:
	text "OK, OK. I'll tell"
	line "you where he is."
	done

FakeDirectorTextAfter:
	text "We stashed the"
	line "real Director in"

	para "the Underground"
	line "Warehouse."

	para "It's at the far"
	line "end of the Under-"
	cont "ground."

	para "But I doubt you'll"
	line "get that far."
	done

Ariana1SeenText:
	text "Remember me from"
	line "the hideout in"
	cont "Mahogany Town?"

	para "I lost then, but I"
	line "won't this time."
	done

Ariana1BeatenText:
	text "This can't be"
	line "happening!"

	para "I fought hard, but"
	line "I still lost…"
	done

RadioTower5FRocketBossBeforeText:
	text "Oh? You managed to"
	line "get this far?"

	para "You must be quite"
	line "the trainer."

	para "We intend to take"
	line "over this Radio"

	para "Station and an-"
	line "nounce our come-"
	cont "back."

	para "That should bring"
	line "our boss Giovanni"

	para "back from his solo"
	line "training."

	para "We are going to"
	line "regain our former"
	cont "glory."

	para "I won't allow you"
	line "to interfere with"
	cont "our plans."
	done

RadioTower5FRocketBossWinText:
	text "No! Forgive me,"
	line "Giovanni!"
	done

RadioTower5FRocketBossAfterText:
	text "How could this be?"

	para "Our dreams have"
	line "come to naught."

	para "I wasn't up to the"
	line "task after all."

	para "Like Giovanni did"
	line "before me, I will"

	para "disband Team"
	line "Rocket here today."

	para "Farewell."
	done

RadioTower5FDirectorThankYouText:
	text "Director: <PLAYER>,"
	line "thank you!"

	para "Your courageous"
	line "actions have saved"

	para "#mon nation-"
	line "wide."

	para "I know it's not"
	line "much, but please"
	cont "take this."
	done

RadioTower5FDirectorDescribeClearBellText:
	text "There used to be a"
	line "tower right here"
	cont "in Goldenrod City."

	para "But it was old and"
	line "creaky."

	para "So we replaced it"
	line "with our Radio"
	cont "Tower."

	para "We dug up that"
	line "bell during"
	cont "construction."

	para "I heard that all"
	line "sorts of #mon"

	para "lived in Goldenrod"
	line "in the past."

	para "Perhaps…"

	para "That bell has some"
	line "connection to the"

	para "Bell Tower in"
	line "Ecruteak City…"

	para "Ah!"

	para "That reminds me…"

	para "I overheard Team"
	line "Rocket whispering."

	para "Apparently, some-"
	line "thing is going on"
	cont "at the Bell Tower."

	para "I have no idea"
	line "what is happening,"

	para "but you might look"
	line "into it."

	para "OK, I better go to"
	line "my office."
	done

RadioTower5FDirectorText:
	text "Director: Hello,"
	line "<PLAYER>!"

	para "You know, I love"
	line "#mon."

	para "I built this Radio"
	line "Tower so I could"

	para "express my love"
	line "of #mon."

	para "It would be nice"
	line "if people enjoyed"
	cont "our programs."
	done

BenText:
	text "Ben: Do you listen"
	line "to our music?"
	done

SignpostRadioTower5FOffice:
	text "5F Director's"
	line "   Office"
	done

SignpostRadioTower5FStudio:
	text "5F Studio 1"
	done
