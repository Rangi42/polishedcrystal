	db 16  ; height
	dw 705 ; weight

	db 0 ; unused

if DEF(FAITHFUL)
	db "Hermit Crab@" ; species name
else
	db "Squatter@" ; species name
endc

	db   "A Shellder bite"
	next "set off a chemical"
	next "reaction with"

	page "Slowbro's body,"
	next "making Slowbro a"
	next "Poison-type.@"
