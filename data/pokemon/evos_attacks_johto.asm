SECTION "Evolutions and Attacks Johto", ROMX

EvosAttacksPointersJohto::
	dw .ChikoritaEvosAttacks
	dw .BayleefEvosAttacks
	dw .MeganiumEvosAttacks
	dw .CyndaquilEvosAttacks
	dw .QuilavaEvosAttacks
	dw .TyphlosionPlainEvosAttacks
	dw .TotodileEvosAttacks
	dw .CroconawEvosAttacks
	dw .FeraligatrEvosAttacks
	dw .SentretEvosAttacks
	dw .FurretEvosAttacks
	dw .HoothootEvosAttacks
	dw .NoctowlEvosAttacks
	dw .LedybaEvosAttacks
	dw .LedianEvosAttacks
	dw .SpinarakEvosAttacks
	dw .AriadosEvosAttacks
	dw .CrobatEvosAttacks
	dw .ChinchouEvosAttacks
	dw .LanturnEvosAttacks
	dw .PichuEvosAttacks
	dw .CleffaEvosAttacks
	dw .IgglybuffEvosAttacks
	dw .TogepiEvosAttacks
	dw .TogeticEvosAttacks
	dw .NatuEvosAttacks
	dw .XatuEvosAttacks
	dw .MareepEvosAttacks
	dw .FlaaffyEvosAttacks
	dw .AmpharosEvosAttacks
	dw .BellossomEvosAttacks
	dw .MarillEvosAttacks
	dw .AzumarillEvosAttacks
	dw .SudowoodoEvosAttacks
	dw .PolitoedEvosAttacks
	dw .HoppipEvosAttacks
	dw .SkiploomEvosAttacks
	dw .JumpluffEvosAttacks
	dw .AipomEvosAttacks
	dw .SunkernEvosAttacks
	dw .SunfloraEvosAttacks
	dw .YanmaEvosAttacks
	dw .WooperPlainEvosAttacks
	dw .QuagsireEvosAttacks
	dw .EspeonEvosAttacks
	dw .UmbreonEvosAttacks
	dw .MurkrowEvosAttacks
	dw .SlowkingPlainEvosAttacks
	dw .MisdreavusEvosAttacks
	dw .UnownEvosAttacks
	dw .WobbuffetEvosAttacks
	dw .GirafarigEvosAttacks
	dw .PinecoEvosAttacks
	dw .ForretressEvosAttacks
	dw .DunsparceEvosAttacks
	dw .GligarEvosAttacks
	dw .SteelixEvosAttacks
	dw .SnubbullEvosAttacks
	dw .GranbullEvosAttacks
	dw .QwilfishPlainEvosAttacks
	dw .ScizorEvosAttacks
	dw .ShuckleEvosAttacks
	dw .HeracrossEvosAttacks
	dw .SneaselPlainEvosAttacks
	dw .TeddiursaEvosAttacks
	dw .UrsaringEvosAttacks
	dw .SlugmaEvosAttacks
	dw .MagcargoEvosAttacks
	dw .SwinubEvosAttacks
	dw .PiloswineEvosAttacks
	dw .CorsolaPlainEvosAttacks
	dw .RemoraidEvosAttacks
	dw .OctilleryEvosAttacks
	dw .DelibirdEvosAttacks
	dw .MantineEvosAttacks
	dw .SkarmoryEvosAttacks
	dw .HoundourEvosAttacks
	dw .HoundoomEvosAttacks
	dw .KingdraEvosAttacks
	dw .PhanpyEvosAttacks
	dw .DonphanEvosAttacks
	dw .Porygon2EvosAttacks
	dw .StantlerEvosAttacks
	dw .SmeargleEvosAttacks
	dw .TyrogueEvosAttacks
	dw .HitmontopEvosAttacks
	dw .SmoochumEvosAttacks
	dw .ElekidEvosAttacks
	dw .MagbyEvosAttacks
	dw .MiltankEvosAttacks
	dw .BlisseyEvosAttacks
	dw .RaikouEvosAttacks
	dw .EnteiEvosAttacks
	dw .SuicuneEvosAttacks
	dw .LarvitarEvosAttacks
	dw .PupitarEvosAttacks
	dw .TyranitarEvosAttacks
	dw .LugiaEvosAttacks
	dw .HoOhEvosAttacks
	dw .CelebiEvosAttacks
.IndirectEnd::

.ChikoritaEvosAttacks
	evo_data EVOLVE_LEVEL, 16, BAYLEEF
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, GROWL
	dbw 6, RAZOR_LEAF
	dbw 9, POISONPOWDER
	dbw 12, HEALINGLIGHT ; Synthesis → similar move
	dbw 17, REFLECT
	dbw 17, LIGHT_SCREEN
	dbw 20, DISARM_VOICE ; Magical Leaf → new move
	dbw 23, ENERGY_BALL ; Natural Gift → tutor move
	dbw 28, ANCIENTPOWER ; Sweet Scent → HGSS tutor move
	dbw 31, DAZZLINGLEAM ; Light Screen → TM move
	dbw 34, BODY_SLAM
	dbw 39, SAFEGUARD
	dbw 42, PLAY_ROUGH ; Aromatherapy → new move
	dbw 45, SOLAR_BEAM
	dbw 48, HEAL_BELL ; Aromatherapy → similar move
	dbw 51, OUTRAGE ; HGSS tutor move
	dbw 56, MOONBLAST ; new move
	db -1 ; no more level-up moves

.BayleefEvosAttacks
	evo_data EVOLVE_LEVEL, 32, MEGANIUM
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, GROWL
	dbw 6, RAZOR_LEAF
	dbw 9, POISONPOWDER
	dbw 12, HEALINGLIGHT ; Synthesis → similar move
	dbw 18, REFLECT
	dbw 18, LIGHT_SCREEN
	dbw 22, DISARM_VOICE ; Magical Leaf → new move
	dbw 26, ENERGY_BALL ; Natural Gift → tutor move
	dbw 32, ANCIENTPOWER ; Sweet Scent → HGSS tutor move
	dbw 36, DAZZLINGLEAM ; Light Screen → TM move
	dbw 40, BODY_SLAM
	dbw 43, SAFEGUARD
	dbw 47, PLAY_ROUGH ; Aromatherapy → new move
	dbw 51, SOLAR_BEAM
	dbw 54, HEAL_BELL ; Aromatherapy → similar move
	dbw 58, OUTRAGE ; HGSS tutor move
	dbw 64, MOONBLAST ; new move
	db -1 ; no more level-up moves

.MeganiumEvosAttacks
	db -1 ; no more evolutions
	dbw 1, PETAL_DANCE ; evolution move
	dbw 1, TACKLE
	dbw 1, GROWL
	dbw 6, RAZOR_LEAF
	dbw 9, POISONPOWDER
	dbw 12, HEALINGLIGHT ; Synthesis → similar move
	dbw 18, REFLECT
	dbw 18, LIGHT_SCREEN
	dbw 22, DISARM_VOICE ; Magical Leaf → new move
	dbw 26, ENERGY_BALL ; Natural Gift → tutor move
	dbw 34, ANCIENTPOWER ; Sweet Scent → HGSS tutor move
	dbw 40, DAZZLINGLEAM ; Light Screen → TM move
	dbw 46, BODY_SLAM
	dbw 50, SAFEGUARD
	dbw 56, PLAY_ROUGH ; Aromatherapy → new move
	dbw 62, SOLAR_BEAM
	dbw 66, HEAL_BELL ; Aromatherapy → similar move
	dbw 72, OUTRAGE ; HGSS tutor move
	dbw 80, MOONBLAST ; new move
	db -1 ; no more level-up moves

.CyndaquilEvosAttacks
	evo_data EVOLVE_LEVEL, 14, QUILAVA
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, LEER
	dbw 6, SMOKESCREEN
	dbw 10, EMBER
	dbw 13, QUICK_ATTACK
	dbw 19, DEFENSE_CURL ; Flame Wheel → Defense Curl
	dbw 22, FLAME_CHARGE ; Defense Curl → Flame Charge
	dbw 28, DIG ; Flame Charge → TM move
	dbw 31, SWIFT
	dbw 37, REVERSAL ; Lava Plume → egg move
	dbw 40, FLAMETHROWER
	dbw 46, EARTH_POWER ; Inferno → new move
	dbw 49, ROLLOUT
	dbw 55, DOUBLE_EDGE
	dbw 58, EARTHQUAKE ; Burn Up → TM move
	dbw 64, FLARE_BLITZ ; Eruption → egg move
	db -1 ; no more level-up moves

.QuilavaEvosAttacks
	evo_data EVOLVE_LEVEL, 36, TYPHLOSION
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, LEER
	dbw 6, SMOKESCREEN
	dbw 10, EMBER
	dbw 13, QUICK_ATTACK
	dbw 20, DEFENSE_CURL ; Flame Wheel → Defense Curl
	dbw 24, FLAME_CHARGE ; Defense Curl → Flame Charge
	dbw 31, SWIFT
	dbw 35, DIG ; Flame Charge → TM move
	dbw 42, REVERSAL ; Lava Plume → egg move
	dbw 46, FLAMETHROWER
	dbw 53, EARTH_POWER ; Inferno → new move
	dbw 57, ROLLOUT
	dbw 64, DOUBLE_EDGE
	dbw 68, EARTHQUAKE ; Burn Up → TM move
	dbw 75, FLARE_BLITZ ; Eruption → egg move
	db -1 ; no more level-up moves

.TyphlosionPlainEvosAttacks
	db -1 ; no more evolutions
	dbw 1, FIRE_PUNCH ; evolution move
	dbw 1, TACKLE
	dbw 1, LEER
	dbw 6, SMOKESCREEN
	dbw 10, EMBER
	dbw 13, QUICK_ATTACK
	dbw 20, DEFENSE_CURL ; Flame Wheel → Defense Curl
	dbw 24, FLAME_CHARGE ; Defense Curl → Flame Charge
	dbw 31, SWIFT
	dbw 35, DIG ; Flame Charge → TM move
	dbw 43, REVERSAL ; Lava Plume → egg move
	dbw 48, FLAMETHROWER
	dbw 56, EARTH_POWER ; Inferno → new move
	dbw 61, ROLLOUT
	dbw 69, DOUBLE_EDGE
	dbw 74, EARTHQUAKE ; Burn Up → TM move
	dbw 81, FLARE_BLITZ ; Eruption → egg move
	db -1 ; no more level-up moves

.TotodileEvosAttacks
	evo_data EVOLVE_LEVEL, 18, CROCONAW
	db -1 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, LEER
	dbw 6, WATER_GUN
	dbw 8, RAGE
	dbw 13, BITE
	dbw 15, SCARY_FACE
	dbw 20, METAL_CLAW ; Ice Fang → egg move
	dbw 22, REVERSAL ; Flail → similar move
	dbw 27, AGILITY ; Feraligatr move
	dbw 29, CRUNCH
	dbw 34, ANCIENTPOWER ; Chip Away → HGSS tutor move
	dbw 36, SLASH
	dbw 41, SCREECH
	dbw 43, THRASH
	dbw 48, AQUA_TAIL
	dbw 50, CLOSE_COMBAT ; Superpower → similar move
	dbw 56, HYDRO_PUMP
	db -1 ; no more level-up moves

.CroconawEvosAttacks
	evo_data EVOLVE_LEVEL, 30, FERALIGATR
	db -1 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, LEER
	dbw 6, WATER_GUN
	dbw 8, RAGE
	dbw 13, BITE
	dbw 15, SCARY_FACE
	dbw 21, METAL_CLAW ; Ice Fang → egg move
	dbw 24, REVERSAL ; Flail → similar move
	dbw 30, AGILITY ; Feraligatr move
	dbw 33, CRUNCH
	dbw 39, ANCIENTPOWER ; Chip Away → HGSS tutor move
	dbw 42, SLASH
	dbw 48, SCREECH
	dbw 51, THRASH
	dbw 57, AQUA_TAIL
	dbw 60, CLOSE_COMBAT ; Superpower → similar move
	dbw 66, HYDRO_PUMP
	db -1 ; no more level-up moves

