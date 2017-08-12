	db BELLOSSOM ; 182

if DEF(FAITHFUL)
	db  75,  80,  95,  50,  90, 100
	;   hp  atk  def  spd  sat  sdf
else
	db  75,  80,  95,  50, 100, 110
	;   hp  atk  def  spd  sat  sdf
endc

if DEF(FAITHFUL)
	db GRASS, GRASS
else
	db GRASS, FAIRY
endc
	db 45 ; catch rate
if DEF(FAITHFUL)
	db 184 ; base exp
else
	db 192 ; base exp
endc
	db SILVER_LEAF ; item 1
	db NO_ITEM ; item 2
	db FEMALE_50 ; gender
	db 20 ; step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db CHLOROPHYLL ; ability 1
	db CHLOROPHYLL ; ability 2
if DEF(FAITHFUL)
	db CHLOROPHYLL ; hidden ability
else
	db OWN_TEMPO ; hidden ability
endc
	db MEDIUM_SLOW ; growth rate
	dn PLANT, PLANT ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   0,   3
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, SWORDS_DANCE, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, GIGA_DRAIN, SAFEGUARD, SOLAR_BEAM, RETURN, DOUBLE_TEAM, SLUDGE_BOMB, FACADE, REST, ATTRACT, ENERGY_BALL, ENDURE, DAZZLINGLEAM, GIGA_IMPACT, FLASH, CUT, DOUBLE_EDGE, HYPER_VOICE, SEED_BOMB, SLEEP_TALK, SUBSTITUTE, SWAGGER
	; end
