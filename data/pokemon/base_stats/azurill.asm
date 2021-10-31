	db  50,  20,  40,  20,  20,  40 ; 190 BST
	;   hp  atk  def  spd  sat  sdf

	db NORMAL, FAIRY ; type
	db 150 ; catch rate
	db 33 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn GENDER_F75, 1 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/azurill/front.dimensions"
	abilities_for AZURILL, THICK_FAT, HUGE_POWER, SAP_SIPPER
	db GROWTH_FAST ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	ev_yield   1,   0,   0,   0,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, LIGHT_SCREEN, PROTECT, RAIN_DANCE, IRON_TAIL, RETURN, DOUBLE_TEAM, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, SCALD, WATER_PULSE, SURF, WHIRLPOOL, WATERFALL, BODY_SLAM, DEFENSE_CURL, DOUBLE_EDGE, ENDURE, HEADBUTT, HYPER_VOICE, ICY_WIND, KNOCK_OFF, ROLLOUT, SLEEP_TALK, SWAGGER
	; end
