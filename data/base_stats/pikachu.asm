	db PIKACHU ; 025

if DEF(FAITHFUL)
	db  35,  55,  40,  90,  50,  50
	;   hp  atk  def  spd  sat  sdf
else
	db  35,  65,  40,  95,  60,  50
	;   hp  atk  def  spd  sat  sdf
endc

	db ELECTRIC, ELECTRIC
	db 190 ; catch rate
if DEF(FAITHFUL)
	db 82 ; base exp
else
	db 92 ; base exp
endc
	db NO_ITEM ; item 1
	db BERRY ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 10 ; step cycles to hatch
	db 5 ; unknown
	dn 5, 5 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn FIELD, FAERY ; egg groups

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, ROLLOUT, HIDDEN_POWER, LIGHT_SCREEN, PROTECT, RAIN_DANCE, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, DIG, MUD_SLAP, DOUBLE_TEAM, SWAGGER, SWIFT, DEFENSE_CURL, WILD_CHARGE, REST, ATTRACT, BODY_SLAM, SUBSTITUTE, ENDURE, THUNDER_WAVE, STRENGTH, FLASH, ROCK_SMASH, COUNTER, DOUBLE_EDGE, HEADBUTT, SEISMIC_TOSS, SLEEP_TALK, THUNDERPUNCH, ZAP_CANNON
	; end
