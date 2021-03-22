	db  60,  85,  42,  91,  85,  42 ; 405 BST
	;   hp  atk  def  spd  sat  sdf

	db DARK, FLYING ; type
	db 30 ; catch rate
	db 107 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn GENDER_F50, 3 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/murkrow/front.dimensions"
	abilities_for MURKROW, INSOMNIA, SUPER_LUCK, PRANKSTER
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_FLYING, EGG_FLYING ; egg groups

	ev_yield   0,   0,   0,   1,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, RAIN_DANCE, RETURN, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, STEEL_WING, ROOST, DARK_PULSE, THUNDER_WAVE, FLY, DOUBLE_EDGE, DREAM_EATER, ENDURE, ICY_WIND, SLEEP_TALK, SUCKER_PUNCH, SWAGGER
	; end
