if DEF(FAITHFUL)
	db 100, 125,  52,  71, 105,  52 ; 505 BST
	;   hp  atk  def  spd  sat  sdf
else
	db 105, 125,  52,  71, 105,  52 ; 510 BST
	;   hp  atk  def  spd  sat  sdf
endc

	db DARK, FLYING
	db 30 ; catch rate
	db 187 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/honchkrow/front.dimensions"
	abilities_for HONCHKROW, INSOMNIA, SUPER_LUCK, MOXIE
	db MEDIUM_SLOW ; growth rate
	dn AVIAN, AVIAN ; egg groups

	ev_yield   0,   2,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, RETURN, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, STEEL_WING, ROOST, DARK_PULSE, GIGA_IMPACT, THUNDER_WAVE, FLY, DOUBLE_EDGE, DREAM_EATER, ENDURE, ICY_WIND, SLEEP_TALK, SUCKER_PUNCH, SWAGGER
	; end
