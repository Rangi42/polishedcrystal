const_value set 2
	const WILLSROOM_WILL

WillsRoom_MapScriptHeader:
.MapTriggers:
	db 2
	dw UnknownScript_0x1804c6
	dw UnknownScript_0x1804ca

.MapCallbacks:
	db 1
	dbw MAPCALLBACK_TILES, UnknownScript_0x1804cb

UnknownScript_0x1804c6:
	priorityjump UnknownScript_0x1804e0
	end

UnknownScript_0x1804ca:
	end

UnknownScript_0x1804cb:
	checkevent EVENT_WILLS_ROOM_ENTRANCE_CLOSED
	iffalse UnknownScript_0x1804d5
	changeblock $4, $e, $2a
UnknownScript_0x1804d5:
	checkevent EVENT_WILLS_ROOM_EXIT_OPEN
	iffalse UnknownScript_0x1804df
	changeblock $4, $2, $16
UnknownScript_0x1804df:
	return

UnknownScript_0x1804e0:
	applymovement PLAYER, MovementData_0x18052c
	refreshscreen $86
	playsound SFX_STRENGTH
	earthquake 80
	changeblock $4, $e, $2a
	reloadmappart
	closetext
	dotrigger $1
	setevent EVENT_WILLS_ROOM_ENTRANCE_CLOSED
	waitsfx
	end

WillScript_0x1804f8:
	faceplayer
	checkcode VAR_BADGES
	if_equal 16, WillRematchScript
	checkevent EVENT_BEAT_ELITE_4_WILL
	iftrue UnknownScript_0x180526
	opentext
	writetext UnknownText_0x180531
	waitbutton
	closetext
	winlosstext UnknownText_0x18062c, 0
	loadtrainer WILL, 1
	startbattle
	reloadmapafterbattle
	scall UnknownScript_0x180526
	jump WillEndBattleScript

UnknownScript_0x180526:
	opentext
	writetext UnknownText_0x180644
	waitbutton
	closetext
	end

WillRematchScript:
	checkevent EVENT_BEAT_ELITE_4_WILL
	iftrue .AfterBattle
	opentext
	writetext WillBeforeRematchText
	waitbutton
	closetext
	winlosstext UnknownText_0x18062c, 0
	loadtrainer WILL, 2
	startbattle
	reloadmapafterbattle
	scall .AfterBattle
	jump WillEndBattleScript

.AfterBattle:
	opentext
	writetext WillAfterRematchText
	waitbutton
	closetext
	end

WillEndBattleScript:
	playsound SFX_ENTER_DOOR
	changeblock $4, $2, $16
	reloadmappart
	setevent EVENT_WILLS_ROOM_EXIT_OPEN
	setevent EVENT_BEAT_ELITE_4_WILL
	waitsfx
	end

MovementData_0x18052c:
	step_up
	step_up
	step_up
	step_up
	step_end

UnknownText_0x180531:
	text "Welcome to the"
	line "#mon League,"
	cont "<PLAYER>."

	para "Allow me to intro-"
	line "duce myself. I am"
	cont "Will."

	para "I have trained all"
	line "around the world,"

	para "making my Psychic"
	line "#mon powerful."

	para "And, at last, I've"
	line "been accepted into"
	cont "the Elite Four."

	para "I can only keep"
	line "getting better!"

	para "Losing is not an"
	line "option!"
	done

UnknownText_0x18062c:
	text "I… I can't…"
	line "believe it…"
	done

UnknownText_0x180644:
	text "Even though I was"
	line "defeated, I won't"
	cont "change my course."

	para "I will continue"
	line "battling until I"

	para "stand above all"
	line "trainers!"

	para "Now, <PLAYER>, move"
	line "on and experience"

	para "the true ferocity"
	line "of the Elite Four."
	done

WillBeforeRematchText:
	text "So, you have"
	line "finally appeared."

	para "I have observed"
	line "your battle"
	cont "techniques."

	para "I'm ready for you!"

	para "All right."

	para "Prepare for"
	line "battle!"
	done

WillAfterRematchText:
	text "I've expended all"
	line "my power."

	para "I have no regrets"
	line "about losing"
	cont "this way."
	done

WillsRoom_MapEventHeader:
.Warps:
	db 3
	warp_def $11, $5, 4, INDIGO_PLATEAU_POKECENTER_1F
	warp_def $2, $4, 1, KOGAS_ROOM
	warp_def $2, $5, 2, KOGAS_ROOM

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 1
	person_event SPRITE_WILL, 7, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, WillScript_0x1804f8, -1
