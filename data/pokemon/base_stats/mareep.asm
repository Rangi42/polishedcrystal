	db  55,  40,  40,  35,  65,  45 ; 280 BST
	;   hp  atk  def  spd  sat  sdf

	db ELECTRIC, ELECTRIC
	db 235 ; catch rate
	db 59 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/mareep/front.dimensions"
if DEF(FAITHFUL)
	abilities_for MAREEP, STATIC, STATIC, STATIC
else
	abilities_for MAREEP, STATIC, STATIC, MOTOR_DRIVE
endc
	db MEDIUM_SLOW ; growth rate
	dn MONSTER, FIELD ; egg groups

	ev_yield   0,   0,   0,   0,   1,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, LIGHT_SCREEN, PROTECT, RAIN_DANCE, SAFEGUARD, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, DOUBLE_TEAM, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, WILD_CHARGE, FLASH, THUNDER_WAVE, BODY_SLAM, DEFENSE_CURL, DOUBLE_EDGE, ENDURE, HEADBUTT, SLEEP_TALK, SWAGGER, ZAP_CANNON
	; end
