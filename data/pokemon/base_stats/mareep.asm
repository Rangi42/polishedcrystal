if DEF(FAITHFUL)
	bst 280,  55,  40,  40,  65,  45,  35
	;   bst   hp  atk  def  sat  sdf  spe
else
	bst 285,  55,  40,  45,  65,  45,  35
	;   bst   hp  atk  def  sat  sdf  spe
endc

	db ELECTRIC, ELECTRIC ; type
	db 235 ; catch rate
	db 59 ; base exp
	db NO_ITEM, NO_ITEM ; held items
	dn GENDER_F50, HATCH_MEDIUM_FAST ; gender ratio, step cycles to hatch

if DEF(FAITHFUL)
	abilities_for MAREEP, STATIC, STATIC, STATIC
else
	abilities_for MAREEP, STATIC, FLUFFY, MOTOR_DRIVE
endc
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_MONSTER, EGG_GROUND ; egg groups

	ev_yield 1 SAt

	; tm/hm learnset
	tmhm CURSE, TOXIC, HIDDEN_POWER, LIGHT_SCREEN, PROTECT, RAIN_DANCE, SAFEGUARD, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, DOUBLE_TEAM, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, WILD_CHARGE, FLASH, THUNDER_WAVE, AGILITY, BODY_SLAM, DEFENSE_CURL, DOUBLE_EDGE, ENDURE, HEADBUTT, SLEEP_TALK, SWAGGER, ZAP_CANNON
	; end
