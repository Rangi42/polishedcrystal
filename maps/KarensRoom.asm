KarensRoom_MapScriptHeader:

.MapTriggers: db 1
	dw KarensRoomEntranceTrigger

.MapCallbacks: db 1
	dbw MAPCALLBACK_TILES, KarensRoomDoorCallback

KarensRoom_MapEventHeader:

.Warps: db 4
	warp_def 17, 4, 3, BRUNOS_ROOM
	warp_def 17, 5, 4, BRUNOS_ROOM
	warp_def 2, 4, 1, LANCES_ROOM
	warp_def 2, 5, 2, LANCES_ROOM

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	person_event SPRITE_KAREN, 7, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, KarenScript, -1

KarensRoomEntranceTrigger:
	priorityjump .Script
	end

.Script:
	applymovement PLAYER, WalkIntoEliteFourRoomMovement
	refreshscreen
	playsound SFX_STRENGTH
	earthquake 80
	changeblock 4, 14, $2a
	reloadmappart
	closetext
	dotrigger $1
	setevent EVENT_KARENS_ROOM_ENTRANCE_CLOSED
	waitsfx
	end

KarensRoomDoorCallback:
	checkevent EVENT_KARENS_ROOM_ENTRANCE_CLOSED
	iffalse .KeepDoorClosed
	changeblock 4, 14, $2a
.KeepDoorClosed:
	checkevent EVENT_KARENS_ROOM_EXIT_OPEN
	iffalse .OpenDoor
	changeblock 4, 2, $16
.OpenDoor:
	return

KarenScript:
	checkcode VAR_BADGES
	if_equal 16, .Rematch
	checkevent EVENT_BEAT_ELITE_4_KAREN
	iftrue_jumptextfaceplayer .AfterText
	showtextfaceplayer .SeenText
	winlosstext .BeatenText, 0
	loadtrainer KAREN, 1
	startbattle
	reloadmapafterbattle
	showtext .AfterText
	jump .EndBattle

.Rematch:
	checkevent EVENT_BEAT_ELITE_4_KAREN
	iftrue_jumptextfaceplayer .AfterRematchText
	showtextfaceplayer .SeenRematchText
	winlosstext .BeatenText, 0
	loadtrainer KAREN, 2
	startbattle
	reloadmapafterbattle
	showtext .AfterRematchText
.EndBattle:
	playsound SFX_ENTER_DOOR
	changeblock 4, 2, $16
	reloadmappart
	setevent EVENT_KARENS_ROOM_EXIT_OPEN
	setevent EVENT_BEAT_ELITE_4_KAREN
	waitsfx
	end

.SeenText:
	text "I am Karen of the"
	line "Elite Four."

	para "You're <PLAYER>?"
	line "How amusing."

	para "I love Dark-type"
	line "#mon."

	para "I find their wild,"
	line "tough image to be"

	para "so appealing. And"
	line "they're so strong."

	para "Think you can take"
	line "them? Just try to"
	cont "entertain me."

	para "Let's go."
	done

.BeatenText:
	text "Well, aren't you"
	line "good. I like that"
	cont "in a trainer."
	done

.AfterText:
	text "Strong #mon."

	para "Weak #mon."

	para "That is only the"
	line "selfish perception"
	cont "of people."

	para "Truly skilled"
	line "trainers should"

	para "try to win with"
	line "their favorites."

	para "I like your style."
	line "You understand"
	cont "what's important."

	para "Go on--the Cham-"
	line "pion is waiting."
	done

.SeenRematchText:
	text "You fought through"
	line "the ranks to reach"
	cont "me. I'm impressed."

	para "You've assembled a"
	line "charming team."

	para "Our battle should"
	line "be a good one."

	para "Let's begin!"
	done

.AfterRematchText:
	text "I will not stray"
	line "from my chosen"
	cont "path."

	para "Lance is looking"
	line "forward to meeting"
	cont "you again."
	done
