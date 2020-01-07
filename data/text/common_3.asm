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
	text_from_ram wStringBuffer1
	text " appears"
	cont "to be abnormal!"
	prompt

UnknownText_0x1c4212::
	text "Trade @"
	text_from_ram wd004
	text ""
	line "for @"
	text_from_ram wStringBuffer1
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
	text_from_ram wStringBuffer4
	text "."
	done

UnknownText_0x1c472c::
	text "<PLAYER> put the"
	line "@"
	text_from_ram wStringBuffer1
	text " in"
	cont "the @"
	text_from_ram wStringBuffer3
	text "."
	prompt

UnknownText_0x1c474b::
	text "The @"
	text_from_ram wStringBuffer3
	text ""
	line "is full…"
	prompt

UnknownText_0x1c4b92::
	text "Congratulations!"
	line "Your @"
	text_from_ram wStringBuffer2
	db "@@"

UnknownText_0x1c4baf::
	text ""
	para "evolved into"
	line "@"
	text_from_ram wStringBuffer1
	text "!"
	done

UnknownText_0x1c4bc5::
	text "Huh? @"
	text_from_ram wStringBuffer2
	text ""
	line "stopped evolving!"
	prompt

UnknownText_0x1c4be3::
	text "What? @"
	text_from_ram wStringBuffer2
	text ""
	line "is evolving!"
	done

UnknownText_0x1c4bfd::
	text "How many?"
	done

UnknownText_0x1c4c08::
	deciram wItemQuantityChangeBuffer, 1, 2
	text " @"
	text_from_ram wStringBuffer2
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
	text_from_ram wStringBuffer2
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
	text_from_ram wStringBuffer2
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
	text_from_ram wStringBuffer2
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
	text_from_ram wStringBuffer2
	text "(s)."
	done

UnknownText_0x1c5049::
	text "Bet how many"
	line "coins?"
	done

TMMartCostsThisMuchText::
	text "@"
	text_from_ram wStringBuffer2
	text " @"
	text_from_ram wStringBuffer1
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
	text_from_ram wStringBuffer1
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

UnknownText_0x1c505e::
	text "Start!"
	done

UnknownText_0x1c5066::
	text "Not enough"
	line "coins."
	prompt

UnknownText_0x1c5079::
	text "Darn… Ran out of"
	line "coins…"
	done

UnknownText_0x1c5092::
	text "Play again?"
	done

UnknownText_0x1c509f::
	text "lined up!"
	line "Won @"
	text_from_ram wStringBuffer2
	text " coins!"
	done

UnknownText_0x1c50bb::
	text "Darn!"
	done

UnknownText_0x1c5565::
	text "Huh? Sorry, wrong"
	line "number!"
	done

UnknownText_0x1c5580::
	text "Click!"
	done

UnknownText_0x1c5588::
	text "……"
	done

UnknownText_0x1c558b::
	text "That number is out"
	line "of the area."
	done

UnknownText_0x1c55ac::
	text "Just go talk to"
	line "that person!"
	done

UnknownText_0x1c55db::
	text "Select Continue to"
	line "set the time."
	prompt

UnknownText_0x1c561c::
	text "Reset the clock?"
	done

UnknownText_0x1c564a::
	text "Clear all save"
	line "data?"
	done

ResetInitialOptionsText::
	text "Reset the initial"
	line "game options?"
	done

UnknownText_0x1c5660::
	text_from_ram wMonOrItemNameBuffer
	text " learned"
	line "@"
	text_from_ram wStringBuffer2
	text "!@"
	sound_dex_fanfare_50_79
	text_waitbutton
	db "@@"

UnknownText_0x1c5678::
	text "Which move should"
	next "be forgotten?"
	prompt

UnknownText_0x1c5699::
	text "Stop learning"
	line "@"
	text_from_ram wStringBuffer2
	text "?"
	done

UnknownText_0x1c56af::
	text_from_ram wMonOrItemNameBuffer
	text ""
	line "did not learn"
	cont "@"
	text_from_ram wStringBuffer2
	text "."
	prompt

UnknownText_0x1c56c9::
	text_from_ram wMonOrItemNameBuffer
	text ""
	line "wants to learn"
	cont "@"
	text_from_ram wStringBuffer2
	text "!"

	para "Should it forget"
	line "an old move for"
	cont "@"
	text_from_ram wStringBuffer2
	text "?"
	done

UnknownText_0x1c5740::
	text "1, 2 and…@"
	interpret_data
	db "@@"

UnknownText_0x1c574e::
	text " Poof!@"
	interpret_data
	text ""
	para "@"
	text_from_ram wMonOrItemNameBuffer
	text " forgot"
	line "@"
	text_from_ram wStringBuffer1
	text "."

	para "And…"
	prompt

