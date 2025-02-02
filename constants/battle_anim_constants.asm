; battle_anim_struct members (see macros/ram.asm)
rsreset
DEF BATTLEANIMSTRUCT_INDEX           rb
DEF BATTLEANIMSTRUCT_OAMFLAGS        rb
DEF BATTLEANIMSTRUCT_FIX_Y           rb
DEF BATTLEANIMSTRUCT_FRAMESET_ID     rb
DEF BATTLEANIMSTRUCT_FUNCTION        rb
DEF BATTLEANIMSTRUCT_PALETTE         rb
DEF BATTLEANIMSTRUCT_TILEID          rb
DEF BATTLEANIMOBJ_LENGTH EQU _RS - 1 ; discount BATTLEANIMSTRUCT_INDEX
DEF BATTLEANIMSTRUCT_XCOORD          rb
DEF BATTLEANIMSTRUCT_YCOORD          rb
DEF BATTLEANIMSTRUCT_XOFFSET         rb
DEF BATTLEANIMSTRUCT_YOFFSET         rb
DEF BATTLEANIMSTRUCT_PARAM           rb
DEF BATTLEANIMSTRUCT_DURATION        rb
DEF BATTLEANIMSTRUCT_FRAME           rb
DEF BATTLEANIMSTRUCT_JUMPTABLE_INDEX rb
DEF BATTLEANIMSTRUCT_VAR1            rb
DEF BATTLEANIMSTRUCT_VAR2            rb
DEF BATTLEANIMSTRUCT_VAR3            rb
                                     rb_skip 6
DEF BATTLEANIMSTRUCT_LENGTH EQU _RS
DEF NUM_ANIM_OBJECTS EQU 10 ; see wActiveAnimObjects

; wBattleAnimTileDict size (see wram.asm)
DEF NUM_BATTLEANIMTILEDICT_ENTRIES EQU 5

; Start tile for battle animation graphics
DEF BATTLEANIM_BASE_TILE EQU 7 * 7  ; Maximum size of a pokemon picture

