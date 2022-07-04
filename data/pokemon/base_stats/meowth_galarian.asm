	db  50,  65,  65,  40,  40,  40 ; 290 BST
	;   hp  atk  def  spd  sat  sdf

	db STEEL, STEEL ; type
	db 255 ; catch rate
	db 69 ; base exp
	db NO_ITEM, NO_ITEM ; held items
	dn GENDER_F50, 3 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/meowth_galarian/front.dimensions"
	abilities_for MEOWTH_GALARIAN, BATTLE_ARMOR, TOUGH_CLAWS, STEELY_SPIRIT
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	ev_yield   0,   1,   0,   0,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HONE_CLAWS, PROTECT, RAIN_DANCE, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, DIG, SHADOW_BALL, DOUBLE_TEAM, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, DARK_PULSE, SHADOW_CLAW, U_TURN, FLASH, GYRO_BALL, SWORDS_DANCE, CUT, BODY_SLAM, DOUBLE_EDGE, ENDURE, HEADBUTT, HYPER_VOICE, IRON_HEAD, KNOCK_OFF, PAY_DAY, SEED_BOMB, SLEEP_TALK, SWAGGER, ZAP_CANNON
	; end
