SECTION "Evolutions and Attacks Variants", ROMX

EvosAttacksPointersVariants::
	dw .GyaradosRedEvosAttacks

	dw .MewtwoArmoredEvosAttacks

	dw .DudunsparceThreeSegmentEvosAttacks

	dw .RattataAlolanEvosAttacks
	dw .RaticateAlolanEvosAttacks
	dw .RaichuAlolanEvosAttacks
	dw .SandshrewAlolanEvosAttacks
	dw .SandslashAlolanEvosAttacks
	dw .VulpixAlolanEvosAttacks
	dw .NinetalesAlolanEvosAttacks
	dw .DiglettAlolanEvosAttacks
	dw .DugtrioAlolanEvosAttacks
	dw .MeowthAlolanEvosAttacks
	dw .PersianAlolanEvosAttacks
	dw .GeodudeAlolanEvosAttacks
	dw .GravelerAlolanEvosAttacks
	dw .GolemAlolanEvosAttacks
	dw .GrimerAlolanEvosAttacks
	dw .MukAlolanEvosAttacks
	dw .ExeggutorAlolanEvosAttacks
	dw .MarowakAlolanEvosAttacks

	dw .MeowthGalarianEvosAttacks
	dw .PonytaGalarianEvosAttacks
	dw .RapidashGalarianEvosAttacks
	dw .SlowpokeGalarianEvosAttacks
	dw .SlowbroGalarianEvosAttacks
	dw .FarfetchDGalarianEvosAttacks
	dw .WeezingGalarianEvosAttacks
	dw .MrMimeGalarianEvosAttacks
	dw .ArticunoGalarianEvosAttacks
	dw .ZapdosGalarianEvosAttacks
	dw .MoltresGalarianEvosAttacks
	dw .SlowkingGalarianEvosAttacks
	dw .CorsolaGalarianEvosAttacks

	dw .GrowlitheHisuianEvosAttacks
	dw .ArcanineHisuianEvosAttacks
	dw .VoltorbHisuianEvosAttacks
	dw .ElectrodeHisuianEvosAttacks
	dw .TyphlosionHisuianEvosAttacks
	dw .QwilfishHisuianEvosAttacks
	dw .SneaselHisuianEvosAttacks

	dw .WooperPaldeanEvosAttacks
	dw .TaurosPaldeanEvosAttacks
	dw .TaurosPaldeanFireEvosAttacks
	dw .TaurosPaldeanWaterEvosAttacks

	dw .UrsalunaBloodmoonEvoAttacks
.IndirectEnd::

.GyaradosRedEvosAttacks
	db -1 ; no more evolutions
	dbw 1, WATERFALL ; HM move
	dbw 1, BITE ; evolution move
	dbw 1, THRASH
	dbw 1, DRAGON_RAGE
	dbw 1, WRAP ; Bind → similar move
	dbw 21, LEER
	dbw 24, GUST ; Twister → new move
	dbw 27, DRAGON_RAGE ; Ice Fang → Dragon Rage
	dbw 30, AQUA_TAIL
	dbw 33, SCARY_FACE
	dbw 36, DRAGONBREATH ; Dragon Rage → GSC TM move
	dbw 39, CRUNCH
	dbw 42, HYDRO_PUMP
	dbw 45, DRAGON_DANCE
	dbw 48, HURRICANE
	dbw 51, RAIN_DANCE
	dbw 54, HYPER_BEAM
	dbw 57, OUTRAGE ; HGSS tutor move
	db -1 ; no more level-up moves

.MewtwoArmoredEvosAttacks
	db -1 ; no more evolutions
	dbw 1, TELEPORT ; Psywave → RBY TM move
	dbw 1, AGILITY ; Sw/Sh move
	dbw 1, FOCUS_ENERGY ; Laser Focus → similar move
	dbw 1, CONFUSION
	dbw 1, DISABLE
	dbw 10, SAFEGUARD
	dbw 19, SWIFT
	dbw 28, FUTURE_SIGHT
	dbw 37, BARRIER ; Psych Up → Barrier
	dbw 46, RECOVER
	dbw 55, PSYCHIC_M
	dbw 64, POWER_GEM ; Barrier → SV TM move
	dbw 73, AURA_SPHERE
	dbw 82, AMNESIA
	dbw 91, NASTY_PLOT ; Mist → Mew move
	dbw 100, PSYSTRIKE
	db -1 ; no more level-up moves

.DudunsparceThreeSegmentEvosAttacks
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
	dbw 53, HURRICANE
	dbw 56, HYPER_VOICE ; Boomburst → similar move
	dbw 58, OUTRAGE ; new move
	db -1 ; no more level-up moves

.RattataAlolanEvosAttacks
	evo_data EVOLVE_LEVEL, 20, RATICATE, ALOLAN_FORM
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, LEER ; Tail Whip → similar move
	dbw 4, QUICK_ATTACK
	dbw 7, FOCUS_ENERGY
	dbw 10, BITE
	dbw 13, PURSUIT
	dbw 16, HYPER_FANG
	dbw 19, SUCKER_PUNCH
	dbw 22, CRUNCH
	dbw 25, FEINT_ATTACK ; Assurance → similar move
	dbw 28, SUPER_FANG
	dbw 31, DOUBLE_EDGE
	dbw 34, COUNTER ; Endeavor → egg move
	db -1 ; no more level-up moves

