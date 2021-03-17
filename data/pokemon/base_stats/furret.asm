if DEF(FAITHFUL)
	db  85,  76,  64,  90,  45,  55 ; 415 BST
	;   hp  atk  def  spd  sat  sdf
else
	db  85,  86,  64, 108,  45,  55 ; 443 BST
	;   hp  atk  def  spd  sat  sdf
endc

	db NORMAL, NORMAL ; type
	db 90 ; catch rate
if DEF(FAITHFUL)
	db 116 ; base exp
else
	db 126 ; base exp
endc
	db ORAN_BERRY ; item 1
	db SITRUS_BERRY ; item 2
	dn GENDER_F50, 2 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/furret/front.dimensions"
	abilities_for FURRET, RUN_AWAY, KEEN_EYE, FRISK
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	ev_yield   0,   0,   0,   2,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm DYNAMICPUNCH, CURSE, TOXIC, BULK_UP, HIDDEN_POWER, SUNNY_DAY, HONE_CLAWS, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, SOLAR_BEAM, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, DIG, SHADOW_BALL, ROCK_SMASH, DOUBLE_TEAM, FLAMETHROWER, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, FOCUS_BLAST, WATER_PULSE, SHADOW_CLAW, GIGA_IMPACT, U_TURN, CUT, SURF, STRENGTH, WHIRLPOOL, AQUA_TAIL, BODY_SLAM, DEFENSE_CURL, DOUBLE_EDGE, ENDURE, FIRE_PUNCH, HEADBUTT, HYPER_VOICE, ICE_PUNCH, KNOCK_OFF, ROLLOUT, SLEEP_TALK, SUCKER_PUNCH, SWAGGER, THUNDERPUNCH, TRICK
	; end
