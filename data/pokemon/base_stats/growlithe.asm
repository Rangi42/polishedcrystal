	db  55,  70,  45,  60,  70,  50 ; 350 BST
	;   hp  atk  def  spd  sat  sdf

	db FIRE, FIRE
	db 190 ; catch rate
	db 91 ; base exp
	db ALWAYS_ITEM_2 ; item 1
	db ASPEAR_BERRY ; item 2
	dn FEMALE_25, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/growlithe/front.dimensions"
	abilities_for GROWLITHE, INTIMIDATE, FLASH_FIRE, JUSTIFIED
	db SLOW ; growth rate
	dn FIELD, FIELD ; egg groups

	ev_yield   0,   1,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, SAFEGUARD, IRON_TAIL, RETURN, DIG, ROCK_SMASH, DOUBLE_TEAM, FLAMETHROWER, FIRE_BLAST, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, FLAME_CHARGE, REST, ATTRACT, THIEF, WILD_CHARGE, WILL_O_WISP, STRENGTH, BODY_SLAM, DOUBLE_EDGE, ENDURE, HEADBUTT, SLEEP_TALK, SWAGGER
	; end
