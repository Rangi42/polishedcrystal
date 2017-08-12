
CeladonHomeDecorStore4F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeladonHomeDecorStore4F_MapEventHeader:

.Warps: db 1
	warp_def $0, $9, 2, CELADON_HOME_DECOR_STORE_3F

.XYTriggers: db 0

.Signposts: db 5
	signpost 0, 8, SIGNPOST_JUMPTEXT, CeladonHomeDecorStore4FDirectoryText
	signpost 5, 2, SIGNPOST_READ, BigOnixDollScript
	signpost 5, 3, SIGNPOST_READ, BigOnixDollScript
	signpost 6, 2, SIGNPOST_READ, BigOnixDollScript
	signpost 6, 3, SIGNPOST_READ, BigOnixDollScript

.PersonEvents: db 9
	person_event SPRITE_CLERK, 5, 9, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, BigDollClerkText, -1
	person_event SPRITE_GYARADOS_BOTTOM_LEFT, 3, 1, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, BigSnorlaxDollScript, -1
	person_event SPRITE_GYARADOS_BOTTOM_LEFT, 3, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, BigSnorlaxDollScript, -1
	person_event SPRITE_GYARADOS_BOTTOM_RIGHT, 4, 1, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, BigSnorlaxDollScript, -1
	person_event SPRITE_GYARADOS_BOTTOM_RIGHT, 4, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, BigSnorlaxDollScript, -1
	person_event SPRITE_GYARADOS_TOP_LEFT, 4, 4, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, BigLaprasDollScript, -1
	person_event SPRITE_GYARADOS_TOP_LEFT, 4, 5, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, BigLaprasDollScript, -1
	person_event SPRITE_GYARADOS_TOP_RIGHT, 5, 4, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, BigLaprasDollScript, -1
	person_event SPRITE_GYARADOS_TOP_RIGHT, 5, 5, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, BigLaprasDollScript, -1

BigDollClerkNoSaleScript:
	jumpopenedtext BigDollClerkNoSaleText

BigDollClerkNoMoneyScript:
	jumpopenedtext BigDollClerkNoMoneyText

BigLaprasDollScript:
	opentext
	checkevent EVENT_DECO_BIG_LAPRAS_DOLL
	iftrue .OwnBigLaprasDoll
	writetext BigDollClerkSellLaprasText
	special PlaceMoneyTopRight
	yesorno
	iffalse BigDollClerkNoSaleScript
	checkmoney $0, 300000
	if_equal $2, BigDollClerkNoMoneyScript
	takemoney $0, 300000
	setevent EVENT_DECO_BIG_LAPRAS_DOLL
	writetext BoughtBigLaprasDollText
	playsound SFX_TRANSACTION
	waitbutton
	jumpopenedtext BigLaprasDollSentText

.OwnBigLaprasDoll:
	jumpopenedtext BigLaprasDollText

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
	jumpopenedtext BigSnorlaxDollSentText

.OwnBigSnorlaxDoll:
	jumpopenedtext BigSnorlaxDollText

BigOnixDollScript:
	opentext
	checkevent EVENT_DECO_BIG_ONIX_DOLL
	iftrue .OwnBigOnixDoll
	writetext BigDollClerkSellOnixText
	special PlaceMoneyTopRight
	yesorno
	iffalse BigDollClerkNoSaleScript
	checkmoney $0, 250000
	if_equal $2, BigDollClerkNoMoneyScript
	takemoney $0, 250000
	setevent EVENT_DECO_BIG_ONIX_DOLL
	writetext BoughtBigOnixDollText
	playsound SFX_TRANSACTION
	waitbutton
	jumpopenedtext BigOnixDollSentText

.OwnBigOnixDoll:
	jumpopenedtext BigOnixDollText

BigDollClerkText:
	text "Aren't our jumbo"
	line "dolls impressive?"

	para "They're so big,"
	line "we can barely fit"
	cont "them in the room."
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
	line "¥300,000."
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
	line "¥250,000."
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
