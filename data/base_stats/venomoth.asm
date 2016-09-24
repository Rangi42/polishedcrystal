	db VENOMOTH ; 049

if DEF(FAITHFUL)
	db  70,  65,  60,  90,  90,  75
	;   hp  atk  def  spd  sat  sdf
else
	db  70,  65,  60,  90, 115,  75
	;   hp  atk  def  spd  sat  sdf
endc

	db BUG, POISON
	db 75 ; catch rate
	db 138 ; base exp
	db NO_ITEM ; item 1
	db SILVERPOWDER ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db SHIELD_DUST ; ability 1
	db TINTED_LENS ; ability 2
	db WONDER_SKIN ; hidden ability
	db 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn INSECT, INSECT ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, PSYCHIC, DOUBLE_TEAM, SLUDGE_BOMB, SWIFT, AERIAL_ACE, REST, ATTRACT, THIEF, SUBSTITUTE, ENERGY_BALL, ENDURE, FLASH, DOUBLE_EDGE, SLEEP_TALK, SWAGGER, ZEN_HEADBUTT
	; end
