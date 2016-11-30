const_value set 2
	const VIRIDIANSCHOOLHOUSE_TEACHER
	const VIRIDIANSCHOOLHOUSE_LASS

ViridianSchoolHouse_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

ViridianSchoolHouseTeacherScript:
	jumptextfaceplayer ViridianSchoolHouseTeacherText

ViridianSchoolHouseLassScript:
	jumptextfaceplayer ViridianSchoolHouseLassText

ViridianSchoolHouseBlackboardScript:
	jumptext ViridianSchoolHouseBlackboardText

ViridianSchoolHouseNotesScript:
	jumptext ViridianSchoolHouseNotesText

ViridianSchoolHouseTeacherText:
	text "I know this is a"
	line "lot of material,"

	para "but please pay"
	line "attention!"
	done

ViridianSchoolHouseLassText:
	text "Wait! I thought"
	line "that, like, all"

	para "Fire-type moves"
	line "were special?"
	done

ViridianSchoolHouseBlackboardText:
	text "Physical moves use"
	line "the Attack and"
	cont "Defense stats."

	para "Special moves use"
	line "the Spcl.Atk and"
	cont "Spcl.Def stats."

	para "Status moves are"
	line "not damaging."
	done

ViridianSchoolHouseNotesText:
	text "There's a doodle"
	line "of a maze."
	done

ViridianSchoolHouse_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $2, 8, VIRIDIAN_CITY
	warp_def $7, $3, 8, VIRIDIAN_CITY

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 0, 3, SIGNPOST_READ, ViridianSchoolHouseBlackboardScript
	signpost 4, 3, SIGNPOST_READ, ViridianSchoolHouseNotesScript

.PersonEvents:
	db 2
	person_event SPRITE_TEACHER, 1, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ViridianSchoolHouseTeacherScript, -1
	person_event SPRITE_LASS, 5, 3, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, ViridianSchoolHouseLassScript, -1
