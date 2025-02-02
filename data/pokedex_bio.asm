HatchSpeedNames:
; entries correspond to HATCH_* (see constants/pokemon_data_constants.asm)
; "step cycles to hatch" are stored in one nybble, and
; only 0-7 are used for hatchable mons (legendaries use 15)
	table_width 1
	dr Fastest
	dr Faster
	dr Fast
	dr MediumFast
	dr MediumSlow
	dr Slow
	dr Slower
	dr Slowest
	assert_table_length NUM_HATCH_RATES

GrowthRateNames:
; entries correspond to GROWTH_* (see constants/pokemon_data_constants.asm)
	table_width 1
	dr MediumFast
	dr MediumSlow
	dr Fast
	dr Slow
	assert_table_length NUM_GROWTH_RATES

Fastest:    db "Fastest@"
Faster:     db "Faster@"
Fast:       db "Fast@"
MediumFast: db "Medium-Fast@"
MediumSlow: db "Medium-Slow@"
Slow:       db "Slow@"
Slower:     db "Slower@"
Slowest:    db "Slowest@"
Unknown:    db "Unknown@"

BodyColorNames:
; entries correspond to colors (see constants/pokemon_data_constants.asm)
	table_width 1
	dr BodyRed
	dr BodyBlue
	dr BodyYellow
	dr BodyGreen
	dr BodyBlack
	dr BodyBrown
	dr BodyPurple
	dr BodyGray
	dr BodyWhite
	dr BodyPink
	assert_table_length NUM_BODY_COLORS

BodyRed:    db "Red@"
BodyBlue:   db "Blue@"
BodyYellow: db "Yellow@"
BodyGreen:  db "Green@"
BodyBlack:  db "Black@"
BodyBrown:  db "Brown@"
BodyPurple: db "Purple@"
BodyGray:   db "Gray@"
BodyWhite:  db "White@"
BodyPink:   db "Pink@"
