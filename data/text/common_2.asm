UnknownText_0x1c0043::
	text "Hello, hello! I'm"
	line "the Name Rater."

	para "I rate the names"
	line "of #mon."

	para "Would you like me"
	line "to rate names?"
	done

UnknownText_0x1c00a0::
	text "Which #mon's"
	line "nickname should I"
	cont "rate for you?"
	prompt

UnknownText_0x1c00cd::
	text "Hm… @"
	text_from_ram wStringBuffer1
	text "…"
	line "That's a fairly"
	cont "decent name."

	para "But, how about a"
	line "slightly better"
	cont "nickname?"

	para "Want me to give it"
	line "a better name?"
	done

UnknownText_0x1c0142::
	text "All right. What"
	line "name should we"
	cont "give it, then?"
	prompt

UnknownText_0x1c0171::
	text "That's a better"
	line "name than before!"

	para "Well done!"
	done

UnknownText_0x1c019e::
	text "OK, then. Come"
	line "again sometime."
	done

UnknownText_0x1c01be::
	text "Hm… @"
	text_from_ram wStringBuffer1
	text "?"
	line "What a great name!"
	cont "It's perfect."

	para "Treat @"
	text_from_ram wStringBuffer1
	text ""
	line "with loving care."
	done

UnknownText_0x1c0208::
	text "Whoa… That's just"
	line "an Egg."
	done

UnknownText_0x1c0222::
	text "It might look the"
	line "same as before,"

	para "but this new name"
	line "is much better!"

	para "Well done!"
	done

UnknownText_0x1c0272::
	text "All right. This"
	line "#mon is now"
	cont "named @"
	text_from_ram wStringBuffer1
	text "."
	prompt

Text_Gained::
	text_from_ram wStringBuffer1
	text " gained@@"

Text_ABoostedStringBuffer2ExpPoints::
	text ""
	line "a boosted"
	cont "@"
	deciram wStringBuffer2, 3, 6
	text " Exp. Points!"
	prompt

Text_StringBuffer2ExpPoints::
	text ""
	line "@"
	deciram wStringBuffer2, 3, 6
	text " Exp. Points!"
	prompt

Text_GoPkmn::
	text "Go! @@"

Text_DoItPkmn::
	text "Do it! @@"

Text_GoForItPkmn::
	text "Go for it,"
	line "@@"

Text_YourFoesWeakGetmPkmn::
	text "Your foe's weak!"
	line "Get'm, @@"

Text_BattleMonNick01::
	text_from_ram wBattleMonNick
	text "!"
	done

Text_BattleMonNickComma::
	text_from_ram wBattleMonNick
	text ",@@"

Text_ThatsEnoughComeBack::
	text " that's"
	line "enough! Come back!@@"

Text_OKComeBack::
	text " OK!"
	line "Come back!@@"

Text_GoodComeBack::
	text " good!"
	line "Come back!@@"

Text_ComeBack::
	text " come"
	line "back!"
	done

UnknownText_0x1c0373::
	text "Booted up a TM."
	done

UnknownText_0x1c0384::
	text "Booted up an HM."
	done

UnknownText_0x1c0396::
	text "It contained"
	line "@"
	text_from_ram wStringBuffer2
	text "."

	para "Teach @"
	text_from_ram wStringBuffer2
	text ""
	line "to a #mon?"
	done

UnknownText_0x1c03c2::
	text_from_ram wStringBuffer2
	text " is"
	line "not compatible"
	cont "with @"
	text_from_ram wStringBuffer1
	text "."

	para "It can't learn"
	line "@"
	text_from_ram wStringBuffer2
	text "."
	prompt

_BadgeRequiredText::
	text "Sorry! A new Badge"
	line "is required."
	prompt

UnknownText_0x1c05c8::
	text "Can't use that"
	line "here."
	prompt

UnknownText_0x1c05dd::
	text_from_ram wStringBuffer2
	text " used"
	line "Cut!"
	prompt

UnknownText_0x1c05ec::
	text "There's nothing to"
	line "Cut here."
	prompt

UnknownText_0x1c0609::
	text "A blinding Flash"
	line "lights the area!@"
	text_waitbutton
	db "@@"

_UsedSurfText::
	text_from_ram wStringBuffer2
	text " used"
	line "Surf!"
	done

