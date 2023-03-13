LyraPhoneGreetingText_Morn:
	text "Oh, <PLAYER>!"
	line "Good morning!"
	prompt

LyraPhoneGreetingText_Day:
	text "Oh, <PLAYER>!"
	line "How are you?"
	prompt

LyraPhoneGreetingText_Eve:
	text "Oh, <PLAYER>!"
	line "Good evening!"
	prompt

LyraPhoneGreetingText_Nite:
	text "…<PLAYER>!"
	line "Good evening!"
	cont "You're up late."
	prompt

LyraPhoneLandmarkText:
	text "Where are you now?"
	line ""
	text_ram wStringBuffer4
	text "?"
	prompt

LyraPhoneKantoText:
	text "So you're all the"
	line "way over in Kanto!"
	prompt

LyraPhoneIslandsText:
	text "You're exploring a"
	line "tropical island…"

	para "I'm jealous,"
	line "<PLAYER>!"
	prompt

LyraPhoneJohtoText_Generic:
	text "Tell me all about"
	line "it later, OK?"
	prompt

LyraPhoneNextMoveQuestionText:
	text "So, <PLAYER>…"

	para "Want me to tell"
	line "you when your"

	para "#mon will learn"
	line "its next move?"
	done

LyraPhoneNextMoveRefusedText:
	text "Haha, I won't"
	line "spoil it, then!"
	prompt

LyraPhoneNextMoveLevelText:
	text_ram wStringBuffer3
	line "learns its next"
	cont "move at level "
	text_decimal hScriptVar, 1, 3
	text "."
	prompt

LyraPhoneNoNextMoveText:
	text_ram wStringBuffer3
	line "won't learn any"

	para "more moves just"
	line "by leveling up."
	prompt

LyraPhoneNoEggMovesText:
	text "Eggs don't learn"
	line "moves! …Do they?"
	prompt

LyraPhoneEndText:
	text "Anyway… So nice"
	line "to catch up with"
	cont "you, <PLAYER>."

	para "Call me again"
	line "sometime!"
	done

LyraPhoneSpecialText_YellowForest:
	text "Hi, <PLAYER>!"
	line "How are you?"

	para "Have you been to"
	line "see Yellow Forest?"

	para "I was going to"
	line "visit, but I heard"

	para "Team Rocket was"
	line "up to something"
	cont "there."

	para "I don't want to"
	line "get mixed up in"
	cont "that!"

	para "You've faced Team"
	line "Rocket before,"

	para "haven't you,"
	line "<PLAYER>?"

	para "That's so brave"
	line "of you!"

	para "Anyway, good luck"
	line "on your journey!"
	done

LyraPhoneSpecialText_FirstBadge:
	text "<PLAYER>! Hi!"

	para "I just got my"
	line "first Gym Badge!"

	para "Falkner's Pidgeot"
	line "is strong, but"
	cont "mine beat him!"

	para "I just had to tell"
	line "you, <PLAYER>."

	para "Oh, you got your"
	line "first badge in"
	cont "Kanto too?"
	cont "Good going!"

	para "Let's both keep on"
	line "winning Badges."

	para "I'll see you at"
	line "the League!"
	done

LyraPhoneSpecialText_LyrasEgg:
	text "<PLAYER>! Hi!"

	para "Are you doing well"
	line "against Kanto's"
	cont "Gym Leaders?"

	para "I'm sure you are!"

	para "Listen, listen!"

	para "I left my "
	text_ram wStringBuffer4
	line "at the Day-Care"

	para "with Grandma and"
	line "Grandpa, and they"
	cont "found an Egg!"

	para "Isn't that neat?"

	para "I'm raising a full"
	line "party of #mon,"

	para "so, um, if you'd"
	line "like to have it…"

	para "That is… Anyway,"
	line "I left the Egg at"

	para "the Day-Care if"
	line "you want it!"

	para "I know you'll take"
	line "good care of it,"
	cont "<PLAYER>."

	para "Bye-bye!"
	done
