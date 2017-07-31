	db PHANPY ; 231

	db  90,  60,  60,  40,  40,  40
	;   hp  atk  def  spd  sat  sdf

	db GROUND, GROUND
	db 120 ; catch rate
	db 124 ; base exp
	db NO_ITEM ; item 1
	db ORAN_BERRY ; item 2
	db FEMALE_50 ; gender
	db 20 ; step cycles to hatch
	dn 5, 5 ; frontpic dimensions
	db PICKUP ; ability 1
	db PICKUP ; ability 2
	db SAND_VEIL ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; ev_yield
	ev_yield   1,   0,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, IRON_TAIL, EARTHQUAKE, RETURN, DOUBLE_TEAM, SANDSTORM, FACADE, REST, ATTRACT, ROCK_SLIDE, ROCK_SMASH, ENDURE, STRENGTH, BODY_SLAM, BULLDOZE, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, EARTH_POWER, HEADBUTT, HYPER_VOICE, ROLLOUT, SEED_BOMB, SLEEP_TALK, SUBSTITUTE, SWAGGER
	; end
