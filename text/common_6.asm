WonderTradeQuestionText::
	text "Would you like to"
	line "trade?"
	done

WonderTradePromptText::
	text "Which #mon do"
	line "you want to trade?"
	prompt

; unused
UnknownText_0x616b4::
	text "Oh? You traded a"
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
UnknownText_0x613a9:
	text "Sorry. We can't"
	line "accept an Egg."
	done

; unused
UnknownText_0x613c8::
	text "Sorry, but your"
	line "#mon appears to"

	para "be abnormal. We"
	line "can't accept it."
	done

WonderTradeSetupText::
	text "Searching for a"
	line "trade partner..."
	prompt

WonderTradeReadyText::
	text "A trade partner"
	line "has been found."
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