.FeraligatrEvosAttacks
	db -1 ; no more evolutions
	dbw 1, NIGHT_SLASH ; evolution move
	dbw 1, SCRATCH
	dbw 1, LEER
	dbw 6, WATER_GUN
	dbw 8, RAGE
	dbw 13, BITE
	dbw 15, SCARY_FACE
	dbw 21, METAL_CLAW ; Ice Fang → egg move
	dbw 24, REVERSAL ; Flail → similar move
	dbw 32, AGILITY
	dbw 37, CRUNCH
	dbw 45, ANCIENTPOWER ; Chip Away → HGSS tutor move
	dbw 50, SLASH
	dbw 56, SCREECH
	dbw 62, THRASH
	dbw 68, OUTRAGE ; HGSS tutor move
	dbw 73, AQUA_TAIL
	dbw 78, CLOSE_COMBAT ; Superpower → similar move
	dbw 84, HYDRO_PUMP
	db -1 ; no more level-up moves

.SentretEvosAttacks
	evo_data EVOLVE_LEVEL, 15, FURRET
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, FORESIGHT
	dbw 4, DEFENSE_CURL
	dbw 7, QUICK_ATTACK
	dbw 13, FURY_STRIKES ; Fury Swipes → similar move
	dbw 16, DIZZY_PUNCH ; Helping Hand → event move
	dbw 19, SUPER_FANG ; Follow Me → HGSS tutor move
	dbw 25, HEADBUTT ; Slam → tutor move
	dbw 28, REST
	dbw 31, SUCKER_PUNCH
	dbw 36, AMNESIA
	dbw 39, BATON_PASS
	dbw 42, SLASH ; Me First → egg move
	dbw 47, HYPER_VOICE
	db -1 ; no more level-up moves

.FurretEvosAttacks
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, FORESIGHT
	dbw 1, AGILITY ; evolution move
	dbw 4, DEFENSE_CURL
	dbw 7, QUICK_ATTACK
	dbw 13, FURY_STRIKES ; Fury Swipes → similar move
	dbw 17, DIZZY_PUNCH ; Helping Hand → event move
	dbw 21, SUPER_FANG ; Follow Me → HGSS tutor move
	dbw 28, HEADBUTT ; Slam → tutor move
	dbw 32, REST
	dbw 36, SUCKER_PUNCH
	dbw 42, AMNESIA
	dbw 46, BATON_PASS
	dbw 50, SLASH ; Me First → egg move
	dbw 56, HYPER_VOICE
	db -1 ; no more level-up moves

.HoothootEvosAttacks
	evo_data EVOLVE_LEVEL, 20, NOCTOWL
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, GROWL
	dbw 1, FORESIGHT
	dbw 4, HYPNOSIS
	dbw 7, PECK
	dbw 10, CONFUSION
	dbw 13, NIGHT_SHADE ; Echoed Voice → event move
	dbw 16, ZEN_HEADBUTT
	dbw 19, HEX ; Psycho Shift → new move
	dbw 22, WING_ATTACK ; Extrasensory → egg move
	dbw 25, TAKE_DOWN
	dbw 28, REFLECT
	dbw 31, AIR_SLASH
	dbw 34, EXTRASENSORY ; Uproar → Extrasensory
	dbw 37, ROOST
	dbw 40, HYPER_VOICE ; Moonblast → tutor move
	dbw 43, MOONBLAST ; Synchronoise → Moonblast
	dbw 46, DREAM_EATER
	db -1 ; no more level-up moves

.NoctowlEvosAttacks
	db -1 ; no more evolutions
	dbw 1, DREAM_EATER
	dbw 1, TACKLE
	dbw 1, GROWL
	dbw 1, FORESIGHT
	dbw 4, HYPNOSIS
	dbw 7, PECK
	dbw 10, CONFUSION
	dbw 13, NIGHT_SHADE ; Echoed Voice → event move
	dbw 16, ZEN_HEADBUTT
	dbw 19, HEX ; Psycho Shift → new move
	dbw 23, WING_ATTACK ; Extrasensory → egg move
	dbw 27, TAKE_DOWN
	dbw 31, REFLECT
	dbw 35, AIR_SLASH
	dbw 39, EXTRASENSORY ; Uproar → Extrasensory
	dbw 43, ROOST
	dbw 47, HYPER_VOICE ; Moonblast → tutor move
	dbw 51, MOONBLAST ; Synchronoise → Moonblast
	dbw 55, DREAM_EATER
	db -1 ; no more level-up moves

.LedybaEvosAttacks
	evo_data EVOLVE_LEVEL, 18, LEDIAN
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 5, SUPERSONIC
	dbw 8, SWIFT
	dbw 12, LIGHT_SCREEN
	dbw 12, REFLECT
	dbw 12, SAFEGUARD
	dbw 15, MACH_PUNCH
	dbw 19, BARRIER ; Silver Wind → event move
	dbw 22, DIZZY_PUNCH ; Comet Punch → new move
	dbw 26, BATON_PASS
	dbw 29, AGILITY
	dbw 33, BUG_BUZZ
	dbw 36, AIR_SLASH
	dbw 40, DOUBLE_EDGE
	db -1 ; no more level-up moves

.LedianEvosAttacks
	db -1 ; no more evolutions
	dbw 1, SWORDS_DANCE ; evolution move
	dbw 1, TACKLE
	dbw 5, SUPERSONIC
	dbw 8, SWIFT
	dbw 12, LIGHT_SCREEN
	dbw 12, REFLECT
	dbw 12, SAFEGUARD
	dbw 15, MACH_PUNCH
	dbw 20, BARRIER ; Silver Wind → event move
	dbw 24, DIZZY_PUNCH ; Comet Punch → new move
	dbw 29, BATON_PASS
	dbw 33, AGILITY
	dbw 38, BUG_BUZZ
	dbw 42, AIR_SLASH
	dbw 47, DOUBLE_EDGE
	db -1 ; no more level-up moves

.SpinarakEvosAttacks
	evo_data EVOLVE_LEVEL, 22, ARIADOS
	db -1 ; no more evolutions
	dbw 1, POISON_STING
	dbw 1, STRING_SHOT
	dbw 1, WRAP ; Constrict → similar move
	dbw 5, ABSORB
	dbw 8, GLARE ; Infestation → new move
	dbw 12, SCARY_FACE
	dbw 15, NIGHT_SHADE
	dbw 19, GROWTH ; Shadow Sneak → event move
	dbw 22, FURY_STRIKES ; Fury Swipes → similar move
	dbw 26, SUCKER_PUNCH
	dbw 29, MEAN_LOOK ; Spider Web → similar move
	dbw 33, AGILITY
	dbw 36, PIN_MISSILE
	dbw 40, PSYCHIC_M
	dbw 43, POISON_JAB
	dbw 47, LEECH_LIFE ; Cross Poison → TM move
	dbw 50, FEINT_ATTACK ; Sticky Web → new move
	db -1 ; no more level-up moves

.AriadosEvosAttacks
	db -1 ; no more evolutions
	dbw 1, BUG_BITE ; evolution move
	dbw 1, FOCUS_ENERGY
	dbw 1, POISON_STING
	dbw 1, STRING_SHOT
	dbw 1, WRAP ; Constrict → similar move
	dbw 5, ABSORB
	dbw 8, GLARE ; Infestation → new move
	dbw 12, SCARY_FACE
	dbw 15, NIGHT_SHADE
	dbw 19, GROWTH ; Shadow Sneak → event move
	dbw 23, FURY_STRIKES ; Fury Swipes → similar move
	dbw 28, SUCKER_PUNCH
	dbw 32, MEAN_LOOK ; Spider Web → similar move
	dbw 37, AGILITY
	dbw 41, PIN_MISSILE
	dbw 46, PSYCHIC_M
	dbw 50, POISON_JAB
	dbw 55, LEECH_LIFE ; Cross Poison → TM move
	dbw 58, FEINT_ATTACK ; Sticky Web → new move
	db -1 ; no more level-up moves

.CrobatEvosAttacks
	db -1 ; no more evolutions
	dbw 1, X_SCISSOR ; evolution move
	dbw 1, SCREECH
	dbw 1, ABSORB
	dbw 1, CRUNCH ; LGPE move
	dbw 5, SUPERSONIC
	dbw 7, ASTONISH
	dbw 11, BITE
	dbw 13, GUST ; Wing Attack → egg move
	dbw 17, CONFUSE_RAY
	dbw 19, WING_ATTACK ; Air Cutter → Wing Attack
	dbw 24, SWIFT
	dbw 27, SUPER_FANG ; Poison Fang → HGSS tutor move
	dbw 32, MEAN_LOOK
	dbw 35, LEECH_LIFE
	dbw 40, HAZE
	dbw 43, VENOSHOCK
	dbw 48, AIR_SLASH
	dbw 51, CRUNCH ; Quick Guard → new move
	db -1 ; no more level-up moves

.ChinchouEvosAttacks
	evo_data EVOLVE_LEVEL, 27, LANTURN
	db -1 ; no more evolutions
	dbw 1, WATER_GUN ; Bubble → Water Gun
	dbw 1, SUPERSONIC
	dbw 6, THUNDER_WAVE
	dbw 9, THUNDERSHOCK ; Electro Ball → new move
	dbw 12, BUBBLE_BEAM ; Water Gun → Bubble Beam
	dbw 17, CONFUSE_RAY
	dbw 20, WATER_PULSE ; Bubble Beam → TM move
	dbw 23, SPARK
	dbw 28, PSYBEAM ; Signal Beam → egg move
	dbw 31, REVERSAL ; Flail → similar move
	dbw 34, THUNDERBOLT ; Discharge → TM move
	dbw 39, TAKE_DOWN
	dbw 42, RECOVER ; Aqua Ring → similar move
	dbw 45, ICE_BEAM ; Hydro Pump → TM move
	dbw 47, HYDRO_PUMP ; Ion Deluge → Hydro Pump
	dbw 50, LIGHT_SCREEN ; Charge → event move
	db -1 ; no more level-up moves

.LanturnEvosAttacks
	db -1 ; no more evolutions
	dbw 1, WATER_GUN ; Bubble → Water Gun
	dbw 1, SUPERSONIC
	dbw 6, THUNDER_WAVE
	dbw 9, THUNDERSHOCK ; Electro Ball → new move
	dbw 12, BUBBLE_BEAM ; Water Gun → Bubble Beam
	dbw 17, CONFUSE_RAY
	dbw 20, WATER_PULSE ; Bubble Beam → TM move
	dbw 23, SPARK
	dbw 29, PSYBEAM ; Signal Beam → egg move
	dbw 33, REVERSAL ; Flail → similar move
	dbw 37, THUNDERBOLT ; Discharge → TM move
	dbw 43, TAKE_DOWN
	dbw 47, RECOVER ; Aqua Ring → similar move
	dbw 51, ICE_BEAM ; Hydro Pump → TM move
	dbw 54, HYDRO_PUMP ; Ion Deluge → Hydro Pump
	dbw 58, LIGHT_SCREEN ; Charge → event move
	db -1 ; no more level-up moves

.PichuEvosAttacks
	evo_data EVOLVE_HAPPINESS, TR_ANYTIME, PIKACHU
	db -1 ; no more evolutions
	dbw 1, THUNDERSHOCK
	dbw 1, CHARM
	dbw 5, LEER ; Tail Whip → similar move
	dbw 10, SWEET_KISS
	dbw 13, NASTY_PLOT
	dbw 18, THUNDER_WAVE
	dbw 23, SCARY_FACE ; event move
	dbw 28, SING ; event move
	dbw 38, PETAL_DANCE ; event move
	db -1 ; no more level-up moves

