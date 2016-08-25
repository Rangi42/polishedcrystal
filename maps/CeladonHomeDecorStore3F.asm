const_value set 2
	const CELADONHOMEDECORSTORE3F_CLERK
	const CELADONHOMEDECORSTORE3F_YOUNGSTER
	const CELADONHOMEDECORSTORE3F_BUENA

CeladonHomeDecorStore3F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonHomeDecorStore3FYoungsterScript:
	jumptextfaceplayer CeladonHomeDecorStore3FYoungsterText

CeladonHomeDecorStore3FBeautyScript:
	jumptextfaceplayer CeladonHomeDecorStore3FBeautyText

CeladonHomeDecorStore3FDirectory:
	jumptext CeladonHomeDecorStore3FDirectoryText

CeladonHomeDecorStore3FYoungsterText:
	text "This carpet feels"
	line "so plush!"
	done

CeladonHomeDecorStore3FBeautyText:
	text "Some of these"
	line "carpets are im-"
	cont "ported from Kalos!"
	done

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
	db 3
	person_event SPRITE_CLERK, 7, 7, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	person_event SPRITE_YOUNGSTER, 5, 3, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, CeladonHomeDecorStore3FYoungsterScript, -1
	person_event SPRITE_BUENA, 3, 9, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeladonHomeDecorStore3FBeautyScript, -1
