SECTION "Evolutions and Attacks Variants", ROMX

EvosAttacksPointersVariants::
	dw GyaradosRedEvosAttacks

	dw MewtwoArmoredEvosAttacks

	dw DudunsparceThreeSegmentEvosAttacks

	dw RattataAlolanEvosAttacks
	dw RaticateAlolanEvosAttacks
	dw RaichuAlolanEvosAttacks
	dw SandshrewAlolanEvosAttacks
	dw SandslashAlolanEvosAttacks
	dw VulpixAlolanEvosAttacks
	dw NinetalesAlolanEvosAttacks
	dw DiglettAlolanEvosAttacks
	dw DugtrioAlolanEvosAttacks
	dw MeowthAlolanEvosAttacks
	dw PersianAlolanEvosAttacks
	dw GeodudeAlolanEvosAttacks
	dw GravelerAlolanEvosAttacks
	dw GolemAlolanEvosAttacks
	dw GrimerAlolanEvosAttacks
	dw MukAlolanEvosAttacks
	dw ExeggutorAlolanEvosAttacks
	dw MarowakAlolanEvosAttacks

	dw MeowthGalarianEvosAttacks
	dw PonytaGalarianEvosAttacks
	dw RapidashGalarianEvosAttacks
	dw SlowpokeGalarianEvosAttacks
	dw SlowbroGalarianEvosAttacks
	dw FarfetchDGalarianEvosAttacks
	dw WeezingGalarianEvosAttacks
	dw MrMimeGalarianEvosAttacks
	dw ArticunoGalarianEvosAttacks
	dw ZapdosGalarianEvosAttacks
	dw MoltresGalarianEvosAttacks
	dw SlowkingGalarianEvosAttacks
	dw CorsolaGalarianEvosAttacks

	dw GrowlitheHisuianEvosAttacks
	dw ArcanineHisuianEvosAttacks
	dw VoltorbHisuianEvosAttacks
	dw ElectrodeHisuianEvosAttacks
	dw TyphlosionHisuianEvosAttacks
	dw QwilfishHisuianEvosAttacks
	dw SneaselHisuianEvosAttacks

	dw WooperPaldeanEvosAttacks
	dw TaurosPaldeanEvosAttacks
	dw TaurosPaldeanFireEvosAttacks
	dw TaurosPaldeanWaterEvosAttacks

	dw UrsalunaBloodmoonEvosAttacks
