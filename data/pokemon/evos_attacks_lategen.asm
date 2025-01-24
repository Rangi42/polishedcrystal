SECTION "Evolutions and Attacks LateGen", ROMX

EvosAttacksPointersLateGen::
	dw .AzurillEvosAttacks
	dw .WynautEvosAttacks
	dw .AmbipomEvosAttacks
	dw .EggEvosAttacks
	dw .EggEvosAttacks ; $100
	dw .MismagiusEvosAttacks
	dw .HonchkrowEvosAttacks
	dw .BonslyEvosAttacks
	dw .MimeJrEvosAttacks
	dw .HappinyEvosAttacks
	dw .MunchlaxEvosAttacks
	dw .MantykeEvosAttacks
	dw .WeavileEvosAttacks
	dw .MagnezoneEvosAttacks
	dw .LickilickyEvosAttacks
	dw .RhyperiorEvosAttacks
	dw .TangrowthEvosAttacks
	dw .ElectivireEvosAttacks
	dw .MagmortarEvosAttacks
	dw .TogekissEvosAttacks
	dw .YanmegaEvosAttacks
	dw .LeafeonEvosAttacks
	dw .GlaceonEvosAttacks
	dw .GliscorEvosAttacks
	dw .MamoswineEvosAttacks
	dw .PorygonZEvosAttacks
	dw .SylveonEvosAttacks
	dw .PerrserkerEvosAttacks
	dw .CursolaEvosAttacks
	dw .SirfetchDEvosAttacks
	dw .MrRimeEvosAttacks
	dw .WyrdeerEvosAttacks
	dw .KleavorEvosAttacks
	dw .UrsalunaPlainEvosAttacks
	dw .SneaslerEvosAttacks
	dw .OverqwilEvosAttacks
	dw .DudunsparceEvosAttacks
	dw .FarigirafEvosAttacks
	dw .ClodsireEvosAttacks
	dw .AnnihilapeEvosAttacks
.IndirectEnd::

.AzurillEvosAttacks
	evo_data EVOLVE_HAPPINESS, TR_ANYTIME, MARILL
	db -1 ; no more evolutions
	dbw 1, SPLASH
	dbw 1, WATER_GUN
	dbw 2, GROWL ; Tail Whip → new move
	dbw 5, FORESIGHT ; Water Sport → Marill egg move
	dbw 7, AQUA_JET ; Bubble → egg move
	dbw 10, CHARM
	dbw 13, BUBBLE_BEAM
	dbw 16, SING ; Helping Hand → egg move
	dbw 20, ROLLOUT ; Slam → tutor move
	dbw 23, BODY_SLAM ; Bounce → egg move
	db -1 ; no more level-up moves

.WynautEvosAttacks
	evo_data EVOLVE_LEVEL, 15, WOBBUFFET
	db -1 ; no more evolutions
	dbw 1, SPLASH
	dbw 1, CHARM
	dbw 1, ENCORE
	dbw 1, AMNESIA
	dbw 1, COUNTER
	dbw 1, MIRROR_COAT
	dbw 1, SAFEGUARD
	dbw 1, DESTINY_BOND
	db -1 ; no more level-up moves

.AmbipomEvosAttacks
	db -1 ; no more evolutions
	dbw 1, HEADBUTT ; Dual Chop → tutor move
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

.MismagiusEvosAttacks
	db -1 ; no more evolutions
	dbw 1, POWER_GEM
	dbw 1, SHADOW_BALL ; Phantom Force → TM move
	dbw 1, FLAMETHROWER ; Mystical Fire → TM move
	dbw 1, DAZZLINGLEAM ; Magical Leaf → TM move ; evolution move
	dbw 1, GROWL
	dbw 1, TELEPORT ; Psywave → new move
	dbw 1, DISARM_VOICE ; new move
	dbw 1, CONFUSION ; Spite → new move
	dbw 1, ASTONISH
	db -1 ; no more level-up moves

