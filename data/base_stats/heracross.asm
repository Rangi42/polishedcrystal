	db HERACROSS ; 214

	db  80, 125,  75,  85,  40,  95
	;   hp  atk  def  spd  sat  sdf

	db BUG, FIGHTING
	db 45 ; catch rate
	db 200 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 25 ; step cycles to hatch
	db 5 ; unknown
	dn 6, 6 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db SLOW ; growth rate
	dn INSECT, INSECT ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, BULK_UP, SWORDS_DANCE, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, EARTHQUAKE, RETURN, DIG, DOUBLE_TEAM, AERIAL_ACE, STONE_EDGE, REST, ATTRACT, THIEF, ROCK_SLIDE, FURY_CUTTER, SUBSTITUTE, BODY_SLAM, FOCUS_BLAST, FALSE_SWIPE, ENDURE, SHADOW_CLAW, CUT, STRENGTH, ROCK_SMASH, COUNTER, DOUBLE_EDGE, HEADBUTT, SEISMIC_TOSS, SLEEP_TALK, SWAGGER
	; end
