CopycatsHouse2F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_OBJECTS, CopycatsHouse2FCallback

CopycatsHouse2F_MapEventHeader:

.Warps: db 1
	warp_def 0, 3, 3, COPYCATS_HOUSE_1F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 6
	person_event SPRITE_COPYCAT, 3, 4, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, Copycat1Script, EVENT_COPYCAT_1
	person_event SPRITE_COPYCAT, 3, 4, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Copycat2Script, EVENT_COPYCAT_2
	person_event SPRITE_DODRIO, 4, 6, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, CopycatsDodrioScript, -1
	person_event SPRITE_CLEFAIRY, 1, 6, SPRITEMOVEDATA_DOLL, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptext, CopycatsHouse2FDollText, EVENT_COPYCATS_HOUSE_2F_DOLL
	person_event SPRITE_GENGAR, 1, 2, SPRITEMOVEDATA_DOLL, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_COMMAND, jumptext, CopycatsHouse2FDollText, -1
	person_event SPRITE_MURKROW, 1, 7, SPRITEMOVEDATA_DOLL, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptext, CopycatsHouse2FDollText, -1

const_value set 1
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

Copycat1Script:
	faceplayer
	checkevent EVENT_GOT_PASS_FROM_COPYCAT
	iftrue .GotPass
	checkevent EVENT_RETURNED_LOST_ITEM_TO_COPYCAT
	iftrue CopycatReturnedLostItemScript
	checkitem LOST_ITEM
	iftrue CopycatFoundLostItemScript
	applymovement COPYCATSHOUSE2F_COPYCAT1, CopycatSpinMovement
	faceplayer
	variablesprite SPRITE_COPYCAT, SPRITE_CHRIS
	special MapCallbackSprites_LoadUsedSpritesGFX
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .ReturnedMachinePart
	showtext .Greeting1Text
	applymovement COPYCATSHOUSE2F_COPYCAT1, CopycatSpinMovement
	jump CopycatRetortScript

.ReturnedMachinePart:
	showtext .LostDoll1Text
	applymovement COPYCATSHOUSE2F_COPYCAT1, CopycatSpinMovement
	jump CopycatWorriedScript

.GotPass:
	applymovement COPYCATSHOUSE2F_COPYCAT1, CopycatSpinMovement
	faceplayer
	variablesprite SPRITE_COPYCAT, SPRITE_CHRIS
	special MapCallbackSprites_LoadUsedSpritesGFX
	showtext .Thanks1Text
	applymovement COPYCATSHOUSE2F_COPYCAT1, CopycatSpinMovement
	jump CopycatFinalScript

.Greeting1Text:
	text "<PLAYER>: Hi! Do"
	line "you like #mon?"

	para "<PLAYER>: Uh, no, I"
	line "just asked you."

	para "<PLAYER>: Huh?"
	line "You're strange!"
	done

.LostDoll1Text:
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

.Thanks1Text:
	text "<PLAYER>: Hi!"
	line "Thanks a lot for"
	cont "the rail pass!"

	para "<PLAYER>: Pardon?"

	para "<PLAYER>: Is it"
	line "that fun to mimic"
	cont "my every move?"
	done

Copycat2Script:
	faceplayer
	checkevent EVENT_GOT_PASS_FROM_COPYCAT
	iftrue .GotPass
	checkevent EVENT_RETURNED_LOST_ITEM_TO_COPYCAT
	iftrue CopycatReturnedLostItemScript
	checkitem LOST_ITEM
	iftrue CopycatFoundLostItemScript
	applymovement COPYCATSHOUSE2F_COPYCAT2, CopycatSpinMovement
	faceplayer
	variablesprite SPRITE_COPYCAT, SPRITE_KRIS
	special MapCallbackSprites_LoadUsedSpritesGFX
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .ReturnedMachinePart
	showtext .Greeting2Text
	applymovement COPYCATSHOUSE2F_COPYCAT2, CopycatSpinMovement
	jump CopycatRetortScript

