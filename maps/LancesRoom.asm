LancesRoom_MapScriptHeader:

.MapTriggers: db 1
	dw LancesRoomTrigger0

.MapCallbacks: db 1
	dbw MAPCALLBACK_TILES, LancesRoomCheckDoor

LancesRoom_MapEventHeader:

.Warps: db 4
	warp_def $17, $4, 3, KARENS_ROOM
	warp_def $17, $5, 4, KARENS_ROOM
	warp_def $1, $4, 1, HALL_OF_FAME
	warp_def $1, $5, 2, HALL_OF_FAME

.XYTriggers: db 2
	xy_trigger 1, $5, $4, Script_ApproachLanceFromLeft
	xy_trigger 1, $5, $5, Script_ApproachLanceFromRight

.Signposts: db 0

.PersonEvents: db 3
	person_event SPRITE_LANCE, 3, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, LanceScript_0x180e7b, -1
	person_event SPRITE_TEACHER, 7, 4, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_LANCES_ROOM_OAK_AND_MARY
	person_event SPRITE_OAK, 7, 4, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_LANCES_ROOM_OAK_AND_MARY

const_value set 2
	const LANCESROOM_LANCE
	const LANCESROOM_MARY
	const LANCESROOM_OAK

LancesRoomTrigger0:
	priorityjump LancesRoom_PlayerWalksIn_DoorsCloseBehind
	end

LancesRoomCheckDoor:
	checkevent EVENT_LANCES_ROOM_ENTRANCE_CLOSED
	iffalse .LanceEntranceOpen
	changeblock $4, $16, $34
.LanceEntranceOpen:
	checkevent EVENT_LANCES_ROOM_EXIT_OPEN
	iffalse .LanceExitClosed
	changeblock $4, $0, $b
.LanceExitClosed:
	return

LancesRoom_PlayerWalksIn_DoorsCloseBehind:
	applymovement PLAYER, LancesRoom_PlayerWalksInMovementData
	refreshscreen
	playsound SFX_STRENGTH
	earthquake 80
	changeblock $4, $16, $34
	reloadmappart
	closetext
	dotrigger $1
	setevent EVENT_LANCES_ROOM_ENTRANCE_CLOSED
	end

Script_ApproachLanceFromLeft:
	special Special_FadeOutMusic
	applymovement PLAYER, MovementData_ApproachLanceFromLeft
	jump LanceScript_0x180e7b

Script_ApproachLanceFromRight:
	special Special_FadeOutMusic
	applymovement PLAYER, MovementData_ApproachLanceFromRight
LanceScript_0x180e7b:
	spriteface LANCESROOM_LANCE, LEFT
	opentext
	checkcode VAR_BADGES
	if_equal 16, LanceRematchScript
	writetext LanceBattleIntroText
	waitbutton
	closetext
	winlosstext LanceBattleWinText, 0
	setlasttalked LANCESROOM_LANCE
	loadtrainer CHAMPION, LANCE
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	setevent EVENT_BEAT_CHAMPION_LANCE
	opentext
	writetext LanceBattleAfterText