_CantSurfText::
	text "You can't Surf"
	line "here."
	prompt

_AlreadySurfingText::
	text "You're already"
	line "Surfing."
	prompt

_AskSurfText::
	text "The water is calm."
	line "Want to Surf?"
	done

UnknownText_0x1c068e::
	text_from_ram wStringBuffer2
	text " used"
	line "Waterfall!"
	done

UnknownText_0x1c06a3::
	text "Wow, it's a huge"
	line "waterfall."
	done

UnknownText_0x1c06bf::
	text "Do you want to use"
	line "Waterfall?"
	done

UnknownText_0x1c06de::
	text_from_ram wStringBuffer2
	text " used"
	line "Dig!"
	done

UnknownText_0x1c06ed::
	text "<PLAYER> used an"
	line "Escape Rope."
	done

UnknownText_0x1c0705::
	text "Can't use that"
	line "here."
	done

UnknownText_0x1c073b::
	text "Can't use that"
	line "here."

	para ""
	done

UnknownText_0x1c0774::
	text_from_ram wStringBuffer2
	text " used"
	line "Strength!"
	done

UnknownText_0x1c0788::
	text_from_ram wStringBuffer1
	text " can"
	line "move boulders."
	prompt

UnknownText_0x1c07a0::
	text "A #mon may be"
	line "able to move this."

	para "Want to use"
	line "Strength?"
	done

UnknownText_0x1c07d8::
	text "Boulders may now"
	line "be moved!"
	done

UnknownText_0x1c07f4::
	text "A #mon may be"
	line "able to move this."
	done

UnknownText_0x1c0816::
	text_from_ram wStringBuffer2
	text " used"
	line "Whirlpool!"
	prompt

UnknownText_0x1c082b::
	text "It's a vicious"
	line "whirlpool!"

	para "A #mon may be"
	line "able to pass it."
	done

UnknownText_0x1c0864::
	text "A whirlpool is in"
	line "the way."

	para "Want to use"
	line "Whirlpool?"
	done

UnknownText_0x1c0897::
	text_from_ram wStringBuffer2
	text " did a"
	line "Headbutt!"
	prompt

UnknownText_0x1c08ac::
	text "Nope. Nothing…"
	done

UnknownText_0x1c08bc::
	text "A #mon could be"
	line "in this tree."

	para "Want to Headbutt"
	line "it?"
	done

UnknownText_0x1c08f0::
	text_from_ram wStringBuffer2
	text " used"
if DEF(FAITHFUL)
	line "Rock Smash!"
else
	line "Brick Break!"
endc
	prompt

UnknownText_0x1c0906::
	text "Maybe a #mon"
	line "can break this."
	done

UnknownText_0x1c0924::
	text "This rock looks"
	line "breakable."

if DEF(FAITHFUL)
	para "Want to use Rock"
	line "Smash?"
else
	para "Want to use Brick"
	line "Break?"
endc
	done

UnknownText_0x1c0958::
	text "Oh!"
	line "A bite!"
	prompt

UnknownText_0x1c0965::
	text "Not even a nibble!"
	prompt

UnknownText_0x1c099a::
	text "You can't get off"
	line "here!"
	done

UnknownText_0x1c09b2::
	text "<PLAYER> got on the"
	line "@"
	text_from_ram wStringBuffer2
	text "."
	done

UnknownText_0x1c09c7::
	text "<PLAYER> got off"
	line "the @"
	text_from_ram wStringBuffer2
	text "."
	done

UnknownText_0x1c09dd::
	text "This tree can be"
	line "Cut!"

	para "Want to use Cut?"
	done

UnknownText_0x1c0a05::
	text "This tree can be"
	line "Cut!"
	done

UnknownText_0x1c0a1c::
	text "<PLAYER> found"
	line "@"
	text_from_ram wStringBuffer3
	text "!"
	done

WhiteoutText::
	text "<PLAYER> is out of"
	line "useable #mon!"

	para "<PLAYER> blacked"
	line "out!"
	done

WhiteoutToWildText::
	text "<PLAYER> is out of"
	line "useable #mon!"

	para "<PLAYER> panicked"
	line "and dropped"
	cont "¥@"
	deciram hMoneyTemp, 3, 7
	text "…"

	para "………………"
	line "………………"

	para "<PLAYER> blacked"
	line "out!"
	done

