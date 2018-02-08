KogasRoom_MapScriptHeader:
	db 1 ; scene scripts
	scene_script KogasRoomEntranceTrigger

	db 1 ; callbacks
	callback MAPCALLBACK_TILES, KogasRoomDoorCallback

	db 4 ; warp events
	warp_event  4, 17, WILLS_ROOM, 2
	warp_event  5, 17, WILLS_ROOM, 3
	warp_event  4,  2, BRUNOS_ROOM, 1
	warp_event  5,  2, BRUNOS_ROOM, 2

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event  5,  7, SPRITE_KOGA, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_SCRIPT, 0, KogaScript, -1

KogasRoomEntranceTrigger:
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
	setscene $1
	setevent EVENT_KOGAS_ROOM_ENTRANCE_CLOSED
	waitsfx
	end

KogasRoomDoorCallback:
	checkevent EVENT_KOGAS_ROOM_ENTRANCE_CLOSED
	iffalse .KeepDoorClosed
	changeblock 4, 14, $2a
.KeepDoorClosed:
	checkevent EVENT_KOGAS_ROOM_EXIT_OPEN
	iffalse .OpenDoor
	changeblock 4, 2, $16
.OpenDoor:
	return

KogaScript:
	checkcode VAR_BADGES
	ifequal 16, .Rematch
	checkevent EVENT_BEAT_ELITE_4_KOGA
	iftrue_jumptextfaceplayer .AfterText
	showtextfaceplayer .SeenText
	winlosstext .BeatenText, 0
	loadtrainer KOGA, 1
	startbattle
	reloadmapafterbattle
	showtext .AfterText
	jump .EndBattle

.Rematch:
	checkevent EVENT_BEAT_ELITE_4_KOGA
	iftrue_jumptextfaceplayer .AfterRematchText
	showtextfaceplayer .SeenRematchText
	winlosstext .BeatenText, 0
	loadtrainer KOGA, 2
	startbattle
	reloadmapafterbattle
	showtext .AfterRematchText
.EndBattle:
	playsound SFX_ENTER_DOOR
	changeblock 4, 2, $16
	reloadmappart
	setevent EVENT_KOGAS_ROOM_EXIT_OPEN
	setevent EVENT_BEAT_ELITE_4_KOGA
	waitsfx
	end

.SeenText:
	text "Fwahahahaha!"

	para "I am Koga of the"
	line "Elite Four."

	para "I live in shadows,"
	line "a ninja!"

	para "My intricate style"
	line "will confound and"
	cont "destroy you!"

	para "Confusion, sleep,"
	line "poison…"

	para "Prepare to be the"
	line "victim of my sin-"
	cont "ister technique!"

	para "Fwahahahaha!"

	para "#mon is not"
	line "merely about brute"

	para "force--you shall"
	line "see soon enough!"
	done

.BeatenText:
	text "Ah!"
	line "You have proven"
	cont "your worth!"
	done

.AfterText:
	text "I subjected you to"
	line "everything I could"
	cont "muster."

	para "But my efforts"
	line "failed. I must"
	cont "hone my skills."

	para "Go on to the next"
	line "room, and put your"
	cont "abilities to test!"
	done

.SeenRematchText:
	text "Your arrival is"
	line "indeed impressive,"
	cont "as is your look of"
	cont "resolve."

	para "Fwahahahaha!"

	para "My skill will be"
	line "hard to overcome!"

	para "Let me show you"
	line "what I mean!"
	done

.AfterRematchText:
	text "Never have I met"
	line "the likes of you."

	para "I must devote"
	line "myself to my"
	cont "training."
	done
