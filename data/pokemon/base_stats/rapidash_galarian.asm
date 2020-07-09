	db  65, 100,  70, 105,  80,  80 ; 500 BST
	;   hp  atk  def  spd  sat  sdf

	db PSYCHIC, FAIRY
	db 60 ; catch rate
	db 192 ; base exp
	db NO_ITEM ; item 1
	db MARANGABERRY ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db RUN_AWAY ; ability 1
	db PASTEL_VEIL ; ability 2
	db ANTICIPATION ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   2,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, HYPER_BEAM, PROTECT, IRON_TAIL, RETURN, PSYCHIC, DOUBLE_TEAM, REFLECT, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, WILD_CHARGE, GIGA_IMPACT, SWORDS_DANCE, STRENGTH, AGILITY, BATON_PASS, BODY_SLAM, CHARM, DOUBLE_EDGE, ENDURE, HEADBUTT, PAY_DAY, SLEEP_TALK, SWAGGER, TRICK_ROOM, ZEN_HEADBUTT
	; end
