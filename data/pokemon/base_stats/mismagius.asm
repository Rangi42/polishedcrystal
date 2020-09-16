if DEF(FAITHFUL)
	db  60,  60,  60, 105, 105, 105 ; 495 BST
	;   hp  atk  def  spd  sat  sdf
else
	db  60,  60,  60, 110, 110, 110 ; 510 BST
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
	INCBIN "gfx/pokemon/mismagius/front.dimensions"
	abilities_for MISMAGIUS, LEVITATE, LEVITATE, LEVITATE
	db FAST ; growth rate
	dn AMORPHOUS, AMORPHOUS ; egg groups

	ev_yield   0,   0,   0,   0,   1,   1
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, THUNDERBOLT, THUNDER, RETURN, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, FLAMETHROWER, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, DAZZLINGLEAM, ENERGY_BALL, DARK_PULSE, WILL_O_WISP, GIGA_IMPACT, FLASH, THUNDER_WAVE, DEFENSE_CURL, DOUBLE_EDGE, DREAM_EATER, ENDURE, HEADBUTT, HYPER_VOICE, ICY_WIND, SKILL_SWAP, SLEEP_TALK, SUCKER_PUNCH, SWAGGER, TRICK
	; end
