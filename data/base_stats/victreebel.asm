	db VICTREEBEL ; 071

if DEF(FAITHFUL)
	db  80, 105,  65,  70, 100,  70
	;   hp  atk  def  spd  sat  sdf
else
	db  80, 115,  65,  70, 110,  70
	;   hp  atk  def  spd  sat  sdf
endc

	db GRASS, POISON
	db 45 ; catch rate
if DEF(FAITHFUL)
	db 191 ; base exp
else
	db 199 ; base exp
endc
	db GOLD_LEAF ; item 1
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
	tmhm CURSE, TOXIC, SWORDS_DANCE, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, DOUBLE_TEAM, REFLECT, SWAGGER, SLUDGE_BOMB, REST, ATTRACT, THIEF, BODY_SLAM, SUBSTITUTE, ENDURE, CUT, FLASH, DOUBLE_EDGE, SEED_BOMB, SLEEP_TALK
	; end