.RaticateAlolanEvosAttacks
	db -1 ; no more evolutions
	dbw 1, SCARY_FACE ; evolution move
	dbw 1, SWORDS_DANCE
	dbw 1, TACKLE
	dbw 1, LEER ; Tail Whip → similar move
	dbw 4, QUICK_ATTACK
	dbw 7, FOCUS_ENERGY
	dbw 10, BITE
	dbw 13, PURSUIT
	dbw 16, HYPER_FANG
	dbw 19, SUCKER_PUNCH
	dbw 24, CRUNCH
	dbw 29, FEINT_ATTACK ; Assurance → similar move
	dbw 34, SUPER_FANG
	dbw 39, DOUBLE_EDGE
	dbw 44, COUNTER ; Endeavor → egg move
	db -1 ; no more level-up moves

.RaichuAlolanEvosAttacks
	db -1 ; no more evolutions
	dbw 1, THUNDERSHOCK
	dbw 1, LEER ; Tail Whip → similar move
	dbw 1, QUICK_ATTACK
	dbw 1, THUNDERBOLT
	dbw 1, PSYCHIC_M ; evolution move
	dbw 1, REVERSAL ; Sw/Sh move
	db -1 ; no more level-up moves

.SandshrewAlolanEvosAttacks
	evo_data EVOLVE_ITEM, ICE_STONE, SANDSLASH, ALOLAN_FORM
	db -1 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, DEFENSE_CURL
	dbw 3, FOCUS_ENERGY ; Bide → new move
	dbw 5, ICY_WIND ; Powder Snow → similar move
	dbw 7, DEFENSE_CURL ; Ice Ball → TM move
	dbw 9, RAPID_SPIN
	dbw 11, PIN_MISSILE ; Fury Cutter → new move
	dbw 14, METAL_CLAW
	dbw 17, SWIFT
	dbw 20, FURY_STRIKES ; Fury Swipes → similar move
	dbw 23, ROLLOUT ; Iron Defense → TM move
	dbw 26, SLASH
	dbw 30, IRON_HEAD
	dbw 34, GYRO_BALL
	dbw 38, SWORDS_DANCE
	dbw 42, HAIL
	dbw 46, BLIZZARD
	db -1 ; no more level-up moves

.SandslashAlolanEvosAttacks
	db -1 ; no more evolutions
	dbw 1, ICICLE_SPEAR ; evolution move
	dbw 1, COUNTER ; Metal Burst → similar move
	dbw 1, MIRROR_COAT ; Metal Burst → similar move
	dbw 1, ICICLE_CRASH ; evolution move
	dbw 1, SLASH
	dbw 1, DEFENSE_CURL
	dbw 1, ROLLOUT ; Ice Ball → TM move
	dbw 1, METAL_CLAW
	dbw 48, HAIL
	dbw 53, BLIZZARD
	db -1 ; no more level-up moves

.VulpixAlolanEvosAttacks
	evo_data EVOLVE_ITEM, ICE_STONE, NINETALES, ALOLAN_FORM
	db -1 ; no more evolutions
	dbw 1, ICY_WIND ; Powder Snow → similar move
	dbw 4, GROWL ; Tail Whip → new move
	dbw 7, ROAR
	dbw 9, CHARM ; Baby-Doll Eyes → similar move
	dbw 10, ICE_SHARD
	dbw 12, CONFUSE_RAY
	dbw 15, DISARM_VOICE ; Icy Wind → new move
	dbw 18, NIGHT_SHADE ; Payback → new move
	dbw 20, HAIL ; Mist → TM move
	dbw 23, FEINT_ATTACK
	dbw 26, HEX
	dbw 28, AURORA_BEAM
	dbw 31, EXTRASENSORY
	dbw 34, SAFEGUARD
	dbw 36, ICE_BEAM
	dbw 39, HYPNOSIS ; Imprison → egg move
	dbw 42, BLIZZARD
	dbw 44, SHADOW_BALL ; Grudge → TM move
	dbw 47, DISABLE ; Captivate → egg move
	dbw 50, MOONBLAST ; Sheer Cold → egg move
	dbw 53, HEALINGLIGHT ; new move
	db -1 ; no more level-up moves

.NinetalesAlolanEvosAttacks
	db -1 ; no more evolutions
	dbw 1, DAZZLINGLEAM ; evolution move
	dbw 1, NASTY_PLOT
	dbw 1, ICE_BEAM
	dbw 1, ICE_SHARD
	dbw 1, CONFUSE_RAY
	dbw 1, SAFEGUARD
	db -1 ; no more level-up moves

.DiglettAlolanEvosAttacks
	evo_data EVOLVE_LEVEL, 26, DUGTRIO, ALOLAN_FORM
	db -1 ; no more evolutions
	dbw 1, MUD_SLAP ; Sand Attack → Mud-Slap
	dbw 1, METAL_CLAW
	dbw 1, CHARM ; XD move
	dbw 4, GROWL
	dbw 7, ASTONISH
	dbw 10, AGILITY ; Mud-Slap → LGPE move
	dbw 14, MAGNITUDE
	dbw 18, BULLDOZE
	dbw 22, SUCKER_PUNCH
	dbw 25, ANCIENTPOWER ; Mud Bomb → egg move
	dbw 28, EARTH_POWER
	dbw 31, DIG
	dbw 35, IRON_HEAD
	dbw 39, EARTHQUAKE
	dbw 43, NIGHT_SLASH ; Fissure → Dugtrio move
	db -1 ; no more level-up moves