; BattleAnimObjects indexes (see data/battle_anims/objects.asm)
	const_def
	const ANIM_OBJ_HIT_BIG_YFIX
	const ANIM_OBJ_HIT_YFIX
	const ANIM_OBJ_HIT_SMALL_YFIX
	const ANIM_OBJ_HIT_BIG
	const ANIM_OBJ_HIT
	const ANIM_OBJ_HIT_SMALL
	const ANIM_OBJ_PUNCH
	const ANIM_OBJ_KICK
	const ANIM_OBJ_PALM
	const ANIM_OBJ_FANG
	const ANIM_OBJ_PUNCH_SHAKE
	const ANIM_OBJ_EMBER
	const ANIM_OBJ_DRAGON_RAGE
	const ANIM_OBJ_FLAMETHROWER
	const ANIM_OBJ_FIRE_SPIN
	const ANIM_OBJ_FIRE_BLAST
	const ANIM_OBJ_BURNED
	const ANIM_OBJ_BLIZZARD
	const ANIM_OBJ_ICE
	const ANIM_OBJ_ICE_BEAM
	const ANIM_OBJ_RAZOR_LEAF
	const ANIM_OBJ_POKE_BALL
	const ANIM_OBJ_POKE_BALL_BLOCKED
	const ANIM_OBJ_EXPLOSION1
	const ANIM_OBJ_EXPLOSION2
	const ANIM_OBJ_ACID
	const ANIM_OBJ_SLUDGE
	const ANIM_OBJ_BALL_POOF_YFIX
	const ANIM_OBJ_BALL_POOF
	const ANIM_OBJ_BIG_ROCK
	const ANIM_OBJ_SMALL_ROCK
	const ANIM_OBJ_STRENGTH
	const ANIM_OBJ_SEISMIC_TOSS
	const ANIM_OBJ_BUBBLE
	const ANIM_OBJ_SURF
	const ANIM_OBJ_SING
	const ANIM_OBJ_WATER_GUN
	const ANIM_OBJ_HYDRO_PUMP
	const ANIM_OBJ_POWDER
	const ANIM_OBJ_BEAM
	const ANIM_OBJ_BEAM_TIP
	const ANIM_OBJ_ICE_BUILDUP
	const ANIM_OBJ_FROZEN
	const ANIM_OBJ_MASTER_BALL_SPARKLE
	const ANIM_OBJ_RECOVER
	const ANIM_OBJ_THUNDER1
	const ANIM_OBJ_THUNDER2
	const ANIM_OBJ_THUNDER3
	const ANIM_OBJ_THUNDER_WAVE
	const ANIM_OBJ_SPARKS_CIRCLE_BIG
	const ANIM_OBJ_THUNDERBOLT_BALL
	const ANIM_OBJ_SPARKS_CIRCLE
	const ANIM_OBJ_THUNDERSHOCK_BALL
	const ANIM_OBJ_CLAMP
	const ANIM_OBJ_BITE
	const ANIM_OBJ_CUT_DOWN_LEFT
	const ANIM_OBJ_CUT_DOWN_RIGHT
	const ANIM_OBJ_CUT_UP_RIGHT
	const ANIM_OBJ_CUT_LONG_DOWN_LEFT
	const ANIM_OBJ_CUT_LONG_DOWN_RIGHT
	const ANIM_OBJ_SOLAR_BEAM_CHARGE
	const ANIM_OBJ_ABSORB_CENTER
	const ANIM_OBJ_GUST
	const ANIM_OBJ_VINE_WHIP1
	const ANIM_OBJ_VINE_WHIP2
	const ANIM_OBJ_RAZOR_WIND1
	const ANIM_OBJ_RAZOR_WIND2
	const ANIM_OBJ_SONICBOOM_JP
	const ANIM_OBJ_WARP
	const ANIM_OBJ_ABSORB
	const ANIM_OBJ_EGG
	const ANIM_OBJ_FOCUS
	const ANIM_OBJ_BIND1
	const ANIM_OBJ_BIND2
	const ANIM_OBJ_LEECH_SEED
	const ANIM_OBJ_SOUND
	const ANIM_OBJ_WAVE
	const ANIM_OBJ_CONFUSE_RAY
	const ANIM_OBJ_LEER
	const ANIM_OBJ_LEER_TIP
	const ANIM_OBJ_SCREEN
	const ANIM_OBJ_HARDEN
	const ANIM_OBJ_CHICK
	const ANIM_OBJ_AMNESIA
	const ANIM_OBJ_ASLEEP
	const ANIM_OBJ_SKULL
	const ANIM_OBJ_DIG_SAND
	const ANIM_OBJ_DIG_PILE
	const ANIM_OBJ_SAND
	const ANIM_OBJ_PARALYZED
	const ANIM_OBJ_STRING_SHOT
	const ANIM_OBJ_HAZE
	const ANIM_OBJ_MIST
	const ANIM_OBJ_SMOG
	const ANIM_OBJ_POISON_GAS
	const ANIM_OBJ_HORN
	const ANIM_OBJ_NEEDLE
	const ANIM_OBJ_PETAL_DANCE
	const ANIM_OBJ_SLUDGE_BOMB
	const ANIM_OBJ_PAY_DAY
	const ANIM_OBJ_SONICBOOM_JP_UNUSED
	const ANIM_OBJ_MIMIC
	const ANIM_OBJ_ATTRACT
	const ANIM_OBJ_BONEMERANG
	const ANIM_OBJ_BONE_CLUB
	const ANIM_OBJ_BONE_RUSH
	const ANIM_OBJ_SWIFT
	const ANIM_OBJ_KINESIS
	const ANIM_OBJ_FLASH
	const ANIM_OBJ_SHINY
	const ANIM_OBJ_SKY_ATTACK
	const ANIM_OBJ_LICK
	const ANIM_OBJ_WITHDRAW
	const ANIM_OBJ_DRAIN
	const ANIM_OBJ_GROWTH
	const ANIM_OBJ_CONVERSION2
	const ANIM_OBJ_SMOKE
	const ANIM_OBJ_SMOKESCREEN
	const ANIM_OBJ_SWORDS_DANCE
	const ANIM_OBJ_SPEED_LINE
	const ANIM_OBJ_SHARPEN
	const ANIM_OBJ_DEFENSE_CURL
	const ANIM_OBJ_METRONOME_HAND
	const ANIM_OBJ_METRONOME_SPARKLE
	const ANIM_OBJ_DISABLE
	const ANIM_OBJ_AGILITY
	const ANIM_OBJ_HEART
	const ANIM_OBJ_FLAME_WHEEL
	const ANIM_OBJ_SACRED_FIRE
	const ANIM_OBJ_COTTON_SPORE
	const ANIM_OBJ_MILK_DRINK
	const ANIM_OBJ_ANGER
	const ANIM_OBJ_HEAL_BELL
	const ANIM_OBJ_HEAL_BELL_NOTE
	const ANIM_OBJ_BATON_PASS
	const ANIM_OBJ_LOCK_ON
	const ANIM_OBJ_MIND_READER
	const ANIM_OBJ_SAFEGUARD
	const ANIM_OBJ_PROTECT
	const ANIM_OBJ_THIEF
	const ANIM_OBJ_OCTAZOOKA
	const ANIM_OBJ_PRESENT
	const ANIM_OBJ_SPIKES
	const ANIM_OBJ_POWDER_SNOW
	const ANIM_OBJ_DRAGONBREATH
	const ANIM_OBJ_CONVERSION
	const ANIM_OBJ_SPIDER_WEB
	const ANIM_OBJ_NIGHTMARE
	const ANIM_OBJ_IN_NIGHTMARE
	const ANIM_OBJ_LOVELY_KISS
	const ANIM_OBJ_SWEET_KISS
	const ANIM_OBJ_SKETCH
	const ANIM_OBJ_ENCORE_HAND
	const ANIM_OBJ_ENCORE_STAR
	const ANIM_OBJ_DESTINY_BOND
	const ANIM_OBJ_MORNING_SUN
	const ANIM_OBJ_GLIMMER
	const ANIM_OBJ_MOONLIGHT
	const ANIM_OBJ_HIDDEN_POWER
	const ANIM_OBJ_CROSS_CHOP1
	const ANIM_OBJ_CROSS_CHOP2
	const ANIM_OBJ_SANDSTORM
	const ANIM_OBJ_ZAP_CANNON
	const ANIM_OBJ_SPITE
	const ANIM_OBJ_CURSE
	const ANIM_OBJ_PERISH_SONG
	const ANIM_OBJ_FORESIGHT
	const ANIM_OBJ_RAPID_SPIN
	const ANIM_OBJ_SWAGGER
	const ANIM_OBJ_BELLY_DRUM_HAND
	const ANIM_OBJ_BELLY_DRUM_NOTE
	const ANIM_OBJ_MEAN_LOOK
	const ANIM_OBJ_PURSUIT
	const ANIM_OBJ_SHOOTING_SPARKLE
	const ANIM_OBJ_RAIN
	const ANIM_OBJ_B0
	const ANIM_OBJ_PSYCH_UP
	const ANIM_OBJ_ANCIENTPOWER
	const ANIM_OBJ_AEROBLAST
	const ANIM_OBJ_SHADOW_BALL
	const ANIM_OBJ_ROCK_SMASH
	const ANIM_OBJ_FLOWER
	const ANIM_OBJ_COTTON
	const ANIM_OBJ_ENEMYFEET_1ROW
	const ANIM_OBJ_PLAYERHEAD_1ROW
	const ANIM_OBJ_ENEMYFEET_2ROW
	const ANIM_OBJ_PLAYERHEAD_2ROW
	const ANIM_OBJ_HAIL
	const ANIM_OBJ_GEM
	const ANIM_OBJ_FOCUS_BLAST
	const ANIM_OBJ_ICICLE
	const ANIM_OBJ_BIG_ICE_CHUNK
	const ANIM_OBJ_SMALL_ICE_CHUNK
	const ANIM_OBJ_ICE_SPLASH
	const ANIM_OBJ_HONE_CLAWS_LEFT
	const ANIM_OBJ_HONE_CLAWS_RIGHT
	const ANIM_OBJ_ROCK_BLAST
	const ANIM_OBJ_SKILL_SWAP_1
	const ANIM_OBJ_SKILL_SWAP_2
	const ANIM_OBJ_GUNK_SHOT
	const ANIM_OBJ_GUNK_SHOT_BUBBLES
	const ANIM_OBJ_STONE_EDGE
	const ANIM_OBJ_STONE_EDGE_STILL
	const ANIM_OBJ_AQUA_JET
	const ANIM_OBJ_AQUA_JET_BUBBLE
	const ANIM_OBJ_TRICK
	const ANIM_OBJ_BLUR_DIAGONAL
	const ANIM_OBJ_BLUR_VERTICAL_UP
	const ANIM_OBJ_BLUR_VERTICAL_DOWN
	const ANIM_OBJ_CHARGE
	const ANIM_OBJ_DAZZLE
	const ANIM_OBJ_TRICK_ROOM
	const ANIM_OBJ_GUNKSHOT
	const ANIM_OBJ_SPLASH
	const ANIM_OBJ_POWER_GEM
	const ANIM_OBJ_MINIMIZE
	const ANIM_OBJ_STAT_UP
	const ANIM_OBJ_STAT_DOWN
	const ANIM_OBJ_POKE_BALL_BG
	const ANIM_OBJ_FLARE_BLITZ
	const ANIM_OBJ_RADIAL_FLAME
	const ANIM_OBJ_BRAVE_BIRD
	const ANIM_OBJ_NASTY_PLOT_1
	const ANIM_OBJ_NASTY_PLOT_2
	const ANIM_OBJ_NASTY_PLOT_HAND
	const ANIM_OBJ_NASTY_PLOT_SURPRISED
	const ANIM_OBJ_VERTICAL_CHOP
	const ANIM_OBJ_VERTICAL_CHOP_STILL
	const ANIM_OBJ_SEED_BOMB
	const ANIM_OBJ_AIR_SLASH
	const ANIM_OBJ_BUG_BUZZ
	const ANIM_OBJ_MID_GLOW_SHRINKING
	const ANIM_OBJ_DRAGON_PULSE
	const ANIM_OBJ_HYPER_VOICE
	const ANIM_OBJ_BULLET_PUNCH
	const ANIM_OBJ_LONG_PUNCH
	const ANIM_OBJ_CLAW_TEAR
	const ANIM_OBJ_VORTEX
	const ANIM_OBJ_SHRINKING_GLOW
	const ANIM_OBJ_HEART_BURST
	const ANIM_OBJ_STAR_BURST
	const ANIM_OBJ_SNOW_FALL
	const ANIM_OBJ_AVALANCHE_SMALL
	const ANIM_OBJ_AVALANCHE_BIG
	const ANIM_OBJ_ICE_SHARD
	const ANIM_OBJ_ICE_SHARD_MIST
	const ANIM_OBJ_RED_STAR
	const ANIM_OBJ_ZEN_HEADBUTT
	const ANIM_OBJ_ZEN_HEADBUTT_PARTICLE
	const ANIM_OBJ_SEISMIC_TOSS_UP
	const ANIM_OBJ_SEISMIC_TOSS_DOWN
	const ANIM_OBJ_SHELL_SMASH_DEBRIS
	const ANIM_OBJ_SHELL_SMASH_SHELL
	const ANIM_OBJ_SHELL_SMASH_HIT
	const ANIM_OBJ_POISON_DROPLET
	const ANIM_OBJ_BERRY
	const ANIM_OBJ_SMALL_GLOW
	const ANIM_OBJ_BIG_GLOW_CLEAR
	const ANIM_OBJ_PUNISHMENT
	const ANIM_OBJ_SUCKER_PUNCH_L
	const ANIM_OBJ_SUCKER_PUNCH_R
	const ANIM_OBJ_AURA_SPHERE
	const ANIM_OBJ_SWIRL_SHORT
	const ANIM_OBJ_RISING_MOON
	const ANIM_OBJ_RISING_SPARKLE
	const ANIM_OBJ_FLASH_CANNON_CHARGE
	const ANIM_OBJ_SLOW_GROWING_GLOW
	const ANIM_OBJ_FLASH_CANNON_SPARKS_WHITE
	const ANIM_OBJ_FLASH_CANNON_SPARKS_RED
	const ANIM_OBJ_FLASH_CANNON
	const ANIM_OBJ_PULSING_SPARKLE
	const ANIM_OBJ_PULSING_SPARKLE_YFIX
	const ANIM_OBJ_POISON_JAB
	const ANIM_OBJ_DARK_PULSE_N
	const ANIM_OBJ_DARK_PULSE_NE
	const ANIM_OBJ_DARK_PULSE_E
	const ANIM_OBJ_DARK_PULSE_SE
	const ANIM_OBJ_DARK_PULSE_S
	const ANIM_OBJ_DARK_PULSE_SW
	const ANIM_OBJ_DARK_PULSE_W
	const ANIM_OBJ_DARK_PULSE_NW
	const ANIM_OBJ_CUT_HORIZONTAL
	const ANIM_OBJ_GLIMMER_YFIX
	const ANIM_OBJ_SCALD
	const ANIM_OBJ_SCALD_STEAM
	const ANIM_OBJ_SHOOTING_TRIANGLE
	const ANIM_OBJ_SPINNING_TRIANGLE
	const ANIM_OBJ_MUSHROOM
	const ANIM_OBJ_POWDER_SHOOT
	const ANIM_OBJ_SIGNAL_BEAM_R
	const ANIM_OBJ_BULK_UP
	const ANIM_OBJ_MUD_SHOT
	const ANIM_OBJ_SHRINKING_RING_SMALL
	const ANIM_OBJ_SHRINKING_RING_BIG
	const ANIM_OBJ_DRAGON_DANCE
	const ANIM_OBJ_ROOST
	const ANIM_OBJ_GYRO_BALL
	const ANIM_OBJ_RISING_BUBBLE
	const ANIM_OBJ_BUBBLE_SPLASH
	const ANIM_OBJ_OCTAZOOKA_SMOKE
	const ANIM_OBJ_INK_SPLASH
	const ANIM_OBJ_DROPLET_R
	const ANIM_OBJ_DROPLET_L
	const ANIM_OBJ_MEDIUM_HORN
	const ANIM_OBJ_ICICLE_CRASH
	const ANIM_OBJ_FLAME_CHARGE
	const ANIM_OBJ_ENERGY_ORB
	const ANIM_OBJ_VOLT_SWITCH
	const ANIM_OBJ_VOLT_SWITCH_SPARKS
	const ANIM_OBJ_PSYSTRIKE_BALL
	const ANIM_OBJ_SHRINKING_GLOW_YFIX
	const ANIM_OBJ_HURRICANE
	const ANIM_OBJ_SHOOTING_HEART
