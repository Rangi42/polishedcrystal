	db  38,  41,  40,  65,  50,  65 ; 299 BST
	;   hp  atk  def  spd  sat  sdf

	db FIRE, FIRE
	db 190 ; catch rate
	db 63 ; base exp
	db ALWAYS_ITEM_2 ; item 1
	db ASPEAR_BERRY ; item 2
	dn FEMALE_75, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/vulpix_plain/front.dimensions"
if DEF(FAITHFUL)
	abilities_for VULPIX, FLASH_FIRE, FLASH_FIRE, DROUGHT
else
	abilities_for VULPIX, FLASH_FIRE, FOREWARN, DROUGHT
endc
	db MEDIUM_FAST ; growth rate
	dn FIELD, FIELD ; egg groups

	ev_yield   0,   0,   0,   1,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, SAFEGUARD, IRON_TAIL, RETURN, DIG, DOUBLE_TEAM, FLAMETHROWER, FIRE_BLAST, SWIFT, SUBSTITUTE, FACADE, FLAME_CHARGE, REST, ATTRACT, THIEF, ENERGY_BALL, DARK_PULSE, WILL_O_WISP, BODY_SLAM, DOUBLE_EDGE, ENDURE, HEADBUTT, SLEEP_TALK, SWAGGER, ZEN_HEADBUTT
	; end