.DugtrioAlolanEvosAttacks
	db -1 ; no more evolutions
	dbw 1, TRI_ATTACK ; Sand Tomb → Tri Attack ; evolution move
	dbw 1, NIGHT_SLASH
	dbw 1, MUD_SLAP ; Sand Attack → Mud-Slap
	dbw 1, METAL_CLAW
	dbw 1, CHARM ; XD move
	dbw 4, GROWL
	dbw 7, ASTONISH
	dbw 10, AGILITY ; Mud-Slap → LGPE move
	dbw 14, MAGNITUDE
	dbw 18, BULLDOZE
	dbw 22, SUCKER_PUNCH
	dbw 25, ANCIENTPOWER ; Mud Bomb → egg move
	dbw 30, EARTH_POWER
	dbw 35, DIG
	dbw 41, IRON_HEAD
	dbw 47, EARTHQUAKE
	dbw 53, NIGHT_SLASH ; Fissure → Night Slash
	db -1 ; no more level-up moves

.MeowthAlolanEvosAttacks
	evo_data EVOLVE_LEVEL, 28, PERSIAN, ALOLAN_FORM
	db -1 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, GROWL
	dbw 6, BITE
	dbw 9, ASTONISH ; Fake Out → new move
	dbw 14, FURY_STRIKES ; Fury Swipes → similar move
	dbw 17, SCREECH
	dbw 22, FEINT_ATTACK
	dbw 25, PURSUIT ; Taunt → egg move
	dbw 30, PAY_DAY
	dbw 33, SLASH
	dbw 38, NASTY_PLOT
	dbw 41, THIEF ; Assurance → TM move
	dbw 46, CHARM ; Captivate → egg move
	dbw 49, NIGHT_SLASH
	dbw 55, DARK_PULSE
	db -1 ; no more level-up moves

.PersianAlolanEvosAttacks
	db -1 ; no more evolutions
	dbw 1, BUBBLE_BEAM ; RBY TM move
	dbw 1, PLAY_ROUGH
	dbw 1, SWIFT ; evolution move
	dbw 1, SCRATCH
	dbw 1, GROWL
	dbw 6, BITE
	dbw 9, ASTONISH ; Fake Out → new move
	dbw 14, FURY_STRIKES ; Fury Swipes → similar move
	dbw 17, SCREECH
	dbw 22, FEINT_ATTACK
	dbw 25, PURSUIT ; Taunt → egg move
	dbw 32, POWER_GEM
	dbw 37, SLASH
	dbw 44, NASTY_PLOT
	dbw 49, THIEF ; Assurance → TM move
	dbw 56, CHARM ; Captivate → egg move
	dbw 61, NIGHT_SLASH
	dbw 65, DARK_PULSE
	db -1 ; no more level-up moves

.GeodudeAlolanEvosAttacks
	evo_data EVOLVE_LEVEL, 25, GRAVELER, ALOLAN_FORM
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, DEFENSE_CURL
	dbw 4, THUNDERSHOCK ; Charge → new move
	dbw 6, RAPID_SPIN ; Rock Polish → event move
	dbw 10, ROLLOUT
	dbw 12, SPARK
	dbw 16, ROCK_THROW
	dbw 18, ANCIENTPOWER ; Smack Down → HGSS tutor move
	dbw 22, THUNDERPUNCH
	dbw 24, ROCK_BLAST ; Self-Destruct → Rock Blast
	dbw 28, SANDSTORM ; Stealth Rock → TM move
	dbw 30, ROCK_SLIDE ; Rock Blast → TM move
	dbw 34, WILD_CHARGE ; Discharge → new move
	dbw 36, EXPLOSION
	dbw 40, DOUBLE_EDGE
	dbw 42, STONE_EDGE
	db -1 ; no more level-up moves

.GravelerAlolanEvosAttacks
	evo_data EVOLVE_ITEM, LINKING_CORD, GOLEM, ALOLAN_FORM
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, DEFENSE_CURL
	dbw 4, THUNDERSHOCK ; Charge → new move
	dbw 6, RAPID_SPIN ; Rock Polish → event move
	dbw 10, ROLLOUT
	dbw 12, SPARK
	dbw 16, ROCK_THROW
	dbw 18, ANCIENTPOWER ; Smack Down → HGSS tutor move
	dbw 22, THUNDERPUNCH
	dbw 24, ROCK_BLAST ; Self-Destruct → Rock Blast
	dbw 30, SANDSTORM ; Stealth Rock → TM move
	dbw 34, ROCK_SLIDE ; Rock Blast → TM move
	dbw 40, WILD_CHARGE ; Discharge → new move
	dbw 44, EXPLOSION
	dbw 50, DOUBLE_EDGE
	dbw 54, STONE_EDGE
	db -1 ; no more level-up moves

.GolemAlolanEvosAttacks
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, DEFENSE_CURL
	dbw 4, THUNDERSHOCK ; Charge → new move
	dbw 6, RAPID_SPIN ; Rock Polish → event move
	dbw 10, ROLLOUT
	dbw 12, SPARK
	dbw 16, ROCK_THROW
	dbw 18, ANCIENTPOWER ; Smack Down → HGSS tutor move
	dbw 22, THUNDERPUNCH
	dbw 24, ROCK_BLAST ; Self-Destruct → Rock Blast
	dbw 30, SANDSTORM ; Stealth Rock → TM move
	dbw 34, ROCK_SLIDE ; Rock Blast → TM move
	dbw 40, WILD_CHARGE ; Discharge → new move
	dbw 44, EXPLOSION
	dbw 50, DOUBLE_EDGE
	dbw 54, STONE_EDGE
	dbw 60, GYRO_BALL ; Heavy Slam → similar move
	db -1 ; no more level-up moves

