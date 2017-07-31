	db XATU ; 178

if DEF(FAITHFUL)
	db  65,  75,  70,  95,  95,  70
	;   hp  atk  def  spd  sat  sdf
else
	db  65,  75,  70, 100, 100,  70
	;   hp  atk  def  spd  sat  sdf
endc

	db PSYCHIC, FLYING
	db 75 ; catch rate
	db 171 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db FEMALE_50 ; gender
	db 20 ; step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db SYNCHRONIZE ; ability 1
	db EARLY_BIRD ; ability 2
	db MAGIC_BOUNCE ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn AVIAN, AVIAN ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   1,   1,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, LIGHT_SCREEN, PROTECT, RAIN_DANCE, GIGA_DRAIN, SOLAR_BEAM, RETURN, PSYCHIC, SHADOW_BALL, ROOST, DOUBLE_TEAM, REFLECT, SWIFT, AERIAL_ACE, FACADE, REST, ATTRACT, THIEF, STEEL_WING, ENDURE, DAZZLINGLEAM, THUNDER_WAVE, GIGA_IMPACT, U_TURN, FLASH, FLY, DOUBLE_EDGE, DREAM_EATER, SLEEP_TALK, SUBSTITUTE, SUCKER_PUNCH, SWAGGER, ZEN_HEADBUTT
	; end
