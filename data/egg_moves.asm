INCLUDE "includes.asm"


SECTION "Egg Moves", ROMX, BANK[EGG_MOVES]

; All instances of Charm, Steel Wing, Sweet Scent, and Lovely Kiss were
; removed from egg move lists in Crystal, because they are also TMs.

; Staryu's egg moves were removed in Crystal, because Staryu is genderless
; and can only breed with Ditto.


INCLUDE "data/egg_move_pointers.asm"


EggMoves::

BulbasaurEggMoves:
	db LIGHT_SCREEN
	db SAFEGUARD
if !_CRYSTAL
	db CHARM
endc
	db PETAL_DANCE
	db $ff

CharmanderEggMoves:
	db BELLY_DRUM
	db ANCIENTPOWER
	db ROCK_SLIDE
	db BITE
	db OUTRAGE
	db $ff

SquirtleEggMoves:
	db MIRROR_COAT
	db HAZE
	db MIST
	db CONFUSION
	db FORESIGHT
	db FLAIL
	db $ff

PidgeyEggMoves:
	db PURSUIT
	db FAINT_ATTACK
	db FORESIGHT
if !_CRYSTAL
	db STEEL_WING
endc
	db AIR_SLASH
	db $ff

RattataEggMoves:
	db SCREECH
	db FLAME_WHEEL
	db FURY_SWIPES
	db BITE
	db COUNTER
	db REVERSAL
	db $ff

EkansEggMoves:
	db PURSUIT
	db SLAM
if _CRYSTAL
	db CRUNCH
endc
	db $ff

SandshrewEggMoves:
	db FLAIL
	db SAFEGUARD
	db COUNTER
	db RAPID_SPIN
if _CRYSTAL
	db METAL_CLAW
endc
	db $ff

NidoranFEggMoves:
	db SUPERSONIC
	db DISABLE
	db TAKE_DOWN
	db FOCUS_ENERGY
	db CHARM
	db COUNTER
	db $ff

NidoranMEggMoves:
	db SUPERSONIC
	db DISABLE
	db TAKE_DOWN
	db CONFUSION
	db CALM_MIND
	db COUNTER
	db $ff

VulpixEggMoves:
	db FAINT_ATTACK
	db HYPNOSIS
	db FLAIL
	db DISABLE
	db EXTRASENSORY
	db $ff

ZubatEggMoves:
	db QUICK_ATTACK
	db PURSUIT
	db FAINT_ATTACK
	db GUST
	db WHIRLWIND
	db ZEN_HEADBUTT
	db $ff

OddishEggMoves:
	db SWORDS_DANCE
	db RAZOR_LEAF
	db FLAIL
	db SYNTHESIS
if !_CRYSTAL
	db CHARM
endc
	db $ff

ParasEggMoves:
	db FALSE_SWIPE
	db SCREECH
	db COUNTER
	db PSYBEAM
	db FLAIL
if !_CRYSTAL
	db SWEET_SCENT
endc
	db LIGHT_SCREEN
	db PURSUIT
	db $ff

VenonatEggMoves:
	db BATON_PASS
	db SCREECH
	db GIGA_DRAIN
	db $ff

DiglettEggMoves:
	db FAINT_ATTACK
	db SCREECH
	db ANCIENTPOWER
	db PURSUIT
	db $ff

MeowthEggMoves:
	db CHARM
	db HYPNOSIS
	db CALM_MIND
	db $ff

PsyduckEggMoves:
	db ICE_BEAM
	db HYPNOSIS
	db PSYBEAM
	db FORESIGHT
	db LIGHT_SCREEN
	db FUTURE_SIGHT
	db PSYCHIC_M
if _CRYSTAL
	db CROSS_CHOP
endc
	db $ff

MankeyEggMoves:
	db ROCK_SLIDE
	db FORESIGHT
	db MEDITATE
	db COUNTER
	db REVERSAL
	db $ff

GrowlitheEggMoves:
	db BODY_SLAM
	db SAFEGUARD
	db CRUNCH
	db THRASH
	db FIRE_SPIN
	db $ff

PoliwagEggMoves:
	db MIST
	db SPLASH
	db BUBBLEBEAM
	db HAZE
	db LOCK_ON
	db $ff

