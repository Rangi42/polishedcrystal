	db RATICATE ; 020

if DEF(FAITHFUL)
	db  55,  81,  60,  97,  50,  70
	;   hp  atk  def  spd  sat  sdf
else
	db  65,  91,  60, 107,  50,  70
	;   hp  atk  def  spd  sat  sdf
endc

	db NORMAL, NORMAL
	db 90 ; catch rate
	db 116 ; base exp
	db NO_ITEM ; item 1
	db GOLD_BERRY ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 15 ; step cycles to hatch
	db 5 ; unknown
	dn 6, 6 ; frontpic dimensions
	db RUN_AWAY ; ability 1
	db GUTS ; ability 2
	db HUSTLE ; hidden ability
	db 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; tmhm
	tmhm CURSE, ROAR, TOXIC, SWORDS_DANCE, HIDDEN_POWER, SUNNY_DAY, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, DIG, SHADOW_BALL, MUD_SLAP, DOUBLE_TEAM, SWIFT, WILD_CHARGE, REST, ATTRACT, THIEF, SUBSTITUTE, BODY_SLAM, ENDURE, THUNDER_WAVE, CUT, STRENGTH, ROCK_SMASH, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, HEADBUTT, ICY_WIND, SLEEP_TALK, SWAGGER, ZEN_HEADBUTT
	; end
