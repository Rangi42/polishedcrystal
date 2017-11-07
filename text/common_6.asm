WonderTradeQuestionText::
	text "Would you like to"
	line "trade?"
	done

WonderTradePromptText::
	text "Which #mon do"
	line "you want to trade?"
	prompt

;WonderTradeCantTradeEggText::
;	text "Sorry. We can't"
;	line "accept an Egg."
;	prompt

;UnknownText_0x613c8::
;	text "Sorry, but your"
;	line "#mon appears to"
;
;	para "be abnormal. We"
;	line "can't accept it."
;	prompt

WonderTradeCantTradeGSBallText::
	text "Sorry, but your"
	line "#mon is holding"

	para "a strange item. We"
	line "can't accept it."
	prompt

WonderTradeConfirmText::
	text "Offer to trade"
	line "@"
	text_from_ram StringBuffer1
	text "?"
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

	para "…………"

	para "Well, a #mon"
	line "is a #mon."

	para "Please look after"
	line "it carefully."
	prompt

SilphMartIntroText::
	text "Employees like me"
	line "have access to"
	cont "company swag!"

	para "Want to buy some?"
	done

SilphMartComeAgainText::
	text "Come again! I"
	line "could use the"
	cont "side income."
	done

AdventurerMartIntroText::
	text "I picked up some"
	line "rare items abroad!"
	done

AdventurerMartComeAgainText::
	text "Come by again!"
	done

InformalMartIntroText::
	text "What's up? Need"
	line "some supplies?"
	done

BazaarMartIntroText::
	text "Come take a look"
	line "at my wares!"
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

MoveReminderNoGoldLeafText::
	text "Huh? You don't"
	line "have any Gold"
	cont "Leaves."

	para "Sometimes you can"
	line "find them on wild"
	cont "Bellsprout."
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

MoveReminderCancelText::
	text "If your #mon"
	line "needs to learn a"

	para "move, come back"
	line "with a Gold Leaf."
	done

AlreadyHaveTMText::
	text "You already have"
	line "that TM."
	done

MartPremierBallText::
	text "You also get a"
	line "Premier Ball as"
	cont "an added bonus."
	done

ItemCantBeSelectedText::
	text "That item can't be"
	line "selected."
	prompt
