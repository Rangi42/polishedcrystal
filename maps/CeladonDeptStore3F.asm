const_value set 2
	const CELADONDEPTSTORE3F_CLERK1
	const CELADONDEPTSTORE3F_CLERK2
	const CELADONDEPTSTORE3F_YOUNGSTER
	const CELADONDEPTSTORE3F_SUPER_NERD
	const CELADONDEPTSTORE3F_CLERK3

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

SuperNerdScript_0x70d4a:
	jumptextfaceplayer UnknownText_0x70e61

CeladonDeptStore3FElevatorButton:
	jumpstd elevatorbutton

CeladonDeptStore3FDirectory:
	jumptext CeladonDeptStore3FDirectoryText

CeladonDeptStore3FN64:
	jumptext CeladonDeptStore3FN64Text

CeladonDeptStore3FWii:
	jumptext CeladonDeptStore3FWiiText

CeladonDeptStore3FRPG:
	jumptext CeladonDeptStore3FRPGText

CeladonDeptStore3FSportsGame:
	jumptext CeladonDeptStore3FSportsGameText

CeladonDeptStore3FPuzzleGame:
	jumptext CeladonDeptStore3FPuzzleGameText

CeladonDeptStore3FFightingGame:
	jumptext CeladonDeptStore3FFightingGameText

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

	para "Good thing it"
	line "doesn't run out."
	done

UnknownText_0x70e61:
	text "The Tech Shop"
	line "sells some cool"
	cont "game systems."
	done

VideoGameClerkText:
	text "TODO: sell games"
	done

CeladonDeptStore3FDirectoryText:
	text "Make Your #mon"
	line "Stronger!"

	para "3F: Tech Shop"
	done

CeladonDeptStore3FN64Text:
	text "It's an N64!"
	done

CeladonDeptStore3FWiiText:
	text "It's a Wii!"
	done

CeladonDeptStore3FRPGText:
	text "An RPG! There's"
	line "no time for that!"
	done

CeladonDeptStore3FSportsGameText:
	text "A sports game!"
	line "Dad'll like that!"
	done

CeladonDeptStore3FPuzzleGameText:
	text "A puzzle game!"
	line "Looks addictive!"
	done

CeladonDeptStore3FFightingGameText:
	text "A fighting game!"
	line "Looks tough!"
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
	db 10
	signpost 0, 14, SIGNPOST_READ, CeladonDeptStore3FDirectory
	signpost 0, 3, SIGNPOST_READ, CeladonDeptStore3FElevatorButton
	signpost 3, 1, SIGNPOST_READ, CeladonDeptStore3FN64
	signpost 5, 1, SIGNPOST_READ, CeladonDeptStore3FN64
	signpost 3, 4, SIGNPOST_READ, CeladonDeptStore3FWii
	signpost 5, 4, SIGNPOST_READ, CeladonDeptStore3FWii
	signpost 3, 2, SIGNPOST_READ, CeladonDeptStore3FRPG
	signpost 3, 5, SIGNPOST_READ, CeladonDeptStore3FSportsGame
	signpost 5, 2, SIGNPOST_READ, CeladonDeptStore3FPuzzleGame
	signpost 5, 5, SIGNPOST_READ, CeladonDeptStore3FFightingGame

.PersonEvents:
	db 9
	person_event SPRITE_CLERK, 1, 9, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ClerkScript_0x70d29, -1
	person_event SPRITE_CLERK, 1, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CeladonDeptStore3FClerk2Script, -1
	person_event SPRITE_YOUNGSTER, 5, 7, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, YoungsterScript_0x70d31, -1
	person_event SPRITE_SUPER_NERD, 4, 13, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, SuperNerdScript_0x70d4a, -1
	person_event SPRITE_CLERK, 3, 0, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, VideoGameClerkScript, -1
	person_event SPRITE_FAMICOM, 3, 1, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, (1 << 3) | 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	person_event SPRITE_SNES, 5, 1, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, (1 << 3) | 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	person_event SPRITE_VIRTUAL_BOY, 3, 4, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, (1 << 3) | 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	person_event SPRITE_N64, 5, 4, SPRITEMOVEDATA_ITEM_TREE, 0, 0, -1, -1, (1 << 3) | 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