.ReturnedMachinePart:
	showtext .LostDoll2Text
	applymovement COPYCATSHOUSE2F_COPYCAT2, CopycatSpinMovement
	jump CopycatWorriedScript

.GotPass:
	applymovement COPYCATSHOUSE2F_COPYCAT2, CopycatSpinMovement
	faceplayer
	variablesprite SPRITE_COPYCAT, SPRITE_KRIS
	special MapCallbackSprites_LoadUsedSpritesGFX
	showtext .Thanks2Text
	applymovement COPYCATSHOUSE2F_COPYCAT2, CopycatSpinMovement
	jump CopycatFinalScript

.Greeting2Text:
	text "<PLAYER>: Hi. You"
	line "must like #mon."

	para "<PLAYER>: No, not"
	line "me. I asked you."

	para "<PLAYER>: Pardon?"
	line "You're weird!"
	done

.LostDoll2Text:
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

.Thanks2Text:
	text "<PLAYER>: Thank you"
	line "for the rail pass!"

	para "<PLAYER>: …Pardon?"

	para "<PLAYER>: Is it"
	line "really that fun to"

	para "copy what I say"
	line "and do?"
	done
CopycatRetortScript:
	faceplayer
	variablesprite SPRITE_COPYCAT, SPRITE_LASS
	special MapCallbackSprites_LoadUsedSpritesGFX
	thistext

	text "Copycat: Hmm?"
	line "Quit mimicking?"

	para "But that's my"
	line "favorite hobby!"
	done

CopycatWorriedScript:
	faceplayer
	variablesprite SPRITE_COPYCAT, SPRITE_LASS
	special MapCallbackSprites_LoadUsedSpritesGFX
	setevent EVENT_MET_COPYCAT_FOUND_OUT_ABOUT_LOST_ITEM
	thistext

	text "Copycat: Pardon?"

	para "I shouldn't decide"
	line "what you should"
	cont "do?"

	para "But I'm really"
	line "worried… What if"
	cont "someone finds it?"
	done

CopycatFoundLostItemScript:
	opentext
	writetext .FoundDollText
	buttonsound
	takeitem LOST_ITEM
	setevent EVENT_RETURNED_LOST_ITEM_TO_COPYCAT
	clearevent EVENT_COPYCATS_HOUSE_2F_DOLL
	jump CopycatGivePassScript

.FoundDollText:
	text "Copycat: Yay!"
	line "That's my Clefairy"
	cont "# Doll!"

	para "See the tear where"
	line "the right leg is"

	para "sewn on? That's"
	line "proof!"
	done

CopycatReturnedLostItemScript:
	opentext
CopycatGivePassScript:
	writetext .GivePassText
	buttonsound
	verbosegiveitem PASS
	iffalse_endtext
	setevent EVENT_GOT_PASS_FROM_COPYCAT
	thisopenedtext

	text "Copycat: That's"
	line "the pass for the"
	cont "Magnet Train."

	para "The rail company"
	line "man gave me that"

	para "when they tore"
	line "down our old house"
	cont "for the station."
	done

.GivePassText:
	text "OK. Here's the"
	line "Magnet Train Pass"
	cont "like I promised!"
	done

CopycatFinalScript:
	faceplayer
	variablesprite SPRITE_COPYCAT, SPRITE_LASS
	special MapCallbackSprites_LoadUsedSpritesGFX
	thistext

	text "Copycat: You bet!"
	line "It's a scream!"
	done

CopycatSpinMovement:
rept 2
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
endr
	turn_head_down
	step_end

CopycatsDodrioScript:
	opentext
	writetext .Text1
	cry DODRIO
	buttonsound
	thisopenedtext

	text "Mirror, mirror on"
	line "the wall, who's"

	para "the fairest one of"
	line "all?"
	done

.Text1:
	text "Dodrio: Gii giii!"
	done

CopycatsHouse2FDollText:
	text "This is a rare"
	line "#mon! Huh?"

	para "It's only a doll…"
	done
