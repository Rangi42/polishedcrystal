	db YANMEGA ; 469

	db  86,  76,  86,  95, 116,  56
	;   hp  atk  def  spd  sat  sdf

	db BUG, FLYING
	db 30 ; catch rate
	db 198 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn INSECT, INSECT ; egg groups

	; tmhm
	tmhm TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, PSYCHIC, SHADOW_BALL, MUD_SLAP, DOUBLE_TEAM, SWIFT, AERIAL_ACE, REST, ATTRACT, THIEF, STEEL_WING, SUBSTITUTE, ENDURE, FLY, FLASH, DREAM_EATER, HEADBUTT, SLEEP_TALK, SWAGGER
	; end
