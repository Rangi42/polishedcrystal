	db  55, 130, 115,  75,  50,  50 ; 475 BST
	;   hp  atk  def  spd  sat  sdf

	db WATER, WATER ; type
	db 60 ; catch rate
	db 206 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn GENDER_F50, 3 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/kingler/front.dimensions"
	abilities_for KINGLER, HYPER_CUTTER, SHELL_ARMOR, SHEER_FORCE
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_WATER_3, EGG_WATER_3 ; egg groups

	ev_yield   0,   2,   0,   0,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, HONE_CLAWS, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, RETURN, DIG, ROCK_SMASH, DOUBLE_TEAM, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROCK_SLIDE, FALSE_SWIPE, SCALD, X_SCISSOR, WATER_PULSE, SHADOW_CLAW, GIGA_IMPACT, SWORDS_DANCE, CUT, SURF, STRENGTH, WHIRLPOOL, BODY_SLAM, DOUBLE_EDGE, ENDURE, ICY_WIND, KNOCK_OFF, SLEEP_TALK, SWAGGER
	; end
