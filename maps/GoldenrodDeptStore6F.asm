GoldenrodDeptStore6F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

GoldenrodDeptStore6F_MapEventHeader:

.Warps: db 3
	warp_def $0, $f, 2, GOLDENROD_DEPT_STORE_5F
	warp_def $0, $2, 1, GOLDENROD_DEPT_STORE_ELEVATOR
	warp_def $0, $d, 1, GOLDENROD_DEPT_STORE_ROOF

.XYTriggers: db 0

.Signposts: db 2
	signpost 0, 14, SIGNPOST_JUMPTEXT, GoldenrodDeptStore6FDirectoryText
	signpost 0, 3, SIGNPOST_JUMPSTD, elevatorbutton

.PersonEvents: db 2
	person_event SPRITE_LASS, 2, 10, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_JUMPTEXTFP, 0, UnknownText_0x5654b, -1
	person_event SPRITE_SUPER_NERD, 2, 8, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_JUMPTEXTFP, 0, UnknownText_0x565ca, -1

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
