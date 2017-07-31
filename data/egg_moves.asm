INCLUDE "includes.asm"


SECTION "Egg Moves", ROMX, BANK[EGG_MOVES]


INCLUDE "data/egg_move_pointers.asm"


EggMoves::

BulbasaurEggMoves:
	db CHARM
	db PETAL_DANCE
	db SLUDGE
	db LIGHT_SCREEN
	db SAFEGUARD
	db $ff

CharmanderEggMoves:
	db ANCIENTPOWER
	db BELLY_DRUM
	db BITE
	db CRUNCH
	db DRAGON_DANCE
	db FLARE_BLITZ
	db OUTRAGE
	db $ff

SquirtleEggMoves:
	db CONFUSION
	db FLAIL
	db FORESIGHT
	db HAZE
	db MIRROR_COAT
	db MIST
	db $ff

PidgeyEggMoves:
	db PECK
	db FEINT_ATTACK
	db FORESIGHT
	db PURSUIT
	db AIR_SLASH
	db STEEL_WING
	db CHARM
	db EXTREMESPEED
	db $ff

RattataEggMoves:
	db FLAME_WHEEL
	db FURY_SWIPES
	db REVERSAL
	db SCREECH
	db BITE
	db COUNTER
	db $ff

MarillEggMoves:
	db BELLY_DRUM
	db FORESIGHT
	db FUTURE_SIGHT
	db PERISH_SONG
	db SUPERSONIC
	db LIGHT_SCREEN
	db CALM_MIND
	db $ff

EkansEggMoves:
	db CRUNCH
	db DISABLE
	db PURSUIT
	db SCARY_FACE
	db $ff

SandshrewEggMoves:
	db FLAIL
	db METAL_CLAW
	db RAPID_SPIN
	db SAFEGUARD
	db COUNTER
	db NIGHT_SLASH
	db $ff

NidoranFEggMoves:
	db CHARM
	db DISABLE
	db FOCUS_ENERGY
	db PURSUIT
	db SUPERSONIC
	db TAKE_DOWN
	db $ff

NidoranMEggMoves:
	db CONFUSION
	db DISABLE
	db SUPERSONIC
	db TAKE_DOWN
	db CALM_MIND
	db COUNTER
	db $ff

ClefairyEggMoves:
	db CALM_MIND
	db BELLY_DRUM
	db METRONOME
	db SPLASH
	db SOFTBOILED
	db $ff

VulpixEggMoves:
	db DISABLE
	db FLAIL
	db FLARE_BLITZ
	db HYPNOSIS
	db FEINT_ATTACK
	db EXTRASENSORY
	db CHARM
	db ENERGY_BALL
	db ROAR
	db $ff

JigglypuffEggMoves:
	db THIEF
	db FEINT_ATTACK
	db PERISH_SONG
	db SLEEP_TALK
	db MOONBLAST
	db $ff

ZubatEggMoves:
	db FEINT_ATTACK
	db GUST
	db HYPNOSIS
	db NASTY_PLOT
	db PURSUIT
	db QUICK_ATTACK
	db ZEN_HEADBUTT
	db $ff

OddishEggMoves:
	db CHARM
	db FLAIL
	db RAZOR_LEAF
	db MORNING_SUN
	db SWORDS_DANCE
	db $ff

ParasEggMoves:
	db AGILITY
	db FLAIL
	db LEECH_SEED
	db METAL_CLAW
	db PSYBEAM
	db PURSUIT
	db SCREECH
	db $ff

VenonatEggMoves:
	db AGILITY
	db BATON_PASS
	db MORNING_SUN
	db SCREECH
	db TOXIC_SPIKES
	db $ff

DiglettEggMoves:
	db ANCIENTPOWER
	db FEINT_ATTACK
	db HEADBUTT
	db PURSUIT
	db REVERSAL
	db SCREECH
	db $ff

MeowthEggMoves:
	db CHARM
	db FLAIL
	db HYPNOSIS
	db LEER
	db NIGHT_SLASH
	db $ff

