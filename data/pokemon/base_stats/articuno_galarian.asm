	db  90,  85,  85,  95, 125, 100 ; 580 BST
	;   hp  atk  def  spd  sat  sdf

	db PSYCHIC, FLYING ; type
	db 3 ; catch rate
	db 215 ; base exp
	db ALWAYS_ITEM_2 ; item 1
	db LUM_BERRY ; item 2
	dn GENDER_UNKNOWN, 15 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/articuno_galarian/front.dimensions"
	abilities_for ARTICUNO_GALARIAN, COMPETITIVE, COMPETITIVE, COMPETITIVE
	db GROWTH_SLOW ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	ev_yield   0,   0,   0,   0,   3,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, CALM_MIND, ROAR, TOXIC, HIDDEN_POWER, HYPER_BEAM, LIGHT_SCREEN, PROTECT, SAFEGUARD, RETURN, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, REFLECT, FLASH_CANNON, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, STEEL_WING, DAZZLINGLEAM, GIGA_IMPACT, U_TURN, FLY, AGILITY, DOUBLE_EDGE, DREAM_EATER, ENDURE, SKILL_SWAP, SLEEP_TALK, SWAGGER, TRICK_ROOM
	; end
