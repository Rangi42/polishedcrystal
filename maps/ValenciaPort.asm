ValenciaPort_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

ValenciaPort_MapEventHeader:

.Warps: db 2
	warp_def 17, 10, 1, ROUTE_49
	warp_def 17, 11, 1, ROUTE_49

.XYTriggers: db 0

.Signposts: db 1
	signpost 9, 10, SIGNPOST_ITEM + MAX_POTION, EVENT_VALENCIA_PORT_HIDDEN_MAX_POTION

.PersonEvents: db 2
	person_event SPRITE_SAILOR, 4, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ValenciaPortSailorScript, -1
	person_event SPRITE_FISHER, 10, 13, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, ValenciaPortFisherText, -1

const_value set 1
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
	spriteface VALENCIAPORT_SAILOR, UP
	pause 10
	playsound SFX_EXIT_BUILDING
	disappear VALENCIAPORT_SAILOR
	waitsfx
	applyonemovement PLAYER, step_up
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	domaptrigger SEAGALLOP_FERRY_SHAMOUTI_GATE, $1
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
