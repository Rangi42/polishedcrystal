	db MISMAGIUS ; 429

	db  60,  60,  60, 105, 105, 105
	;   hp  atk  def  spd  sat  sdf

	db GHOST, FAIRY
	db 45 ; catch rate
	db 187 ; base exp
	db NO_ITEM ; item 1
	db SPELL_TAG ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 25 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db FAST ; growth rate
	dn AMORPHOUS, AMORPHOUS ; egg groups

	; tmhm
	tmhm HEADBUTT, CURSE, TOXIC, ZAP_CANNON, HIDDEN_POWER, SUNNY_DAY, PROTECT, RAIN_DANCE, ENDURE, THUNDER, RETURN, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, SWAGGER, SLEEP_TALK, SWIFT, DEFENSE_CURL, DREAM_EATER, DAZZLINGLEAM, REST, ATTRACT, THIEF, NIGHTMARE, FLASH, THUNDERBOLT
	; end
