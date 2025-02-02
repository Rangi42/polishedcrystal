StatStrings:
; entries correspond to stat constants
	table_width 1
	dr .health
	dr .attack
	dr .defense
	dr .speed
	dr .sp_atk
	dr .sp_def
	assert_table_length NUM_STATS

.health:  db "Health@"
.attack:  db "Attack@"
.defense: db "Defense@"
.speed:   db "Speed@"
.sp_atk:  db "Sp.Atk@"
.sp_def:  db "Sp.Def@"
