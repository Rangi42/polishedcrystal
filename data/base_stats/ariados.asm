	db ARIADOS ; 168

if DEF(FAITHFUL)
	db  70,  90,  70,  40,  60,  60
	;   hp  atk  def  spd  sat  sdf
else
	db  70,  90,  70,  80,  60,  60
	;   hp  atk  def  spd  sat  sdf
endc

	db BUG, POISON
	db 90 ; catch rate
	db 134 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 15 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db SWARM ; ability 1
	db INSOMNIA ; ability 2
	db SNIPER ; hidden ability
	db 0 ; padding
	db FAST ; growth rate
	dn INSECT, INSECT ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HONE_CLAWS, HYPER_BEAM, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, DIG, PSYCHIC, DOUBLE_TEAM, SLUDGE_BOMB, REST, ATTRACT, THIEF, SUBSTITUTE, BODY_SLAM, X_SCISSOR, DARK_PULSE, ENDURE, POISON_JAB, FLASH, DOUBLE_EDGE, SLEEP_TALK, SWAGGER
	; end
