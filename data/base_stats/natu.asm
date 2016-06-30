	db NATU ; 177

	db  40,  50,  45,  70,  70,  45
	;   hp  atk  def  spd  sat  sdf

	db PSYCHIC, FLYING
	db 190 ; catch rate
	db 73 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 5, 5 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn AVIAN, AVIAN ; egg groups

	; tmhm
	tmhm CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, LIGHT_SCREEN, PROTECT, RAIN_DANCE, GIGA_DRAIN, SOLAR_BEAM, RETURN, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, REFLECT, SWAGGER, SWIFT, REST, ATTRACT, THIEF, SUBSTITUTE, STEEL_WING, ENDURE, DAZZLINGLEAM, THUNDER_WAVE, FLASH, DOUBLE_EDGE, DREAM_EATER, SLEEP_TALK, ZEN_HEADBUTT
	; end
