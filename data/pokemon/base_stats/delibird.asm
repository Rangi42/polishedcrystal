if DEF(FAITHFUL)
	db  45,  55,  45,  75,  65,  45 ; 330 BST
	;   hp  atk  def  spd  sat  sdf
else
	db  55,  85,  55, 105,  95,  55 ; 450 BST
	;   hp  atk  def  spd  sat  sdf
endc

	db ICE, FLYING ; type
if DEF(FAITHFUL)
	db 45 ; catch rate
	db 183 ; base exp
else
	db 35 ; catch rate
	db 193 ; base exp
endc
	db NO_ITEM ; item 1
	db NEVERMELTICE ; item 2
	dn GENDER_F50, 2 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/delibird/front.dimensions"
	abilities_for DELIBIRD, VITAL_SPIRIT, HUSTLE, INSOMNIA
	db GROWTH_FAST ; growth rate
	dn EGG_WATER_1, EGG_GROUND ; egg groups

	ev_yield   0,   0,   0,   1,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, RETURN, DOUBLE_TEAM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, STEEL_WING, ROOST, WATER_PULSE, AVALANCHE, FLY, AGILITY, BATON_PASS, COUNTER, DOUBLE_EDGE, ENDURE, HEADBUTT, ICE_PUNCH, ICY_WIND, ROLLOUT, SEED_BOMB, SEISMIC_TOSS, SLEEP_TALK, SWAGGER
	; end
