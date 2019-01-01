CeladonDeptStore6F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event 15,  0, CELADON_DEPT_STORE_5F, 2
	warp_event  2,  0, CELADON_DEPT_STORE_ELEVATOR, 1

	db 0 ; coord events

	db 1 ; bg events
	bg_event 14,  0, SIGNPOST_JUMPTEXT, CeladonDeptStore6FDirectoryText

	db 4 ; object events
	object_event  9,  2, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x712c7, -1
	object_event 12,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 1, 2, -1, -1, PAL_NPC_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x71310, -1
	object_event  5,  1, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, GameboyKidScript_0x70d34, -1
	object_event  6,  1, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, GameboyKidScript_0x70d3f, -1

GameboyKidScript_0x70d34:
	showtextfaceplayer UnknownText_0x70d86
	turnobject LAST_TALKED, DOWN
	end

GameboyKidScript_0x70d3f:
	showtextfaceplayer UnknownText_0x70dc7
	turnobject LAST_TALKED, DOWN
	end

UnknownText_0x712c7:
	text "A vending machine"
	line "with a prize rou-"
	cont "lette…"

	para "You never see"
	line "those anymore."
	done

UnknownText_0x71310:
	text "I can play games"
	line "on the third"
	cont "floor, then come"

	para "here when I get"
	line "thirsty!"

	para "This store is"
	line "great!"
	done

UnknownText_0x70d86:
	text "I traded my"
	line "#mon while"

	para "it was holding"
	line "an Up-Grade."
	done

UnknownText_0x70dc7:
	text "Yeah! I'm finally"
	line "getting a Porygon!"

	para "I'm no good at the"
	line "slots, so I could"

	para "never get enough"
	line "coins…"

	para "I'll raise it with"
	line "an Up-Grade to"
	cont "make it evolve!"
	done

CeladonDeptStore6FDirectoryText:
	text "6F: Rooftop Atrium"
	line "Vending Machines"
	done
