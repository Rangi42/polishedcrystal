if DEF(FAITHFUL)
	db  45,  55,  45,  75,  65,  45 ; 330 BST
	;   hp  atk  def  spe  sat  sdf
else
	db  55,  85,  55, 105,  95,  55 ; 450 BST
	;   hp  atk  def  spe  sat  sdf
endc

	db ICE, FLYING ; type
if DEF(FAITHFUL)
	db 45 ; catch rate
	db 183 ; base exp
else
	db 35 ; catch rate
	db 193 ; base exp
endc
	db NO_ITEM, NEVERMELTICE ; held items
	dn GENDER_F50, HATCH_FAST ; gender ratio, step cycles to hatch

	abilities_for DELIBIRD, VITAL_SPIRIT, HUSTLE, INSOMNIA
	db GROWTH_FAST ; growth rate
	dn EGG_WATER_1, EGG_GROUND ; egg groups

	ev_yield 1 Spe

	; tm/hm learnset
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, RETURN, DOUBLE_TEAM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, STEEL_WING, ROOST, WATER_PULSE, AVALANCHE, FLY, AGILITY, BATON_PASS, COUNTER, DOUBLE_EDGE, ENDURE, HEADBUTT, ICE_PUNCH, ICY_WIND, ROLLOUT, SEED_BOMB, SEISMIC_TOSS, SLEEP_TALK, SWAGGER
	; end
