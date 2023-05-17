InitialOptionDescriptions:
	table_width 2, InitialOptionDescriptions
	dw .InitialOptionDesc_Natures
	dw .InitialOptionDesc_Abilities
	dw .InitialOptionDesc_PSS
	dw .InitialOptionDesc_EVs
	dw .InitialOptionDesc_ExpScaling
	dw .InitialOptionDesc_ColorVariation
	dw .InitialOptionDesc_PerfectIVs
	dw .InitialOptionDesc_TradedMon
	dw .InitialOptionDesc_NuzlockeMode
	assert_table_length NUM_INITIAL_OPTIONS

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

.InitialOptionDesc_ExpScaling:
	text "Experience gain"
	line "is greater from"

	para "defeating higher-"
	line "leveled foes,"

	para "and less from low-"
	line "er leveled ones."

	para "Introduced in"
	line "Gen 5 and 7."
	prompt

.InitialOptionDesc_ColorVariation:
	text "Both normal and"
	line "shiny #mon"

	para "have their colors"
	line "subtly varied"
	cont "based on IVs."

	para "Inspired by"
	line "Stadium."
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

	para "but Exp. Points"
	line "won't be boosted."
	prompt

.InitialOptionDesc_NuzlockeMode:
	text "Only the first"
	line "new species you"

	para "encounter per"
	line "area may be cap-"

	para "tured (as well"
	line "as any shinies)."

	para "#mon cannot"
	line "be revived."
	prompt
