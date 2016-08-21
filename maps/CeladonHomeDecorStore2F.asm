const_value set 2
	const CELADONHOMEDECORSTORE2F_CLERK

CeladonHomeDecorStore2F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonHomeDecorStore2FDirectory:
	jumptext CeladonHomeDecorStore2FDirectoryText

CeladonHomeDecorStore2FDirectoryText:
	text "Soft and Fluffy!"

	para "2F: Beds"
	done

CeladonHomeDecorStore2F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $0, $9, 3, CELADON_HOME_DECOR_STORE_1F
	warp_def $0, $6, 1, CELADON_HOME_DECOR_STORE_3F

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 0, 8, SIGNPOST_READ, CeladonHomeDecorStore2FDirectory

.PersonEvents:
	db 1
	person_event SPRITE_CLERK, 5, 9, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
