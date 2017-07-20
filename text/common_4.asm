_ElmText6::
	text "Please tell me"
	line "your name."
	prompt

_ElmText7::
	text "<PLAYER>, are you"
	line "ready?"

if !DEF(DEBUG)
	para "Your very own"
	line "#mon story is"
	cont "about to unfold."

	para "You'll face fun"
	line "times and tough"
	cont "challenges."

	para "A world of dreams"
	line "and adventures"

	para "with #mon"
	line "awaits! Let's go!"
endc

	para "I'll be seeing you"
	line "later!"
	done

UnknownText_0x1c40e6::
	text "The clock's time"
	line "may be wrong."

	para "Please reset the"
	line "time."
	prompt

UnknownText_0x1c411c::
	text "Set with the"
	line "Control Pad."

	para "Confirm: A Button"
	line "Cancel:  B Button"
	done

UnknownText_0x1c415b::
	text "Is this OK?"
	done

UnknownText_0x1c4168::
	text "The clock has been"
	line "reset."
	done

UnknownText_0x1c4183::
	text "Too much time has"
	line "elapsed. Please"
	cont "try again."
	prompt

UnknownText_0x1c41b1::
	text "If you trade that"
	line "#mon, you won't"
	cont "be able to battle."
	prompt

UnknownText_0x1c41e6::
	text "Your friend's"
	line "@"
	text_from_ram StringBuffer1
	text " appears"
	cont "to be abnormal!"
	prompt

UnknownText_0x1c4212::
	text "Trade @"
	text_from_ram wd004
	text ""
	line "for @"
	text_from_ram StringBuffer1
	text "?"
	done

UnknownText_0x1c454b::
	text "Would you like to"
	line "save the game?"
	done

UnknownText_0x1c456d::
	text "Saving… Don't turn"
	line "off the power!"
	done

UnknownText_0x1c4590::
	text "<PLAYER> saved"
	line "the game."
	done

UnknownText_0x1c45d9::
	text "Warning! There is"
	line "a save file from"
	cont "another game."

	para "Is it OK to over-"
	line "write the other"
	cont "save file?"
	done

UnknownText_0x1c460d::
	text "The save file is"
	line "corrupted!"
	prompt

UnknownText_0x1c462a::
	text "When you change a"
	line "#mon Box, data"
	cont "will be saved. OK?"
	done

UnknownText_0x1c465f::
	text "Each time you move"
	line "a #mon, data"
	cont "will be saved. OK?"
	done

UnknownText_0x1c46b7::
	text "No windows avail-"
	line "able for popping."
	done

_ObjectEventText::
	text "Object event"
	done

UnknownText_0x1c4719::
	text "<PLAYER> received"
	line "@"
	text_from_ram StringBuffer4
	text "."
	done

UnknownText_0x1c472c::
	text "<PLAYER> put the"
	line "@"
	text_from_ram StringBuffer1
	text " in"
	cont "the @"
	text_from_ram StringBuffer3
	text "."
	prompt

UnknownText_0x1c474b::
	text "The @"
	text_from_ram StringBuffer3
	text ""
	line "is full…"
	prompt

UnknownText_0x1c4b92::
	text "Congratulations!"
	line "Your @"
	text_from_ram StringBuffer2
	db "@@"

UnknownText_0x1c4baf::
	text ""
	para "evolved into"
	line "@"
	text_from_ram StringBuffer1
	text "!"
	done

UnknownText_0x1c4bc5::
	text "Huh? @"
	text_from_ram StringBuffer2
	text ""
	line "stopped evolving!"
	prompt

UnknownText_0x1c4be3::
	text "What? @"
	text_from_ram StringBuffer2
	text ""
	line "is evolving!"
	done

UnknownText_0x1c4bfd::
	text "How many?"
	done

UnknownText_0x1c4c08::
	deciram wItemQuantityChangeBuffer, 1, 2
	text " @"
	text_from_ram StringBuffer2
	text "(s)"
	line "will be ¥@"
	deciram hMoneyTemp, 3, 7
	text "."
	done

UnknownText_0x1c4c28::
	text "Hello, dear."

	para "I sell inexpensive"
	line "herbal medicine."

	para "They're good, but"
	line "a trifle bitter."

	para "Your #mon may"
	line "not like them."

	para "Hehehehe…"
	done

UnknownText_0x1c4ca3::
	text "How many?"
	done

