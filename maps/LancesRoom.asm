LancesRoom_MapScriptHeader:
	def_scene_scripts
	scene_script LancesRoomEntranceTrigger

	def_callbacks
	callback MAPCALLBACK_TILES, LancesRoomDoorCallback

	def_warp_events
	warp_event  6, 23, KARENS_ROOM, 3
	warp_event  7, 23, KARENS_ROOM, 4
	warp_event  6,  1, HALL_OF_FAME, 1
	warp_event  7,  1, HALL_OF_FAME, 2

	def_coord_events
	coord_event  6,  5, 1, ApproachLanceFromLeftTrigger
	coord_event  7,  5, 1, ApproachLanceFromRightTrigger

	def_bg_events

	def_object_events
	object_event  7,  3, SPRITE_LANCE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LanceScript, -1
	object_event  6,  7, SPRITE_BUENA, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_LANCES_ROOM_OAK_AND_MARY
	object_event  6,  7, SPRITE_OAK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_LANCES_ROOM_OAK_AND_MARY

	object_const_def
	const LANCESROOM_LANCE
	const LANCESROOM_MARY
	const LANCESROOM_OAK

LancesRoomEntranceTrigger:
	sdefer .Script
	end

.Script:
	applymovement PLAYER, WalkIntoEliteFourRoomMovement
	refreshscreen
	playsound SFX_STRENGTH
	earthquake 80
	changeblock 6, 22, $34
	reloadmappart
	closetext
	setscene $1
	setevent EVENT_LANCES_ROOM_ENTRANCE_CLOSED
	end

WalkIntoEliteFourRoomMovement:
	step_up
	step_up
	step_up
	step_up
	step_end

LancesRoomDoorCallback:
	checkevent EVENT_LANCES_ROOM_ENTRANCE_CLOSED
	iffalse .LanceEntranceOpen
	changeblock 6, 22, $34
.LanceEntranceOpen:
	checkevent EVENT_LANCES_ROOM_EXIT_OPEN
	iffalse .LanceExitClosed
	changeblock 6, 0, $b
.LanceExitClosed:
	endcallback

ApproachLanceFromLeftTrigger:
	special Special_FadeOutMusic
	applymovement PLAYER, ApproachLanceFromLeftMovement
	sjump LanceScript

ApproachLanceFromRightTrigger:
	special Special_FadeOutMusic
	applymovement PLAYER, ApproachLanceFromRightMovement
LanceScript:
	turnobject LANCESROOM_LANCE, LEFT
	readvar VAR_BADGES
	ifequal 16, .Rematch
	showtext .SeenText
	winlosstext .BeatenText, 0
	setlasttalked LANCESROOM_LANCE
	loadtrainer CHAMPION, LANCE
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	showtext .AfterText
	sjump .EndBattle

.Rematch:
	showtext .SeenRematchText
	winlosstext .BeatenText, 0
	setlasttalked LANCESROOM_LANCE
	loadtrainer CHAMPION, LANCE2
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	showtext .AfterRematchText
.EndBattle:
	setevent EVENT_BEAT_CHAMPION_LANCE
	playsound SFX_ENTER_DOOR
	changeblock 6, 0, $b
	reloadmappart
	closetext
	setevent EVENT_LANCES_ROOM_ENTRANCE_CLOSED
	musicfadeout MUSIC_BEAUTY_ENCOUNTER, $10
	pause 30
	showemote EMOTE_SHOCK, LANCESROOM_LANCE, 15
	turnobject LANCESROOM_LANCE, DOWN
	pause 10
	turnobject PLAYER, DOWN
	appear LANCESROOM_MARY
	applymovement LANCESROOM_MARY, .RushInMovement
	showtext .MaryText1
	appear LANCESROOM_OAK
	applymovement LANCESROOM_OAK, .WalkInMovement
	follow LANCESROOM_MARY, LANCESROOM_OAK
	applymovement LANCESROOM_MARY, .StepAsideMovement
	stopfollow
	turnobject LANCESROOM_OAK, UP
	turnobject LANCESROOM_LANCE, LEFT
	showtext .OakSpeechText
	applymovement LANCESROOM_MARY, .ApproachPlayerMovement
	turnobject PLAYER, LEFT
	showtext .MaryText2
	applymovement LANCESROOM_LANCE, .WalkTowardExitMovement
	turnobject PLAYER, UP
	showtext .LanceLeavingText
	follow LANCESROOM_LANCE, PLAYER
	turnobject LANCESROOM_MARY, UP
	turnobject LANCESROOM_OAK, UP
	applyonemovement LANCESROOM_LANCE, step_up
	stopfollow
	playsound SFX_EXIT_BUILDING
	disappear LANCESROOM_LANCE
	applyonemovement PLAYER, step_up
	playsound SFX_EXIT_BUILDING
	disappear PLAYER
	applymovement LANCESROOM_MARY, .TryToFollowMovement
	showemote EMOTE_SHOCK, LANCESROOM_MARY, 15
	opentext
	writetext .MaryText3
	pause 30
	closetext
	applymovement LANCESROOM_MARY, .RunBackAndForthMovement
	special FadeOutPalettes
	pause 15
	warpfacing UP, HALL_OF_FAME, 4, 13
	end