PsyduckEggMoves:
	db CONFUSE_RAY
	db CROSS_CHOP
	db ENCORE
	db FORESIGHT
	db FUTURE_SIGHT
	db HYPNOSIS
	db PSYBEAM
	db ICE_BEAM
	db LIGHT_SCREEN
	db PSYCHIC_M
	db $ff

MankeyEggMoves:
	db ENCORE
	db FORESIGHT
	db BULK_UP
	db REVERSAL
	db ROCK_SLIDE
	db COUNTER
	db GUNK_SHOT
	db NIGHT_SLASH
	db CLOSE_COMBAT
	db $ff

GrowlitheEggMoves:
	db DOUBLE_KICK
	db FIRE_SPIN
	db MORNING_SUN
	db THRASH
	db CRUNCH
	db FLARE_BLITZ
	db BODY_SLAM
	db SAFEGUARD
	db CLOSE_COMBAT
	db $ff

PoliwagEggMoves:
	db ENCORE
	db HAZE
	db MIST
	db SPLASH
	db BUBBLE_BEAM
	db LOCK_ON
	db WATER_PULSE
	db $ff

AbraEggMoves:
	db BARRIER
	db ENCORE
	db LIGHT_SCREEN
	db $ff

MachopEggMoves:
	db BULLET_PUNCH
	db ENCORE
	db BULK_UP
	db LIGHT_SCREEN
	db MACH_PUNCH
	db CLOSE_COMBAT
	db $ff

BellsproutEggMoves:
	db ENCORE
	db LEECH_LIFE
	db SWORDS_DANCE
	db REFLECT
	db MORNING_SUN
	db $ff

TentacoolEggMoves:
	db AURORA_BEAM
	db CONFUSE_RAY
	db HAZE
	db MIRROR_COAT
	db RAPID_SPIN
	db SAFEGUARD
	db $ff

GeodudeEggMoves:
	db FLAIL
	db ROCK_SLIDE
	db $ff

PonytaEggMoves:
	db CHARM
	db DOUBLE_KICK
	db HYPNOSIS
	db MORNING_SUN
	db THRASH
	db QUICK_ATTACK
	db FLAME_WHEEL
	db EXTREMESPEED
	db $ff

SlowpokeEggMoves:
	db BELLY_DRUM
	db FUTURE_SIGHT
	db STOMP
	db SAFEGUARD
	db ZEN_HEADBUTT
	db $ff

FarfetchDEggMoves:
	db FLAIL
	db FORESIGHT
	db GUST
	db QUICK_ATTACK
	db STEEL_WING
	db NIGHT_SLASH
	db ROOST
	db $ff

DoduoEggMoves:
	db FEINT_ATTACK
	db FLAIL
	db HAZE
	db SUPERSONIC
	db QUICK_ATTACK
	db $ff

SeelEggMoves:
	db DISABLE
	db LICK
	db PECK
	db PERISH_SONG
	db ENCORE
	db WATER_PULSE
	db ICICLE_SPEAR
	db $ff

GrimerEggMoves:
	db HAZE
	db LICK
	db MEAN_LOOK
	db SCARY_FACE
	db $ff

ShellderEggMoves:
	db AVALANCHE
	db BARRIER
	db BUBBLE_BEAM
	db RAPID_SPIN
	db SCREECH
	db TAKE_DOWN
	db WATER_PULSE
	db ICICLE_SPEAR
	db $ff

GastlyEggMoves:
	db ASTONISH
	db DISABLE
	db HAZE
	db PERISH_SONG
	db SCARY_FACE
	db NASTY_PLOT
	db FEINT_ATTACK
	db $ff

OnixEggMoves:
	db DEFENSE_CURL
	db FLAIL
	db ROCK_SLIDE
	db EARTHQUAKE
	db $ff

DrowzeeEggMoves:
	db BARRIER
	db LIGHT_SCREEN
	db BELLY_DRUM
	db $ff

KrabbyEggMoves:
	db AGILITY
	db HAZE
	db FLAIL
	db DIG
	db CALM_MIND
	db $ff

