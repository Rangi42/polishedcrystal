SECTION "Egg Moves", ROMX

INCLUDE "data/pokemon/egg_move_pointers.asm"

EggSpeciesMoves::

BulbasaurEggSpeciesMoves:
	dp BULBASAUR, PLAIN_FORM
	dw CHARM
	dw PETAL_DANCE
	dw LIGHT_SCREEN
	dw SAFEGUARD
	dw POWER_WHIP
	dw $ff

CharmanderEggSpeciesMoves:
	dp CHARMANDER, PLAIN_FORM
	dw ANCIENTPOWER
	dw BELLY_DRUM
	dw BITE
	dw CRUNCH
	dw DRAGON_DANCE
	dw DRAGONBREATH
	dw FLARE_BLITZ
	dw OUTRAGE
	dw $ff

SquirtleEggSpeciesMoves:
	dp SQUIRTLE, PLAIN_FORM
	dw CONFUSION
	dw CRUNCH
	dw FORESIGHT
	dw HAZE
	dw MIRROR_COAT
	dw AQUA_JET
	dw $ff

CaterpieEggSpeciesMoves:
	dp CATERPIE, PLAIN_FORM
	dw $ff

WeedleEggSpeciesMoves:
	dp WEEDLE, PLAIN_FORM
	dw $ff

PidgeyEggSpeciesMoves:
	dp PIDGEY, PLAIN_FORM
	dw PECK
	dw FEINT_ATTACK
	dw FORESIGHT
	dw PURSUIT
	dw AIR_SLASH
	dw STEEL_WING
	dw CHARM
	dw EXTREMESPEED
	dw BRAVE_BIRD
	dw $ff

RattataPlainEggSpeciesMoves:
	dp RATTATA, PLAIN_FORM
	dw FURY_STRIKES
	dw REVERSAL
	dw SCREECH
	dw BITE
	dw COUNTER
	dw $ff

RattataAlolanEggSpeciesMoves:
	dp RATTATA, ALOLAN_FORM
	dw FURY_STRIKES
	dw REVERSAL
	dw SCREECH
	dw BITE
	dw COUNTER
	dw $ff

SpearowEggSpeciesMoves:
	dp SPEAROW, PLAIN_FORM
	dw ASTONISH
	dw FEINT_ATTACK
	dw QUICK_ATTACK
	dw SCARY_FACE
	dw TRI_ATTACK
	dw $ff

EkansEggSpeciesMoves:
	dp EKANS, NO_FORM
	dw CRUNCH
	dw DISABLE
	dw PURSUIT
	dw SCARY_FACE
	dw $ff

SandshrewPlainEggSpeciesMoves:
	dp SANDSHREW, PLAIN_FORM
	dw METAL_CLAW
	dw RAPID_SPIN
	dw SAFEGUARD
	dw COUNTER
	dw NIGHT_SLASH
	dw $ff

SandshrewAlolanEggSpeciesMoves:
	dp SANDSHREW, ALOLAN_FORM
	dw AMNESIA
	dw RAPID_SPIN
	dw SAFEGUARD
	dw REVERSAL ; Flail → similar move
	dw ICICLE_CRASH
	dw ICICLE_SPEAR
	dw NIGHT_SLASH
	dw $ff

NidoranFEggSpeciesMoves:
	dp NIDORAN_F, PLAIN_FORM
	dw CHARM
	dw DISABLE
	dw FOCUS_ENERGY
	dw PURSUIT
	dw SUPERSONIC
	dw TAKE_DOWN
	dw $ff

NidoranMEggSpeciesMoves:
	dp NIDORAN_M, PLAIN_FORM
	dw AMNESIA
	dw CONFUSION
	dw DISABLE
	dw SUPERSONIC
	dw TAKE_DOWN
	dw CALM_MIND
	dw COUNTER
	dw $ff

VulpixPlainEggSpeciesMoves:
	dp VULPIX, PLAIN_FORM
	dw FLAME_CHARGE
	dw DISABLE
	dw FLARE_BLITZ
	dw HYPNOSIS
	dw FEINT_ATTACK
	dw EXTRASENSORY
	dw CHARM
	dw ENERGY_BALL
	dw ROAR
	dw $ff

VulpixAlolanEggSpeciesMoves:
	dp VULPIX, ALOLAN_FORM
	dw DISABLE
	dw BLIZZARD
	dw HYPNOSIS
	dw FEINT_ATTACK
	dw EXTRASENSORY
	dw CHARM
	dw ICE_BEAM
	dw ROAR
	dw $ff

