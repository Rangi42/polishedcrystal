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
	writetext .Text
	waitbutton
	closetext
	end

.Text:
	text "TODO"
	done

ValenciaPortFisherScript:
	jumptextfaceplayer .Text

.Text:
	text "TODO"
	done

ValenciaPort_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $11, $6, 1, ROUTE_49
	warp_def $11, $7, 1, ROUTE_49

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 2
	person_event SPRITE_SAILOR, 4, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ValenciaPortSailorScript, -1
	person_event SPRITE_FISHER, 10, 9, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, ValenciaPortFisherScript, -1
