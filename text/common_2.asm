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
	deciram wStringBuffer2, 2, 4
	text " Exp. Points!"
	prompt

Text_StringBuffer2ExpPoints::
	text ""
	line "@"
	deciram wStringBuffer2, 2, 4
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
	prompt

UnknownText_0x1c0384::
	text "Booted up an HM."
	prompt

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