.IndirectEnd::

	evos_attacks GyaradosRed
	learnset 1, WATERFALL ; HM move
	learnset 1, BITE ; evolution move
	learnset 1, THRASH
	learnset 1, DRAGON_RAGE
	learnset 1, WRAP ; Bind → similar move
	learnset 21, LEER
	learnset 24, GUST ; Twister → new move
	learnset 27, DRAGON_RAGE ; Ice Fang → Dragon Rage
	learnset 30, AQUA_TAIL
	learnset 33, SCARY_FACE
	learnset 36, DRAGONBREATH ; Dragon Rage → GSC TM move
	learnset 39, CRUNCH
	learnset 42, HYDRO_PUMP
	learnset 45, DRAGON_DANCE
	learnset 48, HURRICANE
	learnset 51, RAIN_DANCE
	learnset 54, HYPER_BEAM
	learnset 57, OUTRAGE ; HGSS tutor move

	evos_attacks MewtwoArmored
	learnset 1, TELEPORT ; Psywave → RBY TM move
	learnset 1, AGILITY ; Sw/Sh move
	learnset 1, FOCUS_ENERGY ; Laser Focus → similar move
	learnset 1, CONFUSION
	learnset 1, DISABLE
	learnset 10, SAFEGUARD
	learnset 19, SWIFT
	learnset 28, FUTURE_SIGHT
	learnset 37, BARRIER ; Psych Up → Barrier
	learnset 46, RECOVER
	learnset 55, PSYCHIC_M
	learnset 64, POWER_GEM ; Barrier → SV TM move
	learnset 73, AURA_SPHERE
	learnset 82, AMNESIA
	learnset 91, NASTY_PLOT ; Mist → Mew move
	learnset 100, PSYSTRIKE

	evos_attacks DudunsparceThreeSegment
	learnset 1, RAGE
	learnset 1, DEFENSE_CURL
	learnset 3, ROLLOUT
	learnset 6, ASTONISH ; Spite → egg move
	learnset 8, PURSUIT
	learnset 11, SCREECH
	learnset 13, MUD_SLAP
	learnset 16, FURY_STRIKES ; Yawn → event move (Fury Attack)
	learnset 18, ANCIENTPOWER
	learnset 21, BODY_SLAM
	learnset 23, DRAGON_RAGE ; Drill Run → new move
	learnset 26, ROOST
	learnset 28, TAKE_DOWN
	learnset 31, DRAGON_DANCE ; Coil → new move
	learnset 33, DIG
	learnset 36, GLARE
	learnset 38, DOUBLE_EDGE
	learnset 41, EARTHQUAKE ; Endeavor → TM move
	learnset 43, AIR_SLASH
	learnset 46, HEX ; Dragon Rush → egg move
	learnset 48, ENDURE
	learnset 51, REVERSAL ; Flail → similar move
	learnset 53, HURRICANE
	learnset 56, HYPER_VOICE ; Boomburst → similar move
	learnset 58, OUTRAGE ; new move

	evos_attacks RattataAlolan
	evo_data EVOLVE_LEVEL, 20, RATICATE, ALOLAN_FORM
	learnset 1, TACKLE
	learnset 1, LEER ; Tail Whip → similar move
	learnset 4, QUICK_ATTACK
	learnset 7, FOCUS_ENERGY
	learnset 10, BITE
	learnset 13, PURSUIT
	learnset 16, HYPER_FANG
	learnset 19, SUCKER_PUNCH
	learnset 22, CRUNCH
	learnset 25, FEINT_ATTACK ; Assurance → similar move
	learnset 28, SUPER_FANG
	learnset 31, DOUBLE_EDGE
	learnset 34, COUNTER ; Endeavor → egg move

	evos_attacks RaticateAlolan
	learnset 1, SCARY_FACE ; evolution move
	learnset 1, SWORDS_DANCE
	learnset 1, TACKLE
	learnset 1, LEER ; Tail Whip → similar move
	learnset 4, QUICK_ATTACK
	learnset 7, FOCUS_ENERGY
	learnset 10, BITE
	learnset 13, PURSUIT
	learnset 16, HYPER_FANG
	learnset 19, SUCKER_PUNCH
	learnset 24, CRUNCH
	learnset 29, FEINT_ATTACK ; Assurance → similar move
	learnset 34, SUPER_FANG
	learnset 39, DOUBLE_EDGE
	learnset 44, COUNTER ; Endeavor → egg move

	evos_attacks RaichuAlolan
	learnset 1, THUNDERSHOCK
	learnset 1, LEER ; Tail Whip → similar move
	learnset 1, QUICK_ATTACK
	learnset 1, THUNDERBOLT
	learnset 1, PSYCHIC_M ; evolution move
	learnset 1, REVERSAL ; Sw/Sh move

	evos_attacks SandshrewAlolan
	evo_data EVOLVE_ITEM, ICE_STONE, SANDSLASH, ALOLAN_FORM
	learnset 1, SCRATCH
	learnset 1, DEFENSE_CURL
	learnset 3, FOCUS_ENERGY ; Bide → new move
	learnset 5, ICY_WIND ; Powder Snow → similar move
	learnset 7, DEFENSE_CURL ; Ice Ball → TM move
	learnset 9, RAPID_SPIN
	learnset 11, PIN_MISSILE ; Fury Cutter → new move
	learnset 14, METAL_CLAW
	learnset 17, SWIFT
	learnset 20, FURY_STRIKES ; Fury Swipes → similar move
	learnset 23, ROLLOUT ; Iron Defense → TM move
	learnset 26, SLASH
	learnset 30, IRON_HEAD
	learnset 34, GYRO_BALL
	learnset 38, SWORDS_DANCE
	learnset 42, HAIL
	learnset 46, BLIZZARD

	evos_attacks SandslashAlolan
	learnset 1, ICICLE_SPEAR ; evolution move
	learnset 1, COUNTER ; Metal Burst → similar move
	learnset 1, MIRROR_COAT ; Metal Burst → similar move
	learnset 1, ICICLE_CRASH ; evolution move
	learnset 1, SLASH
	learnset 1, DEFENSE_CURL
	learnset 1, ROLLOUT ; Ice Ball → TM move
	learnset 1, METAL_CLAW
	learnset 48, HAIL
	learnset 53, BLIZZARD

	evos_attacks VulpixAlolan
	evo_data EVOLVE_ITEM, ICE_STONE, NINETALES, ALOLAN_FORM
	learnset 1, ICY_WIND ; Powder Snow → similar move
	learnset 4, GROWL ; Tail Whip → new move
	learnset 7, ROAR
	learnset 9, CHARM ; Baby-Doll Eyes → similar move
	learnset 10, ICE_SHARD
	learnset 12, CONFUSE_RAY
	learnset 15, DISARM_VOICE ; Icy Wind → new move
	learnset 18, NIGHT_SHADE ; Payback → new move
	learnset 20, HAIL ; Mist → TM move
	learnset 23, FEINT_ATTACK
	learnset 26, HEX
	learnset 28, AURORA_BEAM
	learnset 31, EXTRASENSORY
	learnset 34, SAFEGUARD
	learnset 36, ICE_BEAM
	learnset 39, HYPNOSIS ; Imprison → egg move
	learnset 42, BLIZZARD
	learnset 44, SHADOW_BALL ; Grudge → TM move
	learnset 47, DISABLE ; Captivate → egg move
	learnset 50, MOONBLAST ; Sheer Cold → egg move
	learnset 53, HEALINGLIGHT ; new move

	evos_attacks NinetalesAlolan
	learnset 1, DAZZLINGLEAM ; evolution move
	learnset 1, NASTY_PLOT
	learnset 1, ICE_BEAM
	learnset 1, ICE_SHARD
	learnset 1, CONFUSE_RAY
	learnset 1, SAFEGUARD

	evos_attacks DiglettAlolan
	evo_data EVOLVE_LEVEL, 26, DUGTRIO, ALOLAN_FORM
	learnset 1, MUD_SLAP ; Sand Attack → Mud-Slap
	learnset 1, METAL_CLAW
	learnset 1, CHARM ; XD move
	learnset 4, GROWL
	learnset 7, ASTONISH
	learnset 10, AGILITY ; Mud-Slap → LGPE move
	learnset 14, MAGNITUDE
	learnset 18, BULLDOZE
	learnset 22, SUCKER_PUNCH
	learnset 25, ANCIENTPOWER ; Mud Bomb → egg move
	learnset 28, EARTH_POWER
	learnset 31, DIG
	learnset 35, IRON_HEAD
	learnset 39, EARTHQUAKE
	learnset 43, NIGHT_SLASH ; Fissure → Dugtrio move

	evos_attacks DugtrioAlolan
	learnset 1, TRI_ATTACK ; Sand Tomb → Tri Attack ; evolution move
	learnset 1, NIGHT_SLASH
	learnset 1, MUD_SLAP ; Sand Attack → Mud-Slap
	learnset 1, METAL_CLAW
	learnset 1, CHARM ; XD move
	learnset 4, GROWL
	learnset 7, ASTONISH
	learnset 10, AGILITY ; Mud-Slap → LGPE move
	learnset 14, MAGNITUDE
	learnset 18, BULLDOZE
	learnset 22, SUCKER_PUNCH
	learnset 25, ANCIENTPOWER ; Mud Bomb → egg move
	learnset 30, EARTH_POWER
	learnset 35, DIG
	learnset 41, IRON_HEAD
	learnset 47, EARTHQUAKE
	learnset 53, NIGHT_SLASH ; Fissure → Night Slash

	evos_attacks MeowthAlolan
	evo_data EVOLVE_LEVEL, 28, PERSIAN, ALOLAN_FORM
	learnset 1, SCRATCH
	learnset 1, GROWL
	learnset 6, BITE
	learnset 9, ASTONISH ; Fake Out → new move
	learnset 14, FURY_STRIKES ; Fury Swipes → similar move
	learnset 17, SCREECH
	learnset 22, FEINT_ATTACK
	learnset 25, PURSUIT ; Taunt → egg move
	learnset 30, PAY_DAY
	learnset 33, SLASH
	learnset 38, NASTY_PLOT
	learnset 41, THIEF ; Assurance → TM move
	learnset 46, CHARM ; Captivate → egg move
	learnset 49, NIGHT_SLASH
	learnset 55, DARK_PULSE

	evos_attacks PersianAlolan
	learnset 1, BUBBLE_BEAM ; RBY TM move
	learnset 1, PLAY_ROUGH
	learnset 1, SWIFT ; evolution move
	learnset 1, SCRATCH
	learnset 1, GROWL
	learnset 6, BITE
	learnset 9, ASTONISH ; Fake Out → new move
	learnset 14, FURY_STRIKES ; Fury Swipes → similar move
	learnset 17, SCREECH
	learnset 22, FEINT_ATTACK
	learnset 25, PURSUIT ; Taunt → egg move
	learnset 32, POWER_GEM
	learnset 37, SLASH
	learnset 44, NASTY_PLOT
	learnset 49, THIEF ; Assurance → TM move
	learnset 56, CHARM ; Captivate → egg move
	learnset 61, NIGHT_SLASH
	learnset 65, DARK_PULSE

	evos_attacks GeodudeAlolan
	evo_data EVOLVE_LEVEL, 25, GRAVELER, ALOLAN_FORM
	learnset 1, TACKLE
	learnset 1, DEFENSE_CURL
	learnset 4, THUNDERSHOCK ; Charge → new move
	learnset 6, RAPID_SPIN ; Rock Polish → event move
	learnset 10, ROLLOUT
	learnset 12, SPARK
	learnset 16, ROCK_THROW
	learnset 18, ANCIENTPOWER ; Smack Down → HGSS tutor move
	learnset 22, THUNDERPUNCH
	learnset 24, ROCK_BLAST ; Self-Destruct → Rock Blast
	learnset 28, SANDSTORM ; Stealth Rock → TM move
	learnset 30, ROCK_SLIDE ; Rock Blast → TM move
	learnset 34, WILD_CHARGE ; Discharge → new move
	learnset 36, EXPLOSION
	learnset 40, DOUBLE_EDGE
	learnset 42, STONE_EDGE

	evos_attacks GravelerAlolan
	evo_data EVOLVE_TRADE, LINKING_CORD, GOLEM, ALOLAN_FORM
	learnset 1, TACKLE
	learnset 1, DEFENSE_CURL
	learnset 4, THUNDERSHOCK ; Charge → new move
	learnset 6, RAPID_SPIN ; Rock Polish → event move
	learnset 10, ROLLOUT
	learnset 12, SPARK
	learnset 16, ROCK_THROW
	learnset 18, ANCIENTPOWER ; Smack Down → HGSS tutor move
	learnset 22, THUNDERPUNCH
	learnset 24, ROCK_BLAST ; Self-Destruct → Rock Blast
	learnset 30, SANDSTORM ; Stealth Rock → TM move
	learnset 34, ROCK_SLIDE ; Rock Blast → TM move
	learnset 40, WILD_CHARGE ; Discharge → new move
	learnset 44, EXPLOSION
	learnset 50, DOUBLE_EDGE
	learnset 54, STONE_EDGE

	evos_attacks GolemAlolan
	learnset 1, TACKLE
	learnset 1, DEFENSE_CURL
	learnset 4, THUNDERSHOCK ; Charge → new move
	learnset 6, RAPID_SPIN ; Rock Polish → event move
	learnset 10, ROLLOUT
	learnset 12, SPARK
	learnset 16, ROCK_THROW
	learnset 18, ANCIENTPOWER ; Smack Down → HGSS tutor move
	learnset 22, THUNDERPUNCH
	learnset 24, ROCK_BLAST ; Self-Destruct → Rock Blast
	learnset 30, SANDSTORM ; Stealth Rock → TM move
	learnset 34, ROCK_SLIDE ; Rock Blast → TM move
	learnset 40, WILD_CHARGE ; Discharge → new move
	learnset 44, EXPLOSION
	learnset 50, DOUBLE_EDGE
	learnset 54, STONE_EDGE
	learnset 60, GYRO_BALL ; Heavy Slam → similar move

	evos_attacks GrimerAlolan
	evo_data EVOLVE_LEVEL, 38, MUK, ALOLAN_FORM
	learnset 1, TACKLE ; Pound → similar move
	learnset 1, ACID ; Poison Gas → new move
	learnset 4, DEFENSE_CURL ; Harden → similar move
	learnset 7, BITE
	learnset 12, DISABLE
	learnset 15, VENOSHOCK ; Acid Spray → tutor move
	learnset 18, HAZE ; Poison Fang → egg move
	learnset 21, MINIMIZE
	learnset 26, FEINT_ATTACK ; Fling → new move
	learnset 29, KNOCK_OFF
	learnset 32, CRUNCH
	learnset 37, SCREECH
	learnset 40, GUNK_SHOT
	learnset 43, PAIN_SPLIT ; Acid Armor → HGSS tutor move
	learnset 46, TOXIC_SPIKES ; Belch → SV TM move

	evos_attacks MukAlolan
	learnset 1, MOONBLAST ; LGPE move
	learnset 1, TACKLE ; Pound → similar move
	learnset 1, ACID ; Poison Gas → new move
	learnset 4, DEFENSE_CURL ; Harden → similar move
	learnset 7, BITE
	learnset 12, DISABLE
	learnset 15, VENOSHOCK ; Acid Spray → tutor move
	learnset 18, HAZE ; Poison Fang → egg move
	learnset 21, MINIMIZE
	learnset 26, FEINT_ATTACK ; Fling → new move
	learnset 29, KNOCK_OFF
	learnset 32, CRUNCH
	learnset 37, SCREECH
	learnset 40, GUNK_SHOT
	learnset 46, PAIN_SPLIT ; Acid Armor → HGSS tutor move
	learnset 52, TOXIC_SPIKES ; Belch → SV TM move

	evos_attacks ExeggutorAlolan
	learnset 1, TACKLE ; Barrage → new move
	learnset 1, HYPNOSIS
	learnset 1, CONFUSION
	learnset 1, DRAGON_PULSE ; evolution move
	learnset 17, DRAGON_RAGE ; Psyshock → new move
	learnset 27, ZEN_HEADBUTT ; Egg Bomb → tutor move
	learnset 37, POWER_WHIP ; Wood Hammer → new move
	learnset 47, OUTRAGE ; Leaf Storm → S/M TM move

	evos_attacks MarowakAlolan
	learnset 1, SWORDS_DANCE ; evolution move
	learnset 1, GROWL
	learnset 3, TACKLE ; Tail Whip → new move
	learnset 7, ASTONISH ; Bone Club → new move
	learnset 11, FIRE_SPIN ; Flame Wheel → LGPE move
	learnset 13, LEER
	learnset 17, HEX
	learnset 21, BONEMERANG
	learnset 23, WILL_O_WISP
	learnset 27, SHADOW_CLAW ; Shadow Bone → similar move
	learnset 33, THRASH
	learnset 37, KNOCK_OFF ; Fling → TM move
	learnset 43, ACROBATICS ; Stomping Tantrum → new move
	learnset 49, ROCK_SMASH ; Endeavor → TM move
	learnset 53, FLARE_BLITZ
	learnset 59, PAIN_SPLIT ; Retaliate → S/M tutor move
	learnset 65, OUTRAGE ; Bone Rush → HGSS tutor move

	evos_attacks MeowthGalarian
	evo_data EVOLVE_LEVEL, 28, PERRSERKER, PLAIN_FORM
	learnset 1, ASTONISH ; Fake Out → new move
	learnset 1, GROWL
	learnset 4, HONE_CLAWS
	learnset 8, SCRATCH
	learnset 12, PAY_DAY
	learnset 16, METAL_CLAW
	learnset 20, PURSUIT ; Taunt → new move
	learnset 24, SWAGGER
	learnset 29, FURY_STRIKES ; Fury Swipes → similar move
	learnset 32, SCREECH
	learnset 36, SLASH
	learnset 40, CRUNCH ; Metal Sound → TR move
	learnset 44, THRASH

	evos_attacks PonytaGalarian
	evo_data EVOLVE_LEVEL, 40, RAPIDASH, GALARIAN_FORM
	learnset 1, GROWL
	learnset 1, TACKLE
	learnset 4, LEER ; Tail Whip → similar move
	learnset 9, CONFUSION
	learnset 13, DISARM_VOICE ; Fairy Wind → similar move
	learnset 17, STOMP
	learnset 21, HEALINGLIGHT ; Heal Pulse → similar move
	learnset 25, PSYBEAM
	learnset 29, TAKE_DOWN
	learnset 33, DAZZLINGLEAM
	learnset 37, AGILITY
	learnset 41, PSYCHIC_M
	learnset 45, EXTREMESPEED ; Bounce → new move
	learnset 49, MOONBLAST ; Healing Wish → new move

	evos_attacks RapidashGalarian
	learnset 1, PLAY_ROUGH ; evolution move
	learnset 1, MEGAHORN
	learnset 1, GROWL
	learnset 1, TACKLE
	learnset 4, LEER ; Tail Whip → similar move
	learnset 9, CONFUSION
	learnset 13, DISARM_VOICE ; Fairy Wind → similar move
	learnset 17, STOMP
	learnset 21, HEALINGLIGHT ; Heal Pulse → similar move
	learnset 25, PSYBEAM
	learnset 29, TAKE_DOWN
	learnset 33, DAZZLINGLEAM
	learnset 37, AGILITY
	learnset 41, PSYCHIC_M
	learnset 45, EXTREMESPEED ; Bounce → new move
	learnset 49, MOONBLAST ; Healing Wish → new move

	evos_attacks SlowpokeGalarian
	evo_data EVOLVE_TRADE, KINGS_ROCK, SLOWKING, GALARIAN_FORM
	evo_data EVOLVE_LEVEL, 37, SLOWBRO, GALARIAN_FORM
	learnset 1, CURSE
	learnset 1, TACKLE
	learnset 5, GROWL
	learnset 9, ACID
	learnset 14, CONFUSION
	learnset 19, DISABLE
	learnset 23, HEADBUTT
	learnset 28, WATER_PULSE
	learnset 32, ZEN_HEADBUTT
	learnset 36, SAFEGUARD ; Slack Off → egg move
	learnset 41, AMNESIA
	learnset 45, PSYCHIC_M
	learnset 49, RAIN_DANCE
	learnset 54, BELLY_DRUM ; Psych Up → egg move
	learnset 58, RECOVER ; Heal Pulse → similar move

	evos_attacks SlowbroGalarian
	learnset 1, GUNK_SHOT ; Shell Side Arm → similar move ; evolution move
	learnset 1, CURSE
	learnset 1, TACKLE
	learnset 5, GROWL
	learnset 9, ACID
	learnset 14, CONFUSION
	learnset 19, DISABLE
	learnset 23, HEADBUTT
	learnset 28, WATER_PULSE
	learnset 32, ZEN_HEADBUTT
	learnset 36, SAFEGUARD ; Slack Off → egg move
	learnset 43, AMNESIA
	learnset 49, PSYCHIC_M
	learnset 55, RAIN_DANCE
	learnset 62, BELLY_DRUM ; Psych Up → egg move
	learnset 68, RECOVER ; Heal Pulse → similar move

	evos_attacks FarfetchDGalarian
	evo_data EVOLVE_CRIT, TR_ANYTIME, SIRFETCH_D, PLAIN_FORM
	learnset 1, PECK
	learnset 1, MUD_SLAP ; Sand Attack → similar move
	learnset 5, LEER
	learnset 10, QUICK_ATTACK ; Fury Cutter → egg move