.GrimerAlolanEvosAttacks
	evo_data EVOLVE_LEVEL, 38, MUK, ALOLAN_FORM
	db -1 ; no more evolutions
	dbw 1, TACKLE ; Pound → similar move
	dbw 1, ACID ; Poison Gas → new move
	dbw 4, DEFENSE_CURL ; Harden → similar move
	dbw 7, BITE
	dbw 12, DISABLE
	dbw 15, VENOSHOCK ; Acid Spray → tutor move
	dbw 18, HAZE ; Poison Fang → egg move
	dbw 21, MINIMIZE
	dbw 26, FEINT_ATTACK ; Fling → new move
	dbw 29, KNOCK_OFF
	dbw 32, CRUNCH
	dbw 37, SCREECH
	dbw 40, GUNK_SHOT
	dbw 43, PAIN_SPLIT ; Acid Armor → HGSS tutor move
	dbw 46, TOXIC_SPIKES ; Belch → SV TM move
	db -1 ; no more level-up moves

.MukAlolanEvosAttacks
	db -1 ; no more evolutions
	dbw 1, MOONBLAST ; LGPE move
	dbw 1, TACKLE ; Pound → similar move
	dbw 1, ACID ; Poison Gas → new move
	dbw 4, DEFENSE_CURL ; Harden → similar move
	dbw 7, BITE
	dbw 12, DISABLE
	dbw 15, VENOSHOCK ; Acid Spray → tutor move
	dbw 18, HAZE ; Poison Fang → egg move
	dbw 21, MINIMIZE
	dbw 26, FEINT_ATTACK ; Fling → new move
	dbw 29, KNOCK_OFF
	dbw 32, CRUNCH
	dbw 37, SCREECH
	dbw 40, GUNK_SHOT
	dbw 46, PAIN_SPLIT ; Acid Armor → HGSS tutor move
	dbw 52, TOXIC_SPIKES ; Belch → SV TM move
	db -1 ; no more level-up moves

.ExeggutorAlolanEvosAttacks
	db -1 ; no more evolutions
	dbw 1, TACKLE ; Barrage → new move
	dbw 1, HYPNOSIS
	dbw 1, CONFUSION
	dbw 1, DRAGON_PULSE ; evolution move
	dbw 17, DRAGON_RAGE ; Psyshock → new move
	dbw 27, ZEN_HEADBUTT ; Egg Bomb → tutor move
	dbw 37, POWER_WHIP ; Wood Hammer → new move
	dbw 47, OUTRAGE ; Leaf Storm → S/M TM move
	db -1 ; no more level-up moves

.MarowakAlolanEvosAttacks
	db -1 ; no more evolutions
	dbw 1, SWORDS_DANCE ; evolution move
	dbw 1, GROWL
	dbw 3, TACKLE ; Tail Whip → new move
	dbw 7, ASTONISH ; Bone Club → new move
	dbw 11, FIRE_SPIN ; Flame Wheel → LGPE move
	dbw 13, LEER
	dbw 17, HEX
	dbw 21, BONEMERANG
	dbw 23, WILL_O_WISP
	dbw 27, SHADOW_CLAW ; Shadow Bone → similar move
	dbw 33, THRASH
	dbw 37, KNOCK_OFF ; Fling → TM move
	dbw 43, ACROBATICS ; Stomping Tantrum → new move
	dbw 49, ROCK_SMASH ; Endeavor → TM move
	dbw 53, FLARE_BLITZ
	dbw 59, PAIN_SPLIT ; Retaliate → S/M tutor move
	dbw 65, OUTRAGE ; Bone Rush → HGSS tutor move
	db -1 ; no more level-up moves

.MeowthGalarianEvosAttacks
	evo_data EVOLVE_LEVEL, 28, PERRSERKER, PLAIN_FORM
	db -1 ; no more evolutions
	dbw 1, ASTONISH ; Fake Out → new move
	dbw 1, GROWL
	dbw 4, HONE_CLAWS
	dbw 8, SCRATCH
	dbw 12, PAY_DAY
	dbw 16, METAL_CLAW
	dbw 20, PURSUIT ; Taunt → new move
	dbw 24, SWAGGER
	dbw 29, FURY_STRIKES ; Fury Swipes → similar move
	dbw 32, SCREECH
	dbw 36, SLASH
	dbw 40, CRUNCH ; Metal Sound → TR move
	dbw 44, THRASH
	db -1 ; no more level-up moves

.PonytaGalarianEvosAttacks
	evo_data EVOLVE_LEVEL, 40, RAPIDASH, GALARIAN_FORM
	db -1 ; no more evolutions
	dbw 1, GROWL
	dbw 1, TACKLE
	dbw 4, LEER ; Tail Whip → similar move
	dbw 9, CONFUSION
	dbw 13, DISARM_VOICE ; Fairy Wind → similar move
	dbw 17, STOMP
	dbw 21, HEALINGLIGHT ; Heal Pulse → similar move
	dbw 25, PSYBEAM
	dbw 29, TAKE_DOWN
	dbw 33, DAZZLINGLEAM
	dbw 37, AGILITY
	dbw 41, PSYCHIC_M
	dbw 45, EXTREMESPEED ; Bounce → new move
	dbw 49, MOONBLAST ; Healing Wish → new move
	db -1 ; no more level-up moves

