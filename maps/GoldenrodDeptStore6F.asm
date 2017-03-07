const_value set 2
	const GOLDENRODDEPTSTORE6F_LASS
	const GOLDENRODDEPTSTORE6F_SUPER_NERD

GoldenrodDeptStore6F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

GoldenrodVendingMachine:
	jumpstd vendingmachine

LassScript_0x564bf:
	jumptextfaceplayer UnknownText_0x5654b

SuperNerdScript_0x564c2:
	jumptextfaceplayer UnknownText_0x565ca

GoldenrodDeptStore6FDirectory:
	jumptext GoldenrodDeptStore6FDirectoryText

GoldenrodDeptStore6FElevatorButton:
	jumpstd elevatorbutton

UnknownText_0x5654b:
	text "Do you listen to"
	line "Lucky Channel?"

	para "If you want to"
	line "win, trade #mon"

	para "with as many peo-"
	line "ple as possible to"

	para "get different ID"
	line "numbers."
	done

UnknownText_0x565ca:
	text "If you're tired,"
	line "try the vending"
	cont "machine's drinks."

	para "Your #mon will"
	line "love them too."
	done

GoldenrodDeptStore6FDirectoryText:
	text "Take a Break from"
	line "Shopping!"

	para "6F Tranquil Square"
	done

GoldenrodDeptStore6F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $0, $f, 2, GOLDENROD_DEPT_STORE_5F
	warp_def $0, $2, 1, GOLDENROD_DEPT_STORE_ELEVATOR
	warp_def $0, $d, 1, GOLDENROD_DEPT_STORE_ROOF

.XYTriggers:
	db 0

.Signposts:
	db 6
	signpost 0, 14, SIGNPOST_READ, GoldenrodDeptStore6FDirectory
	signpost 0, 3, SIGNPOST_READ, GoldenrodDeptStore6FElevatorButton
	signpost 1, 8, SIGNPOST_UP, GoldenrodVendingMachine
	signpost 1, 9, SIGNPOST_UP, GoldenrodVendingMachine
	signpost 1, 10, SIGNPOST_UP, GoldenrodVendingMachine
	signpost 1, 11, SIGNPOST_UP, GoldenrodVendingMachine

.PersonEvents:
	db 2
	person_event SPRITE_LASS, 2, 10, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, LassScript_0x564bf, -1
	person_event SPRITE_SUPER_NERD, 2, 8, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, SuperNerdScript_0x564c2, -1
