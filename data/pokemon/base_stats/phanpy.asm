	db  90,  60,  60,  40,  40,  40 ; 330 BST
	;   hp  atk  def  spd  sat  sdf

	db GROUND, GROUND
	db 120 ; catch rate
	db 124 ; base exp
	db NO_ITEM ; item 1
	db KEE_BERRY ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/phanpy/front.dimensions"
	abilities_for PHANPY, PICKUP, PICKUP, SAND_VEIL
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	ev_yield   1,   0,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, BULLDOZE, IRON_TAIL, EARTHQUAKE, RETURN, ROCK_SMASH, DOUBLE_TEAM, SANDSTORM, SUBSTITUTE, FACADE, REST, ATTRACT, ROCK_SLIDE, STRENGTH, BODY_SLAM, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, EARTH_POWER, ENDURE, HEADBUTT, HYPER_VOICE, KNOCK_OFF, ROLLOUT, SEED_BOMB, SLEEP_TALK, SWAGGER
	; end
