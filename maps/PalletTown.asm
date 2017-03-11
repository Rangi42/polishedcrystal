const_value set 2
	const PALLETTOWN_TEACHER
	const PALLETTOWN_FISHER
	const PALLETTOWN_YOUNGSTER

PalletTown_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1

	; callbacks
	dbw MAPCALLBACK_NEWMAP, .FlyPoint

.FlyPoint:
	setflag ENGINE_FLYPOINT_PALLET
	return

TeacherScript_0x1ac6d5:
	jumptextfaceplayer UnknownText_0x1ac6e7

FisherScript_0x1ac6d8:
	jumptextfaceplayer UnknownText_0x1ac720

PalletTownYoungsterScript:
	jumptextfaceplayer PalletTownYoungsterText

PalletTownSign:
	jumptext PalletTownSignText

RedsHouseSign:
	jumptext RedsHouseSignText

OaksLabSign:
	jumptext OaksLabSignText

BluesHouseSign:
	jumptext BluesHouseSignText

UnknownText_0x1ac6e7:
	text "I'm raising #-"
	line "mon too."

	para "They serve as my"
	line "private guards."
	done

UnknownText_0x1ac720:
	text "Technology is"
	line "incredible!"

	para "You can now make"
	line "games just by"

	para "writing code in-"
	line "stead of editing"
	cont "binary data."
	done

PalletTownYoungsterText:
	text "Smell ya later!"

	para "…People started"
	line "saying that around"
	cont "here, but it's"

	para "kinda weird if you"
	line "think about it."
	done

PalletTownSignText:
	text "Pallet Town"

	para "A Tranquil Setting"
	line "of Peace & Purity"
	done

RedsHouseSignText:
	text "Red's House"
	done

OaksLabSignText:
	text "Oak #mon"
	line "Research Lab"
	done

BluesHouseSignText:
	text "Blue's House"
	done

PalletTown_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $5, $5, 1, REDS_HOUSE_1F
	warp_def $5, $d, 1, BLUES_HOUSE_1F
	warp_def $b, $c, 1, OAKS_LAB

.XYTriggers:
	db 0

.Signposts:
	db 4
	signpost 9, 7, SIGNPOST_READ, PalletTownSign
	signpost 5, 3, SIGNPOST_READ, RedsHouseSign
	signpost 13, 13, SIGNPOST_READ, OaksLabSign
	signpost 5, 11, SIGNPOST_READ, BluesHouseSign

.PersonEvents:
	db 3
	person_event SPRITE_TEACHER, 8, 3, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, 0, PERSONTYPE_SCRIPT, 0, TeacherScript_0x1ac6d5, -1
	person_event SPRITE_FISHER, 14, 12, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, FisherScript_0x1ac6d8, -1
	person_event SPRITE_YOUNGSTER, 7, 17, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, PalletTownYoungsterScript, -1