DEF NUM_ANIM_OBJS EQU const_value

; DoBattleAnimFrame arguments (see engine/battle_anims/functions.asm)
	const_def
	const BATTLEANIMFUNC_NULL
	const BATTLEANIMFUNC_USER_TO_TARGET
	const BATTLEANIMFUNC_USER_TO_TARGET_DISAPPEAR
	const BATTLEANIMFUNC_MOVE_IN_CIRCLE
	const BATTLEANIMFUNC_WAVE_TO_TARGET
	const BATTLEANIMFUNC_THROW_TO_TARGET
	const BATTLEANIMFUNC_THROW_TO_TARGET_DISAPPEAR
	const BATTLEANIMFUNC_DROP
	const BATTLEANIMFUNC_USER_TO_TARGET_SPIN
	const BATTLEANIMFUNC_SHAKE
	const BATTLEANIMFUNC_FIRE_BLAST
	const BATTLEANIMFUNC_RAZOR_LEAF
	const BATTLEANIMFUNC_BUBBLE
	const BATTLEANIMFUNC_SURF
	const BATTLEANIMFUNC_SING
	const BATTLEANIMFUNC_WATER_GUN
	const BATTLEANIMFUNC_EMBER
	const BATTLEANIMFUNC_POWDER
	const BATTLEANIMFUNC_POKEBALL
	const BATTLEANIMFUNC_POKEBALL_BLOCKED
	const BATTLEANIMFUNC_RECOVER
	const BATTLEANIMFUNC_THUNDER_WAVE
	const BATTLEANIMFUNC_CLAMP_ENCORE
	const BATTLEANIMFUNC_BITE
	const BATTLEANIMFUNC_SOLAR_BEAM
	const BATTLEANIMFUNC_GUST
	const BATTLEANIMFUNC_RAZOR_WIND
	const BATTLEANIMFUNC_KICK
	const BATTLEANIMFUNC_ABSORB
	const BATTLEANIMFUNC_EGG
	const BATTLEANIMFUNC_MOVE_UP
	const BATTLEANIMFUNC_WRAP
	const BATTLEANIMFUNC_LEECH_SEED
	const BATTLEANIMFUNC_SOUND
	const BATTLEANIMFUNC_CONFUSE_RAY
	const BATTLEANIMFUNC_DIZZY
	const BATTLEANIMFUNC_AMNESIA
	const BATTLEANIMFUNC_FLOAT_UP
	const BATTLEANIMFUNC_DIG
	const BATTLEANIMFUNC_STRING
	const BATTLEANIMFUNC_PARALYZED
	const BATTLEANIMFUNC_SPIRAL_DESCENT
	const BATTLEANIMFUNC_POISON_GAS
	const BATTLEANIMFUNC_HORN
	const BATTLEANIMFUNC_NEEDLE
	const BATTLEANIMFUNC_PETAL_DANCE
	const BATTLEANIMFUNC_THIEF_PAYDAY
	const BATTLEANIMFUNC_ABSORB_CIRCLE
	const BATTLEANIMFUNC_BONEMERANG
	const BATTLEANIMFUNC_SHINY
	const BATTLEANIMFUNC_SKY_ATTACK
	const BATTLEANIMFUNC_GROWTH_SWORDS_DANCE
	const BATTLEANIMFUNC_SMOKE_FLAME_WHEEL
	const BATTLEANIMFUNC_PRESENT_SMOKESCREEN
	const BATTLEANIMFUNC_STRENGTH_SEISMIC_TOSS
	const BATTLEANIMFUNC_SPEED_LINE
	const BATTLEANIMFUNC_SLUDGE
	const BATTLEANIMFUNC_METRONOME_HAND
	const BATTLEANIMFUNC_METRONOME_SPARKLE_SKETCH
	const BATTLEANIMFUNC_AGILITY
	const BATTLEANIMFUNC_SACRED_FIRE
	const BATTLEANIMFUNC_SAFEGUARD_PROTECT
	const BATTLEANIMFUNC_LOCK_ON_MIND_READER
	const BATTLEANIMFUNC_SPIKES
	const BATTLEANIMFUNC_HEAL_BELL_NOTES
	const BATTLEANIMFUNC_BATON_PASS
	const BATTLEANIMFUNC_CONVERSION
	const BATTLEANIMFUNC_ENCORE_BELLY_DRUM
	const BATTLEANIMFUNC_SWAGGER_MORNING_SUN
	const BATTLEANIMFUNC_HIDDEN_POWER
	const BATTLEANIMFUNC_HIDDEN_POWER_FAST
	const BATTLEANIMFUNC_CURSE
	const BATTLEANIMFUNC_PERISH_SONG
	const BATTLEANIMFUNC_RAPID_SPIN
	const BATTLEANIMFUNC_PURSUIT
	const BATTLEANIMFUNC_RAIN_SANDSTORM
	const BATTLEANIMFUNC_ANIM_OBJ_B0
	const BATTLEANIMFUNC_PSYCH_UP
	const BATTLEANIMFUNC_ANCIENT_POWER
	const BATTLEANIMFUNC_ROCK_SMASH
	const BATTLEANIMFUNC_COTTON
	const BATTLEANIMFUNC_PAUSE_THEN_RUSH
	const BATTLEANIMFUNC_ROCK_TOMB
	const BATTLEANIMFUNC_POWER_GEM
	const BATTLEANIMFUNC_BUBBLE_SPLASH
	const BATTLEANIMFUNC_MOON
	const BATTLEANIMFUNC_POKE_BALL_BG
	const BATTLEANIMFUNC_AIR_CUTTER
	const BATTLEANIMFUNC_RADIAL_MOVE_OUT
	const BATTLEANIMFUNC_RADIAL_MOVE_OUT_SLOW
	const BATTLEANIMFUNC_RADIAL_MOVE_OUT_VERY_SLOW
	const BATTLEANIMFUNC_RADIAL_MOVE_OUT_FAST
	const BATTLEANIMFUNC_RADIAL_MOVE_OUT_SPORE
	const BATTLEANIMFUNC_RADIAL_MOVE_OUT_STATS
	const BATTLEANIMFUNC_POWER_UP
	const BATTLEANIMFUNC_ROOST
	const BATTLEANIMFUNC_LAST_RESORT
	const BATTLEANIMFUNC_DARK_PULSE
	const BATTLEANIMFUNC_SPIRAL_DESCENT_FAST
	const BATTLEANIMFUNC_RADIAL_MOVE_IN
	const BATTLEANIMFUNC_NIGHT_SLASH