ExeggcuteEggMoves:
	db MEGA_DRAIN
	db MOONLIGHT
	db MORNING_SUN
	db ANCIENTPOWER
	db REFLECT
	db $ff

CuboneEggMoves:
	db ANCIENTPOWER
	db BELLY_DRUM
	db DOUBLE_KICK
	db PERISH_SONG
	db SCREECH
	db ROCK_SLIDE
	db SWORDS_DANCE
	db IRON_HEAD
	db $ff

KoffingEggMoves:
	db PSYBEAM
	db SCREECH
	db DESTINY_BOND
	db PAIN_SPLIT
	db TOXIC_SPIKES
	db $ff

RhyhornEggMoves:
	db CRUNCH
	db MAGNITUDE
	db PURSUIT
	db REVERSAL
	db THRASH
	db ROCK_SLIDE
	db COUNTER
	db $ff

ChanseyEggMoves:
	db METRONOME
	db HEAL_BELL
	db $ff

TangelaEggMoves:
	db CONFUSION
	db FLAIL
	db LEECH_SEED
	db $ff

KangaskhanEggMoves:
	db DISABLE
	db FOCUS_ENERGY
	db FORESIGHT
	db STOMP
	db SAFEGUARD
	db $ff

HorseaEggMoves:
	db AURORA_BEAM
	db DISABLE
	db DRAGON_RAGE
	db FLAIL
	db OCTAZOOKA
	db SPLASH
	db HAZE
	db WATER_PULSE
	db $ff

TogepiEggMoves:
	db EXTRASENSORY
	db FORESIGHT
	db FUTURE_SIGHT
	db MORNING_SUN
	db NASTY_PLOT
	db PECK
	db $ff

MrMimeEggMoves:
	db CONFUSE_RAY
	db FUTURE_SIGHT
	db HYPNOSIS
	db NASTY_PLOT
	db $ff

ScytherEggMoves:
	db BATON_PASS
	db BUG_BUZZ
	db REVERSAL
	db COUNTER
	db SAFEGUARD
	db LIGHT_SCREEN
	db NIGHT_SLASH
	db $ff

JynxEggMoves:
	db BULK_UP
	db NASTY_PLOT
	db $ff

PinsirEggMoves:
	db FEINT_ATTACK
	db FLAIL
	db FURY_ATTACK
	db QUICK_ATTACK
	db CLOSE_COMBAT
	db $ff

LaprasEggMoves:
	db AURORA_BEAM
	db DRAGON_DANCE
	db FORESIGHT
	db FUTURE_SIGHT
	db HEAL_BELL
	db $ff

EeveeEggMoves:
	db FLAIL
	db CHARM
	db $ff

OmanyteEggMoves:
	db AURORA_BEAM
	db BUBBLE_BEAM
	db HAZE
	db SPIKES
	db TOXIC_SPIKES
	db SUPERSONIC
	db WATER_PULSE
	db $ff

KabutoEggMoves:
	db AURORA_BEAM
	db BUBBLE_BEAM
	db CONFUSE_RAY
	db FLAIL
	db FORESIGHT
	db RAPID_SPIN
	db SCREECH
	db TAKE_DOWN
	db DIG
	db $ff

AerodactylEggMoves:
	db FORESIGHT
	db PURSUIT
	db STEEL_WING
	db ROOST
	db $ff

DratiniEggMoves:
	db EXTREMESPEED
	db HAZE
	db MIST
	db SUPERSONIC
	db WATER_PULSE
	db $ff

ChikoritaEggMoves:
	db FLAIL
	db LEECH_SEED
	db VINE_WHIP
	db ANCIENTPOWER
	db COUNTER
	db SWORDS_DANCE
	db CHARM
	db HEAL_BELL
	db $ff

CyndaquilEggMoves:
	db DOUBLE_KICK
	db EXTRASENSORY
	db FLARE_BLITZ
	db FORESIGHT
	db FURY_SWIPES
	db REVERSAL
	db CLOSE_COMBAT
	db THRASH
	db QUICK_ATTACK
	db $ff

