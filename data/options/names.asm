OptionNames:
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
	dw .Done
	assert_table_length NUM_OPTIONS + 1 ; include "Done"

.TextSpeed:
	db "Text Speed@"
.TextAutoscroll:
	db "Text Autoscroll@"
.Frame:
	db "Frame@"
.Typeface:
	db "Typeface@"
.Keyboard:
	db "Keyboard@"
.Sound:
	db "Sound@"
.BattleEffects:
	db "Battle Effects@"
.BattleStyle:
	db "Battle Style@"
.RunningShoes:
	db "Running Shoes@"
.TurningSpeed:
	db "Turning Speed@"
.ClockFormat:
	db "Clock Format@"
.PokedexUnits:
	db "#dex Units@"
.Done:
	db "Done@"
