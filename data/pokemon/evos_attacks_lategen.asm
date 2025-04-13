SECTION "Evolutions and Attacks LateGen", ROMX

EvosAttacksPointersLateGen::
	dw AzurillEvosAttacks
	dw WynautEvosAttacks
	dw AmbipomEvosAttacks
	dw EggEvosAttacks
	dw EggEvosAttacks ; $100
	dw MismagiusEvosAttacks
	dw HonchkrowEvosAttacks
	dw BonslyEvosAttacks
	dw MimeJrEvosAttacks
	dw HappinyEvosAttacks
	dw MunchlaxEvosAttacks
	dw MantykeEvosAttacks
	dw WeavileEvosAttacks
	dw MagnezoneEvosAttacks
	dw LickilickyEvosAttacks
	dw RhyperiorEvosAttacks
	dw TangrowthEvosAttacks
	dw ElectivireEvosAttacks
	dw MagmortarEvosAttacks
	dw TogekissEvosAttacks
	dw YanmegaEvosAttacks
	dw LeafeonEvosAttacks
	dw GlaceonEvosAttacks
	dw GliscorEvosAttacks
	dw MamoswineEvosAttacks
	dw PorygonZEvosAttacks
	dw SylveonEvosAttacks
	dw PerrserkerEvosAttacks
	dw CursolaEvosAttacks
	dw SirfetchDEvosAttacks
	dw MrRimeEvosAttacks
	dw WyrdeerEvosAttacks
	dw KleavorEvosAttacks
	dw UrsalunaPlainEvosAttacks
	dw SneaslerEvosAttacks
	dw OverqwilEvosAttacks
	dw DudunsparceEvosAttacks
	dw FarigirafEvosAttacks
	dw ClodsireEvosAttacks
	dw AnnihilapeEvosAttacks
