	db AZUMARILL ; 184

if DEF(FAITHFUL)
	db 100,  50,  80,  50,  60,  80
	;   hp  atk  def  spd  sat  sdf
else
	db 100,  50,  80,  50,  90,  80
	;   hp  atk  def  spd  sat  sdf
endc

	db WATER, FAIRY
	db 75 ; catch rate
if DEF(FAITHFUL)
	db 153 ; base exp
else
	db 183 ; base exp
endc
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db THICK_FAT ; ability 1
	db HUGE_POWER ; ability 2
	db SAP_SIPPER ; hidden ability
	db 0 ; padding
	db FAST ; growth rate
	dn AMPHIBIAN, FAERY ; egg groups

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, IRON_TAIL, RETURN, DIG, MUD_SLAP, DOUBLE_TEAM, SWIFT, REST, ATTRACT, SUBSTITUTE, BODY_SLAM, FOCUS_BLAST, SCALD, ENDURE, SURF, STRENGTH, WHIRLPOOL, WATERFALL, ROCK_SMASH, AQUA_TAIL, DEFENSE_CURL, DOUBLE_EDGE, HEADBUTT, HYPER_VOICE, ICE_PUNCH, ICY_WIND, ROLLOUT, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, WATER_PULSE
	; end
