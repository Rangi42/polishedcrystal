	db 115, 115,  85, 100,  90,  75 ; 580 BST
	;   hp  atk  def  spd  sat  sdf

	db FIRE, FIRE ; type
	db 3 ; catch rate
	db 217 ; base exp
	db ALWAYS_ITEM_2 ; item 1
	db CHARCOAL ; item 2
	dn GENDER_UNKNOWN, 15 ; gender ratio, step cycles to hatch
	INCBIN "gfx/pokemon/entei/front.dimensions"
if DEF(FAITHFUL)
	abilities_for ENTEI, PRESSURE, PRESSURE, INNER_FOCUS
else
	abilities_for ENTEI, PRESSURE, INNER_FOCUS, FLASH_FIRE
endc
	db GROWTH_SLOW ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	ev_yield   1,   2,   0,   0,   0,   0
	;         hp  atk  def  spd  sat  sdf

	; tm/hm learnset
	tmhm CURSE, CALM_MIND, ROAR, TOXIC, HIDDEN_POWER, SUNNY_DAY, HYPER_BEAM, PROTECT, RAIN_DANCE, BULLDOZE, SOLAR_BEAM, IRON_TAIL, EARTHQUAKE, RETURN, DIG, SHADOW_BALL, ROCK_SMASH, DOUBLE_TEAM, REFLECT, FLAMETHROWER, SANDSTORM, FIRE_BLAST, SWIFT, SUBSTITUTE, FACADE, FLAME_CHARGE, REST, WILL_O_WISP, GIGA_IMPACT, FLASH, STONE_EDGE, CUT, STRENGTH, BODY_SLAM, DOUBLE_EDGE, ENDURE, HEADBUTT, IRON_HEAD, SLEEP_TALK, SWAGGER
	; end
