	db  20,  25,  45,  60,  70,  90 ; 310 BST
	;   hp  atk  def  spd  sat  sdf

	db PSYCHIC, FAIRY ; type
	db 145 ; catch rate
	db 78 ; base exp
	db NO_ITEM ; item 1
	db LEPPA_BERRY ; item 2
	dn GENDER_F50, 4 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/mime_jr_/front.dimensions"
	abilities_for MIME_JR_, SOUNDPROOF, FILTER, TECHNICIAN
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	ev_yield   0,   0,   0,   0,   0,   1
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, LIGHT_SCREEN, PROTECT, RAIN_DANCE, SAFEGUARD, SOLAR_BEAM, THUNDERBOLT, THUNDER, RETURN, PSYCHIC, SHADOW_BALL, ROCK_SMASH, DOUBLE_TEAM, REFLECT, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, DAZZLINGLEAM, DRAIN_PUNCH, FLASH, THUNDER_WAVE, DREAM_EATER, ENDURE, HEADBUTT, ICY_WIND, SKILL_SWAP, SLEEP_TALK, SWAGGER, TRICK
	; end
