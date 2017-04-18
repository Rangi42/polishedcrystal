	db SUDOWOODO ; 185

if DEF(FAITHFUL)
	db  70, 100, 115,  30,  30,  65
	;   hp  atk  def  spd  sat  sdf
else
	db  75, 115, 130,  30,  30,  80
	;   hp  atk  def  spd  sat  sdf
endc

	db ROCK, ROCK
	db 65 ; catch rate
	db 135 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db FEMALE_50 ; gender
	db 20 ; step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db STURDY ; ability 1
	db ROCK_HEAD ; ability 2
	db RATTLED ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn INANIMATE, INANIMATE ; egg groups

	; ev_yield
	ev_yield   0,   0,   2,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, EARTHQUAKE, RETURN, DIG, MUD_SLAP, DOUBLE_TEAM, SANDSTORM, STONE_EDGE, FACADE, REST, ATTRACT, THIEF, ROCK_SLIDE, ROCK_SMASH, ENDURE, EXPLOSION, STRENGTH, BODY_SLAM, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, EARTH_POWER, FIRE_PUNCH, HEADBUTT, ICE_PUNCH, IRON_HEAD, ROLLOUT, SEISMIC_TOSS, SLEEP_TALK, SUBSTITUTE, SUCKER_PUNCH, SWAGGER, THUNDERPUNCH
	; end
