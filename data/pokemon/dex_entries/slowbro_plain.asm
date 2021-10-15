	db 16  ; height
	dw 785 ; weight

	dn SHAPE_BIPEDAL_TAIL, BODY_COLOR_PINK

if DEF(FAITHFUL)
	db "Hermit Crab@" ; species name
else
	db "Squatter@" ; species name
endc

	db   "An attached"
	next "Shellder won't let"
	next "go because of the"

	page "tasty flavor that"
	next "oozes out of its"
	next "tail.@"
