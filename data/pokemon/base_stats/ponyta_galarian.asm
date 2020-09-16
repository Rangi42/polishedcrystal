	db  50,  85,  55,  90,  65,  65 ; 410 BST
	;   hp  atk  def  spd  sat  sdf

	db PSYCHIC, PSYCHIC
	db 190 ; catch rate
	db 152 ; base exp
	db NO_ITEM ; item 1
	db MARANGABERRY ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/ponyta_galarian/front.dimensions"
	abilities_for PONYTA_GALARIAN, RUN_AWAY, PASTEL_VEIL, ANTICIPATION
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	ev_yield   0,   0,   0,   1,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, PROTECT, IRON_TAIL, RETURN, PSYCHIC, DOUBLE_TEAM, REFLECT, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, WILD_CHARGE, STRENGTH, AGILITY, BODY_SLAM, CHARM, DOUBLE_EDGE, ENDURE, HEADBUTT, PAY_DAY, SLEEP_TALK, SWAGGER, ZEN_HEADBUTT
	; end
