	db MUNCHLAX ; 446

	db 135,  85,  45,   5,  40,  85
	;   hp  atk  def  spd  sat  sdf

	db NORMAL, NORMAL
	db 50 ; catch rate
	db 94 ; base exp
	db NO_ITEM ; item 1
	db LEFTOVERS ; item 2
	db 31 ; gender
	db 100 ; unknown
	db 40 ; step cycles to hatch
	db 5 ; unknown
	dn 6, 6 ; frontpic dimensions
	db PICKUP ; ability 1
	db THICK_FAT ; ability 2
	db PICKUP ; hidden ability
	db 0 ; padding
	db SLOW ; growth rate
	dn NO_EGGS, NO_EGGS ; egg groups

	; tmhm
	tmhm CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, SOLAR_BEAM, THUNDERBOLT, THUNDER, EARTHQUAKE, RETURN, PSYCHIC, SHADOW_BALL, MUD_SLAP, DOUBLE_TEAM, FLAMETHROWER, SANDSTORM, FIRE_BLAST, REST, ATTRACT, ROCK_SLIDE, SUBSTITUTE, BODY_SLAM, ENDURE, SURF, STRENGTH, WHIRLPOOL, ROCK_SMASH, DEFENSE_CURL, FIRE_PUNCH, HEADBUTT, HYPER_VOICE, ICE_PUNCH, ICY_WIND, ROLLOUT, SEED_BOMB, SLEEP_TALK, SWAGGER, THUNDERPUNCH, WATER_PULSE, ZEN_HEADBUTT
	; end