.HonchkrowEvosAttacks
	db -1 ; no more evolutions
	dbw 1, SUCKER_PUNCH
	dbw 1, ASTONISH
	dbw 1, PURSUIT
	dbw 1, HAZE
	dbw 1, WING_ATTACK
	dbw 25, SWAGGER
	dbw 35, NASTY_PLOT
	dbw 45, NIGHT_SLASH ; Foul Play → Night Slash
	dbw 55, PERISH_SONG ; Night Slash → egg move
	dbw 65, BRAVE_BIRD ; Quash → egg move
	dbw 75, DARK_PULSE
	db -1 ; no more level-up moves

.BonslyEvosAttacks
	evo_data EVOLVE_MOVE, ROCK_THROW, SUDOWOODO
	db -1 ; no more evolutions
	dbw 1, CHARM ; Fake Tears → new move
	dbw 1, SUBSTITUTE ; Copycat → Sudowoodo event move
	dbw 5, REVERSAL ; Flail → similar move
	dbw 8, LOW_KICK
	dbw 12, LEER ; Rock Throw → new move
	dbw 15, ROCK_THROW ; Mimic → Rock Throw
	dbw 19, FEINT_ATTACK
	dbw 22, ANCIENTPOWER ; Rock Tomb → new move
	dbw 26, PROTECT ; Block → TM move
	dbw 29, ROCK_SLIDE
	dbw 33, COUNTER
	dbw 36, SUCKER_PUNCH
	dbw 40, DOUBLE_EDGE
	db -1 ; no more level-up moves

.MimeJrEvosAttacks
	evo_data EVOLVE_LOCATION, ICE_PATH, MR__MIME, GALARIAN_FORM
	evo_data EVOLVE_LEVEL, 30, MR__MIME, PLAIN_FORM
	evo_data EVOLVE_ITEM, ICE_STONE, MR__MIME, GALARIAN_FORM
	db -1 ; no more evolutions
	dbw 1, BARRIER
	dbw 1, CONFUSION
	dbw 1, TACKLE  ; Pound → similar move
	dbw 4, HYPNOSIS ; Copycat → egg move
	dbw 8, CALM_MIND ; Meditate → TM move
	dbw 11, DOUBLE_SLAP
	dbw 13, PROTECT ; Mimic → event move
	dbw 15, METRONOME ; Psywave → RBY TM move
	dbw 18, ENCORE
	dbw 22, LIGHT_SCREEN
	dbw 22, REFLECT
	dbw 25, PSYBEAM
	dbw 29, SUBSTITUTE
	dbw 32, CONFUSE_RAY ; Recycle → egg move
	dbw 36, TRICK
	dbw 39, PSYCHIC_M
	dbw 43, FUTURE_SIGHT ; Role Play → egg move
	dbw 46, BATON_PASS
	dbw 50, SAFEGUARD
	db -1 ; no more level-up moves

.HappinyEvosAttacks
	evo_data EVOLVE_HOLDING, OVAL_STONE, TR_MORNDAY, CHANSEY
	db -1 ; no more evolutions
	dbw 1, MINIMIZE
	dbw 1, TACKLE ; Pound → similar move
	dbw 1, METRONOME ; Copycat → egg move
	dbw 4, DEFENSE_CURL
	dbw 8, SWEET_KISS
	dbw 12, DISARM_VOICE
	dbw 16, ROLLOUT ; Covet → tutor move
	dbw 20, CHARM
	db -1 ; no more level-up moves

