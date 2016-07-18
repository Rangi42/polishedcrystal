	db VILEPLUME ; 045

if DEF(FAITHFUL)
	db  75,  80,  85,  50, 110,  90
	;   hp  atk  def  spd  sat  sdf
else
	db  75,  80,  85,  50, 110, 100
	;   hp  atk  def  spd  sat  sdf
endc

	db GRASS, POISON
	db 45 ; catch rate
if DEF(FAITHFUL)
	db 184 ; base exp
else
	db 192 ; base exp
endc
	db SILVER_LEAF ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_SLOW ; growth rate
	dn PLANT, PLANT ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, SWORDS_DANCE, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, GIGA_DRAIN, SAFEGUARD, SOLAR_BEAM, RETURN, DOUBLE_TEAM, SWAGGER, SLUDGE_BOMB, REST, ATTRACT, BODY_SLAM, SUBSTITUTE, ENDURE, DAZZLINGLEAM, CUT, FLASH, DOUBLE_EDGE, EARTH_POWER, HYPER_VOICE, SEED_BOMB, SLEEP_TALK
	; end
