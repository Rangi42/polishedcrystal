	db  40,  30,  50, 100,  55,  55
	;   hp  atk  def  spd  sat  sdf

	db ELECTRIC, ELECTRIC
	db 190 ; catch rate
	db 103 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn GENDERLESS, 3 ; gender, step cycles to hatch
	dn 5, 5 ; frontpic dimensions
	db SOUNDPROOF ; ability 1
	db STATIC ; ability 2
	db AFTERMATH ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn INANIMATE, INANIMATE ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   1,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, LIGHT_SCREEN, PROTECT, RAIN_DANCE, THUNDERBOLT, THUNDER, RETURN, DOUBLE_TEAM, SWIFT, SUBSTITUTE, FACADE, WILD_CHARGE, REST, THIEF, ENDURE, EXPLOSION, FLASH, VOLT_SWITCH, THUNDER_WAVE, GYRO_BALL, HEADBUTT, ROLLOUT, SLEEP_TALK, SUCKER_PUNCH, SWAGGER, ZAP_CANNON
	; end
