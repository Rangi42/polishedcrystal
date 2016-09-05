	db DEWGONG ; 087

if DEF(FAITHFUL)
	db  90,  70,  80,  70,  70,  95
	;   hp  atk  def  spd  sat  sdf
else
	db  90,  70,  80,  70,  80,  95
	;   hp  atk  def  spd  sat  sdf
endc

	db WATER, ICE
	db 75 ; catch rate
	db 176 ; base exp
	db ICE_BERRY ; item 1
	db NEVERMELTICE ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn AMPHIBIAN, FIELD ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, ICY_WIND, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, SAFEGUARD, IRON_TAIL, RETURN, DOUBLE_TEAM, SWAGGER, AVALANCHE, REST, ATTRACT, THIEF, BODY_SLAM, SUBSTITUTE, ENDURE, SURF, WHIRLPOOL, WATERFALL, AQUA_TAIL, DOUBLE_EDGE, HEADBUTT, SLEEP_TALK, WATER_PULSE
	; end
