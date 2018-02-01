FarawayJungle_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event 12, 18, 1, FARAWAY_ISLAND
	warp_event 13, 18, 2, FARAWAY_ISLAND

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event 12, 10, SPRITE_MEW, SPRITEMOVEDATA_WANDER, 3, 3, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, FarawayJungleMew, EVENT_FARAWAY_JUNGLE_MEW

	const_def 1 ; object constants
	const FARAWAYJUNGLE_MEW

FarawayJungleMew:
	faceplayer
	opentext
	writetext MewText
	cry MEW
	pause 15
	closetext
	loadwildmon MEW, 30
	writecode VAR_BATTLETYPE, BATTLETYPE_LEGENDARY
	startbattle
	disappear FARAWAYJUNGLE_MEW
	setevent EVENT_FARAWAY_JUNGLE_MEW
	reloadmapafterbattle
	end

MewText:
	text "Mew!"
	done