WhiteoutToTrainerText::
	text "<PLAYER> is out of"
	line "useable #mon!"

	para "<PLAYER> paid"
	line "¥@"
	deciram hMoneyTemp, 3, 7
	text " to the"
	cont "winner…"

	para "………………"
	line "………………"

	para "<PLAYER> blacked"
	line "out!"
	done

ForfeitToTrainerText::
	text "<PLAYER> forfeit-"
	line "ed the battle…"

	para "<PLAYER> paid"
	line "¥@"
	deciram hMoneyTemp, 3, 7
	text " to the"
	cont "winner…"

	para "………………"
	line "………………"

	para "<PLAYER> blacked"
	line "out!"
	done

UnknownText_0x1c0acc::
	text_from_ram wStringBuffer3
	text ""
	line "recovered from"
	cont "its poisoning!"
	prompt

UnknownText_0x1c0b3b::
	text "<PLAYER> sprinkled"
	line "water."

	para "But nothing"
	line "happened…"
	done

UnknownText_0x1c0b65::
	text "<PLAYER>'s #mon"
	line "were all healed!"
	done

Text_AnEGGCantHoldAnItem::
	text "An Egg can't hold"
	line "an item."
	prompt

UnknownText_0x1c0ba5::
	text "Throw away how"
	line "many?"
	done

UnknownText_0x1c0bbb::
	text "Throw away @"
	deciram wItemQuantityChangeBuffer, 1, 2
	text ""
	line "@"
	text_from_ram wStringBuffer2
	text "(s)?"
	done

UnknownText_0x1c0bd8::
	text "Threw away"
	line "@"
	text_from_ram wStringBuffer2
	text "(s)."
	prompt

UnknownText_0x1c0bee::
	text "Oak: <PLAYER>!"
	line "This isn't the"
	cont "time to use that!"
	prompt

Text_YouDontHaveAPkmn::
	text "You don't have a"
	line "#mon!"
	prompt

UnknownText_0x1c0c2e::
	text "Registered the"
	line "@"
	text_from_ram wStringBuffer2
	text "."
	prompt

UnknownText_0x1c0c45::
	text "You can't register"
	line "that item."
	prompt

UnknownText_0x1c0c63::
	text "Where should this"
	line "be moved to?"
	done

UnknownText_0x1c0c83::
	text ""
	done

Text_AreYouABoyOrAreYouAGirl::
	text "Are you a boy?"
	line "Or are you a girl?"
	done

Text_SoYoureABoy::
	text "So you're a boy?"
	done

Text_SoYoureAGirl::
	text "So you're a girl?"
	done

UnknownText_0x1c0d0e::
	text "<USER>@@"

UnknownText_0x1c0d26::
	text ""
	line "took in sunlight!"
	prompt

UnknownText_0x1c0d5c::
	text ""
	line "flew up high!"
	prompt

UnknownText_0x1c0d6c::
	text ""
	line "dug a hole!"
	prompt

UnknownText_0x1c0db0::
	text "Huh?"
	para "@@"

UnknownText_0x1c0db8::
	text ""
	done

UnknownText_0x1c0dba::
	text_from_ram wStringBuffer1
	text " came"
	line "out of its Egg!@"
	sound_caught_mon
	text_waitbutton
	db "@@"

UnknownText_0x1c0dd8::
	text "Give a nickname to"
	line "@"
	text_from_ram wStringBuffer1
	text "?"
	done

UnknownText_0x1c0df3::
	text "It's @"
	text_from_ram wBreedMon2Nick
	text ""
	line "that was left with"
	cont "the Day-Care Lady."
	done

UnknownText_0x1c0e24::
	text "It's @"
	text_from_ram wBreedMon1
	text ""
	line "that was left with"
	cont "the Day-Care Man."
	done

UnknownText_0x1c0e6f::
	text "It has no interest"
	line "in @"
	text_from_ram wStringBuffer1
	text "."
	prompt

UnknownText_0x1c0e8d::
	text "It appears to care"
	line "for @"
	text_from_ram wStringBuffer1
	text "."
	prompt

UnknownText_0x1c0eac::
	text "It's friendly with"
	line "@"
	text_from_ram wStringBuffer1
	text "."
	prompt

UnknownText_0x1c0ec6::
	text "It shows interest"
	line "in @"
	text_from_ram wStringBuffer1
	text "."
	prompt

