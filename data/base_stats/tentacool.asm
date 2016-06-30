	db TENTACOOL ; 072

	db  40,  40,  35,  70,  50, 100
	;   hp  atk  def  spd  sat  sdf

	db WATER, POISON
	db 190 ; catch rate
	db 105 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 5, 5 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db SLOW ; growth rate
	dn INVERTEBRATE, INVERTEBRATE ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, SWORDS_DANCE, HIDDEN_POWER, ICY_WIND, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, GIGA_DRAIN, SAFEGUARD, RETURN, DOUBLE_TEAM, SWAGGER, SLUDGE_BOMB, REST, ATTRACT, THIEF, SUBSTITUTE, SCALD, ENDURE, DAZZLINGLEAM, POISON_JAB, CUT, SURF, WHIRLPOOL, WATERFALL, DOUBLE_EDGE, SLEEP_TALK
	; end
