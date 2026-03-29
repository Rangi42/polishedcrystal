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
	dw .Nicknames
	dw .RunningShoes
	dw .TurningSpeed
	dw .ClockFormat
	dw .PokedexUnits
	assert_table_length NUM_OPTIONS

.TextSpeed:
	text "How fast text is"
	line "displayed."
	prompt

.TextAutoscroll:
	text "Auto-advance text"
	line "by holding down"
	cont "some button(s)."
	prompt

.Frame:
	text "The frame around"
	line "most text boxes."
	prompt

.Typeface:
	text "The font used for"
	line "ordinary text."
	prompt

.Keyboard:
	text "The keyboard lay-"
	line "out for entering"
	cont "names and mail."
	prompt

.Sound:
	text "Audio output:"
	line "mono (one channel)"

	para "or stereo (two,"
	line "left and right)."
	prompt

.BattleEffects:
	text "Move and status"
	line "animations."
	prompt

.BattleStyle:
	text "After you KO an"
	line "opponent:"

	para "Set: just sends"
	line "out the next foe."

	para "Switch: lets you"
	line "switch first."

	para "Predict: tells"
	line "you the next foe."
	prompt

.Nicknames:
	text "Whether to give"
	line "nicknames to new"
	cont "#mon."
	prompt

.RunningShoes:
	text "Hold B to run if"
	line "Running Shoes are"

	para "Off, or to walk"
	line "if they are On."
	prompt

.TurningSpeed:
	text "How fast you can"
	line "change direction"
	cont "in the overworld."
	prompt

.ClockFormat:
	text "The clock display"
	line "format:"
	cont "12-hour has AM/PM."
	prompt

.PokedexUnits:
	text "#dex height"
	line "and weight units:"

	para "Imperial: feet,"
	line "inches and pounds."

	para "Metric: meters"
	line "and kilograms."
	prompt

OptionsDoneDescription:
	text "Save options and"
	line "exit the menu."
	prompt
