	db  35,  35,  35,  35,  35,  35 ; 210 BST
	;   hp  atk  def  spe  sat  sdf

	db FIGHTING, FIGHTING ; type
	db 75 ; catch rate
	db 91 ; base exp
	db NO_ITEM, NO_ITEM ; held items
	dn GENDER_F0, HATCH_MEDIUM_SLOW ; gender ratio, step cycles to hatch

	abilities_for TYROGUE, GUTS, STEADFAST, VITAL_SPIRIT
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	ev_yield 1 Atk

	; tm/hm learnset
	tmhm CURSE, TOXIC, BULK_UP, HIDDEN_POWER, SUNNY_DAY, PROTECT, RAIN_DANCE, BULLDOZE, EARTHQUAKE, RETURN, ROCK_SMASH, DOUBLE_TEAM, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROCK_SLIDE, STRENGTH, BODY_SLAM, COUNTER, DOUBLE_EDGE, ENDURE, HEADBUTT, SEISMIC_TOSS, SLEEP_TALK, SWAGGER
	; end