.RapidashGalarianEvosAttacks
	db -1 ; no more evolutions
	dbw 1, PLAY_ROUGH ; evolution move
	dbw 1, MEGAHORN
	dbw 1, GROWL
	dbw 1, TACKLE
	dbw 4, LEER ; Tail Whip → similar move
	dbw 9, CONFUSION
	dbw 13, DISARM_VOICE ; Fairy Wind → similar move
	dbw 17, STOMP
	dbw 21, HEALINGLIGHT ; Heal Pulse → similar move
	dbw 25, PSYBEAM
	dbw 29, TAKE_DOWN
	dbw 33, DAZZLINGLEAM
	dbw 37, AGILITY
	dbw 41, PSYCHIC_M
	dbw 45, EXTREMESPEED ; Bounce → new move
	dbw 49, MOONBLAST ; Healing Wish → new move
	db -1 ; no more level-up moves

.SlowpokeGalarianEvosAttacks
	evo_data EVOLVE_HOLDING, KINGS_ROCK, TR_ANYTIME, SLOWKING, GALARIAN_FORM
	evo_data EVOLVE_LEVEL, 37, SLOWBRO, GALARIAN_FORM
	db -1 ; no more evolutions
	dbw 1, CURSE
	dbw 1, TACKLE
	dbw 5, GROWL
	dbw 9, ACID
	dbw 14, CONFUSION
	dbw 19, DISABLE
	dbw 23, HEADBUTT
	dbw 28, WATER_PULSE
	dbw 32, ZEN_HEADBUTT
	dbw 36, SAFEGUARD ; Slack Off → egg move
	dbw 41, AMNESIA
	dbw 45, PSYCHIC_M
	dbw 49, RAIN_DANCE
	dbw 54, BELLY_DRUM ; Psych Up → egg move
	dbw 58, RECOVER ; Heal Pulse → similar move
	db -1 ; no more level-up moves

.SlowbroGalarianEvosAttacks
	db -1 ; no more evolutions
	dbw 1, GUNK_SHOT ; Shell Side Arm → similar move ; evolution move
	dbw 1, CURSE
	dbw 1, TACKLE
	dbw 5, GROWL
	dbw 9, ACID
	dbw 14, CONFUSION
	dbw 19, DISABLE
	dbw 23, HEADBUTT
	dbw 28, WATER_PULSE
	dbw 32, ZEN_HEADBUTT
	dbw 36, SAFEGUARD ; Slack Off → egg move
	dbw 43, AMNESIA
	dbw 49, PSYCHIC_M
	dbw 55, RAIN_DANCE
	dbw 62, BELLY_DRUM ; Psych Up → egg move
	dbw 68, RECOVER ; Heal Pulse → similar move
	db -1 ; no more level-up moves

.FarfetchDGalarianEvosAttacks
	evo_data EVOLVE_CRIT, TR_ANYTIME, SIRFETCH_D, PLAIN_FORM
	db -1 ; no more evolutions
	dbw 1, PECK
	dbw 1, MUD_SLAP ; Sand Attack → similar move
	dbw 5, LEER
	dbw 10, QUICK_ATTACK ; Fury Cutter → egg move
if DEF(FAITHFUL)
	dbw 15, ROCK_SMASH
else
	dbw 15, REVERSAL ; Rock Smash → TM move
endc
	dbw 20, FEINT_ATTACK ; Brutal Swing → similar move
	dbw 25, PROTECT ; Detect → similar move
	dbw 30, KNOCK_OFF
	dbw 35, STEEL_WING ; Defog → TM move
if DEF(FAITHFUL)
	dbw 40, NIGHT_SLASH ; Brick Break → egg move
else
	dbw 40, ROCK_SMASH ; Brick Break
endc
	dbw 45, SWORDS_DANCE
	dbw 50, BODY_SLAM ; Slam → TR move
	dbw 55, POISON_JAB ; Leaf Blade → TR move
	dbw 60, CLOSE_COMBAT ; Final Gambit → TR move
	dbw 65, BRAVE_BIRD
	db -1 ; no more level-up moves

.WeezingGalarianEvosAttacks
	db -1 ; no more evolutions
	dbw 1, SAFEGUARD ; evolution move
	dbw 1, TACKLE
	dbw 4, GUST ; Smog → new move
	dbw 7, SMOKESCREEN
	dbw 12, ENDURE ; Assurance → TM move
	dbw 15, WILL_O_WISP ; Clear Smog → TM move
	dbw 18, SCREECH ; Sludge → Sw/Sh TM move
	dbw 23, RAGE ; Self-Destruct → RBY TM move
	dbw 26, HAZE ; Aromatherapy → Kantonian move
	dbw 29, GYRO_BALL
	dbw 34, PLAY_ROUGH ; Sludge Bomb → Sw/Sh TR move
	dbw 40, EXPLOSION
	dbw 46, DESTINY_BOND
	dbw 51, PAIN_SPLIT ; Belch → HGSS tutor move
	dbw 57, MOONBLAST ; Memento → new move
	db -1 ; no more level-up moves

