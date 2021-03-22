	db  20,  40,  15,  60,  35,  35 ; 205 BST
	;   hp  atk  def  spd  sat  sdf

	db ELECTRIC, ELECTRIC ; type
	db 190 ; catch rate
	db 42 ; base exp
	db ORAN_BERRY ; item 1
	db LIGHT_BALL ; item 2
	dn GENDER_F50, 1 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/pichu_plain/front.dimensions"
	abilities_for PICHU, STATIC, STATIC, LIGHTNING_ROD
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	ev_yield   0,   0,   0,   1,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, LIGHT_SCREEN, PROTECT, RAIN_DANCE, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, DOUBLE_TEAM, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, WILD_CHARGE, FLASH, VOLT_SWITCH, THUNDER_WAVE, BODY_SLAM, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, ENDURE, HEADBUTT, PAY_DAY, ROLLOUT, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, THUNDERPUNCH, ZAP_CANNON
	; end
