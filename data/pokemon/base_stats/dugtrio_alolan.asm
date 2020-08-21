	db  35, 100,  60, 110,  50,  70 ; 425 BST
	;   hp  atk  def  spd  sat  sdf

	db GROUND, STEEL
	db 50 ; catch rate
	db 153 ; base exp
	db NO_ITEM ; item 1
	db SOFT_SAND ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/dugtrio_alolan/front.dimensions"
	abilities_for DUGTRIO_ALOLAN, SAND_VEIL, TANGLING_HAIR, SAND_FORCE
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	ev_yield   0,   0,   0,   2,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, HONE_CLAWS, HYPER_BEAM, PROTECT, BULLDOZE, EARTHQUAKE, RETURN, DIG, ROCK_SMASH, DOUBLE_TEAM, FLASH_CANNON, SLUDGE_BOMB, SANDSTORM, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ROCK_SLIDE, SHADOW_CLAW, GIGA_IMPACT, STONE_EDGE, CUT, AGILITY, BODY_SLAM, DOUBLE_EDGE, EARTH_POWER, ENDURE, HEADBUTT, IRON_HEAD, SLEEP_TALK, SUCKER_PUNCH, SWAGGER
	; end
