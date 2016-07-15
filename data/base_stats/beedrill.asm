	db BEEDRILL ; 015

if DEF(FAITHFUL)
	db  65,  90,  40,  75,  45,  80
	;   hp  atk  def  spd  sat  sdf
else
	db  65, 100,  40, 115,  45,  90
	;   hp  atk  def  spd  sat  sdf
endc

	db BUG, POISON
	db 45 ; catch rate
if DEF(FAITHFUL)
	db 159 ; base exp
else
	db 184 ; base exp
endc
	db NO_ITEM ; item 1
	db POISON_BARB ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 15 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn INSECT, INSECT ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, SWORDS_DANCE, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, DOUBLE_TEAM, SWAGGER, SLUDGE_BOMB, SWIFT, REST, ATTRACT, THIEF, FURY_CUTTER, SUBSTITUTE, FALSE_SWIPE, X_SCISSOR, ENDURE, POISON_JAB, CUT, FLASH, ROCK_SMASH, DOUBLE_EDGE, SLEEP_TALK
	; end
