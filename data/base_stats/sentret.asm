	db SENTRET ; 161

	db  35,  46,  34,  20,  35,  45
	;   hp  atk  def  spd  sat  sdf

	db NORMAL, NORMAL
	db 255 ; catch rate
	db 57 ; base exp
	db NO_ITEM ; item 1
	db BERRY ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 15 ; step cycles to hatch
	db 5 ; unknown
	dn 6, 6 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, ROLLOUT, HIDDEN_POWER, SUNNY_DAY, ICE_BEAM, PROTECT, RAIN_DANCE, SOLAR_BEAM, IRON_TAIL, THUNDERBOLT, RETURN, DIG, SHADOW_BALL, MUD_SLAP, DOUBLE_TEAM, SWAGGER, FLAMETHROWER, SWIFT, DEFENSE_CURL, REST, ATTRACT, THIEF, BODY_SLAM, FURY_CUTTER, SUBSTITUTE, ENDURE, SHADOW_CLAW, CUT, SURF, WHIRLPOOL, AQUA_TAIL, DOUBLE_EDGE, FIRE_PUNCH, HEADBUTT, HYPER_VOICE, ICE_PUNCH, SLEEP_TALK, THUNDERPUNCH
	; end
