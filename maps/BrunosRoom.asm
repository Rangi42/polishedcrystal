const_value set 2
	const BRUNOSROOM_BRUNO

BrunosRoom_MapScriptHeader:
.MapTriggers:
	db 2
	maptrigger .Trigger0
	maptrigger .Trigger1

.MapCallbacks:
	db 1
	dbw MAPCALLBACK_TILES, .BrunosRoomDoors

.Trigger0:
	priorityjump UnknownScript_0x1809ad
	end

.Trigger1:
	end

.BrunosRoomDoors:
	checkevent EVENT_BRUNOS_ROOM_ENTRANCE_CLOSED
	iffalse .KeepDoorClosed
	changeblock $4, $e, $2a
.KeepDoorClosed:
	checkevent EVENT_BRUNOS_ROOM_EXIT_OPEN
	iffalse .OpenDoor
	changeblock $4, $2, $16
.OpenDoor:
	return

UnknownScript_0x1809ad:
	applymovement PLAYER, MovementData_0x1809f9
	refreshscreen $86
	playsound SFX_STRENGTH
	earthquake 80
	changeblock $4, $e, $2a
	reloadmappart
	closetext
	dotrigger $1
	setevent EVENT_BRUNOS_ROOM_ENTRANCE_CLOSED
	waitsfx
	end

BrunoScript_0x1809c5:
	faceplayer
	checkcode VAR_BADGES
	if_equal 16, BrunoRematchScript
	checkevent EVENT_BEAT_ELITE_4_BRUNO
	iftrue UnknownScript_0x1809f3
	opentext
	writetext UnknownText_0x1809fe
	waitbutton
	closetext
	winlosstext UnknownText_0x180b23, 0
	loadtrainer BRUNO, 1
	startbattle
	reloadmapafterbattle
	scall UnknownScript_0x1809f3
	jump BrunoEndBattleScript

UnknownScript_0x1809f3:
	opentext
	writetext UnknownText_0x180b3c
	waitbutton
	closetext
	end

BrunoRematchScript:
	checkevent EVENT_BEAT_ELITE_4_BRUNO
	iftrue .AfterBattle
	opentext
	writetext BrunoBeforeRematchText
	waitbutton
	closetext
	winlosstext UnknownText_0x180b23, 0
	loadtrainer BRUNO, 2
	startbattle
	reloadmapafterbattle
	scall .AfterBattle
	jump BrunoEndBattleScript

.AfterBattle:
	opentext
	writetext BrunoAfterRematchText
	waitbutton
	closetext
	end

BrunoEndBattleScript:
	playsound SFX_ENTER_DOOR
	changeblock $4, $2, $16
	reloadmappart
	setevent EVENT_BRUNOS_ROOM_EXIT_OPEN
	setevent EVENT_BEAT_ELITE_4_BRUNO
	waitsfx
	end

MovementData_0x1809f9:
	step_up
	step_up
	step_up
	step_up
	step_end

UnknownText_0x1809fe:
	text "I am Bruno of the"
	line "Elite Four."

	para "I always train to"
	line "the extreme be-"
	cont "cause I believe in"
	cont "our potential."

	para "That is how we"
	line "became strong."

	para "Can you withstand"
	line "our power?"

	para "Hm? I see no fear"
	line "in you. You look"

	para "determined. Per-"
	line "fect for battle!"

	para "Ready, <PLAYER>?"
	line "You will bow down"

	para "to our overwhelm-"
	line "ing power!"

	para "Hoo hah!"
	done

UnknownText_0x180b23:
	text "Why? How could we"
	line "lose?"
	done

UnknownText_0x180b3c:
	text "Having lost, I"
	line "have no right to"
	cont "say anything…"

	para "Go face your next"
	line "challenge!"
	done

BrunoBeforeRematchText:
	text "Hello again."

	para "As one of the"
	line "Elite Four, I will"
	cont "stand up to your"
	cont "challenge!"

	para "It would disturb"
	line "me for you to"
	cont "underestimate my"
	cont "fighting #mon."

	para "Get ready!"
	done

BrunoAfterRematchText:
	text "We tried hard."

	para "Continue on!"
	done

BrunosRoom_MapEventHeader:
.Warps:
	db 4
	warp_def $11, $4, 3, KOGAS_ROOM
	warp_def $11, $5, 4, KOGAS_ROOM
	warp_def $2, $4, 1, KARENS_ROOM
	warp_def $2, $5, 2, KARENS_ROOM

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 1
	person_event SPRITE_BRUNO, 7, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, BrunoScript_0x1809c5, -1
