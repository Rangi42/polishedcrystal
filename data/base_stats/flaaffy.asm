	db FLAAFFY ; 180

	db  70,  55,  55,  45,  80,  60
	;   hp  atk  def  spd  sat  sdf

	db ELECTRIC, ELECTRIC
	db 120 ; catch rate
	db 117 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 6, 6 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_SLOW ; growth rate
	dn MONSTER, FIELD ; egg groups

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, HIDDEN_POWER, LIGHT_SCREEN, PROTECT, RAIN_DANCE, SAFEGUARD, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, DOUBLE_TEAM, SWIFT, WILD_CHARGE, REST, ATTRACT, SUBSTITUTE, BODY_SLAM, ENDURE, THUNDER_WAVE, STRENGTH, FLASH, ROCK_SMASH, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, FIRE_PUNCH, HEADBUTT, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, THUNDERPUNCH, ZAP_CANNON
	; end
