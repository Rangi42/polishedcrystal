const_value set 2
	const CELADONHOMEDECORSTORE4F_CLERK
	const CELADONHOMEDECORSTORE4F_BIG_SNORLAX_DOLL_TOP_LEFT
	const CELADONHOMEDECORSTORE4F_BIG_SNORLAX_DOLL_TOP_RIGHT
	const CELADONHOMEDECORSTORE4F_BIG_SNORLAX_DOLL_BOTTOM_LEFT
	const CELADONHOMEDECORSTORE4F_BIG_SNORLAX_DOLL_BOTTOM_RIGHT
	const CELADONHOMEDECORSTORE4F_BIG_LAPRAS_DOLL_TOP_LEFT
	const CELADONHOMEDECORSTORE4F_BIG_LAPRAS_DOLL_TOP_RIGHT
	const CELADONHOMEDECORSTORE4F_BIG_LAPRAS_DOLL_BOTTOM_LEFT
	const CELADONHOMEDECORSTORE4F_BIG_LAPRAS_DOLL_BOTTOM_RIGHT
	const CELADONHOMEDECORSTORE4F_BIG_ONIX_DOLL


CeladonHomeDecorStore4F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1

	; callbacks

	dbw MAPCALLBACK_OBJECTS, .DailyDolls

.DailyDolls:
	checkcode VAR_WEEKDAY
	if_equal MONDAY, .SnorlaxAndLapras
	if_equal TUESDAY, .LaprasAndOnix
	if_equal WEDNESDAY, .SnorlaxAndOnix
	if_equal THURSDAY, .SnorlaxAndLapras
	if_equal FRIDAY, .LaprasAndOnix
	if_equal SATURDAY, .SnorlaxAndOnix
.SnorlaxAndLapras:
	appear CELADONHOMEDECORSTORE4F_BIG_SNORLAX_DOLL_TOP_LEFT
	appear CELADONHOMEDECORSTORE4F_BIG_SNORLAX_DOLL_TOP_RIGHT
	appear CELADONHOMEDECORSTORE4F_BIG_SNORLAX_DOLL_BOTTOM_LEFT
	appear CELADONHOMEDECORSTORE4F_BIG_SNORLAX_DOLL_BOTTOM_RIGHT
	appear CELADONHOMEDECORSTORE4F_BIG_LAPRAS_DOLL_TOP_LEFT
	appear CELADONHOMEDECORSTORE4F_BIG_LAPRAS_DOLL_TOP_RIGHT
	appear CELADONHOMEDECORSTORE4F_BIG_LAPRAS_DOLL_BOTTOM_LEFT
	appear CELADONHOMEDECORSTORE4F_BIG_LAPRAS_DOLL_BOTTOM_RIGHT
	disappear CELADONHOMEDECORSTORE4F_BIG_ONIX_DOLL
	return

.LaprasAndOnix:
	disappear CELADONHOMEDECORSTORE4F_BIG_SNORLAX_DOLL_TOP_LEFT
	disappear CELADONHOMEDECORSTORE4F_BIG_SNORLAX_DOLL_TOP_RIGHT
	disappear CELADONHOMEDECORSTORE4F_BIG_SNORLAX_DOLL_BOTTOM_LEFT
	disappear CELADONHOMEDECORSTORE4F_BIG_SNORLAX_DOLL_BOTTOM_RIGHT
	appear CELADONHOMEDECORSTORE4F_BIG_LAPRAS_DOLL_TOP_LEFT
	appear CELADONHOMEDECORSTORE4F_BIG_LAPRAS_DOLL_TOP_RIGHT
	appear CELADONHOMEDECORSTORE4F_BIG_LAPRAS_DOLL_BOTTOM_LEFT
	appear CELADONHOMEDECORSTORE4F_BIG_LAPRAS_DOLL_BOTTOM_RIGHT
	appear CELADONHOMEDECORSTORE4F_BIG_ONIX_DOLL
	return