_EmptyMailboxText::
	text "There's no Mail"
	line "here."
	prompt

ClearedMailPutAwayText::
	text "The cleared Mail"
	line "was put away."
	prompt

MailPackFullText::
	text "The Bag is full."
	prompt

MailMessageLostText::
	text "The Mail's message"
	line "will be lost. OK?"
	done

MailAlreadyHoldingItemText::
	text "It's already hold-"
	line "ing an item."
	prompt

MailEggText::
	text "An Egg can't hold"
	line "any Mail."
	prompt

MailMovedFromBoxText::
	text "The Mail was moved"
	line "from the Mailbox."
	prompt

Text_WasSentToBillsPC::
	text_from_ram wStringBuffer1
	text " was"
	line "sent to Bill's PC."
	prompt

UnknownText_0x1c1006::
	text "You gotta have"
	line "#mon to call!"
	prompt

UnknownText_0x1c1024::
	text "What?"
	done

UnknownText_0x1c102b::
	text "There is a #mon"
	line "holding Mail."

	para "Please remove the"
	line "Mail."
	prompt

UnknownText_0x1c10c0::
	text "Caught @"
	text_from_ram wStringBuffer1
	text "!"
	prompt

UnknownText_0x1c10cf::
	text "Switch #mon?"
	done

UnknownText_0x1c10dd::
	text "You already caught"
	line "a @"
	text_from_ram wStringBuffer1
	text "."
	prompt

ContestJudging_FirstPlaceText::
	text "This Bug-Catching"
	line "Contest winner is@"
	interpret_data
	text "…"

	para "@"
	text_from_ram wBugContestWinnerName
	text ","
	line "who caught a"
	cont "@"
	text_from_ram wStringBuffer1
	text "!@@"

ContestJudging_FirstPlaceScoreText::
	text ""

	para "The winning score"
	line "was @"
	deciram wBugContestFirstPlaceScore, 2, 3
	text " points!"
	prompt

ContestJudging_SecondPlaceText::
	text "Placing second was"
	line "@"
	text_from_ram wBugContestWinnerName
	text ","
	para "who caught a"
	line "@"
	text_from_ram wStringBuffer1
	text "!@@"

ContestJudging_SecondPlaceScoreText::
	text ""
	para "The score was"
	line "@"
	deciram wBugContestSecondPlaceScore, 2, 3
	text " points!"
	prompt

ContestJudging_ThirdPlaceText::
	text "Placing third was"
	line "@"
	text_from_ram wBugContestWinnerName
	text ","
	para "who caught a"
	line "@"
	text_from_ram wStringBuffer1
	text "!@@"

ContestJudging_ThirdPlaceScoreText::
	text ""
	para "The score was"
	line "@"
	deciram wBugContestThirdPlaceScore, 2, 3
	text " points!"
	prompt

UnknownText_0x1c1203::
	text "Let me measure"
	line "that Magikarp."

	para "…Hm, it measures"
	line "@"
	text_from_ram wStringBuffer1
	text "."
	prompt

UnknownText_0x1c123a::
	text "Current Record"
	para "@"
	text_from_ram wStringBuffer1
	text " caught by"
	line "@"
	text_from_ram wMagikarpRecordHoldersName
	text_waitbutton
	db "@@"

UnknownText_0x1c1261::
	text "Congratulations!"

	para "We have a match"
	line "with the ID number"

	para "of @"
	text_from_ram wStringBuffer1
	text " in"
	line "your party."
	prompt

UnknownText_0x1c12ae::
	text "Congratulations!"

	para "We have a match"
	line "with the ID number"

	para "of @"
	text_from_ram wStringBuffer1
	text " in"
	line "your PC Box."
	prompt

UnknownText_0x1c12fc::
	text "Give a nickname to"
	line "the @"
	text_from_ram wStringBuffer1
	text " you"
	cont "received?"
	done

UnknownText_0x1c1328::
	text "Bzzzzt! You must"
	line "have a #mon to"
	cont "use this!"
	prompt

UnknownText_0x1c1353::
	text "<PLAYER> turned on"
	line "the PC."
	prompt

UnknownText_0x1c1368::
	text "What do you want"
	line "to do?"
	done

_KrissPCHowManyWithdrawText::
	text "How many do you"
	line "want to withdraw?"
	done

