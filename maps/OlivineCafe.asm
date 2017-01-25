const_value set 2
	const OLIVINECAFE_SAILOR1
	const OLIVINECAFE_FISHING_GURU
	const OLIVINECAFE_SAILOR2
	const OLIVINECAFE_LYRA
	const OLIVINECAFE_OFFICER

OlivineCafe_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

SailorScript_0x9c8c1:
	faceplayer
	opentext
	checkevent EVENT_GOT_HM04_STRENGTH
	iftrue UnknownScript_0x9c8d3
	writetext UnknownText_0x9c8df
	buttonsound
	verbosegivetmhm HM_STRENGTH
	setevent EVENT_GOT_HM04_STRENGTH
UnknownScript_0x9c8d3:
	writetext UnknownText_0x9c965
	waitbutton
	closetext
	end

OlivineCafeLyraScript:
	faceplayer
	opentext
	writetext OlivineCafeLyraText1
	buttonsound
	verbosegiveitem AMULET_COIN
	iffalse .BagFull
	writetext OlivineCafeLyraText2
	waitbutton
	closetext
	checkcode VAR_FACING
	if_not_equal UP, .GoStraightDown
	applymovement OLIVINECAFE_LYRA, OlivineCafeMovementData_Lyra1
.GoStraightDown
	applymovement OLIVINECAFE_LYRA, OlivineCafeMovementData_Lyra2
	playsound SFX_EXIT_BUILDING
	disappear OLIVINECAFE_LYRA
	setevent EVENT_GOT_AMULET_COIN_FROM_LYRA
	waitsfx
.BagFull
	end

FishingGuruScript_0x9c8d9:
	jumptextfaceplayer UnknownText_0x9c9c5

SailorScript_0x9c8dc:
	jumptextfaceplayer UnknownText_0x9ca09

OlivineCafeOfficerScript:
	jumptextfaceplayer OlivineCafeOfficerText

OlivineCafeMovementData_Lyra1:
	step_right
	step_end

OlivineCafeMovementData_Lyra2:
	step_down
	step_down
	step_down
	step_end

UnknownText_0x9c8df:
	text "Hah! Your #mon"
	line "sure look like"
	cont "lightweights!"

	para "They don't have"
	line "the power to move"
	cont "boulders aside."

	para "Here, use this"
	line "and teach them"
	cont "Strength!"
	done

UnknownText_0x9c965:
	text "On the sea, the"
	line "only thing you can"

	para "count on is your"
	line "own good self!"

	para "I'm so proud of my"
	line "buff bod!"
	done

UnknownText_0x9c9c5:
	text "Olivine Café's"
	line "menu is chock full"

	para "of hearty fare for"
	line "beefy sailors!"
	done

UnknownText_0x9ca09:
	text "Whenever I roll"
	line "into this town, I"

	para "always visit the"
	line "Olivine Café."

	para "Everything on the"
	line "menu makes me feel"

	para "stronger. I can't"
	line "stop eating!"
	done

OlivineCafeLyraText1:
	text "Lyra: Hi, <PLAYER>!"
	line "You should try the"

	para "food here. It's"
	line "really good!"

	para "I always come"
	line "here when I visit"
	cont "Olivine."

	para "Although I don't"
	line "want to eat too"
	cont "much…"

	para "Oh, that's right!"
	line "I found an item"

	para "that you might"
	line "like. Here!"
	done

OlivineCafeLyraText2:
	text "Isn't it pretty?"
	line "And useful, too."

	para "Well, I should"
	line "get going."

	para "I want to see the"
	line "Yellow Forest in"

	para "Cianwood before I"
	line "go back home."

	para "See you,"
	line "<PLAYER>!"
	done

OlivineCafeOfficerText:
	text "I know it's cli-"
	line "ché, but I always"

	para "come to this place"
	line "for doughnuts."

	para "I can't get enough!"
	done

OlivineCafe_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $2, 6, OLIVINE_CITY
	warp_def $7, $3, 6, OLIVINE_CITY

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 5
	person_event SPRITE_SAILOR, 2, 4, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SailorScript_0x9c8c1, -1
	person_event SPRITE_FISHING_GURU, 3, 7, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, FishingGuruScript_0x9c8d9, -1
	person_event SPRITE_SAILOR, 6, 7, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SailorScript_0x9c8dc, -1
	person_event SPRITE_LYRA, 4, 2, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, OlivineCafeLyraScript, EVENT_GOT_AMULET_COIN_FROM_LYRA
	person_event SPRITE_OFFICER, 5, 5, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, (1 << MORN), 0, PERSONTYPE_SCRIPT, 0, OlivineCafeOfficerScript, -1