.MunchlaxEvosAttacks
	evo_data EVOLVE_HAPPINESS, TR_ANYTIME, SNORLAX
	db -1 ; no more evolutions
	dbw 1, SWEET_KISS ; Recycle → event move
	dbw 1, METRONOME
	dbw 1, TACKLE
	dbw 4, DEFENSE_CURL
	dbw 9, AMNESIA
	dbw 12, LICK
	dbw 17, RAGE ; Chip Away → RBY TM move
	dbw 20, TAKE_DOWN ; Screech → RBY TM move
	dbw 25, BODY_SLAM
	dbw 28, SCREECH ; Stockpile → Screech
	dbw 33, PROTECT ; Swallow → TM move
	dbw 36, ROLLOUT
	dbw 41, OUTRAGE ; Fling → HGSS tutor move
	dbw 44, BELLY_DRUM
	dbw 49, CRUNCH ; Natural Gift → Snorlax move
	dbw 50, GUNK_SHOT ; Snatch → egg move
	dbw 57, DOUBLE_EDGE ; Last Resort → egg move
	db -1 ; no more level-up moves

.MantykeEvosAttacks
	evo_data EVOLVE_PARTY, REMORAID, MANTINE
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

.WeavileEvosAttacks
	db -1 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, LEER
	dbw 1, BITE ; Taunt → egg move
	dbw 8, QUICK_ATTACK
	dbw 10, FEINT_ATTACK
	dbw 14, ICE_SHARD ; Icy Wind → Ice Shard
	dbw 16, FURY_STRIKES ; Fury Swipes → similar move
	dbw 20, NASTY_PLOT
	dbw 22, METAL_CLAW
	dbw 25, HONE_CLAWS
	dbw 28, ICICLE_CRASH ; Fling → egg move
	dbw 32, SCREECH
	dbw 35, NIGHT_SLASH
	dbw 40, HEALINGLIGHT ; Snatch → event move (Moonlight)
	dbw 44, X_SCISSOR ; Punishment → TM move
	dbw 47, CRUNCH ; Dark Pulse → new move
	db -1 ; no more level-up moves

.MagnezoneEvosAttacks
	db -1 ; no more evolutions
	dbw 1, TRI_ATTACK ; evolution move
	dbw 1, MIRROR_COAT
	dbw 1, BARRIER
	dbw 1, SUPERSONIC
	dbw 1, TACKLE
	dbw 5, THUNDERSHOCK
	dbw 7, THUNDER_WAVE
	dbw 11, QUICK_ATTACK ; Magnet Bomb → TCG move
	dbw 13, LIGHT_SCREEN
	dbw 17, SONIC_BOOM
	dbw 19, SPARK
	dbw 23, SWIFT ; Mirror Shot → TM move
	dbw 25, SCREECH ; Metal Sound → Screech
	dbw 29, THUNDERBOLT ; Electro Ball → TM move
	dbw 33, FLASH_CANNON
	dbw 39, EXPLOSION ; Screech → TM move
	dbw 43, HIDDEN_POWER ; Discharge → TM move
	dbw 49, AGILITY ; Lock-On → event move
	dbw 53, GYRO_BALL ; Magnet Rise → Gyro Ball
	dbw 59, THUNDER ; Gyro Ball → TM move
	dbw 63, ZAP_CANNON
	db -1 ; no more level-up moves

.LickilickyEvosAttacks
	db -1 ; no more evolutions
	dbw 1, LICK
	dbw 5, SUPERSONIC
	dbw 9, DEFENSE_CURL
	dbw 13, KNOCK_OFF
	dbw 17, WRAP
	dbw 21, STOMP
	dbw 25, DISABLE
	dbw 29, HEADBUTT ; Slam → TM move
	dbw 33, ROLLOUT
	dbw 37, SCREECH ; Chip Away → Screech
	dbw 41, AMNESIA ; Me First → egg move
	dbw 45, BODY_SLAM ; Refresh → egg move
	dbw 49, CURSE ; Screech → egg move
	dbw 53, POWER_WHIP
	dbw 57, BELLY_DRUM ; Wring Out → egg move
	dbw 61, GYRO_BALL
	db -1 ; no more level-up moves

