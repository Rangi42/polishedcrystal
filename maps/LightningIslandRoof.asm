LightningIslandRoof_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

LightningIslandRoof_MapEventHeader:

.Warps: db 1
	warp_def 7, 3, 2, LIGHTNING_ISLAND

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	person_event SPRITE_SPARK, 5, 5, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, LightningIslandRoofSparkScript, EVENT_SHAMOUTI_COAST_SPARK

const_value set 1
	const LIGHTNINGISLANDROOF_SPARK

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
	loadtrainer SPARK_T, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_SPARK
	showtext .AfterText
	playsound SFX_WARP_TO
	applyonemovement LIGHTNINGISLANDROOF_SPARK, teleport_from
	disappear LIGHTNINGISLANDROOF_SPARK
	clearevent EVENT_CELADON_UNIVERSITY_SPARK
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
