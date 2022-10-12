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
	line "how #mon evolve"
	cont "with Prof.Elm."

	para "Want me to tell"
	line "you how your #-"
	cont "mon evolve?"
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
	; TODO (EVOLVE_ITEM, THUNDERSTONE), (EVOLVE_ITEM, ODD_SOUVENIR)
	text "Pikachu"
	prompt

LyraPhoneEvoText_Gloom:
	; TODO (EVOLVE_ITEM, LEAF_STONE), (EVOLVE_ITEM, SUN_STONE)
	text "Gloom"
	prompt

LyraPhoneEvoText_Poliwhirl:
	; TODO (EVOLVE_ITEM, WATER_STONE), (EVOLVE_HOLDING, KINGS_ROCK)
	text "Poliwhirl"
	prompt

LyraPhoneEvoText_SlowpokePlain:
	; TODO (EVOLVE_HOLDING, KINGS_ROCK, TR_ANYTIME), (EVOLVE_LEVEL, 37)
	text "SlowpokePlain"
	prompt

LyraPhoneEvoText_SlowpokeGalarian:
	; TODO (EVOLVE_HOLDING, KINGS_ROCK, TR_ANYTIME), (EVOLVE_LEVEL, 37)
	text "SlowpokeGalarian"
	prompt

LyraPhoneEvoText_Magneton:
	; TODO (EVOLVE_ITEM, THUNDERSTONE), (EVOLVE_LOCATION, MAGNET_TUNNEL), (EVOLVE_LOCATION, ROCK_TUNNEL)
	text "Magneton"
	prompt

LyraPhoneEvoText_Exeggcute:
	; TODO (EVOLVE_ITEM, LEAF_STONE), (EVOLVE_ITEM, ODD_SOUVENIR)
	text "Exeggcute"
	prompt

LyraPhoneEvoText_Cubone:
	; TODO (EVOLVE_LEVEL, 28), (EVOLVE_ITEM, ODD_SOUVENIR)
	text "Cubone"
	prompt

LyraPhoneEvoText_Scyther:
	; TODO (EVOLVE_HOLDING, METAL_COAT), (EVOLVE_HOLDING, HARD_STONE)
	text "Scyther"
	prompt

LyraPhoneEvoText_Eevee:
	; TODO
	text "Eevee"
	prompt

LyraPhoneEvoText_MimeJr:
	; TODO (EVOLVE_LEVEL, 30), (EVOLVE_ITEM, ICE_STONE), (EVOLVE_LOCATION, ICE_PATH)
	text "MimeJr"
	prompt

LyraPhoneEvoText_Ursaring:
	; TODO (EVOLVE_ITEM, MOON_STONE), (EVOLVE_LOCATION, SINJOH_RUINS), (EVOLVE_LOCATION, MYSTRI_STAGE)
	text "Ursaring"
	prompt

LyraPhoneEvoText_Stantler:
	; TODO (EVOLVE_LOCATION, RUGGED_ROAD), (EVOLVE_LOCATION, SNOWTOP_MOUNTAIN), (EVOLVE_LOCATION, SINJOH_RUINS), (EVOLVE_LOCATION, MYSTRI_STAGE)
	text "Stantler"
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
