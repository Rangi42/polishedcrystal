GinaAnswerPhoneText:
	text "Hello? This is"
	line ""
	text_ram wStringBuffer3
	text "…"

	para "Oh, <PLAYER>!"
	line "Good morning!"
	done

GinaAnswerPhoneDayText:
	text "Hello? This is"
	line ""
	text_ram wStringBuffer3
	text "…"

	para "Oh, <PLAYER>!"
	line "Hi, how are you?"
	done

GinaAnswerPhoneNiteText:
	text "Hello? This is"
	line ""
	text_ram wStringBuffer3
	text "…"

	para "Oh, <PLAYER>!"
	line "Good evening!"
	done

GinaGreetText:
	text "<PLAYER>?"

	para "It's "
	text_ram wStringBuffer3
	text "."
	line "Good morning!"
	done

GinaGreetDayText:
	text "<PLAYER>?"

	para "It's "
	text_ram wStringBuffer3
	text ". Is"
	line "this a bad time?"
	done

GinaGreetNiteText:
	text "<PLAYER>?"

	para "It's "
	text_ram wStringBuffer3
	text "."
	line "Got time to chat?"
	done

GinaGenericText:
	text "Are your #mon"
	line "still tough?"

	para "I train every day"
	line "with "
	text_ram wStringBuffer4
	text "."
	done
