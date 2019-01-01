	db  78,  84,  78, 100, 109,  85
	;   hp  atk  def  spd  sat  sdf

if DEF(FAITHFUL)
	db FIRE, FLYING
else
	db FIRE, DRAGON
endc
	db 45 ; catch rate
	db 209 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_12_5, 3 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db BLAZE ; ability 1
if DEF(FAITHFUL)
	db BLAZE ; ability 2
else
	db LEVITATE ; ability 2
endc
	db SOLAR_POWER ; hidden ability
	db MEDIUM_SLOW ; growth rate
	dn MONSTER, REPTILE ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   3,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, DRAGON_CLAW, CURSE, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, HONE_CLAWS, HYPER_BEAM, PROTECT, BULLDOZE, SOLAR_BEAM, IRON_TAIL, EARTHQUAKE, RETURN, DIG, ROOST, DOUBLE_TEAM, FLAMETHROWER, SANDSTORM, FIRE_BLAST, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, STEEL_WING, ROCK_SLIDE, ROCK_SMASH, FOCUS_BLAST, ENDURE, DRAGON_PULSE, WILL_O_WISP, SHADOW_CLAW, GIGA_IMPACT, SWORDS_DANCE, CUT, FLY, STRENGTH, BODY_SLAM, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, FIRE_PUNCH, HEADBUTT, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, THUNDERPUNCH
	; end
