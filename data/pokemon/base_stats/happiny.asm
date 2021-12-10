	db 100,  05,  05,  30,  15,  65 ; 220 BST
	;   hp  atk  def  spd  sat  sdf

	db NORMAL, NORMAL ; type
	db 130 ; catch rate
	db 255 ; base exp
	db HARD_STONE ; item 1
	db LUCKY_EGG ; item 2
	dn GENDER_F100, 7 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/happiny/front.dimensions"
	abilities_for HAPPINY, NATURAL_CURE, SERENE_GRACE, NATURAL_CURE
	db GROWTH_FAST ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	ev_yield   1,   0,   0,   0,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm TOXIC, HAIL, HIDDEN_POWER, SUNNY_DAY, LIGHT_SCREEN, PROTECT, RAIN_DANCE, SAFEGUARD, SOLAR_BEAM, RETURN, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, FLAMETHROWER, FIRE_BLAST, SUBSTITUTE, FACADE, REST, ATTRACT, DRAIN_PUNCH, WATER_PULSE, FLASH, THUNDER_WAVE, COUNTER, DEFENSE_CURL, DREAM_EATER, ENDURE, HEADBUTT, HYPER_VOICE, ICY_WIND, ROLLOUT, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, ZEN_HEADBUTT
	; end
