WadeAnswerPhoneText:
	text "Hello? This is"
	line ""
	text_ram wStringBuffer3
	text " speaking."

	para "Oh. Hi, <PLAYER>!"
	line "Good morning!"
	done

WadeAnswerPhoneDayText:
	text "Hello? This is"
	line ""
	text_ram wStringBuffer3
	text " speaking."

	para "Oh, hi, <PLAYER>!"
	done

WadeAnswerPhoneNiteText:
	text "Hello? This is"
	line ""
	text_ram wStringBuffer3
	text " speaking."

	para "Oh, hi, <PLAYER>!"
	line "Good evening!"
	done

WadeGreetText:
	text "<PLAYER>, good"
	line "morning!"

	para "It's me, "
	text_ram wStringBuffer3
	text "."
	line "Isn't it nice out?"
	done

WadeGreetDayText:
	text "<PLAYER>, howdy!"

	para "It's me, "
	text_ram wStringBuffer3
	text "."
	line "Isn't it nice out?"
	done

WadeGreetNiteText:
	text "Good evening,"
	line "<PLAYER>!"

	para "It's me, "
	text_ram wStringBuffer3
	text "."
	line "Were you awake?"
	done

WadeGenericText:
	text "How are your"
	line "#mon doing?"

	para "My #mon have"
	line "too much energy to"

	para "burn. It gets to"
	line "be a problem."

	para "Of all my #mon,"
	line ""
	text_ram wStringBuffer4
	text " is the"
	cont "hardest to handle."

	para "Working with it is"
	line "exhausting."
	done