ZubatEggSpeciesMoves:
	dp ZUBAT, PLAIN_FORM
	dw FEINT_ATTACK
	dw GUST
	dw HYPNOSIS
	dw NASTY_PLOT
	dw PURSUIT
	dw QUICK_ATTACK
	dw ZEN_HEADBUTT
	dw BRAVE_BIRD
	dw $ff

OddishEggSpeciesMoves:
	dp ODDISH, PLAIN_FORM
	dw CHARM
	dw RAZOR_LEAF
	dw HEALINGLIGHT
	dw SWORDS_DANCE
	dw $ff

ParasEggSpeciesMoves:
	dp PARAS, PLAIN_FORM
	dw AGILITY
	dw LEECH_SEED
	dw METAL_CLAW
	dw PSYBEAM
	dw PURSUIT
	dw SCREECH
	dw SHADOW_CLAW
	dw $ff

VenonatEggSpeciesMoves:
	dp VENONAT, PLAIN_FORM
	dw AGILITY
	dw BATON_PASS
	dw HEALINGLIGHT
	dw SCREECH
	dw TOXIC_SPIKES
	dw $ff

DiglettPlainEggSpeciesMoves:
	dp DIGLETT, PLAIN_FORM
	dw ANCIENTPOWER
	dw FEINT_ATTACK
	dw HEADBUTT
	dw PURSUIT
	dw REVERSAL
	dw SCREECH
	dw $ff

DiglettAlolanEggSpeciesMoves:
	dp DIGLETT, ALOLAN_FORM
	dw ANCIENTPOWER
	dw FEINT_ATTACK
	dw HEADBUTT
	dw PURSUIT
	dw REVERSAL
	dw SCREECH
	dw $ff

MeowthPlainEggSpeciesMoves:
	dp MEOWTH, PLAIN_FORM
	dw CHARM
	dw HYPNOSIS
	dw AMNESIA
	dw LEER
	dw NIGHT_SLASH
	dw $ff

MeowthAlolanEggSpeciesMoves:
	dp MEOWTH, ALOLAN_FORM
	dw CHARM
	dw HYPNOSIS
	dw AMNESIA
	dw LEER
	dw NIGHT_SLASH
	dw $ff

MeowthGalarianEggSpeciesMoves:
	dp MEOWTH, GALARIAN_FORM
	dw CHARM
	dw HYPNOSIS
	dw AMNESIA
	dw LEER
	dw NIGHT_SLASH
	dw $ff

PsyduckEggSpeciesMoves:
	dp PSYDUCK, PLAIN_FORM
	dw CONFUSE_RAY
	dw CROSS_CHOP
	dw ENCORE
	dw FORESIGHT
	dw FUTURE_SIGHT
	dw HYPNOSIS
	dw PSYBEAM
	dw ICE_BEAM
	dw LIGHT_SCREEN
	dw PSYCHIC_M
	dw $ff

MankeyEggSpeciesMoves:
	dp MANKEY, PLAIN_FORM
	dw ENCORE
	dw FORESIGHT
	dw BULK_UP
	dw REVERSAL
	dw ROCK_SLIDE
	dw COUNTER
	dw GUNK_SHOT
	dw NIGHT_SLASH
	dw CLOSE_COMBAT
	dw $ff

GrowlithePlainEggSpeciesMoves:
	dp GROWLITHE, PLAIN_FORM
	dw DOUBLE_KICK
	dw FIRE_SPIN
	dw HEALINGLIGHT
	dw THRASH
	dw CRUNCH
	dw FLARE_BLITZ
	dw BODY_SLAM
	dw SAFEGUARD
	dw CLOSE_COMBAT
	dw $ff

GrowlitheHisuianEggSpeciesMoves:
	dp GROWLITHE, HISUIAN_FORM
	dw DOUBLE_KICK
	dw FIRE_SPIN
	dw HEALINGLIGHT
	dw THRASH
	dw CRUNCH
	dw FLARE_BLITZ
	dw BODY_SLAM
	dw SAFEGUARD
	dw CLOSE_COMBAT
	dw $ff

PoliwagEggSpeciesMoves:
	dp POLIWAG, PLAIN_FORM
	dw ENCORE
	dw HAZE
	dw SPLASH
	dw BUBBLE_BEAM
	dw WATER_PULSE
	dw $ff

