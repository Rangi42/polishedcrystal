if DEF(FAITHFUL)
	db  78,  84,  78, 100, 109,  85 ; 534 BST
	;   hp  atk  def  spd  sat  sdf
else
	db  78,  94,  78, 100,  99,  85 ; 534 BST
	;   hp  atk  def  spd  sat  sdf
endc

if DEF(FAITHFUL)
	db FIRE, FLYING ; type
else
	db FIRE, DRAGON ; type
endc
	db 45 ; catch rate
	db 209 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn GENDER_F12_5, 3 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/charizard/front.dimensions"
if DEF(FAITHFUL)
	abilities_for CHARIZARD, BLAZE, SOLAR_POWER, DROUGHT
else
	abilities_for CHARIZARD, BLAZE, SOLAR_POWER, TOUGH_CLAWS
endc
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_MONSTER, EGG_DRAGON ; egg groups

	ev_yield   0,   0,   0,   0,   3,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm DYNAMICPUNCH, DRAGON_CLAW, CURSE, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, HONE_CLAWS, HYPER_BEAM, PROTECT, BULLDOZE, SOLAR_BEAM, IRON_TAIL, EARTHQUAKE, RETURN, DIG, ROCK_SMASH, DOUBLE_TEAM, FLAMETHROWER, SANDSTORM, FIRE_BLAST, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, FLAME_CHARGE, REST, ATTRACT, STEEL_WING, ROCK_SLIDE, ROOST, FOCUS_BLAST, DRAGON_PULSE, WILL_O_WISP, SHADOW_CLAW, GIGA_IMPACT, SWORDS_DANCE, CUT, FLY, STRENGTH, BODY_SLAM, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, ENDURE, FIRE_PUNCH, HEADBUTT, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, THUNDERPUNCH
	; end