.CleffaEvosAttacks
	evo_data EVOLVE_HAPPINESS, TR_ANYTIME, CLEFAIRY
	db -1 ; no more evolutions
	dbw 1, SPLASH
	dbw 1, TACKLE ; Pound → similar move
	dbw 1, METRONOME ; Copycat → egg move
	dbw 4, SING
	dbw 8, SWEET_KISS
	dbw 12, DISARM_VOICE
	dbw 16, ENCORE
	dbw 20, CHARM
	db -1 ; no more level-up moves

.IgglybuffEvosAttacks
	evo_data EVOLVE_HAPPINESS, TR_ANYTIME, JIGGLYPUFF
	db -1 ; no more evolutions
	dbw 1, SING
	dbw 1, TACKLE ; Pound → similar move
	dbw 1, DEFENSE_CURL ; Copycat → Defense Curl
	dbw 4, ROLLOUT ; Defense Curl → tutor move
	dbw 8, SWEET_KISS
	dbw 12, DISARM_VOICE
	dbw 16, DISABLE
	dbw 20, CHARM
	db -1 ; no more level-up moves

.TogepiEvosAttacks
	evo_data EVOLVE_HAPPINESS, TR_ANYTIME, TOGETIC
	db -1 ; no more evolutions
	dbw 1, GROWL
	dbw 1, CHARM
	dbw 5, METRONOME
	dbw 9, SWEET_KISS
	dbw 13, SING ; Yawn → similar move
	dbw 17, ENCORE
	dbw 21, DIZZY_PUNCH ; Follow Me → new move
	dbw 25, HEAL_BELL ; Bestow → HGSS tutor move
	dbw 29, FRESH_SNACK ; Wish → new move
	dbw 33, ANCIENTPOWER
	dbw 37, SAFEGUARD
	dbw 41, BATON_PASS
	dbw 45, DOUBLE_EDGE
	dbw 49, EXTRASENSORY ; Last Resort → egg move
	dbw 53, PLAY_ROUGH ; After You → Sw/Sh move
	db -1 ; no more level-up moves

.TogeticEvosAttacks
	evo_data EVOLVE_ITEM, SHINY_STONE, TOGEKISS
	db -1 ; no more evolutions
	dbw 1, GROWL
	dbw 1, CHARM
	dbw 1, DISARM_VOICE ; evolution move
	dbw 5, METRONOME
	dbw 9, SWEET_KISS
	dbw 13, SING ; Yawn → similar move
	dbw 17, ENCORE
	dbw 21, DIZZY_PUNCH ; Follow Me → new move
	dbw 25, HEAL_BELL ; Bestow → HGSS tutor move
	dbw 29, FRESH_SNACK ; Wish → new move
	dbw 33, ANCIENTPOWER
	dbw 37, SAFEGUARD
	dbw 41, BATON_PASS
	dbw 45, DOUBLE_EDGE
	dbw 49, EXTRASENSORY ; Last Resort → egg move
	dbw 53, PLAY_ROUGH ; After You → Sw/Sh move
	db -1 ; no more level-up moves

.NatuEvosAttacks
	evo_data EVOLVE_LEVEL, 25, XATU
	db -1 ; no more evolutions
	dbw 1, PECK
	dbw 1, LEER
	dbw 6, NIGHT_SHADE
	dbw 9, TELEPORT
	dbw 12, SAFEGUARD ; Lucky Chant → event move
	dbw 17, HYPNOSIS ; Stored Power → new move
	dbw 20, PAIN_SPLIT ; Ominous Wind → HGSS tutor move
	dbw 23, CONFUSE_RAY
	dbw 28, RECOVER ; Wish → similar move
	dbw 33, PSYCHIC_M
	dbw 36, ROOST ; Miracle Eye → egg move
	dbw 39, HAZE ; Psycho Shift → egg move
	dbw 44, FUTURE_SIGHT
	dbw 47, HEX ; Power Swap + Guard Swap → new move
	dbw 50, SUCKER_PUNCH ; Me First → HGSS tutor move
	db -1 ; no more level-up moves

.XatuEvosAttacks
	db -1 ; no more evolutions
	dbw 1, AIR_SLASH ; evolution move
	dbw 1, PECK
	dbw 1, LEER
	dbw 6, NIGHT_SHADE
	dbw 9, TELEPORT
	dbw 12, SAFEGUARD ; Lucky Chant → event move
	dbw 17, HYPNOSIS ; Stored Power → new move
	dbw 20, PAIN_SPLIT ; Ominous Wind → HGSS tutor move
	dbw 23, CONFUSE_RAY
	dbw 29, RECOVER ; Wish → similar move
	dbw 35, PSYCHIC_M
	dbw 39, ROOST ; Miracle Eye → egg move
	dbw 43, HAZE ; Psycho Shift → egg move
	dbw 49, FUTURE_SIGHT
	dbw 53, HEX ; Power Swap + Guard Swap → new move
	dbw 57, SUCKER_PUNCH ; Me First → HGSS tutor move
	db -1 ; no more level-up moves

.MareepEvosAttacks
	evo_data EVOLVE_LEVEL, 15, FLAAFFY
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, GROWL
	dbw 4, THUNDER_WAVE
	dbw 8, THUNDERSHOCK
	dbw 11, MUD_SLAP ; Cotton Spore → GSC TM move
	dbw 15, SPARK ; Charge → new move
	dbw 18, HEAL_BELL ; Take Down → HGSS tutor move
	dbw 22, TAKE_DOWN ; Electro Ball → Take Down
	dbw 25, CONFUSE_RAY
	dbw 29, POWER_GEM
	dbw 32, THUNDERBOLT ; Discharge → TM move
	dbw 36, SAFEGUARD ; Cotton Guard → egg move
	dbw 39, DAZZLINGLEAM ; Signal Beam → new move
	dbw 43, LIGHT_SCREEN
	dbw 46, THUNDER
	db -1 ; no more level-up moves

.FlaaffyEvosAttacks
if DEF(FAITHFUL)
	evo_data EVOLVE_LEVEL, 30, AMPHAROS
else
	evo_data EVOLVE_LEVEL, 36, AMPHAROS
endc
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, GROWL
	dbw 4, THUNDER_WAVE
	dbw 8, THUNDERSHOCK
	dbw 11, MUD_SLAP ; Cotton Spore → GSC TM move
	dbw 16, SPARK ; Charge → new move
	dbw 20, HEAL_BELL ; Take Down → HGSS tutor move
	dbw 25, TAKE_DOWN ; Electro Ball → Take Down
	dbw 29, CONFUSE_RAY
	dbw 34, POWER_GEM
	dbw 38, THUNDERBOLT ; Discharge → TM move
	dbw 43, SAFEGUARD ; Cotton Guard → egg move
	dbw 47, DAZZLINGLEAM ; Signal Beam → new move
	dbw 52, LIGHT_SCREEN
	dbw 56, THUNDER
	db -1 ; no more level-up moves

.AmpharosEvosAttacks
	db -1 ; no more evolutions
	dbw 1, THUNDERPUNCH ; evolution move
	dbw 1, FIRE_PUNCH
	dbw 1, DRAGON_PULSE
	dbw 1, TACKLE
	dbw 1, GROWL
	dbw 4, THUNDER_WAVE
	dbw 8, THUNDERSHOCK
	dbw 11, MUD_SLAP ; Cotton Spore → GSC TM move
	dbw 16, SPARK ; Charge → new move
	dbw 20, HEAL_BELL ; Take Down → HGSS tutor move
	dbw 25, TAKE_DOWN ; Electro Ball → Take Down
	dbw 29, CONFUSE_RAY
	dbw 35, POWER_GEM
	dbw 40, THUNDERBOLT ; Discharge → TM move
	dbw 46, SAFEGUARD ; Cotton Guard → egg move
	dbw 51, DAZZLINGLEAM ; Signal Beam → new move
	dbw 57, LIGHT_SCREEN
	dbw 62, THUNDER
	dbw 65, DRAGON_PULSE
	dbw 71, OUTRAGE ; HGSS tutor move
	db -1 ; no more level-up moves

.BellossomEvosAttacks
	db -1 ; no more evolutions
	dbw 1, MEGA_DRAIN
	dbw 1, HEAL_BELL ; new move
	dbw 1, SUNNY_DAY
	dbw 1, STUN_SPORE
	dbw 39, GROWTH ; Quiver Dance → Growth
	dbw 49, MOONBLAST ; Petal Blizzard → Gloom move
	dbw 59, PETAL_DANCE ; evolution move
	dbw 69, PLAY_ROUGH ; Leaf Storm → Sw/Sh move
	db -1 ; no more level-up moves

.MarillEvosAttacks
	evo_data EVOLVE_LEVEL, 18, AZUMARILL
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 2, GROWL ; Tail Whip → new move
	dbw 5, FORESIGHT ; Water Sport → egg move
	dbw 7, AQUA_JET ; Bubble → egg move
	dbw 10, DEFENSE_CURL
	dbw 10, ROLLOUT
	dbw 13, BUBBLE_BEAM
	dbw 16, DIZZY_PUNCH ; Helping Hand → event move
	dbw 20, AQUA_TAIL
	dbw 23, PLAY_ROUGH
	dbw 28, SCARY_FACE ; Aqua Ring → event move
	dbw 31, RAIN_DANCE
	dbw 37, DOUBLE_EDGE
	dbw 40, CLOSE_COMBAT ; Superpower → similar move
	dbw 47, HYDRO_PUMP
	db -1 ; no more level-up moves

.AzumarillEvosAttacks
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 2, GROWL ; Tail Whip → new move
	dbw 5, FORESIGHT ; Water Sport → egg move
	dbw 7, AQUA_JET ; Bubble → egg move
	dbw 10, DEFENSE_CURL
	dbw 10, ROLLOUT
	dbw 13, BUBBLE_BEAM
	dbw 16, DIZZY_PUNCH ; Helping Hand → event move
	dbw 21, AQUA_TAIL
	dbw 25, PLAY_ROUGH
	dbw 31, SCARY_FACE ; Aqua Ring → event move
	dbw 35, RAIN_DANCE
	dbw 42, DOUBLE_EDGE
	dbw 46, CLOSE_COMBAT ; Superpower → similar move
	dbw 55, HYDRO_PUMP
	db -1 ; no more level-up moves

.SudowoodoEvosAttacks
	db -1 ; no more evolutions
	dbw 1, SUBSTITUTE ; Copycat → event move
	dbw 5, REVERSAL ; Flail → similar move
	dbw 8, LOW_KICK
	dbw 12, LEER ; Rock Throw → new move
	dbw 15, ROCK_THROW ; Mimic → Rock Throw
	dbw 19, FEINT_ATTACK
	dbw 22, ANCIENTPOWER ; Rock Tomb → new move
	dbw 26, SPIKES ; Block → SV TM move
	dbw 29, ROCK_SLIDE
	dbw 33, COUNTER
	dbw 36, SUCKER_PUNCH
	dbw 40, DOUBLE_EDGE
	dbw 43, STONE_EDGE ; evolution move
	dbw 47, CLOSE_COMBAT ; Hammer Arm → similar move
	dbw 50, IRON_HEAD ; Head Smash → tutor move
	db -1 ; no more level-up moves

.PolitoedEvosAttacks
	db -1 ; no more evolutions
	dbw 1, GIGA_DRAIN ; Bounce → TM move ; evolution move
	dbw 1, BUBBLE_BEAM
	dbw 1, HYPNOSIS
	dbw 1, DOUBLE_SLAP
	dbw 1, PERISH_SONG
	dbw 27, SWAGGER
	dbw 48, HYPER_VOICE
	db -1 ; no more level-up moves

