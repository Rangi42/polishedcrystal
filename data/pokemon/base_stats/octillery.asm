	db  75, 105,  75,  45, 105,  75 ; 480 BST
	;   hp  atk  def  spd  sat  sdf

if DEF(FAITHFUL)
	db WATER, WATER
else
	db WATER, FIRE
endc
	db 75 ; catch rate
	db 164 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	INCBIN "gfx/pokemon/octillery/front.dimensions"
	abilities_for OCTILLERY, SUCTION_CUPS, SNIPER, MOODY
	db MEDIUM_FAST ; growth rate
	dn AMPHIBIAN, FISH ; egg groups

	ev_yield   0,   1,   0,   0,   1,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, RETURN, PSYCHIC, DOUBLE_TEAM, FLASH_CANNON, FLAMETHROWER, SLUDGE_BOMB, FIRE_BLAST, SWIFT, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, ENERGY_BALL, SCALD, WATER_PULSE, GIGA_IMPACT, THUNDER_WAVE, SURF, WHIRLPOOL, WATERFALL, DEFENSE_CURL, DOUBLE_EDGE, ENDURE, ICY_WIND, SEED_BOMB, SEISMIC_TOSS, SLEEP_TALK, SWAGGER
	; end
