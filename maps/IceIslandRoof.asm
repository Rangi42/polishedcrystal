const_value set 2
	const ICEISLANDROOF_BLANCHE

IceIslandRoof_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

IceIslandRoofBlancheScript:
	faceplayer
	opentext
	writetext .GreetingText
	yesorno
	iffalse .Refused
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	loadtrainer BLANCHE, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_BLANCHE
	opentext
	writetext .AfterText
	waitbutton
	closetext
	playsound SFX_WARP_TO
	applymovement ICEISLANDROOF_BLANCHE, IceIslandRoofBlancheTeleport
	disappear ICEISLANDROOF_BLANCHE
	clearevent EVENT_CELADON_UNIVERSITY_BLANCHE
	end

.Refused:
	writetext .RefusedText
	waitbutton
	closetext
	end

.GreetingText:
	text "TODO"
	done

.SeenText:
	text "TODO"
	done

.BeatenText:
	text "TODO"
	done

.AfterText:
	text "TODO"
	done

.RefusedText:
	text "TODO"
	done

IceIslandRoofBlancheTeleport:
	teleport_from
	step_end

IceIslandRoof_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def $7, $3, 2, ICE_ISLAND

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 1
	person_event SPRITE_BLANCHE, 5, 5, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, IceIslandRoofBlancheScript, EVENT_SHAMOUTI_COAST_BLANCHE
