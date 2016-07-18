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
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; tmhm
	tmhm CURSE, ROAR, TOXIC, SWORDS_DANCE, HIDDEN_POWER, SUNNY_DAY, ICY_WIND, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, IRON_TAIL, THUNDERBOLT, THUNDER, RETURN, DIG, SHADOW_BALL, MUD_SLAP, DOUBLE_TEAM, SWAGGER, SWIFT, DEFENSE_CURL, WILD_CHARGE, REST, ATTRACT, THIEF, BODY_SLAM, SUBSTITUTE, ENDURE, THUNDER_WAVE, CUT, STRENGTH, ROCK_SMASH, COUNTER, DOUBLE_EDGE, HEADBUTT, SLEEP_TALK, ZEN_HEADBUTT
	; end
