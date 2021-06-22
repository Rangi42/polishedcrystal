GrassMonProbTable:
	table_width 1, GrassMonProbTable
	db 30  ; 30% chance
	db 60  ; 30% chance
	db 80  ; 20% chance
	db 90  ; 10% chance
	db 95  ;  5% chance
	db 98  ;  3% chance
	db 100 ;  2% chance
	assert_table_length NUM_GRASSMON

WaterMonProbTable:
	table_width 1, WaterMonProbTable
	db 60  ; 60% chance
	db 90  ; 30% chance
	db 100 ; 10% chance
	assert_table_length NUM_WATERMON
