	db  63,  60,  55,  71,  50,  50
	;   hp  atk  def  spd  sat  sdf

	db NORMAL, FLYING
	db 120 ; catch rate
	db 113 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 2 ; gender, step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db KEEN_EYE ; ability 1
	db TANGLED_FEET ; ability 2
	db BIG_PECKS ; hidden ability
	db MEDIUM_SLOW ; growth rate
	dn AVIAN, AVIAN ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   2,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, RAIN_DANCE, RETURN, ROOST, DOUBLE_TEAM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, STEEL_WING, FOCUS_BLAST, ENDURE, U_TURN, FLY, DOUBLE_EDGE, SLEEP_TALK, SWAGGER
	; end
