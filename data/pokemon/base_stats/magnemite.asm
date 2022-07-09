	db  25,  35,  70,  45,  95,  55 ; 325 BST
	;   hp  atk  def  spd  sat  sdf

	db ELECTRIC, STEEL ; type
	db 190 ; catch rate
	db 89 ; base exp
	db NO_ITEM, METAL_COAT ; held items
	dn GENDER_UNKNOWN, 3 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/magnemite/front.dimensions"
if DEF(FAITHFUL)
	abilities_for MAGNEMITE, STURDY, MAGNET_PULL, ANALYTIC
else
	abilities_for MAGNEMITE, LEVITATE, MAGNET_PULL, ANALYTIC
endc
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_MINERAL, EGG_MINERAL ; egg groups

	ev_yield   0,   0,   0,   0,   1,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, LIGHT_SCREEN, PROTECT, RAIN_DANCE, THUNDERBOLT, THUNDER, RETURN, DOUBLE_TEAM, REFLECT, FLASH_CANNON, SWIFT, SUBSTITUTE, FACADE, REST, WILD_CHARGE, EXPLOSION, FLASH, VOLT_SWITCH, THUNDER_WAVE, GYRO_BALL, DOUBLE_EDGE, ENDURE, ROLLOUT, SLEEP_TALK, SWAGGER, ZAP_CANNON
	; end
