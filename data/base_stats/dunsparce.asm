	db DUNSPARCE ; 206

if DEF(FAITHFUL)
	db 100,  70,  70,  45,  65,  65
	;   hp  atk  def  spd  sat  sdf
else
	db 105,  80,  70,  45,  65,  65
	;   hp  atk  def  spd  sat  sdf
endc

if DEF(FAITHFUL)
	db NORMAL, NORMAL
else
	db NORMAL, GROUND
endc
	db 190 ; catch rate
	db 75 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 6, 6 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; tmhm
	tmhm CURSE, CALM_MIND, TOXIC, ROLLOUT, BULK_UP, HIDDEN_POWER, SUNNY_DAY, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, SOLAR_BEAM, IRON_TAIL, THUNDERBOLT, THUNDER, EARTHQUAKE, RETURN, DIG, SHADOW_BALL, MUD_SLAP, DOUBLE_TEAM, SWAGGER, FLAMETHROWER, FIRE_BLAST, DEFENSE_CURL, WILD_CHARGE, REST, ATTRACT, THIEF, BODY_SLAM, ROCK_SLIDE, SUBSTITUTE, ENDURE, POISON_JAB, THUNDER_WAVE, STRENGTH, ROCK_SMASH, AQUA_TAIL, COUNTER, DOUBLE_EDGE, DREAM_EATER, HEADBUTT, SLEEP_TALK, ZAP_CANNON, ZEN_HEADBUTT
	; end
