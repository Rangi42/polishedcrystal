	db  35,  35,  35,  35,  35,  35 ; 210 BST
	;   hp  atk  def  spd  sat  sdf

	db FIGHTING, FIGHTING ; type
	db 75 ; catch rate
	db 91 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn GENDER_F0, 4 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/tyrogue/front.dimensions"
	abilities_for TYROGUE, GUTS, STEADFAST, VITAL_SPIRIT
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	ev_yield   0,   1,   0,   0,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, TOXIC, BULK_UP, HIDDEN_POWER, SUNNY_DAY, PROTECT, RAIN_DANCE, BULLDOZE, EARTHQUAKE, RETURN, ROCK_SMASH, DOUBLE_TEAM, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROCK_SLIDE, STRENGTH, BODY_SLAM, COUNTER, DOUBLE_EDGE, ENDURE, HEADBUTT, SEISMIC_TOSS, SLEEP_TALK, SWAGGER
	; end
