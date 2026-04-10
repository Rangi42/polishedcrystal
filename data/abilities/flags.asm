DEF _abilflag_count = 0
DEF _abilflag_error = 0
MACRO abilflag
	if !_abilflag_error
		def _abilflag_error |= \1 != _abilflag_count
		assert !_abilflag_error, "Ability ID mismatch: \1"
	endc
	def _abilflag_count += 1
	def _abilflag_flags = 0
	for i, 2, _NARG + 1
		def _abilflag_flags |= ABILFLAG_\<i>
	endr
	db _abilflag_flags
ENDM

AbilityFlags:
; When adding abilities, keep Polished's additional flags in mind.
	table_width 1
	abilflag NO_ABILITY, NO_COPY, NO_TRACE, NO_SWAP
	abilflag STENCH
	abilflag DRIZZLE
	abilflag SPEED_BOOST
	abilflag BATTLE_ARMOR, IGNORABLE
	abilflag STURDY, IGNORABLE
	abilflag DAMP, IGNORABLE
	abilflag LIMBER, IGNORABLE
	abilflag SAND_VEIL, IGNORABLE
	abilflag STATIC
	abilflag VOLT_ABSORB, IGNORABLE
	abilflag WATER_ABSORB, IGNORABLE
	abilflag OBLIVIOUS, IGNORABLE, NO_INTIMIDATE
	abilflag CLOUD_NINE
	abilflag COMPOUND_EYES
	abilflag INSOMNIA, IGNORABLE
	abilflag IMMUNITY, IGNORABLE
	abilflag FLASH_FIRE, IGNORABLE
	abilflag SHIELD_DUST, IGNORABLE
	abilflag OWN_TEMPO, IGNORABLE, NO_INTIMIDATE
	abilflag SUCTION_CUPS, IGNORABLE
	abilflag INTIMIDATE
	abilflag SHADOW_TAG
	abilflag LEVITATE, IGNORABLE
	abilflag EFFECT_SPORE
	abilflag SYNCHRONIZE
	abilflag CLEAR_BODY, IGNORABLE
	abilflag NATURAL_CURE
	abilflag LIGHTNING_ROD, IGNORABLE
	abilflag SERENE_GRACE
	abilflag SWIFT_SWIM
	abilflag CHLOROPHYLL
	abilflag ILLUMINATE, IGNORABLE
	abilflag TRACE, NO_COPY, NO_TRACE
	abilflag HUGE_POWER
	abilflag POISON_POINT
	abilflag INNER_FOCUS, IGNORABLE, NO_INTIMIDATE
	abilflag MAGMA_ARMOR, IGNORABLE
	abilflag WATER_VEIL, IGNORABLE
	abilflag MAGNET_PULL
	abilflag SOUNDPROOF, IGNORABLE
	abilflag RAIN_DISH
	abilflag SAND_STREAM
	abilflag PRESSURE
	abilflag THICK_FAT, IGNORABLE
	abilflag EARLY_BIRD
	abilflag FLAME_BODY
	abilflag RUN_AWAY
	abilflag KEEN_EYE, IGNORABLE
	abilflag HYPER_CUTTER, IGNORABLE
	abilflag PICKUP
	abilflag HUSTLE
	abilflag CUTE_CHARM
	abilflag STICKY_HOLD, IGNORABLE
	abilflag SHED_SKIN
	abilflag GUTS
	abilflag MARVEL_SCALE, IGNORABLE
	abilflag LIQUID_OOZE
	abilflag OVERGROW
	abilflag BLAZE
	abilflag TORRENT
	abilflag SWARM
	abilflag ROCK_HEAD
	abilflag DROUGHT
	abilflag ARENA_TRAP
	abilflag VITAL_SPIRIT, IGNORABLE
	abilflag WHITE_SMOKE, IGNORABLE
	abilflag SHELL_ARMOR, IGNORABLE
	abilflag TANGLED_FEET, IGNORABLE
	abilflag MOTOR_DRIVE, IGNORABLE
	abilflag RIVALRY
	abilflag STEADFAST
	abilflag SNOW_CLOAK, IGNORABLE
	abilflag GLUTTONY
	abilflag ANGER_POINT
	abilflag UNBURDEN
	abilflag DRY_SKIN, IGNORABLE
	abilflag DOWNLOAD
	abilflag IRON_FIST
	abilflag POISON_HEAL
	abilflag ADAPTABILITY
	abilflag SKILL_LINK
	abilflag HYDRATION
	abilflag SOLAR_POWER
	abilflag QUICK_FEET
	abilflag SNIPER
	abilflag MAGIC_GUARD
	abilflag NO_GUARD
	abilflag TECHNICIAN
	abilflag LEAF_GUARD, IGNORABLE
	abilflag MOLD_BREAKER
	abilflag SUPER_LUCK
	abilflag AFTERMATH
	abilflag ANTICIPATION
	abilflag FOREWARN
	abilflag UNAWARE, IGNORABLE
	abilflag TINTED_LENS
	abilflag FILTER, IGNORABLE
	abilflag SCRAPPY, NO_INTIMIDATE
	abilflag ICE_BODY
	abilflag SOLID_ROCK, IGNORABLE
	abilflag SNOW_WARNING
	abilflag HONEY_GATHER
	abilflag FRISK
	abilflag RECKLESS
	abilflag BAD_DREAMS
	abilflag PICKPOCKET
	abilflag SHEER_FORCE
	abilflag CONTRARY, IGNORABLE
	abilflag UNNERVE
	abilflag DEFIANT
	abilflag CURSED_BODY
	abilflag WEAK_ARMOR
	abilflag LIGHT_METAL, IGNORABLE
	abilflag MULTISCALE, IGNORABLE
	abilflag HARVEST
	abilflag MOODY
	abilflag OVERCOAT, IGNORABLE
	abilflag POISON_TOUCH
	abilflag REGENERATOR
	abilflag BIG_PECKS, IGNORABLE
	abilflag SAND_RUSH
	abilflag WONDER_SKIN, IGNORABLE
	abilflag ANALYTIC
	abilflag IMPOSTER, NO_COPY, NO_TRACE ; can swap, but won't trigger
	abilflag INFILTRATOR
	abilflag MOXIE
	abilflag JUSTIFIED
	abilflag RATTLED
	abilflag MAGIC_BOUNCE, IGNORABLE
	abilflag SAP_SIPPER, IGNORABLE
	abilflag PRANKSTER
	abilflag SAND_FORCE
	abilflag FUR_COAT, IGNORABLE
	abilflag BULLETPROOF, IGNORABLE
	abilflag COMPETITIVE
	abilflag MEGA_LAUNCHER
	abilflag TOUGH_CLAWS
	abilflag PIXILATE
	abilflag PARENTAL_BOND
	abilflag BERSERK
	abilflag SLUSH_RUSH
	abilflag GALVANIZE
	abilflag CORROSION
	abilflag FLUFFY, IGNORABLE
	abilflag TANGLING_HAIR
	abilflag SCREEN_CLEANER
	abilflag STEELY_SPIRIT
	abilflag PERISH_BODY
	abilflag GORILLA_TACTICS
	abilflag NEUTRALIZING_GAS, NO_COPY, NO_TRACE, NO_SWAP, NO_TRANSFORM
	abilflag PASTEL_VEIL, IGNORABLE
	abilflag QUICK_DRAW
	abilflag WIND_RIDER, IGNORABLE
	abilflag CUD_CHEW
	abilflag SHARPNESS
	abilflag ARMOR_TAIL
	abilflag MINDS_EYE, IGNORABLE
	abilflag MEGA_SOL
	assert_table_length NUM_ABILITIES
