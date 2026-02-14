OptionsDescriptions:
	table_width 2
	dw .TextSpeed
	dw .TextAutoscroll
	dw .Frame
	dw .Typeface
	dw .Keyboard
	dw .Sound
	dw .BattleEffects
	dw .BattleStyle
	dw .RunningShoes
	dw .TurningSpeed
	dw .ClockFormat
	dw .PokedexUnits
	assert_table_length NUM_OPTIONS

.TextSpeed:
	text "How fast text is"
	line "displayed."

	para "Slow, Medium,"
	line "Fast, or Instant."
	prompt

.TextAutoscroll:
	text "Auto-advance text"
	line "with a button:"
	cont "None/Start/B/A+B"
	prompt

.Frame:
	text "Choose the border"
	line "style for all"
	cont "text boxes."
	prompt

.Typeface:
	text "Choose the font"
	line "used for menu and"
	cont "dialog text."
	prompt

.Keyboard:
	text "Set the naming"
	line "keyboard layout:"
	cont "ABCDEF or QWERTY"
	prompt

.Sound:
	text "Choose mono or"
	line "stereo sound"
	cont "output."
	prompt

.BattleEffects:
	text "Turn move"
	line "animations in"
	cont "battle on or off."
	prompt

.BattleStyle:
	text "Set: no switch"
	line "after KOs."

	para "Switch: switch."
	line "Predict: see foe."
	prompt

.RunningShoes:
	text "Set whether B"
	line "runs or walks by"
	cont "default."
	prompt

.TurningSpeed:
	text "Set your turning"
	line "speed in the"
	cont "overworld."
	prompt

.ClockFormat:
	text "Choose the clock"
	line "display format:"
	cont "12-hour or 24-hour"
	prompt

.PokedexUnits:
	text "Choose Imperial"
	line "or Metric units"
	cont "for #dex data."
	prompt

.Done:
	text "Save settings and"
	line "return to the"
	cont "previous menu."
	prompt
