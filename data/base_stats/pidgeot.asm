	db PIDGEOT ; 018

if DEF(FAITHFUL)
	db  83,  80,  75, 101,  70,  70
	;   hp  atk  def  spd  sat  sdf
else
	db  93,  81,  75, 101,  90,  70
	;   hp  atk  def  spd  sat  sdf
endc

	db NORMAL, FLYING
	db 45 ; catch rate
if DEF(FAITHFUL)
	db 172 ; base exp
else
	db 194 ; base exp
endc
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 15 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_SLOW ; growth rate
	dn AVIAN, AVIAN ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, RETURN, MUD_SLAP, DOUBLE_TEAM, SWIFT, AERIAL_ACE, REST, ATTRACT, THIEF, STEEL_WING, SUBSTITUTE, ENDURE, FLY, DOUBLE_EDGE, SLEEP_TALK, SWAGGER
	; end
