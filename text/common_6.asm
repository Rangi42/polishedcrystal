WonderTradeIntroText::
	text "Hello! Welcome to"
	line "#Com Center"
	cont "Wonder Trade Hub."

	para "You can trade"
	line "#mon with other"
	cont "people far away."

;	text "With Wonder Trade,"
;	line "you can quickly"
;	cont "and easily trade"
;
;	para "your #mon with"
;	line "anyone from anywh-"
;	cont "ere in the world!"

	para "Would you like to"
	line "trade?"
	done

; unused
UnknownText_0x61727:
	text "Which #mon do"
	line "you want to trade?"
	done

; unused
UnknownText_0x61749:
	text "Sorry, but we must"
	line "cancel the trade."
	done

WonderTradeCanceledText::
	text "We hope to see you"
	line "again."
	done

; unused
UnknownText_0x616b4:
	text "Oh? You left your"
	line "#mon with us"
	cont "only recently."

	para "Please come back"
	line "later."
	done

WonderTradeConfirmText::
	text "Offer to trade"
	line "@"
	text_from_ram StringBuffer1
	text "? "
	done

; unused
UnknownText_0x616fb:
	text "We'll Save before"
	line "connecting to the"
	cont "Center."
	done

; unused
UnknownText_0x6113b:
	text "Fine. We will try"
	line "to trade your"

	para "@"
	text_from_ram StringBuffer3
	text " for"
	line "@"
	text_from_ram StringBuffer4
	text "."
	done

; unused
UnknownText_0x612d8:
	text "Oh? You have only"
	line "one #mon in"
	cont "your party. "

	para "Please come back"
	line "once you've in-"
	cont "creased the size"
	cont "of your party."
	done

; unused
UnknownText_0x61375:
	text "If we accept that"
	line "#mon, what will"
	cont "you battle with?"
	done

; unused
UnknownText_0x613a9:
	text "Sorry. We can't"
	line "accept an Egg."
	done

; unused
UnknownText_0x613c8:
	text "Sorry, but your"
	line "#mon appears to"

	para "be abnormal. We"
	line "can't accept it."
	done

WonderTradeSetupText::
	text "Searching for a"
	line "trade partner..."
	prompt

; unused
UnknownText_0x6191f:
	text "Please wait a"
	line "moment."
	done

WonderTradeReadyText::
	text "A trade partner"
	line "has been found."

;	text "We've found you a"
;	line "trade partner!"

	prompt

WonderTradeCompleteText::
	text "It's your new"
	line "partner."

	para "Please take care"
	line "of it with love."

	para "We hope to see you"
	line "again."
	done

WonderTradeDoneFanfare::
	sound_dex_fanfare_80_109
	interpret_data
	db "@@"