.HoppipEvosAttacks
	evo_data EVOLVE_LEVEL, 18, SKIPLOOM
	db -1 ; no more evolutions
	dbw 1, ABSORB
	dbw 1, SPLASH
	dbw 4, HEALINGLIGHT ; Synthesis → similar move
	dbw 6, DEFENSE_CURL; Tail Whip → tutor move
	dbw 8, TACKLE
	dbw 10, CONFUSION ; Fairy Wind → egg move
	dbw 12, POISONPOWDER
	dbw 14, STUN_SPORE
	dbw 16, SLEEP_POWDER
	dbw 19, HEADBUTT ; Bullet Seed → tutor move
	dbw 22, LEECH_SEED
	dbw 25, MEGA_DRAIN
	dbw 28, ACROBATICS
	dbw 31, ENCORE ; Rage Powder → egg move
	dbw 34, AGILITY ; Cotton Spore → GSC event move
	dbw 37, U_TURN
	dbw 40, AMNESIA ; Worry Seed → egg move
	dbw 43, GIGA_DRAIN
	dbw 46, DAZZLINGLEAM ; Bounce → TM move
	dbw 49, ENERGY_BALL ; Memento → TM move
	db -1 ; no more level-up moves

.SkiploomEvosAttacks
	evo_data EVOLVE_LEVEL, 27, JUMPLUFF
	db -1 ; no more evolutions
	dbw 1, ABSORB
	dbw 1, SPLASH
	dbw 4, HEALINGLIGHT ; Synthesis → similar move
	dbw 6, DEFENSE_CURL; Tail Whip → tutor move
	dbw 8, TACKLE
	dbw 10, CONFUSION ; Fairy Wind → egg move
	dbw 12, POISONPOWDER
	dbw 14, STUN_SPORE
	dbw 16, SLEEP_POWDER
	dbw 20, HEADBUTT ; Bullet Seed → tutor move
	dbw 24, LEECH_SEED
	dbw 28, MEGA_DRAIN
	dbw 32, ACROBATICS
	dbw 36, ENCORE ; Rage Powder → egg move
	dbw 40, AGILITY ; Cotton Spore → GSC event move
	dbw 44, U_TURN
	dbw 48, AMNESIA ; Worry Seed → egg move
	dbw 52, GIGA_DRAIN
	dbw 56, DAZZLINGLEAM ; Bounce → TM move
	dbw 60, ENERGY_BALL ; Memento → TM move
	db -1 ; no more level-up moves

.JumpluffEvosAttacks
	db -1 ; no more evolutions
	dbw 1, ABSORB
	dbw 1, SPLASH
	dbw 4, HEALINGLIGHT ; Synthesis → similar move
	dbw 6, DEFENSE_CURL; Tail Whip → tutor move
	dbw 8, TACKLE
	dbw 10, CONFUSION ; Fairy Wind → egg move
	dbw 12, POISONPOWDER
	dbw 14, STUN_SPORE
	dbw 16, SLEEP_POWDER
	dbw 20, HEADBUTT ; Bullet Seed → tutor move
	dbw 24, LEECH_SEED
	dbw 29, MEGA_DRAIN
	dbw 34, ACROBATICS
	dbw 39, ENCORE ; Rage Powder → egg move
	dbw 44, AGILITY ; Cotton Spore → GSC event move
	dbw 49, U_TURN
	dbw 54, AMNESIA ; Worry Seed → egg move
	dbw 59, GIGA_DRAIN
	dbw 64, DAZZLINGLEAM ; Bounce → TM move
	dbw 69, ENERGY_BALL ; nice, Memento → TM move
	db -1 ; no more level-up moves

.AipomEvosAttacks
	evo_data EVOLVE_MOVE, DOUBLE_SLAP, AMBIPOM
	db -1 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, LEER ; Tail Whip → similar move
	dbw 4, MUD_SLAP ; Sand Attack → similar move
	dbw 8, ASTONISH
	dbw 11, BATON_PASS
	dbw 15, THIEF ; Tickle → TM move
	dbw 18, FURY_STRIKES ; Fury Swipes → similar move
	dbw 22, SWIFT
	dbw 25, SCREECH
	dbw 29, AGILITY
	dbw 32, DOUBLE_SLAP ; Double Hit → egg move
	dbw 36, ACROBATICS ; Fling → TM move
	dbw 39, NASTY_PLOT
	dbw 43, DOUBLE_EDGE ; Last Resort → tutor move
	db -1 ; no more level-up moves

.SunkernEvosAttacks
	evo_data EVOLVE_ITEM, SUN_STONE, SUNFLORA
	db -1 ; no more evolutions
	dbw 1, SPLASH ; Growth → Hoppip move
	dbw 1, ABSORB
	dbw 4, GROWTH ; Ingrain → Growth
	dbw 7, DEFENSE_CURL ; Grass Whistle → TM move
	dbw 10, MEGA_DRAIN
	dbw 13, LEECH_SEED
	dbw 16, RAZOR_LEAF
	dbw 19, PROTECT ; Worry Seed → TM move
	dbw 22, GIGA_DRAIN
	dbw 25, AGILITY ; Endeavor → new move
	dbw 28, HEALINGLIGHT ; Synthesis → similar move
	dbw 31, EARTH_POWER ; Natural Gift → tutor move
	dbw 34, SOLAR_BEAM
	dbw 37, DOUBLE_EDGE
	dbw 40, SUNNY_DAY
	dbw 43, SEED_BOMB
	db -1 ; no more level-up moves

.SunfloraEvosAttacks
	db -1 ; no more evolutions
	dbw 1, SPLASH ; Growth → Hoppip move
	dbw 1, TACKLE ; Pound → similar move
	dbw 1, ABSORB
if !DEF(FAITHFUL)
	dbw 1, EMBER ; evolution move
endc
	dbw 4, GROWTH ; Ingrain → Growth
	dbw 7, DEFENSE_CURL ; Grass Whistle → TM move
	dbw 10, MEGA_DRAIN
	dbw 13, LEECH_SEED
	dbw 16, RAZOR_LEAF
	dbw 19, PROTECT ; Worry Seed → TM move
	dbw 22, GIGA_DRAIN
	dbw 25, AGILITY ; Bullet Seed → TM move
	dbw 28, PETAL_DANCE
if DEF(FAITHFUL)
	dbw 31, EARTH_POWER ; Natural Gift → tutor move
else
	dbw 31, FLAMETHROWER ; Natural Gift → TM move
endc
	dbw 34, SOLAR_BEAM
	dbw 37, DOUBLE_EDGE
	dbw 40, SUNNY_DAY
	dbw 43, SEED_BOMB ; Leaf Storm → Sunkern move
if !DEF(FAITHFUL)
	dbw 50, FIRE_BLAST ; Petal Blizzard → TM move
endc
	db -1 ; no more level-up moves

.YanmaEvosAttacks
	evo_data EVOLVE_MOVE, ANCIENTPOWER, YANMEGA
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, FORESIGHT
	dbw 1, BUG_BITE
	dbw 6, QUICK_ATTACK
	dbw 11, DOUBLE_TEAM
	dbw 14, SONIC_BOOM
	dbw 17, PROTECT ; Detect → similar move
	dbw 22, DRAGON_RAGE ; Supersonic → new move
	dbw 27, SUPERSONIC ; Uproar → Supersonic
	dbw 30, PURSUIT
if DEF(FAITHFUL)
	dbw 33, ANCIENTPOWER
else
	dbw 35, ANCIENTPOWER
endc
	dbw 38, HYPNOSIS
	dbw 43, WING_ATTACK
	dbw 46, SCREECH
	dbw 49, U_TURN
	dbw 54, AIR_SLASH
	dbw 57, BUG_BUZZ
	dbw 62, DREAM_EATER ; event move
	db -1 ; no more level-up moves

.WooperPlainEvosAttacks
	evo_data EVOLVE_LEVEL, 20, QUAGSIRE
	db -1 ; no more evolutions
	dbw 1, WATER_GUN
	dbw 1, LEER ; Tail Whip → similar move
	dbw 5, MUD_SLAP ; Mud Sport → TM move
	dbw 9, SCARY_FACE ; Mud Shot → event move
	dbw 15, HEADBUTT ; Slam → tutor move
	dbw 19, RECOVER ; Mud Bomb → egg move
	dbw 23, AMNESIA
	dbw 29, BELLY_DRUM ; Yawn → event move
	dbw 33, EARTHQUAKE
	dbw 37, RAIN_DANCE
	dbw 43, HAZE
	dbw 47, AQUA_TAIL ; Muddy Water → event move
	db -1 ; no more level-up moves

.QuagsireEvosAttacks
	db -1 ; no more evolutions
	dbw 1, ANCIENTPOWER ; evolution move
	dbw 1, WATER_GUN
	dbw 1, LEER ; Tail Whip → similar move
	dbw 5, MUD_SLAP ; Mud Sport → TM move
	dbw 9, SCARY_FACE ; Mud Shot → event move
	dbw 15, HEADBUTT ; Slam → tutor move
	dbw 19, RECOVER ; Mud Bomb → egg move
	dbw 24, AMNESIA
	dbw 31, BELLY_DRUM ; Yawn → event move
	dbw 36, EARTHQUAKE
	dbw 41, RAIN_DANCE
	dbw 48, HAZE
	dbw 53, AQUA_TAIL ; Muddy Water → event move
	db -1 ; no more level-up moves

.EspeonEvosAttacks
	db -1 ; no more evolutions
	dbw 1, GROWL
	dbw 1, TACKLE
	dbw 1, LEER ; Tail Whip → similar move
	dbw 1, CONFUSION ; evolution move
	dbw 5, MUD_SLAP ; Sand Attack → similar move
	dbw 9, DOUBLE_KICK ; Baby-Doll Eyes → LGPE move
	dbw 13, QUICK_ATTACK
	dbw 17, SWIFT
	dbw 20, PSYBEAM
	dbw 25, FUTURE_SIGHT
	dbw 29, REFLECT ; Psych Up → event move
	dbw 33, HEALINGLIGHT ; Morning Sun → similar move
	dbw 37, PSYCHIC_M
	dbw 41, DOUBLE_EDGE ; Last Resort → tutor move
	dbw 45, POWER_GEM ; Power Swap → SV TM move
	db -1 ; no more level-up moves

.UmbreonEvosAttacks
	db -1 ; no more evolutions
	dbw 1, GROWL
	dbw 1, TACKLE
	dbw 1, LEER ; Tail Whip → similar move
	dbw 1, PURSUIT ; evolution move
	dbw 5, MUD_SLAP ; Sand Attack → similar move
	dbw 9, DOUBLE_KICK ; Baby-Doll Eyes → LGPE move
	dbw 13, QUICK_ATTACK
	dbw 17, CONFUSE_RAY
	dbw 20, FEINT_ATTACK
	dbw 25, TOXIC ; Assurance → TM move
	dbw 29, SCREECH
	dbw 33, HEALINGLIGHT ; Moonlight → similar move
	dbw 37, SUCKER_PUNCH ; Mean Look → tutor move
	dbw 41, DOUBLE_EDGE ; Last Resort → tutor move
	dbw 45, MEAN_LOOK ; Guard Swap → Mean Look
	db -1 ; no more level-up moves

.MurkrowEvosAttacks
	evo_data EVOLVE_ITEM, DUSK_STONE, HONCHKROW
	db -1 ; no more evolutions
	dbw 1, PECK
	dbw 1, ASTONISH
	dbw 5, PURSUIT
	dbw 11, HAZE
	dbw 15, WING_ATTACK
	dbw 21, NIGHT_SHADE
	dbw 25, THIEF ; Assurance → TM move
	dbw 31, SWAGGER ; Taunt → TM move
	dbw 35, FEINT_ATTACK
	dbw 41, MEAN_LOOK
	dbw 45, BATON_PASS ; Foul Play → XD move
	dbw 50, DRILL_PECK ; Tailwind → egg move
	dbw 55, SUCKER_PUNCH
	dbw 61, PERISH_SONG ; Torment → egg move
	dbw 65, BRAVE_BIRD ; Quash → egg move
	db -1 ; no more level-up moves

