WhirlIslandLugiaChamber_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, WhirlIslandLugiaChamberLugia

	def_warp_events
	warp_event  9, 13, WHIRL_ISLAND_B2F, 3

	def_coord_events

	def_bg_events

	def_object_events
	object_event  9,  5, SPRITE_BIG_LUGIA, SPRITEMOVEDATA_BIG_LUGIA, 0, 0, -1, PAL_NPC_WHITE, OBJECTTYPE_SCRIPT, 0, Lugia, EVENT_WHIRL_ISLAND_LUGIA_CHAMBER_LUGIA

	object_const_def
	const WHIRLISLANDLUGIACHAMBER_LUGIA

WhirlIslandLugiaChamberLugia:
	checkevent EVENT_FOUGHT_LUGIA
	iftruefwd .NoAppear
	checkkeyitem SILVER_WING
	iftruefwd .Appear
	sjumpfwd .NoAppear

.Appear:
	appear WHIRLISLANDLUGIACHAMBER_LUGIA
	endcallback

.NoAppear:
	disappear WHIRLISLANDLUGIACHAMBER_LUGIA
	endcallback

Lugia:
	faceplayer
	opentext
	writetext LugiaText
	cry LUGIA
	pause 15
	closetext
	setevent EVENT_FOUGHT_LUGIA
	loadvar VAR_BATTLETYPE, BATTLETYPE_LEGENDARY
	loadwildmon LUGIA, 75
	startbattle
	disappear WHIRLISLANDLUGIACHAMBER_LUGIA
	reloadmapafterbattle
	special CheckBattleCaughtResult
	iffalsefwd .nocatch
	setflag ENGINE_PLAYER_CAUGHT_LUGIA
.nocatch
	end

LugiaText:
	text "Gyaaas!"
	done
