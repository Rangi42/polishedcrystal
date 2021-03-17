	db  65,  65,  45,  95,  75,  45 ; 390 BST
	;   hp  atk  def  spd  sat  sdf

	db BUG, FLYING
	db 75 ; catch rate
	db 147 ; base exp
	db NO_ITEM ; item 1
	db WIDE_LENS ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/yanma/front.dimensions"
	abilities_for YANMA, SPEED_BOOST, COMPOUND_EYES, FRISK
	db MEDIUM_FAST ; growth rate
	dn INSECT, INSECT ; egg groups

	ev_yield   0,   0,   0,   1,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, STEEL_WING, LEECH_LIFE, ROOST, U_TURN, FLASH, DOUBLE_EDGE, DREAM_EATER, ENDURE, HEADBUTT, SLEEP_TALK, SWAGGER
	; end