.SlowkingPlainEvosAttacks
	db -1 ; no more evolutions
	dbw 1, POWER_GEM
	dbw 1, HIDDEN_POWER
	dbw 1, CURSE
	dbw 1, TACKLE
	dbw 5, GROWL
	dbw 9, WATER_GUN
	dbw 14, CONFUSION
	dbw 19, DISABLE
	dbw 23, HEADBUTT
	dbw 28, WATER_PULSE
	dbw 32, ZEN_HEADBUTT
	dbw 36, NASTY_PLOT
	dbw 41, SWAGGER
	dbw 45, PSYCHIC_M
	dbw 49, RAIN_DANCE ; Trump Card → TM move
	dbw 54, BELLY_DRUM ; Psych Up → egg move
	dbw 58, RECOVER ; Heal Pulse → similar move
	db -1 ; no more level-up moves

.MisdreavusEvosAttacks
	evo_data EVOLVE_ITEM, DUSK_STONE, MISMAGIUS
	db -1 ; no more evolutions
	dbw 1, GROWL
	dbw 1, TELEPORT ; Psywave → new move
	dbw 1, DISARM_VOICE ; new move
	dbw 5, CONFUSION ; Spite → new move
	dbw 10, ASTONISH
	dbw 14, CONFUSE_RAY
	dbw 19, MEAN_LOOK
	dbw 23, HEX
	dbw 28, PSYBEAM
	dbw 32, PAIN_SPLIT
	dbw 37, DESTINY_BOND ; Payback → egg move
	dbw 41, SHADOW_BALL
	dbw 46, PERISH_SONG
	dbw 50, DAZZLINGLEAM ; Grudge → TM move
	dbw 55, POWER_GEM
	dbw 62, NASTY_PLOT ; egg move
	db -1 ; no more level-up moves

.UnownEvosAttacks
	db -1 ; no more evolutions
	dbw 1, HIDDEN_POWER
	db -1 ; no more level-up moves

.WobbuffetEvosAttacks
	db -1 ; no more evolutions
	dbw 1, SPLASH
	dbw 1, CHARM
	dbw 1, ENCORE
	dbw 1, AMNESIA
	dbw 1, RECOVER ; evolve move
	dbw 1, COUNTER
	dbw 1, MIRROR_COAT
	dbw 1, SAFEGUARD
	dbw 1, DESTINY_BOND
	db -1 ; no more level-up moves

.GirafarigEvosAttacks
	evo_data EVOLVE_MOVE, ZEN_HEADBUTT, FARIGIRAF
	db -1 ; no more evolutions
	dbw 1, ASTONISH
	dbw 1, TACKLE
	dbw 1, GROWL
	dbw 1, CONFUSION
	dbw 5, FORESIGHT ; Odor Sleuth → egg move
	dbw 10, PURSUIT ; Assurance → new move
	dbw 14, STOMP
	dbw 19, PSYBEAM
	dbw 23, AGILITY
	dbw 28, DOUBLE_KICK ; Double Hit → egg move
	dbw 32, ZEN_HEADBUTT
	dbw 37, CRUNCH
	dbw 41, BATON_PASS
	dbw 46, NASTY_PLOT
	dbw 50, PSYCHIC_M
if !DEF(FAITHFUL)
	dbw 55, DARK_PULSE ; new move
endc
	db -1 ; no more level-up moves

.PinecoEvosAttacks
	evo_data EVOLVE_LEVEL, 31, FORRETRESS
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, PROTECT
	dbw 6, FOCUS_ENERGY ; Self-Destruct → TCG move
	dbw 9, BUG_BITE
	dbw 12, SUBSTITUTE ; Take Down → event move
	dbw 17, RAPID_SPIN
	dbw 20, DEFENSE_CURL ; Bide → TM move
	dbw 23, TAKE_DOWN ; Natural Gift → Take Down
	dbw 28, SPIKES
	dbw 31, REVERSAL ; Payback → new move
	dbw 34, EXPLOSION
	dbw 39, REFLECT ; Iron Defense → egg move
	dbw 42, GYRO_BALL
	dbw 45, DOUBLE_EDGE
	db -1 ; no more level-up moves

.ForretressEvosAttacks
	db -1 ; no more evolutions
	dbw 1, FLASH_CANNON ; Mirror Shot → TM move ; evolution move
	dbw 1, AGILITY ; Autotomize → similar move
	dbw 1, TOXIC_SPIKES
	dbw 1, TACKLE
	dbw 1, PROTECT
	dbw 6, FOCUS_ENERGY ; Self-Destruct → TCG move
	dbw 9, BUG_BITE
	dbw 12, SUBSTITUTE ; Take Down → event move
	dbw 17, RAPID_SPIN
	dbw 20, DEFENSE_CURL ; Bide → TM move
	dbw 23, TAKE_DOWN ; Natural Gift → Take Down
	dbw 28, SPIKES
	dbw 32, REVERSAL ; Payback → new move
	dbw 36, EXPLOSION
	dbw 42, REFLECT ; Iron Defense → egg move
	dbw 46, GYRO_BALL
	dbw 50, DOUBLE_EDGE
	dbw 56, ZAP_CANNON
	dbw 60, IRON_HEAD ; Heavy Slam → new move
	db -1 ; no more level-up moves

.DunsparceEvosAttacks
	evo_data EVOLVE_LEVEL, 32, DUDUNSPARCE, NO_FORM ; preserve pre-evo form
	db -1 ; no more evolutions
	dbw 1, RAGE
	dbw 1, DEFENSE_CURL
	dbw 3, ROLLOUT
	dbw 6, ASTONISH ; Spite → egg move
	dbw 8, PURSUIT
	dbw 11, SCREECH
	dbw 13, MUD_SLAP
	dbw 16, FURY_STRIKES ; Yawn → event move (Fury Attack)
	dbw 18, ANCIENTPOWER
	dbw 21, BODY_SLAM
	dbw 23, DRAGON_RAGE ; Drill Run → new move
	dbw 26, ROOST
	dbw 28, TAKE_DOWN
	dbw 31, DRAGON_DANCE ; Coil → new move
	dbw 33, DIG
	dbw 36, GLARE
	dbw 38, DOUBLE_EDGE
	dbw 41, EARTHQUAKE ; Endeavor → TM move
	dbw 43, AIR_SLASH
	dbw 46, HEX ; Dragon Rush → egg move
	dbw 48, ENDURE
	dbw 51, REVERSAL ; Flail → similar move
	dbw 53, OUTRAGE ; new move
	db -1 ; no more level-up moves

.GligarEvosAttacks
	evo_data EVOLVE_HOLDING, RAZOR_FANG, TR_EVENITE, GLISCOR
	db -1 ; no more evolutions
	dbw 1, POISON_STING
	dbw 4, MUD_SLAP ; Sand Attack → similar move
	dbw 7, DEFENSE_CURL ; Harden → similar move
	dbw 10, QUICK_ATTACK ; Knock Off → Quick Attack
	dbw 13, WING_ATTACK ; Quick Attack → egg move
	dbw 16, BUG_BITE ; Fury Cutter → similar move
	dbw 19, FEINT_ATTACK
	dbw 22, ACROBATICS
	dbw 27, SLASH
	dbw 30, U_TURN
	dbw 35, SCREECH
	dbw 40, X_SCISSOR
	dbw 45, KNOCK_OFF ; Sky Uppercut → Knock Off
	dbw 50, SWORDS_DANCE
	dbw 55, NIGHT_SLASH ; Guillotine → egg move
	db -1 ; no more level-up moves

.SteelixEvosAttacks
	db -1 ; no more evolutions
	dbw 1, IRON_TAIL ; evolution move
	dbw 1, TACKLE
	dbw 1, DEFENSE_CURL ; Harden → similar move
	dbw 1, WRAP ; Bind → similar move
	dbw 4, CURSE
	dbw 7, ROCK_THROW
	dbw 10, RAGE
	dbw 13, ROCK_BLAST ; Rock Tomb → egg move
	dbw 16, BODY_SLAM ; Stealth Rock → TM move
	dbw 19, SANDSTORM ; Autotomize → Sandstorm
	dbw 22, ANCIENTPOWER ; Smack Down → HGSS tutor move
	dbw 25, DRAGONBREATH
	dbw 28, HEADBUTT ; Slam → tutor move
	dbw 31, SCREECH
	dbw 34, ROCK_SLIDE
	dbw 37, CRUNCH
	dbw 40, IRON_HEAD
	dbw 43, DIG
	dbw 46, STONE_EDGE
	dbw 49, DOUBLE_EDGE
	dbw 52, EARTHQUAKE ; Sandstorm → TM move
	db -1 ; no more level-up moves

.SnubbullEvosAttacks
	evo_data EVOLVE_LEVEL, 23, GRANBULL
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, SCARY_FACE
	dbw 1, LEER ; Tail Whip → similar move
	dbw 1, CHARM
	dbw 7, BITE
	dbw 13, LICK
	dbw 19, HEADBUTT
	dbw 25, ROAR
	dbw 31, RAGE
	dbw 37, PLAY_ROUGH
	dbw 43, DOUBLE_EDGE ; Payback → event move
	dbw 49, CRUNCH
	db -1 ; no more level-up moves

.GranbullEvosAttacks
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, SCARY_FACE
	dbw 1, LEER ; Tail Whip → similar move
	dbw 1, CHARM
	dbw 7, BITE
	dbw 13, LICK
	dbw 19, HEADBUTT
	dbw 27, ROAR
	dbw 35, RAGE
	dbw 43, PLAY_ROUGH
	dbw 51, DOUBLE_EDGE ; Payback → event move
	dbw 59, CRUNCH
	dbw 67, OUTRAGE
	db -1 ; no more level-up moves

.QwilfishPlainEvosAttacks
	db -1 ; no more evolutions
	dbw 1, WATER_GUN
	dbw 1, SPIKES
	dbw 1, TACKLE
	dbw 1, POISON_STING
	dbw 5, DEFENSE_CURL ; Harden → TM move
	dbw 9, MINIMIZE
	dbw 13, BUBBLE_BEAM ; Bubble → similar move
	dbw 17, ROLLOUT
	dbw 21, TOXIC_SPIKES
	dbw 25, PAIN_SPLIT ; Stockpile + Spit Up → HGSS move tutor
	dbw 29, REVERSAL ; Revenge → Sw/Sh move
	dbw 33, WATER_PULSE ; Brine → TM move
	dbw 37, PIN_MISSILE
	dbw 41, TAKE_DOWN
	dbw 45, AQUA_TAIL
	dbw 49, POISON_JAB
	dbw 53, DESTINY_BOND
	dbw 57, HYDRO_PUMP
	dbw 60, DOUBLE_EDGE ; Fell Stinger → event move
	db -1 ; no more level-up moves

.ScizorEvosAttacks
	db -1 ; no more evolutions
	dbw 1, METAL_CLAW ; evolution move
	dbw 1, BULLET_PUNCH
	dbw 1, QUICK_ATTACK
	dbw 1, LEER
	dbw 5, FOCUS_ENERGY
	dbw 9, PURSUIT
	dbw 13, FALSE_SWIPE
	dbw 17, AGILITY
	dbw 21, WING_ATTACK
	dbw 25, BUG_BITE ; Fury Cutter → similar move
	dbw 29, SLASH
	dbw 33, BUG_BUZZ ; Razor Wind → egg move
	dbw 37, DEFENSE_CURL ; Iron Defense → similar move
	dbw 41, X_SCISSOR
	dbw 45, CRUNCH ; Night Slash → Prism tutor move
	dbw 49, CLOSE_COMBAT ; Double Hit → SV TM move
	dbw 50, IRON_HEAD
	dbw 57, SWORDS_DANCE
	db -1 ; no more level-up moves

