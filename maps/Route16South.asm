const_value set 2
	const ROUTE16_OFFICER_F

Route16South_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1

	; callbacks

	dbw MAPCALLBACK_NEWMAP, UnknownScript_0x1ad318

UnknownScript_0x1ad318:
	setflag ENGINE_ALWAYS_ON_BIKE
	return

OfficerfJennyScript:
	faceplayer
	opentext
	checknite
	iffalse .NoFight
	checkevent EVENT_BEAT_OFFICERF_JENNY
	iftrue .AfterScript
	special SaveMusic
	playmusic MUSIC_OFFICER_ENCOUNTER
	writetext OfficerfJennySeenText
	waitbutton
	closetext
	winlosstext OfficerfJennyBeatenText, 0
	loadtrainer OFFICERF, JENNY
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_OFFICERF_JENNY
	closetext
	end

.AfterScript:
	writetext OfficerfJennyAfterText
	waitbutton
	closetext
	end

.NoFight:
	writetext OfficerfJennyDaytimeText
	waitbutton
	closetext
	end

CyclingRoadSign:
	jumptext CyclingRoadSignText

OfficerfJennySeenText:
	text "Hey you! Are you"
	line "causing trouble?"
	done

OfficerfJennyBeatenText:
	text "Hmph!"
	done

OfficerfJennyAfterText:
	text "Riding around late"
	line "at night just"
	cont "looks suspicious."
	done

OfficerfJennyDaytimeText:
	text "Bikers and"
	line "Roughnecks like"

	para "to make trouble"
	line "on this road."

	para "Don't you get"
	line "involved, got it?"
	done

CyclingRoadSignText:
	text "Cycling Road"

	para "Downhill coasting"
	line "all the way!"
	done

Route16South_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $a, $9, 1, ROUTE_16_17_GATE
	warp_def $b, $9, 2, ROUTE_16_17_GATE

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 9, 5, SIGNPOST_READ, CyclingRoadSign

.PersonEvents:
	db 1
	person_event SPRITE_OFFICER_F, 11, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, OfficerfJennyScript, -1
