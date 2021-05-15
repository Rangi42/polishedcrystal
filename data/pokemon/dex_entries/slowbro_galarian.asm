if DEF(FAITHFUL)
	db "Hermit Crab@" ; species name
else
	db "Squatter@" ; species name
endc
	dw 503, 1554 ; height, weight

	db   "A Shellder bite"
	next "set off a chemical"
	next "reaction with"

	page "Slowbro's body,"
	next "making Slowbro a"
	next "Poison-type.@"
