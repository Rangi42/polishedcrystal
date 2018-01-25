if DEF(FAITHFUL)
	db  60,  80, 110,  45,  50,  80
	;   hp  atk  def  spd  sat  sdf
else
	db  60,  80, 110,  70,  50,  80
	;   hp  atk  def  spd  sat  sdf
endc

if DEF(FAITHFUL)
	db GROUND, GROUND
else
	db GROUND, GHOST
endc
	db 75 ; catch rate
if DEF(FAITHFUL)
	db 124 ; base exp
else
	db 140 ; base exp
endc
	db NO_ITEM ; item 1
	db THICK_CLUB ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 6, 6 ; frontpic dimensions
if DEF(FAITHFUL)
	db ROCK_HEAD ; ability 1
	db LIGHTNING_ROD ; ability 2
else
	db ROCK_HEAD ; ability 1
	db CURSED_BODY ; ability 2
endc
	db BATTLE_ARMOR ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn MONSTER, MONSTER ; egg groups

	; ev_yield
	ev_yield   0,   0,   2,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, BULLDOZE, IRON_TAIL, THUNDERBOLT, THUNDER, EARTHQUAKE, RETURN, DIG, SHADOW_BALL, DOUBLE_TEAM, FLAMETHROWER, SANDSTORM, FIRE_BLAST, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROCK_SLIDE, ROCK_SMASH, FOCUS_BLAST, FALSE_SWIPE, DARK_PULSE, ENDURE, WILL_O_WISP, SHADOW_CLAW, GIGA_IMPACT, STONE_EDGE, SWORDS_DANCE, STRENGTH, BODY_SLAM, COUNTER, DOUBLE_EDGE, DREAM_EATER, EARTH_POWER, FIRE_PUNCH, HEADBUTT, ICE_PUNCH, ICY_WIND, IRON_HEAD, KNOCK_OFF, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, THUNDERPUNCH
	; end
