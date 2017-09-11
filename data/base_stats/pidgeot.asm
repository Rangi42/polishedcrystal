if DEF(FAITHFUL)
	db  83,  80,  75, 101,  70,  70
	;   hp  atk  def  spd  sat  sdf
else
	db  93,  81,  75, 101,  90,  70
	;   hp  atk  def  spd  sat  sdf
endc

	db NORMAL, FLYING
	db 45 ; catch rate
if DEF(FAITHFUL)
	db 172 ; base exp
else
	db 194 ; base exp
endc
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 2 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db KEEN_EYE ; ability 1
	db TANGLED_FEET ; ability 2
	db NO_GUARD ; hidden ability
	db MEDIUM_SLOW ; growth rate
	dn AVIAN, AVIAN ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   3,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, RETURN, ROOST, DOUBLE_TEAM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, STEEL_WING, FOCUS_BLAST, ENDURE, GIGA_IMPACT, U_TURN, FLY, DOUBLE_EDGE, SLEEP_TALK, SWAGGER
	; end
