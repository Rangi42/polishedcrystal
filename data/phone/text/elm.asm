ElmPhoneStartText:
	text "Hello, <PLAYER>?"

	para "Try not to overdo"
	line "it."

	para "Be sure to heal"
	line "your #mon if"
	cont "they are hurt."
	done

ElmPhoneSawMrPokemonText:
	text "Hello, <PLAYER>?"

	para "Did you meet Mr."
	line "#mon? Great!"
	cont "Come back safely!"
	done

ElmPhonePokemonStolenText:
	text "<PLAYER>? I'm very"
	line "upset now."

	para "We had a #mon"
	line "stolen from here."

	para "How could anyone"
	line "do that?"
	prompt

ElmPhoneCheckingEggText:
	text "Hello, <PLAYER>?"

	para "We're checking the"
	line "Egg now. It does"

	para "appear to be a"
	line "#mon Egg."
	prompt

ElmPhoneAssistantText:
	text "Hello, <PLAYER>?"

	para "Did you see my"
	line "assistant? He's at"

	para "the #mon Center"
	line "in Violet City."
	done

ElmPhoneEggUnhatchedText:
	text "Hello, <PLAYER>?"

	para "How's the Egg? Has"
	line "anything changed?"

	para "If anything hap-"
	line "pens, please call."
	prompt

ElmPhoneEggHatchedText:
	text "Hello, <PLAYER>?"
	line "How is the Egg?"

	para "What? It hatched?"
	line "Wow! What kind of"
	cont "#mon is it?"

	para "Please come show"
	line "me now!"
	prompt

ElmPhoneDiscovery1Text:
	text "Hello, <PLAYER>?"

	para "I just made a new"
	line "discovery."

	para "The time it takes"
	line "for an Egg to"

	para "hatch depends on"
	line "the #mon."
	prompt

ElmPhoneDiscovery2Text:
	text "Hello, <PLAYER>?"

	para "It's still a"
	line "mystery what kinds"

	para "of moves hatched"
	line "#mon have."

	para "We're investigat-"
	line "ing that now."
	prompt

ElmPhonePokerusText:
	text "Hello, <PLAYER>?"

	para "I discovered an"
	line "odd thing."

	para "Apparently there's"
	line "something called"

	para "#rus that in-"
	line "fects #mon."

	para "Yes, it's like a"
	line "virus, so it's"
	cont "called #rus."

	para "It multiplies fast"
	line "and infects other"

	para "#mon too. But"
	line "that's all."

	para "It doesn't seem to"
	line "do anything, and"

	para "it goes away over"
	line "time."

	para "I guess it's"
	line "nothing to worry"
	cont "about. Bye!"
	done

ElmPhoneDisasterText:
	text "H-hello? <PLAYER>?"
	line "It's a disaster!"

	para "Uh, um, it's just"
	line "terrible!"

	para "What should I do?"
	line "It… Oh, no…"

	para "Please get back"
	line "here now!"
	done

ElmPhoneEggAssistantText:
	text "Hello, <PLAYER>? We"
	line "discovered some-"

	para "thing about the"
	line "Egg!"

	para "My assistant is at"
	line "the #mon Center"

	para "in Violet City."
	line "Could you talk to"
	cont "him?"
	done

ElmPhoneRocketText:
	text "<PLAYER>, how are"
	line "things going?"

	para "I called because"
	line "something weird is"

	para "happening with the"
	line "radio broadcasts."

	para "They were talking"
	line "about Team Rocket."

	para "<PLAYER>, do you"
	line "know anything"
	cont "about it?"

	para "Maybe Team Rocket"
	line "has returned. No,"

	para "that just can't"
	line "be true."

	para "Sorry to bug you."
	line "Take care!"
	done

ElmPhoneGiftText:
	text "Hello, <PLAYER>?"

	para "I have something"
	line "here for you."

	para "Could you swing by"
	line "my Lab?"

	para "See you later!"
	done

ElmPhoneEvolutionQuestionText:
	text "By the way,"
	line "<PLAYER>, want to"

	para "know how your"
	line "#mon evolves?"
	done

ElmPhoneEvoText_None:
	text "Well, "
	text_ram wStringBuffer3
	line "doesn't evolve!"
	prompt

ElmPhoneEvoText_Level:
	text_ram wStringBuffer3
	line "evolves when it"
	cont "reaches level "
	text_decimal wStringBuffer4, 1, 3
	text "."
	prompt

ElmPhoneEvoText_Item:
	text_ram wStringBuffer3
	line "evolves when it's"

	para "exposed to a"
	line ""
	text_ram wStringBuffer4
	text "."
	prompt

ElmPhoneEvoText_TradeNoItem:
	text_ram wStringBuffer3
	line "evolves by trade,"

	para "or when exposed to"
	line "a "
	text_ram wStringBuffer4
	text "."
	prompt

ElmPhoneEvoText_TradeWithItem:
	text_ram wStringBuffer3
	line "evolves by trade,"

	para "or when gaining a"
	line "level with"
	cont ""
	text_ram wStringBuffer4
	text " held."
	prompt

ElmPhoneEvoText_Holding:
	text_ram wStringBuffer3
	line "evolves when it"
	cont "gains a level"

	para "while holding a"
	line ""
	text_ram wStringBuffer4
	text "."
	prompt

ElmPhoneEvoText_Holding_MornDay:
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

ElmPhoneEvoText_Holding_EveNite:
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

ElmPhoneEvoText_Happiness:
	text_ram wStringBuffer3
	line "evolves when it's"
	cont "really happy!"
	prompt

