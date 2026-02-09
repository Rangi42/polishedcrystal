BrunosRoom_MapScriptHeader:
	def_scene_scripts
	scene_script BrunosRoomLockDoorScene, SCENE_BRUNOSROOM_LOCK_DOOR
	scene_const SCENE_BRUNOSROOM_NOOP

	def_callbacks
	callback MAPCALLBACK_TILES, BrunosRoomDoorCallback

	def_warp_events
	warp_event  4, 17, KOGAS_ROOM, 3
	warp_event  5, 17, KOGAS_ROOM, 4
	warp_event  4,  2, KARENS_ROOM, 1
	warp_event  5,  2, KARENS_ROOM, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  7, SPRITE_BRUNO, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, BrunoScript, -1

BrunosRoomLockDoorScene:
	sdefer .Script
	end

.Script:
	applymovement PLAYER, WalkIntoEliteFourRoomMovement
	reanchormap
	playsound SFX_STRENGTH
	earthquake 80
	changeblock 4, 14, $2a
	refreshmap
	closetext
	setscene SCENE_BRUNOSROOM_NOOP
	setevent EVENT_BRUNOS_ROOM_ENTRANCE_CLOSED
	waitsfx
	end

BrunosRoomDoorCallback:
	checkevent EVENT_BRUNOS_ROOM_ENTRANCE_CLOSED
	iffalsefwd .KeepDoorClosed
	changeblock 4, 14, $2a
.KeepDoorClosed:
	checkevent EVENT_BRUNOS_ROOM_EXIT_OPEN
	iffalsefwd .OpenDoor
	changeblock 4, 2, $16
.OpenDoor:
	endcallback

BrunoScript:
	readvar VAR_BADGES
	ifequalfwd 16, .Rematch
	checkevent EVENT_BEAT_ELITE_4_BRUNO
	iftrue_jumptextfaceplayer .AfterText
	showtextfaceplayer .SeenText
	winlosstext .BeatenText, 0
	loadtrainer BRUNO, 1
	startbattle
	reloadmapafterbattle
	showtext .AfterText
	sjumpfwd .EndBattle

.Rematch:
	checkevent EVENT_BEAT_ELITE_4_BRUNO
	iftrue_jumptextfaceplayer .AfterRematchText
	showtextfaceplayer .SeenRematchText
	winlosstext .BeatenText, 0
	loadtrainer BRUNO, 2
	startbattle
	reloadmapafterbattle
	showtext .AfterRematchText
.EndBattle:
	playsound SFX_ENTER_DOOR
	changeblock 4, 2, $16
	refreshmap
	setevent EVENT_BRUNOS_ROOM_EXIT_OPEN
	setevent EVENT_BEAT_ELITE_4_BRUNO
	waitsfx
	end

.SeenText:
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

.BeatenText:
	text "Why? How could we"
	line "lose?"
	done

.AfterText:
	text "Having lost, I"
	line "have no right to"
	cont "say anything…"

	para "Go face your next"
	line "challenge!"
	done

.SeenRematchText:
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

.AfterRematchText:
	text "We tried hard."

	para "Continue on!"
	done