AbraEggMoves:
	db LIGHT_SCREEN
	db ENCORE
	db BARRIER
	db $ff

MachopEggMoves:
	db LIGHT_SCREEN
	db MEDITATE
	db ENCORE
	db BULLET_PUNCH
	db $ff

BellsproutEggMoves:
	db SWORDS_DANCE
	db ENCORE
	db REFLECT
	db SYNTHESIS
	db LEECH_LIFE
	db $ff

TentacoolEggMoves:
	db AURORA_BEAM
	db MIRROR_COAT
	db RAPID_SPIN
	db HAZE
	db SAFEGUARD
	db $ff

GeodudeEggMoves:
	db ROCK_SLIDE
	db $ff

PonytaEggMoves:
	db FLAME_WHEEL
	db THRASH
	db DOUBLE_KICK
	db HYPNOSIS
	db CHARM
	db QUICK_ATTACK
	db $ff

SlowpokeEggMoves:
	db SAFEGUARD
	db BELLY_DRUM
	db FUTURE_SIGHT
	db STOMP
	db ZEN_HEADBUTT
	db $ff

FarfetchDEggMoves:
if !_CRYSTAL
	db STEEL_WING
endc
	db FORESIGHT
	db MIRROR_MOVE
	db GUST
	db QUICK_ATTACK
	db FLAIL
	db $ff

DoduoEggMoves:
	db QUICK_ATTACK
	db SUPERSONIC
	db HAZE
	db FAINT_ATTACK
	db FLAIL
	db $ff

SeelEggMoves:
	db LICK
	db PERISH_SONG
	db DISABLE
	db PECK
	db SLAM
	db ENCORE
	db $ff

GrimerEggMoves:
	db HAZE
	db MEAN_LOOK
	db LICK
	db $ff

ShellderEggMoves:
	db BUBBLEBEAM
	db TAKE_DOWN
	db BARRIER
	db RAPID_SPIN
	db SCREECH
	db $ff

GastlyEggMoves:
	db PERISH_SONG
	db HAZE
	db $ff

OnixEggMoves:
	db ROCK_SLIDE
	db FLAIL
	db $ff

DrowzeeEggMoves:
	db LIGHT_SCREEN
	db BARRIER
	db $ff

KrabbyEggMoves:
	db DIG
	db HAZE
	db CALM_MIND
	db FLAIL
	db SLAM
	db $ff

ExeggcuteEggMoves:
	db SYNTHESIS
	db MOONLIGHT
	db REFLECT
	db MEGA_DRAIN
	db ANCIENTPOWER
	db $ff

CuboneEggMoves:
	db ROCK_SLIDE
	db ANCIENTPOWER
	db BELLY_DRUM
	db SCREECH
	db IRON_HEAD
	db PERISH_SONG
if _CRYSTAL
	db SWORDS_DANCE
endc
	db $ff

KoffingEggMoves:
	db SCREECH
	db PSYBEAM
	db DESTINY_BOND
	db PAIN_SPLIT
	db $ff

RhyhornEggMoves:
	db CRUNCH
	db REVERSAL
	db ROCK_SLIDE
	db THRASH
	db PURSUIT
	db COUNTER
	db MAGNITUDE
	db $ff

ChanseyEggMoves:
	db METRONOME
	db HEAL_BELL
	db $ff

TangelaEggMoves:
	db FLAIL
	db CONFUSION
	db MEGA_DRAIN
	db REFLECT
	db CALM_MIND
	db $ff

KangaskhanEggMoves:
	db STOMP
	db FORESIGHT
	db FOCUS_ENERGY
	db SAFEGUARD
	db DISABLE
	db $ff

HorseaEggMoves:
	db FLAIL
	db AURORA_BEAM
	db OCTAZOOKA
	db DISABLE
	db SPLASH
	db DRAGON_RAGE
	db $ff

if !_CRYSTAL
StaryuEggMoves:
	db AURORA_BEAM
	db BARRIER
	db SUPERSONIC
	db $ff
endc

MrMimeEggMoves:
	db FUTURE_SIGHT
	db HYPNOSIS
	db $ff

ScytherEggMoves:
	db COUNTER
	db SAFEGUARD
	db BATON_PASS
	db REVERSAL
	db LIGHT_SCREEN
	db $ff

