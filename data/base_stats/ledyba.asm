	db LEDYBA ; 165

if DEF(FAITHFUL)
	db  40,  20,  30,  55,  40,  80
	;   hp  atk  def  spd  sat  sdf
else
	db  40,  40,  30,  55,  20,  80
	;   hp  atk  def  spd  sat  sdf
endc

	db BUG, FLYING
	db 255 ; catch rate
	db 54 ; base exp
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
	tmhm DYNAMICPUNCH, CURSE, TOXIC, ROLLOUT, SWORDS_DANCE, HIDDEN_POWER, SUNNY_DAY, LIGHT_SCREEN, PROTECT, GIGA_DRAIN, SAFEGUARD, SOLAR_BEAM, RETURN, DIG, DOUBLE_TEAM, REFLECT, SWAGGER, SWIFT, REST, ATTRACT, THIEF, SUBSTITUTE, ENDURE, FLASH, DOUBLE_EDGE, HEADBUTT, ICE_PUNCH, SLEEP_TALK, THUNDERPUNCH
	; end