.SnorlaxAndOnix:
	appear CELADONHOMEDECORSTORE4F_BIG_SNORLAX_DOLL_TOP_LEFT
	appear CELADONHOMEDECORSTORE4F_BIG_SNORLAX_DOLL_TOP_RIGHT
	appear CELADONHOMEDECORSTORE4F_BIG_SNORLAX_DOLL_BOTTOM_LEFT
	appear CELADONHOMEDECORSTORE4F_BIG_SNORLAX_DOLL_BOTTOM_RIGHT
	disappear CELADONHOMEDECORSTORE4F_BIG_LAPRAS_DOLL_TOP_LEFT
	disappear CELADONHOMEDECORSTORE4F_BIG_LAPRAS_DOLL_TOP_RIGHT
	disappear CELADONHOMEDECORSTORE4F_BIG_LAPRAS_DOLL_BOTTOM_LEFT
	disappear CELADONHOMEDECORSTORE4F_BIG_LAPRAS_DOLL_BOTTOM_RIGHT
	appear CELADONHOMEDECORSTORE4F_BIG_ONIX_DOLL
	return

BigDollClerkScript:
	jumptextfaceplayer BigDollClerkText

BigDollClerkNoSaleScript:
	writetext BigDollClerkNoSaleText
	waitbutton
	closetext
	end

BigDollClerkNoMoneyScript:
	writetext BigDollClerkNoMoneyText
	waitbutton
	closetext
	end

BigLaprasDollScript:
	opentext
	checkevent EVENT_DECO_BIG_LAPRAS_DOLL
	iftrue .OwnBigLaprasDoll
	writetext BigDollClerkSellLaprasText
	special PlaceMoneyTopRight
	yesorno
	iffalse BigDollClerkNoSaleScript
	checkmoney $0, 250000
	if_equal $2, BigDollClerkNoMoneyScript
	takemoney $0, 250000
	setevent EVENT_DECO_BIG_LAPRAS_DOLL
	writetext BoughtBigLaprasDollText
	playsound SFX_TRANSACTION
	waitbutton
	writetext BigLaprasDollSentText
	waitbutton
	closetext
	end

.OwnBigLaprasDoll:
	writetext BigLaprasDollText
	waitbutton
	closetext
	end

BigSnorlaxDollScript:
	opentext
	checkevent EVENT_DECO_BIG_SNORLAX_DOLL
	iftrue .OwnBigSnorlaxDoll
	writetext BigDollClerkSellSnorlaxText
	special PlaceMoneyTopRight
	yesorno
	iffalse BigDollClerkNoSaleScript
	checkmoney $0, 200000
	if_equal $2, BigDollClerkNoMoneyScript
	takemoney $0, 200000
	setevent EVENT_DECO_BIG_SNORLAX_DOLL
	writetext BoughtBigSnorlaxDollText
	playsound SFX_TRANSACTION
	waitbutton
	writetext BigSnorlaxDollSentText
	waitbutton
	closetext
	end

.OwnBigSnorlaxDoll:
	writetext BigSnorlaxDollText
	waitbutton
	closetext
	end

BigOnixDollScript:
	opentext
	checkevent EVENT_DECO_BIG_ONIX_DOLL
	iftrue .OwnBigOnixDoll
	writetext BigDollClerkSellOnixText
	special PlaceMoneyTopRight
	yesorno
	iffalse BigDollClerkNoSaleScript
	checkmoney $0, 150000
	if_equal $2, BigDollClerkNoMoneyScript
	takemoney $0, 150000
	setevent EVENT_DECO_BIG_ONIX_DOLL
	writetext BoughtBigOnixDollText
	playsound SFX_TRANSACTION
	waitbutton
	writetext BigOnixDollSentText
	waitbutton
	closetext
	end

.OwnBigOnixDoll:
	writetext BigOnixDollText
	waitbutton
	closetext
	end

CeladonHomeDecorStore4FDirectory:
	jumptext CeladonHomeDecorStore4FDirectoryText

