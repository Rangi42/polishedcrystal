	db  50,  64,  50,  41,  45,  50 ; 300 BST
	;   hp  atk  def  spe  sat  sdf

	db ROCK, GROUND ; type
	db 45 ; catch rate
	db 67 ; base exp
	db NO_ITEM, NO_ITEM ; held items
	dn GENDER_F50, HATCH_SLOWEST ; gender ratio, step cycles to hatch

if DEF(FAITHFUL)
	abilities_for LARVITAR, GUTS, GUTS, SAND_VEIL
else
	abilities_for LARVITAR, GUTS, BATTLE_ARMOR, SAND_VEIL
endc
	db GROWTH_SLOW ; growth rate
	dn EGG_MONSTER, EGG_MONSTER ; egg groups

	ev_yield 1 Atk

	; tm/hm learnset
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, BULLDOZE, IRON_TAIL, EARTHQUAKE, RETURN, DIG, ROCK_SMASH, DOUBLE_TEAM, SANDSTORM, SUBSTITUTE, FACADE, REST, ATTRACT, ROCK_SLIDE, DARK_PULSE, STONE_EDGE, BODY_SLAM, DOUBLE_EDGE, EARTH_POWER, ENDURE, HEADBUTT, IRON_HEAD, SLEEP_TALK, SWAGGER
	; end
