	db  80, 105,  65, 130,  60,  75 ; 515 BST
	;   hp  atk  def  spd  sat  sdf

	db ROCK, FLYING
	db 45 ; catch rate
	db 202 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_12_5, 6 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db ROCK_HEAD ; ability 1
if DEF(FAITHFUL)
	db PRESSURE ; ability 2
	db UNNERVE ; hidden ability
else
	db UNNERVE ; ability 2
	db TOUGH_CLAWS ; hidden ability
endc
	db SLOW ; growth rate
	dn AVIAN, AVIAN ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   2,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DRAGON_CLAW, CURSE, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, HONE_CLAWS, HYPER_BEAM, PROTECT, RAIN_DANCE, BULLDOZE, IRON_TAIL, EARTHQUAKE, RETURN, ROCK_SMASH, DOUBLE_TEAM, FLAMETHROWER, SANDSTORM, FIRE_BLAST, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, STEEL_WING, ROCK_SLIDE, ROOST, DRAGON_PULSE, GIGA_IMPACT, STONE_EDGE, FLY, STRENGTH, AQUA_TAIL, DOUBLE_EDGE, EARTH_POWER, ENDURE, HEADBUTT, IRON_HEAD, SLEEP_TALK, SWAGGER
	; end