AbraEggSpeciesMoves:
	dp ABRA, PLAIN_FORM
	dw BARRIER
	dw ENCORE
	dw LIGHT_SCREEN
	dw KNOCK_OFF
	dw $ff

MachopEggSpeciesMoves:
	dp MACHOP, PLAIN_FORM
	dw BULLET_PUNCH
	dw ENCORE
	dw BULK_UP
	dw LIGHT_SCREEN
	dw MACH_PUNCH
	dw CLOSE_COMBAT
	dw KNOCK_OFF
	dw $ff

BellsproutEggSpeciesMoves:
	dp BELLSPROUT, PLAIN_FORM
	dw ENCORE
	dw LEECH_LIFE
	dw SWORDS_DANCE
	dw REFLECT
	dw HEALINGLIGHT
	dw POWER_WHIP
	dw $ff

TentacoolEggSpeciesMoves:
	dp TENTACOOL, PLAIN_FORM
	dw AURORA_BEAM
	dw CONFUSE_RAY
	dw HAZE
	dw MIRROR_COAT
	dw RAPID_SPIN
	dw SAFEGUARD
	dw KNOCK_OFF
	dw $ff

GeodudePlainEggSpeciesMoves:
	dp GEODUDE, PLAIN_FORM
	dw ROCK_SLIDE
	dw $ff

GeodudeAlolanEggSpeciesMoves:
	dp GEODUDE, ALOLAN_FORM
	dw ROCK_SLIDE
	dw $ff

PonytaPlainEggSpeciesMoves:
	dp PONYTA, PLAIN_FORM
	dw CHARM
	dw DOUBLE_KICK
	dw HYPNOSIS
	dw HEALINGLIGHT
	dw THRASH
	dw QUICK_ATTACK
	dw EXTREMESPEED
	dw PLAY_ROUGH
	dw $ff

PonytaGalarianEggSpeciesMoves:
	dp PONYTA, GALARIAN_FORM
	dw CHARM
	dw DOUBLE_KICK
	dw HYPNOSIS
	dw HEALINGLIGHT
	dw THRASH
	dw QUICK_ATTACK
	dw PSYBEAM
	dw PSYCHIC_M
	dw EXTREMESPEED
	dw PLAY_ROUGH
	dw $ff

SlowpokePlainEggSpeciesMoves:
	dp SLOWPOKE, PLAIN_FORM
	dp SLOWPOKE, GALARIAN_FORM
	dw BELLY_DRUM
	dw FUTURE_SIGHT
	dw STOMP
	dw SAFEGUARD
	dw ZEN_HEADBUTT
	dw $ff

SlowpokeGalarianEggSpeciesMoves:
	dp SLOWPOKE, GALARIAN_FORM
	dw BELLY_DRUM
	dw FUTURE_SIGHT
	dw STOMP
	dw SAFEGUARD
	dw ZEN_HEADBUTT
	dw $ff

MagnemiteEggSpeciesMoves:
	dp MAGNEMITE, PLAIN_FORM
	dw $ff

FarfetchDGalarianEggSpeciesMoves:
	dp FARFETCH_D, GALARIAN_FORM
	dw COUNTER
	dw FORESIGHT
	dw GUST
	dw QUICK_ATTACK
	dw STEEL_WING
	dw NIGHT_SLASH
	dw ROOST
	dw $ff

FarfetchDPlainEggSpeciesMoves:
	dp FARFETCH_D, PLAIN_FORM
	dw FORESIGHT
	dw GUST
	dw QUICK_ATTACK
	dw STEEL_WING
	dw NIGHT_SLASH
	dw ROOST
	dw $ff

DoduoEggSpeciesMoves:
	dp DODUO, PLAIN_FORM
	dw FEINT_ATTACK
	dw HAZE
	dw SUPERSONIC
	dw QUICK_ATTACK
	dw BRAVE_BIRD
	dw $ff

SeelEggSpeciesMoves:
	dp SEEL, PLAIN_FORM
	dw DISABLE
	dw LICK
	dw PECK
	dw PERISH_SONG
	dw ENCORE
	dw WATER_PULSE
	dw ICICLE_SPEAR
	dw $ff

GrimerPlainEggSpeciesMoves:
	dp GRIMER, PLAIN_FORM
	dw HAZE
	dw LICK
	dw MEAN_LOOK
	dw SCARY_FACE
	dw SHADOW_CLAW
	dw $ff

