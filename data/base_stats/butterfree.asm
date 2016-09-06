	db BUTTERFREE ; 012


if DEF(FAITHFUL)
	db  60,  45,  50,  70,  90,  80
	;   hp  atk  def  spd  sat  sdf
else
	db  60,  45,  50,  80, 110, 110
	;   hp  atk  def  spd  sat  sdf
endc

if DEF(FAITHFUL)
	db BUG, FLYING
else
	db BUG, PSYCHIC
endc
	db 45 ; catch rate
if DEF(FAITHFUL)
	db 160 ; base exp
else
	db 185 ; base exp
endc
	db NO_ITEM ; item 1
	db SILVERPOWDER ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 15 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn INSECT, INSECT ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, GIGA_DRAIN, SAFEGUARD, SOLAR_BEAM, RETURN, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, SWIFT, AERIAL_ACE, REST, ATTRACT, THIEF, SUBSTITUTE, ENERGY_BALL, ENDURE, FLASH, DOUBLE_EDGE, DREAM_EATER, SLEEP_TALK, SWAGGER
	; end