.RhyperiorEvosAttacks
	db -1 ; no more evolutions
	dbw 1, OUTRAGE ; Hammer Arm → HGSS tutor move ; evolution move
	dbw 1, POISON_JAB
	dbw 1, TACKLE
	dbw 1, MUD_SLAP ; Sand-Attack → similar move
	dbw 1, LEER ; Tail Whip → similar move
	dbw 3, HORN_ATTACK
	dbw 6, FURY_STRIKES ; Fury Attack → similar move
	dbw 9, SCARY_FACE
	dbw 13, MAGNITUDE ; Smack Down → egg move
	dbw 17, STOMP
	dbw 21, BULLDOZE
	dbw 25, ANCIENTPOWER ; Chip Away → HGSS tutor move
	dbw 29, ROCK_BLAST
	dbw 33, TAKE_DOWN ; Drill Run → Take Down
	dbw 37, STONE_EDGE ; Take Down → Stone Edge
	dbw 41, DOUBLE_EDGE ; Double Edge → event move
	dbw 48, EARTHQUAKE
	dbw 55, CLOSE_COMBAT ; Megahorn → new move
	dbw 62, MEGAHORN ; Horn Drill → Megahorn
	dbw 69, ROCK_SLIDE ; Rock Wrecker → similar move
	db -1 ; no more level-up moves

.TangrowthEvosAttacks
	db -1 ; no more evolutions
	dbw 1, WRAP ; Constrict → similar move
	dbw 4, SLEEP_POWDER
	dbw 7, VINE_WHIP
	dbw 10, ABSORB
	dbw 14, POISONPOWDER
	dbw 17, PROTECT ; Bind → TM move
	dbw 20, GROWTH
	dbw 23, MEGA_DRAIN
	dbw 27, KNOCK_OFF
	dbw 30, STUN_SPORE
	dbw 33, HEALINGLIGHT ; Natural Gift → new move
	dbw 36, GIGA_DRAIN
	dbw 40, ANCIENTPOWER
	dbw 43, BODY_SLAM ; Slam → similar move
	dbw 46, PAIN_SPLIT ; Tickle → HGSS tutor move
	dbw 49, SWORDS_DANCE ; Wring Out → TM move
	dbw 50, BATON_PASS ; Grassy Terrain → new move
	dbw 53, POWER_WHIP
	db -1 ; no more level-up moves

.ElectivireEvosAttacks
	db -1 ; no more evolutions
	dbw 1, CLOSE_COMBAT ; evolution move
	dbw 1, FIRE_PUNCH
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
	dbw 36, SCREECH ; Discharge → Screech
	dbw 42, CROSS_CHOP ; Screech → new move
	dbw 49, THUNDERBOLT
	dbw 55, THUNDER
	dbw 62, GIGA_IMPACT
	db -1 ; no more level-up moves

.MagmortarEvosAttacks
	db -1 ; no more evolutions
	dbw 1, FLASH_CANNON ; evolution move
	dbw 1, THUNDERPUNCH
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
	dbw 36, SUNNY_DAY ; Lava Plume → Sunny Day
	dbw 42, FOCUS_BLAST ; Sunny Day → TM move
	dbw 49, FLAMETHROWER
	dbw 55, FIRE_BLAST
	dbw 62, HYPER_BEAM
	db -1 ; no more level-up moves

.TogekissEvosAttacks
	db -1 ; no more evolutions
	dbw 1, DISARM_VOICE ; evolution move
	dbw 1, HURRICANE ; Sky Attack → new move
	dbw 1, EXTREMESPEED
	dbw 1, AURA_SPHERE
	dbw 1, AIR_SLASH
	dbw 1, PLAY_ROUGH ; Sw/Sh move
	dbw 1, FUTURE_SIGHT ; Sw/Sh move
	db -1 ; no more level-up moves