GrimerAlolanEggSpeciesMoves:
	dp GRIMER, ALOLAN_FORM
	dw HAZE
	dw LICK
	dw MEAN_LOOK
	dw SCARY_FACE
	dw PURSUIT
	dw $ff

ShellderEggSpeciesMoves:
	dp SHELLDER, PLAIN_FORM
	dw BARRIER
	dw BUBBLE_BEAM
	dw RAPID_SPIN
	dw SCREECH
	dw TAKE_DOWN
	dw WATER_PULSE
	dw ICICLE_SPEAR
	dw ROCK_BLAST
	dw $ff

GastlyEggSpeciesMoves:
	dp GASTLY, PLAIN_FORM
	dw ASTONISH
	dw DISABLE
	dw HAZE
	dw PERISH_SONG
	dw SCARY_FACE
	dw NASTY_PLOT
	dw FEINT_ATTACK
	dw $ff

OnixEggSpeciesMoves:
	dp ONIX, PLAIN_FORM
	dw DEFENSE_CURL
	dw ROCK_SLIDE
	dw EARTHQUAKE
	dw ROCK_BLAST
	dw $ff

DrowzeeEggSpeciesMoves:
	dp DROWZEE, PLAIN_FORM
	dw BARRIER
	dw LIGHT_SCREEN
	dw BELLY_DRUM
	dw $ff

KrabbyEggSpeciesMoves:
	dp KRABBY, PLAIN_FORM
	dw AGILITY
	dw HAZE
	dw AMNESIA
	dw DIG
	dw CALM_MIND
	dw KNOCK_OFF
	dw $ff

VoltorbPlainEggSpeciesMoves:
	dp VOLTORB, PLAIN_FORM
	dw $ff

VoltorbHisuianEggSpeciesMoves:
	dp VOLTORB, HISUIAN_FORM
	dw $ff

ExeggcuteEggSpeciesMoves:
	dp EXEGGCUTE, PLAIN_FORM
	dw MEGA_DRAIN
	dw HEALINGLIGHT
	dw ANCIENTPOWER
	dw REFLECT
	dw $ff

CuboneEggSpeciesMoves:
	dp CUBONE, PLAIN_FORM
	dw ANCIENTPOWER
	dw BELLY_DRUM
	dw DOUBLE_KICK
	dw PERISH_SONG
	dw SCREECH
	dw ROCK_SLIDE
	dw SWORDS_DANCE
	dw IRON_HEAD
	dw $ff

LickitungEggSpeciesMoves:
	dp LICKITUNG, PLAIN_FORM
	dw THRASH
	dw $ff

KoffingEggSpeciesMoves:
	dp KOFFING, PLAIN_FORM
	dw PSYBEAM
	dw SCREECH
	dw DESTINY_BOND
	dw PAIN_SPLIT
	dw $ff

RhyhornEggSpeciesMoves:
	dp RHYHORN, PLAIN_FORM
	dw CRUNCH
	dw MAGNITUDE
	dw PURSUIT
	dw REVERSAL
	dw THRASH
	dw ROCK_SLIDE
	dw COUNTER
	dw $ff

TangelaEggSpeciesMoves:
	dp TANGELA, PLAIN_FORM
	dw CONFUSION
	dw AMNESIA
	dw LEECH_SEED
	dw $ff

KangaskhanEggSpeciesMoves:
	dp KANGASKHAN, PLAIN_FORM
	dw DISABLE
	dw FOCUS_ENERGY
	dw FORESIGHT
	dw STOMP
	dw SAFEGUARD
	dw $ff

HorseaEggSpeciesMoves:
	dp HORSEA, PLAIN_FORM
	dw AURORA_BEAM
	dw DISABLE
	dw DRAGON_RAGE
	dw DRAGONBREATH
	dw OCTAZOOKA
	dw SPLASH
	dw HAZE
	dw WATER_PULSE
	dw $ff

GoldeenEggSpeciesMoves:
	dp GOLDEEN, PLAIN_FORM
	dw AQUA_TAIL
	dw HYDRO_PUMP
	dw PSYBEAM
	dw QUICK_ATTACK
	dw $ff

StaryuEggSpeciesMoves:
	dp STARYU, PLAIN_FORM
	dw $ff

ScytherEggSpeciesMoves:
	dp SCYTHER, PLAIN_FORM
	dw BATON_PASS
	dw BUG_BUZZ
	dw REVERSAL
	dw COUNTER
	dw SAFEGUARD
	dw LIGHT_SCREEN
	dw NIGHT_SLASH
	dw $ff

