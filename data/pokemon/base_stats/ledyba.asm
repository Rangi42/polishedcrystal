if DEF(FAITHFUL)
	db  40,  20,  30,  55,  40,  80 ; 265 BST
	;   hp  atk  def  spd  sat  sdf
else
	db  40,  40,  30,  55,  20,  80 ; 265 BST
	;   hp  atk  def  spd  sat  sdf
endc

	db BUG, FLYING
	db 255 ; catch rate
	db 54 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 2 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/ledyba/front.dimensions"
	abilities_for LEDYBA, SWARM, EARLY_BIRD, RATTLED
	db FAST ; growth rate
	dn INSECT, INSECT ; egg groups

	ev_yield   0,   0,   0,   0,   0,   1
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm DYNAMICPUNCH, CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, LIGHT_SCREEN, PROTECT, GIGA_DRAIN, SAFEGUARD, SOLAR_BEAM, RETURN, DIG, ROCK_SMASH, DOUBLE_TEAM, REFLECT, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROOST, DRAIN_PUNCH, ACROBATICS, U_TURN, FLASH, SWORDS_DANCE, DOUBLE_EDGE, ENDURE, HEADBUTT, ICE_PUNCH, KNOCK_OFF, ROLLOUT, SLEEP_TALK, SWAGGER, THUNDERPUNCH
	; end
