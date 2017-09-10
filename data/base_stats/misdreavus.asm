	db  60,  60,  60,  85,  85,  85
	;   hp  atk  def  spd  sat  sdf

	db GHOST, GHOST
	db 45 ; catch rate
	db 147 ; base exp
	db NO_ITEM ; item 1
	db SPELL_TAG ; item 2
	dn FEMALE_50, 4 ; gender, step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db LEVITATE ; ability 1
	db LEVITATE ; ability 2
	db LEVITATE ; hidden ability
	db FAST ; growth rate
	dn AMORPHOUS, AMORPHOUS ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   0,   1
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, RAIN_DANCE, THUNDERBOLT, THUNDER, RETURN, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, FLAMETHROWER, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, DAZZLINGLEAM, DARK_PULSE, ENDURE, WILL_O_WISP, FLASH, THUNDER_WAVE, DEFENSE_CURL, DOUBLE_EDGE, DREAM_EATER, HEADBUTT, HYPER_VOICE, ICY_WIND, SKILL_SWAP, SLEEP_TALK, SUCKER_PUNCH, SWAGGER, TRICK, ZAP_CANNON
	; end
