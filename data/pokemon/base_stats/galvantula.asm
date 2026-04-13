	bst 472,  70,  77,  60,  97,  60, 108
	;   bst   hp  atk  def  sat  sdf  spe

	db BUG, ELECTRIC  ; type
	db 75  ; catch rate
	db 165  ; base exp
	db NO_ITEM, NO_ITEM  ; held items
	dn GENDER_F50, HATCH_MEDIUM_FAST  ; gender ratio, step cycles to hatch

	abilities_for GALVANTULA, COMPOUND_EYES, UNNERVE, SWARM
	db GROWTH_MEDIUM_FAST  ; growth rate
	dn EGG_BUG, EGG_BUG  ; egg groups

	ev_yield 2 Spe

	 ; tm/hm learnset
	tmhm HIDDEN_POWER, \ ;2
	     SLEEP_TALK,   HYPER_BEAM,   \ ;3
	     LIGHT_SCREEN, PROTECT,      RAIN_DANCE,   \ ;4
		 THUNDERBOLT,  THUNDER,      \ ;5
	     RETURN,       \ ;6
	     DOUBLE_TEAM,  \ ;7
		 SWIFT,        \ ;8
	     SUBSTITUTE,   FACADE,       REST,         ATTRACT,      \ ;9
		 THIEF,        \ ;10
		 ENERGY_BALL,  \ ;11
		 X_SCISSOR,    WILD_CHARGE,  \ ;12
	     POISON_JAB,   GIGA_IMPACT,  U_TURN,       SWAGGER,      \ ;14
		 VOLT_SWITCH,  THUNDER_WAVE, \ ;15
		 CUT,          \ ;HM
		 GIGA_DRAIN,   \ ;T1
		 THUNDER_FANG, SHOCK_WAVE,   \ ;T2
		 SIGNAL_BEAM,  \ ;T3
		 SUCKER_PUNCH ;T6
	 ; end
