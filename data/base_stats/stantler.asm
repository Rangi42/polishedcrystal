	db STANTLER ; 234

if DEF(FAITHFUL)
	db  73,  95,  62,  85,  85,  65
	;   hp  atk  def  spd  sat  sdf
else
	db  73, 100,  62,  95,  85,  65
	;   hp  atk  def  spd  sat  sdf
endc

	db NORMAL, NORMAL
	db 45 ; catch rate
if DEF(FAITHFUL)
	db 165 ; base exp
else
	db 170 ; base exp
endc
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db SLOW ; growth rate
	dn FIELD, FIELD ; egg groups

	; tmhm
	tmhm CURSE, CALM_MIND, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, LIGHT_SCREEN, PROTECT, RAIN_DANCE, SOLAR_BEAM, IRON_TAIL, THUNDERBOLT, THUNDER, EARTHQUAKE, RETURN, PSYCHIC, SHADOW_BALL, MUD_SLAP, DOUBLE_TEAM, REFLECT, SWAGGER, SWIFT, WILD_CHARGE, REST, ATTRACT, THIEF, BODY_SLAM, SUBSTITUTE, ENDURE, THUNDER_WAVE, FLASH, DOUBLE_EDGE, DREAM_EATER, HEADBUTT, SLEEP_TALK, ZEN_HEADBUTT
	; end
