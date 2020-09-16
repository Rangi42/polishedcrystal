	db  85,  90,  80, 130,  70,  80 ; 535 BST
	;   hp  atk  def  spd  sat  sdf

	db POISON, FLYING
	db 90 ; catch rate
	db 204 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 2 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/crobat/front.dimensions"
if DEF(FAITHFUL)
	abilities_for CROBAT, INNER_FOCUS, INNER_FOCUS, INFILTRATOR
else
	abilities_for CROBAT, INNER_FOCUS, ANTICIPATION, INFILTRATOR
endc
	db MEDIUM_FAST ; growth rate
	dn AVIAN, AVIAN ; egg groups

	ev_yield   0,   0,   0,   3,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, GIGA_DRAIN, RETURN, SHADOW_BALL, DOUBLE_TEAM, SLUDGE_BOMB, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, STEEL_WING, LEECH_LIFE, ROOST, X_SCISSOR, DARK_PULSE, ACROBATICS, POISON_JAB, GIGA_IMPACT, U_TURN, FLY, DOUBLE_EDGE, ENDURE, SLEEP_TALK, SWAGGER, ZEN_HEADBUTT
	; end
