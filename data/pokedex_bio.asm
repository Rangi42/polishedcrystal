HatchSpeedNames:
; "step cycles to hatch" are stored in one nybble, and
; only 0-7 are used for hatchable mons (legendaries use 15)
	dw Fastest
	dw Faster
	dw Fast
	dw MediumFast
	dw MediumSlow
	dw Slow
	dw Slower
	dw Slowest

GrowthRateNames:
; entries correspond to types (see constants/pokemon_data_constants.asm)
	table_width 2, GrowthRateNames
	dw MediumFast
	dw MediumSlow
	dw Fast
	dw Slow
	assert_table_length NUM_GROWTH_RATES

Fastest:       db "Fastest@"
Faster:        db "Faster@"
Fast:          db "Fast@"
MediumFast:    db "Medium-Fast@"
MediumSlow:    db "Medium-Slow@"
Slow:          db "Slow@"
Slower:        db "Slower@"
Slowest:       db "Slowest@"
NotApplicable: db "N/A@"