BigDollClerkText:
	text "Aren't our jumbo"
	line "dolls impressive?"

	para "They're so big,"
	line "we can't display"
	cont "them all at once."

	para "Come back tomorrow"
	line "to see another."
	done

BigDollClerkNoSaleText:
	text "Clerk: Well, if"
	line "you say so."
	done

BigDollClerkNoMoneyText:
	text "Clerk: You can't"
	line "afford it!"
	done

BigDollClerkSellLaprasText:
	text "Clerk: You like"
	line "the Lapras doll?"

	para "It'll cost you"
	line "¥250,000."
	done

BigDollClerkSellSnorlaxText:
	text "Clerk: You like"
	line "the Snorlax doll?"

	para "It'll cost you"
	line "¥200,000."
	done

BigDollClerkSellOnixText:
	text "Clerk: You like"
	line "the Onix doll?"

	para "It'll cost you"
	line "¥150,000."
	done

BoughtBigLaprasDollText:
	text "<PLAYER> bought"
	line "Big Lapras Doll."
	done

BigLaprasDollSentText:
	text "Big Lapras Doll"
	line "was sent home."
	done

BoughtBigSnorlaxDollText:
	text "<PLAYER> bought"
	line "Big Snorlax Doll."
	done

BigSnorlaxDollSentText:
	text "Big Snorlax Doll"
	line "was sent home."
	done

BoughtBigOnixDollText:
	text "<PLAYER> bought"
	line "Big Onix Doll."
	done

BigOnixDollSentText:
	text "Big Onix Doll"
	line "was sent home."
	done

BigLaprasDollText:
	text "It's a jumbo-size"
	line "Lapras Doll!"
	done

BigSnorlaxDollText:
	text "It's a jumbo-size"
	line "Snorlax Doll!"
	done

BigOnixDollText:
	text "It's a jumbo-size"
	line "Onix Doll!"
	done

CeladonHomeDecorStore4FDirectoryText:
	text "A Stuffed"
	line "Companion!"

	para "4F: Jumbo Dolls"
	done

CeladonHomeDecorStore4F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def $0, $9, 2, CELADON_HOME_DECOR_STORE_3F

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 0, 8, SIGNPOST_READ, CeladonHomeDecorStore4FDirectory

.PersonEvents:
	db 10
	person_event SPRITE_CLERK, 5, 9, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, BigDollClerkScript, -1
	person_event SPRITE_GYARADOS_BOTTOM_LEFT, 5, 2, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, BigSnorlaxDollScript, EVENT_BIG_SNORLAX_DOLL_ON_SALE
	person_event SPRITE_GYARADOS_BOTTOM_LEFT, 5, 3, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, BigSnorlaxDollScript, EVENT_BIG_SNORLAX_DOLL_ON_SALE
	person_event SPRITE_GYARADOS_BOTTOM_RIGHT, 6, 2, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, BigSnorlaxDollScript, EVENT_BIG_SNORLAX_DOLL_ON_SALE
	person_event SPRITE_GYARADOS_BOTTOM_RIGHT, 6, 3, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, BigSnorlaxDollScript, EVENT_BIG_SNORLAX_DOLL_ON_SALE
	person_event SPRITE_GYARADOS_TOP_LEFT, 3, 4, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, BigLaprasDollScript, EVENT_BIG_LAPRAS_DOLL_ON_SALE
	person_event SPRITE_GYARADOS_TOP_LEFT, 3, 5, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, BigLaprasDollScript, EVENT_BIG_LAPRAS_DOLL_ON_SALE
	person_event SPRITE_GYARADOS_TOP_RIGHT, 4, 4, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, BigLaprasDollScript, EVENT_BIG_LAPRAS_DOLL_ON_SALE
	person_event SPRITE_GYARADOS_TOP_RIGHT, 4, 5, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, BigLaprasDollScript, EVENT_BIG_LAPRAS_DOLL_ON_SALE
	person_event SPRITE_BIG_ONIX, 3, 1, SPRITEMOVEDATA_BIGDOLL, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, BigOnixDollScript, EVENT_BIG_ONIX_DOLL_ON_SALE
