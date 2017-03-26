const_value set 2
	const SHAMOUTIISLAND_VILEPLUME

ShamoutiIsland_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

ShamoutiIslandVileplumeScript:
	special SpecialSnorlaxAwake
	iftrue .Awake
	showemote EMOTE_SLEEP, SHAMOUTIISLAND_VILEPLUME, 15
	opentext
	writetext ShamoutiIslandVileplumeText
	waitbutton
	closetext
	end

.Awake:
	opentext
	writetext ShamoutiIslandPokeFluteText
	pause 15
	cry VILEPLUME
	closetext
	writecode VAR_BATTLETYPE, BATTLETYPE_FORCEITEM
	loadwildmon VILEPLUME, 60
	startbattle
	disappear SHAMOUTIISLAND_VILEPLUME
	reloadmapafterbattle
	end

ShamoutiIslandVileplumeText:
	text "Vileplume is fast"
	line "asleep…"
	done

ShamoutiIslandPokeFluteText:
	text "The #gear was"
	line "placed near the"

	para "sleeping Vile-"
	line "plume…"

	para "…"

	para "Vileplume woke up!"
	done

ShamoutiIsland_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 6
	warp_def $d, $15, 1, SHAMOUTI_POKECENTER_1F
	warp_def $5, $21, 1, SHAMOUTI_HOTEL
	warp_def $7, $10, 1, SHAMOUTI_TUNNEL
	warp_def $5, $1b, 1, SHAMOUTI_TOURIST_CENTER
	warp_def $c, $1f, 1, SHAMOUTI_HOUSE
	warp_def $d, $7, 1, SHAMOUTI_MERCHANT

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 1
	person_event SPRITE_VILEPLUME, 8, 16, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ShamoutiIslandVileplumeScript, EVENT_SHAMOUTI_ISLAND_VILEPLUME
