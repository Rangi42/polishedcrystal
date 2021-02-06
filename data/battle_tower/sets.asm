BattleTowerSetTable:
; One of the 2 tables are chosen at random.
; Pokémon tiers: P = Poor, A = Average, G = Good, E = Excellent
	db %010000, %010000 ; APP, APP
	db %100000, %010100 ; GPP, AAP
	db %100100, %010101 ; GAP, AAA
	db %100101, %101000 ; GAA, GGP
	db %110101, %101001 ; EAA, GGA
	db %111001, %101010 ; EGA, GGG
	db %111101, %111010 ; EEA, EGG
	db %111110, %111110 ; EEG, EEG
