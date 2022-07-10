if DEF(FAITHFUL)
	db  73,  95,  62,  85,  65,  85 ; 465 BST
	;   hp  atk  def  spd  sat  sdf
else
	db  73, 100,  62,  85,  65,  85 ; 470 BST
	;   hp  atk  def  spd  sat  sdf
endc

if DEF(FAITHFUL)
	db NORMAL, NORMAL ; type
else
	db NORMAL, PSYCHIC ; type
endc
	db 45 ; catch rate
	db 165 ; base exp
	db NO_ITEM, NO_ITEM ; held items
	dn GENDER_F50, HATCH_MEDIUM_FAST ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/stantler/front.dimensions"
	abilities_for STANTLER, INTIMIDATE, FRISK, SAP_SIPPER
	db GROWTH_SLOW ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	ev_yield   0,   1,   0,   0,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, CALM_MIND, ROAR, TOXIC, HAIL, HIDDEN_POWER, SUNNY_DAY, LIGHT_SCREEN, PROTECT, RAIN_DANCE, BULLDOZE, SOLAR_BEAM, IRON_TAIL, THUNDERBOLT, THUNDER, EARTHQUAKE, RETURN, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, REFLECT, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ENERGY_BALL, WILD_CHARGE, GIGA_IMPACT, FLASH, THUNDER_WAVE, BODY_SLAM, DOUBLE_EDGE, DREAM_EATER, ENDURE, HEADBUTT, ROLLOUT, SKILL_SWAP, SLEEP_TALK, SUCKER_PUNCH, SWAGGER, TRICK_ROOM, ZEN_HEADBUTT
	; end
