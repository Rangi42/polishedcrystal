	db  50,  95,  95,  70,  35, 110 ; 455 BST
	;   hp  atk  def  spe  sat  sdf

	db FIGHTING, FIGHTING ; type
	db 45 ; catch rate
	db 138 ; base exp
	db NO_ITEM, NO_ITEM ; held items
	dn GENDER_F0, HATCH_MEDIUM_SLOW ; gender ratio, step cycles to hatch

	abilities_for HITMONTOP, INTIMIDATE, TECHNICIAN, STEADFAST
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_HUMANSHAPE, EGG_HUMANSHAPE ; egg groups

	ev_yield 2 SDf

	; tm/hm learnset
	tmhm CURSE, TOXIC, BULK_UP, HIDDEN_POWER, SUNNY_DAY, PROTECT, RAIN_DANCE, BULLDOZE, EARTHQUAKE, RETURN, DIG, ROCK_SMASH, DOUBLE_TEAM, SANDSTORM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROCK_SLIDE, FOCUS_BLAST, STONE_EDGE, GYRO_BALL, STRENGTH, BODY_SLAM, COUNTER, DOUBLE_EDGE, ENDURE, HEADBUTT, ROLLOUT, SEISMIC_TOSS, SLEEP_TALK, SUCKER_PUNCH, SWAGGER, CUT, FLY, SURF, WHIRLPOOL, FLASH
	; end
