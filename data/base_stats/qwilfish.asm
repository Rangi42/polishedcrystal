	db QWILFISH ; 211

if DEF(FAITHFUL)
	db  65,  95,  75,  85,  55,  55
	;   hp  atk  def  spd  sat  sdf
else
	db  65, 100, 100,  85,  75,  55
	;   hp  atk  def  spd  sat  sdf
endc

	db WATER, POISON
	db 45 ; catch rate
if DEF(FAITHFUL)
	db 100 ; base exp
else
	db 109 ; base exp
endc
	db NO_ITEM ; item 1
	db POISON_BARB ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 5, 5 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn FISH, FISH ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, ROLLOUT, SWORDS_DANCE, HIDDEN_POWER, ICY_WIND, ICE_BEAM, BLIZZARD, PROTECT, RAIN_DANCE, RETURN, SHADOW_BALL, DOUBLE_TEAM, SWAGGER, SLUDGE_BOMB, SWIFT, DEFENSE_CURL, REST, ATTRACT, SUBSTITUTE, SCALD, ENDURE, POISON_JAB, THUNDER_WAVE, EXPLOSION, SURF, WHIRLPOOL, WATERFALL, AQUA_TAIL, DOUBLE_EDGE, HEADBUTT, SLEEP_TALK
	; end
