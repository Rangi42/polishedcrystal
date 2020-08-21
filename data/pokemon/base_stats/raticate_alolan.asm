if DEF(FAITHFUL)
	db  75,  71,  70,  77,  40,  80 ; 413 BST
	;   hp  atk  def  spd  sat  sdf
else
	db  85,  81,  70,  87,  40,  80 ; 443 BST
	;   hp  atk  def  spd  sat  sdf
endc

	db DARK, NORMAL
	db 90 ; catch rate
	db 116 ; base exp
	db NO_ITEM ; item 1
	db PECHA_BERRY ; item 2
	dn FEMALE_50, 2 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/raticate_alolan/front.dimensions"
	abilities_for RATICATE_ALOLAN, GLUTTONY, HUSTLE, THICK_FAT
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	ev_yield   0,   0,   0,   2,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, ROAR, TOXIC, BULK_UP, HIDDEN_POWER, SUNNY_DAY, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, IRON_TAIL, RETURN, DIG, SHADOW_BALL, ROCK_SMASH, DOUBLE_TEAM, SLUDGE_BOMB, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, DARK_PULSE, SHADOW_CLAW, GIGA_IMPACT, U_TURN, SWORDS_DANCE, CUT, STRENGTH, BODY_SLAM, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, ENDURE, HEADBUTT, ICY_WIND, SLEEP_TALK, SUCKER_PUNCH, SWAGGER, ZEN_HEADBUTT
	; end