LanceEndBattleScript:
	waitbutton
	closetext
	playsound SFX_ENTER_DOOR
	changeblock $4, $0, $b
	reloadmappart
	closetext
	setevent EVENT_LANCES_ROOM_ENTRANCE_CLOSED
	musicfadeout MUSIC_BEAUTY_ENCOUNTER, $10
	pause 30
	showemote EMOTE_SHOCK, LANCESROOM_LANCE, 15
	spriteface LANCESROOM_LANCE, DOWN
	pause 10
	spriteface PLAYER, DOWN
	appear LANCESROOM_MARY
	applymovement LANCESROOM_MARY, LancesRoomMovementData_MaryRushesIn
	showtext UnknownText_0x1811dd
	appear LANCESROOM_OAK
	applymovement LANCESROOM_OAK, LancesRoomMovementData_OakWalksIn
	follow LANCESROOM_MARY, LANCESROOM_OAK
	applymovement LANCESROOM_MARY, LancesRoomMovementData_MaryYieldsToOak
	stopfollow
	spriteface LANCESROOM_OAK, UP
	spriteface LANCESROOM_LANCE, LEFT
	showtext UnknownText_0x18121b
	applymovement LANCESROOM_MARY, LancesRoomMovementData_MaryInterviewChampion
	spriteface PLAYER, LEFT
	showtext UnknownText_0x18134b
	applymovement LANCESROOM_LANCE, LancesRoomMovementData_LancePositionsSelfToGuidePlayerAway
	spriteface PLAYER, UP
	showtext UnknownText_0x18137b
	follow LANCESROOM_LANCE, PLAYER
	spriteface LANCESROOM_MARY, UP
	spriteface LANCESROOM_OAK, UP
	applymovement LANCESROOM_LANCE, LancesRoomMovementData_LanceLeadsPlayerToHallOfFame
	stopfollow
	playsound SFX_EXIT_BUILDING
	disappear LANCESROOM_LANCE
	applymovement PLAYER, LancesRoomMovementData_PlayerExits
	playsound SFX_EXIT_BUILDING
	disappear PLAYER
	applymovement LANCESROOM_MARY, LancesRoomMovementData_MaryTriesToFollow
	showemote EMOTE_SHOCK, LANCESROOM_MARY, 15
	opentext
	writetext UnknownText_0x1813c5
	pause 30
	closetext
	applymovement LANCESROOM_MARY, LancesRoomMovementData_MaryRunsBackAndForth
	special FadeOutPalettes
	pause 15
	warpfacing UP, HALL_OF_FAME, $4, $d
	end

LanceRematchScript:
	writetext LanceBeforeRematchText
	waitbutton
	closetext
	winlosstext LanceBattleWinText, 0
	setlasttalked LANCESROOM_LANCE
	loadtrainer CHAMPION, LANCE2
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	setevent EVENT_BEAT_CHAMPION_LANCE
	opentext
	writetext LanceAfterRematchText
	jump LanceEndBattleScript

LancesRoom_PlayerWalksInMovementData:
	step_up
	step_up
	step_up
	step_up
	step_end

MovementData_ApproachLanceFromLeft:
	step_up
	step_up
	turn_head_right
	step_end

MovementData_ApproachLanceFromRight:
	step_up
	step_left
	step_up
	turn_head_right
	step_end

LancesRoomMovementData_MaryRushesIn:
	big_step_up
	big_step_up
	big_step_up
	turn_head_down
	step_end

LancesRoomMovementData_OakWalksIn:
	step_up
	step_up
	step_end

LancesRoomMovementData_MaryYieldsToOak:
	step_left
	turn_head_right
	step_end

LancesRoomMovementData_MaryInterviewChampion:
	big_step_up
	turn_head_right
	step_end

LancesRoomMovementData_LancePositionsSelfToGuidePlayerAway:
	step_up
	step_left
	turn_head_down
	step_end

LancesRoomMovementData_LanceLeadsPlayerToHallOfFame:
	step_up
	step_end

LancesRoomMovementData_PlayerExits:
	step_up
	step_end

LancesRoomMovementData_MaryTriesToFollow:
	step_up
	step_right
	turn_head_up
	step_end

LancesRoomMovementData_MaryRunsBackAndForth:
	big_step_right
	big_step_right
	big_step_left
	big_step_left
	big_step_left
	big_step_right
	big_step_right
	big_step_right
	big_step_left
	big_step_left
	turn_head_up
	step_end

LanceBattleIntroText:
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

LanceBattleWinText:
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

LanceBattleAfterText:
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

LanceBeforeRematchText:
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

LanceAfterRematchText:
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

UnknownText_0x1811dd:
	text "Mary: Oh, no!"
	line "It's all over!"

	para "Prof.Oak, if you"
	line "weren't so slow…"
	done

UnknownText_0x18121b:
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

UnknownText_0x18134b:
	text "Mary: Let's inter-"
	line "view the brand new"
	cont "Champion!"
	done

UnknownText_0x18137b:
	text "Lance: This is"
	line "getting to be a"
	cont "bit too noisy…"

	para "<PLAYER>, could you"
	line "come with me?"
	done

UnknownText_0x1813c5:
	text "Mary: Oh, wait!"
	line "We haven't done"
	cont "the interview!"
	done
