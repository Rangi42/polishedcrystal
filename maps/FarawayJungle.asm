FarawayJungle_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 12, 18, FARAWAY_ISLAND, 1
	warp_event 13, 18, FARAWAY_ISLAND, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event 12, 10, SPRITE_MEW, SPRITEMOVEDATA_WANDER, 3, 3, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FarawayJungleMew, EVENT_FARAWAY_JUNGLE_MEW

	object_const_def
	const FARAWAYJUNGLE_MEW

FarawayJungleMew:
	faceplayer
	opentext
	writetext MewText
	cry MEW
	pause 15
	closetext
	loadwildmon MEW, 30
	loadvar VAR_BATTLETYPE, BATTLETYPE_LEGENDARY
	startbattle
	disappear FARAWAYJUNGLE_MEW
	setevent EVENT_FARAWAY_JUNGLE_MEW
	reloadmapafterbattle
	end

MewText:
	text "Mew!"
	done
