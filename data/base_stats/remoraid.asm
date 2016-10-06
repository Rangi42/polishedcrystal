	db REMORAID ; 223

	db  35,  65,  35,  65,  65,  35
	;   hp  atk  def  spd  sat  sdf

	db WATER, WATER
	db 190 ; catch rate
	db 78 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	db 127 ; gender
	db 100 ; unknown
	db 20 ; step cycles to hatch
	db 5 ; unknown
	dn 5, 5 ; frontpic dimensions
	db HUSTLE ; ability 1
	db SNIPER ; ability 2
	db MOODY ; hidden ability
	db 0 ; padding
	db MEDIUM_FAST ; growth rate
	dn AMPHIBIAN, FISH ; egg groups

	; tmhm
	tmhm CURSE, TOXIC, HIDDEN_POWER, SUNNY_DAY, ICE_BEAM, BLIZZARD, HYPER_BEAM, PROTECT, RAIN_DANCE, RETURN, PSYCHIC, MUD_SLAP, DOUBLE_TEAM, FLAMETHROWER, FIRE_BLAST, SWIFT, REST, ATTRACT, THIEF, SUBSTITUTE, SCALD, ENDURE, THUNDER_WAVE, SURF, WHIRLPOOL, WATERFALL, DEFENSE_CURL, DOUBLE_EDGE, ICY_WIND, SEED_BOMB, SLEEP_TALK, SWAGGER, WATER_PULSE
	; end
