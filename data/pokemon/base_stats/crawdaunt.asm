	bst 470,  65, 120,  85,  90,  55,  55
	;   bst   hp  atk  def  sat  sdf  spe

	db WATER, DARK  ; type
	db 155  ; catch rate
	db 161  ; base exp
	db NO_ITEM, NO_ITEM  ; held items
	dn GENDER_F50, HATCH_FAST  ; gender ratio, step cycles to hatch

	abilities_for CRAWDAUNT, HYPER_CUTTER, SHELL_ARMOR, ADAPTABILITY
	db GROWTH_MEDIUM_FAST  ; growth rate
	dn EGG_WATER_1, EGG_WATER_3  ; egg groups

	ev_yield 2 Atk

	 ; tm/hm learnset
	tmhm HONE_CLAWS,   \ ;1
	     HAIL,         HIDDEN_POWER, \ ;2
	     SLEEP_TALK,   ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   \ ;3
	     PROTECT,      RAIN_DANCE,   \ ;4
	     RETURN,       DIG,          \ ;6
	     BRICK_BREAK,  DOUBLE_TEAM,  \ ;7
		 SLUDGE_BOMB,  SWIFT,        AERIAL_ACE,   \ ;8
	     SUBSTITUTE,   FACADE,       REST,         ATTRACT,      \ ;9
		 THIEF,        ROCK_SLIDE,   \ ;10
		 FALSE_SWIPE,  SCALD,        \ ;11
		 X_SCISSOR,    DARK_PULSE,   \ ;12
		 WATER_PULSE,  \ ;13
	     PAYBACK,      GIGA_IMPACT,  SWAGGER,      \ ;14
		 SWORDS_DANCE, \ ;15
		 CUT,          SURF,         STRENGTH,     WATERFALL,    \ ;HM
		 AQUA_TAIL,    \ ;T2
		 ICY_WIND,     \ ;T3
		 ANCIENTPOWER, \ ;T5
		 KNOCK_OFF,    \ ;T6
		 DOUBLE_EDGE ;T7
	 ; end