_KrissPCWithdrewItemsText::
	text "Withdrew @"
	deciram wItemQuantityChangeBuffer, 1, 2
	text ""
	line "@"
	text_from_ram wStringBuffer2
	text "(s)."
	prompt

_KrissPCNoRoomWithdrawText::
	text "There's no room"
	line "for more items."
	prompt

UnknownText_0x1c13df::
	text "No items here!"
	prompt

_KrissPCCantDepositItemText::
	text "That item can't"
	line "be deposited."
	prompt

_KrissPCHowManyDepositText::
	text "How many do you"
	line "want to deposit?"
	done

_KrissPCDepositItemsText::
	text "Deposited @"
	deciram wItemQuantityChangeBuffer, 1, 2
	text ""
	line "@"
	text_from_ram wStringBuffer2
	text "(s)."
	prompt

_KrissPCNoRoomDepositText::
	text "There's no room to"
	line "store items."
	prompt

UnknownText_0x1c144d::
	text "<PLAYER> turned on"
	line "the PC."
	prompt

UnknownText_0x1c1462::
	text "Access whose PC?"
	done

UnknownText_0x1c1474::
	text "Bill's PC"
	line "accessed."

	para "#mon Storage"
	line "System opened."
	prompt

UnknownText_0x1c14a4::
	text "Accessed own PC."

	para "Item Storage"
	line "System opened."
	prompt

UnknownText_0x1c14d2::
	text "Prof.Oak's PC"
	line "accessed."

	para "#dex Rating"
	line "System opened."
	prompt

UnknownText_0x1c1505::
	text "…"
	line "Link closed…"
	done

_OakPCText1::
	text "Want to get your"
	line "#dex rated?"
	done

_OakPCText2::
	text "Current #dex"
	line "completion level:"
	prompt

_OakPCText3::
	text_from_ram wStringBuffer3
	text " #mon seen"
	line "@"
	text_from_ram wStringBuffer4
	text " #mon owned"

	para "Prof.Oak's"
	line "Rating:"
	done

_OakRating01::
	text "Look for #mon"
	line "in grassy areas!"
	done

_OakRating02::
	text "Good. I see you"
	line "understand how to"
	cont "use # Balls."
	done

_OakRating03::
	text "You're getting"
	line "good at this."

	para "But you have a"
	line "long way to go."
	done

_OakRating04::
	text "You need to fill"
	line "up the #dex."

	para "Catch different"
	line "kinds of #mon!"
	done

_OakRating05::
	text "You're trying--I"
	line "can see that."

	para "Your #dex is"
	line "coming together."
	done

_OakRating06::
	text "To evolve, some"
	line "#mon grow,"

	para "others use the"
	line "effects of Stones."
	done

_OakRating07::
	text "Have you gotten a"
	line "fishing Rod? You"

	para "can catch #mon"
	line "by fishing."
	done

_OakRating08::
	text "Excellent! You"
	line "seem to like col-"
	cont "lecting things!"
	done

_OakRating09::
	text "Some #mon only"
	line "appear during"

	para "certain times of"
	line "the day."
	done

_OakRating10::
	text "Your #dex is"
	line "filling up. Keep"
	cont "up the good work!"
	done

_OakRating11::
	text "I'm impressed."
	line "You're evolving"

	para "#mon, not just"
	line "catching them."
	done

_OakRating12::
	text "Have you met Kurt?"
	line "His custom Balls"
	cont "should help."
	done

_OakRating13::
	text "Wow. You've found"
	line "more #mon than"

	para "the last #dex"
	line "research project."
	done

_OakRating14::
	text "Are you trading"
	line "your #mon?"

	para "It's tough to do"
	line "this alone!"
	done

_OakRating15::
	text "Wow! You've hit"
	line "200! Your #dex"
	cont "is looking great!"
	done

_OakRating16::
	text "You've found so"
	line "many #mon!"

	para "You've really"
	line "helped my studies!"
	done

_OakRating17::
	text "Magnificent! You"
	line "could become a"

	para "#mon professor"
	line "right now!"
	done

_OakRating18::
	text "Your #dex is"
	line "amazing! You're"

	para "ready to turn"
	line "professional!"
	done

_OakRating19::
	text "Whoa! A perfect"
	line "#dex! I've"

	para "dreamt about this!"
	line "Congratulations!"
	done

