	db  70,  84,  70,  51,  65,  70 ; 410 BST
	;   hp  atk  def  spd  sat  sdf

	db ROCK, GROUND ; type
	db 45 ; catch rate
	db 144 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn GENDER_F50, 7 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/pupitar/front.dimensions"
if DEF(FAITHFUL)
	abilities_for PUPITAR, SHED_SKIN, SHED_SKIN, SHED_SKIN
else
	abilities_for PUPITAR, SHED_SKIN, SHED_SKIN, BATTLE_ARMOR
endc
	db GROWTH_SLOW ; growth rate
	dn EGG_MONSTER, EGG_MONSTER ; egg groups

	ev_yield   0,   2,   0,   0,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, BULLDOZE, IRON_TAIL, EARTHQUAKE, RETURN, DIG, ROCK_SMASH, DOUBLE_TEAM, SANDSTORM, SUBSTITUTE, FACADE, REST, ATTRACT, ROCK_SLIDE, DARK_PULSE, STONE_EDGE, BODY_SLAM, DOUBLE_EDGE, EARTH_POWER, ENDURE, HEADBUTT, IRON_HEAD, SLEEP_TALK, SWAGGER
	; end
