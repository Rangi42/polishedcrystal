	db POLIWRATH ; 062

	db  90,  95,  95,  70,  70,  90
	;   hp  atk  def  spd  sat  sdf

	db WATER, FIGHTING
	db 45 ; catch rate
	db 185 ; base exp
	db NO_ITEM ; item 1
	db KINGS_ROCK ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_SLOW ; growth rate
	dn AMPHIBIAN, AMPHIBIAN ; egg groups

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, BULK_UP, HIDDEN_POWER, ICY_WIND, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, EARTHQUAKE, RETURN, DIG, PSYCHIC, MUD_SLAP, DOUBLE_TEAM, SWAGGER, DEFENSE_CURL, REST, ATTRACT, THIEF, BODY_SLAM, ROCK_SLIDE, SUBSTITUTE, FOCUS_BLAST, SCALD, ENDURE, POISON_JAB, SURF, STRENGTH, WHIRLPOOL, WATERFALL, ROCK_SMASH, COUNTER, DOUBLE_EDGE, HEADBUTT, ICE_PUNCH, SEISMIC_TOSS, SLEEP_TALK
	; end