.MrMimeGalarianEvosAttacks
	evo_data EVOLVE_LEVEL, 42, MR__RIME
	db -1 ; no more evolutions
	dbw 1, RECOVER ; Slack Off → similar move
	dbw 1, ENCORE
	dbw 1, PROTECT
	dbw 1, LIGHT_SCREEN
	dbw 1, REFLECT
	dbw 1, SAFEGUARD
	dbw 1, DAZZLINGLEAM
	dbw 1, TACKLE ; Pound → similar move
	dbw 1, RAPID_SPIN
	dbw 1, BATON_PASS
	dbw 1, ICE_SHARD
	dbw 12, CONFUSION
	dbw 16, METRONOME ; Ally Switch → TR move
	dbw 20, ICY_WIND
	dbw 24, DOUBLE_KICK
	dbw 28, PSYBEAM
	dbw 32, HYPNOSIS
	dbw 36, MIRROR_COAT
	dbw 40, SUCKER_PUNCH
	dbw 44, ICE_BEAM ; Freeze-Dry → TR move
	dbw 48, PSYCHIC_M
	dbw 52, CONFUSE_RAY ; Teeter Dance → egg move
	db -1 ; no more level-up moves

.ArticunoGalarianEvosAttacks
	db -1 ; no more evolutions
	dbw 1, GUST
	dbw 1, CONFUSION
	dbw 1, LEER ; LGPE move
	dbw 8, SAFEGUARD ; Psycho Shift → new move
	dbw 15, HYPNOSIS
	dbw 22, EXTRASENSORY ; Mind Reader → event move
	dbw 29, ANCIENTPOWER
	dbw 36, AGILITY
	dbw 43, PSYCHIC_M ; Freezing Glare → TM move
	dbw 50, AIR_SLASH ; Reflect → new move
	dbw 57, DREAM_EATER
	dbw 64, REFLECT ; Tailwind → Reflect
	dbw 71, FUTURE_SIGHT
	dbw 78, BRAVE_BIRD ; Sheer Cold → TR move
	dbw 85, RECOVER
	dbw 92, HURRICANE
	dbw 99, AEROBLAST ; new move
	db -1 ; no more level-up moves

.ZapdosGalarianEvosAttacks
	db -1 ; no more evolutions
	dbw 1, PECK
	dbw 1, LOW_KICK ; Rock Smash → TR move
	dbw 1, LEER ; LGPE move
	dbw 8, FOCUS_ENERGY
	dbw 15, PROTECT ; Detect → similar move
	dbw 22, COUNTER ; Pluck → Counter
	dbw 29, ANCIENTPOWER
	dbw 36, AGILITY ; Charge → Agility
	dbw 43, ROCK_SMASH ; Agility → Rock Smash/Brick Break
	dbw 50, DRILL_PECK ; Discharge → Drill Peck
	dbw 57, BULK_UP
	dbw 64, LIGHT_SCREEN
	dbw 71, CLOSE_COMBAT
	dbw 78, BRAVE_BIRD ; Counter → TR move
	dbw 85, HI_JUMP_KICK ; Quick Guard → new move
	dbw 92, HURRICANE
	dbw 99, REVERSAL
	db -1 ; no more level-up moves

.MoltresGalarianEvosAttacks
	db -1 ; no more evolutions
	dbw 1, GUST
	dbw 1, PURSUIT ; Payback → new move
	dbw 1, LEER
	dbw 8, FEINT_ATTACK ; new move
	dbw 15, SAFEGUARD
	dbw 22, WING_ATTACK
	dbw 29, ANCIENTPOWER
	dbw 36, AGILITY ; Flamethrower → Agility
	dbw 43, SUCKER_PUNCH
	dbw 50, AIR_SLASH
	dbw 57, NASTY_PLOT ; After You → Nasty Plot
	dbw 64, DARK_PULSE ; Fiery Wrath → similar move
	dbw 71, HEX ; Nasty Plot → TR move
	dbw 78, BRAVE_BIRD ; Sky Attack → new move
	dbw 85, PAIN_SPLIT ; Memento → new move
	dbw 92, HURRICANE
	dbw 99, NIGHT_SLASH ; new move
	db -1 ; no more level-up moves

.SlowkingGalarianEvosAttacks
	db -1 ; no more evolutions
	dbw 1, HEX ; Eerie Spell → Sw/Sh TR move ; evolution move
	dbw 1, POWER_GEM
	dbw 1, HIDDEN_POWER
	dbw 1, CURSE
	dbw 1, TACKLE
	dbw 5, GROWL
	dbw 9, ACID
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

.CorsolaGalarianEvosAttacks
	evo_data EVOLVE_LEVEL, 38, CURSOLA, PLAIN_FORM
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, DEFENSE_CURL ; Harden → similar move
	dbw 5, ASTONISH
	dbw 10, DISABLE
	dbw 15, HAZE ; Spite → egg move
	dbw 20, ANCIENTPOWER
	dbw 25, HEX
	dbw 30, CURSE
	dbw 35, GIGA_DRAIN ; Strength Sap → TM move
	dbw 40, POWER_GEM
	dbw 45, NIGHT_SHADE
	dbw 50, HYDRO_PUMP ; Grudge → TR move
	dbw 55, MIRROR_COAT
	db -1 ; no more level-up moves

