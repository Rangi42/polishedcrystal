	db  60,  60,  60,  85,  85,  85 ; 435 BST
	;   hp  atk  def  spd  sat  sdf

	db GHOST, GHOST ; type
	db 45 ; catch rate
	db 147 ; base exp
	db NO_ITEM ; item 1
	db SPELL_TAG ; item 2
	dn GENDER_F50, 4 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/misdreavus/front.dimensions"
	abilities_for MISDREAVUS, LEVITATE, LEVITATE, LEVITATE
	db GROWTH_FAST ; growth rate
	dn EGG_INDETERMINATE, EGG_INDETERMINATE ; egg groups

	ev_yield   0,   0,   0,   0,   0,   1
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, RAIN_DANCE, THUNDERBOLT, THUNDER, RETURN, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, FLAMETHROWER, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, DAZZLINGLEAM, DARK_PULSE, WILL_O_WISP, FLASH, THUNDER_WAVE, DEFENSE_CURL, DOUBLE_EDGE, DREAM_EATER, ENDURE, HEADBUTT, HYPER_VOICE, ICY_WIND, SKILL_SWAP, SLEEP_TALK, SUCKER_PUNCH, SWAGGER, TRICK, ZAP_CANNON
	; end
