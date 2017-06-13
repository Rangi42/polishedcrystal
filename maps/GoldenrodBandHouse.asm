const_value set 2
	const GOLDENRODBANDHOUSE_ROCKER1
	const GOLDENRODBANDHOUSE_ROCKER2
	const GOLDENRODBANDHOUSE_COOLTRAINER_F

GoldenrodBandHouse_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

GoldenrodBandHouseRocker1Script:
	jumptextfaceplayer GoldenrodBandHouseRocker1Text

GoldenrodBandHouseRocker2Script:
	jumptextfaceplayer GoldenrodBandHouseRocker2Text

GoldenrodBandHouseCooltrainerFScript:
	jumptextfaceplayer GoldenrodBandHouseCooltrainerFText

GoldenrodBandHouseRocker1Text:
	text "I play guitar in"
	line "our cover band."

	para "Give us a listen"
	line "on the Variety"
	cont "Channel!"
	done

GoldenrodBandHouseRocker2Text:
	text "Music and passion"
	line "are always in"

	para "fashion. Don't"
	line "you forget it!"
	done

GoldenrodBandHouseCooltrainerFText:
	text "People like diff-"
	line "erent types of"
	cont "music, but every-"

	para "one's entitled to"
	line "their own opinion."

	para "Don't be a hater!"
	done

GoldenrodBandHouse_MapEventHeader:
.Warps:
	db 2
	warp_def $7, $2, 20, GOLDENROD_CITY
	warp_def $7, $3, 20, GOLDENROD_CITY

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 3
	person_event SPRITE_ROCKER, 3, 1, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, GoldenrodBandHouseRocker1Script, -1
	person_event SPRITE_ROCKER, 4, 6, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, GoldenrodBandHouseRocker2Script, -1
	person_event SPRITE_COOLTRAINER_F, 4, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, GoldenrodBandHouseCooltrainerFScript, -1