.ShuckleEvosAttacks
	db -1 ; no more evolutions
	dbw 1, MUD_SLAP ; Constrict → GSC TM move
	dbw 1, DEFENSE_CURL ; Withdraw → similar move
	dbw 1, ROLLOUT
	dbw 5, ENCORE
	dbw 9, WRAP
	dbw 12, STRING_SHOT ; Struggle Bug → HGSS tutor move
	dbw 16, SAFEGUARD
	dbw 20, REST
	dbw 23, ROCK_THROW
	dbw 27, ACID ; Gastro Acid → egg move
	dbw 31, DISABLE ; Power Trick → new move
	dbw 34, SHELL_SMASH
	dbw 38, ROCK_BLAST ; Rock Slide → Sw/Sh move
	dbw 42, BUG_BITE
	dbw 45, ROCK_SLIDE ; Power Split + Guard Split → Rock Slide
	dbw 49, REVERSAL ; Stone Edge → Sw/Sh move
	dbw 53, STONE_EDGE ; Sticky Web → Stone Edge
	db -1 ; no more level-up moves

.HeracrossEvosAttacks
	db -1 ; no more evolutions
	dbw 1, NIGHT_SLASH
	dbw 1, TACKLE
	dbw 1, LEER
	dbw 1, HORN_ATTACK
	dbw 1, ENDURE
	dbw 7, BUG_BITE ; Feint → HGSS tutor move
	dbw 10, FURY_STRIKES ; Aerial Ace → Fury Strikes
	dbw 16, LOW_KICK ; Chip Away → HGSS tutor move
	dbw 19, COUNTER
	dbw 25, AERIAL_ACE ; Fury Attack → Aerial Ace
	dbw 28, SEISMIC_TOSS ; Brick Break → tutor move
	dbw 31, PIN_MISSILE
	dbw 34, TAKE_DOWN
	dbw 37, MEGAHORN
	dbw 43, CLOSE_COMBAT
	dbw 46, REVERSAL
	db -1 ; no more level-up moves

.SneaselPlainEvosAttacks
	evo_data EVOLVE_HOLDING, RAZOR_CLAW, TR_EVENITE, WEAVILE
	db -1 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, LEER
	dbw 1, BITE ; Taunt → egg move
	dbw 8, QUICK_ATTACK
	dbw 10, FEINT_ATTACK
	dbw 14, ICE_SHARD ; Icy Wind → Ice Shard
	dbw 16, FURY_STRIKES ; Fury Swipes → similar move
	dbw 20, AGILITY
	dbw 22, METAL_CLAW
	dbw 25, HONE_CLAWS
	dbw 28, ICICLE_CRASH ; Beat Up → egg move
	dbw 32, SCREECH
	dbw 35, SLASH
	dbw 40, HEALINGLIGHT ; Snatch → event move (Moonlight)
	dbw 44, X_SCISSOR ; Punishment → TM move
	dbw 47, CRUNCH ; Ice Shard → new move
	db -1 ; no more level-up moves

.TeddiursaEvosAttacks
	evo_data EVOLVE_LEVEL, 30, URSARING
	db -1 ; no more evolutions
	dbw 1, THIEF ; Covet → TM move
	dbw 1, SCRATCH
	dbw 1, GROWL ; Baby-Doll Eyes → similar move
	dbw 1, LICK
	dbw 1, FOCUS_ENERGY ; Fake Tears → egg move
	dbw 8, FURY_STRIKES ; Fury Swipes → similar move
	dbw 15, FEINT_ATTACK
	dbw 22, BELLY_DRUM ; Sweet Scent → egg move
	dbw 25, PLAY_ROUGH ; Play Nice → egg move
	dbw 29, SLASH
	dbw 36, CHARM
	dbw 43, REST
	dbw 43, CRUNCH ; Snore → egg move
	dbw 50, THRASH
	dbw 57, CLOSE_COMBAT ; Fling → new move
	dbw 64, DOUBLE_EDGE ; new move
	db -1 ; no more level-up moves

.UrsaringEvosAttacks
	evo_data EVOLVE_ITEM, MOON_STONE, URSALUNA
	evo_data EVOLVE_LOCATION, SINJOH_RUINS, URSALUNA
	evo_data EVOLVE_LOCATION, MYSTRI_STAGE, URSALUNA
	evo_data EVOLVE_LOCATION, MURKY_SWAMP, URSALUNA, URSALUNA_BLOODMOON_FORM
	db -1 ; no more evolutions
	dbw 1, GUNK_SHOT ; HGSS tutor move
	dbw 1, THIEF ; Covet → TM move
	dbw 1, SCRATCH
	dbw 1, LEER
	dbw 1, LICK
	dbw 1, FOCUS_ENERGY ; Fake Tears → egg move
	dbw 8, FURY_STRIKES ; Fury Swipes → similar move
	dbw 15, FEINT_ATTACK
	dbw 22, BELLY_DRUM ; Sweet Scent → egg move
	dbw 25, PLAY_ROUGH ; Play Nice → egg move
	dbw 29, SLASH
	dbw 38, SCARY_FACE
	dbw 47, REST
	dbw 49, CRUNCH ; Snore → egg move
	dbw 58, THRASH
	dbw 67, CLOSE_COMBAT ; Hammer Arm → new move
	dbw 76, DOUBLE_EDGE ; new move
	db -1 ; no more level-up moves

.SlugmaEvosAttacks
	evo_data EVOLVE_LEVEL, 38, MAGCARGO
	db -1 ; no more evolutions
	dbw 1, MUD_SLAP ; Smog → TM move
	dbw 6, EMBER
	dbw 8, ROCK_THROW
	dbw 13, DEFENSE_CURL ; Harden → similar move
	dbw 15, FIRE_SPIN ; Incinerate → new move
	dbw 20, SMOKESCREEN ; Clear Smog → egg move
	dbw 22, ANCIENTPOWER
	dbw 27, FLAME_CHARGE ; Flame Burst → TM move
	dbw 29, ROCK_SLIDE
	dbw 34, PAIN_SPLIT ; Lava Plume → HGSS tutor move
	dbw 36, AMNESIA
	dbw 41, BODY_SLAM
	dbw 43, RECOVER
	dbw 48, FLAMETHROWER
	dbw 50, EARTH_POWER
	db -1 ; no more level-up moves

.MagcargoEvosAttacks
	db -1 ; no more evolutions
	dbw 1, SHELL_SMASH ; evolution move
	dbw 1, MUD_SLAP ; Smog → TM move
	dbw 6, EMBER
	dbw 8, ROCK_THROW
	dbw 13, DEFENSE_CURL ; Harden → similar move
	dbw 15, FIRE_SPIN ; Incinerate → new move
	dbw 20, SMOKESCREEN ; Clear Smog → egg move
	dbw 22, ANCIENTPOWER
	dbw 27, FLAME_CHARGE ; Flame Burst → TM move
	dbw 29, ROCK_SLIDE
	dbw 34, PAIN_SPLIT ; Lava Plume → HGSS tutor move
	dbw 36, AMNESIA
	dbw 43, BODY_SLAM
	dbw 47, RECOVER
	dbw 54, FLAMETHROWER
	dbw 58, EARTH_POWER
	db -1 ; no more level-up moves

.SwinubEvosAttacks
	evo_data EVOLVE_LEVEL, 33, PILOSWINE
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, FORESIGHT ; Odor Sleuth → similar move
	dbw 5, BITE ; Mud Sport → egg move
	dbw 8, ICE_SHARD ; Powder Snow → Ice Shard
	dbw 11, MUD_SLAP
	dbw 14, ENDURE
	dbw 18, MAGNITUDE ; Mud Bomb → new move
	dbw 21, ICY_WIND
	dbw 24, ICICLE_CRASH ; Ice Shard → egg move
	dbw 28, TAKE_DOWN
	dbw 35, BULLDOZE ; Mist → TM move
	dbw 37, REVERSAL ; Earthquake → similar move
	dbw 40, EARTHQUAKE ; Flail → Earthquake
	dbw 44, BLIZZARD
	dbw 48, AMNESIA
	db -1 ; no more level-up moves

.PiloswineEvosAttacks
	evo_data EVOLVE_MOVE, ANCIENTPOWER, MAMOSWINE
	db -1 ; no more evolutions
	dbw 1, ANCIENTPOWER
	dbw 1, FURY_STRIKES ; evolution move (Fury Attack)
	dbw 1, PECK
	dbw 1, FORESIGHT ; Odor Sleuth → similar move
	dbw 5, BITE ; Mud Sport → egg move
	dbw 8, ICE_SHARD ; Powder Snow → Ice Shard
	dbw 11, MUD_SLAP
	dbw 14, ENDURE
	dbw 18, MAGNITUDE ; Mud Bomb → new move
	dbw 21, ICY_WIND
	dbw 24, ICICLE_CRASH ; Ice Fang → egg move
	dbw 28, TAKE_DOWN
	dbw 37, BULLDOZE ; Mist → TM move
	dbw 41, THRASH
	dbw 46, EARTHQUAKE
	dbw 52, BLIZZARD
	dbw 58, AMNESIA
	db -1 ; no more level-up moves

.CorsolaPlainEvosAttacks
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, DEFENSE_CURL ; Harden → similar move
	dbw 4, WATER_GUN ; Bubble → similar move
	dbw 8, ROLLOUT ; Recover → TM move
	dbw 10, BUBBLE_BEAM
	dbw 13, SAFEGUARD ; Refresh → egg move
	dbw 17, ANCIENTPOWER
	dbw 20, ICICLE_SPEAR ; Spike Cannon → egg move
	dbw 23, CONFUSE_RAY ; Lucky Chant → egg move
	dbw 27, ENDURE ; Brine → Endure
	dbw 29, BARRIER ; Iron Defense → similar move
	dbw 31, ROCK_BLAST
	dbw 35, RECOVER ; Endure → Recover
	dbw 38, HYDRO_PUMP ; Aqua Ring → Sw/Sh move
	dbw 41, POWER_GEM
	dbw 45, MIRROR_COAT
	dbw 47, EARTH_POWER
	dbw 50, REVERSAL ; Flail → similar move
	db -1 ; no more level-up moves

.RemoraidEvosAttacks
	evo_data EVOLVE_LEVEL, 25, OCTILLERY
	db -1 ; no more evolutions
	dbw 1, WRAP ; Sw/Sh move
	dbw 1, WATER_GUN
	dbw 6, FORESIGHT ; Lock-On → new move
	dbw 10, PSYBEAM
	dbw 14, AURORA_BEAM
	dbw 18, BUBBLE_BEAM
	dbw 22, FOCUS_ENERGY
	dbw 26, WATER_PULSE
	dbw 30, FLAMETHROWER ; Signal Beam → TM move
	dbw 34, ICE_BEAM
	dbw 38, SEED_BOMB ; Bullet Seed → tutor move
	dbw 42, GUNK_SHOT ; Hydro Pump → new move
	dbw 46, HYDRO_PUMP ; Hyper Beam → Hydro Pump
	dbw 50, AURA_SPHERE ; Soak → new move
	dbw 54, HYPER_BEAM
	db -1 ; no more level-up moves

