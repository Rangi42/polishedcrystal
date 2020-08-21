
if DEF(FAITHFUL)
	db  60,  45,  50,  70,  90,  80 ; 395 BST
	;   hp  atk  def  spd  sat  sdf
else
	db  60,  45,  50,  80, 110, 110 ; 455 BST
	;   hp  atk  def  spd  sat  sdf
endc

if DEF(FAITHFUL)
	db BUG, FLYING
else
	db BUG, PSYCHIC
endc
	db 45 ; catch rate
if DEF(FAITHFUL)
	db 160 ; base exp
else
	db 185 ; base exp
endc
	db SHED_SHELL ; item 1
	db SILVERPOWDER ; item 2
	dn FEMALE_50, 2 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/butterfree/front.dimensions"
if DEF(FAITHFUL)
	abilities_for BUTTERFREE, COMPOUND_EYES, COMPOUND_EYES, TINTED_LENS
else
	abilities_for BUTTERFREE, COMPOUND_EYES, LEVITATE, TINTED_LENS
endc
	db MEDIUM_FAST ; growth rate
	dn INSECT, INSECT ; egg groups

	ev_yield   0,   0,   0,   0,   2,   1
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, GIGA_DRAIN, SAFEGUARD, SOLAR_BEAM, RETURN, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, REFLECT, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROOST, ENERGY_BALL, ACROBATICS, GIGA_IMPACT, U_TURN, FLASH, DOUBLE_EDGE, DREAM_EATER, ENDURE, SKILL_SWAP, SLEEP_TALK, SWAGGER
	; end
