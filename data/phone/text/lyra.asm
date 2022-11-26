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

LyraPhoneEvolutionQuestionText:
	text "I've been studying"
	line "#mon evolution"
	cont "with Prof.Elm."

	para "Want me to tell"
	line "you how your #-"
	cont "mon evolves?"
	done

LyraPhoneEvoText_None:
	text "Well, "
	text_ram wStringBuffer3
	line "doesn't evolve!"

	para "At least not as"
	line "far as I know."
	prompt

LyraPhoneEvoText_Level:
	text_ram wStringBuffer3
	line "evolves when it"
	cont "reaches level "
	text_decimal wStringBuffer4, 1, 3
	text "."
	prompt

LyraPhoneEvoText_Item:
	text_ram wStringBuffer3
	line "evolves when it's"

	para "exposed to a"
	line ""
	text_ram wStringBuffer4
	text "."
	prompt

LyraPhoneEvoText_Holding:
	text_ram wStringBuffer3
	line "evolves when it"
	cont "gains a level"

	para "while holding a"
	line ""
	text_ram wStringBuffer4
	text "."
	prompt

LyraPhoneEvoText_Holding_MornDay:
	text_ram wStringBuffer3
	line "evolves when it"
	cont "gains a level"

	para "while holding a"
	line ""
	text_ram wStringBuffer4
	text ", but"

	para "only during the"
	line "morning or day."
	prompt

LyraPhoneEvoText_Holding_EveNite:
	text_ram wStringBuffer3
	line "evolves when it"
	cont "gains a level"

	para "while holding a"
	line ""
	text_ram wStringBuffer4
	text ", but"

	para "only during the"
	line "evening or night."
	prompt

LyraPhoneEvoText_Happiness:
	text_ram wStringBuffer3
	line "evolves when it's"
	cont "really happy!"
	prompt

LyraPhoneEvoText_Happiness_MornDay:
	text_ram wStringBuffer3
	line "evolves when it's"
	cont "really happy, but"

	para "only during the"
	line "morning or day."
	prompt

LyraPhoneEvoText_Happiness_EveNite:
	text_ram wStringBuffer3
	line "evolves when it's"
	cont "really happy, but"

	para "only during the"
	line "evening or night."
	prompt

LyraPhoneEvoText_Stat:
	text_ram wStringBuffer3
	line "evolves at level"
	cont ""
	text_decimal wStringBuffer4, 1, 3
	text ", but what it"

	para "evolves into de-"
	line "pends on its"

	para "Attack and"
	line "Defense stats."
	prompt

LyraPhoneEvoText_Location:
	text_ram wStringBuffer3
	line "evolves when it"

	para "gains a level at"
	line ""
	text_ram wStringBuffer4
	text "."
	prompt

LyraPhoneEvoText_Move:
	text_ram wStringBuffer3
	line "evolves when it"

	para "gains a level"
	line "while it knows"

	para "how to use"
	line ""
	text_ram wStringBuffer4
	text "."
	prompt

LyraPhoneEvoText_EVs:
	text_ram wStringBuffer3
	line "evolves when it's"

	para "put enough effort"
	line "into improving"
	cont "its "
	text_ram wStringBuffer4
	text "."

	para "Vitamins can help"
	line "with that."
	prompt

LyraPhoneEvoText_Crit:
	text_ram wStringBuffer3
	line "evolves after it"

	para "lands three crit-"
	line "ical hits in one"
	cont "battle."
	prompt

LyraPhoneEvoText_Party:
	text_ram wStringBuffer3
	line "evolves when it"
	cont "gains a level"

	para "while you have a"
	line ""
	text_ram wStringBuffer4
	cont "in your party too."
	prompt

LyraPhoneEvoText_Egg:
	text "Eggs don't evolve,"
	line "they hatch! Haha!"
	prompt

LyraPhoneEvoText_Pikachu:
	text_ram wStringBuffer3
	line "evolves when it's"

	para "exposed to a"
	line "ThunderStone or"
	cont "an Odd Souvenir."
	prompt

LyraPhoneEvoText_Gloom:
	text_ram wStringBuffer3
	line "evolves when it's"

	para "exposed to a"
	line "Leaf Stone or"
	cont "a Sun Stone."
	prompt

LyraPhoneEvoText_Poliwhirl:
	text_ram wStringBuffer3
	line "evolves when it's"

	para "exposed to a"
	line "Water Stone, or"

	para "when it gains a"
	line "level while hold-"
	cont "ing a King's Rock."
	prompt

LyraPhoneEvoText_SlowpokePlain:
LyraPhoneEvoText_SlowpokeGalarian:
	text_ram wStringBuffer3
	line "evolves at level"
	cont "37, or when it"

	para "gains a level"
	line "while holding a"
	cont "a King's Rock."
	prompt

LyraPhoneEvoText_Magneton:
	text_ram wStringBuffer3
	line "evolves when it's"

	para "exposed to a"
	line "ThunderStone, or"

	para "when it gains a"
	line "level in a mag-"
	cont "netic field."

	para "I think Magnet"
	line "Tunnel and Dim"
	cont "Cave have that."
	prompt

LyraPhoneEvoText_Exeggcute:
	text_ram wStringBuffer3
	line "evolves when it's"

	para "exposed to a"
	line "Leaf Stone or"
	cont "an Odd Souvenir."
	prompt

LyraPhoneEvoText_Koffing:
	text_ram wStringBuffer3
	line "evolves when it"
	cont "reaches level 35,"

	para "or when it gains a"
	line "level while hold-"
	cont "ing Charcoal."
	prompt

LyraPhoneEvoText_Cubone:
	text_ram wStringBuffer3
	line "evolves at level"
	cont "28, or when it's"

	para "exposed to an"
	line "Odd Souvenir."
	prompt

LyraPhoneEvoText_Scyther:
	text_ram wStringBuffer3
	line "evolves when it"
	cont "gains a level"

	para "while holding a"
	line "Metal Coat or a"
	cont "Hard Stone."
	prompt

LyraPhoneEvoText_Eevee:
	text_ram wStringBuffer3
	line "evolves in so"
	cont "many ways!"

	para "It can be exposed"
	line "to any of eight"
	cont "different Stones,"

	para "or gain a level"
	line "near a Moss Rock"
	cont "or an Ice Rock."

	para "I think Ilex For-"
	line "est and Ice Path"
	cont "have those."

	para "But also, Eevee"
	line "will evolve just"

	para "from the sun or"
	line "moon if it's very"
	cont "happy!"
	prompt

LyraPhoneEvoText_MimeJr:
	text_ram wStringBuffer3
	line "evolves when it's"

	para "exposed to an"
	line "Ice Stone, or"

	para "when it gains a"
	line "level near an"
	cont "Ice Rock."

	para "I think there's"
	line "one in Ice Path."
	prompt

LyraPhoneEvoText_Stantler:
	text_ram wStringBuffer3
	line "evolves when it's"

	para "exposed to harsh"
	line "hail or sand."

	para "I think Rugged"
	line "Road and Snowtop"

	para "Mountain have"
	line "weather like that."
	prompt

LyraPhoneEvoText_AncientSinnoh:
	text "But based on its"
	line "ancestry, it"

	para "may also evolve"
	line "when reminded"

	para "of ancient Sinnoh…"
	line "somehow…"
	prompt

LyraPhoneEvoText_DunsparceSegments:
	text "Some of them end"
	line "up being longer"
	cont "than others."

	para "It's just in their"
	line "genes."
	prompt

LyraPhoneEvolutionRefusedText:
	text "Haha, I won't"
	line "spoil it, then!"
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
