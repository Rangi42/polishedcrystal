	db CORSOLA ; 222

if DEF(FAITHFUL)
	db  55,  55,  85,  35,  65,  85
	;   hp  atk  def  spd  sat  sdf
else
	db  55,  55, 115,  35, 105, 115
	;   hp  atk  def  spd  sat  sdf
endc

	db WATER, ROCK
	db 60 ; catch rate
if DEF(FAITHFUL)
	db 113 ; base exp
else
	db 128 ; base exp
endc
	db NO_ITEM ; item 1
	db HARD_STONE ; item 2
	db 191 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 6, 6 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db FAST ; growth rate
	dn AMPHIBIAN, INVERTEBRATE ; egg groups

	; tmhm
	tmhm CURSE, CALM_MIND, TOXIC, HAIL, HIDDEN_POWER, SUNNY_DAY, ICE_BEAM, BLIZZARD, LIGHT_SCREEN, PROTECT, RAIN_DANCE, SAFEGUARD, EARTHQUAKE, RETURN, DIG, PSYCHIC, SHADOW_BALL, MUD_SLAP, DOUBLE_TEAM, REFLECT, SANDSTORM, STONE_EDGE, REST, ATTRACT, ROCK_SLIDE, SUBSTITUTE, BODY_SLAM, SCALD, ENDURE, EXPLOSION, SURF, STRENGTH, WHIRLPOOL, ROCK_SMASH, DEFENSE_CURL, DOUBLE_EDGE, EARTH_POWER, HEADBUTT, ICY_WIND, ROLLOUT, SLEEP_TALK, SWAGGER, WATER_PULSE
	; end
