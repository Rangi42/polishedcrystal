FireIslandRoof_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  7, FIRE_ISLAND, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  5, SPRITE_CANDELA, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FireIslandRoofCandelaScript, EVENT_SHAMOUTI_COAST_CANDELA

	object_const_def
	const FIREISLANDROOF_CANDELA

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
	showtext .AfterText
	playsound SFX_WARP_TO
	applyonemovement FIREISLANDROOF_CANDELA, teleport_from
	disappear FIREISLANDROOF_CANDELA
	clearevent EVENT_CELADON_UNIVERSITY_CANDELA
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
