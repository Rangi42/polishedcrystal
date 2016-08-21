const_value set 2
	const CELADONHOMEDECORSTORE3F_CLERK

CeladonHomeDecorStore3F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonHomeDecorStore3FDirectory:
	jumptext CeladonHomeDecorStore3FDirectoryText

CeladonHomeDecorStore3FDirectoryText:
	text "Colorful Elegance"

	para "3F: Carpets"
	done

CeladonHomeDecorStore3F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $0, $6, 2, CELADON_HOME_DECOR_STORE_2F
	warp_def $0, $9, 1, CELADON_HOME_DECOR_STORE_4F

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 0, 8, SIGNPOST_READ, CeladonHomeDecorStore3FDirectory

.PersonEvents:
	db 1
	person_event SPRITE_CLERK, 7, 7, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
