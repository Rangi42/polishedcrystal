StatStrings:
; entries correspond to stat constants
	table_width 2, StatStrings
	dw .health
	dw .attack
	dw .defense
	dw .speed
	dw .sp_atk
	dw .sp_def
	assert_table_length NUM_STATS

.health:  db "Health@"
.attack:  db "Attack@"
.defense: db "Defense@"
.speed:   db "Speed@"
.sp_atk:  db "Sp.Atk@"
.sp_def:  db "Sp.Def@"
