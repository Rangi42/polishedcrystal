	db  50,  64,  50,  41,  45,  50 ; 300 BST
	;   hp  atk  def  spd  sat  sdf

	db ROCK, GROUND ; type
	db 45 ; catch rate
	db 67 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn GENDER_F50, 7 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/larvitar/front.dimensions"
if DEF(FAITHFUL)
	abilities_for LARVITAR, GUTS, GUTS, SAND_VEIL
else
	abilities_for LARVITAR, GUTS, BATTLE_ARMOR, SAND_VEIL
endc
	db GROWTH_SLOW ; growth rate
	dn EGG_MONSTER, EGG_MONSTER ; egg groups

	ev_yield   0,   1,   0,   0,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, BULLDOZE, IRON_TAIL, EARTHQUAKE, RETURN, DIG, ROCK_SMASH, DOUBLE_TEAM, SANDSTORM, SUBSTITUTE, FACADE, REST, ATTRACT, ROCK_SLIDE, DARK_PULSE, STONE_EDGE, BODY_SLAM, DOUBLE_EDGE, EARTH_POWER, ENDURE, HEADBUTT, IRON_HEAD, SLEEP_TALK, SWAGGER
	; end