TotodileEggMoves:
	db DRAGON_DANCE
	db METAL_CLAW
	db CRUNCH
	db THRASH
	db HYDRO_PUMP
	db ANCIENTPOWER
	db ROCK_SLIDE
	db WATER_PULSE
	db $ff

SentretEggMoves:
	db CHARM
	db FOCUS_ENERGY
	db PURSUIT
	db REVERSAL
	db SLASH
	db DOUBLE_EDGE
	db $ff

HoothootEggMoves:
	db AGILITY
	db FEINT_ATTACK
	db NIGHT_SHADE
	db SUPERSONIC
	db WING_ATTACK
	db SKY_ATTACK
	db MOONLIGHT
	db $ff

LedybaEggMoves:
	db DIZZY_PUNCH
	db ENCORE
	db PSYBEAM
	db SCREECH
	db LIGHT_SCREEN
	db $ff

SpinarakEggMoves:
	db BATON_PASS
	db DISABLE
	db MEGAHORN
	db PSYBEAM
	db PURSUIT
	db SONIC_BOOM
	db POISON_JAB
	db NIGHT_SLASH
	db TOXIC_SPIKES
	db $ff

ChinchouEggMoves:
	db AGILITY
	db MIST
	db PSYBEAM
	db SCREECH
	db FLAIL
	db SUPERSONIC
	db WATER_PULSE
	db $ff

PichuEggMoves:
	db DISARM_VOICE
	db DOUBLE_SLAP
	db ENCORE
	db FLAIL
	db REVERSAL
	db $ff

MunchlaxEggMoves:
	db CHARM
	db COUNTER
	db CURSE
	db DOUBLE_EDGE
	db PURSUIT
	db LICK
	db GUNK_SHOT
	db $ff

NatuEggMoves:
	db DRILL_PECK
	db FEINT_ATTACK
	db HAZE
	db QUICK_ATTACK
	db STEEL_WING
	db ZEN_HEADBUTT
	db ROOST
	db $ff

MareepEggMoves:
	db AGILITY
	db REFLECT
	db MUD_SLAP
	db SCREECH
	db THUNDERBOLT
	db TAKE_DOWN
	db BODY_SLAM
	db SAFEGUARD
	db $ff

SudowoodoEggMoves:
	db HARDEN
	db SELFDESTRUCT
	db $ff

SunkernEggMoves:
	db $ff

YanmaEggMoves:
	db FEINT_ATTACK
	db LEECH_LIFE
	db REVERSAL
	db $ff

WooperEggMoves:
	db COUNTER
	db DOUBLE_KICK
	db ENCORE
	db RECOVER
	db BODY_SLAM
	db ANCIENTPOWER
	db SAFEGUARD
	db $ff

MurkrowEggMoves:
	db CONFUSE_RAY
	db DRILL_PECK
	db PERISH_SONG
	db QUICK_ATTACK
	db SCREECH
	db WING_ATTACK
	db SKY_ATTACK
	db ROOST
	db $ff

MisdreavusEggMoves:
	db DESTINY_BOND
	db NASTY_PLOT
	db SCREECH
	db $ff

WobbuffetEggMoves:
	db CHARM
	db ENCORE
	db $ff

GirafarigEggMoves:
	db DOUBLE_KICK
	db FORESIGHT
	db FUTURE_SIGHT
	db MEAN_LOOK
	db MIRROR_COAT
	db TAKE_DOWN
	db CALM_MIND
	db $ff

PinecoEggMoves:
	db FLAIL
	db PIN_MISSILE
	db SWIFT
	db REFLECT
	db TOXIC_SPIKES
	db $ff

DunsparceEggMoves:
	db AGILITY
	db ASTONISH
	db BITE
	db RAGE
	db ANCIENTPOWER
	db ROCK_SLIDE
	db HEX
	db $ff

GligarEggMoves:
	db AGILITY
	db BATON_PASS
	db METAL_CLAW
	db WING_ATTACK
	db COUNTER
	db NIGHT_SLASH
	db $ff

