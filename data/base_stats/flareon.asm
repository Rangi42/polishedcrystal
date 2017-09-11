	db  65, 130,  60,  65,  95, 110
	;   hp  atk  def  spd  sat  sdf

	db FIRE, FIRE
	db 45 ; catch rate
	db 198 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_12_5, 6 ; gender, step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db FLASH_FIRE ; ability 1
if DEF(FAITHFUL)
	db FLASH_FIRE ; ability 2
else
	db DROUGHT ; ability 2
endc
	db GUTS ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; ev_yield
	ev_yield   0,   2,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, IRON_TAIL, RETURN, DIG, SHADOW_BALL, DOUBLE_TEAM, FLAMETHROWER, FIRE_BLAST, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, ROCK_SMASH, ENDURE, WILL_O_WISP, GIGA_IMPACT, STRENGTH, BODY_SLAM, DOUBLE_EDGE, HEADBUTT, HYPER_VOICE, SLEEP_TALK, SWAGGER, ZAP_CANNON
	; end
