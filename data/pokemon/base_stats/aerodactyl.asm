	db  80, 105,  65, 130,  60,  75 ; 515 BST
	;   hp  atk  def  spd  sat  sdf

	db ROCK, FLYING ; type
	db 45 ; catch rate
	db 202 ; base exp
	db NO_ITEM, NO_ITEM ; held items
	dn GENDER_F12_5, HATCH_SLOWER ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/aerodactyl/front.dimensions"
	abilities_for AERODACTYL, ROCK_HEAD, UNNERVE, TOUGH_CLAWS
	db GROWTH_SLOW ; growth rate
	dn EGG_FLYING, EGG_FLYING ; egg groups

	ev_yield   0,   0,   0,   2,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm DRAGON_CLAW, CURSE, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, HONE_CLAWS, HYPER_BEAM, PROTECT, RAIN_DANCE, BULLDOZE, IRON_TAIL, EARTHQUAKE, RETURN, ROCK_SMASH, DOUBLE_TEAM, FLAMETHROWER, SANDSTORM, FIRE_BLAST, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, STEEL_WING, ROCK_SLIDE, ROOST, DRAGON_PULSE, GIGA_IMPACT, STONE_EDGE, FLY, STRENGTH, AQUA_TAIL, DOUBLE_EDGE, EARTH_POWER, ENDURE, HEADBUTT, IRON_HEAD, SLEEP_TALK, SWAGGER
	; end
