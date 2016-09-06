	db SUNFLORA ; 192

if DEF(FAITHFUL)
	db  75,  75,  55,  30, 105,  85
	;   hp  atk  def  spd  sat  sdf
else
	db  75,  55,  75,  85, 105,  85
	;   hp  atk  def  spd  sat  sdf
endc

if DEF(FAITHFUL)
	db GRASS, GRASS
else
	db GRASS, FIRE
endc
if DEF(FAITHFUL)
	db 120 ; catch rate
else
	db 110 ; catch rate
endc
if DEF(FAITHFUL)
	db 146 ; base exp
else
	db 156 ; base exp
endc
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 6, 6 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_SLOW ; growth rate
	dn PLANT, PLANT ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, SWORDS_DANCE, HIDDEN_POWER, SUNNY_DAY, LIGHT_SCREEN, PROTECT, GIGA_DRAIN, SAFEGUARD, SOLAR_BEAM, RETURN, DOUBLE_TEAM, FLAMETHROWER, SLUDGE_BOMB, FIRE_BLAST, REST, ATTRACT, SUBSTITUTE, ENERGY_BALL, ENDURE, CUT, FLASH, DEFENSE_CURL, DOUBLE_EDGE, EARTH_POWER, ROLLOUT, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