.YanmegaEvosAttacks
	db -1 ; no more evolutions
	dbw 1, DRAGONBREATH ; evolution move
	dbw 1, NIGHT_SLASH
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
	dbw 38, SLASH ; Feint → Slash
	dbw 43, WING_ATTACK ; Slash → Wing Attack
	dbw 46, SCREECH
	dbw 49, U_TURN
	dbw 54, AIR_SLASH
	dbw 57, BUG_BUZZ
	dbw 62, FLY ; new move
	db -1 ; no more level-up moves

.LeafeonEvosAttacks
	db -1 ; no more evolutions
	dbw 1, GROWL
	dbw 1, TACKLE
	dbw 1, LEER ; Tail Whip → similar move
	dbw 1, RAZOR_LEAF ; evolution move
	dbw 5, MUD_SLAP ; Sand Attack → similar move
	dbw 9, DOUBLE_KICK ; Baby-Doll Eyes → LGPE move
	dbw 13, QUICK_ATTACK
	dbw 17, BITE ; Grass Whistle → new move
	dbw 20, ENERGY_BALL ; Magical Leaf → TM move
	dbw 25, GIGA_DRAIN
	dbw 29, SWORDS_DANCE
	dbw 33, HEALINGLIGHT ; Synthesis → similar move
	dbw 37, SEED_BOMB ; Sunny Day → tutor move
	dbw 41, DOUBLE_EDGE ; Last Resort → tutor move
	dbw 45, SUNNY_DAY ; Leaf Blade → Sunny Day
	db -1 ; no more level-up moves

.GlaceonEvosAttacks
	db -1 ; no more evolutions
	dbw 1, GROWL
	dbw 1, TACKLE
	dbw 1, LEER ; Tail Whip → similar move
	dbw 1, ICY_WIND ; evolution move
	dbw 5, MUD_SLAP ; Sand Attack → similar move
	dbw 9, DOUBLE_KICK ; Baby-Doll Eyes → LGPE move
	dbw 13, QUICK_ATTACK
	dbw 17, BITE
	dbw 20, ICE_SHARD ; Ice Fang → Ice Shard
	dbw 25, HAIL ; Ice Shard → Hail
	dbw 29, BARRIER
	dbw 33, MIRROR_COAT
	dbw 37, ICE_BEAM ; Hail → TM move
	dbw 41, DOUBLE_EDGE ; Last Resort → tutor move
	dbw 45, BLIZZARD
	db -1 ; no more level-up moves

.GliscorEvosAttacks
	db -1 ; no more evolutions
	dbw 1, POISON_JAB
	dbw 4, MUD_SLAP ; Sand Attack → similar move
	dbw 7, DEFENSE_CURL ; Harden → similar move
	dbw 10, QUICK_ATTACK ; Knock Off → Quick Attack
	dbw 13, WING_ATTACK ; Quick Attack → egg move
	dbw 16, BUG_BITE ; Fury Cutter → similar move
	dbw 19, FEINT_ATTACK
	dbw 22, ACROBATICS
	dbw 27, SLASH ; Night Slash → Gligar move
	dbw 30, U_TURN
	dbw 35, SCREECH
	dbw 40, X_SCISSOR
	dbw 45, KNOCK_OFF ; Sky Uppercut → Knock Off
	dbw 50, SWORDS_DANCE
	dbw 55, NIGHT_SLASH ; Guillotine → Night Slash
	db -1 ; no more level-up moves

.MamoswineEvosAttacks
	db -1 ; no more evolutions
	dbw 1, ANCIENTPOWER
	dbw 1, PECK
	dbw 1, FORESIGHT ; Odor Sleuth → similar move
	dbw 5, BITE ; Mud Sport → egg move
	dbw 8, ICE_SHARD ; Powder Snow → Ice Shard
	dbw 11, MUD_SLAP
	dbw 14, ENDURE
	dbw 18, MAGNITUDE ; Mud Bomb → new move
	dbw 21, HAIL
	dbw 24, AVALANCHE ; Ice Fang → egg move
	dbw 28, TAKE_DOWN
	dbw 34, ROCK_BLAST ; Double Hit → Sw/Sh move
	dbw 37, BULLDOZE ; Mist → TM move
	dbw 41, THRASH
	dbw 46, EARTHQUAKE
	dbw 52, BLIZZARD
	dbw 58, SCARY_FACE
	db -1 ; no more level-up moves

