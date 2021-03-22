	db  50,  52,  48,  55,  65,  50 ; 320 BST
	;   hp  atk  def  spd  sat  sdf

	db WATER, WATER ; type
	db 190 ; catch rate
	db 80 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn GENDER_F50, 3 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/psyduck/front.dimensions"
	abilities_for PSYDUCK, DAMP, CLOUD_NINE, SWIFT_SWIM
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_WATER_1, EGG_GROUND ; egg groups

	ev_yield   0,   0,   0,   0,   1,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm DYNAMICPUNCH, CURSE, CALM_MIND, TOXIC, HAIL, HIDDEN_POWER, HONE_CLAWS, ICE_BEAM, BLIZZARD, LIGHT_SCREEN, PROTECT, RAIN_DANCE, IRON_TAIL, RETURN, DIG, PSYCHIC, ROCK_SMASH, DOUBLE_TEAM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, SCALD, WATER_PULSE, SHADOW_CLAW, FLASH, SURF, STRENGTH, WHIRLPOOL, WATERFALL, AQUA_TAIL, BODY_SLAM, COUNTER, DOUBLE_EDGE, ENDURE, HEADBUTT, ICE_PUNCH, ICY_WIND, PAY_DAY, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, ZEN_HEADBUTT
	; end
