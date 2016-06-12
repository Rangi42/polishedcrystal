WonderTradeQuestionText::
	text "Would you like to"
	line "trade?"
	done

WonderTradePromptText::
	text "Which #mon do"
	line "you want to trade?"
	prompt

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
	line "trade partner…"
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
	prompt

WonderTradeDoneFanfare::
	sound_dex_fanfare_80_109
	interpret_data
	db "@@"

WonderTradeAlreadyDoneText::
	text "You traded a"
	line "#mon with us"
	cont "only recently."

	para "Please come back"
	line "later."
	prompt

WonderTradeForGSBallPichuText::
	text "…But what's this?"
	line "Is something wrong"

	para "with the Wonder"
	line "Trade machine?"

	para "It seems like you"
	line "just traded a"
	cont "#mon with"
	cont "yourself."

	para "But that can't be"
	line "right… You can't"
	cont "be in two places"
	cont "at once."

	para "Besides, the ma-"
	line "chine communicates"
	cont "through space,"
	cont "not time…"

	para "And what is that"
	line "strange Ball it's"
	cont "holding? Is it an"
	cont "Apricorn Ball?"

	para "Well, a #mon"
	line "is a #mon."
	cont "Please look after"
	cont "it carefully."
	prompt
