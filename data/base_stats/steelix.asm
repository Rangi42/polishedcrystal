	db STEELIX ; 208

if DEF(FAITHFUL)
	db  75,  85, 200,  30,  55,  65
	;   hp  atk  def  spd  sat  sdf
else
	db  75,  90, 200,  30,  55,  65
	;   hp  atk  def  spd  sat  sdf
endc

	db STEEL, GROUND
	db 25 ; catch rate
	db 196 ; base exp
	db NO_ITEM ; item 1
	db METAL_COAT ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 25 ; step cycles to hatch
	db 5 ; unknown
	dn 7, 7 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn INANIMATE, INANIMATE ; egg groups

	; tmhm
	tmhm CURSE, ROAR, TOXIC, ROLLOUT, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, DRAGONBREATH, IRON_TAIL, EARTHQUAKE, RETURN, DIG, MUD_SLAP, DOUBLE_TEAM, SWAGGER, SANDSTORM, DEFENSE_CURL, STONE_EDGE, REST, ATTRACT, BODY_SLAM, ROCK_SLIDE, SUBSTITUTE, FLASH_CANNON, DARK_PULSE, ENDURE, DRAGON_PULSE, EXPLOSION, CUT, STRENGTH, ROCK_SMASH, AQUA_TAIL, DOUBLE_EDGE, EARTH_POWER, HEADBUTT, IRON_HEAD, SLEEP_TALK
	; end
