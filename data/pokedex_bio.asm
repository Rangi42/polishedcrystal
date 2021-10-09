HatchSpeedNames:
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
	dw MediumFast
	dw MediumSlow
	dw Fast
	dw Slow

Fastest:       db "Fastest@"
Faster:        db "Faster@"
Fast:          db "Fast@"
MediumFast:    db "Medium-Fast@"
MediumSlow:    db "Medium-Slow@"
Slow:          db "Slow@"
Slower:        db "Slower@"
Slowest:       db "Slowest@"
NotApplicable: db "N/A@"