UnknownText_0x1c5772::
	text "HM moves can't be"
	line "forgotten now."
	prompt

UnknownText_0x1c5793::
	text "Play with three"
	line "coins?"
	done

UnknownText_0x1c57ab::
	text "Not enough coins…"
	prompt

UnknownText_0x1c57be::
	text "Choose a card."
	done

UnknownText_0x1c57ce::
	text "Place your bet."
	done

UnknownText_0x1c57df::
	text "Want to play"
	line "again?"
	done

UnknownText_0x1c57f4::
	text "The cards have"
	line "been shuffled."
	prompt

UnknownText_0x1c5813::
	text "Yeah!"
	done

UnknownText_0x1c581a::
	text "Darn…"
	done

UnknownText_0x1c5821::
	current_day
	db "@@"

UnknownText_0x1c5824::
	text "……"
	done

UnknownText_0x1c5827::
	text "You're out of the"
	line "service area."
	prompt

UnknownText_0x1c5847::
	text "Whom do you want"
	line "to call?"
	done

UnknownText_0x1c5862::
	text "Press any button"
	line "to exit."
	done

UnknownText_0x1c587d::
	text "Delete this stored"
	line "phone number?"
	done

UnknownText_0x1c589f::
	text "You can cash in"
	line "your saved points"

	para "for a lovely prize"
	line "of your choice!"

	para "Which prize would"
	line "you like?"
	done

UnknownText_0x1c58bc::
	text_from_ram wStringBuffer1
	text "?"
	line "Is that right?"
	done

UnknownText_0x1c58d1::
	text "Here you go!"
	done

UnknownText_0x1c58e0::
	text "You don't have"
	line "enough points."
	done

UnknownText_0x1c58ff::
	text "You have no room"
	line "for it."
	done

UnknownText_0x1c591a::
	text "Oh. Please come"
	line "back again!"
	done

Text_ExcuseMeYoureNotReady::
	text "Excuse me."
	line "You're not ready."
	para ""
	done

UnknownText_0x1c5962::
	text "Please return when"
	line "you're ready."
	done

Text_OnlyThreePkmnMayBeEntered::
	text "Three #mon"
	line "must be entered."
	para ""
	done

Text_ThePkmnMustAllBeDifferentKinds::
	text "The three #mon"
	line "must all be"
	cont "different kinds."
	para ""
	done

Text_ThePkmnMustNotHoldTheSameItems::
	text "The three #mon"
	line "must not hold the"
	cont "same items."
	para ""
	done

Text_YouCantTakeAnEgg::
	text "You can't take an"
	line "Egg!"
	para ""
	done

Text_UberRestriction::
	text_from_ram wStringBuffer1
	text " must be"
	line "<LV>70 or higher."
	para ""
	done

UnknownText_0x1c5aa6::
	text "Oh no! The #mon"
	line "broke free!"
	prompt

UnknownText_0x1c5ac3::
	text "Aww! It appeared"
	line "to be caught!"
	prompt

UnknownText_0x1c5ae3::
	text "Aargh!"
	line "Almost had it!"
	prompt

UnknownText_0x1c5afa::
	text "Shoot! It was so"
	line "close too!"
	prompt

UnknownText_0x1c5b17::
	text "Gotcha! @"
	text_from_ram wEnemyMonNick
	text ""
	line "was caught!@"
	sound_caught_mon
	db "@@"

Text_Waitbutton_2::
	text_waitbutton
	db "@@"

UnknownText_0x1c5b38::
	text_from_ram wMonOrItemNameBuffer
	text " was"
	line "sent to Bill's PC."
	prompt

UnknownText_0x1c5b53::
	text_from_ram wEnemyMonNick
	text "'s data"
	line "was newly added to"
	cont "the #dex.@"
	sound_slot_machine_start
	text_waitbutton
	db "@@"

UnknownText_0x1c5b7f::
	text "Give a nickname to"
	line "@"
	text_from_ram wStringBuffer1
	text "?"
	done

_ItemHappinessRoseButStatFellText::
	text_from_ram wStringBuffer1
	text " became"
	line "friendly. Base"
	cont "@"
	text_from_ram wStringBuffer2
	text " fell!"
	prompt

_ItemStatRoseText::
	text_from_ram wStringBuffer1
	text "'s"
	line "@"
	text_from_ram wStringBuffer2
	text " rose."
	prompt

UnknownText_0x1c5bac::
	text "That can't be used"
	line "on this #mon."
	prompt

