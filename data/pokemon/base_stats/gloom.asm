	db  60,  65,  70,  40,  85,  75 ; 395 BST
	;   hp  atk  def  spd  sat  sdf

	db GRASS, POISON
	db 120 ; catch rate
	db 132 ; base exp
	db SILVER_LEAF ; item 1
	db SILVER_LEAF ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/gloom/front.dimensions"
	abilities_for GLOOM, CHLOROPHYLL, CHLOROPHYLL, STENCH
	db MEDIUM_SLOW ; growth rate
	dn PLANT, PLANT ; egg groups

	ev_yield   0,   0,   0,   0,   2,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, DOUBLE_TEAM, SLUDGE_BOMB, SUBSTITUTE, FACADE, REST, ATTRACT, DAZZLINGLEAM, ENERGY_BALL, DRAIN_PUNCH, FLASH, SWORDS_DANCE, CUT, DOUBLE_EDGE, ENDURE, HYPER_VOICE, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
