CopycatsHouse2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, CopycatsHouse2FCallback

	def_warp_events
	warp_event  3,  0, COPYCATS_HOUSE_1F, 3

	def_coord_events

	def_bg_events

	def_object_events
	object_event  4,  3, SPRITE_COPYCAT, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Copycat1Script, EVENT_COPYCAT_1
	object_event  4,  3, SPRITE_COPYCAT, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Copycat2Script, EVENT_COPYCAT_2
	object_event  6,  4, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, DODRIO, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, CopycatsDodrioScript, -1
	object_event  6,  1, SPRITE_MON_ICON, SPRITEMOVEDATA_STILL, 0, CLEFAIRY, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptext, CopycatsHouse2FDollText, EVENT_COPYCATS_HOUSE_2F_DOLL
	object_event  2,  1, SPRITE_MON_ICON, SPRITEMOVEDATA_STILL, 0, GENGAR, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_COMMAND, jumptext, CopycatsHouse2FDollText, -1
	object_event  7,  1, SPRITE_MON_ICON, SPRITEMOVEDATA_STILL, 0, MURKROW, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptext, CopycatsHouse2FDollText, -1
	pokemon_event  0,  4, DITTO, -1, -1, PAL_NPC_PURPLE, CopycatsHouse2FDittoText, -1

	object_const_def
	const COPYCATSHOUSE2F_COPYCAT1
	const COPYCATSHOUSE2F_COPYCAT2

CopycatsHouse2FCallback:
	variablesprite SPRITE_COPYCAT, SPRITE_LASS
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .Part1
	disappear COPYCATSHOUSE2F_COPYCAT2
	appear COPYCATSHOUSE2F_COPYCAT1
	sjump .Done
.Part1:
	disappear COPYCATSHOUSE2F_COPYCAT1
	appear COPYCATSHOUSE2F_COPYCAT2
.Done:
	endcallback

Copycat1Script:
	faceplayer
	checkevent EVENT_GOT_PASS_FROM_COPYCAT
	iftrue .GotPass
	checkevent EVENT_RETURNED_LOST_ITEM_TO_COPYCAT
	iftrue CopycatReturnedLostItemScript
	checkkeyitem LOST_ITEM
	iftrue CopycatFoundLostItemScript
	applymovement COPYCATSHOUSE2F_COPYCAT1, CopycatSpinMovement
	faceplayer
	setval (PAL_NPC_RED) << 4
	special Special_SetCopycatPalette
	variablesprite SPRITE_COPYCAT, SPRITE_CHRIS
	special MapCallbackSprites_LoadUsedSpritesGFX
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .ReturnedMachinePart
	showtext .Greeting1Text
	applymovement COPYCATSHOUSE2F_COPYCAT1, CopycatSpinMovement
	sjump CopycatRetortScript

.ReturnedMachinePart:
	showtext .LostDoll1Text
	applymovement COPYCATSHOUSE2F_COPYCAT1, CopycatSpinMovement
	sjump CopycatWorriedScript

.GotPass:
	applymovement COPYCATSHOUSE2F_COPYCAT1, CopycatSpinMovement
	faceplayer
	setval (PAL_NPC_RED) << 4
	special Special_SetCopycatPalette
	variablesprite SPRITE_COPYCAT, SPRITE_CHRIS
	special MapCallbackSprites_LoadUsedSpritesGFX
	showtext .Thanks1Text
	applymovement COPYCATSHOUSE2F_COPYCAT1, CopycatSpinMovement
	sjump CopycatFinalScript

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
	checkkeyitem LOST_ITEM
	iftrue CopycatFoundLostItemScript
	applymovement COPYCATSHOUSE2F_COPYCAT2, CopycatSpinMovement
	faceplayer
	setval (PAL_NPC_BLUE) << 4
	special Special_SetCopycatPalette
	variablesprite SPRITE_COPYCAT, SPRITE_KRIS
	special MapCallbackSprites_LoadUsedSpritesGFX
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .ReturnedMachinePart
	showtext .Greeting2Text
	applymovement COPYCATSHOUSE2F_COPYCAT2, CopycatSpinMovement
	sjump CopycatRetortScript

.ReturnedMachinePart:
	showtext .LostDoll2Text
	applymovement COPYCATSHOUSE2F_COPYCAT2, CopycatSpinMovement
	sjump CopycatWorriedScript

.GotPass:
	applymovement COPYCATSHOUSE2F_COPYCAT2, CopycatSpinMovement
	faceplayer
	setval (PAL_NPC_BLUE) << 4
	special Special_SetCopycatPalette
	variablesprite SPRITE_COPYCAT, SPRITE_KRIS
	special MapCallbackSprites_LoadUsedSpritesGFX
	showtext .Thanks2Text
	applymovement COPYCATSHOUSE2F_COPYCAT2, CopycatSpinMovement
	sjump CopycatFinalScript

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
	setval (PAL_NPC_GREEN) << 4
	special Special_SetCopycatPalette
	variablesprite SPRITE_COPYCAT, SPRITE_LASS
	special MapCallbackSprites_LoadUsedSpritesGFX
	jumpthistext

	text "Copycat: Hmm?"
	line "Quit mimicking?"

	para "But that's my"
	line "favorite hobby!"
	done

CopycatWorriedScript:
	faceplayer
	setval (PAL_NPC_GREEN) << 4
	special Special_SetCopycatPalette
	variablesprite SPRITE_COPYCAT, SPRITE_LASS
	special MapCallbackSprites_LoadUsedSpritesGFX
	setevent EVENT_MET_COPYCAT_FOUND_OUT_ABOUT_LOST_ITEM
	jumpthistext

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
	promptbutton
	takekeyitem LOST_ITEM
	setevent EVENT_RETURNED_LOST_ITEM_TO_COPYCAT
	clearevent EVENT_COPYCATS_HOUSE_2F_DOLL
	sjump CopycatGivePassScript

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
	promptbutton
	verbosegivekeyitem PASS
	iffalse_endtext
	setevent EVENT_GOT_PASS_FROM_COPYCAT
	jumpthisopenedtext

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
	setval (PAL_NPC_GREEN) << 4
	special Special_SetCopycatPalette
	variablesprite SPRITE_COPYCAT, SPRITE_LASS
	special MapCallbackSprites_LoadUsedSpritesGFX
	jumpthistext

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
	promptbutton
	jumpthisopenedtext

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

CopycatsHouse2FDittoText:
	text "Ditto: Dii…"
	done
