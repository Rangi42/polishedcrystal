	db SUNFLORA ; 192

if DEF(FAITHFUL)
	db  75,  75,  55,  30, 105,  85
	;   hp  atk  def  spd  sat  sdf
else
	db  75,  55,  75,  95, 105,  75
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
	tmhm CURSE, TOXIC, ROLLOUT, SWORDS_DANCE, HIDDEN_POWER, SUNNY_DAY, LIGHT_SCREEN, PROTECT, GIGA_DRAIN, SAFEGUARD, SOLAR_BEAM, RETURN, DOUBLE_TEAM, SWAGGER, FLAMETHROWER, SLUDGE_BOMB, FIRE_BLAST, DEFENSE_CURL, REST, ATTRACT, SUBSTITUTE, ENDURE, CUT, FLASH, DOUBLE_EDGE, EARTH_POWER, SEED_BOMB, SLEEP_TALK
	; end
