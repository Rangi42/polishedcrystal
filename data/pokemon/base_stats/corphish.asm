	bst 310,  45,  80,  65,  50,  35,  35
	;   bst   hp  atk  def  sat  sdf  spe

	db WATER, WATER  ; type
	db 205  ; catch rate
	db 111  ; base exp
	db NO_ITEM, NO_ITEM  ; held items
	dn GENDER_F50, HATCH_FAST  ; gender ratio, step cycles to hatch

	abilities_for CORPHISH, HYPER_CUTTER, SHELL_ARMOR, ADAPTABILITY
	db GROWTH_MEDIUM_FAST  ; growth rate
	dn EGG_WATER_1, EGG_WATER_3  ; egg groups

	ev_yield 1 Atk

	 ; tm/hm learnset
	tmhm HONE_CLAWS,   \ ;1
	     HAIL,         HIDDEN_POWER, \ ;2
	     SLEEP_TALK,   ICE_BEAM,     BLIZZARD,     \ ;3
	     PROTECT,      RAIN_DANCE,   \ ;4
	     RETURN,       DIG,          \ ;6
	     BRICK_BREAK,  DOUBLE_TEAM,  \ ;7
		 SLUDGE_BOMB,  AERIAL_ACE,   \ ;8
	     SUBSTITUTE,   FACADE,       REST,         ATTRACT,      \ ;9
		 THIEF,        ROCK_SLIDE,   \ ;10
		 FALSE_SWIPE,  SCALD,        \ ;11
		 X_SCISSOR,    \ ;12
		 WATER_PULSE,  \ ;13
	     PAYBACK,      SWAGGER,      \ ;14
		 SWORDS_DANCE, \ ;15
		 CUT,          SURF,         STRENGTH,     WATERFALL,    \ ;HM
		 AQUA_TAIL,    \ ;T2
		 ICY_WIND,     \ ;T3
		 ANCIENTPOWER, \ ;T5
		 KNOCK_OFF,    \ ;T6
		 DOUBLE_EDGE ;T7
	 ; end