DEF NUM_BATTLEANIMFUNCS EQU const_value

; BattleAnimFrameData indexes (see data/battle_anims/framesets.asm)
	const_def
	const BATTLEANIMFRAMESET_00
	const BATTLEANIMFRAMESET_01
	const BATTLEANIMFRAMESET_02
	const BATTLEANIMFRAMESET_03
	const BATTLEANIMFRAMESET_04
	const BATTLEANIMFRAMESET_05
	const BATTLEANIMFRAMESET_06
	const BATTLEANIMFRAMESET_07
	const BATTLEANIMFRAMESET_BALL_POOF
	const BATTLEANIMFRAMESET_09
	const BATTLEANIMFRAMESET_0A
	const BATTLEANIMFRAMESET_0B
	const BATTLEANIMFRAMESET_0C
	const BATTLEANIMFRAMESET_0D
	const BATTLEANIMFRAMESET_0E
	const BATTLEANIMFRAMESET_0F
	const BATTLEANIMFRAMESET_10
	const BATTLEANIMFRAMESET_BURNED
	const BATTLEANIMFRAMESET_12
	const BATTLEANIMFRAMESET_13
	const BATTLEANIMFRAMESET_14
	const BATTLEANIMFRAMESET_15
	const BATTLEANIMFRAMESET_16
	const BATTLEANIMFRAMESET_17
	const BATTLEANIMFRAMESET_18
	const BATTLEANIMFRAMESET_BIG_ROCK_STAR_HEART
	const BATTLEANIMFRAMESET_SMALL_ROCK_STAR_HEART
	const BATTLEANIMFRAMESET_1B
	const BATTLEANIMFRAMESET_1C
	const BATTLEANIMFRAMESET_1D
	const BATTLEANIMFRAMESET_POISON_DROPLET
	const BATTLEANIMFRAMESET_1F
	const BATTLEANIMFRAMESET_20
	const BATTLEANIMFRAMESET_SMALL_BUBBLE
	const BATTLEANIMFRAMESET_22
	const BATTLEANIMFRAMESET_23
	const BATTLEANIMFRAMESET_24
	const BATTLEANIMFRAMESET_25
	const BATTLEANIMFRAMESET_26
	const BATTLEANIMFRAMESET_27
	const BATTLEANIMFRAMESET_28
	const BATTLEANIMFRAMESET_29
	const BATTLEANIMFRAMESET_2A
	const BATTLEANIMFRAMESET_POWDER
	const BATTLEANIMFRAMESET_2C
	const BATTLEANIMFRAMESET_2D
	const BATTLEANIMFRAMESET_2E
	const BATTLEANIMFRAMESET_2F
	const BATTLEANIMFRAMESET_30
	const BATTLEANIMFRAMESET_31
	const BATTLEANIMFRAMESET_32
	const BATTLEANIMFRAMESET_33
	const BATTLEANIMFRAMESET_34
	const BATTLEANIMFRAMESET_35
	const BATTLEANIMFRAMESET_36
	const BATTLEANIMFRAMESET_37
	const BATTLEANIMFRAMESET_38
	const BATTLEANIMFRAMESET_39
	const BATTLEANIMFRAMESET_3A
	const BATTLEANIMFRAMESET_3B
	const BATTLEANIMFRAMESET_3C
	const BATTLEANIMFRAMESET_3D
	const BATTLEANIMFRAMESET_3E
	const BATTLEANIMFRAMESET_3F
	const BATTLEANIMFRAMESET_40
	const BATTLEANIMFRAMESET_41
	const BATTLEANIMFRAMESET_42
	const BATTLEANIMFRAMESET_43
	const BATTLEANIMFRAMESET_44
	const BATTLEANIMFRAMESET_45
	const BATTLEANIMFRAMESET_46
	const BATTLEANIMFRAMESET_47
	const BATTLEANIMFRAMESET_RAZOR_WIND_1
	const BATTLEANIMFRAMESET_RAZOR_WIND_2
	const BATTLEANIMFRAMESET_4A
	const BATTLEANIMFRAMESET_4B
	const BATTLEANIMFRAMESET_4C
	const BATTLEANIMFRAMESET_4D
	const BATTLEANIMFRAMESET_4E
	const BATTLEANIMFRAMESET_4F
	const BATTLEANIMFRAMESET_50
	const BATTLEANIMFRAMESET_51
	const BATTLEANIMFRAMESET_52
	const BATTLEANIMFRAMESET_53
	const BATTLEANIMFRAMESET_54
	const BATTLEANIMFRAMESET_55
	const BATTLEANIMFRAMESET_56
	const BATTLEANIMFRAMESET_57
	const BATTLEANIMFRAMESET_58
	const BATTLEANIMFRAMESET_59
	const BATTLEANIMFRAMESET_5A
	const BATTLEANIMFRAMESET_5B
	const BATTLEANIMFRAMESET_5C
	const BATTLEANIMFRAMESET_5D
	const BATTLEANIMFRAMESET_5E
	const BATTLEANIMFRAMESET_5F
	const BATTLEANIMFRAMESET_60
	const BATTLEANIMFRAMESET_61
	const BATTLEANIMFRAMESET_62
	const BATTLEANIMFRAMESET_AMNESIA_1
	const BATTLEANIMFRAMESET_AMNESIA_2
	const BATTLEANIMFRAMESET_AMNESIA_3_RECOVER
	const BATTLEANIMFRAMESET_66
	const BATTLEANIMFRAMESET_DIG_SAND
	const BATTLEANIMFRAMESET_DIG_PILE
	const BATTLEANIMFRAMESET_69
	const BATTLEANIMFRAMESET_6A
	const BATTLEANIMFRAMESET_6B
	const BATTLEANIMFRAMESET_6C
	const BATTLEANIMFRAMESET_6D
	const BATTLEANIMFRAMESET_6E
	const BATTLEANIMFRAMESET_6F
	const BATTLEANIMFRAMESET_MIST
	const BATTLEANIMFRAMESET_71
	const BATTLEANIMFRAMESET_72
	const BATTLEANIMFRAMESET_73
	const BATTLEANIMFRAMESET_BARRAGE_BALL_HEART
	const BATTLEANIMFRAMESET_75
	const BATTLEANIMFRAMESET_HEART_SHORT
	const BATTLEANIMFRAMESET_77
	const BATTLEANIMFRAMESET_78
	const BATTLEANIMFRAMESET_79
	const BATTLEANIMFRAMESET_7A
	const BATTLEANIMFRAMESET_7B
	const BATTLEANIMFRAMESET_7C
	const BATTLEANIMFRAMESET_WITHDRAW_SHELL
	const BATTLEANIMFRAMESET_7E
	const BATTLEANIMFRAMESET_7F
	const BATTLEANIMFRAMESET_80
	const BATTLEANIMFRAMESET_81
	const BATTLEANIMFRAMESET_82
	const BATTLEANIMFRAMESET_83
	const BATTLEANIMFRAMESET_SEISMIC_TOSS
	const BATTLEANIMFRAMESET_85
	const BATTLEANIMFRAMESET_86
	const BATTLEANIMFRAMESET_METRONOME_HAND
	const BATTLEANIMFRAMESET_AGILITY
	const BATTLEANIMFRAMESET_COTTON
	const BATTLEANIMFRAMESET_8A
	const BATTLEANIMFRAMESET_8B
	const BATTLEANIMFRAMESET_8C
	const BATTLEANIMFRAMESET_8D
	const BATTLEANIMFRAMESET_8E
	const BATTLEANIMFRAMESET_8F
	const BATTLEANIMFRAMESET_90
	const BATTLEANIMFRAMESET_91
	const BATTLEANIMFRAMESET_92
	const BATTLEANIMFRAMESET_93
	const BATTLEANIMFRAMESET_94
	const BATTLEANIMFRAMESET_95
	const BATTLEANIMFRAMESET_96
	const BATTLEANIMFRAMESET_97
	const BATTLEANIMFRAMESET_FEATHER
	const BATTLEANIMFRAMESET_99
	const BATTLEANIMFRAMESET_9A
	const BATTLEANIMFRAMESET_9B
	const BATTLEANIMFRAMESET_IMP
	const BATTLEANIMFRAMESET_IMP_FLIPPED
	const BATTLEANIMFRAMESET_CHERUB
	const BATTLEANIMFRAMESET_9F
	const BATTLEANIMFRAMESET_A0
	const BATTLEANIMFRAMESET_A1
	const BATTLEANIMFRAMESET_A2
	const BATTLEANIMFRAMESET_MORNING_SUN
	const BATTLEANIMFRAMESET_GLIMMER
	const BATTLEANIMFRAMESET_A5
	const BATTLEANIMFRAMESET_A6
	const BATTLEANIMFRAMESET_A7
	const BATTLEANIMFRAMESET_A8
	const BATTLEANIMFRAMESET_A9
	const BATTLEANIMFRAMESET_AA
	const BATTLEANIMFRAMESET_AB
	const BATTLEANIMFRAMESET_AC
	const BATTLEANIMFRAMESET_AD
	const BATTLEANIMFRAMESET_AE
	const BATTLEANIMFRAMESET_AF
	const BATTLEANIMFRAMESET_B0
	const BATTLEANIMFRAMESET_B1
	const BATTLEANIMFRAMESET_B2
	const BATTLEANIMFRAMESET_B3
	const BATTLEANIMFRAMESET_B4
	const BATTLEANIMFRAMESET_B5
	const BATTLEANIMFRAMESET_B6
	const BATTLEANIMFRAMESET_B7
	const BATTLEANIMFRAMESET_B8
	const BATTLEANIMFRAMESET_POWER_GEM
	const BATTLEANIMFRAMESET_GUNK_SHOT
	const BATTLEANIMFRAMESET_STONE_EDGE
	const BATTLEANIMFRAMESET_AQUA_JET
	const BATTLEANIMFRAMESET_BRICK_BREAK
	const BATTLEANIMFRAMESET_HYPER_VOICE
	const BATTLEANIMFRAMESET_SEED_BOMB
	const BATTLEANIMFRAMESET_MID_GLOW_SHRINKING
	const BATTLEANIMFRAMESET_DRAGON_PULSE
	const BATTLEANIMFRAMESET_BULLET_PUNCH
	const BATTLEANIMFRAMESET_LONG_PUNCH
	const BATTLEANIMFRAMESET_FOCUS_BLAST
	const BATTLEANIMFRAMESET_ICE_LONG
	const BATTLEANIMFRAMESET_TRICK_ROOM
	const BATTLEANIMFRAMESET_CLAW_TEAR
	const BATTLEANIMFRAMESET_VORTEX
	const BATTLEANIMFRAMESET_SHRINKING_GLOW
	const BATTLEANIMFRAMESET_BULK_UP
	const BATTLEANIMFRAMESET_MUD_SHOT
	const BATTLEANIMFRAMESET_SHRINKING_RING_SMALL
	const BATTLEANIMFRAMESET_SHRINKING_RING_BIG
	const BATTLEANIMFRAMESET_PULSING_ENERGY_ORB_BIG
	const BATTLEANIMFRAMESET_GYRO_BALL
	const BATTLEANIMFRAMESET_RED_STAR
	const BATTLEANIMFRAMESET_HAIL
	const BATTLEANIMFRAMESET_U_TURN_FALL
	const BATTLEANIMFRAMESET_BIG_WHIP
	const BATTLEANIMFRAMESET_SWIRL_SHORT
	const BATTLEANIMFRAMESET_SMALL_GLOW
	const BATTLEANIMFRAMESET_BIG_GLOW_CLEAR
	const BATTLEANIMFRAMESET_BERRY
	const BATTLEANIMFRAMESET_STAT_UP
	const BATTLEANIMFRAMESET_STAT_DOWN
	const BATTLEANIMFRAMESET_SPARKLE_LONG
	const BATTLEANIMFRAMESET_FLASH_CANNON_CHARGE_ORB
	const BATTLEANIMFRAMESET_SLOW_GROWING_GLOW
	const BATTLEANIMFRAMESET_FLASH_CANNON_SPARKS
	const BATTLEANIMFRAMESET_TINY_GLOW
	const BATTLEANIMFRAMESET_PULSING_SPARKLE
	const BATTLEANIMFRAMESET_OCTAZOOKA_SMOKE
	const BATTLEANIMFRAMESET_INK_SPLASH
	const BATTLEANIMFRAMESET_SMOKE_PUFF
	const BATTLEANIMFRAMESET_BUBBLE_SPLASH
	const BATTLEANIMFRAMESET_DROPLET_R
	const BATTLEANIMFRAMESET_DROPLET_L
	const BATTLEANIMFRAMESET_SMELLINGSALT_SURPRISED
	const BATTLEANIMFRAMESET_SPINNING_TRIANGLE
	const BATTLEANIMFRAMESET_SPINNING_TRIANGLE_SLOW
	const BATTLEANIMFRAMESET_BOUNCING_MUSHROOM
	const BATTLEANIMFRAMESET_MEDIUM_HORN
	const BATTLEANIMFRAMESET_MINIMIZE
	const BATTLEANIMFRAMESET_ICICLE_CRASH
	const BATTLEANIMFRAMESET_ENERGY_ORB_LONG
	const BATTLEANIMFRAMESET_VOLT_SWITCH
	const BATTLEANIMFRAMESET_DISCHARGE_SPARKS_N
	const BATTLEANIMFRAMESET_HONE_CLAWS_LEFT
	const BATTLEANIMFRAMESET_HONE_CLAWS_RIGHT
	const BATTLEANIMFRAMESET_HURRICANE
	const BATTLEANIMFRAMESET_GROWING_HEART

