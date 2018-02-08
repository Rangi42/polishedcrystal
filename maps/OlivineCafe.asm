OlivineCafe_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  4,  7, OLIVINE_CITY, 6
	warp_event  5,  7, OLIVINE_CITY, 6

	db 0 ; coord events

	db 0 ; bg events

	db 7 ; object events
	object_event  6,  2, SPRITE_BAKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BakerScript_0x9c8c1, -1
	object_event  4,  4, SPRITE_LYRA, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, OlivineCafeLyraScript, EVENT_GOT_AMULET_COIN_FROM_LYRA
	object_event  9,  3, SPRITE_FISHING_GURU, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9c9c5, -1
	object_event  9,  6, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x9ca09, -1
	object_event  7,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, (1 << MORN), 0, PERSONTYPE_COMMAND, jumptextfaceplayer, OlivineCafeOfficerText, -1
	object_event  7,  4, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, (1 << DAY), 0, PERSONTYPE_COMMAND, jumptextfaceplayer, OlivineCafeYoungsterText, -1
	object_event  3,  2, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, (1 << NITE), 0, PERSONTYPE_COMMAND, jumptextfaceplayer, OlivineCafeFisherText, -1

	const_def 1 ; object constants
	const OLIVINECAFE_BAKER
	const OLIVINECAFE_LYRA

BakerScript_0x9c8c1:
	faceplayer
	opentext
	checkevent EVENT_BEAT_BAKER_CHELSIE
	iftrue_jumpopenedtext BakerChelsieAfterText
	writetext BakerChelsieGreetingText
	yesorno
	iffalse_jumpopenedtext BakerChelsieNoBattleText
	writetext BakerChelsieSeenText
	waitbutton
	closetext
	winlosstext BakerChelsieBeatenText, 0
	setlasttalked OLIVINECAFE_BAKER
	loadtrainer BAKER, CHELSIE
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_BAKER_CHELSIE
	opentext
	thisopenedtext

BakerChelsieAfterText:
	text "I always add vita-"
	line "mins to my bread."

	para "They make my #-"
	line "mon stronger."
	done

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
	ifnotequal UP, .GoStraightDown
	applyonemovement OLIVINECAFE_LYRA, step_right
.GoStraightDown
	applymovement OLIVINECAFE_LYRA, OlivineCafeMovementData_LyraLeaves
	playsound SFX_EXIT_BUILDING
	disappear OLIVINECAFE_LYRA
	setevent EVENT_GOT_AMULET_COIN_FROM_LYRA
	waitsfx
.BagFull
	end

OlivineCafeMovementData_LyraLeaves:
	step_down
	step_down
	step_down
	step_end

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

BakerChelsieGreetingText:
	text "My Pokemon are on"
	line "the rise!"

	para "I raised them with"
	line "my special yeast"
	cont "bread!"

	para "Want to battle"
	line "them?"
	done

BakerChelsieSeenText:
	text "You'll see what my"
	line "bread can do!"
	done

BakerChelsieBeatenText:
	text "You are strong."
	line "Are you eating my"
	cont "special bread?"
	done

BakerChelsieNoBattleText:
	text "My bread-raised"
	line "#mon are un-"
	cont "beatable!"
	done

OlivineCafeLyraText1:
	text "Lyra: Hi, <PLAYER>!"
	line "You should try the"

	para "food here. It's"
	line "really good!"

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

OlivineCafeYoungsterText:
	text "These doughnuts"
	line "are great."

	para "Jelly-filled ones"
	line "are my favorite!"

	para "Nothing beats a"
	line "jelly-filled"
	cont "doughnut."
	done

OlivineCafeFisherText:
	text "I'd go for a run,"
	line "but I wouldn't"

	para "want to ruin my"
	line "physique."
	done
