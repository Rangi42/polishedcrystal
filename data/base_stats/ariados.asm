if DEF(FAITHFUL)
	db  70,  90,  70,  40,  60,  70
	;   hp  atk  def  spd  sat  sdf
else
	db  70,  90,  70,  80,  60,  70
	;   hp  atk  def  spd  sat  sdf
endc

	db BUG, POISON
	db 90 ; catch rate
	db 134 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 2 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db SWARM ; ability 1
	db INSOMNIA ; ability 2
	db SNIPER ; hidden ability
	db FAST ; growth rate
	dn INSECT, INSECT ; egg groups

	; ev_yield
	ev_yield   0,   2,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HONE_CLAWS, HYPER_BEAM, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, DIG, PSYCHIC, DOUBLE_TEAM, SLUDGE_BOMB, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, LEECH_LIFE, X_SCISSOR, DARK_PULSE, ENDURE, POISON_JAB, GIGA_IMPACT, FLASH, SWORDS_DANCE, BODY_SLAM, DOUBLE_EDGE, SLEEP_TALK, SUCKER_PUNCH, SWAGGER
	; end
