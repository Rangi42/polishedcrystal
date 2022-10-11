StatStrings:
; entries correspond to stat constants
	table_width 2, StatStrings
	dw .health
	dw .attack
	dw .defense
	dw .speed
	dw .spcl_atk
	dw .spcl_def
	assert_table_length NUM_STATS

.health   db "Health@"
.attack   db "Attack@"
.defense  db "Defense@"
.speed    db "Speed@"
.spcl_atk db "Spcl.Atk@"
.spcl_def db "Spcl.Def@"
