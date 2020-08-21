	db  90, 110,  80,  95, 100,  80 ; 555 BST
	;   hp  atk  def  spd  sat  sdf

	db FIRE, FIRE
	db 75 ; catch rate
	db 213 ; base exp
	db NO_ITEM ; item 1
	db ASPEAR_BERRY ; item 2
	dn FEMALE_25, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/arcanine/front.dimensions"
	abilities_for ARCANINE, INTIMIDATE, FLASH_FIRE, JUSTIFIED
	db SLOW ; growth rate
	dn FIELD, FIELD ; egg groups

	ev_yield   0,   2,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, SAFEGUARD, BULLDOZE, SOLAR_BEAM, IRON_TAIL, RETURN, DIG, ROCK_SMASH, DOUBLE_TEAM, FLAMETHROWER, FIRE_BLAST, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, FLAME_CHARGE, REST, ATTRACT, THIEF, WILD_CHARGE, DRAGON_PULSE, WILL_O_WISP, GIGA_IMPACT, STRENGTH, BODY_SLAM, DOUBLE_EDGE, ENDURE, HEADBUTT, HYPER_VOICE, IRON_HEAD, SLEEP_TALK, SWAGGER
	; end
