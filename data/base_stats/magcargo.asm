	db MAGCARGO ; 219

if DEF(FAITHFUL)
	db  50,  50, 120,  30,  80,  80
	;   hp  atk  def  spd  sat  sdf
else
	db  50,  50, 135,  30, 115, 115
	;   hp  atk  def  spd  sat  sdf
endc

	db FIRE, ROCK
	db 75 ; catch rate
if DEF(FAITHFUL)
	db 154 ; base exp
else
	db 171 ; base exp
endc
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 6, 6 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn AMORPHOUS, AMORPHOUS ; egg groups

	; tmhm
	tmhm CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, LIGHT_SCREEN, PROTECT, SOLAR_BEAM, EARTHQUAKE, RETURN, MUD_SLAP, DOUBLE_TEAM, REFLECT, FLAMETHROWER, SANDSTORM, FIRE_BLAST, STONE_EDGE, REST, ATTRACT, ROCK_SLIDE, SUBSTITUTE, BODY_SLAM, ENDURE, WILL_O_WISP, EXPLOSION, STRENGTH, ROCK_SMASH, DEFENSE_CURL, DOUBLE_EDGE, EARTH_POWER, ROLLOUT, SLEEP_TALK, SWAGGER
	; end
