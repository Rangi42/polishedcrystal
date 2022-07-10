	db  90, 130,  75,  55,  75,  75 ; 500 BST
	;   hp  atk  def  spd  sat  sdf

	db NORMAL, NORMAL ; type
	db 60 ; catch rate
	db 189 ; base exp
	db ALWAYS_ITEM_2, SITRUS_BERRY ; held items
	dn GENDER_F50, HATCH_MEDIUM_FAST ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/ursaring/front.dimensions"
	abilities_for URSARING, GUTS, QUICK_FEET, UNNERVE
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	ev_yield   0,   2,   0,   0,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm DYNAMICPUNCH, CURSE, ROAR, TOXIC, BULK_UP, HIDDEN_POWER, SUNNY_DAY, HONE_CLAWS, HYPER_BEAM, PROTECT, RAIN_DANCE, BULLDOZE, EARTHQUAKE, RETURN, DIG, ROCK_SMASH, DOUBLE_TEAM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROCK_SLIDE, FOCUS_BLAST, FALSE_SWIPE, SHADOW_CLAW, AVALANCHE, GIGA_IMPACT, STONE_EDGE, SWORDS_DANCE, CUT, STRENGTH, BODY_SLAM, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, ENDURE, FIRE_PUNCH, HEADBUTT, HYPER_VOICE, ICE_PUNCH, ROLLOUT, SEED_BOMB, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, THUNDERPUNCH, ZAP_CANNON
	; end
