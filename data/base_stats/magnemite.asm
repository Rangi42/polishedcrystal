	db MAGNEMITE ; 081

	db  25,  35,  70,  45,  95,  55
	;   hp  atk  def  spd  sat  sdf

	db ELECTRIC, STEEL
	db 190 ; catch rate
	db 89 ; base exp
	db NO_ITEM ; item 1
	db METAL_COAT ; item 2
	db 255 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 5, 5 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn INANIMATE, INANIMATE ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, ROLLOUT, HIDDEN_POWER, SUNNY_DAY, LIGHT_SCREEN, PROTECT, RAIN_DANCE, THUNDERBOLT, THUNDER, RETURN, DOUBLE_TEAM, REFLECT, SWAGGER, SWIFT, WILD_CHARGE, REST, SUBSTITUTE, FLASH_CANNON, ENDURE, THUNDER_WAVE, EXPLOSION, FLASH, DOUBLE_EDGE, SLEEP_TALK, ZAP_CANNON
	; end
