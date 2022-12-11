BethAnswerPhoneText:
	text "Hello, this is"
	line ""
	text_ram wStringBuffer3
	text "."
	para "Oh, <PLAYER>."
	line "Good morning."
	para ""
	done

BethAnswerPhoneDayText:
	text "Hello, this is"
	line ""
	text_ram wStringBuffer3
	text "."

	para "Oh. Hi, <PLAYER>."
	done

BethAnswerPhoneNiteText:
	text "Hello, this is"
	line ""
	text_ram wStringBuffer3
	text "."

	para "Oh, <PLAYER>."
	line "Good evening."
	done

BethGreetText:
	text "Good morning,"
	line "<PLAYER>!"

	para "This is "
	text_ram wStringBuffer3
	text "."
	line "Were you sleeping?"
	done

BethGreetDayText:
	text "<PLAYER>, hi!"
	line "This is "
	text_ram wStringBuffer3
	text "."

	para "Do you have some"
	line "time?"
	done

BethGreetNiteText:
	text "Hi, <PLAYER>."
	line "Good evening."

	para "This is "
	text_ram wStringBuffer3
	text "."

	para "I hope you were"
	line "awake."
	done

BethGenericText:
	text "Are you the kind"
	line "of person who goes"

	para "to #mon Centers"
	line "often?"

	para "I go every day."
	line "Watching out for"

	para "the health of your"
	line "#mon is a basic"

	para "part of being a"
	line "#mon trainer."
	done
