	db NINETALES ; 038

	db  73,  76,  75, 100,  81, 100
	;   hp  atk  def  spd  sat  sdf

if DEF(FAITHFUL)
	db FIRE, FIRE
else
	db FIRE, GHOST
endc
	db 75 ; catch rate
	db 178 ; base exp
	db BURNT_BERRY ; item 1
	db BURNT_BERRY ; item 2
	db 191 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db FLASH_FIRE ; ability 1
	db FLASH_FIRE ; ability 2
	db DROUGHT ; hidden ability
	db 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	; tmhm
	tmhm CURSE, CALM_MIND, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, SAFEGUARD, SOLAR_BEAM, IRON_TAIL, RETURN, DIG, SHADOW_BALL, DOUBLE_TEAM, FLAMETHROWER, FIRE_BLAST, SWIFT, REST, ATTRACT, THIEF, SUBSTITUTE, BODY_SLAM, ENERGY_BALL, DARK_PULSE, ENDURE, WILL_O_WISP, DOUBLE_EDGE, DREAM_EATER, HEADBUTT, SLEEP_TALK, SWAGGER, ZEN_HEADBUTT
	; end