.PorygonZEvosAttacks
	db -1 ; no more evolutions
	dbw 1, TRICK_ROOM
	dbw 1, TACKLE
	dbw 1, CONVERSION
	dbw 1, NASTY_PLOT ; evolution move
	dbw 7, PSYBEAM
	dbw 12, AGILITY
	dbw 18, RECOVER
	dbw 23, GROWTH ; Magnet Rise → new move
	dbw 29, AURORA_BEAM ; Signal Beam → new move
	dbw 34, PAIN_SPLIT ; Embargo → HGSS tutor move
	dbw 40, BARRIER ; Discharge → event move
	dbw 45, THUNDERBOLT ; Lock-On → TM move
	dbw 50, TRI_ATTACK
	dbw 56, MIRROR_COAT ; Magic Coat → new move
	dbw 62, ZAP_CANNON
	dbw 67, HYPER_BEAM
	db -1 ; no more level-up moves

.SylveonEvosAttacks
	db -1 ; no more evolutions
	dbw 1, GROWL
	dbw 1, TACKLE
	dbw 1, LEER ; Tail Whip → similar move
	dbw 1, DISARM_VOICE ; evolution move
	dbw 5, MUD_SLAP ; Sand Attack → similar move
	dbw 9, DOUBLE_KICK ; Baby-Doll Eyes → LGPE move
	dbw 13, QUICK_ATTACK
	dbw 17, SWIFT
	dbw 20, DRAINING_KISS
	dbw 25, SKILL_SWAP
	dbw 29, HEAL_BELL ; Misty Terrain → HGSS tutor move
	dbw 33, LIGHT_SCREEN
	dbw 37, MOONBLAST
	dbw 41, DOUBLE_EDGE ; Last Resort → tutor move
	dbw 45, PLAY_ROUGH ; Psych Up → new move
	db -1 ; no more level-up moves

.PerrserkerEvosAttacks
	db -1 ; no more evolutions
	dbw 1, IRON_HEAD ; evolution move
	dbw 1, COUNTER ; Metal Burst → similar move
	dbw 1, PLAY_ROUGH ; Iron Defense → TR move
	dbw 1, ASTONISH ; Fake Out → new move
	dbw 1, GROWL
	dbw 1, HONE_CLAWS
	dbw 1, SCRATCH
	dbw 12, PAY_DAY
	dbw 16, METAL_CLAW
	dbw 20, PURSUIT ; Taunt → new move
	dbw 24, SWAGGER
	dbw 31, FURY_STRIKES
	dbw 36, SCREECH
	dbw 42, SLASH
	dbw 48, CRUNCH ; Metal Sound → TR move
	dbw 54, THRASH
	dbw 60, CLOSE_COMBAT ; TR move
	db -1 ; no more level-up moves

.CursolaEvosAttacks
	db -1 ; no more evolutions
	dbw 1, PERISH_SONG
	dbw 1, TACKLE
	dbw 1, DEFENSE_CURL ; Harden → similar move
	dbw 1, ASTONISH
	dbw 1, DISABLE
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

.SirfetchDEvosAttacks
	db -1 ; no more evolutions
	dbw 1, CUT ; Fury Cutter → HM move
	dbw 1, COUNTER ; Iron Defense → egg move ; evolution move
	dbw 1, QUICK_ATTACK ; First Impression → egg move
	dbw 1, PECK
	dbw 1, MUD_SLAP ; Sand Attack → similar move
	dbw 1, LEER
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
	dbw 70, GIGA_IMPACT ; Meteor Assault → similar move
	db -1 ; no more level-up moves

.MrRimeEvosAttacks
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

