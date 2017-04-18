	db TENTACOOL ; 072

	db  40,  40,  35,  70,  50, 100
	;   hp  atk  def  spd  sat  sdf

	db WATER, POISON
	db 190 ; catch rate
	db 105 ; base exp
	db NO_ITEM ; item 1
	db POISON_BARB ; item 2
	db FEMALE_50 ; gender
	db 20 ; step cycles to hatch
	dn 5, 5 ; frontpic dimensions
	db CLEAR_BODY ; ability 1
	db LIQUID_OOZE ; ability 2
	db RAIN_DISH ; hidden ability
	db SLOW ; growth rate
	dn INVERTEBRATE, INVERTEBRATE ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   0,   1
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HAIL, SWORDS_DANCE, HIDDEN_POWER, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, GIGA_DRAIN, SAFEGUARD, RETURN, DOUBLE_TEAM, SLUDGE_BOMB, FACADE, REST, ATTRACT, THIEF, LEECH_LIFE, SCALD, ENDURE, DAZZLINGLEAM, POISON_JAB, CUT, SURF, WATERFALL, WHIRLPOOL, DOUBLE_EDGE, ICY_WIND, SLEEP_TALK, SUBSTITUTE, SWAGGER, WATER_PULSE
	; end
