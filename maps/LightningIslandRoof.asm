const_value set 2
	const LIGHTNINGISLANDROOF_SPARK

LightningIslandRoof_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

LightningIslandRoofSparkScript:
	faceplayer
	opentext
	writetext .GreetingText
	yesorno
	iffalse .Refused
	writetext .SeenText
	waitbutton
	closetext
	winlosstext .BeatenText, 0
	loadtrainer SPARK, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_SPARK
	opentext
	writetext .AfterText
	waitbutton
	closetext
	playsound SFX_WARP_TO
	applymovement LIGHTNINGISLANDROOF_SPARK, LightningIslandRoofSparkTeleport
	disappear LIGHTNINGISLANDROOF_SPARK
	clearevent EVENT_CELADON_UNIVERSITY_SPARK
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

LightningIslandRoofSparkTeleport:
	teleport_from
	step_end

LightningIslandRoof_MapEventHeader:
.Warps:
	db 1
	warp_def $7, $3, 2, LIGHTNING_ISLAND

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 1
	person_event SPRITE_SPARK, 5, 5, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, LightningIslandRoofSparkScript, EVENT_SHAMOUTI_COAST_SPARK
