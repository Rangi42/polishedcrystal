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

BodyColorNames:
; entries correspond to colors (see constants/pokemon_data_constants.asm)
	table_width 2, BodyColorNames
	dw BodyRed
	dw BodyBlue
	dw BodyYellow
	dw BodyGreen
	dw BodyBlack
	dw BodyBrown
	dw BodyPurple
	dw BodyGray
	dw BodyWhite
	dw BodyPink
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
