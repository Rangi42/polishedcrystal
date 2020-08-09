ValenciaPort_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 10, 17, ROUTE_49, 1
	warp_event 11, 17, ROUTE_49, 1

	def_coord_events

	def_bg_events
	bg_event 10,  9, BGEVENT_ITEM + MAX_POTION, EVENT_VALENCIA_PORT_HIDDEN_MAX_POTION

	def_object_events
	object_event 11,  4, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ValenciaPortSailorScript, -1
	object_event 13, 10, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, ValenciaPortFisherText, -1

	object_const_def
	const VALENCIAPORT_SAILOR

ValenciaPortSailorScript:
	faceplayer
	opentext
	writetext .QuestionText
	yesorno
	iffalse .RefuseFerry
	writetext .DepartText
	waitbutton
	closetext
	turnobject VALENCIAPORT_SAILOR, UP
	pause 10
	playsound SFX_EXIT_BUILDING
	disappear VALENCIAPORT_SAILOR
	waitsfx
	applyonemovement PLAYER, step_up
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	setmapscene SEAGALLOP_FERRY_SHAMOUTI_GATE, $1
	warp SEAGALLOP_FERRY_SHAMOUTI_GATE, 6, 5
	end

.RefuseFerry
	jumpopenedtext .RefuseText

.QuestionText:
	text "Going back to"
	line "Shamouti Island?"
	done

.DepartText:
	text "All right!"

	para "All aboard the"
	line "Seagallop Ferry!"
	done

.RefuseText:
	text "I'll be waiting"
	line "right here."
	done

ValenciaPortFisherText:
	text "Have you noticed"
	line "the sea?"

	para "These waters are"
	line "different from"

	para "those found in"
	line "Kanto and Johto."
	done