PinsirEggSpeciesMoves:
	dp PINSIR, PLAIN_FORM
	dw FEINT_ATTACK
	dw FURY_STRIKES
	dw QUICK_ATTACK
	dw CLOSE_COMBAT
	dw $ff

MagikarpEggSpeciesMoves:
	dp MAGIKARP, NO_FORM
	dw $ff

LaprasEggSpeciesMoves:
	dp LAPRAS, PLAIN_FORM
	dw AURORA_BEAM
	dw DRAGON_DANCE
	dw FORESIGHT
	dw FUTURE_SIGHT
	dw HEAL_BELL
	dw $ff

EeveeEggSpeciesMoves:
	dp EEVEE, PLAIN_FORM
	dw CHARM
	dw $ff

PorygonEggSpeciesMoves:
	dp PORYGON, PLAIN_FORM
	dw $ff

OmanyteEggSpeciesMoves:
	dp OMANYTE, PLAIN_FORM
	dw AURORA_BEAM
	dw BUBBLE_BEAM
	dw HAZE
	dw SPIKES
	dw TOXIC_SPIKES
	dw SUPERSONIC
	dw WATER_PULSE
	dw KNOCK_OFF
	dw $ff

KabutoEggSpeciesMoves:
	dp KABUTO, PLAIN_FORM
	dw AURORA_BEAM
	dw BUBBLE_BEAM
	dw CONFUSE_RAY
	dw FORESIGHT
	dw RAPID_SPIN
	dw SCREECH
	dw TAKE_DOWN
	dw DIG
	dw KNOCK_OFF
	dw $ff

AerodactylEggSpeciesMoves:
	dp AERODACTYL, PLAIN_FORM
	dw FORESIGHT
	dw PURSUIT
	dw STEEL_WING
	dw ROOST
	dw $ff

DratiniEggSpeciesMoves:
	dp DRATINI, PLAIN_FORM
	dw EXTREMESPEED ; requires Dragon Shrine Dratini
	dw HAZE
	dw SUPERSONIC
	dw WATER_PULSE
	dw AQUA_JET
	dw $ff

ChikoritaEggSpeciesMoves:
	dp CHIKORITA, PLAIN_FORM
	dw LEECH_SEED
	dw VINE_WHIP
	dw ANCIENTPOWER
	dw COUNTER
	dw SWORDS_DANCE
	dw CHARM
	dw HEAL_BELL
	dw $ff

CyndaquilEggSpeciesMoves:
	dp CYNDAQUIL, PLAIN_FORM
	dw DOUBLE_KICK
	dw EXTRASENSORY
	dw FLARE_BLITZ
	dw FORESIGHT
	dw FURY_STRIKES
	dw REVERSAL
	dw CLOSE_COMBAT
	dw THRASH
	dw QUICK_ATTACK
	dw $ff

TotodileEggSpeciesMoves:
	dp TOTODILE, PLAIN_FORM
	dw DRAGON_DANCE
	dw METAL_CLAW
	dw CRUNCH
	dw THRASH
	dw HYDRO_PUMP
	dw ANCIENTPOWER
	dw ROCK_SLIDE
	dw WATER_PULSE
	dw AQUA_JET
	dw $ff

SentretEggSpeciesMoves:
	dp SENTRET, PLAIN_FORM
	dw CHARM
	dw FOCUS_ENERGY
	dw PURSUIT
	dw REVERSAL
	dw SLASH
	dw DOUBLE_EDGE
	dw TRICK
	dw $ff

HoothootEggSpeciesMoves:
	dp HOOTHOOT, PLAIN_FORM
	dw AGILITY
	dw FEINT_ATTACK
	dw NIGHT_SHADE
	dw SUPERSONIC
	dw WING_ATTACK
	dw BRAVE_BIRD
	dw HURRICANE
	dw $ff

LedybaEggSpeciesMoves:
	dp LEDYBA, PLAIN_FORM
	dw DIZZY_PUNCH
	dw ENCORE
	dw PSYBEAM
	dw SCREECH
	dw LIGHT_SCREEN
	dw KNOCK_OFF
	dw DRAIN_PUNCH
	dw $ff

SpinarakEggSpeciesMoves:
	dp SPINARAK, PLAIN_FORM
	dw BATON_PASS
	dw DISABLE
	dw MEGAHORN
	dw PSYBEAM
	dw PURSUIT
	dw SONIC_BOOM
	dw POISON_JAB
	dw NIGHT_SLASH
	dw TOXIC_SPIKES
	dw $ff

