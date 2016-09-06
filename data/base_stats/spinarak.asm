	db SPINARAK ; 167

	db  40,  60,  40,  30,  40,  40
	;   hp  atk  def  spd  sat  sdf

	db BUG, POISON
	db 255 ; catch rate
	db 54 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 15 ; step cycles to hatch
	db 5 ; unknown
	dn 5, 5 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db FAST ; growth rate
	dn INSECT, INSECT ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HONE_CLAWS, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, DIG, PSYCHIC, DOUBLE_TEAM, SLUDGE_BOMB, REST, ATTRACT, THIEF, SUBSTITUTE, BODY_SLAM, X_SCISSOR, DARK_PULSE, ENDURE, POISON_JAB, FLASH, DOUBLE_EDGE, SLEEP_TALK, SWAGGER
	; end
