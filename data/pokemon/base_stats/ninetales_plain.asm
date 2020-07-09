	db  73,  76,  75, 100,  81, 100 ; 505 BST
	;   hp  atk  def  spd  sat  sdf

if DEF(FAITHFUL)
	db FIRE, FIRE
else
	db FIRE, GHOST
endc
	db 75 ; catch rate
	db 178 ; base exp
	db ALWAYS_ITEM_2 ; item 1
	db ASPEAR_BERRY ; item 2
	dn FEMALE_75, 3 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db FLASH_FIRE ; ability 1
if DEF(FAITHFUL)
	db FLASH_FIRE ; ability 2
else
	db FOREWARN ; ability 2
endc
	db DROUGHT ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   1,   0,   1
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, CALM_MIND, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, SAFEGUARD, SOLAR_BEAM, IRON_TAIL, RETURN, DIG, SHADOW_BALL, DOUBLE_TEAM, FLAMETHROWER, FIRE_BLAST, SWIFT, SUBSTITUTE, FACADE, FLAME_CHARGE, REST, ATTRACT, THIEF, ENERGY_BALL, DARK_PULSE, WILL_O_WISP, GIGA_IMPACT, BODY_SLAM, DOUBLE_EDGE, DREAM_EATER, ENDURE, HEADBUTT, SLEEP_TALK, SWAGGER, ZEN_HEADBUTT
	; end
