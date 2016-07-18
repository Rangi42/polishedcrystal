	db FURRET ; 162

if DEF(FAITHFUL)
	db  85,  76,  64,  90,  45,  55
	;   hp  atk  def  spd  sat  sdf
else
	db  85,  86,  64, 108,  45,  55
	;   hp  atk  def  spd  sat  sdf
endc

	db NORMAL, NORMAL
	db 90 ; catch rate
if DEF(FAITHFUL)
	db 116 ; base exp
else
	db 126 ; base exp
endc
	db BERRY ; item 1
	db GOLD_BERRY ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 15 ; step cycles to hatch
	db 5 ; unknown
	dn 6, 6 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, ROLLOUT, HIDDEN_POWER, SUNNY_DAY, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, SOLAR_BEAM, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, DIG, SHADOW_BALL, MUD_SLAP, DOUBLE_TEAM, SWAGGER, FLAMETHROWER, SWIFT, DEFENSE_CURL, REST, ATTRACT, THIEF, BODY_SLAM, FURY_CUTTER, SUBSTITUTE, FOCUS_BLAST, ENDURE, SHADOW_CLAW, CUT, SURF, STRENGTH, WHIRLPOOL, ROCK_SMASH, AQUA_TAIL, DOUBLE_EDGE, FIRE_PUNCH, HEADBUTT, HYPER_VOICE, ICE_PUNCH, SLEEP_TALK, THUNDERPUNCH
	; end
