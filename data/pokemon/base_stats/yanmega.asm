	db  86,  76,  86,  95, 116,  56
	;   hp  atk  def  spd  sat  sdf

if DEF(FAITHFUL)
	db BUG, FLYING
else
	db BUG, DRAGON
endc
	db 30 ; catch rate
	db 198 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db SPEED_BOOST ; ability 1
	db TINTED_LENS ; ability 2
if DEF(FAITHFUL)
	db FRISK ; hidden ability
else
	db LEVITATE ; hidden ability
endc
	db MEDIUM_FAST ; growth rate
	dn INSECT, INSECT ; egg groups

	; ev_yield
	ev_yield   0,   2,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DRAGON_CLAW, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, GIGA_DRAIN, SOLAR_BEAM, RETURN, PSYCHIC, SHADOW_BALL, ROOST, DOUBLE_TEAM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, STEEL_WING, LEECH_LIFE, ENDURE, DRAGON_PULSE, GIGA_IMPACT, U_TURN, FLASH, FLY, DREAM_EATER, HEADBUTT, SLEEP_TALK, SWAGGER
	; end
