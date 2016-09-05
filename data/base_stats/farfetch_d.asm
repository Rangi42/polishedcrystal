	db FARFETCH_D ; 083

if DEF(FAITHFUL)
	db  52,  65,  55,  60,  58,  62
	;   hp  atk  def  spd  sat  sdf
else
	db  55, 110,  55, 105,  60,  65
	;   hp  atk  def  spd  sat  sdf
endc

if DEF(FAITHFUL)
	db NORMAL, FLYING
else
	db FIGHTING, FLYING
endc
	db 45 ; catch rate
if DEF(FAITHFUL)
	db 94 ; base exp
else
	db 144 ; base exp
endc
	db NO_ITEM ; item 1
	db STICK ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 6, 6 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn AVIAN, FIELD ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, SWORDS_DANCE, HIDDEN_POWER, SUNNY_DAY, PROTECT, IRON_TAIL, RETURN, MUD_SLAP, DOUBLE_TEAM, SWAGGER, SWIFT, AERIAL_ACE, REST, ATTRACT, THIEF, BODY_SLAM, FURY_CUTTER, SUBSTITUTE, STEEL_WING, FALSE_SWIPE, ENDURE, POISON_JAB, CUT, FLY, ROCK_SMASH, DOUBLE_EDGE, HEADBUTT, SLEEP_TALK
	; end
