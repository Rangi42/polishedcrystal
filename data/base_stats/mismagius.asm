	db MISMAGIUS ; 429

	db  60,  60,  60, 105, 105, 105
	;   hp  atk  def  spd  sat  sdf

	db GHOST, FAIRY
	db 45 ; catch rate
	db 187 ; base exp
	db NO_ITEM ; item 1
	db SPELL_TAG ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 25 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db FAST ; growth rate
	dn AMORPHOUS, AMORPHOUS ; egg groups

	; tmhm
	tmhm CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, ICY_WIND, HYPER_BEAM, PROTECT, RAIN_DANCE, THUNDERBOLT, THUNDER, RETURN, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, SWAGGER, FLAMETHROWER, SWIFT, REST, ATTRACT, THIEF, SUBSTITUTE, DARK_PULSE, ENDURE, DAZZLINGLEAM, WILL_O_WISP, THUNDER_WAVE, FLASH, DREAM_EATER, HEADBUTT, HYPER_VOICE, SLEEP_TALK
	; end