PinsirEggMoves:
	db FURY_ATTACK
	db FLAIL
	db $ff

LaprasEggMoves:
	db AURORA_BEAM
	db FORESIGHT
	db $ff

EeveeEggMoves:
	db FLAIL
	db CHARM
	db $ff

OmanyteEggMoves:
	db BUBBLEBEAM
	db AURORA_BEAM
	db SLAM
	db SUPERSONIC
	db HAZE
	db $ff

KabutoEggMoves:
	db BUBBLEBEAM
	db AURORA_BEAM
	db RAPID_SPIN
	db DIG
	db FLAIL
	db $ff

AerodactylEggMoves:
	db WHIRLWIND
	db PURSUIT
	db FORESIGHT
if !_CRYSTAL
	db STEEL_WING
endc
	db $ff

DratiniEggMoves:
	db LIGHT_SCREEN
	db MIST
	db HAZE
	db SUPERSONIC
	db $ff

ChikoritaEggMoves:
	db VINE_WHIP
	db LEECH_SEED
	db COUNTER
	db ANCIENTPOWER
	db FLAIL
	db SWORDS_DANCE
	db $ff

CyndaquilEggMoves:
	db FURY_SWIPES
	db QUICK_ATTACK
	db REVERSAL
	db THRASH
	db FORESIGHT
if _CRYSTAL
	db SUBMISSION
endc
	db EXTRASENSORY
	db $ff

TotodileEggMoves:
	db CRUNCH
	db THRASH
	db HYDRO_PUMP
	db ANCIENTPOWER
	db ROCK_SLIDE
	db $ff

SentretEggMoves:
	db DOUBLE_EDGE
	db PURSUIT
	db SLASH
	db FOCUS_ENERGY
	db REVERSAL
	db $ff

HoothootEggMoves:
	db MIRROR_MOVE
	db SUPERSONIC
	db FAINT_ATTACK
	db WING_ATTACK
	db WHIRLWIND
if _CRYSTAL
	db SKY_ATTACK
endc
	db $ff

LedybaEggMoves:
	db PSYBEAM
	db LIGHT_SCREEN
	db $ff

SpinarakEggMoves:
	db PSYBEAM
	db DISABLE
	db SONICBOOM
	db BATON_PASS
	db PURSUIT
	db POISON_JAB
	db $ff

ChinchouEggMoves:
	db FLAIL
	db SUPERSONIC
	db SCREECH
	db $ff

PichuEggMoves:
	db REVERSAL
	db ENCORE
	db DOUBLESLAP
	db DISARM_VOICE
	db $ff

MunchlaxEggMoves:
	db LICK
	db $ff

TogepiEggMoves:
	db MIRROR_MOVE
	db PECK
	db FORESIGHT
	db FUTURE_SIGHT
	db EXTRASENSORY
	db $ff

NatuEggMoves:
	db HAZE
	db DRILL_PECK
	db QUICK_ATTACK
	db FAINT_ATTACK
	db STEEL_WING
	db ZEN_HEADBUTT
	db $ff

MareepEggMoves:
	db THUNDERBOLT
	db TAKE_DOWN
	db BODY_SLAM
	db SAFEGUARD
	db SCREECH
	db REFLECT
	db $ff

MarillEggMoves:
	db LIGHT_SCREEN
	db CALM_MIND
	db FUTURE_SIGHT
	db BELLY_DRUM
	db PERISH_SONG
	db SUPERSONIC
	db FORESIGHT
	db $ff

SudowoodoEggMoves:
	db SELFDESTRUCT
	db $ff

HoppipEggMoves:
	db CONFUSION
	db GROWL
	db ENCORE
	db DOUBLE_EDGE
	db REFLECT
	db CALM_MIND
	db PAY_DAY
	db SEED_BOMB
	db $ff

AipomEggMoves:
	db COUNTER
	db SCREECH
	db PURSUIT
	db AGILITY
	db SLAM
	db DOUBLESLAP
	db $ff

YanmaEggMoves:
	db WHIRLWIND
	db REVERSAL
	db LEECH_LIFE
	db $ff

WooperEggMoves:
	db BODY_SLAM
	db ANCIENTPOWER
	db SAFEGUARD
	db $ff

