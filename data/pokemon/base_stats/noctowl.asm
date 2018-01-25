if DEF(FAITHFUL)
	db 100,  50,  50,  70,  86,  96
	;   hp  atk  def  spd  sat  sdf
else
	db 100,  50,  50,  70,  96,  96
	;   hp  atk  def  spd  sat  sdf
endc

if DEF(FAITHFUL)
	db NORMAL, FLYING
	db 90 ; catch rate
else
	db GHOST, FLYING
	db 80 ; catch rate
endc
	db 162 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 2 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db INSOMNIA ; ability 1
	db KEEN_EYE ; ability 2
	db TINTED_LENS ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn AVIAN, AVIAN ; egg groups

	; ev_yield
	ev_yield   2,   0,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, RETURN, PSYCHIC, SHADOW_BALL, ROOST, DOUBLE_TEAM, REFLECT, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, STEEL_WING, ENDURE, GIGA_IMPACT, FLASH, FLY, DOUBLE_EDGE, DREAM_EATER, HYPER_VOICE, SLEEP_TALK, SWAGGER, ZEN_HEADBUTT
	; end
