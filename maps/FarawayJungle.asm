FarawayJungle_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 2 ; warps
	warp_def 18, 12, 1, FARAWAY_ISLAND
	warp_def 18, 13, 2, FARAWAY_ISLAND

	db 0 ; xy triggers

	db 0 ; signposts

	db 1 ; person events
	person_event SPRITE_MEW, 10, 12, SPRITEMOVEDATA_WANDER, 3, 3, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, FarawayJungleMew, EVENT_FARAWAY_JUNGLE_MEW

	const_def 1 ; person constants
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
