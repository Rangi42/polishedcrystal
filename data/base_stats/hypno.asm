	db HYPNO ; 097

	db  85,  73,  70,  67,  73, 115
	;   hp  atk  def  spd  sat  sdf

	db PSYCHIC, PSYCHIC
	db 75 ; catch rate
	db 165 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db INSOMNIA ; ability 1
	db FOREWARN ; ability 2
	db INNER_FOCUS ; hidden ability
	db 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn HUMANSHAPE, HUMANSHAPE ; egg groups

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, SAFEGUARD, RETURN, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, REFLECT, REST, ATTRACT, THIEF, SUBSTITUTE, BODY_SLAM, FOCUS_BLAST, ENDURE, DAZZLINGLEAM, THUNDER_WAVE, FLASH, COUNTER, DOUBLE_EDGE, DREAM_EATER, FIRE_PUNCH, HEADBUTT, ICE_PUNCH, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, THUNDERPUNCH, ZAP_CANNON, ZEN_HEADBUTT
	; end