ChinchouEggSpeciesMoves:
	dp CHINCHOU, PLAIN_FORM
	dw AGILITY
	dw HAZE
	dw PSYBEAM
	dw SCREECH
	dw SUPERSONIC
	dw WATER_PULSE
	dw $ff

PichuEggSpeciesMoves:
	dp PICHU, PLAIN_FORM
	dw DISARM_VOICE
	dw DOUBLE_SLAP
	dw ENCORE
	dw REVERSAL
	dw $ff

CleffaEggSpeciesMoves:
	dp CLEFFA, PLAIN_FORM
	dw CALM_MIND
	dw BELLY_DRUM
	dw AMNESIA
	dw SPLASH
	dw FRESH_SNACK
	dw $ff

IgglybuffEggSpeciesMoves:
	dp IGGLYBUFF, PLAIN_FORM
	dw FEINT_ATTACK
	dw PERISH_SONG
	dw MOONBLAST
	dw $ff

TogepiEggSpeciesMoves:
	dp TOGEPI, PLAIN_FORM
	dw EXTRASENSORY
	dw FORESIGHT
	dw FUTURE_SIGHT
	dw HEALINGLIGHT
	dw NASTY_PLOT
	dw PECK
	dw $ff

NatuEggSpeciesMoves:
	dp NATU, PLAIN_FORM
	dw DRILL_PECK
	dw FEINT_ATTACK
	dw HAZE
	dw QUICK_ATTACK
	dw STEEL_WING
	dw ZEN_HEADBUTT
	dw ROOST
	dw $ff

MareepEggSpeciesMoves:
	dp MAREEP, PLAIN_FORM
	dw AGILITY
	dw REFLECT
	dw MUD_SLAP
	dw SCREECH
	dw THUNDERBOLT
	dw TAKE_DOWN
	dw BODY_SLAM
	dw SAFEGUARD
	dw $ff

HoppipEggSpeciesMoves:
	dp HOPPIP, PLAIN_FORM
	dw ENCORE
	dw SEED_BOMB
	dw $ff

AipomEggSpeciesMoves:
	dp AIPOM, PLAIN_FORM
	dw COUNTER
	dw PURSUIT
	dw $ff

SunkernEggSpeciesMoves:
	dp SUNKERN, PLAIN_FORM
	dw $ff

YanmaEggSpeciesMoves:
	dp YANMA, PLAIN_FORM
	dw FEINT_ATTACK
	dw LEECH_LIFE
	dw REVERSAL
	dw $ff

WooperPlainEggSpeciesMoves:
	dp WOOPER, PLAIN_FORM
	dw COUNTER
	dw DOUBLE_KICK
	dw ENCORE
	dw RECOVER
	dw BODY_SLAM
	dw ANCIENTPOWER
	dw SAFEGUARD
	dw $ff

WooperPaldeanEggSpeciesMoves:
	dp WOOPER, PALDEAN_FORM
	dw COUNTER
	dw DOUBLE_KICK
	dw ENCORE
	dw RECOVER
	dw BODY_SLAM
	dw ANCIENTPOWER
	dw SAFEGUARD
	dw $ff

MurkrowEggSpeciesMoves:
	dp MURKROW, PLAIN_FORM
	dw CONFUSE_RAY
	dw DRILL_PECK
	dw PERISH_SONG
	dw QUICK_ATTACK
	dw SCREECH
	dw WING_ATTACK
	dw BRAVE_BIRD
	dw ROOST
	dw $ff

MisdreavusEggSpeciesMoves:
	dp MISDREAVUS, PLAIN_FORM
	dw DESTINY_BOND
	dw NASTY_PLOT
	dw SCREECH
	dw $ff

GirafarigEggSpeciesMoves:
	dp GIRAFARIG, PLAIN_FORM
	dw DOUBLE_KICK
	dw FORESIGHT
	dw FUTURE_SIGHT
	dw MEAN_LOOK
	dw MIRROR_COAT
	dw TAKE_DOWN
	dw AMNESIA
	dw CALM_MIND
	dw $ff

PinecoEggSpeciesMoves:
	dp PINECO, PLAIN_FORM
	dw PIN_MISSILE
	dw SWIFT
	dw REFLECT
	dw TOXIC_SPIKES
	dw $ff

