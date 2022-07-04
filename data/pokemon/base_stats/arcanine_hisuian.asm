	db  95, 115,  80,  90,  95,  80 ; 555 BST
	;   hp  atk  def  spd  sat  sdf

	db FIRE, ROCK ; type
	db 75 ; catch rate
	db 213 ; base exp
	db NO_ITEM, ASPEAR_BERRY ; held items
	dn GENDER_F25, 3 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/arcanine_hisuian/front.dimensions"
if DEF(FAITHFUL)
	abilities_for ARCANINE_HISUIAN, INTIMIDATE, FLASH_FIRE, JUSTIFIED
else
	abilities_for ARCANINE_HISUIAN, INTIMIDATE, FLASH_FIRE, ROCK_HEAD
endc
	db GROWTH_SLOW ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	ev_yield   0,   2,   0,   0,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, ROAR, TOXIC, BULK_UP, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, SAFEGUARD, BULLDOZE, SOLAR_BEAM, IRON_TAIL, RETURN, DIG, ROCK_SMASH, DOUBLE_TEAM, FLAMETHROWER, FIRE_BLAST, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, FLAME_CHARGE, REST, ATTRACT, THIEF, ROCK_SLIDE, WILD_CHARGE, DRAGON_PULSE, WILL_O_WISP, GIGA_IMPACT, STONE_EDGE, STRENGTH, BODY_SLAM, DOUBLE_EDGE, ENDURE, HEADBUTT, HYPER_VOICE, IRON_HEAD, SLEEP_TALK, SWAGGER
	; end
