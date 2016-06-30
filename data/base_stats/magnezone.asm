	db MAGNEZONE ; 462

	db  70,  70, 115,  60, 130,  90
	;   hp  atk  def  spd  sat  sdf

	db ELECTRIC, STEEL
	db 30 ; catch rate
	db 211 ; base exp
	db NO_ITEM ; item 1
	db METAL_COAT ; item 2
	db 255 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn INANIMATE, INANIMATE ; egg groups

	; tmhm
	tmhm TOXIC, ROLLOUT, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, THUNDERBOLT, THUNDER, RETURN, DOUBLE_TEAM, REFLECT, SWAGGER, SWIFT, WILD_CHARGE, REST, SUBSTITUTE, FLASH_CANNON, ENDURE, THUNDER_WAVE, EXPLOSION, FLASH, IRON_HEAD, SLEEP_TALK, ZAP_CANNON
	; end
