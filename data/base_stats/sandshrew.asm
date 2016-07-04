	db SANDSHREW ; 027

	db  50,  75,  85,  40,  20,  30
	;   hp  atk  def  spd  sat  sdf

	db GROUND, GROUND
	db 255 ; catch rate
	db 93 ; base exp
	db NO_ITEM ; item 1
	db QUICK_CLAW ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 5, 5 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, ROLLOUT, SWORDS_DANCE, HIDDEN_POWER, SUNNY_DAY, PROTECT, SAFEGUARD, IRON_TAIL, EARTHQUAKE, RETURN, DIG, MUD_SLAP, DOUBLE_TEAM, SWAGGER, SANDSTORM, SWIFT, DEFENSE_CURL, REST, ATTRACT, THIEF, BODY_SLAM, ROCK_SLIDE, FURY_CUTTER, SUBSTITUTE, X_SCISSOR, ENDURE, POISON_JAB, SHADOW_CLAW, CUT, STRENGTH, ROCK_SMASH, COUNTER, DOUBLE_EDGE, EARTH_POWER, HEADBUTT, SEISMIC_TOSS, SLEEP_TALK
	; end
