if DEF(FAITHFUL)
	db  70, 100, 115,  30,  30,  65 ; 410 BST
	;   hp  atk  def  spd  sat  sdf
else
	db  75, 115, 130,  30,  30,  80 ; 460 BST
	;   hp  atk  def  spd  sat  sdf
endc

	db ROCK, ROCK
	db 65 ; catch rate
	db 135 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/sudowoodo/front.dimensions"
	abilities_for SUDOWOODO, STURDY, ROCK_HEAD, RATTLED
	db MEDIUM_FAST ; growth rate
	dn INANIMATE, INANIMATE ; egg groups

	ev_yield   0,   0,   2,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, BULLDOZE, EARTHQUAKE, RETURN, DIG, ROCK_SMASH, DOUBLE_TEAM, SANDSTORM, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROCK_SLIDE, EXPLOSION, STONE_EDGE, STRENGTH, BODY_SLAM, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, EARTH_POWER, ENDURE, FIRE_PUNCH, HEADBUTT, ICE_PUNCH, IRON_HEAD, ROLLOUT, SEISMIC_TOSS, SLEEP_TALK, SUCKER_PUNCH, SWAGGER, THUNDERPUNCH
	; end
