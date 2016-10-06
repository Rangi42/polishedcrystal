	db ARBOK ; 024

if DEF(FAITHFUL)
	db  60,  85,  69,  80,  65,  79
	;   hp  atk  def  spd  sat  sdf
else
	db  60,  91,  69,  86,  65,  79
	;   hp  atk  def  spd  sat  sdf
endc

	db POISON, POISON
	db 90 ; catch rate
if DEF(FAITHFUL)
	db 147 ; base exp
else
	db 163 ; base exp
endc
	db NO_ITEM ; item 1
	db POISON_BARB ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db INTIMIDATE ; ability 1
	db SHED_SKIN ; ability 2
	db UNNERVE ; hidden ability
	db 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn FIELD, REPTILE ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, BULK_UP, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, GIGA_DRAIN, IRON_TAIL, EARTHQUAKE, RETURN, DIG, DOUBLE_TEAM, SLUDGE_BOMB, REST, ATTRACT, THIEF, ROCK_SLIDE, SUBSTITUTE, BODY_SLAM, DARK_PULSE, ENDURE, POISON_JAB, STRENGTH, AQUA_TAIL, DOUBLE_EDGE, HEADBUTT, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
