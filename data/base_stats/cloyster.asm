	db CLOYSTER ; 091

	db  50,  95, 180,  70,  85,  45
	;   hp  atk  def  spd  sat  sdf

	db WATER, ICE
	db 60 ; catch rate
	db 203 ; base exp
	db PEARL ; item 1
	db BIG_PEARL ; item 2
	db FEMALE_50 ; gender
	db 20 ; step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db SHELL_ARMOR ; ability 1
	db SKILL_LINK ; ability 2
	db OVERCOAT ; hidden ability
	db SLOW ; growth rate
	dn INVERTEBRATE, INVERTEBRATE ; egg groups

	; ev_yield
	ev_yield   0,   0,   2,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, RETURN, DOUBLE_TEAM, SWIFT, FACADE, REST, ATTRACT, ENDURE, EXPLOSION, POISON_JAB, AVALANCHE, GIGA_IMPACT, SURF, WATERFALL, WHIRLPOOL, DOUBLE_EDGE, ICY_WIND, ROLLOUT, SLEEP_TALK, SUBSTITUTE, SWAGGER, WATER_PULSE
	; end
