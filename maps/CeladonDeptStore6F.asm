CeladonDeptStore6F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeladonDeptStore6F_MapEventHeader:

.Warps: db 2
	warp_def 0, 15, 2, CELADON_DEPT_STORE_5F
	warp_def 0, 2, 1, CELADON_DEPT_STORE_ELEVATOR

.XYTriggers: db 0

.Signposts: db 1
	signpost 0, 14, SIGNPOST_JUMPTEXT, CeladonDeptStore6FDirectoryText

.PersonEvents: db 4
	person_event SPRITE_SUPER_NERD, 2, 9, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x712c7, -1
	person_event SPRITE_YOUNGSTER, 5, 12, SPRITEMOVEDATA_WANDER, 1, 2, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x71310, -1
	person_event SPRITE_GAMEBOY_KID, 1, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, GameboyKidScript_0x70d34, -1
	person_event SPRITE_GAMEBOY_KID, 1, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, GameboyKidScript_0x70d3f, -1

GameboyKidScript_0x70d34:
	showtextfaceplayer UnknownText_0x70d86
	spriteface LAST_TALKED, DOWN
	end

GameboyKidScript_0x70d3f:
	showtextfaceplayer UnknownText_0x70dc7
	spriteface LAST_TALKED, DOWN
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
