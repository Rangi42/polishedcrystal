	db SCIZOR ; 212

	db  70, 130, 100,  65,  55,  80
	;   hp  atk  def  spd  sat  sdf

	db BUG, STEEL
	db 25 ; catch rate
	db 200 ; base exp
	db NO_ITEM ; item 1
	db METAL_COAT ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 25 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn INSECT, INSECT ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, SWORDS_DANCE, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, SAFEGUARD, RETURN, DOUBLE_TEAM, SWAGGER, SANDSTORM, SWIFT, REST, ATTRACT, THIEF, FURY_CUTTER, SUBSTITUTE, STEEL_WING, FLASH_CANNON, FALSE_SWIPE, X_SCISSOR, ENDURE, CUT, FLY, STRENGTH, ROCK_SMASH, COUNTER, DOUBLE_EDGE, HEADBUTT, IRON_HEAD, SLEEP_TALK
	; end
