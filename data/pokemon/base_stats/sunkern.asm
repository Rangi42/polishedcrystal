	db  30,  30,  30,  30,  30,  30 ; 180 BST
	;   hp  atk  def  spd  sat  sdf

	db GRASS, GRASS
	db 235 ; catch rate
	db 52 ; base exp
	db NO_ITEM ; item 1
	db STARF_BERRY ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/sunkern/front.dimensions"
	abilities_for SUNKERN, CHLOROPHYLL, SOLAR_POWER, EARLY_BIRD
	db MEDIUM_SLOW ; growth rate
	dn PLANT, PLANT ; egg groups

	ev_yield   0,   0,   0,   0,   1,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, LIGHT_SCREEN, PROTECT, GIGA_DRAIN, SAFEGUARD, SOLAR_BEAM, RETURN, DOUBLE_TEAM, SLUDGE_BOMB, SUBSTITUTE, FACADE, REST, ATTRACT, ENERGY_BALL, FLASH, SWORDS_DANCE, CUT, DEFENSE_CURL, DOUBLE_EDGE, EARTH_POWER, ENDURE, ROLLOUT, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