UnknownText_0x1c4cae::
	deciram wItemQuantityChangeBuffer, 1, 2
	text " @"
	text_from_ram StringBuffer2
	text "(s)"
	line "will be ¥@"
	deciram hMoneyTemp, 3, 7
	text "."
	done

UnknownText_0x1c4cce::
	text "Thank you, dear."
	line "Hehehehe…"
	done

UnknownText_0x1c4cea::
	text "Oh? Your Bag is"
	line "full, dear."
	done

UnknownText_0x1c4d08::
	text "Hehehe… You don't"
	line "have the money."
	done

UnknownText_0x1c4d2a::
	text "Come again, dear."
	line "Hehehehe…"
	done

UnknownText_0x1c4d47::
	text "Hiya! Care to see"
	line "some bargains?"

	para "I sell rare items"
	line "that nobody else"

	para "carries--but only"
	line "one of each item."
	done

UnknownText_0x1c4db0::
	text_from_ram StringBuffer2
	text " costs"
	line "¥@"
	deciram hMoneyTemp, 3, 7
	text ". Want it?"
	done

UnknownText_0x1c4dcd::
	text "Thanks."
	done

UnknownText_0x1c4dd6::
	text "Uh-oh, your Bag"
	line "is chock-full."
	done

UnknownText_0x1c4df7::
	text "You bought that"
	line "already. I'm all"
	cont "sold out of it."
	done

UnknownText_0x1c4e28::
	text "Uh-oh, you're"
	line "short on funds."
	done

UnknownText_0x1c4e46::
	text "Come by again"
	line "sometime."
	done

UnknownText_0x1c4e5f::
	text "What's up? Need"
	line "some medicine?"
	done

UnknownText_0x1c4e7e::
	text "How many?"
	done

UnknownText_0x1c4e89::
	deciram wItemQuantityChangeBuffer, 1, 2
	text " @"
	text_from_ram StringBuffer2
	text "(s)"
	line "will cost ¥@"
	deciram hMoneyTemp, 3, 7
	text "."
	done

UnknownText_0x1c4eab::
	text "Thanks much!"
	done

UnknownText_0x1c4eb9::
	text "You don't have any"
	line "more space."
	done

UnknownText_0x1c4ed8::
	text "Huh? That's not"
	line "enough money."
	done

UnknownText_0x1c4ef6::
	text "All right."
	line "See you around."
	done

UnknownText_0x1c4f33::
	text "How many?"
	done

UnknownText_0x1c4f3e::
	text "I can pay you"
	line "¥@"
	deciram hMoneyTemp, 3, 7
	text "."

	para "Is that OK?"
	done

UnknownText_0x1c4f62::
	text "Welcome! How may I"
	line "help you?"
	done

UnknownText_0x1c4f80::
	text "Here you are."
	line "Thank you!"
	done

UnknownText_0x1c4f9a::
	text "You don't have"
	line "enough money."
	done

UnknownText_0x1c4fb7::
	text "You can't carry"
	line "any more items."
	done

UnknownText_0x1c4fd7::
	text "Sorry, I can't buy"
	line "that from you."
	prompt

UnknownText_0x1c4ff9::
	text "Please come again!"
	done

UnknownText_0x1c500d::
	text "Can I do anything"
	line "else for you?"
	done

UnknownText_0x1c502e::
	text "Got ¥@"
	deciram hMoneyTemp, 3, 7
	text " for"
	line "@"
	text_from_ram StringBuffer2
	text "(s)."
	done

UnknownText_0x1c5049::
	text "Bet how many"
	line "coins?"
	done

TMMartCostsThisMuchText::
	text "@"
	text_from_ram StringBuffer2
	text " @"
	text_from_ram StringBuffer1
	text ""
	line "will be ¥@"
	deciram hMoneyTemp, 3, 7
	text "."
	done

BTMartHowMayIHelpYouText::
	text "Welcome to the"
	line "Exchange Service"
	cont "Corner!"

	para "You can trade your"
	line "BP for prizes."
	done

BTMartCostsThisMuchText::
	deciram wItemQuantityChangeBuffer, 1, 2
	text " @"
	text_from_ram StringBuffer1
	text "(s)"
	line "will cost @"
	deciram hMoneyTemp, 3, 3
	text " BP."
	done

BTMartInsufficientFundsText::
	text "I'm sorry, but you"
	line "don't have enough"
	cont "BP."
	done

BTMartBagFullText::
	text "I'm sorry, but your"
	line "Bag is full."
	done

BTMartComeAgainText::
	text "Please come back"
	line "any time you want!"
	done
