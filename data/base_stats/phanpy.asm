	db PHANPY ; 231

	db  90,  60,  60,  40,  40,  40
	;   hp  atk  def  spd  sat  sdf

	db GROUND, GROUND
	db 120 ; catch rate
	db 124 ; base exp
	db NO_ITEM ; item 1
	db BERRY ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 5, 5 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; tmhm
	tmhm CURSE, ROAR, TOXIC, ROLLOUT, HIDDEN_POWER, SUNNY_DAY, PROTECT, IRON_TAIL, EARTHQUAKE, RETURN, MUD_SLAP, DOUBLE_TEAM, SWAGGER, SANDSTORM, DEFENSE_CURL, REST, ATTRACT, BODY_SLAM, ROCK_SLIDE, SUBSTITUTE, ENDURE, STRENGTH, ROCK_SMASH, COUNTER, DOUBLE_EDGE, EARTH_POWER, HEADBUTT, HYPER_VOICE, SEED_BOMB, SLEEP_TALK
	; end