.IndirectEnd::

	evos_attacks Azurill
	evo_data EVOLVE_HAPPINESS, TR_ANYTIME, MARILL
	learnset 1, SPLASH
	learnset 1, WATER_GUN
	learnset 2, GROWL ; Tail Whip → new move
	learnset 5, FORESIGHT ; Water Sport → Marill egg move
	learnset 7, AQUA_JET ; Bubble → egg move
	learnset 10, CHARM
	learnset 13, BUBBLE_BEAM
	learnset 16, SING ; Helping Hand → egg move
	learnset 20, ROLLOUT ; Slam → tutor move
	learnset 23, BODY_SLAM ; Bounce → egg move

	evos_attacks Wynaut
	evo_data EVOLVE_LEVEL, 15, WOBBUFFET
	learnset 1, SPLASH
	learnset 1, CHARM
	learnset 1, ENCORE
	learnset 1, AMNESIA
	learnset 1, COUNTER
	learnset 1, MIRROR_COAT
	learnset 1, SAFEGUARD
	learnset 1, DESTINY_BOND

	evos_attacks Ambipom
	learnset 1, HEADBUTT ; Dual Chop → tutor move
	learnset 1, SCRATCH
	learnset 1, LEER ; Tail Whip → similar move
	learnset 4, MUD_SLAP ; Sand Attack → similar move
	learnset 8, ASTONISH
	learnset 11, BATON_PASS
	learnset 15, THIEF ; Tickle → TM move
	learnset 18, FURY_STRIKES ; Fury Swipes → similar move
	learnset 22, SWIFT
	learnset 25, SCREECH
	learnset 29, AGILITY
	learnset 32, DOUBLE_SLAP ; Double Hit → egg move
	learnset 36, ACROBATICS ; Fling → TM move
	learnset 39, NASTY_PLOT
	learnset 43, DOUBLE_EDGE ; Last Resort → tutor move

	evos_attacks Mismagius
	learnset 1, POWER_GEM
	learnset 1, SHADOW_BALL ; Phantom Force → TM move
	learnset 1, FLAMETHROWER ; Mystical Fire → TM move
	learnset 1, DAZZLINGLEAM ; Magical Leaf → TM move ; evolution move
	learnset 1, GROWL
	learnset 1, TELEPORT ; Psywave → new move
	learnset 1, DISARM_VOICE ; new move
	learnset 1, CONFUSION ; Spite → new move
	learnset 1, ASTONISH

	evos_attacks Honchkrow
	learnset 1, SUCKER_PUNCH
	learnset 1, ASTONISH
	learnset 1, PURSUIT
	learnset 1, HAZE
	learnset 1, WING_ATTACK
	learnset 25, SWAGGER
	learnset 35, NASTY_PLOT
	learnset 45, NIGHT_SLASH ; Foul Play → Night Slash
	learnset 55, PERISH_SONG ; Night Slash → egg move
	learnset 65, BRAVE_BIRD ; Quash → egg move
	learnset 75, DARK_PULSE

	evos_attacks Bonsly
	evo_data EVOLVE_MOVE, ROCK_THROW, SUDOWOODO
	learnset 1, CHARM ; Fake Tears → new move
	learnset 1, SUBSTITUTE ; Copycat → Sudowoodo event move
	learnset 5, REVERSAL ; Flail → similar move
	learnset 8, LOW_KICK
	learnset 12, LEER ; Rock Throw → new move
	learnset 15, ROCK_THROW ; Mimic → Rock Throw
	learnset 19, FEINT_ATTACK
	learnset 22, ANCIENTPOWER ; Rock Tomb → new move
	learnset 26, PROTECT ; Block → TM move
	learnset 29, ROCK_SLIDE
	learnset 33, COUNTER
	learnset 36, SUCKER_PUNCH
	learnset 40, DOUBLE_EDGE

	evos_attacks MimeJr
	evo_data EVOLVE_LOCATION, ICE_PATH, MR__MIME, GALARIAN_FORM
	evo_data EVOLVE_LEVEL, 30, MR__MIME, PLAIN_FORM
	evo_data EVOLVE_ITEM, ICE_STONE, MR__MIME, GALARIAN_FORM
	learnset 1, BARRIER
	learnset 1, CONFUSION
	learnset 1, TACKLE  ; Pound → similar move
	learnset 4, HYPNOSIS ; Copycat → egg move
	learnset 8, CALM_MIND ; Meditate → TM move
	learnset 11, DOUBLE_SLAP
	learnset 13, PROTECT ; Mimic → event move
	learnset 15, METRONOME ; Psywave → RBY TM move
	learnset 18, ENCORE
	learnset 22, LIGHT_SCREEN
	learnset 22, REFLECT
	learnset 25, PSYBEAM
	learnset 29, SUBSTITUTE
	learnset 32, CONFUSE_RAY ; Recycle → egg move
	learnset 36, TRICK
	learnset 39, PSYCHIC_M
	learnset 43, FUTURE_SIGHT ; Role Play → egg move
	learnset 46, BATON_PASS
	learnset 50, SAFEGUARD

	evos_attacks Happiny
	evo_data EVOLVE_HOLDING, OVAL_STONE, TR_MORNDAY, CHANSEY
	learnset 1, MINIMIZE
	learnset 1, TACKLE ; Pound → similar move
	learnset 1, METRONOME ; Copycat → egg move
	learnset 4, DEFENSE_CURL
	learnset 8, SWEET_KISS
	learnset 12, DISARM_VOICE
	learnset 16, ROLLOUT ; Covet → tutor move
	learnset 20, CHARM

	evos_attacks Munchlax
	evo_data EVOLVE_HAPPINESS, TR_ANYTIME, SNORLAX
	learnset 1, SWEET_KISS ; Recycle → event move
	learnset 1, METRONOME
	learnset 1, TACKLE
	learnset 4, DEFENSE_CURL
	learnset 9, AMNESIA
	learnset 12, LICK
	learnset 17, RAGE ; Chip Away → RBY TM move
	learnset 20, TAKE_DOWN ; Screech → RBY TM move
	learnset 25, BODY_SLAM
	learnset 28, SCREECH ; Stockpile → Screech
	learnset 33, PROTECT ; Swallow → TM move
	learnset 36, ROLLOUT
	learnset 41, OUTRAGE ; Fling → HGSS tutor move
	learnset 44, BELLY_DRUM
	learnset 49, CRUNCH ; Natural Gift → Snorlax move
	learnset 50, GUNK_SHOT ; Snatch → egg move
	learnset 57, DOUBLE_EDGE ; Last Resort → egg move

	evos_attacks Mantyke
	evo_data EVOLVE_PARTY, REMORAID, MANTINE
	learnset 1, GUST ; event move
	learnset 1, TACKLE
	learnset 1, WATER_GUN ; Bubble → similar move
	learnset 3, SUPERSONIC
	learnset 7, BUBBLE_BEAM
	learnset 11, CONFUSE_RAY
	learnset 14, WING_ATTACK
	learnset 16, HEADBUTT
	learnset 19, WATER_PULSE
	learnset 23, AQUA_JET ; Wide Guard → new move
	learnset 27, TAKE_DOWN
	learnset 32, AGILITY
	learnset 36, AIR_SLASH
	learnset 39, ROOST ; Aqua Ring → similar move
	learnset 46, MIRROR_COAT ; Bounce → Dream World move
	learnset 49, HYDRO_PUMP

	evos_attacks Weavile
	learnset 1, SCRATCH
	learnset 1, LEER
	learnset 1, BITE ; Taunt → egg move
	learnset 8, QUICK_ATTACK
	learnset 10, FEINT_ATTACK
	learnset 14, ICE_SHARD ; Icy Wind → Ice Shard
	learnset 16, FURY_STRIKES ; Fury Swipes → similar move
	learnset 20, NASTY_PLOT
	learnset 22, METAL_CLAW
	learnset 25, HONE_CLAWS
	learnset 28, ICICLE_CRASH ; Fling → egg move
	learnset 32, SCREECH
	learnset 35, NIGHT_SLASH
	learnset 40, HEALINGLIGHT ; Snatch → event move (Moonlight)
	learnset 44, X_SCISSOR ; Punishment → TM move
	learnset 47, CRUNCH ; Dark Pulse → new move

	evos_attacks Magnezone
	learnset 1, TRI_ATTACK ; evolution move
	learnset 1, MIRROR_COAT
	learnset 1, BARRIER
	learnset 1, SUPERSONIC
	learnset 1, TACKLE
	learnset 5, THUNDERSHOCK
	learnset 7, THUNDER_WAVE
	learnset 11, QUICK_ATTACK ; Magnet Bomb → TCG move
	learnset 13, LIGHT_SCREEN
	learnset 17, SONIC_BOOM
	learnset 19, SPARK
	learnset 23, SWIFT ; Mirror Shot → TM move
	learnset 25, SCREECH ; Metal Sound → Screech
	learnset 29, THUNDERBOLT ; Electro Ball → TM move
	learnset 33, FLASH_CANNON
	learnset 39, EXPLOSION ; Screech → TM move
	learnset 43, HIDDEN_POWER ; Discharge → TM move
	learnset 49, AGILITY ; Lock-On → event move
	learnset 53, GYRO_BALL ; Magnet Rise → Gyro Ball
	learnset 59, THUNDER ; Gyro Ball → TM move
	learnset 63, ZAP_CANNON

	evos_attacks Lickilicky
	learnset 1, LICK
	learnset 5, SUPERSONIC
	learnset 9, DEFENSE_CURL
	learnset 13, KNOCK_OFF
	learnset 17, WRAP
	learnset 21, STOMP
	learnset 25, DISABLE
	learnset 29, HEADBUTT ; Slam → TM move
	learnset 33, ROLLOUT
	learnset 37, SCREECH ; Chip Away → Screech
	learnset 41, AMNESIA ; Me First → egg move
	learnset 45, BODY_SLAM ; Refresh → egg move
	learnset 49, CURSE ; Screech → egg move
	learnset 53, POWER_WHIP
	learnset 57, BELLY_DRUM ; Wring Out → egg move
	learnset 61, GYRO_BALL

	evos_attacks Rhyperior
	learnset 1, OUTRAGE ; Hammer Arm → HGSS tutor move ; evolution move
	learnset 1, POISON_JAB
	learnset 1, TACKLE
	learnset 1, MUD_SLAP ; Sand-Attack → similar move
	learnset 1, LEER ; Tail Whip → similar move
	learnset 3, HORN_ATTACK
	learnset 6, FURY_STRIKES ; Fury Attack → similar move
	learnset 9, SCARY_FACE
	learnset 13, MAGNITUDE ; Smack Down → egg move
	learnset 17, STOMP
	learnset 21, BULLDOZE
	learnset 25, ANCIENTPOWER ; Chip Away → HGSS tutor move
	learnset 29, ROCK_BLAST
	learnset 33, TAKE_DOWN ; Drill Run → Take Down
	learnset 37, STONE_EDGE ; Take Down → Stone Edge
	learnset 41, DOUBLE_EDGE ; Double Edge → event move
	learnset 48, EARTHQUAKE
	learnset 55, CLOSE_COMBAT ; Megahorn → new move
	learnset 62, MEGAHORN ; Horn Drill → Megahorn
	learnset 69, ROCK_SLIDE ; Rock Wrecker → similar move

	evos_attacks Tangrowth
	learnset 1, WRAP ; Constrict → similar move
	learnset 4, SLEEP_POWDER
	learnset 7, VINE_WHIP
	learnset 10, ABSORB
	learnset 14, POISONPOWDER
	learnset 17, PROTECT ; Bind → TM move
	learnset 20, GROWTH
	learnset 23, MEGA_DRAIN
	learnset 27, KNOCK_OFF
	learnset 30, STUN_SPORE
	learnset 33, HEALINGLIGHT ; Natural Gift → new move
	learnset 36, GIGA_DRAIN
	learnset 40, ANCIENTPOWER
	learnset 43, BODY_SLAM ; Slam → similar move
	learnset 46, PAIN_SPLIT ; Tickle → HGSS tutor move
	learnset 48, SWORDS_DANCE ; Wring Out → TM move
	learnset 50, BATON_PASS ; Grassy Terrain → new move
	learnset 53, POWER_WHIP

	evos_attacks Electivire
	learnset 1, CLOSE_COMBAT ; evolution move
	learnset 1, FIRE_PUNCH
	learnset 1, QUICK_ATTACK
	learnset 1, LEER
	learnset 5, THUNDERSHOCK
	learnset 8, LOW_KICK
	learnset 12, SWIFT
	learnset 15, BULK_UP ; Shock Wave → TM move
	learnset 19, THUNDER_WAVE
	learnset 22, KARATE_CHOP ; Electro Ball → egg move
	learnset 26, LIGHT_SCREEN
	learnset 29, THUNDERPUNCH
	learnset 36, SCREECH ; Discharge → Screech
	learnset 42, CROSS_CHOP ; Screech → new move
	learnset 49, THUNDERBOLT
	learnset 55, THUNDER
	learnset 62, GIGA_IMPACT

	evos_attacks Magmortar
	learnset 1, FLASH_CANNON ; evolution move
	learnset 1, THUNDERPUNCH
	learnset 1, HAZE ; Smog → new move
	learnset 1, LEER
	learnset 5, EMBER
	learnset 8, SMOKESCREEN
	learnset 12, FEINT_ATTACK
	learnset 15, FIRE_SPIN
	learnset 19, LOW_KICK ; Clear Smog → HGSS tutor move
	learnset 22, FLAME_CHARGE ; Flame Burst → TM move
	learnset 26, CONFUSE_RAY
	learnset 29, FIRE_PUNCH
	learnset 36, SUNNY_DAY ; Lava Plume → Sunny Day
	learnset 42, FOCUS_BLAST ; Sunny Day → TM move
	learnset 49, FLAMETHROWER
	learnset 55, FIRE_BLAST
	learnset 62, HYPER_BEAM

	evos_attacks Togekiss
	learnset 1, DISARM_VOICE ; evolution move
	learnset 1, HURRICANE ; Sky Attack → new move
	learnset 1, EXTREMESPEED
	learnset 1, AURA_SPHERE
	learnset 1, AIR_SLASH
	learnset 1, PLAY_ROUGH ; Sw/Sh move
	learnset 1, FUTURE_SIGHT ; Sw/Sh move

	evos_attacks Yanmega
	learnset 1, DRAGONBREATH ; evolution move
	learnset 1, NIGHT_SLASH
	learnset 1, TACKLE
	learnset 1, FORESIGHT
	learnset 1, BUG_BITE
	learnset 6, QUICK_ATTACK
	learnset 11, DOUBLE_TEAM
	learnset 14, SONIC_BOOM
	learnset 17, PROTECT ; Detect → similar move
	learnset 22, DRAGON_RAGE ; Supersonic → new move
	learnset 27, SUPERSONIC ; Uproar → Supersonic
	learnset 30, PURSUIT
