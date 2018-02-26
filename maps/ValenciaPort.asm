ValenciaPort_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event 10, 17, ROUTE_49, 1
	warp_event 11, 17, ROUTE_49, 1

	db 0 ; coord events

	db 1 ; bg events
	bg_event 10,  9, SIGNPOST_ITEM + MAX_POTION, EVENT_VALENCIA_PORT_HIDDEN_MAX_POTION

	db 2 ; object events
	object_event 11,  4, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ValenciaPortSailorScript, -1
	object_event 13, 10, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, ValenciaPortFisherText, -1

	const_def 1 ; object constants
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