.GrowlitheHisuianEvosAttacks
	evo_data EVOLVE_ITEM, FIRE_STONE, ARCANINE, HISUIAN_FORM
	db -1 ; no more evolutions
	dbw 1, GROWL
	dbw 1, BITE
	dbw 1, ROAR
	dbw 6, EMBER
	dbw 8, LEER
	dbw 10, SAFEGUARD ; Odor Sleuth → egg move
	dbw 12, BATON_PASS ; Helping Hand → new move
	dbw 17, FIRE_SPIN ; Flame Wheel → egg move
	dbw 19, REVERSAL
	dbw 21, ROCK_BLAST ; Fire Fang → new move
	dbw 23, TAKE_DOWN
	dbw 28, FLAME_CHARGE ; Flame Burst → TM move
	dbw 30, AGILITY
	dbw 32, ROCK_SLIDE
	dbw 34, FLAMETHROWER
	dbw 39, CRUNCH
	dbw 41, POWER_GEM ; Heat Wave → new move
	dbw 43, OUTRAGE
	dbw 45, PLAY_ROUGH ; Flare Blitz → LGPE move
	dbw 49, FLARE_BLITZ
	db -1 ; no more level-up moves

.ArcanineHisuianEvosAttacks
	db -1 ; no more evolutions
	dbw 1, BULK_UP ; new move
	dbw 1, GROWL
	dbw 1, BITE
	dbw 1, ROAR
	dbw 1, FLAME_CHARGE
	dbw 1, TAKE_DOWN
	dbw 1, EXTREMESPEED ; evolution move
	db -1 ; no more level-up moves

.VoltorbHisuianEvosAttacks
	evo_data EVOLVE_ITEM, LEAF_STONE, ELECTRODE, HISUIAN_FORM
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, THUNDERSHOCK ; LGPE move
	dbw 1, ABSORB ; new move
	dbw 4, SONIC_BOOM
	dbw 6, AGILITY ; Eerie Impulse → event move
	dbw 9, SPARK
	dbw 11, ROLLOUT
	dbw 13, SCREECH
	dbw 16, THUNDER_WAVE ; Charge Beam → TM move
	dbw 20, SWIFT
	dbw 22, THUNDERBOLT ; Electro Ball → TM move
	dbw 26, ENERGY_BALL
	dbw 29, LIGHT_SCREEN
	dbw 34, EXPLOSION ; Magnet Rise → Explosion
	dbw 37, THUNDER ; Discharge → TM move
	dbw 41, SOLAR_BEAM ; Chloroblast → TM move
	dbw 46, GYRO_BALL
	dbw 48, MIRROR_COAT
	db -1 ; no more level-up moves

.ElectrodeHisuianEvosAttacks
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, THUNDERSHOCK ; LGPE move
	dbw 1, ABSORB ; new move
	dbw 4, SONIC_BOOM
	dbw 6, AGILITY ; Eerie Impulse → event move
	dbw 9, SPARK
	dbw 11, ROLLOUT
	dbw 13, SCREECH
	dbw 16, THUNDER_WAVE ; Charge Beam → TM move
	dbw 20, SWIFT
	dbw 22, THUNDERBOLT ; Electro Ball → TM move
	dbw 26, ENERGY_BALL
	dbw 29, LIGHT_SCREEN
	dbw 36, EXPLOSION ; Magnet Rise → Explosion
	dbw 41, THUNDER ; Discharge → TM move
	dbw 47, SOLAR_BEAM ; Chloroblast → TM move
	dbw 54, GYRO_BALL
	dbw 58, MIRROR_COAT
	db -1 ; no more level-up moves

.TyphlosionHisuianEvosAttacks
	db -1 ; no more evolutions
	dbw 1, SHADOW_CLAW ; evolution move
	dbw 1, ASTONISH ; new move
	dbw 1, TACKLE
	dbw 1, LEER
	dbw 6, SMOKESCREEN
	dbw 10, EMBER
	dbw 13, QUICK_ATTACK
	dbw 20, DEFENSE_CURL ; Flame Wheel → Defense Curl
	dbw 24, FLAME_CHARGE ; Defense Curl → Flame Charge
	dbw 31, SWIFT
	dbw 35, HEX
	dbw 43, WILL_O_WISP ; Lava Plume → TM move
	dbw 48, FLAMETHROWER
	dbw 56, SHADOW_BALL
	dbw 61, ROLLOUT
	dbw 69, DOUBLE_EDGE
	dbw 74, DARK_PULSE ; Infernal Parade → new move
	dbw 81, FLARE_BLITZ ; Eruption → egg move
	db -1 ; no more level-up moves

.QwilfishHisuianEvosAttacks
	evo_data EVOLVE_LEVEL, 33, OVERQWIL
	db -1 ; no more evolutions
	dbw 1, AQUA_JET ; Water Gun → SV TM move
	dbw 1, SPIKES
	dbw 1, TACKLE
	dbw 1, POISON_STING
	dbw 5, DEFENSE_CURL ; Harden → TM move
	dbw 9, MINIMIZE
	dbw 13, PIN_MISSILE
	dbw 17, ROLLOUT
	dbw 21, TOXIC_SPIKES
	dbw 25, PAIN_SPLIT ; Stockpile + Spit Up → HGSS move tutor
	dbw 29, REVERSAL ; Revenge → Sw/Sh move
	dbw 33, WATER_PULSE ; Brine → TM move
	dbw 37, CRUNCH ; Dark Pulse → SV TM move
	dbw 41, TAKE_DOWN
	dbw 45, AQUA_TAIL
	dbw 49, POISON_JAB
	dbw 53, DESTINY_BOND
	dbw 57, EXPLOSION ; Self-Destruct → similar move
	dbw 60, DOUBLE_EDGE ; Fell Stinger → event move
	db -1 ; no more level-up moves

