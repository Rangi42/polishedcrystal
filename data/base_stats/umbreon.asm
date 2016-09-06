	db UMBREON ; 197

	db  95,  65, 110,  65,  60, 130
	;   hp  atk  def  spd  sat  sdf

	db DARK, DARK
	db 45 ; catch rate
	db 197 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 31 ; gender
	db 100 ; unknown
	db 35 ; step cycles to hatch
	db 5 ; unknown
	dn 6, 6 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, IRON_TAIL, RETURN, DIG, PSYCHIC, SHADOW_BALL, MUD_SLAP, DOUBLE_TEAM, SWIFT, REST, ATTRACT, SUBSTITUTE, BODY_SLAM, DARK_PULSE, ENDURE, CUT, FLASH, DOUBLE_EDGE, DREAM_EATER, HEADBUTT, HYPER_VOICE, SLEEP_TALK, SWAGGER, ZAP_CANNON
	; end