DEF FIRST_DYNAMIC_FRAMESET EQU const_value
	; Framesets below this can be dynamically adjusted by BATTLEANIMSTRUCT_VAR3.
	; If you do not want this, define the frameset above FIRST_DYNAMIC_FRAMESET.
	const BATTLEANIMFRAMESET_BUG_BUZZ
	const BATTLEANIMFRAMESET_POISON_JAB
	const BATTLEANIMFRAMESET_CUT_HORIZONTAL
	const BATTLEANIMFRAMESET_SUCKER_PUNCH
DEF NUM_BATTLEANIMFRAMESETS EQU const_value

; BattleAnimOAMData indexes (see data/battle_anims/oam.asm)
	const_def
	const BATTLEANIMOAMSET_00
	const BATTLEANIMOAMSET_01
	const BATTLEANIMOAMSET_02
	const BATTLEANIMOAMSET_03
	const BATTLEANIMOAMSET_04
	const BATTLEANIMOAMSET_05
	const BATTLEANIMOAMSET_06
	const BATTLEANIMOAMSET_07
	const BATTLEANIMOAMSET_08
	const BATTLEANIMOAMSET_09
	const BATTLEANIMOAMSET_0A
	const BATTLEANIMOAMSET_0B
	const BATTLEANIMOAMSET_0C
	const BATTLEANIMOAMSET_0D
	const BATTLEANIMOAMSET_0E
	const BATTLEANIMOAMSET_0F
	const BATTLEANIMOAMSET_10
	const BATTLEANIMOAMSET_11
	const BATTLEANIMOAMSET_12
	const BATTLEANIMOAMSET_13
	const BATTLEANIMOAMSET_14
	const BATTLEANIMOAMSET_15
	const BATTLEANIMOAMSET_16
	const BATTLEANIMOAMSET_17
	const BATTLEANIMOAMSET_18
	const BATTLEANIMOAMSET_19
	const BATTLEANIMOAMSET_1A
	const BATTLEANIMOAMSET_1B
	const BATTLEANIMOAMSET_1C
	const BATTLEANIMOAMSET_1D
	const BATTLEANIMOAMSET_1E
	const BATTLEANIMOAMSET_1F
	const BATTLEANIMOAMSET_20
	const BATTLEANIMOAMSET_21
	const BATTLEANIMOAMSET_22
	const BATTLEANIMOAMSET_23
	const BATTLEANIMOAMSET_24
	const BATTLEANIMOAMSET_25
	const BATTLEANIMOAMSET_26
	const BATTLEANIMOAMSET_27
	const BATTLEANIMOAMSET_28
	const BATTLEANIMOAMSET_29
	const BATTLEANIMOAMSET_2A
	const BATTLEANIMOAMSET_2B
	const BATTLEANIMOAMSET_2C
	const BATTLEANIMOAMSET_2D
	const BATTLEANIMOAMSET_2E
	const BATTLEANIMOAMSET_2F
	const BATTLEANIMOAMSET_30
	const BATTLEANIMOAMSET_31
	const BATTLEANIMOAMSET_32
	const BATTLEANIMOAMSET_33
	const BATTLEANIMOAMSET_34
	const BATTLEANIMOAMSET_35
	const BATTLEANIMOAMSET_36
	const BATTLEANIMOAMSET_37
	const BATTLEANIMOAMSET_38
	const BATTLEANIMOAMSET_39
	const BATTLEANIMOAMSET_3A
	const BATTLEANIMOAMSET_3B
	const BATTLEANIMOAMSET_3C
	const BATTLEANIMOAMSET_3D
	const BATTLEANIMOAMSET_3E
	const BATTLEANIMOAMSET_3F
	const BATTLEANIMOAMSET_40
	const BATTLEANIMOAMSET_41
	const BATTLEANIMOAMSET_42
	const BATTLEANIMOAMSET_43
	const BATTLEANIMOAMSET_44
	const BATTLEANIMOAMSET_45
	const BATTLEANIMOAMSET_46
	const BATTLEANIMOAMSET_47
	const BATTLEANIMOAMSET_48
	const BATTLEANIMOAMSET_49
	const BATTLEANIMOAMSET_4A
	const BATTLEANIMOAMSET_4B
	const BATTLEANIMOAMSET_4C
	const BATTLEANIMOAMSET_4D
	const BATTLEANIMOAMSET_4E
	const BATTLEANIMOAMSET_4F
	const BATTLEANIMOAMSET_50
	const BATTLEANIMOAMSET_51
	const BATTLEANIMOAMSET_52
	const BATTLEANIMOAMSET_53
	const BATTLEANIMOAMSET_54
	const BATTLEANIMOAMSET_55
	const BATTLEANIMOAMSET_56
	const BATTLEANIMOAMSET_57
	const BATTLEANIMOAMSET_58
	const BATTLEANIMOAMSET_59
	const BATTLEANIMOAMSET_5A
	const BATTLEANIMOAMSET_5B
	const BATTLEANIMOAMSET_5C
	const BATTLEANIMOAMSET_5D
	const BATTLEANIMOAMSET_5E
	const BATTLEANIMOAMSET_5F
	const BATTLEANIMOAMSET_60
	const BATTLEANIMOAMSET_61
	const BATTLEANIMOAMSET_62
	const BATTLEANIMOAMSET_63
	const BATTLEANIMOAMSET_64
	const BATTLEANIMOAMSET_65
	const BATTLEANIMOAMSET_66
	const BATTLEANIMOAMSET_67
	const BATTLEANIMOAMSET_68
	const BATTLEANIMOAMSET_69
	const BATTLEANIMOAMSET_6A
	const BATTLEANIMOAMSET_6B
	const BATTLEANIMOAMSET_6C
	const BATTLEANIMOAMSET_6D
	const BATTLEANIMOAMSET_6E
	const BATTLEANIMOAMSET_6F
	const BATTLEANIMOAMSET_70
	const BATTLEANIMOAMSET_71
	const BATTLEANIMOAMSET_72
	const BATTLEANIMOAMSET_73
	const BATTLEANIMOAMSET_74
	const BATTLEANIMOAMSET_75
	const BATTLEANIMOAMSET_76
	const BATTLEANIMOAMSET_77
	const BATTLEANIMOAMSET_78
	const BATTLEANIMOAMSET_79
	const BATTLEANIMOAMSET_7A
	const BATTLEANIMOAMSET_7B
	const BATTLEANIMOAMSET_7C
	const BATTLEANIMOAMSET_7D
	const BATTLEANIMOAMSET_7E
	const BATTLEANIMOAMSET_7F
	const BATTLEANIMOAMSET_80
	const BATTLEANIMOAMSET_81
	const BATTLEANIMOAMSET_82
	const BATTLEANIMOAMSET_83
	const BATTLEANIMOAMSET_84
	const BATTLEANIMOAMSET_85
	const BATTLEANIMOAMSET_86
	const BATTLEANIMOAMSET_87
	const BATTLEANIMOAMSET_88
	const BATTLEANIMOAMSET_89
	const BATTLEANIMOAMSET_8A
	const BATTLEANIMOAMSET_8B
	const BATTLEANIMOAMSET_8C
	const BATTLEANIMOAMSET_8D
	const BATTLEANIMOAMSET_8E
	const BATTLEANIMOAMSET_8F
	const BATTLEANIMOAMSET_90
	const BATTLEANIMOAMSET_91
	const BATTLEANIMOAMSET_92
	const BATTLEANIMOAMSET_93
	const BATTLEANIMOAMSET_94
	const BATTLEANIMOAMSET_95
	const BATTLEANIMOAMSET_96
	const BATTLEANIMOAMSET_97
	const BATTLEANIMOAMSET_98
	const BATTLEANIMOAMSET_99
	const BATTLEANIMOAMSET_9A
	const BATTLEANIMOAMSET_9B
	const BATTLEANIMOAMSET_9C
	const BATTLEANIMOAMSET_9D
	const BATTLEANIMOAMSET_9E
	const BATTLEANIMOAMSET_9F
	const BATTLEANIMOAMSET_A0
	const BATTLEANIMOAMSET_A1
	const BATTLEANIMOAMSET_A2
	const BATTLEANIMOAMSET_A3
	const BATTLEANIMOAMSET_A4
	const BATTLEANIMOAMSET_A5
	const BATTLEANIMOAMSET_A6
	const BATTLEANIMOAMSET_A7
	const BATTLEANIMOAMSET_A8
	const BATTLEANIMOAMSET_A9
	const BATTLEANIMOAMSET_AA
	const BATTLEANIMOAMSET_AB
	const BATTLEANIMOAMSET_AC
	const BATTLEANIMOAMSET_AD
	const BATTLEANIMOAMSET_AE
	const BATTLEANIMOAMSET_AF
	const BATTLEANIMOAMSET_B0
	const BATTLEANIMOAMSET_B1
	const BATTLEANIMOAMSET_B2
	const BATTLEANIMOAMSET_B3
	const BATTLEANIMOAMSET_B4
	const BATTLEANIMOAMSET_B5
	const BATTLEANIMOAMSET_B6
	const BATTLEANIMOAMSET_B7
	const BATTLEANIMOAMSET_B8
	const BATTLEANIMOAMSET_B9
	const BATTLEANIMOAMSET_BA
	const BATTLEANIMOAMSET_BB
	const BATTLEANIMOAMSET_BC
	const BATTLEANIMOAMSET_BD
	const BATTLEANIMOAMSET_BE
	const BATTLEANIMOAMSET_BF
	const BATTLEANIMOAMSET_C0
	const BATTLEANIMOAMSET_C1
	const BATTLEANIMOAMSET_C2
	const BATTLEANIMOAMSET_C3
	const BATTLEANIMOAMSET_C4
	const BATTLEANIMOAMSET_C5
	const BATTLEANIMOAMSET_C6
	const BATTLEANIMOAMSET_C7
	const BATTLEANIMOAMSET_C8
	const BATTLEANIMOAMSET_C9
	const BATTLEANIMOAMSET_CA
	const BATTLEANIMOAMSET_CB
	const BATTLEANIMOAMSET_CC
	const BATTLEANIMOAMSET_CD
	const BATTLEANIMOAMSET_CE
	const BATTLEANIMOAMSET_CF
	const BATTLEANIMOAMSET_D0
	const BATTLEANIMOAMSET_D1
	const BATTLEANIMOAMSET_D2
	const BATTLEANIMOAMSET_D3
	const BATTLEANIMOAMSET_D4
	const BATTLEANIMOAMSET_D5
	const BATTLEANIMOAMSET_D6
	const BATTLEANIMOAMSET_D7
	const BATTLEANIMOAMSET_D8 ; E1 in MAE
	const BATTLEANIMOAMSET_D9 ; E2 in MAE
	const BATTLEANIMOAMSET_DA ; E3 in MAE
	const BATTLEANIMOAMSET_DB ; E4 in MAE
	const BATTLEANIMOAMSET_DC ; E8 in MAE
	const BATTLEANIMOAMSET_DD ; 12B in MAE
	const BATTLEANIMOAMSET_DE ; FA in MAE
	const BATTLEANIMOAMSET_DF ; FB in MAE
	const BATTLEANIMOAMSET_E0 ; DD in MAE
	const BATTLEANIMOAMSET_E1 ; D8 in sour
	const BATTLEANIMOAMSET_E2 ; 10E in MAE
	const BATTLEANIMOAMSET_E3 ; 10F in MAE
	const BATTLEANIMOAMSET_E4 ; 110 in MAE
	const BATTLEANIMOAMSET_E5 ; 111 in MAE
	const BATTLEANIMOAMSET_E6 ; 112 in MAE
	const BATTLEANIMOAMSET_E7 ; 113 in MAE
	const BATTLEANIMOAMSET_E8 ; 114 in MAE
	const BATTLEANIMOAMSET_E9 ; 115 in MAE
	const BATTLEANIMOAMSET_EA ; 11D in MAE
	const BATTLEANIMOAMSET_EB ; 11E in MAE
	const BATTLEANIMOAMSET_EC ; D9 in sour
	const BATTLEANIMOAMSET_ED ; DA in sour
	const BATTLEANIMOAMSET_EE ; F5 in MAE
	const BATTLEANIMOAMSET_EF ; F7 in MAE
	const BATTLEANIMOAMSET_F0 ; F8 in MAE
	const BATTLEANIMOAMSET_F1 ; 118 in MAE
	const BATTLEANIMOAMSET_F2 ; 119 in MAE (uses unported MAE oamset DA)
	const BATTLEANIMOAMSET_F3 ; 11C in MAE (uses unported MAE oamset E9)
	const BATTLEANIMOAMSET_BIG_WHIP_3
	const BATTLEANIMOAMSET_BIG_WHIP_1
	const BATTLEANIMOAMSET_F6 ; EA in MAE
	const BATTLEANIMOAMSET_F7 ; 12C in MAE
	const BATTLEANIMOAMSET_F8 ; 12D in MAE
	const BATTLEANIMOAMSET_F9 ; 12E in MAE
	const BATTLEANIMOAMSET_FA ; 12F in MAE
	const BATTLEANIMOAMSET_FB ; DB in MAE
	const BATTLEANIMOAMSET_FC ; FE in MAE
	const BATTLEANIMOAMSET_STONE_EDGE
	const BATTLEANIMOAMSET_BRICK_BREAK
	const BATTLEANIMOAMSET_HYPER_VOICE ; d1 in chatty
	const BATTLEANIMOAMSET_BUG_BUZZ1 ; ee in chatty
	const BATTLEANIMOAMSET_BUG_BUZZ2 ; ed in chatty
	const BATTLEANIMOAMSET_BULLET_PUNCH ; e2 in chatty
	const BATTLEANIMOAMSET_U_TURN_FALL ; ef
	const BATTLEANIMOAMSET_SWIRL_SHORT_1
	const BATTLEANIMOAMSET_SWIRL_SHORT_2
	const BATTLEANIMOAMSET_SWIRL_SHORT_3
	const BATTLEANIMOAMSET_SWIRL_SHORT_4
	const BATTLEANIMOAMSET_MUSHROOM_1
	const BATTLEANIMOAMSET_MUSHROOM_2
	const BATTLEANIMOAMSET_MUSHROOM_3
	const BATTLEANIMOAMSET_STAT
	const BATTLEANIMOAMSET_ICICLE_CRASH
	const BATTLEANIMOAMSET_BIG_WHIP_2
	const BATTLEANIMOAMSET_VOLT_SWITCH_1
	const BATTLEANIMOAMSET_VOLT_SWITCH_2
	const BATTLEANIMOAMSET_VOLT_SWITCH_3
	const BATTLEANIMOAMSET_VOLT_SWITCH_4
	const BATTLEANIMOAMSET_VOLT_SWITCH_5
	const BATTLEANIMOAMSET_VOLT_SWITCH_6
	const BATTLEANIMOAMSET_DISCHARGE_SPARKS_N_1
	const BATTLEANIMOAMSET_DISCHARGE_SPARKS_N_2
	const BATTLEANIMOAMSET_HONE_CLAWS_1
	const BATTLEANIMOAMSET_HONE_CLAWS_2
	const BATTLEANIMOAMSET_HONE_CLAWS_3
	const BATTLEANIMOAMSET_HONE_CLAWS_4
	const BATTLEANIMOAMSET_HURRICANE
