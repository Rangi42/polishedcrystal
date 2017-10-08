GoldenrodDeptStore5F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_OBJECTS, GoldenrodDeptStore5FCheckIfSunday

GoldenrodDeptStore5F_MapEventHeader:

.Warps: db 3
	warp_def 0, 12, 1, GOLDENROD_DEPT_STORE_4F
	warp_def 0, 15, 1, GOLDENROD_DEPT_STORE_6F
	warp_def 0, 2, 1, GOLDENROD_DEPT_STORE_ELEVATOR

.XYTriggers: db 0

.Signposts: db 1
	signpost 0, 14, SIGNPOST_JUMPTEXT, GoldenrodDeptStore5FDirectoryText

.PersonEvents: db 6
	person_event SPRITE_RECEPTIONIST, 5, 7, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ReceptionistScript_0x560ce, EVENT_GOLDENROD_DEPT_STORE_5F_HAPPINESS_EVENT_LADY
	person_event SPRITE_CLERK, 5, 8, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, pokemart, MARTTYPE_TM, MART_GOLDENROD_5F_TM, -1
	person_event SPRITE_COOLTRAINER_M, 3, 6, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, trade, TRADE_WITH_MIKE_FOR_MACHOP, -1
	person_event SPRITE_LASS, 6, 3, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x562ad, -1
	person_event SPRITE_POKEFAN_M, 1, 9, SPRITEMOVEDATA_STANDING_DOWN, 2, 2, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x562f3, -1
	person_event SPRITE_TWIN, 5, 13, SPRITEMOVEDATA_WANDER, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, GoldenrodDeptStore5FTwinScript, -1

const_value set 1
	const GOLDENRODDEPTSTORE5F_RECEPTIONIST

GoldenrodDeptStore5FCheckIfSunday:
	checkcode VAR_WEEKDAY
	if_equal SUNDAY, .yes
	disappear GOLDENRODDEPTSTORE5F_RECEPTIONIST
	return

.yes
	appear GOLDENRODDEPTSTORE5F_RECEPTIONIST
	return

ReceptionistScript_0x560ce:
	faceplayer
	opentext
	checkcode VAR_WEEKDAY
	if_not_equal SUNDAY, .EventIsOver
	checktmhm TM_RETURN
	iftrue .EventIsOver
	checkflag ENGINE_GOLDENROD_MALL_5F_HAPPINESS_EVENT
	iftrue .EventIsOver
	special GetFirstPokemonHappiness
	writetext UnknownText_0x56143
	buttonsound
	if_greater_than $95, .VeryHappy
	jump .SomewhatHappy

.VeryHappy:
	writetext UnknownText_0x5615a
	buttonsound
	verbosegivetmhm TM_RETURN
	setflag ENGINE_GOLDENROD_MALL_5F_HAPPINESS_EVENT
	endtext

.SomewhatHappy:
	jumpopenedtext UnknownText_0x561a6

.EventIsOver:
	jumpopenedtext UnknownText_0x56202

GoldenrodDeptStore5FTwinScript:
	faceplayer
	opentext
	checkflag ENGINE_DAILY_MYSTERY_GIFT
	iftrue .GotDailyBerry
	writetext UnknownText_0x56279
	buttonsound
	callasm .PickRandomMysteryGift
	itemtotext $0, $1
	giveitem ITEM_FROM_MEM
	iffalse .NoRoom
	writetext MysteryGiftGirl_GiveItemText
	itemnotify
	setflag ENGINE_DAILY_MYSTERY_GIFT
.GotDailyBerry
	jumpopenedtext MysteryGiftGirl_ComeBackText

.NoRoom:
	jumpopenedtext MysteryGiftGirl_NoRoomText

.PickRandomMysteryGift:
	ld a, APICOT_BERRY - ORAN_BERRY + 1
	call RandomRange
	add ORAN_BERRY
	ld [ScriptVar], a
	ret

UnknownText_0x56143:
	text "Hello. Oh, your"
	line "#mon…"
	done

UnknownText_0x5615a:
	text "It's very attached"
	line "to you."

	para "This move should"
	line "be perfect for a"
	cont "pair like you."
	done

UnknownText_0x561a6:
	text "It's adorable!"

	para "You should teach"
	line "it good TM moves."
	done

UnknownText_0x56202:
	text "There are sure to"
	line "be TMs that are"

	para "just perfect for"
	line "your #mon."
	done

UnknownText_0x56279:
	text "Looking at the"
	line "ground while I was"

	para "walking made me"
	line "dizzy."

	para "But, I did find"
	line "this Berry!"
	done

MysteryGiftGirl_GiveItemText:
	text "<PLAYER> received"
	line "@"
	text_from_ram StringBuffer4
	text "!@"
	sound_item
	text_waitbutton
	db "@"

MysteryGiftGirl_ComeBackText:
	text "You can have"
	line "another Berry"
	cont "tomorrow."
	done

MysteryGiftGirl_NoRoomText:
	text "But you can't"
	line "carry it…"
	done

UnknownText_0x562ad:
	text "On Sundays, a lady"
	line "comes to check out"
	cont "#mon."

	para "She even gives"
	line "away TMs!"
	done

UnknownText_0x562f3:
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