if DEF(FAITHFUL)
	learnset 33, ANCIENTPOWER
else
	learnset 35, ANCIENTPOWER
endc
	learnset 38, SLASH ; Feint → Slash
	learnset 43, WING_ATTACK ; Slash → Wing Attack
	learnset 46, SCREECH
	learnset 49, U_TURN
	learnset 54, AIR_SLASH
	learnset 57, BUG_BUZZ
	learnset 62, FLY ; new move

	evos_attacks Leafeon
	learnset 1, GROWL
	learnset 1, TACKLE
	learnset 1, LEER ; Tail Whip → similar move
	learnset 1, RAZOR_LEAF ; evolution move
	learnset 5, MUD_SLAP ; Sand Attack → similar move
	learnset 9, DOUBLE_KICK ; Baby-Doll Eyes → LGPE move
	learnset 13, QUICK_ATTACK
	learnset 17, BITE ; Grass Whistle → new move
	learnset 20, ENERGY_BALL ; Magical Leaf → TM move
	learnset 25, GIGA_DRAIN
	learnset 29, SWORDS_DANCE
	learnset 33, HEALINGLIGHT ; Synthesis → similar move
	learnset 37, SEED_BOMB ; Sunny Day → tutor move
	learnset 41, DOUBLE_EDGE ; Last Resort → tutor move
	learnset 45, SUNNY_DAY ; Leaf Blade → Sunny Day

	evos_attacks Glaceon
	learnset 1, GROWL
	learnset 1, TACKLE
	learnset 1, LEER ; Tail Whip → similar move
	learnset 1, ICY_WIND ; evolution move
	learnset 5, MUD_SLAP ; Sand Attack → similar move
	learnset 9, DOUBLE_KICK ; Baby-Doll Eyes → LGPE move
	learnset 13, QUICK_ATTACK
	learnset 17, BITE
	learnset 20, ICE_SHARD ; Ice Fang → Ice Shard
	learnset 25, HAIL ; Ice Shard → Hail
	learnset 29, BARRIER
	learnset 33, MIRROR_COAT
	learnset 37, ICE_BEAM ; Hail → TM move
	learnset 41, DOUBLE_EDGE ; Last Resort → tutor move
	learnset 45, BLIZZARD

	evos_attacks Gliscor
	learnset 1, POISON_JAB
	learnset 4, MUD_SLAP ; Sand Attack → similar move
	learnset 7, DEFENSE_CURL ; Harden → similar move
	learnset 10, QUICK_ATTACK ; Knock Off → Quick Attack
	learnset 13, WING_ATTACK ; Quick Attack → egg move
	learnset 16, BUG_BITE ; Fury Cutter → similar move
	learnset 19, FEINT_ATTACK
	learnset 22, ACROBATICS
	learnset 27, SLASH ; Night Slash → Gligar move
	learnset 30, U_TURN
	learnset 35, SCREECH
	learnset 40, X_SCISSOR
	learnset 45, KNOCK_OFF ; Sky Uppercut → Knock Off
	learnset 50, SWORDS_DANCE
	learnset 55, NIGHT_SLASH ; Guillotine → Night Slash

	evos_attacks Mamoswine
	learnset 1, ANCIENTPOWER
	learnset 1, PECK
	learnset 1, FORESIGHT ; Odor Sleuth → similar move
	learnset 5, BITE ; Mud Sport → egg move
	learnset 8, ICE_SHARD ; Powder Snow → Ice Shard
	learnset 11, MUD_SLAP
	learnset 14, ENDURE
	learnset 18, MAGNITUDE ; Mud Bomb → new move
	learnset 21, HAIL
	learnset 24, AVALANCHE ; Ice Fang → egg move
	learnset 28, TAKE_DOWN
	learnset 34, ROCK_BLAST ; Double Hit → Sw/Sh move
	learnset 37, BULLDOZE ; Mist → TM move
	learnset 41, THRASH
	learnset 46, EARTHQUAKE
	learnset 52, BLIZZARD
	learnset 58, SCARY_FACE

	evos_attacks PorygonZ
	learnset 1, TRICK_ROOM
	learnset 1, TACKLE
	learnset 1, CONVERSION
	learnset 1, NASTY_PLOT ; evolution move
	learnset 7, PSYBEAM
	learnset 12, AGILITY
	learnset 18, RECOVER
	learnset 23, GROWTH ; Magnet Rise → new move
	learnset 29, AURORA_BEAM ; Signal Beam → new move
	learnset 34, PAIN_SPLIT ; Embargo → HGSS tutor move
	learnset 40, BARRIER ; Discharge → event move
	learnset 45, THUNDERBOLT ; Lock-On → TM move
	learnset 50, TRI_ATTACK
	learnset 56, MIRROR_COAT ; Magic Coat → new move
	learnset 62, ZAP_CANNON
	learnset 67, HYPER_BEAM

	evos_attacks Sylveon
	learnset 1, GROWL
	learnset 1, TACKLE
	learnset 1, LEER ; Tail Whip → similar move
	learnset 1, DISARM_VOICE ; evolution move
	learnset 5, MUD_SLAP ; Sand Attack → similar move
	learnset 9, DOUBLE_KICK ; Baby-Doll Eyes → LGPE move
	learnset 13, QUICK_ATTACK
	learnset 17, SWIFT
	learnset 20, DRAINING_KISS
	learnset 25, SKILL_SWAP
	learnset 29, HEAL_BELL ; Misty Terrain → HGSS tutor move
	learnset 33, LIGHT_SCREEN
	learnset 37, MOONBLAST
	learnset 41, DOUBLE_EDGE ; Last Resort → tutor move
	learnset 45, PLAY_ROUGH ; Psych Up → new move

	evos_attacks Perrserker
	learnset 1, IRON_HEAD ; evolution move
	learnset 1, COUNTER ; Metal Burst → similar move
	learnset 1, PLAY_ROUGH ; Iron Defense → TR move
	learnset 1, ASTONISH ; Fake Out → new move
	learnset 1, GROWL
	learnset 1, HONE_CLAWS
	learnset 1, SCRATCH
	learnset 12, PAY_DAY
	learnset 16, METAL_CLAW
	learnset 20, PURSUIT ; Taunt → new move
	learnset 24, SWAGGER
	learnset 31, FURY_STRIKES
	learnset 36, SCREECH
	learnset 42, SLASH
	learnset 48, CRUNCH ; Metal Sound → TR move
	learnset 54, THRASH
	learnset 60, CLOSE_COMBAT ; TR move

	evos_attacks Cursola
	learnset 1, PERISH_SONG
	learnset 1, TACKLE
	learnset 1, DEFENSE_CURL ; Harden → similar move
	learnset 1, ASTONISH
	learnset 1, DISABLE
	learnset 15, HAZE ; Spite → egg move
	learnset 20, ANCIENTPOWER
	learnset 25, HEX
	learnset 30, CURSE
	learnset 35, GIGA_DRAIN ; Strength Sap → TM move
	learnset 40, POWER_GEM
	learnset 45, NIGHT_SHADE
	learnset 50, HYDRO_PUMP ; Grudge → TR move
	learnset 55, MIRROR_COAT

	evos_attacks SirfetchD
	learnset 1, CUT ; Fury Cutter → HM move
	learnset 1, COUNTER ; Iron Defense → egg move ; evolution move
	learnset 1, QUICK_ATTACK ; First Impression → egg move
	learnset 1, PECK
	learnset 1, MUD_SLAP ; Sand Attack → similar move
	learnset 1, LEER
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
	learnset 70, GIGA_IMPACT ; Meteor Assault → similar move

	evos_attacks MrRime
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

	evos_attacks Wyrdeer
	learnset 1, EXTRASENSORY ; evolution move
	learnset 1, TACKLE
	learnset 3, LEER
	learnset 7, ASTONISH
	learnset 10, HYPNOSIS
	learnset 13, STOMP
	learnset 16, MUD_SLAP ; Sand-Attack → similar move
	learnset 21, HEADBUTT ; Take Down → tutor move
	learnset 23, CONFUSE_RAY
	learnset 27, CALM_MIND
	learnset 33, TAKE_DOWN ; Role Play → Take Down
	learnset 38, ZEN_HEADBUTT
	learnset 43, THRASH ; Jump Kick → egg move
	learnset 49, SKILL_SWAP ; Imprison → tutor move
	learnset 55, HI_JUMP_KICK ; Captivate → new move
	learnset 60, MEGAHORN ; Me First → egg move
	learnset 65, DOUBLE_EDGE ; new move

	evos_attacks Kleavor
	learnset 1, ROCK_THROW ; evolution move
	learnset 1, QUICK_ATTACK
	learnset 1, LEER
	learnset 5, FOCUS_ENERGY
	learnset 9, PURSUIT
	learnset 13, FALSE_SWIPE
	learnset 17, AGILITY
	learnset 21, AERIAL_ACE
	learnset 25, BUG_BITE ; Fury Cutter → similar move
	learnset 29, SLASH
	learnset 33, GLARE ; Razor Wind → new move
	learnset 37, DEFENSE_CURL ; Stealth Rock → new move
	learnset 41, X_SCISSOR
	learnset 45, CRUNCH ; Night Slash → Prism tutor move
	learnset 49, CLOSE_COMBAT ; Double Hit → SV TM move
	learnset 50, STONE_EDGE ; Stone Axe → new move
	learnset 57, SWORDS_DANCE

	evos_attacks UrsalunaPlain
	learnset 1, BULLDOZE ; evolution move
	learnset 1, GUNK_SHOT ; HGSS tutor move
	learnset 1, THIEF ; Covet → TM move
	learnset 1, SCRATCH
	learnset 1, LEER
	learnset 1, LICK
	learnset 1, FOCUS_ENERGY ; Fake Tears → egg move
	learnset 8, FURY_STRIKES ; Fury Swipes → similar move
	learnset 15, FEINT_ATTACK
	learnset 22, BELLY_DRUM ; Sweet Scent → egg move
	learnset 25, PLAY_ROUGH ; Play Nice → egg move
	learnset 29, SLASH
	learnset 38, SCARY_FACE
	learnset 47, REST
	learnset 49, EARTHQUAKE ; High Horsepower → TM move
	learnset 58, THRASH
	learnset 67, CLOSE_COMBAT ; Hammer Arm → SV TM move
	learnset 76, DOUBLE_EDGE ; new move
	learnset 85, GUNK_SHOT ; SV TM move

	evos_attacks Sneasler
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

	evos_attacks Overqwil
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

	evos_attacks Dudunsparce
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

	evos_attacks Farigiraf
	learnset 1, ASTONISH
	learnset 1, TACKLE
	learnset 1, GROWL
	learnset 1, CONFUSION
	learnset 5, FORESIGHT ; Odor Sleuth → egg move
	learnset 10, PURSUIT ; Assurance → new move
	learnset 14, STOMP
	learnset 19, PSYBEAM
	learnset 23, AGILITY
	learnset 28, DOUBLE_KICK ; Double Hit → egg move
	learnset 32, ZEN_HEADBUTT
	learnset 37, CRUNCH
	learnset 41, BATON_PASS
	learnset 46, NASTY_PLOT
	learnset 50, PSYCHIC_M
