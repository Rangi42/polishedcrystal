	db LEDYBA ; 165

if DEF(FAITHFUL)
	db  40,  20,  30,  55,  40,  80
	;   hp  atk  def  spd  sat  sdf
else
	db  40,  40,  30,  55,  20,  80
	;   hp  atk  def  spd  sat  sdf
endc

	db BUG, FLYING
	db 255 ; catch rate
	db 54 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db FEMALE_50 ; gender
	db 15 ; step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db SWARM ; ability 1
	db EARLY_BIRD ; ability 2
	db RATTLED ; hidden ability
	db FAST ; growth rate
	dn INSECT, INSECT ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   0,   1
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, SWORDS_DANCE, HIDDEN_POWER, SUNNY_DAY, LIGHT_SCREEN, PROTECT, GIGA_DRAIN, SAFEGUARD, SOLAR_BEAM, RETURN, DIG, DOUBLE_TEAM, REFLECT, SWIFT, AERIAL_ACE, FACADE, REST, ATTRACT, THIEF, ENDURE, ACROBATICS, U_TURN, FLASH, DOUBLE_EDGE, HEADBUTT, ICE_PUNCH, ROLLOUT, SLEEP_TALK, SUBSTITUTE, SWAGGER, THUNDERPUNCH
	; end
