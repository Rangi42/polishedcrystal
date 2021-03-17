	db  70,  80,  50,  35,  35,  35 ; 305 BST
	;   hp  atk  def  spd  sat  sdf

	db FIGHTING, FIGHTING
	db 180 ; catch rate
	db 88 ; base exp
	db NO_ITEM ; item 1
	db FOCUS_BAND ; item 2
	dn FEMALE_25, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/machop/front.dimensions"
	abilities_for MACHOP, GUTS, NO_GUARD, STEADFAST
	db MEDIUM_SLOW ; growth rate
	dn HUMANSHAPE, HUMANSHAPE ; egg groups

	ev_yield   0,   1,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, BULK_UP, HIDDEN_POWER, SUNNY_DAY, LIGHT_SCREEN, PROTECT, RAIN_DANCE, BULLDOZE, EARTHQUAKE, RETURN, DIG, ROCK_SMASH, DOUBLE_TEAM, FLAMETHROWER, FIRE_BLAST, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROCK_SLIDE, FOCUS_BLAST, FALSE_SWIPE, POISON_JAB, STRENGTH, BODY_SLAM, COUNTER, DOUBLE_EDGE, ENDURE, FIRE_PUNCH, HEADBUTT, ICE_PUNCH, KNOCK_OFF, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, THUNDERPUNCH
	; end
