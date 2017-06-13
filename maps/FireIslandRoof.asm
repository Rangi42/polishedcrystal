const_value set 2
	const FIREISLANDROOF_CANDELA

FireIslandRoof_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

FireIslandRoofCandelaScript:
	faceplayer
	opentext
	writetext .GreetingText
	yesorno
	iffalse .Refused
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	loadtrainer CANDELA, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_CANDELA
	opentext
	writetext .AfterText
	waitbutton
	closetext
	playsound SFX_WARP_TO
	applymovement FIREISLANDROOF_CANDELA, FireIslandRoofCandelaTeleport
	disappear FIREISLANDROOF_CANDELA
	clearevent EVENT_CELADON_UNIVERSITY_CANDELA
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

FireIslandRoofCandelaTeleport:
	teleport_from
	step_end

FireIslandRoof_MapEventHeader:
.Warps:
	db 1
	warp_def $7, $3, 2, FIRE_ISLAND

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 1
	person_event SPRITE_CANDELA, 5, 5, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, FireIslandRoofCandelaScript, EVENT_SHAMOUTI_COAST_CANDELA
