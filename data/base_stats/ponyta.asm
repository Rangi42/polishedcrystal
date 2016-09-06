	db PONYTA ; 077

	db  50,  85,  55,  90,  65,  65
	;   hp  atk  def  spd  sat  sdf

	db FIRE, FIRE
	db 190 ; catch rate
	db 152 ; base exp
	db NO_ITEM ; item 1
	db BERRY ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 6, 6 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, SOLAR_BEAM, IRON_TAIL, RETURN, DOUBLE_TEAM, FLAMETHROWER, FIRE_BLAST, SWIFT, WILD_CHARGE, REST, ATTRACT, SUBSTITUTE, BODY_SLAM, ENDURE, WILL_O_WISP, STRENGTH, DOUBLE_EDGE, HEADBUTT, SLEEP_TALK, SWAGGER
	; end
