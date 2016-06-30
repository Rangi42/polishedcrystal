	db AZUMARILL ; 184

	db 100,  50,  80,  50,  60,  80
	;   hp  atk  def  spd  sat  sdf

	db WATER, FAIRY
	db 75 ; catch rate
	db 153 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db FAST ; growth rate
	dn AMPHIBIAN, FAERY ; egg groups

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, ROLLOUT, HIDDEN_POWER, ICY_WIND, ICE_BEAM, BLIZZARD, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, IRON_TAIL, RETURN, DIG, MUD_SLAP, DOUBLE_TEAM, SWAGGER, SWIFT, DEFENSE_CURL, REST, ATTRACT, BODY_SLAM, SUBSTITUTE, FOCUS_BLAST, SCALD, ENDURE, SURF, STRENGTH, WHIRLPOOL, WATERFALL, ROCK_SMASH, AQUA_TAIL, DOUBLE_EDGE, HEADBUTT, HYPER_VOICE, ICE_PUNCH, SEISMIC_TOSS, SLEEP_TALK
	; end
