const_value set 2
	const CELADONDEPTSTORE3F_CLERK1
	const CELADONDEPTSTORE3F_CLERK2
	const CELADONDEPTSTORE3F_YOUNGSTER
	const CELADONDEPTSTORE3F_GAMEBOY_KID1
	const CELADONDEPTSTORE3F_GAMEBOY_KID2
	const CELADONDEPTSTORE3F_SUPER_NERD

CeladonDeptStore3F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

ClerkScript_0x70d29:
	faceplayer
	opentext
	pokemart MARTTYPE_STANDARD, MART_CELADON_3F
	closetext
	end

CeladonDeptStore3FClerk2Script:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_COUNTER_INTRO
	iftrue CeladonDeptStore3FTutorCounterScript
	writetext CeladonDeptStore3FClerk2Text
	waitbutton
	setevent EVENT_LISTENED_TO_COUNTER_INTRO
CeladonDeptStore3FTutorCounterScript:
	writetext Text_CeladonDeptStore3FTutorCounter
	waitbutton
	checkitem SILVER_LEAF
	iffalse .NoSilverLeaf
	writetext Text_CeladonDeptStore3FTutorQuestion
	yesorno
	iffalse .TutorRefused
	writebyte COUNTER
	writetext Text_CeladonDeptStore3FTutorClear
	special Special_MoveTutor
	if_equal $0, .TeachMove
.TutorRefused
	writetext Text_CeladonDeptStore3FTutorRefused
	waitbutton
	closetext
	end

.NoSilverLeaf
	writetext Text_CeladonDeptStore3FTutorNoSilverLeaf
	waitbutton
	closetext
	end

.TeachMove
	takeitem SILVER_LEAF
	writetext Text_CeladonDeptStore3FTutorTaught
	waitbutton
	closetext
	end

YoungsterScript_0x70d31:
	jumptextfaceplayer UnknownText_0x70d53

GameboyKidScript_0x70d34:
	faceplayer
	opentext
	writetext UnknownText_0x70d86
	waitbutton
	closetext
	spriteface CELADONDEPTSTORE3F_GAMEBOY_KID1, DOWN
	end

GameboyKidScript_0x70d3f:
	faceplayer
	opentext
	writetext UnknownText_0x70dc7
	waitbutton
	closetext
	spriteface CELADONDEPTSTORE3F_GAMEBOY_KID2, DOWN
	end

SuperNerdScript_0x70d4a:
	jumptextfaceplayer UnknownText_0x70e61

CeladonDeptStore3FElevatorButton:
	jumpstd elevatorbutton

CeladonDeptStore3FDirectory:
	jumptext CeladonDeptStore3FDirectoryText

CeladonDeptStore3FClerk2Text:
	text "There's a neat move"
	line "called Counter."

	para "Not the kind of"
	line "counter I'm leaning"
	cont "on, mind you!"
	done

Text_CeladonDeptStore3FTutorCounter:
	text "I'll teach your"
	line "#mon how to use"

	para "Counter if you pay"
	line "me a Silver Leaf."
	done

Text_CeladonDeptStore3FTutorNoSilverLeaf:
	text "You don't have a"
	line "Silver Leaf…"
	done

Text_CeladonDeptStore3FTutorQuestion:
	text "Should I teach"
	line "your #mon"
	cont "Counter?"
	done

Text_CeladonDeptStore3FTutorRefused:
	text "Never mind."
	done

Text_CeladonDeptStore3FTutorClear:
	text ""
	done

Text_CeladonDeptStore3FTutorTaught:
	text "Now your #mon"
	line "knows Counter."
	done

UnknownText_0x70d53:
	text "I can't decide"
	line "which #mon I"

	para "should use this TM"
	line "on…"
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

UnknownText_0x70e61:
	text "The TM Shop sells"
	line "some rare moves."
	done

CeladonDeptStore3FDirectoryText:
	text "3F: TM Shop"

	para "Make Your #mon"
	line "Stronger!"
	done

CeladonDeptStore3F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $0, $c, 1, CELADON_DEPT_STORE_2F
	warp_def $0, $f, 2, CELADON_DEPT_STORE_4F
	warp_def $0, $2, 1, CELADON_DEPT_STORE_ELEVATOR

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 0, 14, SIGNPOST_READ, CeladonDeptStore3FDirectory
	signpost 0, 3, SIGNPOST_READ, CeladonDeptStore3FElevatorButton

.PersonEvents:
	db 6
	person_event SPRITE_CLERK, 1, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ClerkScript_0x70d29, -1
	person_event SPRITE_CLERK, 1, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeladonDeptStore3FClerk2Script, -1
	person_event SPRITE_YOUNGSTER, 4, 6, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, YoungsterScript_0x70d31, -1
	person_event SPRITE_GAMEBOY_KID, 1, 9, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, GameboyKidScript_0x70d34, -1
	person_event SPRITE_GAMEBOY_KID, 1, 10, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, GameboyKidScript_0x70d3f, -1
	person_event SPRITE_SUPER_NERD, 4, 13, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, SuperNerdScript_0x70d4a, -1
