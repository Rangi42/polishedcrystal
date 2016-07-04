	db WEEZING ; 110

	db  65,  90, 120,  60,  85,  70
	;   hp  atk  def  spd  sat  sdf

	db POISON, POISON
	db 60 ; catch rate
	db 173 ; base exp
	db NO_ITEM ; item 1
	db SMOKE_BALL ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn AMORPHOUS, AMORPHOUS ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, ROLLOUT, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, THUNDERBOLT, THUNDER, RETURN, SHADOW_BALL, DOUBLE_TEAM, SWAGGER, FLAMETHROWER, SLUDGE_BOMB, FIRE_BLAST, REST, ATTRACT, THIEF, SUBSTITUTE, DARK_PULSE, ENDURE, WILL_O_WISP, EXPLOSION, FLASH, SLEEP_TALK, ZAP_CANNON
	; end
