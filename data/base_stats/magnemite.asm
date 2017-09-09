	db  25,  35,  70,  45,  95,  55
	;   hp  atk  def  spd  sat  sdf

	db ELECTRIC, STEEL
	db 190 ; catch rate
	db 89 ; base exp
	db NO_ITEM ; item 1
	db METAL_COAT ; item 2
	dn GENDERLESS, 3 ; gender, step cycles to hatch
	dn 5, 5 ; frontpic dimensions
	db MAGNET_PULL ; ability 1
if DEF(FAITHFUL)
	db STURDY ; ability 2
else
	db LEVITATE ; ability 2
endc
	db ANALYTIC ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn INANIMATE, INANIMATE ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   1,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, LIGHT_SCREEN, PROTECT, RAIN_DANCE, THUNDERBOLT, THUNDER, RETURN, DOUBLE_TEAM, REFLECT, FLASH_CANNON, SWIFT, SUBSTITUTE, FACADE, WILD_CHARGE, REST, ENDURE, EXPLOSION, FLASH, VOLT_SWITCH, THUNDER_WAVE, GYRO_BALL, DOUBLE_EDGE, ROLLOUT, SLEEP_TALK, SWAGGER, ZAP_CANNON
	; end
