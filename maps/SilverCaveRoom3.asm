SilverCaveRoom3_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_SPRITES, SilverCaveRoom3DailyRedRematchCallback

	db 1 ; warp events
	warp_event  9, 29, SILVER_CAVE_ROOM_2, 2

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event 10,  6, SPRITE_RED, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, Red, EVENT_RED_IN_MT_SILVER

	const_def 1 ; object constants
	const SILVERCAVEROOM3_RED

SilverCaveRoom3DailyRedRematchCallback:
	disappear SILVERCAVEROOM3_RED
	checkflag ENGINE_RED_IN_MOUNT_SILVER
	iftrue .Disappear
	appear SILVERCAVEROOM3_RED
.Disappear
	return

Red:
	special Special_FadeOutMusic
	showtextfaceplayer .Text1
	winlosstext .Text2, .Text2
	loadtrainer RED, 1
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	special Special_FadeOutMusic
	faceplayer
	opentext
	writetext .Text1
	waitbutton
	checkevent EVENT_GOT_MYSTICTICKET_FROM_RED
	iftrue .AlreadyHaveMysticTicket
	verbosegiveitem MYSTICTICKET
	setevent EVENT_GOT_MYSTICTICKET_FROM_RED
.AlreadyHaveMysticTicket
	closetext
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear SILVERCAVEROOM3_RED
	setflag ENGINE_RED_IN_MOUNT_SILVER
	pause 15
	special Special_FadeInQuickly
	pause 30
	special HealParty
	setevent EVENT_BEAT_RED
	playmapmusic
	end

.Text1:
	text "……"
	line "……"
	done

.Text2:
	text "…"
	done
