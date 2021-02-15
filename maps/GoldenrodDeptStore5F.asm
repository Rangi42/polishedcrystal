GoldenrodDeptStore5F_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, GoldenrodDeptStore5FCheckIfSunday

	def_warp_events
	warp_event 12,  0, GOLDENROD_DEPT_STORE_4F, 1
	warp_event 15,  0, GOLDENROD_DEPT_STORE_6F, 1
	warp_event  2,  0, GOLDENROD_DEPT_STORE_ELEVATOR, 1

	def_coord_events

	def_bg_events
	bg_event 14,  0, BGEVENT_JUMPTEXT, GoldenrodDeptStore5FDirectoryText

	def_object_events
	object_event  7,  5, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore5FReceptionistScript, EVENT_GOLDENROD_DEPT_STORE_5F_HAPPINESS_EVENT_LADY
	object_event  8,  5, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, pokemart, MARTTYPE_TM, MART_GOLDENROD_5F_TM, -1
	object_event  6,  3, SPRITE_COOL_DUDE, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, trade, TRADE_WITH_MIKE_FOR_MACHOP, -1
	object_event  3,  6, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodDeptStore5FLassText, -1
	object_event  9,  1, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 2, 2, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodDeptStore5FPokefanMText, -1
	object_event 13,  5, SPRITE_TWIN, SPRITEMOVEDATA_WANDER, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore5FTwinScript, -1

	object_const_def
	const GOLDENRODDEPTSTORE5F_RECEPTIONIST

GoldenrodDeptStore5FCheckIfSunday:
	checkcode VAR_WEEKDAY
	ifequal SUNDAY, .yes
	disappear GOLDENRODDEPTSTORE5F_RECEPTIONIST
	return

.yes
	appear GOLDENRODDEPTSTORE5F_RECEPTIONIST
	return

GoldenrodDeptStore5FReceptionistScript:
	faceplayer
	opentext
	checkcode VAR_WEEKDAY
	ifnotequal SUNDAY, .EventIsOver
	checktmhm TM_RETURN
	iftrue .EventIsOver
	checkflag ENGINE_GOLDENROD_MALL_5F_HAPPINESS_EVENT
	iftrue .EventIsOver
	special GetFirstPokemonHappiness
	writetext GoldenrodDeptStore5FReceptionistOhYourMonDotDotDotText
	buttonsound
	ifgreater $95, .VeryHappy
	jumpopenedtext GoldenrodDeptStore5FReceptionistItsAdorableText

.VeryHappy:
	writetext GoldenrodDeptStore5FReceptionistThisMoveShouldBePerfectText
	buttonsound
	verbosegivetmhm TM_RETURN
	setflag ENGINE_GOLDENROD_MALL_5F_HAPPINESS_EVENT
	endtext

.EventIsOver:
	jumpthisopenedtext

	text "There are sure to"
	line "be TMs that are"

	para "just perfect for"
	line "your #mon."
	done

GoldenrodDeptStore5FTwinScript:
	checkflag ENGINE_DAILY_MYSTERY_GIFT
	iftrue_jumptextfaceplayer .ComeBackText
	faceplayer
	opentext
	writetext GoldenrodDeptStore5FCarrieMysteryGiftRequiresGBCText
	buttonsound
	random MARANGABERRY - ORAN_BERRY + 1
	addvar ORAN_BERRY
	itemtotext $0, $1
	verbosegiveitem ITEM_FROM_MEM
	iffalse_jumpopenedtext MysteryGiftGirl_NoRoomText
	setflag ENGINE_DAILY_MYSTERY_GIFT
	jumpthisopenedtext

.ComeBackText:
	text "You can have"
	line "another Berry"
	cont "tomorrow."
	done

GoldenrodDeptStore5FReceptionistOhYourMonDotDotDotText:
	text "Hello. Oh, your"
	line "#mon…"
	done

GoldenrodDeptStore5FReceptionistThisMoveShouldBePerfectText:
	text "It's very attached"
	line "to you."

	para "This move should"
	line "be perfect for a"
	cont "pair like you."
	done

GoldenrodDeptStore5FReceptionistItsAdorableText:
	text "It's adorable!"

	para "You should teach"
	line "it good TM moves."
	done

GoldenrodDeptStore5FCarrieMysteryGiftRequiresGBCText:
	text "Looking at the"
	line "ground while I was"

	para "walking made me"
	line "dizzy."

	para "But, I did find"
	line "this Berry!"
	done

MysteryGiftGirl_NoRoomText:
	text "But you can't"
	line "carry it…"
	done

GoldenrodDeptStore5FLassText:
	text "On Sundays, a lady"
	line "comes to check out"
	cont "#mon."

	para "She even gives"
	line "away TMs!"
	done

GoldenrodDeptStore5FPokefanMText:
	text "You can't rename a"
	line "#mon you get in"
	cont "a trade."

	para "The name is a re-"
	line "flection of the"

	para "original trainer's"
	line "feelings for it."
	done

GoldenrodDeptStore5FDirectoryText:
	text "Customize Your"
	line "#mon"

	para "5F TM Corner"
	done