.SeenText:
	text "Lance: I've been"
	line "waiting for you."

	para "<PLAYER>!"

	para "I knew that you,"
	line "with your skills,"

	para "would eventually"
	line "reach me here."

	para "There's no need"
	line "for words now."

	para "We will battle to"
	line "determine who is"

	para "the stronger of"
	line "the two of us."

	para "As the most power-"
	line "ful trainer and as"

	para "the #mon League"
	line "Champion…"

	para "I, Lance the drag-"
	line "on master, accept"
	cont "your challenge!"
	done

.BeatenText:
	text "…It's over."

	para "But it's an odd"
	line "feeling."

	para "I'm not angry that"
	line "I lost. In fact, I"
	cont "feel happy."

	para "Happy that I"
	line "witnessed the rise"

	para "of a great new"
	line "Champion!"
	done

.AfterText:
	text "…Whew."

	para "You have become"
	line "truly powerful,"
	cont "<PLAYER>."

	para "Your #mon have"
	line "responded to your"

	para "strong and up-"
	line "standing nature."

	para "As a trainer, you"
	line "will continue to"

	para "grow strong with"
	line "your #mon."
	done

.SeenRematchText:
	text "Lance: There's no"
	line "need for words"
	cont "now."

	para "We will battle to"
	line "determine who is"

	para "the stronger of"
	line "the two of us."

	para "I, Lance the drag-"
	line "on master, accept"
	cont "your challenge!"
	done

.AfterRematchText:
	text "Just as I"
	line "expected."

	para "You and your"
	line "#mon make"
	cont "quite a team."

	para "As a trainer, you"
	line "will continue to"

	para "grow strong with"
	line "your #mon."
	done

.MaryText1:
	text "Mary: Oh, no!"
	line "It's all over!"

	para "Prof.Oak, if you"
	line "weren't so slow…"
	done

.OakSpeechText:
	text "Prof.Oak: Ah,"
	line "<PLAYER>!"

	para "It's been a long"
	line "while."

	para "You certainly look"
	line "more impressive."

	para "Your conquest of"
	line "the League is just"
	cont "fantastic!"

	para "Your dedication,"
	line "trust and love for"

	para "your #mon made"
	line "this happen."

	para "Your #mon were"
	line "outstanding too."

	para "Because they be-"
	line "lieved in you as a"

	para "trainer, they per-"
	line "severed."

	para "Congratulations,"
	line "<PLAYER>!"
	done

.MaryText2:
	text "Mary: Let's inter-"
	line "view the brand new"
	cont "Champion!"
	done

.LanceLeavingText:
	text "Lance: This is"
	line "getting to be a"
	cont "bit too noisy…"

	para "<PLAYER>, could you"
	line "come with me?"
	done

.MaryText3:
	text "Mary: Oh, wait!"
	line "We haven't done"
	cont "the interview!"
	done

.RushInMovement:
	run_step_up
	run_step_up
	run_step_up
	turn_head_down
	step_end

.WalkInMovement:
	step_up
	step_up
	step_end

.StepAsideMovement:
	step_left
	turn_head_right
	step_end

.ApproachPlayerMovement:
	run_step_up
	turn_head_right
	step_end

.WalkTowardExitMovement:
	step_up
	step_left
	turn_head_down
	step_end

.TryToFollowMovement:
	step_up
	step_right
	turn_head_up
	step_end

.RunBackAndForthMovement:
	run_step_right
	run_step_right
	run_step_left
	run_step_left
	run_step_left
	run_step_right
	run_step_right
	run_step_right
	run_step_left
	run_step_left
	turn_head_up
	step_end

ApproachLanceFromLeftMovement:
	step_up
	step_up
	turn_head_right
	step_end

ApproachLanceFromRightMovement:
	step_up
	step_left
	step_up
	turn_head_right
	step_end
