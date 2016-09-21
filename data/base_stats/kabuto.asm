	db KABUTO ; 140

	db  30,  80,  90,  55,  55,  45
	;   hp  atk  def  spd  sat  sdf

	db ROCK, WATER
	db 45 ; catch rate
	db 119 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 31 ; gender
	db 100 ; unknown
	db 30 ; step cycles to hatch
	db 5 ; unknown
	dn 5, 5 ; frontpic dimensions
	db SWIFT_SWIM ; ability 1
	db BATTLE_ARMOR ; ability 2
	db WEAK_ARMOR ; hidden ability
	db 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn AMPHIBIAN, INVERTEBRATE ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, HAIL, HIDDEN_POWER, HONE_CLAWS, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, GIGA_DRAIN, RETURN, DIG, MUD_SLAP, DOUBLE_TEAM, SANDSTORM, REST, ATTRACT, THIEF, ROCK_SLIDE, SUBSTITUTE, BODY_SLAM, SCALD, ENDURE, SURF, WHIRLPOOL, WATERFALL, ROCK_SMASH, DOUBLE_EDGE, EARTH_POWER, ICY_WIND, IRON_HEAD, ROLLOUT, SLEEP_TALK, SWAGGER, WATER_PULSE
	; end
