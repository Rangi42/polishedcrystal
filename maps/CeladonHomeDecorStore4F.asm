const_value set 2
	const CELADONHOMEDECORSTORE4F_CLERK

CeladonHomeDecorStore4F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonHomeDecorStore4FDirectory:
	jumptext CeladonHomeDecorStore4FDirectoryText

CeladonHomeDecorStore4FDirectoryText:
	text "A Stuffed"
	line "Companion!"

	para "4F: Jumbo Dolls"
	done

CeladonHomeDecorStore4F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def $0, $9, 2, CELADON_HOME_DECOR_STORE_3F

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 0, 8, SIGNPOST_READ, CeladonHomeDecorStore4FDirectory

.PersonEvents:
	db 1
	person_event SPRITE_CLERK, 5, 9, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
