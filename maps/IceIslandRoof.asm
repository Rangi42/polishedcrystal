IceIslandRoof_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  7, ICE_ISLAND, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  5, SPRITE_BLANCHE, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, IceIslandRoofBlancheScript, EVENT_SHAMOUTI_COAST_BLANCHE

	object_const_def
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