_OakPCText4::
	text "The link to Prof."
	line "Oak's PC closed."
	done

UnknownText_0x1c1a5b::
	text " , yeah!"
	done

UnknownText_0x1c1a65::
	text "Darn…"
	done

UnknownText_0x1c1a6c::
	text "Would you like to"
	line "end the Contest?"
	done

UnknownText_0x1c1a90::
	text "Toss out how many"
	line "@"
	text_from_ram wStringBuffer2
	text "(s)?"
	done

UnknownText_0x1c1aad::
	text "Throw away @"
	deciram wItemQuantityChangeBuffer, 1, 2
	text ""
	line "@"
	text_from_ram wStringBuffer2
	text "(s)?"
	done

UnknownText_0x1c1aca::
	text "Discarded"
	line "@"
	text_from_ram wStringBuffer1
	text "(s)."
	prompt

UnknownText_0x1c1b03::
	text "Oak: <PLAYER>!"
	line "This isn't the"
	cont "time to use that!"
	done

UnknownText_0x1c1b2c::
	text "Took @"
	text_from_ram wMonOrItemNameBuffer
	text "'s"
	line "@"
	text_from_ram wStringBuffer1
	text " and"

	para "made it hold"
	line "@"
	text_from_ram wStringBuffer2
	text "."
	prompt

UnknownText_0x1c1b57::
	text "Made @"
	text_from_ram wMonOrItemNameBuffer
	text ""
	line "hold @"
	text_from_ram wStringBuffer2
	text "."
	prompt

UnknownText_0x1c1b6f::
	text "Please remove the"
	line "Mail first."
	prompt

UnknownText_0x1c1b8e::
	text_from_ram wMonOrItemNameBuffer
	text " isn't"
	line "holding anything."
	prompt

UnknownText_0x1c1baa::
	text "Item storage space"
	line "full."
	prompt

UnknownText_0x1c1bc4::
	text "Took @"
	text_from_ram wStringBuffer1
	text ""
	line "from @"
	text_from_ram wMonOrItemNameBuffer
	text "."
	prompt

UnknownText_0x1c1bdc::
	text_from_ram wMonOrItemNameBuffer
	text " is"
	line "already holding"

	para "@"
	text_from_ram wStringBuffer1
	text "."
	line "Switch items?"
	done

UnknownText_0x1c1c09::
	text "That item can't be"
	line "held."
	prompt

UnknownText_0x1c1c22::
	text "The Mail will lose"
	line "its message. OK?"
	done

UnknownText_0x1c1c47::
	text "Mail detached from"
	line "@"
	text_from_ram wStringBuffer1
	text "."
	prompt

UnknownText_0x1c1c62::
	text "There's no space"
	line "for removing Mail."
	prompt

UnknownText_0x1c1c86::
	text "Send the removed"
	line "Mail to your PC?"
	done

UnknownText_0x1c1ca9::
	text "Your PC's Mailbox"
	line "is full."
	prompt

UnknownText_0x1c1cc4::
	text "The Mail was sent"
	line "to your PC."
	prompt

UnknownText_0x1c1ce3::
	text "Not enough HP!"
	prompt

UnknownText_0x1c1cf3::
	text "An item in your"
	line "Bag may be"

	para "registered for use"
	line "on Select Button."
	done

_InitialOptionsText::
	text "Please choose how"
	line "you want to play"
	cont "Polished Crystal."
	prompt

_ElmText1::
	text "Hello! Sorry to"
	line "keep you waiting!"

if !DEF(DEBUG)
	para "Welcome to the"
	line "world of #mon!"

	para "My name is Elm."

	para "People call me the"
	line "#mon Prof."
endc
	prompt

_ElmText2::
	text "This world is in-"
	line "habited by crea-"
	cont "tures that we call"
	cont "#mon.@@"

_ElmText3::
	text_waitbutton
	db "@@"

_ElmText4::
	text "People and #mon"
	line "live together by"

	para "supporting each"
	line "other."

	para "Some people play"
	line "with #mon, some"
	cont "battle with them."
	prompt

_ElmText5::
	text "But we don't know"
	line "everything about"
	cont "#mon yet."

	para "There are still"
	line "many mysteries to"
	cont "solve."

	para "That's why I study"
	line "#mon every day."
	prompt
