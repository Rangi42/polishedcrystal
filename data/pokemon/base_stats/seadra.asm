	db  55,  65,  95,  85,  95,  45 ; 440 BST
	;   hp  atk  def  spd  sat  sdf

	db WATER, WATER ; type
	db 75 ; catch rate
	db 155 ; base exp
	db NO_ITEM ; item 1
	db DRAGON_SCALE ; item 2
	dn GENDER_F50, 3 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/seadra/front.dimensions"
	abilities_for SEADRA, POISON_POINT, SNIPER, DAMP
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_WATER_1, EGG_DRAGON ; egg groups

	ev_yield   0,   0,   1,   0,   1,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, RETURN, DOUBLE_TEAM, FLASH_CANNON, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, SCALD, DRAGON_PULSE, WATER_PULSE, GIGA_IMPACT, SURF, WHIRLPOOL, WATERFALL, DOUBLE_EDGE, ENDURE, HEADBUTT, ICY_WIND, SLEEP_TALK, SWAGGER
	; end
