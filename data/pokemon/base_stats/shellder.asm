	db  30,  65, 100,  40,  45,  25 ; 305 BST
	;   hp  atk  def  spd  sat  sdf

	db WATER, WATER ; type
	db 190 ; catch rate
	db 97 ; base exp
	db PEARL ; item 1
	db BIG_PEARL ; item 2
	dn GENDER_F50, 3 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/shellder/front.dimensions"
	abilities_for SHELLDER, SHELL_ARMOR, SKILL_LINK, OVERCOAT
	db GROWTH_SLOW ; growth rate
	dn EGG_WATER_3, EGG_WATER_3 ; egg groups

	ev_yield   0,   0,   1,   0,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, RETURN, DOUBLE_TEAM, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, WATER_PULSE, EXPLOSION, AVALANCHE, SURF, WHIRLPOOL, WATERFALL, DOUBLE_EDGE, ENDURE, ICY_WIND, ROLLOUT, SLEEP_TALK, SWAGGER
	; end
