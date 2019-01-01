	db  65,  65,  60, 110, 130,  95
	;   hp  atk  def  spd  sat  sdf

	db PSYCHIC, PSYCHIC
	db 45 ; catch rate
	db 197 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_12_5, 6 ; gender, step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db SYNCHRONIZE ; ability 1
if DEF(FAITHFUL)
	db SYNCHRONIZE ; ability 2
else
	db MAGIC_GUARD ; ability 2
endc
	db MAGIC_BOUNCE ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   2,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, IRON_TAIL, RETURN, DIG, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, REFLECT, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, DAZZLINGLEAM, ENDURE, GIGA_IMPACT, FLASH, CUT, BODY_SLAM, DOUBLE_EDGE, DREAM_EATER, HEADBUTT, HYPER_VOICE, SKILL_SWAP, SLEEP_TALK, SWAGGER, TRICK, ZAP_CANNON, ZEN_HEADBUTT
	; end
