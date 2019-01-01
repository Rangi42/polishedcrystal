	db  70,  70, 115,  60, 130,  90
	;   hp  atk  def  spd  sat  sdf

	db ELECTRIC, STEEL
	db 30 ; catch rate
	db 211 ; base exp
	db NO_ITEM ; item 1
	db METAL_COAT ; item 2
	dn GENDERLESS, 3 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
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
	ev_yield   0,   0,   0,   0,   3,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, THUNDERBOLT, THUNDER, RETURN, DOUBLE_TEAM, REFLECT, FLASH_CANNON, SWIFT, SUBSTITUTE, FACADE, WILD_CHARGE, REST, ENDURE, EXPLOSION, GIGA_IMPACT, FLASH, VOLT_SWITCH, THUNDER_WAVE, GYRO_BALL, IRON_HEAD, ROLLOUT, SLEEP_TALK, SWAGGER, ZAP_CANNON
	; end
