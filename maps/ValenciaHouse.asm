const_value set 2
	const VALENCIAHOUSE_LASS

ValenciaHouse_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

ValenciaHouseLassScript:
	jumptextfaceplayer .Text

.Text:
	text "Prof.Ivy is really"
	line "cool!"

	para "She helped my"
	line "#mon when they"
	cont "were sick!"
	done

ValenciaHouse_MapEventHeader:
.Warps:
	db 2
	warp_def $7, $2, 3, VALENCIA_ISLAND
	warp_def $7, $3, 3, VALENCIA_ISLAND

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 1
	person_event SPRITE_LASS, 3, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ValenciaHouseLassScript, -1
