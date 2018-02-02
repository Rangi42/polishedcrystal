GoldenrodDeptStore1F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event  7,  7, GOLDENROD_CITY, 9
	warp_event  8,  7, GOLDENROD_CITY, 9
	warp_event 15,  0, GOLDENROD_DEPT_STORE_2F, 2
	warp_event  2,  0, GOLDENROD_DEPT_STORE_ELEVATOR, 1

	db 0 ; coord events

	db 1 ; bg events
	bg_event 14,  0, SIGNPOST_JUMPTEXT, GoldenrodDeptStore1FDirectoryText

	db 4 ; object events
	object_event 10,  1, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x55993, -1
	object_event  5,  4, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x55a1a, -1
	object_event  5,  5, SPRITE_CHILD, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x55a3a, -1
	object_event 11,  5, SPRITE_GENTLEMAN, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x559b7, -1

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
