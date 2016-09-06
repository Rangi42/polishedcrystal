	db HONCHKROW ; 430

if DEF(FAITHFUL)
	db 100, 125,  52,  71, 105,  52
	;   hp  atk  def  spd  sat  sdf
else
	db 105, 125,  52,  71, 105,  52
	;   hp  atk  def  spd  sat  sdf
endc

	db DARK, FLYING
	db 30 ; catch rate
	db 187 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_SLOW ; growth rate
	dn AVIAN, AVIAN ; egg groups

	; tmhm
	tmhm CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, RETURN, PSYCHIC, SHADOW_BALL, MUD_SLAP, DOUBLE_TEAM, SWIFT, AERIAL_ACE, REST, ATTRACT, THIEF, STEEL_WING, SUBSTITUTE, DARK_PULSE, ENDURE, THUNDER_WAVE, FLY, DREAM_EATER, ICY_WIND, SLEEP_TALK, SWAGGER
	; end
