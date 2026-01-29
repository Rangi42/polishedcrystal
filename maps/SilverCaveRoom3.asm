SilverCaveRoom3_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, SilverCaveRoom3DailyRedRematchCallback

	def_warp_events
	warp_event  7, 29, SILVER_CAVE_ROOM_2, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  8,  6, SPRITE_RED, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, Red, EVENT_RED_IN_MT_SILVER
	object_event  0,  9,  SPRITE_RATTATA_BACK, SPRITEMOVEDATA_ARCH_TREE_LEFT, 0, 0, -1, PAL_NPC_COPY_BG_ROOF, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event  1,  8,  SPRITE_RATTATA_BACK, SPRITEMOVEDATA_ARCH_TREE_LEFT, 0, 0, -1, PAL_NPC_COPY_BG_ROOF, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event  2,  7,  SPRITE_RATTATA_BACK, SPRITEMOVEDATA_POKECOM_NEWS, 0, 0, -1, PAL_NPC_COPY_BG_ROOF, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event  3,  6,  SPRITE_BALL_CUT_TREE, SPRITEMOVEDATA_ARCH_TREE_LEFT, 0, 0, -1, PAL_NPC_COPY_BG_ROOF, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event 15,  9,  SPRITE_BLANK_FRUIT, SPRITEMOVEDATA_ARCH_TREE_RIGHT, 0, 0, -1, PAL_NPC_COPY_BG_ROOF, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event 14,  8,  SPRITE_BLANK_FRUIT, SPRITEMOVEDATA_ARCH_TREE_RIGHT, 0, 0, -1, PAL_NPC_COPY_BG_ROOF, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event 13,  7,  SPRITE_BLANK_FRUIT, SPRITEMOVEDATA_POKECOM_NEWS, 0, 0, -1, PAL_NPC_COPY_BG_ROOF, OBJECTTYPE_COMMAND, end, NULL, -1
	object_event 12,  6,  SPRITE_BALL_CUT_TREE, SPRITEMOVEDATA_ARCH_TREE_RIGHT, 0, 0, -1, PAL_NPC_COPY_BG_ROOF, OBJECTTYPE_COMMAND, end, NULL, -1

	object_const_def
	const SILVERCAVEROOM3_RED

SilverCaveRoom3DailyRedRematchCallback:
	disappear SILVERCAVEROOM3_RED
	checkevent EVENT_BEAT_RED
	iftruefwd .Disappear ; we last beat Red, so Leaf needs to be beaten before Red reappears
	checkflag ENGINE_RED_IN_MOUNT_SILVER
	iftruefwd .Disappear
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
	iftruefwd .AlreadyHaveMysticTicket
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

.Text1: ; text > text
	text "……"
	line "……"
	cont "……"
	done

.Text2: ; text > text
	text "…"
	done