SnubbullEggMoves:
	db FEINT_ATTACK
	db LEER
	db METRONOME
	db REFLECT
	db CRUNCH
	db HEAL_BELL
	db LICK
	db CLOSE_COMBAT
	db $ff

QwilfishEggMoves:
	db ASTONISH
	db BUBBLE_BEAM
	db FLAIL
	db HAZE
	db SUPERSONIC
	db POISON_JAB
	db WATER_PULSE
	db $ff

HeracrossEggMoves:
	db FLAIL
	db HARDEN
	db PURSUIT
	db $ff

SneaselEggMoves:
	db BITE
	db FORESIGHT
	db PURSUIT
	db COUNTER
	db REFLECT
	db ICICLE_CRASH
	db ICE_SHARD
	db $ff

TeddiursaEggMoves:
	db BELLY_DRUM
	db CROSS_CHOP
	db CRUNCH
	db FOCUS_ENERGY
	db METAL_CLAW
	db PLAY_ROUGH
	db TAKE_DOWN
	db SEISMIC_TOSS
	db COUNTER
	db GUNK_SHOT
	db NIGHT_SLASH
	db CLOSE_COMBAT
	db $ff

SlugmaEggMoves:
	db SMOKESCREEN
	db CURSE
	db $ff

SwinubEggMoves:
	db AVALANCHE
	db BITE
	db TAKE_DOWN
	db BODY_SLAM
	db ROCK_SLIDE
	db ANCIENTPOWER
	db ICICLE_CRASH
	db ICICLE_SPEAR
	db $ff

CorsolaEggMoves:
	db BARRIER
	db CONFUSE_RAY
	db MIST
	db SCREECH
	db ROCK_SLIDE
	db SAFEGUARD
	db CALM_MIND
	db WATER_PULSE
	db ICICLE_SPEAR
	db $ff

RemoraidEggMoves:
	db FLAIL
	db HAZE
	db OCTAZOOKA
	db SCREECH
	db SUPERSONIC
	db AURORA_BEAM
	db GUNK_SHOT
	db WATER_PULSE
	db $ff

MantineEggMoves:
	db HAZE
	db MIRROR_COAT
	db SPLASH
	db TWISTER
	db HYDRO_PUMP
	db GUNK_SHOT
	db $ff

SkarmoryEggMoves:
	db DRILL_PECK
	db PURSUIT
	db SKY_ATTACK
	db $ff

HoundourEggMoves:
	db DESTINY_BOND
	db FIRE_SPIN
	db PURSUIT
	db RAGE
	db REVERSAL
	db COUNTER
	db WILL_O_WISP
	db $ff

PhanpyEggMoves:
	db FOCUS_ENERGY
	db PLAY_ROUGH
	db WATER_GUN
	db BODY_SLAM
	db ANCIENTPOWER
	db GUNK_SHOT
	db ICE_SHARD
	db $ff

TyrogueEggMoves:
	db BULLET_PUNCH
	db HI_JUMP_KICK
	db MACH_PUNCH
	db PURSUIT
	db RAPID_SPIN
	db LOCK_ON
	db $ff

ElekidEggMoves:
	db BARRIER
	db CROSS_CHOP
	db KARATE_CHOP
	db BULK_UP
	db $ff

MagbyEggMoves:
	db BARRIER
	db BELLY_DRUM
	db CROSS_CHOP
	db FLARE_BLITZ
	db FOCUS_ENERGY
	db KARATE_CHOP
	db MACH_PUNCH
	db SCREECH
	db $ff

MiltankEggMoves:
	db DIZZY_PUNCH
	db REVERSAL
	db SEISMIC_TOSS
	db $ff

LarvitarEggMoves:
	db DRAGON_DANCE
	db FOCUS_ENERGY
	db PURSUIT
	db STOMP
	db OUTRAGE
	db ANCIENTPOWER
	db IRON_HEAD
	db $ff

NoEggMoves:
	db $ff
