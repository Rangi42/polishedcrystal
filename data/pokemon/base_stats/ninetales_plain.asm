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
	INCBIN "gfx/pokemon/ninetales_plain/front.dimensions"
if DEF(FAITHFUL)
	abilities_for NINETALES, FLASH_FIRE, FLASH_FIRE, DROUGHT
else
	abilities_for NINETALES, FLASH_FIRE, FOREWARN, DROUGHT
endc
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	ev_yield   0,   0,   0,   1,   0,   1
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, CALM_MIND, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, SAFEGUARD, SOLAR_BEAM, IRON_TAIL, RETURN, DIG, SHADOW_BALL, DOUBLE_TEAM, FLAMETHROWER, FIRE_BLAST, SWIFT, SUBSTITUTE, FACADE, FLAME_CHARGE, REST, ATTRACT, THIEF, ENERGY_BALL, DARK_PULSE, WILL_O_WISP, GIGA_IMPACT, BODY_SLAM, DOUBLE_EDGE, DREAM_EATER, ENDURE, HEADBUTT, SLEEP_TALK, SWAGGER, ZEN_HEADBUTT
	; end
