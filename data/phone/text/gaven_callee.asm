GavenAnswerPhoneText:
	text "Hello, this is"
	line ""
	text_ram wStringBuffer3
	text " speaking…"

	para "Hi, <PLAYER>!"
	line "Good morning!"
	done

GavenAnswerPhoneDayText:
	text "Hello, this is"
	line ""
	text_ram wStringBuffer3
	text " speaking…"

	para "Hi, <PLAYER>!"
	done

GavenAnswerPhoneNiteText:
	text "Hello, this is"
	line ""
	text_ram wStringBuffer3
	text " speaking…"

	para "Hi, <PLAYER>!"
	line "Good evening!"
	done

GavenGreetText:
	text "<PLAYER>, good"
	line "morning!"

	para "It's me, "
	text_ram wStringBuffer3
	text "."
	line "How are you doing?"
	done

GavenGreetDayText:
	text "Hi, <PLAYER>!"

	para "It's me, "
	text_ram wStringBuffer3
	text "."
	line "How are you doing?"
	done

GavenGreetNiteText:
	text "<PLAYER>, good"
	line "evening!"

	para "It's me, "
	text_ram wStringBuffer3
	text "."
	line "How are you doing?"
	done

GavenGenericText:
	text "How are your"
	line "#mon doing?"

	para "My "
	text_ram wStringBuffer4
	text "'s"
	line "doing as great as"
	cont "ever."

	para "Let's keep at it"
	line "and become #mon"
	cont "Champs!"
	done
