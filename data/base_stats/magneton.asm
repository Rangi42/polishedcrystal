	db MAGNETON ; 082

	db  50,  60,  95,  70, 120,  70
	;   hp  atk  def  spd  sat  sdf

	db ELECTRIC, STEEL
	db 60 ; catch rate
	db 161 ; base exp
	db NO_ITEM ; item 1
	db METAL_COAT ; item 2
	db GENDERLESS ; gender
	db 20 ; step cycles to hatch
	dn 6, 6 ; frontpic dimensions
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
	ev_yield   0,   0,   0,   0,   2,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, THUNDERBOLT, THUNDER, RETURN, DOUBLE_TEAM, REFLECT, FLASH_CANNON, SWIFT, FACADE, WILD_CHARGE, REST, ENDURE, THUNDER_WAVE, EXPLOSION, GIGA_IMPACT, FLASH, DOUBLE_EDGE, ROLLOUT, SLEEP_TALK, SUBSTITUTE, SWAGGER, VOLT_SWITCH, ZAP_CANNON
	; end
