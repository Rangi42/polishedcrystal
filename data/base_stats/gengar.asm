	db GENGAR ; 094

	db  60,  65,  60, 110, 130,  75
	;   hp  atk  def  spd  sat  sdf

	db GHOST, POISON
	db 45 ; catch rate
	db 190 ; base exp
	db NO_ITEM ; item 1
	db SPELL_TAG ; item 2
	db 127 ; gender
	db 20 ; step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db CURSED_BODY ; ability 1
if DEF(FAITHFUL)
	db CURSED_BODY ; ability 2
else
	db LEVITATE ; ability 2
endc
	db SHADOW_TAG ; hidden ability
	db MEDIUM_SLOW ; growth rate
	dn AMORPHOUS, AMORPHOUS ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   3,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, GIGA_DRAIN, THUNDERBOLT, THUNDER, RETURN, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, SLUDGE_BOMB, REST, ATTRACT, THIEF, ROCK_SMASH, FOCUS_BLAST, LEECH_LIFE, ENERGY_BALL, DARK_PULSE, ENDURE, DAZZLINGLEAM, WILL_O_WISP, EXPLOSION, SHADOW_CLAW, POISON_JAB, GIGA_IMPACT, STRENGTH, BODY_SLAM, COUNTER, DOUBLE_EDGE, DREAM_EATER, FIRE_PUNCH, HEADBUTT, ICE_PUNCH, ICY_WIND, SEISMIC_TOSS, SLEEP_TALK, SUBSTITUTE, SUCKER_PUNCH, SWAGGER, THUNDERPUNCH, ZAP_CANNON
	; end