ElmPhoneEvoText_Happiness_MornDay:
	text_ram wStringBuffer3
	line "evolves when it's"
	cont "really happy, but"

	para "only during the"
	line "morning or day."
	prompt

ElmPhoneEvoText_Happiness_EveNite:
	text_ram wStringBuffer3
	line "evolves when it's"
	cont "really happy, but"

	para "only during the"
	line "evening or night."
	prompt

ElmPhoneEvoText_Stat:
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

ElmPhoneEvoText_Location:
	text_ram wStringBuffer3
	line "evolves when it"

	para "gains a level at"
	line ""
	text_ram wStringBuffer4
	text "."
	prompt

ElmPhoneEvoText_Move:
	text_ram wStringBuffer3
	line "evolves when it"

	para "gains a level"
	line "while it knows"

	para "how to use"
	line ""
	text_ram wStringBuffer4
	text "."
	prompt

ElmPhoneEvoText_Crit:
	text_ram wStringBuffer3
	line "evolves after it"

	para "lands three crit-"
	line "ical hits in one"
	cont "battle."
	prompt

ElmPhoneEvoText_Party:
	text_ram wStringBuffer3
	line "evolves when it"
	cont "gains a level"

	para "while you have a"
	line ""
	text_ram wStringBuffer4
	text " in"
	cont "your party too."
	prompt

ElmPhoneEvoText_Egg:
	text "Eggs don't evolve,"
	line "they hatch!"
	prompt

ElmPhoneEvoText_Pikachu:
	text_ram wStringBuffer3
	line "evolves when it's"

	para "exposed to a"
	line "ThunderStone or"
	cont "an Odd Souvenir."
	prompt

ElmPhoneEvoText_Gloom:
	text_ram wStringBuffer3
	line "evolves when it's"

	para "exposed to a"
	line "Leaf Stone or"
	cont "a Sun Stone."
	prompt

ElmPhoneEvoText_Poliwhirl:
	text_ram wStringBuffer3
	line "evolves when it's"

	para "exposed to a"
	line "Water Stone, or"

	para "when holding a"
	line "King's Rock, if"

	para "traded, or upon"
	line "leveling up."
	prompt

ElmPhoneEvoText_SlowpokePlain:
ElmPhoneEvoText_SlowpokeGalarian:
	text_ram wStringBuffer3
	line "evolves at level"
	cont "37, or when it"

	para "holds King's Rock"
	line "when traded or"
	cont "gaining a level."
	prompt

ElmPhoneEvoText_Magneton:
	text_ram wStringBuffer3
	line "evolves when it's"

	para "exposed to a"
	line "ThunderStone, or"

	para "when it gains a"
	line "level in a mag-"
	cont "netic field."

	para "I've heard Magnet"
	line "Tunnel and Dim"
	cont "Cave have that."
	prompt

ElmPhoneEvoText_Exeggcute:
	text_ram wStringBuffer3
	line "evolves when it's"

	para "exposed to a"
	line "Leaf Stone or"
	cont "an Odd Souvenir."
	prompt

ElmPhoneEvoText_Koffing:
	text_ram wStringBuffer3
	line "evolves at level"
	cont "35, or when it"

	para "holds Charcoal"
	line "when traded or"
	cont "gaining a level."
	prompt

ElmPhoneEvoText_Cubone:
	text_ram wStringBuffer3
	line "evolves at level"
	cont "28, or when it's"

	para "exposed to an"
	line "Odd Souvenir."
	prompt

ElmPhoneEvoText_Scyther:
	text_ram wStringBuffer3
	line "evolves when it"
	cont "gains a level"

	para "while holding a"
	line "Metal Coat or a"
	cont "Hard Stone."

	para "The Metal Coat"
	line "can also be held"
	cont "while trading."
	prompt

ElmPhoneEvoText_Eevee:
	text_ram wStringBuffer3
	line "evolves in so"
	cont "many ways!"

	para "It can be exposed"
	line "to any of eight"
	cont "different Stones,"

	para "or gain a level"
	line "near a Moss Rock"
	cont "or an Ice Rock."

	para "I've heard Ilex"
	line "Forest and Ice"
	cont "Path have those."

	para "But also, Eevee"
	line "will evolve just"

	para "from the sun or"
	line "moon if it's very"
	cont "happy!"
	prompt

ElmPhoneEvoText_MimeJr:
	text_ram wStringBuffer3
	line "evolves when it's"

	para "exposed to an"
	line "Ice Stone, or"

	para "when it gains a"
	line "level near an"
	cont "Ice Rock."

	para "I've heard there's"
	line "one in Ice Path."
	prompt

ElmPhoneEvoText_Stantler:
	text_ram wStringBuffer3
	line "evolves when it's"

	para "exposed to harsh"
	line "hail or sand."

	para "I've heard Rugged"
	line "Road and Snowtop"

	para "Mountain have"
	line "weather like that."
	prompt

ElmPhoneEvoText_AncientSinnoh:
	text "But based on its"
	line "ancestry, it"

	para "may also evolve"
	line "when reminded"

	para "of ancient Sinnoh…"
	line "somehow…"
	prompt

ElmPhoneEvoText_DunsparceSegments:
	text "Some of them end"
	line "up being longer"
	cont "than others."

	para "It's just in their"
	line "genes."
	prompt

ElmPhoneEvolutionRefusedText:
	text "Sorry to bug you"
	line "then."
	prompt

ElmPhoneEndText:
	text "Take care!"
	done
