	db  40,  45,  35,  55,  30,  40 ; 245 BST
	;   hp  atk  def  spd  sat  sdf

	db POISON, FLYING
	db 255 ; catch rate
	db 54 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 2 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/zubat/front.dimensions"
if DEF(FAITHFUL)
	abilities_for ZUBAT, INNER_FOCUS, INNER_FOCUS, INFILTRATOR
else
	abilities_for ZUBAT, INNER_FOCUS, ANTICIPATION, INFILTRATOR
endc
	db MEDIUM_FAST ; growth rate
	dn AVIAN, AVIAN ; egg groups

	ev_yield   0,   0,   0,   1,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, RAIN_DANCE, GIGA_DRAIN, RETURN, SHADOW_BALL, DOUBLE_TEAM, SLUDGE_BOMB, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, STEEL_WING, LEECH_LIFE, ROOST, ACROBATICS, POISON_JAB, U_TURN, FLY, DOUBLE_EDGE, ENDURE, SLEEP_TALK, SWAGGER, ZEN_HEADBUTT
	; end
