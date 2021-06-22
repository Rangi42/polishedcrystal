BattleTowerTierTable:
; The row is chosen from the current difficulty.
; One of the 2 tables in each row is chosen at random.
	db %010000, %010000 ; CDD, CDD
	db %100000, %010100 ; BDD, CCD
	db %100100, %010101 ; BCD, CCC
	db %100101, %101000 ; BCC, BBD
	db %110101, %101001 ; ACC, BBC
	db %111001, %101010 ; ABC, BBB
	db %111101, %111010 ; AAC, ABB
	db %111110, %111110 ; AAB, AAB
