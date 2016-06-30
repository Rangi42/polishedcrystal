	db GIRAFARIG ; 203

	db  70,  80,  65,  85,  90,  65
	;   hp  atk  def  spd  sat  sdf

	db NORMAL, PSYCHIC
	db 60 ; catch rate
	db 149 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; tmhm
	tmhm CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, LIGHT_SCREEN, PROTECT, RAIN_DANCE, IRON_TAIL, THUNDERBOLT, THUNDER, EARTHQUAKE, RETURN, PSYCHIC, SHADOW_BALL, MUD_SLAP, DOUBLE_TEAM, REFLECT, SWAGGER, SWIFT, REST, ATTRACT, THIEF, BODY_SLAM, SUBSTITUTE, ENDURE, DAZZLINGLEAM, THUNDER_WAVE, STRENGTH, FLASH, ROCK_SMASH, DOUBLE_EDGE, DREAM_EATER, HEADBUTT, HYPER_VOICE, SLEEP_TALK, ZAP_CANNON, ZEN_HEADBUTT
	; end