Text_RepelUsedEarlierIsStillInEffect::
	text "The Repel used"
	line "earlier is still"
	cont "in effect."
	prompt

UnknownText_0x1c5c5e::
	text "You now have"
	line "@"
	deciram wBlueCardBalance, 1, 2
	text " points."
	done

UnknownText_0x1c5c7b::
	text "Coins:"
	line "@"
	deciram wCoins, 2, 5
	db "@@"

Text_RaiseThePPOfWhichMove::
	text "Raise the PP of"
	line "which move?"
	done

Text_RestoreThePPOfWhichMove::
	text "Restore the PP of"
	line "which move?"
	done

Text_PPIsMaxedOut::
	text_from_ram wStringBuffer2
	text "'s PP"
	line "is maxed out."
	prompt

Text_PPsIncreased::
	text_from_ram wStringBuffer2
	text "'s PP"
	line "increased."
	prompt

Text_PPsMaximized::
	text_from_ram wStringBuffer2
	text "'s PP"
	line "maximized."
	prompt

UnknownText_0x1c5cf1::
	text "PP was restored."
	prompt

UnknownText_0x1c5d3e::
	text "It looks bitter…"
	prompt

UnknownText_0x1c5d50::
	text "That can't be used"
	line "on an Egg."
	prompt

UnknownText_0x1c5d6e::
	text "Oak: <PLAYER>!"
	line "This isn't the"
	cont "time to use that!"
	prompt

UnknownText_0x1c5db6::
	text "It won't have any"
	line "effect."
	prompt

UnknownText_0x1c5dd0::
	text "The trainer"
	line "blocked the Ball!"
	prompt

UnknownText_0x1c5def::
	text "Don't be a thief!"
	prompt

UnknownText_0x1c5e3a::
	text "The #mon Box"
	line "is full. That"
	cont "can't be used now."
	prompt

Text_MonIsHiddenFromBall::
	text "The #mon can't"
	line "be seen!"
	prompt

Text_MonCantBeCaught::
	text "The #mon can't"
	line "be caught!"
	prompt

Text_NuzlockeBallFailure::
	text "You already"
	line "encountered a"
	cont "#mon here."
	prompt

Text_NuzlockeReviveFailure::
	text "You can't revive"
	line "#mon in"
	cont "Nuzlocke mode!"
	prompt

UnknownText_0x1c5e68::
	text "<PLAYER> used the@"
	text_low
	text_from_ram wStringBuffer2
	text "."
	done

UnknownText_0x1c5ea8::
	text_from_ram wStringBuffer1
	text " knows"
	line "@"
	text_from_ram wStringBuffer2
	text "."
	prompt

UnknownText_0x1c5eba::
	text "That #mon knows"
	line "only one move."
	done

UnknownText_0x1c5eda::
	text "Oh, make it forget"
	line "@"
	text_from_ram wStringBuffer1
	text "?"
	done

UnknownText_0x1c5ef5::
	text "Done! Your #mon"
	line "forgot the move."
	done

UnknownText_0x1c5f17::
	text "An Egg doesn't"
	line "know any moves!"
	done

UnknownText_0x1c5f36::
	text "No? Come visit me"
	line "again."
	done

UnknownText_0x1c5f50::
	text "Which move should"
	line "it forget, then?"
	prompt

UnknownText_0x1c5f74::
	text "Um… Oh, yes, I'm"
	line "the Move Deleter."

	para "I can make #mon"
	line "forget moves."

	para "Shall I make a"
	line "#mon forget?"
	done

UnknownText_0x1c5fd1::
	text "Which #mon?"
	prompt

Text_DSTIsThatOK::
	text " DST,"
	line "is that OK?"
	done

UnknownText_0x1c5ff1::
	text ","
	line "is that OK?"
	done

UnknownText_0x1c6000::
	text "Do you want to"
	line "switch to Daylight"
	cont "Saving Time?"
	done

UnknownText_0x1c6030::
	text "I set the clock"
	line "forward by one"
	cont "hour."
	prompt

UnknownText_0x1c6056::
	text "Is Daylight Saving"
	line "Time over?"
	done

UnknownText_0x1c6075::
	text "I put the clock"
	line "back one hour."
	prompt

UnknownText_0x1c6095::
	text "Do you want to"
	line "adjust your clock"

	para "for Daylight"
	line "Saving Time?"
	done

UnknownText_0x1c60d1::
	text "I lost the in-"
	line "struction booklet"
	cont "for the #gear."

	para "Come back again in"
	line "a while."
	prompt

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

WonderTradeConfirmText::
	text "Offer to trade"
	line "@"
	text_from_ram wStringBuffer1
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
