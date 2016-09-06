	db OCTILLERY ; 224

	db  75, 105,  75,  45, 105,  75
	;   hp  atk  def  spd  sat  sdf

	db WATER, WATER
	db 75 ; catch rate
	db 164 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 6, 6 ; frontpic dimensions
	db 0, 0, 0, 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn AMPHIBIAN, FISH ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, RETURN, PSYCHIC, MUD_SLAP, DOUBLE_TEAM, FLASH_CANNON, FLAMETHROWER, SLUDGE_BOMB, FIRE_BLAST, SWIFT, REST, ATTRACT, THIEF, SUBSTITUTE, ENERGY_BALL, SCALD, ENDURE, THUNDER_WAVE, SURF, WHIRLPOOL, WATERFALL, DEFENSE_CURL, DOUBLE_EDGE, ICY_WIND, SEED_BOMB, SEISMIC_TOSS, SLEEP_TALK, SWAGGER, WATER_PULSE
	; end
