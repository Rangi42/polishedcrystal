	db  90, 125,  90, 100,  85,  90 ; 580 BST
	;   hp  atk  def  spd  sat  sdf

	db FIGHTING, FLYING
	db 3 ; catch rate
	db 216 ; base exp
	db ALWAYS_ITEM_2 ; item 1
	db LUM_BERRY ; item 2
	dn GENDERLESS, 15 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/zapdos_galarian/front.dimensions"
	abilities_for ZAPDOS_GALARIAN, DEFIANT, DEFIANT, DEFIANT
	db SLOW ; growth rate
	dn NO_EGGS, NO_EGGS ; egg groups

	ev_yield   0,   3,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, ROAR, TOXIC, BULK_UP, HIDDEN_POWER, HONE_CLAWS, HYPER_BEAM, LIGHT_SCREEN, PROTECT, BULLDOZE, RETURN, ROCK_SMASH, DOUBLE_TEAM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, STEEL_WING, FALSE_SWIPE, GIGA_IMPACT, U_TURN, FLY, AGILITY, BODY_SLAM, COUNTER, DOUBLE_EDGE, ENDURE, KNOCK_OFF, SLEEP_TALK, SWAGGER
	; end