if !DEF(FAITHFUL)
	learnset 55, DARK_PULSE ; new move
endc

	evos_attacks Clodsire
	learnset 1, MEGAHORN ; evolution move
	learnset 1, MUD_SLAP ; Mud Shot → similar move
	learnset 1, LEER ; Tail Whip → similar move
	learnset 5, TACKLE
	learnset 9, POISON_STING ; Poison Tail → similar move
	learnset 15, HEADBUTT ; Slam → tutor move
	learnset 19, RECOVER ; Mud Bomb → egg move
	learnset 24, AMNESIA
	learnset 31, BELLY_DRUM ; Yawn → event move
	learnset 36, EARTHQUAKE
	learnset 41, POISON_JAB
	learnset 48, TOXIC_SPIKES
	learnset 53, GUNK_SHOT ; Sludge Wave → similar move

	evos_attacks Annihilape
	learnset 1, SHADOW_CLAW ; Shadow Punch → similar move ; evolution move
	learnset 1, OUTRAGE
	learnset 1, RAGE
	learnset 1, SCRATCH
	learnset 1, LOW_KICK
	learnset 1, LEER
	learnset 1, FOCUS_ENERGY
	learnset 5, FURY_STRIKES ; Fury Swipes → similar move
	learnset 8, KARATE_CHOP
	learnset 12, PURSUIT
	learnset 15, SEISMIC_TOSS
	learnset 19, SWAGGER
	learnset 22, CROSS_CHOP
	learnset 26, REVERSAL ; Assurance → egg move
	learnset 30, FEINT_ATTACK ; Punishment → new move
	learnset 35, THRASH
	learnset 39, CLOSE_COMBAT
	learnset 44, SCREECH
	learnset 48, GUNK_SHOT ; Stomping Tantrum → HGSS tutor move
	learnset 53, OUTRAGE

	evos_attacks Egg
