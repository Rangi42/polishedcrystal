if DEF(FAITHFUL)
	db  60,  60,  60, 105, 105, 105
	;   hp  atk  def  spd  sat  sdf
else
	db  60,  60,  60, 110, 110, 110
	;   hp  atk  def  spd  sat  sdf
endc

if DEF(FAITHFUL)
	db GHOST, GHOST
else
	db GHOST, FAIRY
endc
	db 45 ; catch rate
	db 187 ; base exp
	db NO_ITEM ; item 1
	db SPELL_TAG ; item 2
	dn FEMALE_50, 4 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db LEVITATE ; ability 1
	db LEVITATE ; ability 2
	db LEVITATE ; hidden ability
	db FAST ; growth rate
	dn AMORPHOUS, AMORPHOUS ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   1,   1
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, THUNDERBOLT, THUNDER, RETURN, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, FLAMETHROWER, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, DAZZLINGLEAM, ENERGY_BALL, DARK_PULSE, ENDURE, WILL_O_WISP, GIGA_IMPACT, FLASH, THUNDER_WAVE, DREAM_EATER, HEADBUTT, HYPER_VOICE, ICY_WIND, SKILL_SWAP, SLEEP_TALK, SUCKER_PUNCH, SWAGGER, TRICK
	; end
