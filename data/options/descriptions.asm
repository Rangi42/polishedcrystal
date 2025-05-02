; These are in the same order as GetInitialOptionPointer.Pointers,
; not the *_OPT bit order!
InitialOptionDescriptions:
	table_width 2
	dw .InitialOptionDesc_Natures
	dw .InitialOptionDesc_Abilities
	dw .InitialOptionDesc_PSS
	dw .InitialOptionDesc_EVs
	dw .InitialOptionDesc_Experience
	dw .InitialOptionDesc_AffectionBonus
	dw .InitialOptionDesc_NextPage

	dw .InitialOptionDesc_RTC
	dw .InitialOptionDesc_PerfectIVs
	dw .InitialOptionDesc_TradedMon
	dw .InitialOptionDesc_EvolveInBattle
	dw .InitialOptionDesc_ColorVariation
	dw EmptyString
	dw .InitialOptionDesc_PrevPage
	assert_table_length NUM_INITIAL_OPTIONS_PER_PAGE * 2

.InitialOptionDesc_Natures:
	text "Natures raise one"
	line "stat but lower"
	cont "another by 10%."

	para "Introduced in"
	line "Gen 3."
	prompt

.InitialOptionDesc_Abilities:
	text "Abilities may have"
	line "effects inside"

	para "and outside of"
	line "battle."

	para "Introduced in"
	line "Gen 3."
	prompt

.InitialOptionDesc_PSS:
	text "Moves are physical"
	line "or special inde-"
	cont "pendently of type."

	para "Introduced in"
	line "Gen 4."
	prompt

.InitialOptionDesc_EVs:
	text "EVs boost stats by"
	line STRFMT("up to %d points,", MODERN_MAX_EV / 4)
	cont "one per 4 EVs."

	para "You can choose to"
	line "allow maxing every"

	para "stat to {d:MODERN_MAX_EV} EVs,"
	line "like stat exp did,"

	para "or limit them to"
	line "a total of {d:MODERN_EV_LIMIT}."

	para "Replaced stat exp-"
	line "erience in Gen 3."
	prompt

.InitialOptionDesc_Experience:
	text "The old experience"
	line "gain formula, in"

	para "Gen 1 to Gen 4,"
	line "was unscaled."

	para "The new one, in"
	line "Gen 5 and reintro-"
	cont "duced in Gen 7,"

	para "gives more Exp. by"
	line "defeating higher-"
	cont "leveled foes,"

	para "and less from low-"
	line "er leveled ones."

	para "Exp. gain can also"
	line "be turned off for"
	cont "a challenge, but"

	para "Exp.Candy and Rare"
	line "Candy will still"
	cont "work if you do so."
	prompt

.InitialOptionDesc_AffectionBonus:
	text "Your #mon will"
	line "gain benefits in"
	cont "battle when they"

	para "are close friends"
	line "with you."

	para "Introduced in"
	line "Gen 6."
	prompt

.InitialOptionDesc_EvolveInBattle:
	text "Your #mon can"
	line "evolve during"
	cont "trainer battles."

	para "Inspired by anime"
	line "battles."
	prompt

.InitialOptionDesc_ColorVariation:
	text "Individual #-"
	line "mon, both regular"
	cont "and shiny, will"

	para "have their colors"
	line "subtly varied."

	para "The variation is"
	line "pseudorandom, not"

	para "correlated with"
	line "stat quality."

	para "Inspired by"
	line "Stadium's color"

	para "variation based"
	line "on nicknames."
	prompt

.InitialOptionDesc_PerfectIVs:
	text "Stats are calcu-"
	line "lated as if IVs"

	para "were perfect 15s,"
	line "for your #mon"
	cont "and opponents'."
	prompt

.InitialOptionDesc_TradedMon:
	text "Traded #mon"
	line "will obey you and"
	cont "can be nicknamed,"

	para "but Exp.Points"
	line "won't be boosted."
	prompt

.InitialOptionDesc_RTC:
	text "Use the Real-Time"
	line "Clock function to"
	cont "track the time."

	para "If your cartridge"
	line "or emulator does"
	cont "not support RTC,"

	assert NO_RTC_SPEEDUP == 6
	para "disable this to"
	line "make each in-game"
	cont "day last 4 hours."
	prompt

.InitialOptionDesc_NextPage:
	text "View the next"
	line "page of options."
	prompt

.InitialOptionDesc_PrevPage:
	text "View the previous"
	line "page of options."
	prompt
