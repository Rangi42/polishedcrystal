	bst 410,  50,  85,  55,  65,  65,  90
	;   bst   hp  atk  def  sat  sdf  spe

	db PSYCHIC, PSYCHIC ; type
	db 190 ; catch rate
	db 152 ; base exp
	db NO_ITEM, MARANGABERRY ; held items
	dn GENDER_F50, HATCH_MEDIUM_FAST ; gender ratio, step cycles to hatch

	abilities_for PONYTA_GALARIAN, RUN_AWAY, PASTEL_VEIL, ANTICIPATION
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	ev_yield 1 Spe

	; tm/hm learnset
	tmhm CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, PROTECT, IRON_TAIL, RETURN, PSYCHIC, DOUBLE_TEAM, REFLECT, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, WILD_CHARGE, STRENGTH, AGILITY, BODY_SLAM, CHARM, DOUBLE_EDGE, ENDURE, HEADBUTT, PAY_DAY, SLEEP_TALK, SWAGGER, ZEN_HEADBUTT
	; end
