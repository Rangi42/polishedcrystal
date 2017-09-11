	db  95,  65, 110,  65,  60, 130
	;   hp  atk  def  spd  sat  sdf

	db DARK, DARK
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
	db INNER_FOCUS ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   0,   2
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, IRON_TAIL, RETURN, DIG, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, DARK_PULSE, ENDURE, GIGA_IMPACT, FLASH, CUT, BODY_SLAM, DOUBLE_EDGE, DREAM_EATER, HEADBUTT, HYPER_VOICE, SLEEP_TALK, SUCKER_PUNCH, SWAGGER, ZAP_CANNON
	; end
