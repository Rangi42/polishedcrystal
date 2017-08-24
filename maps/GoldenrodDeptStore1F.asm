GoldenrodDeptStore1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

GoldenrodDeptStore1F_MapEventHeader:

.Warps: db 4
	warp_def 7, 7, 9, GOLDENROD_CITY
	warp_def 7, 8, 9, GOLDENROD_CITY
	warp_def 0, 15, 2, GOLDENROD_DEPT_STORE_2F
	warp_def 0, 2, 1, GOLDENROD_DEPT_STORE_ELEVATOR

.XYTriggers: db 0

.Signposts: db 1
	signpost 0, 14, SIGNPOST_JUMPTEXT, GoldenrodDeptStore1FDirectoryText

.PersonEvents: db 4
	person_event SPRITE_RECEPTIONIST, 1, 10, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x55993, -1
	person_event SPRITE_POKEFAN_F, 4, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x55a1a, -1
	person_event SPRITE_CHILD, 5, 5, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x55a3a, -1
	person_event SPRITE_GENTLEMAN, 5, 11, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x559b7, -1

UnknownText_0x55993:
	text "Welcome to Golden-"
	line "rod Dept.Store."
	done

UnknownText_0x559b7:
	text "The Dept.Store"
	line "has a decent se-"
	cont "lection."

	para "But some items"
	line "are only available"

	para "as Game Corner"
	line "prizes."
	done

UnknownText_0x55a1a:
	text "I'm raring to shop"
	line "again today!"
	done

UnknownText_0x55a3a:
	text "Mom's good at"
	line "bargain hunting."

	para "She always buys"
	line "stuff at lower"
	cont "prices."
	done

GoldenrodDeptStore1FDirectoryText:
	text "1F Service Counter"

	para "2F Trainer's"
	line "   Market"

	para "3F Battle"
	line "   Collection"

	para "4F Medicine Box"

	para "5F TM Corner"

	para "6F Tranquil Square"

	para "Rooftop Lookout"
	done
