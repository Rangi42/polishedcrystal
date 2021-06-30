SilverCaveRoom3_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, SilverCaveRoom3DailyRedRematchCallback

	def_warp_events
	warp_event  9, 29, SILVER_CAVE_ROOM_2, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event 10,  6, SPRITE_RED, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Red, EVENT_RED_IN_MT_SILVER

	object_const_def
	const SILVERCAVEROOM3_RED

SilverCaveRoom3DailyRedRematchCallback:
	disappear SILVERCAVEROOM3_RED
	checkevent EVENT_BEAT_RED
	iftrue .Disappear ; we last beat Red, so Leaf needs to be beaten before Red reappears
	checkflag ENGINE_RED_IN_MOUNT_SILVER
	iftrue .Disappear
	appear SILVERCAVEROOM3_RED
.Disappear
	endcallback

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
	verbosegivekeyitem MYSTICTICKET
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
