	db WEAVILE ; 461

	db  70, 120,  65, 125,  45,  85
	;   hp  atk  def  spd  sat  sdf

	db DARK, ICE
	db 45 ; catch rate
	db 199 ; base exp
	db NO_ITEM ; item 1
	db QUICK_CLAW ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_SLOW ; growth rate
	dn FIELD, FIELD ; egg groups

	; tmhm
	tmhm CALM_MIND, TOXIC, SWORDS_DANCE, HIDDEN_POWER, SUNNY_DAY, ICY_WIND, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, IRON_TAIL, RETURN, DIG, SHADOW_BALL, MUD_SLAP, DOUBLE_TEAM, REFLECT, SWAGGER, SWIFT, AVALANCHE, REST, ATTRACT, THIEF, FURY_CUTTER, SUBSTITUTE, FOCUS_BLAST, FALSE_SWIPE, X_SCISSOR, DARK_PULSE, ENDURE, POISON_JAB, SHADOW_CLAW, CUT, SURF, STRENGTH, WHIRLPOOL, ROCK_SMASH, DREAM_EATER, HEADBUTT, ICE_PUNCH, SLEEP_TALK
	; end