DunsparceEggSpeciesMoves:
	dp DUNSPARCE, NO_FORM
	dw AGILITY
	dw ASTONISH
	dw BITE
	dw RAGE
	dw ANCIENTPOWER
	dw ROCK_SLIDE
	dw HEX
	dw $ff

GligarEggSpeciesMoves:
	dp GLIGAR, PLAIN_FORM
	dw AGILITY
	dw BATON_PASS
	dw METAL_CLAW
	dw WING_ATTACK
	dw COUNTER
	dw NIGHT_SLASH
	dw $ff

SnubbullEggSpeciesMoves:
	dp SNUBBULL, PLAIN_FORM
	dw FEINT_ATTACK
	dw LEER
	dw METRONOME
	dw REFLECT
	dw CRUNCH
	dw HEAL_BELL
	dw LICK
	dw CLOSE_COMBAT
	dw $ff

QwilfishEggSpeciesMoves:
	dp QWILFISH, PLAIN_FORM
	dw BUBBLE_BEAM
	dw HAZE
	dw SUPERSONIC
	dw POISON_JAB
	dw WATER_PULSE
	dw $ff

QwilfishHisuianEggSpeciesMoves:
	dp QWILFISH, HISUIAN_FORM
	dw $ff

ShuckleEggSpeciesMoves:
	dp SHUCKLE, PLAIN_FORM
	dw ROLLOUT
	dw ACID
	dw KNOCK_OFF
	dw MUD_SLAP
	dw ROCK_BLAST
	dw $ff

HeracrossEggSpeciesMoves:
	dp HERACROSS, PLAIN_FORM
	dw ROCK_BLAST
	dw DEFENSE_CURL
	dw PURSUIT
	dw $ff

SneaselEggSpeciesMoves:
	dp SNEASEL, PLAIN_FORM
	dw BITE
	dw FORESIGHT
	dw PURSUIT
	dw COUNTER
	dw REFLECT
	dw ICICLE_CRASH
	dw ICE_SHARD
	dw $ff

SneaselHisuianEggSpeciesMoves:
	dp SNEASEL, HISUIAN_FORM
	dw $ff

TeddiursaEggSpeciesMoves:
	dp TEDDIURSA, PLAIN_FORM
	dw BELLY_DRUM
	dw CROSS_CHOP
	dw CRUNCH
	dw FOCUS_ENERGY
	dw METAL_CLAW
	dw PLAY_ROUGH
	dw TAKE_DOWN
	dw SEISMIC_TOSS
	dw COUNTER
	dw GUNK_SHOT
	dw NIGHT_SLASH
	dw CLOSE_COMBAT
	dw $ff

SlugmaEggSpeciesMoves:
	dp SLUGMA, PLAIN_FORM
	dw SMOKESCREEN
	dw CURSE
	dw $ff

SwinubEggSpeciesMoves:
	dp SWINUB, PLAIN_FORM
	dw AVALANCHE
	dw BITE
	dw TAKE_DOWN
	dw BODY_SLAM
	dw ROCK_SLIDE
	dw ANCIENTPOWER
	dw ICICLE_CRASH
	dw ICICLE_SPEAR
	dw $ff

CorsolaPlainEggSpeciesMoves:
	dp CORSOLA, PLAIN_FORM
	dw BARRIER
	dw CONFUSE_RAY
	dw HAZE
	dw AMNESIA
	dw SCREECH
	dw ROCK_SLIDE
	dw SAFEGUARD
	dw CALM_MIND
	dw WATER_PULSE
	dw ICICLE_SPEAR
	dw $ff

CorsolaGalarianEggSpeciesMoves:
	dp CORSOLA, GALARIAN_FORM
	dw BARRIER
	dw CONFUSE_RAY
	dw HAZE
	dw AMNESIA
	dw SCREECH
	dw ROCK_SLIDE
	dw SAFEGUARD
	dw CALM_MIND
	dw WATER_PULSE
	dw ICICLE_SPEAR
	dw $ff

RemoraidEggSpeciesMoves:
	dp REMORAID, PLAIN_FORM
	dw SPLASH
	dw HAZE
	dw OCTAZOOKA
	dw ROCK_BLAST
	dw SCREECH
	dw SUPERSONIC
	dw AURORA_BEAM
	dw GUNK_SHOT
	dw WATER_PULSE
	dw $ff

DelibirdEggSpeciesMoves:
	dp DELIBIRD, PLAIN_FORM
	dw AURORA_BEAM
	dw DESTINY_BOND
	dw ICE_PUNCH
	dw ICY_WIND
	dw QUICK_ATTACK
	dw RAPID_SPIN
	dw SPLASH
	dw $ff

