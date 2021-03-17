	db  65,  80, 140,  70,  40,  70 ; 465 BST
	;   hp  atk  def  spd  sat  sdf

	db STEEL, FLYING
	db 25 ; catch rate
	db 168 ; base exp
	db NO_ITEM ; item 1
	db SHARP_BEAK ; item 2
	dn FEMALE_50, 4 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/skarmory/front.dimensions"
	abilities_for SKARMORY, KEEN_EYE, STURDY, WEAK_ARMOR
	db SLOW ; growth rate
	dn AVIAN, AVIAN ; egg groups

	ev_yield   0,   0,   2,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, RETURN, ROCK_SMASH, DOUBLE_TEAM, FLASH_CANNON, SANDSTORM, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, STEEL_WING, ROCK_SLIDE, ROOST, X_SCISSOR, DARK_PULSE, FLASH, SWORDS_DANCE, CUT, FLY, COUNTER, DOUBLE_EDGE, ENDURE, ICY_WIND, IRON_HEAD, SLEEP_TALK, SWAGGER
	; end
