	db HAUNTER ; 093

	db  45,  50,  45,  95, 115,  55
	;   hp  atk  def  spd  sat  sdf

	db GHOST, POISON
	db 90 ; catch rate
	db 126 ; base exp
	db NO_ITEM ; item 1
	db SPELL_TAG ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 6, 6 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_SLOW ; growth rate
	dn AMORPHOUS, AMORPHOUS ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, ICY_WIND, PROTECT, RAIN_DANCE, GIGA_DRAIN, THUNDERBOLT, THUNDER, RETURN, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, SWAGGER, SLUDGE_BOMB, REST, ATTRACT, THIEF, SUBSTITUTE, DARK_PULSE, ENDURE, DAZZLINGLEAM, WILL_O_WISP, POISON_JAB, EXPLOSION, SHADOW_CLAW, DREAM_EATER, FIRE_PUNCH, ICE_PUNCH, SLEEP_TALK, THUNDERPUNCH, ZAP_CANNON
	; end
