	db DODUO ; 084

	db  35,  85,  45,  75,  35,  35
	;   hp  atk  def  spd  sat  sdf

	db NORMAL, FLYING
	db 190 ; catch rate
	db 96 ; base exp
	db NO_ITEM ; item 1
	db SHARP_BEAK ; item 2
	db FEMALE_50 ; gender
	db 20 ; step cycles to hatch
	dn 5, 5 ; frontpic dimensions
	db RUN_AWAY ; ability 1
	db EARLY_BIRD ; ability 2
	db TANGLED_FEET ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn AVIAN, AVIAN ; egg groups

	; ev_yield
	ev_yield   0,   1,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, SWORDS_DANCE, HIDDEN_POWER, SUNNY_DAY, PROTECT, RETURN, ROOST, DOUBLE_TEAM, SWIFT, AERIAL_ACE, FACADE, REST, ATTRACT, THIEF, STEEL_WING, ENDURE, FLY, BODY_SLAM, DOUBLE_EDGE, SLEEP_TALK, SUBSTITUTE, SWAGGER
	; end