DEF NUM_BATTLEANIMOAMSETS EQU const_value

; BattleBGEffects indexes (see engine/battle_anims/bg_effects.asm)
	const_def 1
	const ANIM_BG_FLASH_INVERTED
	const ANIM_BG_FLASH_WHITE
	const ANIM_BG_WHITE_HUES
	const ANIM_BG_BLACK_HUES
	const ANIM_BG_ALTERNATE_HUES
	const ANIM_BG_CYCLE_OBPALS_GRAY_AND_YELLOW
	const ANIM_BG_CYCLE_MID_OBPALS_GRAY_AND_YELLOW
	const ANIM_BG_CYCLE_BGPALS_INVERTED
	const ANIM_BG_HIDE_MON
	const ANIM_BG_SHOW_MON
	const ANIM_BG_ENTER_MON
	const ANIM_BG_RETURN_MON
	const ANIM_BG_SURF
	const ANIM_BG_WHIRLPOOL
	const ANIM_BG_TELEPORT
	const ANIM_BG_NIGHT_SHADE
	const ANIM_BG_BATTLEROBJ_1ROW
	const ANIM_BG_BATTLEROBJ_2ROW
	const ANIM_BG_DOUBLE_TEAM
	const ANIM_BG_ACID_ARMOR
	const ANIM_BG_RAPID_FLASH
	const ANIM_BG_FADE_MON_TO_LIGHT
	const ANIM_BG_FADE_MON_TO_BLACK
	const ANIM_BG_FADE_MON_TO_LIGHT_REPEATING
	const ANIM_BG_FADE_MON_TO_BLACK_REPEATING
	const ANIM_BG_CYCLE_MON_LIGHT_DARK_REPEATING
	const ANIM_BG_FLASH_MON_REPEATING
	const ANIM_BG_FADE_MONS_TO_BLACK_REPEATING
	const ANIM_BG_FADE_MON_TO_WHITE_WAIT_FADE_BACK
	const ANIM_BG_FADE_MON_FROM_WHITE
	const ANIM_BG_SHAKE_SCREEN_X
	const ANIM_BG_SHAKE_SCREEN_Y
	const ANIM_BG_WITHDRAW
	const ANIM_BG_BOUNCE_DOWN
	const ANIM_BG_DIG
	const ANIM_BG_TACKLE
	const ANIM_BG_BODY_SLAM
	const ANIM_BG_WOBBLE_MON
	const ANIM_BG_REMOVE_MON
	const ANIM_BG_WAVE_DEFORM_MON
	const ANIM_BG_PSYCHIC
	const ANIM_BG_BETA_SEND_OUT_MON1
	const ANIM_BG_BETA_SEND_OUT_MON2
	const ANIM_BG_FLAIL
	const ANIM_BG_PURSUIT
	const ANIM_BG_ROLLOUT
	const ANIM_BG_VITAL_THROW
	const ANIM_BG_START_WATER
	const ANIM_BG_WATER
	const ANIM_BG_END_WATER
	const ANIM_BG_VIBRATE_MON
	const ANIM_BG_WOBBLE_PLAYER
	const ANIM_BG_WOBBLE_SCREEN
	const ANIM_BG_SHAKE_MON_X
	const ANIM_BG_SHAKE_MON_Y
