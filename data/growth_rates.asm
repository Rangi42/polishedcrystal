growth_rate: MACRO
; [1]/[2]*n**3 + [3]*n**2 + [4]*n - [5]
	dn \1, \2
	if \3 & $80 ; signed
		db -\3 | $80
	else
		db \3
	endc
	db \4, \5
ENDM

GrowthRates:
	growth_rate 1, 1,   0,   0,   0 ; Medium Fast
	growth_rate 6, 5, -15, 100, 140 ; Medium Slow
	growth_rate 4, 5,   0,   0,   0 ; Fast
	growth_rate 5, 4,   0,   0,   0 ; Slow
