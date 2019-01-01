; SlowbroPokedexEntry: ; 0x1b8635
if DEF(FAITHFUL)
	db "Hermit Crab@" ; species name
else
	db "Squatter@" ; species name
endc
	dw 503, 1730 ; height, width

	db   "An attached"
	next "Shellder won't let"
	next "go because of the"
	page "tasty flavor that"
	next "oozes out of its"
	next "tail.@"