DEF NUM_ANIM_BGS EQU const_value - 1

; wBattleAnimTileDict keys (see wram.asm)
; AnimObjGFX indexes (see data/battle_anims/object_gfx.asm)
	const_def 1
	const ANIM_GFX_HIT
	const ANIM_GFX_CUT
	const ANIM_GFX_FIRE
	const ANIM_GFX_WATER
	const ANIM_GFX_LIGHTNING
	const ANIM_GFX_PLANT
	const ANIM_GFX_SMOKE
	const ANIM_GFX_EXPLOSION
	const ANIM_GFX_ROCKS
	const ANIM_GFX_ICE
	const ANIM_GFX_POKE_BALL
	const ANIM_GFX_POISON
	const ANIM_GFX_BUBBLE
	const ANIM_GFX_NOISE
	const ANIM_GFX_POWDER
	const ANIM_GFX_BEAM
	const ANIM_GFX_SPEED
	const ANIM_GFX_CHARGE
	const ANIM_GFX_WIND
	const ANIM_GFX_WIND_BG
	const ANIM_GFX_WHIP
	const ANIM_GFX_EGG
	const ANIM_GFX_ROPE
	const ANIM_GFX_PSYCHIC
	const ANIM_GFX_REFLECT
	const ANIM_GFX_STATUS
	const ANIM_GFX_SAND
	const ANIM_GFX_WEB
	const ANIM_GFX_HAZE
	const ANIM_GFX_HORN
	const ANIM_GFX_FLOWER
	const ANIM_GFX_MISC
	const ANIM_GFX_SKY_ATTACK
	const ANIM_GFX_GLOBE
	const ANIM_GFX_SHAPES
	const ANIM_GFX_OBJECTS
	const ANIM_GFX_SHINE
	const ANIM_GFX_ANGELS
	const ANIM_GFX_WAVE
	const ANIM_GFX_AEROBLAST
	const ANIM_GFX_MOON
	const ANIM_GFX_AURA_SPHERE
	const ANIM_GFX_BUG_BUZZ
	const ANIM_GFX_MID_GLOW_CLEAR
	const ANIM_GFX_TEAR
	const ANIM_GFX_VORTEX
	const ANIM_GFX_BULK_UP
	const ANIM_GFX_RINGS
	const ANIM_GFX_BIG_RINGS
	const ANIM_GFX_GYRO_BALL
	const ANIM_GFX_HEARTS
	const ANIM_GFX_STARS
	const ANIM_GFX_U_TURN
	const ANIM_GFX_MISC_2
	const ANIM_GFX_BEAM_LIGHT
	const ANIM_GFX_SMOKE_PUFF
	const ANIM_GFX_FOCUS_BLAST
	const ANIM_GFX_ENERGY_BALL
	const ANIM_GFX_TRICK_ROOM
	const ANIM_GFX_BIG_GLOW_CLEAR
	const ANIM_GFX_OBJECTS_2
	const ANIM_GFX_BIG_WHIP
	const ANIM_GFX_SWIRL
	const ANIM_GFX_TRIANGLE
	const ANIM_GFX_MUSHROOM
	const ANIM_GFX_BERRY
	const ANIM_GFX_STATS
	const ANIM_GFX_GLOW
	const ANIM_GFX_AQUA_JET
	const ANIM_GFX_HIT_2
	const ANIM_GFX_ICICLE_CRASH
	const ANIM_GFX_VOLT_SWITCH
	const ANIM_GFX_PSYSTRIKE
	const ANIM_GFX_HURRICANE
	const ANIM_GFX_PLAYERHEAD
	const ANIM_GFX_ENEMYFEET
	const ANIM_GFX_POKE_BALL_BG
