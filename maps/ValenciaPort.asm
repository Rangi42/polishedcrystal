const_value set 2
	const VALENCIAPORT_SAILOR
	const VALENCIAPORT_FISHER

ValenciaPort_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

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
	applymovement PLAYER, .StepUp
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	domaptrigger SEAGALLOP_FERRY_SHAMOUTI_GATE, $1
	warp SEAGALLOP_FERRY_SHAMOUTI_GATE, $6, $5
	end

.RefuseFerry
	writetext .RefuseText
	waitbutton
	closetext
	end

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

.StepUp:
	step_up
	step_end

ValenciaPortFisherScript:
	jumptextfaceplayer .Text

.Text:
	text "TODO"
	done

ValenciaPortHiddenMaxPotion:
	dwb EVENT_VALENCIA_PORT_HIDDEN_MAX_POTION, MAX_POTION

ValenciaPort_MapEventHeader:
.Warps:
	db 2
	warp_def $11, $a, 1, ROUTE_49
	warp_def $11, $b, 1, ROUTE_49

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 9, 10, SIGNPOST_ITEM, ValenciaPortHiddenMaxPotion

.PersonEvents:
	db 2
	person_event SPRITE_SAILOR, 4, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ValenciaPortSailorScript, -1
	person_event SPRITE_FISHER, 10, 13, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, ValenciaPortFisherScript, -1