SkarmoryEggSpeciesMoves:
	dp SKARMORY, PLAIN_FORM
	dw DRILL_PECK
	dw PURSUIT
	dw BRAVE_BIRD
	dw $ff

HoundourEggSpeciesMoves:
	dp HOUNDOUR, PLAIN_FORM
	dw DESTINY_BOND
	dw FIRE_SPIN
	dw PURSUIT
	dw RAGE
	dw REVERSAL
	dw COUNTER
	dw WILL_O_WISP
	dw $ff

PhanpyEggSpeciesMoves:
	dp PHANPY, PLAIN_FORM
	dw FOCUS_ENERGY
	dw PLAY_ROUGH
	dw WATER_GUN
	dw BODY_SLAM
	dw ANCIENTPOWER
	dw GUNK_SHOT
	dw ICE_SHARD
	dw ENCORE
	dw $ff

StantlerEggSpeciesMoves:
	dp STANTLER, PLAIN_FORM
	dw BITE
	dw DOUBLE_KICK
	dw EXTRASENSORY
	dw RAGE
	dw $ff

TyrogueEggSpeciesMoves:
	dp TYROGUE, PLAIN_FORM
	dw BULLET_PUNCH
	dw HI_JUMP_KICK
	dw MACH_PUNCH
	dw PURSUIT
	dw RAPID_SPIN
	dw $ff

SmoochumEggSpeciesMoves:
	dp SMOOCHUM, PLAIN_FORM
	dw BULK_UP
	dw NASTY_PLOT
	dw $ff

ElekidEggSpeciesMoves:
	dp ELEKID, PLAIN_FORM
	dw BARRIER
	dw CROSS_CHOP
	dw KARATE_CHOP
	dw BULK_UP
	dw $ff

MagbyEggSpeciesMoves:
	dp MAGBY, PLAIN_FORM
	dw BARRIER
	dw BELLY_DRUM
	dw CROSS_CHOP
	dw FLARE_BLITZ
	dw FOCUS_ENERGY
	dw KARATE_CHOP
	dw MACH_PUNCH
	dw SCREECH
	dw $ff

MiltankEggSpeciesMoves:
	dp MILTANK, PLAIN_FORM
	dw DIZZY_PUNCH
	dw REVERSAL
	dw SEISMIC_TOSS
	dw $ff

LarvitarEggSpeciesMoves:
	dp LARVITAR, PLAIN_FORM
	dw DRAGON_DANCE
	dw FOCUS_ENERGY
	dw PURSUIT
	dw STOMP
	dw OUTRAGE
	dw ANCIENTPOWER
	dw IRON_HEAD
	dw $ff

AzurillEggSpeciesMoves:
	dp AZURILL, PLAIN_FORM
	dw BELLY_DRUM
	dw FORESIGHT
	dw FUTURE_SIGHT
	dw PERISH_SONG
	dw SUPERSONIC
	dw LIGHT_SCREEN
	dw AMNESIA
	dw CALM_MIND
	dw $ff

WynautEggSpeciesMoves:
	dp WYNAUT, PLAIN_FORM
	dw CHARM
	dw ENCORE
	dw $ff

BonslyEggSpeciesMoves:
	dp BONSLY, PLAIN_FORM
	dw DEFENSE_CURL
	dw EXPLOSION
	dw $ff

MimeJrEggSpeciesMoves:
	dp MIME_JR_, PLAIN_FORM
	dw CONFUSE_RAY
	dw FUTURE_SIGHT
	dw HYPNOSIS
	dw NASTY_PLOT
	dw TRICK
	dw $ff

HappinyEggSpeciesMoves:
	dp HAPPINY, PLAIN_FORM
	dw HEAL_BELL
	dw $ff

MantykeEggSpeciesMoves:
	dp MANTYKE, PLAIN_FORM
	dw HAZE
	dw MIRROR_COAT
	dw SPLASH
	dw HYDRO_PUMP
	dw GUNK_SHOT
	dw $ff

MunchlaxEggSpeciesMoves:
	dp MUNCHLAX, PLAIN_FORM
	dw CHARM
	dw COUNTER
	dw CURSE
	dw DOUBLE_EDGE
	dw LICK
	dw GUNK_SHOT
	dw $ff

NoEggSpeciesMoves:
	dw $ff
