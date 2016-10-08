	db VULPIX ; 037

	db  38,  41,  40,  65,  50,  65
	;   hp  atk  def  spd  sat  sdf

	db FIRE, FIRE
	db 190 ; catch rate
	db 63 ; base exp
	db BURNT_BERRY ; item 1
	db BURNT_BERRY ; item 2
	db 191 ; gender
	db 20 ; step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db FLASH_FIRE ; ability 1
	db FLASH_FIRE ; ability 2
	db DROUGHT ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   1,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, SAFEGUARD, IRON_TAIL, RETURN, DIG, SHADOW_BALL, DOUBLE_TEAM, FLAMETHROWER, FIRE_BLAST, SWIFT, REST, ATTRACT, THIEF, SUBSTITUTE, BODY_SLAM, ENERGY_BALL, DARK_PULSE, ENDURE, WILL_O_WISP, DOUBLE_EDGE, HEADBUTT, SLEEP_TALK, SWAGGER, ZEN_HEADBUTT
	; end
