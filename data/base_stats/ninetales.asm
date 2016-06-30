	db NINETALES ; 038

	db  73,  76,  75, 100,  81, 100
	;   hp  atk  def  spd  sat  sdf

	db FIRE, GHOST
	db 75 ; catch rate
	db 178 ; base exp
	db BURNT_BERRY ; item 1
	db BURNT_BERRY ; item 2
	db 191 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; tmhm
	tmhm CURSE, CALM_MIND, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, SAFEGUARD, SOLAR_BEAM, IRON_TAIL, RETURN, DIG, DOUBLE_TEAM, SWAGGER, FLAMETHROWER, FIRE_BLAST, SWIFT, REST, ATTRACT, BODY_SLAM, SUBSTITUTE, DARK_PULSE, ENDURE, WILL_O_WISP, DOUBLE_EDGE, DREAM_EATER, HEADBUTT, SLEEP_TALK, ZEN_HEADBUTT
	; end
