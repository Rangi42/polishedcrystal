	db KINGDRA ; 230

	db  75,  95,  95,  85,  95,  95
	;   hp  atk  def  spd  sat  sdf

	db WATER, DRAGON
	db 45 ; catch rate
	db 207 ; base exp
	db NO_ITEM ; item 1
	db DRAGON_SCALE ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn AMPHIBIAN, REPTILE ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, ICY_WIND, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, DRAGONBREATH, RETURN, DOUBLE_TEAM, SWAGGER, SWIFT, REST, ATTRACT, BODY_SLAM, SUBSTITUTE, FLASH_CANNON, SCALD, ENDURE, DRAGON_PULSE, SURF, WHIRLPOOL, WATERFALL, DOUBLE_EDGE, HEADBUTT, IRON_HEAD, SLEEP_TALK, WATER_PULSE
	; end
