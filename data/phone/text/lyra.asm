LyraPhoneMornGreetingText:
	text "Oh, <PLAYER>!"
	line "Good morning!"
	prompt

LyraPhoneDayGreetingText:
	text "Oh, <PLAYER>!"
	line "How are you?"
	prompt

LyraPhoneEveGreetingText:
	text "Oh, <PLAYER>!"
	line "Good evening!"
	prompt

LyraPhoneNiteGreetingText:
	text "Oh, <PLAYER>!"
	line "Good evening!"
	cont "You're up late."
	prompt

LyraPhoneLandmarkText:
	text "Where are you now?"
	line ""
	text_ram wStringBuffer4
	text "?"
	prompt

LyraPhoneJohtoText_Generic:
	text "Tell me all about"
	line "it later, OK?"
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

LyraPhoneMainText:
	text "You know, my dad"
	line "thinks you'll be-"

	para "come an incredible"
	line "trainer someday."

	para "What am I saying?"
	line "I'm starting to"

	para "sound like the"
	line "professor!"

	para "Well, do your"
	line "best!"

	para "Call me again"
	line "sometime!"
	done

LyraPhoneYellowForestText:
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

LyraPhoneFirstBadgeText:
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

LyraPhoneLyrasEggText:
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

LyraPhoneMagnetonText:
	text "What? You have a"
	line "Magneton now?"
	cont "That's so cool!"

	para "I learned some-"
	line "thing from Prof."
	cont "Elm about their"
	cont "evolution."

	para "He said it evolves"
	line "when it levels up"
	cont "in a special"
	cont "magnetic field."

	para "Over in Kanto,"
	line "such a field is"
	cont "apparently found"
	cont "in Rock Tunnel."

	para "You didn't already"
	line "know that,"
	cont "did you?"
	prompt

LyraPhoneEndText:
	text "Anyway… So nice"
	line "to catch up with"
	cont "you, <PLAYER>."

	para "See you later!"
	done