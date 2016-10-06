	db SUDOWOODO ; 185

if DEF(FAITHFUL)
	db  70, 100, 115,  30,  30,  65
	;   hp  atk  def  spd  sat  sdf
else
	db  75, 115, 130,  30,  30,  80
	;   hp  atk  def  spd  sat  sdf
endc

	db ROCK, ROCK
	db 65 ; catch rate
	db 135 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 6, 6 ; frontpic dimensions
	db STURDY ; ability 1
	db ROCK_HEAD ; ability 2
	db RATTLED ; hidden ability
	db 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn INANIMATE, INANIMATE ; egg groups

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, EARTHQUAKE, RETURN, DIG, MUD_SLAP, DOUBLE_TEAM, SANDSTORM, STONE_EDGE, REST, ATTRACT, THIEF, ROCK_SLIDE, SUBSTITUTE, BODY_SLAM, ENDURE, EXPLOSION, STRENGTH, ROCK_SMASH, COUNTER, DEFENSE_CURL, DOUBLE_EDGE, EARTH_POWER, FIRE_PUNCH, HEADBUTT, ICE_PUNCH, ROLLOUT, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, THUNDERPUNCH
	; end
