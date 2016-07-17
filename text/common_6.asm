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
	cont "three times today."

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

	para "#mon with"
	line "yourself."

	para "But that can't be"
	line "right… You can't"

	para "be in two places"
	line "at once."

	para "Besides, the ma-"
	line "chine communicates"

	para "through space,"
	line "not time…"

	para "And what is that"
	line "strange Ball it's"

	para "holding? Is it an"
	line "Apricorn Ball?"

	para "<......><......>"

	para "Well, a #mon"
	line "is a #mon."

	para "Please look after"
	line "it carefully."
	prompt

SilphMartIntroText::
	text "Hi there!"

	para "Silph and Devon"
	line "partnered up"

	para "to design some"
	line "special new #"
	cont "Balls."

	para "Want to buy them"
	line "before they're"
	cont "released?"
	done

SilphMartHowManyText::
	text "How many?"
	done

SilphMartCostsThisMuchText::
	deciram wItemQuantityChangeBuffer, 1, 2
	text " @"
	text_from_ram StringBuffer2
	text "(s)"
	line "will cost ¥@"
	deciram hMoneyTemp, 3, 6
	text "."
	done

SilphMartHereYouGoText::
	text "Thanks!"
	done

SilphMartBagFullText::
	text "You don't have"
	line "space for it."
	done

SilphMartInsufficientFundsText::
	text "That's not enough"
	line "money…"
	done

SilphMartComeAgainText::
	text "Come by again!"
	done

MoveReminderIntroText::
	text "Me? I'm the"
	line "Move Maniac."

	para "I'll make your"
	line "#mon remember"

	para "a move if you'll"
	line "trade me a"
	cont "Gold Leaf."
	done

MoveReminderPromptText::
	text "Do you want me to"
	line "teach one of your"
	cont "#mon a move?"
	done

MoveReminderWhichMonText::
	text "Which #mon"
	line "needs tutoring?"
	done

MoveReminderWhichMoveText::
	text "Which move should"
	line "it remember?"
	done

MoveReminderCancelText::
MoveReminderNoGoldLeafText::
	text "If your #mon"
	line "needs to learn a"

	para "move, come back"
	line "with a Gold Leaf."
	done

MoveReminderEggText::
	text "Huh? That's just"
	line "an Egg."
	done

MoveReminderNoMonText::
	text "Huh? That's not"
	line "a #mon."
	done

MoveReminderNoMovesText::
	text "Sorry… There isn't"
	line "any move I can"

	para "make that #mon"
	line "remember."
	done

MoveReminderSorryText::
	text "I can't do it"
	line "yet, though."
	cont "Sorry."
	done
