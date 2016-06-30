	db SKARMORY ; 227

	db  65,  80, 140,  70,  40,  70
	;   hp  atk  def  spd  sat  sdf

	db STEEL, FLYING
	db 25 ; catch rate
	db 168 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 25 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db SLOW ; growth rate
	dn AVIAN, AVIAN ; egg groups

	; tmhm
	tmhm CURSE, ROAR, TOXIC, SWORDS_DANCE, HIDDEN_POWER, SUNNY_DAY, ICY_WIND, PROTECT, RETURN, MUD_SLAP, DOUBLE_TEAM, SWAGGER, SANDSTORM, SWIFT, REST, ATTRACT, THIEF, ROCK_SLIDE, FURY_CUTTER, SUBSTITUTE, STEEL_WING, FLASH_CANNON, X_SCISSOR, DARK_PULSE, ENDURE, CUT, FLY, FLASH, ROCK_SMASH, COUNTER, DOUBLE_EDGE, IRON_HEAD, SLEEP_TALK
	; end
