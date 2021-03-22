	db  60,  40,  80,  40,  60,  45 ; 325 BST
	;   hp  atk  def  spd  sat  sdf

	db GRASS, PSYCHIC ; type
	db 90 ; catch rate
	db 98 ; base exp
	db NO_ITEM ; item 1
	db MARANGABERRY ; item 2
	dn GENDER_F50, 3 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/exeggcute/front.dimensions"
	abilities_for EXEGGCUTE, CHLOROPHYLL, CHLOROPHYLL, HARVEST
	db GROWTH_SLOW ; growth rate
	dn EGG_PLANT, EGG_PLANT ; egg groups

	ev_yield   0,   0,   1,   0,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, LIGHT_SCREEN, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, PSYCHIC, DOUBLE_TEAM, REFLECT, SLUDGE_BOMB, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ENERGY_BALL, EXPLOSION, FLASH, SWORDS_DANCE, STRENGTH, DOUBLE_EDGE, DREAM_EATER, ENDURE, ROLLOUT, SEED_BOMB, SKILL_SWAP, SLEEP_TALK, SWAGGER
	; end
