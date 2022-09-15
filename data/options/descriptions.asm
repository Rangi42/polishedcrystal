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
	cont "another."
	prompt

.InitialOptionDesc_Abilities:
	text "Abilities may have"
	line "effects inside"

	para "and outside of"
	line "battle."
	prompt

.InitialOptionDesc_PSS:
	text "Moves are physical"
	line "or special inde-"
	cont "pendently of type."
	prompt

.InitialOptionDesc_EVs:
	text "EVs boost stats."
	line "All six stats can"
	cont "maximize EV gain."
	prompt

.InitialOptionDesc_ExpScaling:
	text "Experience gain"
	line "is greater from"

	para "defeating higher-"
	line "leveled foes,"

	para "and less from low-"
	line "er leveled ones."
	prompt

.InitialOptionDesc_ColorVariation:
	text "Both normal and"
	line "shiny #mon"

	para "have their colors"
	line "subtly varied"
	cont "based on IVs."
	prompt

.InitialOptionDesc_PerfectIVs:
	text "Stats are calcu-"
	line "lated as if IVs"

	para "were perfect,"
	line "even for foes."
	prompt

.InitialOptionDesc_TradedMon:
	text "Traded #mon"
	line "will obey you,"

	para "can be nicknamed,"
	line "but EXP. Points"
	cont "won't be boosted."
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
