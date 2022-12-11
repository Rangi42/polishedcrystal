AlanAnswerPhoneText:
	text "Yup, it's "
	text_ram wStringBuffer3
	text "!"

	para "Is this <PLAYER>?"
	line "Good morning!"
	done

AlanAnswerPhoneDayText:
	text "Yup, it's "
	text_ram wStringBuffer3
	text "!"

	para "Is that <PLAYER>?"
	done

AlanAnswerPhoneNiteText:
	text "Yup, it's "
	text_ram wStringBuffer3
	text "!"

	para "Is that <PLAYER>?"
	line "Good evening!"
	done

AlanGreetText:
	text "Hello! It's me,"
	line ""
	text_ram wStringBuffer3
	text "!"
	done

AlanGreetDayText:
	text "Hello! It's me,"
	line ""
	text_ram wStringBuffer3
	text "!"
	done

AlanGreetNiteText:
	text "Hello! It's me,"
	line ""
	text_ram wStringBuffer3
	text "!"
	done

AlanGenericText:
	text "<PLAYER>, are you"
	line "raising your"
	cont "#mon properly?"

	para "I read in a book"
	line "that you should"

	para "raise any #mon"
	line "you catch with"
	cont "love and care."
	done
