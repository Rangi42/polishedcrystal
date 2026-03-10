if DEF(FAITHFUL)
	bst 305,  60,  55,  50,  40,  55,  45
	;   bst   hp  atk  def  sat  sdf  spe
else
	bst 330,  65,  55,  55,  50,  60,  45
	;   bst   hp  atk  def  sat  sdf  spe
endc

	db BUG, POISON ; type
	db 190 ; catch rate
if DEF(FAITHFUL)
	db 75 ; base exp
else
	db 80 ; base exp
endc
	db NO_ITEM, NO_ITEM ; held items
	dn GENDER_F50, HATCH_MEDIUM_FAST ; gender ratio, step cycles to hatch

	abilities_for VENONAT, COMPOUND_EYES, TINTED_LENS, RUN_AWAY
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_BUG, EGG_BUG ; egg groups

	ev_yield 1 SDf

	; tm/hm learnset
	tmhm CURSE, TOXIC, VENOSHOCK, HIDDEN_POWER, SUNNY_DAY, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, PSYCHIC, DOUBLE_TEAM, SLUDGE_BOMB, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, LEECH_LIFE, FLASH, AGILITY, BATON_PASS, DOUBLE_EDGE, ENDURE, SKILL_SWAP, SLEEP_TALK, SWAGGER, ZEN_HEADBUTT
	; end
