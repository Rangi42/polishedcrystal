	db HORSEA ; 116

	db  30,  40,  70,  60,  70,  25
	;   hp  atk  def  spd  sat  sdf

	db WATER, WATER
	db 225 ; catch rate
	db 83 ; base exp
	db NO_ITEM ; item 1
	db DRAGON_SCALE ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 5, 5 ; frontpic dimensions
	db SWIFT_SWIM ; ability 1
	db SNIPER ; ability 2
	db DAMP ; hidden ability
	db 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn AMPHIBIAN, REPTILE ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, DRAGONBREATH, RETURN, DOUBLE_TEAM, FLASH_CANNON, SWIFT, REST, ATTRACT, SUBSTITUTE, SCALD, ENDURE, DRAGON_PULSE, SURF, WHIRLPOOL, WATERFALL, DOUBLE_EDGE, HEADBUTT, ICY_WIND, SLEEP_TALK, SWAGGER, WATER_PULSE
	; end
