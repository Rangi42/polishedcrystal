	db LEDIAN ; 166

if DEF(FAITHFUL)
	db  55,  35,  50,  85,  55, 110
	;   hp  atk  def  spd  sat  sdf
else
	db  55,  95,  50,  85,  35, 110
	;   hp  atk  def  spd  sat  sdf
endc

if DEF(FAITHFUL)
	db BUG, FLYING
else
	db BUG, FIGHTING
endc
	db 90 ; catch rate
	db 134 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 15 ; step cycles to hatch
	db 5 ; unknown
	dn 6, 6 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db FAST ; growth rate
	dn INSECT, INSECT ; egg groups

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, ROLLOUT, SWORDS_DANCE, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, LIGHT_SCREEN, PROTECT, GIGA_DRAIN, SAFEGUARD, SOLAR_BEAM, RETURN, DIG, DOUBLE_TEAM, REFLECT, SWAGGER, SWIFT, REST, ATTRACT, THIEF, SUBSTITUTE, FOCUS_BLAST, ENDURE, STRENGTH, FLASH, ROCK_SMASH, DOUBLE_EDGE, HEADBUTT, ICE_PUNCH, SLEEP_TALK, THUNDERPUNCH
	; end
