	db GROWLITHE ; 058

	db  55,  70,  45,  60,  70,  50
	;   hp  atk  def  spd  sat  sdf

	db FIRE, FIRE
	db 190 ; catch rate
	db 91 ; base exp
	db BURNT_BERRY ; item 1
	db BURNT_BERRY ; item 2
	db 63 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 5, 5 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db SLOW ; growth rate
	dn FIELD, FIELD ; egg groups

	; tmhm
	tmhm CURSE, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, SAFEGUARD, DRAGONBREATH, IRON_TAIL, RETURN, DIG, MUD_SLAP, DOUBLE_TEAM, SWAGGER, FLAMETHROWER, FIRE_BLAST, SWIFT, WILD_CHARGE, REST, ATTRACT, THIEF, BODY_SLAM, SUBSTITUTE, ENDURE, WILL_O_WISP, STRENGTH, ROCK_SMASH, DOUBLE_EDGE, HEADBUTT, SLEEP_TALK
	; end
