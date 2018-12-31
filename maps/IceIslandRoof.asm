IceIslandRoof_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

IceIslandRoof_MapEventHeader:

.Warps: db 1
	warp_def 7, 3, 2, ICE_ISLAND

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	person_event SPRITE_BLANCHE, 5, 5, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, IceIslandRoofBlancheScript, EVENT_SHAMOUTI_COAST_BLANCHE

const_value set 1
	const ICEISLANDROOF_BLANCHE

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
	showtext .AfterText
	playsound SFX_WARP_TO
	applyonemovement ICEISLANDROOF_BLANCHE, teleport_from
	disappear ICEISLANDROOF_BLANCHE
	clearevent EVENT_CELADON_UNIVERSITY_BLANCHE
	end

.Refused:
	jumpopenedtext .RefusedText

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
