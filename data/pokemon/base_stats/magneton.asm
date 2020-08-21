	db  50,  60,  95,  70, 120,  70 ; 465 BST
	;   hp  atk  def  spd  sat  sdf

	db ELECTRIC, STEEL
	db 60 ; catch rate
	db 161 ; base exp
	db NO_ITEM ; item 1
	db METAL_COAT ; item 2
	dn GENDERLESS, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/magneton/front.dimensions"
if DEF(FAITHFUL)
	abilities_for MAGNETON, MAGNET_PULL, STURDY, ANALYTIC
else
	abilities_for MAGNETON, MAGNET_PULL, LEVITATE, ANALYTIC
endc
	db MEDIUM_FAST ; growth rate
	dn INANIMATE, INANIMATE ; egg groups

	ev_yield   0,   0,   0,   0,   2,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, THUNDERBOLT, THUNDER, RETURN, DOUBLE_TEAM, REFLECT, FLASH_CANNON, SWIFT, SUBSTITUTE, FACADE, REST, WILD_CHARGE, EXPLOSION, GIGA_IMPACT, FLASH, VOLT_SWITCH, THUNDER_WAVE, GYRO_BALL, DOUBLE_EDGE, ENDURE, ROLLOUT, SLEEP_TALK, SWAGGER, ZAP_CANNON
	; end
