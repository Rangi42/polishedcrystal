CopycatsHouse2F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_OBJECTS, CopycatsHouse2FCallback

CopycatsHouse2F_MapEventHeader:

.Warps: db 1
	warp_def $0, $3, 3, COPYCATS_HOUSE_1F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 6
	person_event SPRITE_COPYCAT, 3, 4, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, Copycat, EVENT_COPYCAT_1
	person_event SPRITE_COPYCAT, 3, 4, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Copycat, EVENT_COPYCAT_2
	person_event SPRITE_DODRIO, 4, 6, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, CopycatsDodrio, -1
	person_event SPRITE_CLEFAIRY, 1, 6, SPRITEMOVEDATA_DOLL, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CopycatsHouse2FDoll, EVENT_COPYCATS_HOUSE_2F_DOLL
	person_event SPRITE_GENGAR, 1, 2, SPRITEMOVEDATA_DOLL, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, CopycatsHouse2FDoll, -1
	person_event SPRITE_MURKROW, 1, 7, SPRITEMOVEDATA_DOLL, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CopycatsHouse2FDoll, -1

const_value set 2
	const COPYCATSHOUSE2F_COPYCAT1
	const COPYCATSHOUSE2F_COPYCAT2

CopycatsHouse2FCallback:
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .Part1
	disappear COPYCATSHOUSE2F_COPYCAT2
	appear COPYCATSHOUSE2F_COPYCAT1
	jump .Done
.Part1:
	disappear COPYCATSHOUSE2F_COPYCAT1
	appear COPYCATSHOUSE2F_COPYCAT2
.Done:
	return

Copycat:
	faceplayer
	checkevent EVENT_GOT_PASS_FROM_COPYCAT
	iftrue .Part15
	checkevent EVENT_RETURNED_LOST_ITEM_TO_COPYCAT
	iftrue .Part13
	checkitem LOST_ITEM
	iftrue .Part12
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .Part1
	applymovement COPYCATSHOUSE2F_COPYCAT1, MovementData_0x18afd0
	faceplayer
	variablesprite SPRITE_COPYCAT, SPRITE_CHRIS
	jump .Part2

.Part1:
	applymovement COPYCATSHOUSE2F_COPYCAT2, MovementData_0x18afd0
	faceplayer
	variablesprite SPRITE_COPYCAT, SPRITE_KRIS
.Part2:
	special MapCallbackSprites_LoadUsedSpritesGFX
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .Part7
	opentext
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .Part3
	writetext UnknownText_0x18afda
	jump .Part4

.Part3:
	writetext UnknownText_0x18b316
.Part4:
	waitbutton
	closetext
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .Part5
	applymovement COPYCATSHOUSE2F_COPYCAT1, MovementData_0x18afd0
	jump .Part6

.Part5:
	applymovement COPYCATSHOUSE2F_COPYCAT2, MovementData_0x18afd0
.Part6:
	faceplayer
	variablesprite SPRITE_COPYCAT, SPRITE_LASS
	special MapCallbackSprites_LoadUsedSpritesGFX
	jumptext UnknownText_0x18b028

.Part7:
	opentext
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .Part8
	writetext UnknownText_0x18b064
	jump .Part9

.Part8:
	writetext UnknownText_0x18b366
.Part9:
	waitbutton
	closetext
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .Part10
	applymovement COPYCATSHOUSE2F_COPYCAT1, MovementData_0x18afd0
	jump .Part11

.Part10:
	applymovement COPYCATSHOUSE2F_COPYCAT2, MovementData_0x18afd0
.Part11:
	faceplayer
	variablesprite SPRITE_COPYCAT, SPRITE_LASS
	special MapCallbackSprites_LoadUsedSpritesGFX
	showtext UnknownText_0x18b116
	setevent EVENT_MET_COPYCAT_FOUND_OUT_ABOUT_LOST_ITEM
	end

.Part12:
	opentext
	writetext UnknownText_0x18b17f
	buttonsound
	takeitem LOST_ITEM
	setevent EVENT_RETURNED_LOST_ITEM_TO_COPYCAT
	clearevent EVENT_COPYCATS_HOUSE_2F_DOLL
	jump .Part14

.Part13:
	opentext
.Part14:
	writetext UnknownText_0x18b1e2
	buttonsound
	verbosegiveitem PASS
	iffalse .Part22
	setevent EVENT_GOT_PASS_FROM_COPYCAT
	jumpopenedtext UnknownText_0x18b214

.Part15:
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .Part16
	applymovement COPYCATSHOUSE2F_COPYCAT1, MovementData_0x18afd0
	faceplayer
	variablesprite SPRITE_COPYCAT, SPRITE_CHRIS
	jump .Part17