.OctilleryEvosAttacks
	db -1 ; no more evolutions
	dbw 1, OCTAZOOKA ; evolution move
	dbw 1, ROCK_BLAST
	dbw 1, POWER_WHIP ; new move
	dbw 1, WATER_GUN
	dbw 6, FORESIGHT ; Constrict → new move
	dbw 10, PSYBEAM
	dbw 14, AURORA_BEAM
	dbw 18, BUBBLE_BEAM
	dbw 22, FOCUS_ENERGY
	dbw 26, WRAP ; Wring Out → new move
	dbw 28, WATER_PULSE
	dbw 34, FLAMETHROWER ; Signal Beam → TM move
	dbw 40, ICE_BEAM
	dbw 46, SEED_BOMB ; Bullet Seed → tutor move
	dbw 52, GUNK_SHOT ; Hydro Pump → new move
	dbw 58, HYDRO_PUMP ; Hyper Beam → Hydro Pump
if !DEF(FAITHFUL)
	dbw 58, FIRE_BLAST ; new move
endc
	dbw 64, AURA_SPHERE ; Soak → new move
	dbw 70, HYPER_BEAM
	db -1 ; no more level-up moves

.DelibirdEvosAttacks
	db -1 ; no more evolutions
; based on Gen V Chatot
	dbw 1, PECK
	dbw 5, GROWL
	dbw 9, PAY_DAY ; Mirror Move → new move
	dbw 13, SING
	dbw 17, ICY_WIND
	dbw 21, WING_ATTACK
	dbw 25, HAIL
	dbw 29, DRILL_PECK
	dbw 33, AURORA_BEAM
	dbw 37, BODY_SLAM
	dbw 41, ROOST
	dbw 45, FLY
	dbw 49, BELLY_DRUM
	dbw 53, HURRICANE
	dbw 57, BLIZZARD
	db -1 ; no more level-up moves

.MantineEvosAttacks
	db -1 ; no more evolutions
	dbw 1, GUST ; event move
	dbw 1, TACKLE
	dbw 1, WATER_GUN ; Bubble → similar move
	dbw 3, SUPERSONIC
	dbw 7, BUBBLE_BEAM
	dbw 11, CONFUSE_RAY
	dbw 14, WING_ATTACK
	dbw 16, HEADBUTT
	dbw 19, WATER_PULSE
	dbw 23, AQUA_JET ; Wide Guard → new move
	dbw 27, TAKE_DOWN
	dbw 32, AGILITY
	dbw 36, AIR_SLASH
	dbw 39, ROOST ; Aqua Ring → similar move
	dbw 46, MIRROR_COAT ; Bounce → Dream World move
	dbw 49, HYDRO_PUMP
	db -1 ; no more level-up moves

.SkarmoryEvosAttacks
	db -1 ; no more evolutions
	dbw 1, LEER
	dbw 1, PECK
	dbw 6, MUD_SLAP ; Sand Attack → similar move
	dbw 9, BITE ; Metal Claw → new move
	dbw 12, METAL_CLAW ; Air Cutter → Metal Claw
	dbw 17, FURY_STRIKES ; Fury Attack → similar move
	dbw 20, PURSUIT ; Feint → egg move
	dbw 23, SWIFT
	dbw 28, SPIKES
	dbw 31, AGILITY
	dbw 34, STEEL_WING
	dbw 39, SLASH
	dbw 42, SCREECH ; Metal Sound → similar move
	dbw 45, AIR_SLASH
	dbw 50, DRILL_PECK ; Autotomize → egg move
	dbw 53, NIGHT_SLASH
	db -1 ; no more level-up moves

.HoundourEvosAttacks
	evo_data EVOLVE_LEVEL, 24, HOUNDOOM
	db -1 ; no more evolutions
	dbw 1, LEER
	dbw 1, EMBER
	dbw 4, PURSUIT ; Howl → egg move
	dbw 8, SMOKESCREEN ; Smog → new move
	dbw 13, ROAR
	dbw 16, BITE
	dbw 20, FORESIGHT ; Odor Sleuth → similar move
	dbw 25, SUPER_FANG ; Beat Up → HGSS tutor move
	dbw 28, FIRE_SPIN ; Fire Fang → egg move
	dbw 32, FEINT_ATTACK
	dbw 37, DESTINY_BOND ; Embargo → egg move
	dbw 40, WILL_O_WISP ; Foul Play → egg move
	dbw 44, FLAMETHROWER
	dbw 49, CRUNCH
	dbw 52, NASTY_PLOT
	dbw 56, DARK_PULSE ; Inferno → TM move
	db -1 ; no more level-up moves

.HoundoomEvosAttacks
	db -1 ; no more evolutions
	dbw 1, LEER
	dbw 1, EMBER
	dbw 4, PURSUIT ; Howl → egg move
	dbw 8, SMOKESCREEN ; Smog → new move
	dbw 13, ROAR
	dbw 16, BITE
	dbw 20, FORESIGHT ; Odor Sleuth → similar move
	dbw 26, SUPER_FANG ; Beat Up → HGSS tutor move
	dbw 30, FIRE_SPIN ; Fire Fang → egg move
	dbw 35, FEINT_ATTACK
	dbw 41, DESTINY_BOND ; Embargo → egg move
	dbw 45, WILL_O_WISP ; Foul Play → egg move
	dbw 50, FLAMETHROWER
	dbw 56, CRUNCH
	dbw 60, NASTY_PLOT
	dbw 65, DARK_PULSE ; Inferno → TM move
	db -1 ; no more level-up moves

.KingdraEvosAttacks
	db -1 ; no more evolutions
	dbw 1, DRAGONBREATH ; evolution move
	dbw 1, WATER_GUN ; Bubble → similar move
	dbw 5, SMOKESCREEN
	dbw 9, LEER
	dbw 13, BUBBLE_BEAM ; Water Gun → Bubble Beam
	dbw 17, AQUA_JET ; Twister → new move
	dbw 21, WATER_PULSE ; Bubble Beam → TM move
	dbw 26, FOCUS_ENERGY
	dbw 31, OUTRAGE ; Brine → HGSS tutor move
	dbw 38, AGILITY
	dbw 45, DRAGON_PULSE
	dbw 52, DRAGON_DANCE
	dbw 60, HYDRO_PUMP
	db -1 ; no more level-up moves

.PhanpyEvosAttacks
	evo_data EVOLVE_LEVEL, 25, DONPHAN
	db -1 ; no more evolutions
	dbw 1, FORESIGHT ; Odor Sleuth → similar move
	dbw 1, TACKLE
	dbw 1, GROWL
	dbw 1, DEFENSE_CURL
	dbw 6, REVERSAL ; Flail → similar move
	dbw 10, ROLLOUT
	dbw 15, MAGNITUDE ; Natural Gift → Donphan move
	dbw 19, ENDURE
	dbw 24, TAKE_DOWN ; Slam → Take Down
	dbw 28, BODY_SLAM ; Take Down → TM move
	dbw 33, CHARM
	dbw 37, PLAY_ROUGH ; Last Resort → egg move
	dbw 42, DOUBLE_EDGE
	db -1 ; no more level-up moves

.DonphanEvosAttacks
	db -1 ; no more evolutions
	dbw 1, FURY_STRIKES ; evolution move
	dbw 1, GUNK_SHOT ; HGSS tutor move
	dbw 1, HORN_ATTACK
	dbw 1, GROWL
	dbw 1, DEFENSE_CURL
	dbw 1, BULLDOZE
	dbw 6, RAPID_SPIN
	dbw 10, ROLLOUT
	dbw 15, MAGNITUDE ; Assurance → Magnitude
	dbw 19, KNOCK_OFF
	dbw 24, ANCIENTPOWER ; Slam → HGSS tutor move
	dbw 30, IRON_TAIL ; Magnitude → TM move
	dbw 37, SCARY_FACE
	dbw 43, EARTHQUAKE
	dbw 50, GIGA_IMPACT
	db -1 ; no more level-up moves

.Porygon2EvosAttacks
	evo_data EVOLVE_HOLDING, DUBIOUS_DISC, TR_ANYTIME, PORYGON_Z
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, CONVERSION
	dbw 1, DEFENSE_CURL
	dbw 7, PSYBEAM
	dbw 12, AGILITY
	dbw 18, RECOVER
	dbw 23, GROWTH ; Magnet Rise → new move
	dbw 29, AURORA_BEAM ; Signal Beam → new move
	dbw 34, THUNDER_WAVE ; Recycle → TM move
	dbw 40, BARRIER ; Discharge → event move
	dbw 45, THUNDERBOLT ; Lock-On → TM move
	dbw 50, TRI_ATTACK
	dbw 56, MIRROR_COAT ; Magic Coat → new move
	dbw 62, ZAP_CANNON
	dbw 67, HYPER_BEAM
	db -1 ; no more level-up moves

.StantlerEvosAttacks
	evo_data EVOLVE_LOCATION, RUGGED_ROAD, WYRDEER
	evo_data EVOLVE_LOCATION, SNOWTOP_MOUNTAIN, WYRDEER
	evo_data EVOLVE_LOCATION, SINJOH_RUINS, WYRDEER
	evo_data EVOLVE_LOCATION, MYSTRI_STAGE, WYRDEER
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 3, LEER
	dbw 7, ASTONISH
	dbw 10, HYPNOSIS
	dbw 13, STOMP
	dbw 16, MUD_SLAP ; Sand-Attack → similar move
	dbw 21, HEADBUTT ; Take Down → tutor move
	dbw 23, CONFUSE_RAY
	dbw 27, CALM_MIND
	dbw 33, TAKE_DOWN ; Role Play → Take Down
	dbw 38, ZEN_HEADBUTT
	dbw 43, THRASH ; Jump Kick → egg move
	dbw 49, SKILL_SWAP ; Imprison → tutor move
	dbw 50, HI_JUMP_KICK ; Captivate → new move
	dbw 55, MEGAHORN ; Me First → egg move
	dbw 60, DOUBLE_EDGE ; new move
	db -1 ; no more level-up moves

.SmeargleEvosAttacks
	db -1 ; no more evolutions
	dbw 1, SKETCH
	dbw 11, SKETCH
	dbw 21, SKETCH
	dbw 31, SKETCH
	dbw 41, SKETCH
	dbw 51, SKETCH
	dbw 61, SKETCH
	dbw 71, SKETCH
	dbw 81, SKETCH
	dbw 91, SKETCH
	db -1 ; no more level-up moves

.TyrogueEvosAttacks
	evo_data EVOLVE_STAT, 20, ATK_LT_DEF, HITMONCHAN
	evo_data EVOLVE_STAT, 20, ATK_GT_DEF, HITMONLEE
	evo_data EVOLVE_STAT, 20, ATK_EQ_DEF, HITMONTOP
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, RAGE ; Fake Out → event move
	dbw 1, FORESIGHT
	db -1 ; no more level-up moves

.HitmontopEvosAttacks
	db -1 ; no more evolutions
	dbw 1, LOW_KICK ; Rolling Kick → HGSS tutor move ; evolution move
	dbw 1, BULK_UP ; Revenge → TM move
	dbw 6, FOCUS_ENERGY
	dbw 10, PURSUIT
	dbw 15, QUICK_ATTACK
	dbw 19, RAPID_SPIN
	dbw 24, FEINT_ATTACK ; Feint → new move
	dbw 28, COUNTER
	dbw 33, DOUBLE_KICK ; Triple Kick → similar move
	dbw 37, AGILITY
	dbw 42, GYRO_BALL
	dbw 46, FORESIGHT ; Wide Guard + Quick Guard → new move
	dbw 50, PROTECT ; Detect → similar move
	dbw 55, CLOSE_COMBAT
	dbw 60, REVERSAL ; Endeavor → new move
	db -1 ; no more level-up moves

.SmoochumEvosAttacks
	evo_data EVOLVE_LEVEL, 30, JYNX
	db -1 ; no more evolutions
	dbw 1, LICK
	dbw 1, TACKLE ; Pound → similar move
	dbw 4, ICY_WIND ; Powder Snow → TM move
	dbw 8, METRONOME ; Copycat → Jynx RBY TM move
	dbw 12, CONFUSION
	dbw 16, THIEF ; Covet → similar move
	dbw 20, SING
	dbw 24, MEAN_LOOK ; Fake Tears → Mean Look
	dbw 28, ICE_PUNCH
	dbw 32, PSYCHIC_M
	dbw 36, SWEET_KISS
	dbw 40, NASTY_PLOT ; Mean Look → egg move
	dbw 44, PERISH_SONG
	dbw 48, BLIZZARD
	db -1 ; no more level-up moves

