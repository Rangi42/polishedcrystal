PalletTown_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_NEWMAP, PalletTownFlyPoint

PalletTown_MapEventHeader:

.Warps: db 3
	warp_def 5, 5, 1, REDS_HOUSE_1F
	warp_def 5, 13, 1, BLUES_HOUSE_1F
	warp_def 11, 12, 1, OAKS_LAB

.XYTriggers: db 0

.Signposts: db 4
	signpost 9, 7, SIGNPOST_JUMPTEXT, PalletTownSignText
	signpost 5, 3, SIGNPOST_JUMPTEXT, RedsHouseSignText
	signpost 13, 13, SIGNPOST_JUMPTEXT, OaksLabSignText
	signpost 5, 11, SIGNPOST_JUMPTEXT, BluesHouseSignText

.PersonEvents: db 3
	person_event SPRITE_TEACHER, 8, 3, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1ac6e7, -1
	person_event SPRITE_FISHER, 14, 12, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x1ac720, -1
	person_event SPRITE_YOUNGSTER, 7, 17, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, PalletTownYoungsterText, -1

PalletTownFlyPoint:
	setflag ENGINE_FLYPOINT_PALLET
	return

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