.Part16:
	applymovement COPYCATSHOUSE2F_COPYCAT2, MovementData_0x18afd0
	faceplayer
	variablesprite SPRITE_COPYCAT, SPRITE_KRIS
.Part17:
	special MapCallbackSprites_LoadUsedSpritesGFX
	opentext
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .Part18
	writetext UnknownText_0x18b298
	jump .Part19

.Part18:
	writetext UnknownText_0x18b415
.Part19:
	waitbutton
	closetext
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .Part20
	applymovement COPYCATSHOUSE2F_COPYCAT1, MovementData_0x18afd0
	jump .Part21

.Part20:
	applymovement COPYCATSHOUSE2F_COPYCAT2, MovementData_0x18afd0
.Part21:
	faceplayer
	variablesprite SPRITE_COPYCAT, SPRITE_LASS
	special MapCallbackSprites_LoadUsedSpritesGFX
	opentext
	writetext UnknownText_0x18b2f5
	waitbutton
.Part22:
	closetext
	end

CopycatsDodrio:
	opentext
	writetext CopycatsDodrioText1
	cry DODRIO
	buttonsound
	jumpopenedtext CopycatsDodrioText2

CopycatsHouse2FDoll:
	jumptext CopycatsHouse2FDollText

MovementData_0x18afd0:
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	turn_head_down
	step_end

UnknownText_0x18afda:
	text "<PLAYER>: Hi! Do"
	line "you like #mon?"

	para "<PLAYER>: Uh, no, I"
	line "just asked you."

	para "<PLAYER>: Huh?"
	line "You're strange!"
	done

UnknownText_0x18b028:
	text "Copycat: Hmm?"
	line "Quit mimicking?"

	para "But that's my"
	line "favorite hobby!"
	done

UnknownText_0x18b064:
	text "<PLAYER>: Hi!"
	line "I heard that you"

	para "lost your favorite"
	line "# Doll."

	para "<PLAYER>: If I find"
	line "it, you'll give me"
	cont "a rail pass?"

	para "<PLAYER>: I'll go"
	line "find it for you."

	para "You think you lost"
	line "it when you went"
	cont "to Vermilion City?"
	done

UnknownText_0x18b116:
	text "Copycat: Pardon?"

	para "I shouldn't decide"
	line "what you should"
	cont "do?"

	para "But I'm really"
	line "worried… What if"
	cont "someone finds it?"
	done

UnknownText_0x18b17f:
	text "Copycat: Yay!"
	line "That's my Clefairy"
	cont "# Doll!"

	para "See the tear where"
	line "the right leg is"

	para "sewn on? That's"
	line "proof!"
	done

UnknownText_0x18b1e2:
	text "OK. Here's the"
	line "Magnet Train Pass"
	cont "like I promised!"
	done

UnknownText_0x18b214:
	text "Copycat: That's"
	line "the pass for the"
	cont "Magnet Train."

	para "The rail company"
	line "man gave me that"

	para "when they tore"
	line "down our old house"
	cont "for the station."
	done

UnknownText_0x18b298:
	text "<PLAYER>: Hi!"
	line "Thanks a lot for"
	cont "the rail pass!"

	para "<PLAYER>: Pardon?"

	para "<PLAYER>: Is it"
	line "that fun to mimic"
	cont "my every move?"
	done

UnknownText_0x18b2f5:
	text "Copycat: You bet!"
	line "It's a scream!"
	done

UnknownText_0x18b316:
	text "<PLAYER>: Hi. You"
	line "must like #mon."

	para "<PLAYER>: No, not"
	line "me. I asked you."

	para "<PLAYER>: Pardon?"
	line "You're weird!"
	done

UnknownText_0x18b366:
	text "<PLAYER>: Hi. Did"
	line "you really lose"
	cont "your # Doll?"

	para "<PLAYER>: You'll"
	line "really give me a"

	para "rail pass if I"
	line "find it for you?"

	para "<PLAYER>: Sure,"
	line "I'll look for it!"

	para "You think you lost"
	line "it when you were"
	cont "in Vermilion?"
	done

UnknownText_0x18b415:
	text "<PLAYER>: Thank you"
	line "for the rail pass!"

	para "<PLAYER>: …Pardon?"

	para "<PLAYER>: Is it"
	line "really that fun to"

	para "copy what I say"
	line "and do?"
	done

CopycatsDodrioText1:
	text "Dodrio: Gii giii!"
	done

CopycatsDodrioText2:
	text "Mirror, mirror on"
	line "the wall, who's"

	para "the fairest one of"
	line "all?"
	done

CopycatsHouse2FDollText:
	text "This is a rare"
	line "#mon! Huh?"

	para "It's only a doll…"
	done