.SneaselHisuianEvosAttacks
	evo_data EVOLVE_HOLDING, RAZOR_CLAW, TR_MORNDAY, SNEASLER
	db -1 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, LEER
	dbw 1, BITE ; Taunt → egg move
	dbw 8, QUICK_ATTACK
	dbw 10, FEINT_ATTACK
	dbw 14, LOW_KICK ; Rock Smash → Low Kick
	dbw 16, FURY_STRIKES ; Fury Swipes → similar move
	dbw 20, AGILITY
	dbw 22, METAL_CLAW
	dbw 25, HONE_CLAWS
	dbw 28, POISON_JAB
	dbw 32, SCREECH
	dbw 35, SLASH
	dbw 40, SWORDS_DANCE
	dbw 44, X_SCISSOR ; Punishment → TM move
	dbw 47, CLOSE_COMBAT
	dbw 50, GUNK_SHOT ; SV TM move
	db -1 ; no more level-up moves

.WooperPaldeanEvosAttacks
	evo_data EVOLVE_LEVEL, 20, CLODSIRE
	db -1 ; no more evolutions
	dbw 1, MUD_SLAP ; Mud Shot → similar move
	dbw 1, LEER ; Tail Whip → similar move
	dbw 5, TACKLE
	dbw 9, POISON_STING ; Poison Tail → similar move
	dbw 15, HEADBUTT ; Slam → tutor move
	dbw 19, RECOVER ; Mud Bomb → egg move
	dbw 23, AMNESIA
	dbw 29, BELLY_DRUM ; Yawn → event move
	dbw 33, EARTHQUAKE
	dbw 37, POISON_JAB
	dbw 43, TOXIC_SPIKES
	dbw 47, GUNK_SHOT ; Sludge Wave → similar move
	db -1 ; no more level-up moves

.TaurosPaldeanEvosAttacks
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 3, LEER ; Tail Whip → similar move
	dbw 5, RAGE
	dbw 8, HEADBUTT
	dbw 11, SCARY_FACE
	dbw 15, PURSUIT
	dbw 19, REST
	dbw 24, DOUBLE_KICK
	dbw 29, FOCUS_ENERGY ; Work Up → LGPE move
	dbw 35, TAKE_DOWN
	dbw 41, ZEN_HEADBUTT
	dbw 48, SWAGGER
	dbw 55, THRASH
	dbw 63, DOUBLE_EDGE
	dbw 71, CLOSE_COMBAT
	dbw 80, OUTRAGE ; HGSS tutor move
	db -1 ; no more level-up moves

.TaurosPaldeanFireEvosAttacks
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 3, LEER ; Tail Whip → similar move
	dbw 5, RAGE
	dbw 8, HEADBUTT
	dbw 11, SCARY_FACE
	dbw 15, FLAME_CHARGE
	dbw 19, REST
	dbw 24, DOUBLE_KICK
	dbw 29, FOCUS_ENERGY ; Work Up → LGPE move
	dbw 35, TAKE_DOWN
	dbw 41, ZEN_HEADBUTT
	dbw 48, SWAGGER
	dbw 55, THRASH
	dbw 63, FLARE_BLITZ
	dbw 71, CLOSE_COMBAT
	dbw 80, OUTRAGE ; HGSS tutor move
	db -1 ; no more level-up moves

.TaurosPaldeanWaterEvosAttacks
	db -1 ; no more evolutions
	dbw 1, TACKLE
	dbw 3, LEER ; Tail Whip → similar move
	dbw 5, RAGE
	dbw 8, HEADBUTT
	dbw 11, SCARY_FACE
	dbw 15, AQUA_JET
	dbw 19, REST
	dbw 24, DOUBLE_KICK
	dbw 29, FOCUS_ENERGY ; Work Up → LGPE move
	dbw 35, TAKE_DOWN
	dbw 41, ZEN_HEADBUTT
	dbw 48, SWAGGER
	dbw 55, THRASH
	dbw 63, AQUA_TAIL ; Wave Crash → tutor move
	dbw 71, CLOSE_COMBAT
	dbw 80, OUTRAGE ; HGSS tutor move
	db -1 ; no more level-up moves

.UrsalunaBloodmoonEvoAttacks
	db -1 ; no more evolutions
	dbw 1, BULLDOZE ; evolution move
	dbw 1, GUNK_SHOT ; HGSS tutor move
	dbw 1, THIEF ; Covet → TM move
	dbw 1, SCRATCH
	dbw 1, LEER
	dbw 1, LICK
	dbw 1, HEALINGLIGHT ; Moonlight → similar move
	dbw 8, FURY_STRIKES ; Fury Swipes → similar move
	dbw 15, FEINT_ATTACK
	dbw 22, DEFENSE_CURL ; Harden → similar move
	dbw 25, SHADOW_BALL ; new move
	dbw 29, SLASH
	dbw 38, SCARY_FACE
	dbw 47, REST
	dbw 49, NIGHT_SLASH ; Snore → egg move
	dbw 58, MOONBLAST
	dbw 67, FOCUS_BLAST ; Hammer Arm → SV TM move
	dbw 76, HYPER_BEAM ; Blood Moon → SV TM move
	dbw 85, GUNK_SHOT ; SV TM move
	db -1 ; no more level-up moves
