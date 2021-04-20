	db  40,  30,  50, 100,  55,  55 ; 330 BST
	;   hp  atk  def  spd  sat  sdf

	db ELECTRIC, ELECTRIC ; type
	db 190 ; catch rate
	db 103 ; base exp
	db NO_ITEM ; item 1
	db CELL_BATTERY ; item 2
	dn GENDER_UNKNOWN, 3 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/voltorb/front.dimensions"
	abilities_for VOLTORB, SOUNDPROOF, STATIC, AFTERMATH
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_MINERAL, EGG_MINERAL ; egg groups

	ev_yield   0,   0,   0,   1,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, TOXIC, HIDDEN_POWER, LIGHT_SCREEN, PROTECT, RAIN_DANCE, THUNDERBOLT, THUNDER, RETURN, DOUBLE_TEAM, REFLECT, SWIFT, SUBSTITUTE, FACADE, REST, THIEF, WILD_CHARGE, EXPLOSION, FLASH, VOLT_SWITCH, THUNDER_WAVE, GYRO_BALL, ENDURE, HEADBUTT, ROLLOUT, SLEEP_TALK, SUCKER_PUNCH, SWAGGER, ZAP_CANNON
	; end
