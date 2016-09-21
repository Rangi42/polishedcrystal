	db MURKROW ; 198

	db  60,  85,  42,  91,  85,  42
	;   hp  atk  def  spd  sat  sdf

	db DARK, FLYING
	db 30 ; catch rate
	db 107 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 6, 6 ; frontpic dimensions
	db INSOMNIA ; ability 1
	db SUPER_LUCK ; ability 2
	db PRANKSTER ; hidden ability
	db 0 ; padding
	db MEDIUM_SLOW ; growth rate
	dn AVIAN, AVIAN ; egg groups

	; tmhm
	tmhm CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, RAIN_DANCE, RETURN, PSYCHIC, SHADOW_BALL, MUD_SLAP, DOUBLE_TEAM, SWIFT, AERIAL_ACE, REST, ATTRACT, THIEF, STEEL_WING, SUBSTITUTE, DARK_PULSE, ENDURE, THUNDER_WAVE, FLY, DOUBLE_EDGE, DREAM_EATER, ICY_WIND, SLEEP_TALK, SWAGGER
	; end
