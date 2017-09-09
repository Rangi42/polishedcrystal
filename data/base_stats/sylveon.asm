	db  95,  65,  65,  60, 110, 130
	;   hp  atk  def  spd  sat  sdf

	db FAIRY, FAIRY
	db 45 ; catch rate
	db 196 ; base exp
	db NO_ITEM ; item 1
	db PINK_BOW ; item 2
	dn FEMALE_12_5, 6 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db CUTE_CHARM ; ability 1
if DEF(FAITHFUL)
	db CUTE_CHARM ; ability 2
else
	db SERENE_GRACE ; ability 2
endc
	db PIXILATE ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   0,   2
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, SAFEGUARD, IRON_TAIL, RETURN, DIG, SHADOW_BALL, DOUBLE_TEAM, REFLECT, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, DAZZLINGLEAM, FLASH, CUT, DOUBLE_EDGE, HYPER_VOICE, SKILL_SWAP, SLEEP_TALK, SWAGGER
	; end