MurkrowEggMoves:
	db WHIRLWIND
	db DRILL_PECK
	db QUICK_ATTACK
	db MIRROR_MOVE
	db WING_ATTACK
if _CRYSTAL
	db SKY_ATTACK
endc
	db $ff

MisdreavusEggMoves:
	db SCREECH
	db DESTINY_BOND
	db $ff

GirafarigEggMoves:
	db TAKE_DOWN
	db CALM_MIND
	db FORESIGHT
	db FUTURE_SIGHT
	db $ff

PinecoEggMoves:
	db REFLECT
	db PIN_MISSILE
	db FLAIL
	db SWIFT
	db $ff

DunsparceEggMoves:
	db ANCIENTPOWER
	db ROCK_SLIDE
	db BITE
	db RAGE
	db $ff

GligarEggMoves:
	db METAL_CLAW
	db WING_ATTACK
	db COUNTER
	db $ff

SnubbullEggMoves:
	db METRONOME
	db FAINT_ATTACK
	db REFLECT
	db CRUNCH
	db HEAL_BELL
	db LICK
	db LEER
	db $ff

QwilfishEggMoves:
	db FLAIL
	db HAZE
	db BUBBLEBEAM
	db SUPERSONIC
	db POISON_JAB
	db $ff

HeracrossEggMoves:
	db HARDEN
	db FLAIL
	db $ff

SneaselEggMoves:
	db COUNTER
	db FORESIGHT
	db REFLECT
	db BITE
	db $ff

TeddiursaEggMoves:
	db CRUNCH
	db TAKE_DOWN
	db SEISMIC_TOSS
	db FOCUS_ENERGY
	db COUNTER
if _CRYSTAL
	db METAL_CLAW
endc
	db PLAY_ROUGH
	db $ff

SlugmaEggMoves:
	db CURSE
	db SMOKESCREEN
	db $ff

SwinubEggMoves:
	db TAKE_DOWN
	db BITE
	db BODY_SLAM
	db ROCK_SLIDE
	db ANCIENTPOWER
	db $ff

CorsolaEggMoves:
	db ROCK_SLIDE
	db SAFEGUARD
	db SCREECH
	db MIST
	db CALM_MIND
	db $ff

RemoraidEggMoves:
	db AURORA_BEAM
	db OCTAZOOKA
	db SUPERSONIC
	db HAZE
	db SCREECH
	db $ff

MantineEggMoves:
	db TWISTER
	db HYDRO_PUMP
	db HAZE
	db SLAM
	db $ff

SkarmoryEggMoves:
	db DRILL_PECK
	db PURSUIT
	db WHIRLWIND
if _CRYSTAL
	db SKY_ATTACK
endc
	db $ff

HoundourEggMoves:
	db FIRE_SPIN
	db RAGE
	db PURSUIT
	db COUNTER
	db REVERSAL
	db WILL_O_WISP
	db $ff

PhanpyEggMoves:
	db FOCUS_ENERGY
	db BODY_SLAM
	db ANCIENTPOWER
if _CRYSTAL
	db WATER_GUN
endc
	db PLAY_ROUGH
	db $ff

StantlerEggMoves:
	db REFLECT
	db DISABLE
	db LIGHT_SCREEN
	db BITE
	db ZEN_HEADBUTT
	db EXTRASENSORY
	db $ff

TyrogueEggMoves:
	db RAPID_SPIN
	db HI_JUMP_KICK
	db MACH_PUNCH
	db LOCK_ON
	db BULLET_PUNCH
	db $ff

SmoochumEggMoves:
	db MEDITATE
	db $ff

ElekidEggMoves:
	db KARATE_CHOP
	db BARRIER
	db MEDITATE
if _CRYSTAL
	db CROSS_CHOP
endc
	db $ff

MagbyEggMoves:
	db KARATE_CHOP
	db BARRIER
	db SCREECH
if _CRYSTAL
	db CROSS_CHOP
endc
	db $ff

MiltankEggMoves:
	db REVERSAL
	db SEISMIC_TOSS
	db $ff

LarvitarEggMoves:
	db PURSUIT
	db STOMP
	db OUTRAGE
	db FOCUS_ENERGY
	db ANCIENTPOWER
	db IRON_HEAD
	db $ff

NoEggMoves:
	db $ff