if DEF(FAITHFUL)
	learnset 15, ROCK_SMASH
else
	learnset 15, REVERSAL ; Rock Smash → TM move
endc
	learnset 20, FEINT_ATTACK ; Brutal Swing → similar move
	learnset 25, PROTECT ; Detect → similar move
	learnset 30, KNOCK_OFF
	learnset 35, STEEL_WING ; Defog → TM move
if DEF(FAITHFUL)
	learnset 40, NIGHT_SLASH ; Brick Break → egg move
else
	learnset 40, ROCK_SMASH ; Brick Break
endc
	learnset 45, SWORDS_DANCE
	learnset 50, BODY_SLAM ; Slam → TR move
	learnset 55, POISON_JAB ; Leaf Blade → TR move
	learnset 60, CLOSE_COMBAT ; Final Gambit → TR move
	learnset 65, BRAVE_BIRD

	evos_attacks WeezingGalarian
	learnset 1, SAFEGUARD ; evolution move
	learnset 1, TACKLE
	learnset 4, GUST ; Smog → new move
	learnset 7, SMOKESCREEN
	learnset 12, ENDURE ; Assurance → TM move
	learnset 15, WILL_O_WISP ; Clear Smog → TM move
	learnset 18, SCREECH ; Sludge → Sw/Sh TM move
	learnset 23, RAGE ; Self-Destruct → RBY TM move
	learnset 26, HAZE ; Aromatherapy → Kantonian move
	learnset 29, GYRO_BALL
	learnset 34, PLAY_ROUGH ; Sludge Bomb → Sw/Sh TR move
	learnset 40, EXPLOSION
	learnset 46, DESTINY_BOND
	learnset 51, PAIN_SPLIT ; Belch → HGSS tutor move
	learnset 57, MOONBLAST ; Memento → new move

	evos_attacks MrMimeGalarian
	evo_data EVOLVE_LEVEL, 42, MR__RIME
	learnset 1, RECOVER ; Slack Off → similar move
	learnset 1, ENCORE
	learnset 1, PROTECT
	learnset 1, LIGHT_SCREEN
	learnset 1, REFLECT
	learnset 1, SAFEGUARD
	learnset 1, DAZZLINGLEAM
	learnset 1, TACKLE ; Pound → similar move
	learnset 1, RAPID_SPIN
	learnset 1, BATON_PASS
	learnset 1, ICE_SHARD
	learnset 12, CONFUSION
	learnset 16, METRONOME ; Ally Switch → TR move
	learnset 20, ICY_WIND
	learnset 24, DOUBLE_KICK
	learnset 28, PSYBEAM
	learnset 32, HYPNOSIS
	learnset 36, MIRROR_COAT
	learnset 40, SUCKER_PUNCH
	learnset 44, ICE_BEAM ; Freeze-Dry → TR move
	learnset 48, PSYCHIC_M
	learnset 52, CONFUSE_RAY ; Teeter Dance → egg move

	evos_attacks ArticunoGalarian
	learnset 1, GUST
	learnset 1, CONFUSION
	learnset 1, LEER ; LGPE move
	learnset 8, SAFEGUARD ; Psycho Shift → new move
	learnset 15, HYPNOSIS
	learnset 22, EXTRASENSORY ; Mind Reader → event move
	learnset 29, ANCIENTPOWER
	learnset 36, AGILITY
	learnset 43, PSYCHIC_M ; Freezing Glare → TM move
	learnset 50, AIR_SLASH ; Reflect → new move
	learnset 57, DREAM_EATER
	learnset 64, REFLECT ; Tailwind → Reflect
	learnset 71, FUTURE_SIGHT
	learnset 78, BRAVE_BIRD ; Sheer Cold → TR move
	learnset 85, RECOVER
	learnset 92, HURRICANE
	learnset 99, AEROBLAST ; new move

	evos_attacks ZapdosGalarian
	learnset 1, PECK
	learnset 1, LOW_KICK ; Rock Smash → TR move
	learnset 1, LEER ; LGPE move
	learnset 8, FOCUS_ENERGY
	learnset 15, PROTECT ; Detect → similar move
	learnset 22, COUNTER ; Pluck → Counter
	learnset 29, ANCIENTPOWER
	learnset 36, AGILITY ; Charge → Agility
	learnset 43, ROCK_SMASH ; Agility → Rock Smash/Brick Break
	learnset 50, DRILL_PECK ; Discharge → Drill Peck
	learnset 57, BULK_UP
	learnset 64, LIGHT_SCREEN
	learnset 71, CLOSE_COMBAT
	learnset 78, BRAVE_BIRD ; Counter → TR move
	learnset 85, HI_JUMP_KICK ; Quick Guard → new move
	learnset 92, HURRICANE
	learnset 99, REVERSAL

	evos_attacks MoltresGalarian
	learnset 1, GUST
	learnset 1, PURSUIT ; Payback → new move
	learnset 1, LEER
	learnset 8, FEINT_ATTACK ; new move
	learnset 15, SAFEGUARD
	learnset 22, WING_ATTACK
	learnset 29, ANCIENTPOWER
	learnset 36, AGILITY ; Flamethrower → Agility
	learnset 43, SUCKER_PUNCH
	learnset 50, AIR_SLASH
	learnset 57, NASTY_PLOT ; After You → Nasty Plot
	learnset 64, DARK_PULSE ; Fiery Wrath → similar move
	learnset 71, HEX ; Nasty Plot → TR move
	learnset 78, BRAVE_BIRD ; Sky Attack → new move
	learnset 85, PAIN_SPLIT ; Memento → new move
	learnset 92, HURRICANE
	learnset 99, NIGHT_SLASH ; new move

	evos_attacks SlowkingGalarian
	learnset 1, HEX ; Eerie Spell → Sw/Sh TR move ; evolution move
	learnset 1, POWER_GEM
	learnset 1, HIDDEN_POWER
	learnset 1, CURSE
	learnset 1, TACKLE
	learnset 5, GROWL
	learnset 9, ACID
	learnset 14, CONFUSION
	learnset 19, DISABLE
	learnset 23, HEADBUTT
	learnset 28, WATER_PULSE
	learnset 32, ZEN_HEADBUTT
	learnset 36, NASTY_PLOT
	learnset 41, SWAGGER
	learnset 45, PSYCHIC_M
	learnset 49, RAIN_DANCE ; Trump Card → TM move
	learnset 54, BELLY_DRUM ; Psych Up → egg move
	learnset 58, RECOVER ; Heal Pulse → similar move

	evos_attacks CorsolaGalarian
	evo_data EVOLVE_LEVEL, 38, CURSOLA, PLAIN_FORM
	learnset 1, TACKLE
	learnset 1, DEFENSE_CURL ; Harden → similar move
	learnset 5, ASTONISH
	learnset 10, DISABLE
	learnset 15, HAZE ; Spite → egg move
	learnset 20, ANCIENTPOWER
	learnset 25, HEX
	learnset 30, CURSE
	learnset 35, GIGA_DRAIN ; Strength Sap → TM move
	learnset 40, POWER_GEM
	learnset 45, NIGHT_SHADE
	learnset 50, HYDRO_PUMP ; Grudge → TR move
	learnset 55, MIRROR_COAT

	evos_attacks GrowlitheHisuian
	evo_data EVOLVE_ITEM, FIRE_STONE, ARCANINE, HISUIAN_FORM
	learnset 1, GROWL
	learnset 1, BITE
	learnset 1, ROAR
	learnset 6, EMBER
	learnset 8, LEER
	learnset 10, SAFEGUARD ; Odor Sleuth → egg move
	learnset 12, BATON_PASS ; Helping Hand → new move
	learnset 17, FIRE_SPIN ; Flame Wheel → egg move
	learnset 19, REVERSAL
	learnset 21, ROCK_BLAST ; Fire Fang → new move
	learnset 23, TAKE_DOWN
	learnset 28, FLAME_CHARGE ; Flame Burst → TM move
	learnset 30, AGILITY
	learnset 32, ROCK_SLIDE
	learnset 34, FLAMETHROWER
	learnset 39, CRUNCH
	learnset 41, POWER_GEM ; Heat Wave → new move
	learnset 43, OUTRAGE
	learnset 45, PLAY_ROUGH ; Flare Blitz → LGPE move
	learnset 49, FLARE_BLITZ

	evos_attacks ArcanineHisuian
	learnset 1, BULK_UP ; new move
	learnset 1, GROWL
	learnset 1, BITE
	learnset 1, ROAR
	learnset 1, FLAME_CHARGE
	learnset 1, TAKE_DOWN
	learnset 1, EXTREMESPEED ; evolution move

	evos_attacks VoltorbHisuian
	evo_data EVOLVE_ITEM, LEAF_STONE, ELECTRODE, HISUIAN_FORM
	learnset 1, TACKLE
	learnset 1, THUNDERSHOCK ; LGPE move
	learnset 1, ABSORB ; new move
	learnset 4, SONIC_BOOM
	learnset 6, AGILITY ; Eerie Impulse → event move
	learnset 9, SPARK
	learnset 11, ROLLOUT
	learnset 13, SCREECH
	learnset 16, THUNDER_WAVE ; Charge Beam → TM move
	learnset 20, SWIFT
	learnset 22, THUNDERBOLT ; Electro Ball → TM move
	learnset 26, ENERGY_BALL
	learnset 29, LIGHT_SCREEN
	learnset 34, EXPLOSION ; Magnet Rise → Explosion
	learnset 37, THUNDER ; Discharge → TM move
	learnset 41, SOLAR_BEAM ; Chloroblast → TM move
	learnset 46, GYRO_BALL
	learnset 48, MIRROR_COAT

	evos_attacks ElectrodeHisuian
	learnset 1, TACKLE
	learnset 1, THUNDERSHOCK ; LGPE move
	learnset 1, ABSORB ; new move
	learnset 4, SONIC_BOOM
	learnset 6, AGILITY ; Eerie Impulse → event move
	learnset 9, SPARK
	learnset 11, ROLLOUT
	learnset 13, SCREECH
	learnset 16, THUNDER_WAVE ; Charge Beam → TM move
	learnset 20, SWIFT
	learnset 22, THUNDERBOLT ; Electro Ball → TM move
	learnset 26, ENERGY_BALL
	learnset 29, LIGHT_SCREEN
	learnset 36, EXPLOSION ; Magnet Rise → Explosion
	learnset 41, THUNDER ; Discharge → TM move
	learnset 47, SOLAR_BEAM ; Chloroblast → TM move
	learnset 54, GYRO_BALL
	learnset 58, MIRROR_COAT

	evos_attacks TyphlosionHisuian
	learnset 1, SHADOW_CLAW ; evolution move
	learnset 1, ASTONISH ; new move
	learnset 1, TACKLE
	learnset 1, LEER
	learnset 6, SMOKESCREEN
	learnset 10, EMBER
	learnset 13, QUICK_ATTACK
	learnset 20, DEFENSE_CURL ; Flame Wheel → Defense Curl
	learnset 24, FLAME_CHARGE ; Defense Curl → Flame Charge
	learnset 31, SWIFT
	learnset 35, HEX
	learnset 43, WILL_O_WISP ; Lava Plume → TM move
	learnset 48, FLAMETHROWER
	learnset 56, SHADOW_BALL
	learnset 61, ROLLOUT
	learnset 69, DOUBLE_EDGE
	learnset 74, DARK_PULSE ; Infernal Parade → new move
	learnset 81, FLARE_BLITZ ; Eruption → egg move

	evos_attacks QwilfishHisuian
	evo_data EVOLVE_LEVEL, 33, OVERQWIL
	learnset 1, AQUA_JET ; Water Gun → SV TM move
	learnset 1, SPIKES
	learnset 1, TACKLE
	learnset 1, POISON_STING
	learnset 5, DEFENSE_CURL ; Harden → TM move
	learnset 9, MINIMIZE
	learnset 13, PIN_MISSILE
	learnset 17, ROLLOUT
	learnset 21, TOXIC_SPIKES
	learnset 25, PAIN_SPLIT ; Stockpile + Spit Up → HGSS move tutor
	learnset 29, REVERSAL ; Revenge → Sw/Sh move
	learnset 33, WATER_PULSE ; Brine → TM move
	learnset 37, CRUNCH ; Dark Pulse → SV TM move
	learnset 41, TAKE_DOWN
	learnset 45, AQUA_TAIL
	learnset 49, POISON_JAB
	learnset 53, DESTINY_BOND
	learnset 57, EXPLOSION ; Self-Destruct → similar move
	learnset 60, DOUBLE_EDGE ; Fell Stinger → event move

	evos_attacks SneaselHisuian
	evo_data EVOLVE_HOLDING, RAZOR_CLAW, TR_MORNDAY, SNEASLER
	learnset 1, SCRATCH
	learnset 1, LEER
	learnset 1, BITE ; Taunt → egg move
	learnset 8, QUICK_ATTACK
	learnset 10, FEINT_ATTACK
	learnset 14, LOW_KICK ; Rock Smash → Low Kick
	learnset 16, FURY_STRIKES ; Fury Swipes → similar move
	learnset 20, AGILITY
	learnset 22, METAL_CLAW
	learnset 25, HONE_CLAWS
	learnset 28, POISON_JAB
	learnset 32, SCREECH
	learnset 35, SLASH
	learnset 40, SWORDS_DANCE
	learnset 44, X_SCISSOR ; Punishment → TM move
	learnset 47, CLOSE_COMBAT
	learnset 50, GUNK_SHOT ; SV TM move

	evos_attacks WooperPaldean
	evo_data EVOLVE_LEVEL, 20, CLODSIRE
	learnset 1, MUD_SLAP ; Mud Shot → similar move
	learnset 1, LEER ; Tail Whip → similar move
	learnset 5, TACKLE
	learnset 9, POISON_STING ; Poison Tail → similar move
	learnset 15, HEADBUTT ; Slam → tutor move
	learnset 19, RECOVER ; Mud Bomb → egg move
	learnset 23, AMNESIA
	learnset 29, BELLY_DRUM ; Yawn → event move
	learnset 33, EARTHQUAKE
	learnset 37, POISON_JAB
	learnset 43, TOXIC_SPIKES
	learnset 47, GUNK_SHOT ; Sludge Wave → similar move

	evos_attacks TaurosPaldean
	learnset 1, TACKLE
	learnset 3, LEER ; Tail Whip → similar move
	learnset 5, RAGE
	learnset 8, HEADBUTT
	learnset 11, SCARY_FACE
	learnset 15, PURSUIT
	learnset 19, REST
	learnset 24, DOUBLE_KICK
	learnset 29, FOCUS_ENERGY ; Work Up → LGPE move
	learnset 35, TAKE_DOWN
	learnset 41, ZEN_HEADBUTT
	learnset 48, SWAGGER
	learnset 55, THRASH
	learnset 63, DOUBLE_EDGE
	learnset 71, CLOSE_COMBAT
	learnset 80, OUTRAGE ; HGSS tutor move

	evos_attacks TaurosPaldeanFire
	learnset 1, TACKLE
	learnset 3, LEER ; Tail Whip → similar move
	learnset 5, RAGE
	learnset 8, HEADBUTT
	learnset 11, SCARY_FACE
	learnset 15, FLAME_CHARGE
	learnset 19, REST
	learnset 24, DOUBLE_KICK
	learnset 29, FOCUS_ENERGY ; Work Up → LGPE move
	learnset 35, TAKE_DOWN
	learnset 41, ZEN_HEADBUTT
	learnset 48, SWAGGER
	learnset 55, THRASH
	learnset 63, FLARE_BLITZ
	learnset 71, CLOSE_COMBAT
	learnset 80, OUTRAGE ; HGSS tutor move

	evos_attacks TaurosPaldeanWater
	learnset 1, TACKLE
	learnset 3, LEER ; Tail Whip → similar move
	learnset 5, RAGE
	learnset 8, HEADBUTT
	learnset 11, SCARY_FACE
	learnset 15, AQUA_JET
	learnset 19, REST
	learnset 24, DOUBLE_KICK
	learnset 29, FOCUS_ENERGY ; Work Up → LGPE move
	learnset 35, TAKE_DOWN
	learnset 41, ZEN_HEADBUTT
	learnset 48, SWAGGER
	learnset 55, THRASH
	learnset 63, AQUA_TAIL ; Wave Crash → tutor move
	learnset 71, CLOSE_COMBAT
	learnset 80, OUTRAGE ; HGSS tutor move

	evos_attacks UrsalunaBloodmoon
	learnset 1, BULLDOZE ; evolution move
	learnset 1, GUNK_SHOT ; HGSS tutor move
	learnset 1, THIEF ; Covet → TM move
	learnset 1, SCRATCH
	learnset 1, LEER
	learnset 1, LICK
	learnset 1, HEALINGLIGHT ; Moonlight → similar move
	learnset 8, FURY_STRIKES ; Fury Swipes → similar move
	learnset 15, FEINT_ATTACK
	learnset 22, DEFENSE_CURL ; Harden → similar move
	learnset 25, SHADOW_BALL ; new move
	learnset 29, SLASH
	learnset 38, SCARY_FACE
	learnset 47, REST
	learnset 49, EARTH_POWER
	learnset 58, MOONBLAST
	learnset 67, FOCUS_BLAST ; Hammer Arm → SV TM move
	learnset 76, HYPER_BEAM ; Blood Moon → SV TM move
	learnset 85, GUNK_SHOT ; SV TM move

	end_evos_attacks
