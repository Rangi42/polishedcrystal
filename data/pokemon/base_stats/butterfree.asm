
if DEF(FAITHFUL)
	db  60,  45,  50,  70,  90,  80 ; 395 BST
	;   hp  atk  def  spe  sat  sdf
else
	db  60,  45,  50,  80, 110, 110 ; 455 BST
	;   hp  atk  def  spe  sat  sdf
endc

if DEF(FAITHFUL)
	db BUG, FLYING ; type
else
	db BUG, PSYCHIC ; type
endc
	db 45 ; catch rate
if DEF(FAITHFUL)
	db 160 ; base exp
else
	db 185 ; base exp
endc
	db SHED_SHELL, SILVERPOWDER ; held items
	dn GENDER_F50, HATCH_FAST ; gender ratio, step cycles to hatch

if DEF(FAITHFUL)
	abilities_for BUTTERFREE, COMPOUND_EYES, COMPOUND_EYES, TINTED_LENS
else
	abilities_for BUTTERFREE, COMPOUND_EYES, LEVITATE, TINTED_LENS
endc
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_BUG, EGG_BUG ; egg groups

	ev_yield 2 SAt, 1 SDf

	; tm/hm learnset
	tmhm CURSE, TOXIC, VENOSHOCK, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, GIGA_DRAIN, SAFEGUARD, SOLAR_BEAM, RETURN, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, REFLECT, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROOST, ENERGY_BALL, ACROBATICS, GIGA_IMPACT, U_TURN, FLASH, BATON_PASS, DOUBLE_EDGE, DREAM_EATER, ENDURE, SKILL_SWAP, SLEEP_TALK, SWAGGER
	; end
