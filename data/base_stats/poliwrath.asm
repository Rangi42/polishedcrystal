	db POLIWRATH ; 062

if DEF(FAITHFUL)
	db  90,  95,  95,  70,  70,  90
	;   hp  atk  def  spd  sat  sdf
else
	db  90,  95, 100,  70,  70,  90
	;   hp  atk  def  spd  sat  sdf
endc

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
	tmhm DYNAMICPUNCH, CURSE, TOXIC, HAIL, BULK_UP, HIDDEN_POWER, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, EARTHQUAKE, RETURN, DIG, PSYCHIC, MUD_SLAP, DOUBLE_TEAM, REST, ATTRACT, THIEF, ROCK_SLIDE, SUBSTITUTE, BODY_SLAM, FOCUS_BLAST, SCALD, ENDURE, POISON_JAB, SURF, STRENGTH, WHIRLPOOL, WATERFALL, ROCK_SMASH, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, HEADBUTT, ICE_PUNCH, ICY_WIND, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, WATER_PULSE
	; end