.ElekidEvosAttacks
	evo_data EVOLVE_LEVEL, 30, ELECTABUZZ
	db -1 ; no more evolutions
	dbw 1, QUICK_ATTACK
	dbw 1, LEER
	dbw 5, THUNDERSHOCK
	dbw 8, LOW_KICK
	dbw 12, SWIFT
	dbw 15, BULK_UP ; Shock Wave → TM move
	dbw 19, THUNDER_WAVE
	dbw 22, KARATE_CHOP ; Electro Ball → egg move
	dbw 26, LIGHT_SCREEN
	dbw 29, THUNDERPUNCH
	dbw 33, SCREECH ; Discharge → Screech
	dbw 36, CROSS_CHOP ; Screech → new move
	dbw 40, THUNDERBOLT
	dbw 43, THUNDER
	db -1 ; no more level-up moves

.MagbyEvosAttacks
	evo_data EVOLVE_LEVEL, 30, MAGMAR
	db -1 ; no more evolutions
	dbw 1, HAZE ; Smog → new move
	dbw 1, LEER
	dbw 5, EMBER
	dbw 8, SMOKESCREEN
	dbw 12, FEINT_ATTACK
	dbw 15, FIRE_SPIN
	dbw 19, LOW_KICK ; Clear Smog → HGSS tutor move
	dbw 22, FLAME_CHARGE ; Flame Burst → TM move
	dbw 26, CONFUSE_RAY
	dbw 29, FIRE_PUNCH
	dbw 33, SUNNY_DAY ; Lava Plume → Sunny Day
	dbw 36, FOCUS_BLAST ; Sunny Day → TM move
	dbw 40, FLAMETHROWER
	dbw 43, FIRE_BLAST
	db -1 ; no more level-up moves

.MiltankEvosAttacks
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 3, GROWL
	dbw 5, DEFENSE_CURL
	dbw 8, STOMP
	dbw 11, FRESH_SNACK ; Milk Drink → similar move
	dbw 15, DIZZY_PUNCH ; Bide → egg move
	dbw 19, ROLLOUT
	dbw 24, BODY_SLAM
	dbw 29, ZEN_HEADBUTT
	dbw 35, SEISMIC_TOSS ; Captivate → egg move
	dbw 41, GYRO_BALL
	dbw 48, HEAL_BELL
	dbw 50, REVERSAL ; Wake-Up Slap → egg move
	db -1 ; no more level-up moves

.BlisseyEvosAttacks
	db -1 ; no more evolutions
	dbw 1, DEFENSE_CURL
	dbw 1, TACKLE ; Pound → similar move
	dbw 1, GROWL
	dbw 5, LEER ; Tail Whip → similar move
	dbw 9, SWEET_KISS ; Refresh → Happiny move
	dbw 12, DOUBLE_SLAP
	dbw 16, FRESH_SNACK ; Soft-Boiled → similar move
	dbw 20, METRONOME ; Bestow → egg move
	dbw 23, MINIMIZE
	dbw 27, TAKE_DOWN
	dbw 31, SING
	dbw 35, CHARM ; Fling → Happiny move
	dbw 39, HEAL_BELL ; Heal Pulse → HGSS tutor move
	dbw 44, BODY_SLAM ; Egg Bomb → TM move
	dbw 50, LIGHT_SCREEN
	dbw 57, SUBSTITUTE ; Healing Wish → TM move
	dbw 65, DOUBLE_EDGE
	db -1 ; no more level-up moves

.RaikouEvosAttacks
	db -1 ; no more evolutions
	dbw 1, BITE
	dbw 1, LEER
	dbw 8, THUNDERSHOCK
	dbw 15, ROAR
	dbw 22, QUICK_ATTACK
	dbw 29, SPARK
	dbw 36, REFLECT
	dbw 43, CRUNCH
	dbw 50, WILD_CHARGE ; Thunder Fang → TM move
	dbw 57, EXTREMESPEED ; Discharge → event move
	dbw 64, EXTRASENSORY
	dbw 71, RAIN_DANCE
	dbw 78, CALM_MIND
	dbw 85, AURA_SPHERE ; Thunder → event move
	dbw 92, THUNDER
	dbw 99, HIDDEN_POWER ; TM move
	db -1 ; no more level-up moves

.EnteiEvosAttacks
	db -1 ; no more evolutions
	dbw 1, BITE
	dbw 1, LEER
	dbw 8, EMBER
	dbw 15, ROAR
	dbw 22, FIRE_SPIN
	dbw 29, STOMP
	dbw 36, FLAMETHROWER
	dbw 43, SWAGGER
	dbw 50, FLAME_CHARGE ; Fire Fang → TM move
	dbw 57, EXTREMESPEED ; Lava Plume → event move
	dbw 64, EXTRASENSORY
	dbw 71, FIRE_BLAST
	dbw 78, CALM_MIND
	dbw 85, FLARE_BLITZ ; Eruption → event move
	dbw 92, SACRED_FIRE
	dbw 99, HIDDEN_POWER ; TM move
	db -1 ; no more level-up moves

.SuicuneEvosAttacks
	db -1 ; no more evolutions
	dbw 1, BITE
	dbw 1, LEER
	dbw 8, BUBBLE_BEAM
	dbw 15, RAIN_DANCE
	dbw 22, GUST
	dbw 29, AURORA_BEAM
	dbw 36, LIGHT_SCREEN ; Mist → new move
	dbw 43, MIRROR_COAT
	dbw 50, AIR_SLASH ; Ice Fang → event move
	dbw 57, EXTREMESPEED ; Tailwind → event move
	dbw 64, EXTRASENSORY
	dbw 71, HYDRO_PUMP
	dbw 78, CALM_MIND
	dbw 85, HYPER_BEAM ; Blizzard → TM move
	dbw 92, BLIZZARD
	dbw 99, HIDDEN_POWER ; TM move
	db -1 ; no more level-up moves

.LarvitarEvosAttacks
	evo_data EVOLVE_LEVEL, 30, PUPITAR
	db -1 ; no more evolutions
	dbw 1, TACKLE ; Sw/Sh move
	dbw 1, BITE
	dbw 1, LEER
	dbw 5, SANDSTORM
	dbw 10, SCREECH
	dbw 14, RAGE ; Chip Away → event move
	dbw 19, ROCK_SLIDE
	dbw 23, SCARY_FACE
	dbw 28, THRASH
	dbw 32, DARK_PULSE
	dbw 37, ANCIENTPOWER ; Payback → HGSS tutor move
	dbw 41, CRUNCH
	dbw 46, EARTHQUAKE
	dbw 50, STONE_EDGE
	dbw 55, OUTRAGE ; Hyper Beam → HGSS tutor move
	dbw 61, HYPER_BEAM
	dbw 68, CLOSE_COMBAT ; new move
	db -1 ; no more level-up moves

.PupitarEvosAttacks
	evo_data EVOLVE_LEVEL, 55, TYRANITAR
	db -1 ; no more evolutions
	dbw 1, DEFENSE_CURL ; evolution move
	dbw 1, TACKLE ; Sw/Sh move
	dbw 1, BITE
	dbw 1, LEER
	dbw 5, SANDSTORM
	dbw 10, SCREECH
	dbw 14, RAGE ; Chip Away → event move
	dbw 19, ROCK_SLIDE
	dbw 23, SCARY_FACE
	dbw 28, THRASH
	dbw 34, DARK_PULSE
	dbw 41, ANCIENTPOWER ; Payback → HGSS tutor move
	dbw 47, CRUNCH
	dbw 54, EARTHQUAKE
	dbw 60, STONE_EDGE
	dbw 67, OUTRAGE ; Hyper Beam → HGSS tutor move
	dbw 75, HYPER_BEAM
	dbw 84, CLOSE_COMBAT ; new move
	db -1 ; no more level-up moves

.TyranitarEvosAttacks
	db -1 ; no more evolutions
	dbw 1, STOMP ; evolution move
	dbw 1, LOW_KICK ; HGSS tutor move
	dbw 1, DRAGONBREATH ; GSC TM move
	dbw 1, TACKLE ; Sw/Sh move
	dbw 1, BITE
	dbw 1, LEER
	dbw 5, SANDSTORM
	dbw 10, SCREECH
	dbw 14, RAGE ; Chip Away → event move
	dbw 19, ROCK_SLIDE
	dbw 23, SCARY_FACE
	dbw 28, THRASH
	dbw 34, DARK_PULSE
	dbw 41, ANCIENTPOWER ; Payback → HGSS tutor move
	dbw 47, CRUNCH
	dbw 54, EARTHQUAKE
	dbw 63, STONE_EDGE
	dbw 73, OUTRAGE ; Hyper Beam → HGSS tutor move
	dbw 82, HYPER_BEAM
	dbw 92, CLOSE_COMBAT ; new move
	db -1 ; no more level-up moves

.LugiaEvosAttacks
	db -1 ; no more evolutions
	dbw 1, ROAR ; Whirlwind → similar move
	dbw 9, GUST
	dbw 15, DRAGONBREATH ; Dragon Rush → GSC TM move
	dbw 23, EXTRASENSORY
	dbw 29, RAIN_DANCE
	dbw 37, HYDRO_PUMP
	dbw 43, DRAGON_PULSE ; Aeroblast → TM move
	dbw 50, AEROBLAST ; Punishment → Aeroblast
	dbw 57, ANCIENTPOWER
	dbw 65, SAFEGUARD
	dbw 71, RECOVER
	dbw 79, FUTURE_SIGHT
	dbw 85, REFLECT ; Natural Gift → TM move
	dbw 93, CALM_MIND
	dbw 99, HURRICANE ; Sky Attack → new move
	db -1 ; no more level-up moves

.HoOhEvosAttacks
	db -1 ; no more evolutions
	dbw 1, ROAR ; Whirlwind → similar move
	dbw 9, GUST
	dbw 15, DRAGONBREATH ; Brave Bird → GSC TM move
	dbw 23, EXTRASENSORY
	dbw 29, SUNNY_DAY
	dbw 37, FIRE_BLAST
	dbw 43, SOLAR_BEAM ; Sacred Fire → Solar Beam
	dbw 50, SACRED_FIRE ; Punishment → Sacred Fire
	dbw 57, ANCIENTPOWER
	dbw 65, SAFEGUARD
	dbw 71, RECOVER
	dbw 79, FUTURE_SIGHT
	dbw 85, LIGHT_SCREEN ; Natural Gift → TM move
	dbw 93, CALM_MIND
	dbw 99, BRAVE_BIRD ; Sky Attack → Brave Bird
	db -1 ; no more level-up moves

.CelebiEvosAttacks
	db -1 ; no more evolutions
	dbw 1, LEECH_SEED
	dbw 1, CONFUSION
	dbw 1, RECOVER
	dbw 1, METRONOME ; Heal Bell → new move
	dbw 10, SAFEGUARD
	dbw 19, ENERGY_BALL ; Magical Leaf → TM move
	dbw 28, ANCIENTPOWER
	dbw 37, BATON_PASS
	dbw 46, MOONBLAST ; Natural Gift → new move
	dbw 55, LIGHT_SCREEN ; Heal Block → TM move
	dbw 64, FUTURE_SIGHT
	dbw 73, HEAL_BELL ; Healing Wish → Heal Bell
	dbw 82, NASTY_PLOT ; Leaf Storm → event move
	dbw 91, PERISH_SONG
	dbw 100, AURA_SPHERE ; Sw/Sh move
	db -1 ; no more level-up moves