DEF NUM_ANIM_GFX EQU const_value - 1

; battle_bg_effect struct members (see macros/ram.asm)
rsreset
DEF BG_EFFECT_STRUCT_FUNCTION    rb
DEF BG_EFFECT_STRUCT_JT_INDEX    rb
DEF BG_EFFECT_STRUCT_BATTLE_TURN rb
DEF BG_EFFECT_STRUCT_PARAM       rb
DEF BG_EFFECT_STRUCT_LENGTH EQU _RS
DEF NUM_BG_EFFECTS EQU 5 ; see wActiveBGEffects

; anim_bgeffect battle turn values for some effects
	const_def
	const BG_EFFECT_TARGET ; 0
	const BG_EFFECT_USER   ; 1

; battle palettes
	const_def
	const PAL_BATTLE_BG_PLAYER     ; 0
	const PAL_BATTLE_BG_ENEMY      ; 1
	const PAL_BATTLE_BG_ENEMY_HP   ; 2
	const PAL_BATTLE_BG_PLAYER_HP  ; 3
	const PAL_BATTLE_BG_EXP_GENDER ; 4
	const PAL_BATTLE_BG_STATUS     ; 5
	const PAL_BATTLE_BG_TYPE_CAT   ; 6
	const PAL_BATTLE_BG_TEXT       ; 7
; sentinel palette indices that denote "user" or "target" for battle pics
; (anim_setbgpal applies them to the relevant obj palettes too)
	const PAL_BATTLE_BG_USER       ; 8
	const PAL_BATTLE_BG_TARGET     ; 9

; animation object palettes
	const_def
	const PAL_BATTLE_OB_ENEMY  ; 0
	const PAL_BATTLE_OB_PLAYER ; 1
	const PAL_BATTLE_OB_GRAY   ; 2
	const PAL_BATTLE_OB_YELLOW ; 3
	const PAL_BATTLE_OB_RED    ; 4
	const PAL_BATTLE_OB_GREEN  ; 5
	const PAL_BATTLE_OB_BLUE   ; 6
	const PAL_BATTLE_OB_BROWN  ; 7

; custom bg/obj palettes (see gfx/battle_anims/custom.pal)
; the first 6 matches PAL_BATTLE_OB_GRAY/YELLOW/...
	const_def
	const PAL_BTLCUSTOM_GRAY             ; 0
	const PAL_BTLCUSTOM_YELLOW           ; 1
	const PAL_BTLCUSTOM_RED              ; 2
	const PAL_BTLCUSTOM_GREEN            ; 3
	const PAL_BTLCUSTOM_BLUE             ; 4
	const PAL_BTLCUSTOM_BROWN            ; 5
	const PAL_BTLCUSTOM_METALLIC         ; 6
	const PAL_BTLCUSTOM_PURPLE           ; 7
	const PAL_BTLCUSTOM_ICE              ; 8
	const PAL_BTLCUSTOM_FIRE             ; 9
	const PAL_BTLCUSTOM_GLOBE            ; a
	const PAL_BTLCUSTOM_WATER            ; b
	const PAL_BTLCUSTOM_BUBBLE           ; c
	const PAL_BTLCUSTOM_DRAGON_FIRE      ; d
	const PAL_BTLCUSTOM_DRAGONBREATH     ; e
	const PAL_BTLCUSTOM_DRAGON_RAGE      ; f
	const PAL_BTLCUSTOM_AURORA           ; 10
	const PAL_BTLCUSTOM_SPORE            ; 11
	const PAL_BTLCUSTOM_PEACH            ; 12
	const PAL_BTLCUSTOM_BERRY            ; 13
	const PAL_BTLCUSTOM_LIGHT_SCREEN     ; 14
	const PAL_BTLCUSTOM_SKILL_SWAP       ; 15
	const PAL_BTLCUSTOM_WILL_O_WISP      ; 16
	const PAL_BTLCUSTOM_GLOW_YELLOW      ; 17
	const PAL_BTLCUSTOM_GLOW_LUSTER      ; 18
	const PAL_BTLCUSTOM_BRIGHT           ; 19
	const PAL_BTLCUSTOM_SIGNAL_BEAM_RED  ; 1a
	const PAL_BTLCUSTOM_SIGNAL_BEAM_BLUE ; 1b
	const PAL_BTLCUSTOM_BULK_UP          ; 1c
	const PAL_BTLCUSTOM_PSYCHO_BOOST_2   ; 1d
	const PAL_BTLCUSTOM_PAYBACK          ; 1e
	const PAL_BTLCUSTOM_GASTRO_ACID      ; 1f
	const PAL_BTLCUSTOM_DARK_PULSE       ; 20
	const PAL_BTLCUSTOM_GLOW_LIME        ; 21
	const PAL_BTLCUSTOM_DRAGON_PULSE     ; 22
	const PAL_BTLCUSTOM_SNOW             ; 23
	const PAL_BTLCUSTOM_REFLECT          ; 24
	const PAL_BTLCUSTOM_MIRROR_COAT      ; 25
	const PAL_BTLCUSTOM_ACID             ; 26
	const PAL_BTLCUSTOM_MOON             ; 27
	const PAL_BTLCUSTOM_MOONBLAST        ; 28
	const PAL_BTLCUSTOM_VERY_BRIGHT      ; 29
	const PAL_BTLCUSTOM_PINK             ; 2a
	const PAL_BTLCUSTOM_VERY_BRIGHT_PINK ; 2b
	const PAL_BTLCUSTOM_ATTACK           ; 2c
	const PAL_BTLCUSTOM_DEFENSE          ; 2d
	const PAL_BTLCUSTOM_SP_ATTACK        ; 2e
	const PAL_BTLCUSTOM_SP_DEFENSE       ; 2f
	const PAL_BTLCUSTOM_SPEED            ; 30
	const PAL_BTLCUSTOM_ACCURACY         ; 31
	const PAL_BTLCUSTOM_EVASION          ; 32
DEF NUM_CUSTOM_BATTLE_PALETTES EQU const_value

DEF PAL_BTLCUSTOM_DEFAULT EQU -1