.WyrdeerEvosAttacks
	db -1 ; no more evolutions
	dbw 1, EXTRASENSORY ; evolution move
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
	dbw 55, HI_JUMP_KICK ; Captivate → new move
	dbw 60, MEGAHORN ; Me First → egg move
	dbw 65, DOUBLE_EDGE ; new move
	db -1 ; no more level-up moves

.KleavorEvosAttacks
	db -1 ; no more evolutions
	dbw 1, ROCK_THROW ; evolution move
	dbw 1, QUICK_ATTACK
	dbw 1, LEER
	dbw 5, FOCUS_ENERGY
	dbw 9, PURSUIT
	dbw 13, FALSE_SWIPE
	dbw 17, AGILITY
	dbw 21, AERIAL_ACE
	dbw 25, BUG_BITE ; Fury Cutter → similar move
	dbw 29, SLASH
	dbw 33, GLARE ; Razor Wind → new move
	dbw 37, DEFENSE_CURL ; Stealth Rock → new move
	dbw 41, X_SCISSOR
	dbw 45, CRUNCH ; Night Slash → Prism tutor move
	dbw 49, CLOSE_COMBAT ; Double Hit → SV TM move
	dbw 50, STONE_EDGE ; Stone Axe → new move
	dbw 57, SWORDS_DANCE
	db -1 ; no more level-up moves

.UrsalunaPlainEvosAttacks
	db -1 ; no more evolutions
	dbw 1, BULLDOZE ; evolution move
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
	dbw 67, CLOSE_COMBAT ; Hammer Arm → SV TM move
	dbw 76, DOUBLE_EDGE ; new move
	dbw 85, GUNK_SHOT ; SV TM move
	db -1 ; no more level-up moves

.SneaslerEvosAttacks
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

.OverqwilEvosAttacks
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

.DudunsparceEvosAttacks
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

.FarigirafEvosAttacks
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

.ClodsireEvosAttacks
	db -1 ; no more evolutions
	dbw 1, MEGAHORN ; evolution move
	dbw 1, MUD_SLAP ; Mud Shot → similar move
	dbw 1, LEER ; Tail Whip → similar move
	dbw 5, TACKLE
	dbw 9, POISON_STING ; Poison Tail → similar move
	dbw 15, HEADBUTT ; Slam → tutor move
	dbw 19, RECOVER ; Mud Bomb → egg move
	dbw 24, AMNESIA
	dbw 31, BELLY_DRUM ; Yawn → event move
	dbw 36, EARTHQUAKE
	dbw 41, POISON_JAB
	dbw 48, TOXIC_SPIKES
	dbw 53, GUNK_SHOT ; Sludge Wave → similar move
	db -1 ; no more level-up moves

.AnnihilapeEvosAttacks
	db -1 ; no more evolutions
	dbw 1, SHADOW_CLAW ; Shadow Punch → similar move ; evolution move
	dbw 1, OUTRAGE
	dbw 1, RAGE
	dbw 1, SCRATCH
	dbw 1, LOW_KICK
	dbw 1, LEER
	dbw 1, FOCUS_ENERGY
	dbw 5, FURY_STRIKES ; Fury Swipes → similar move
	dbw 8, KARATE_CHOP
	dbw 12, PURSUIT
	dbw 15, SEISMIC_TOSS
	dbw 19, SWAGGER
	dbw 22, CROSS_CHOP
	dbw 26, REVERSAL ; Assurance → egg move
	dbw 30, FEINT_ATTACK ; Punishment → new move
	dbw 35, THRASH
	dbw 39, CLOSE_COMBAT
	dbw 44, SCREECH
	dbw 48, GUNK_SHOT ; Stomping Tantrum → HGSS tutor move
	dbw 53, OUTRAGE
	db -1 ; no more level-up moves

.EggEvosAttacks
	db -1 ; no more evolutions
	db -1 ; no more level-up moves
