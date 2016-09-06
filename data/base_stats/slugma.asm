	db SLUGMA ; 218

	db  40,  40,  40,  20,  70,  40
	;   hp  atk  def  spd  sat  sdf

	db FIRE, FIRE
	db 190 ; catch rate
	db 78 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 5, 5 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn AMORPHOUS, AMORPHOUS ; egg groups

	; tmhm
	tmhm CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, LIGHT_SCREEN, PROTECT, RETURN, MUD_SLAP, DOUBLE_TEAM, REFLECT, FLAMETHROWER, FIRE_BLAST, REST, ATTRACT, ROCK_SLIDE, SUBSTITUTE, BODY_SLAM, ENDURE, WILL_O_WISP, ROCK_SMASH, DEFENSE_CURL, DOUBLE_EDGE, EARTH_POWER, ROLLOUT, SLEEP_TALK, SWAGGER
	; end
