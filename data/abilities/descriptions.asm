AbilityDescriptions:
	table_width 2, AbilityDescriptions
	dw NoAbilityDescription
	dw StenchDescription
	dw DrizzleDescription
	dw SpeedBoostDescription
	dw BattleArmorDescription
	dw SturdyDescription
	dw DampDescription
	dw LimberDescription
	dw SandVeilDescription
	dw StaticDescription
	dw VoltAbsorbDescription
	dw WaterAbsorbDescription
	dw ObliviousDescription
	dw CloudNineDescription
	dw CompoundEyesDescription
	dw InsomniaDescription
	dw ImmunityDescription
	dw FlashFireDescription
	dw ShieldDustDescription
	dw OwnTempoDescription
	dw SuctionCupsDescription
	dw IntimidateDescription
	dw ShadowTagDescription
	dw LevitateDescription
	dw EffectSporeDescription
	dw SynchronizeDescription
	dw ClearBodyDescription
	dw NaturalCureDescription
	dw LightningRodDescription
	dw SereneGraceDescription
	dw SwiftSwimDescription
	dw ChlorophyllDescription
	dw IlluminateDescription
	dw TraceDescription
	dw HugePowerDescription
	dw PoisonPointDescription
	dw InnerFocusDescription
	dw MagmaArmorDescription
	dw WaterVeilDescription
	dw MagnetPullDescription
	dw SoundproofDescription
	dw RainDishDescription
	dw SandStreamDescription
	dw PressureDescription
	dw ThickFatDescription
	dw EarlyBirdDescription
	dw FlameBodyDescription
	dw RunAwayDescription
	dw KeenEyeDescription
	dw HyperCutterDescription
	dw PickupDescription
	dw HustleDescription
	dw CuteCharmDescription
	dw StickyHoldDescription
	dw ShedSkinDescription
	dw GutsDescription
	dw MarvelScaleDescription
	dw LiquidOozeDescription
	dw OvergrowDescription
	dw BlazeDescription
	dw TorrentDescription
	dw SwarmDescription
	dw RockHeadDescription
	dw DroughtDescription
	dw ArenaTrapDescription
	dw VitalSpiritDescription
	dw WhiteSmokeDescription
	dw ShellArmorDescription
	dw TangledFeetDescription
	dw MotorDriveDescription
	dw RivalryDescription
	dw SteadfastDescription
	dw SnowCloakDescription
	dw GluttonyDescription
	dw AngerPointDescription
	dw UnburdenDescription
	dw DrySkinDescription
	dw DownloadDescription
	dw IronFistDescription
	dw PoisonHealDescription
	dw AdaptabilityDescription
	dw SkillLinkDescription
	dw HydrationDescription
	dw SolarPowerDescription
	dw QuickFeetDescription
	dw SniperDescription
	dw MagicGuardDescription
	dw NoGuardDescription
	dw TechnicianDescription
	dw LeafGuardDescription
	dw MoldBreakerDescription
	dw SuperLuckDescription
	dw AftermathDescription
	dw AnticipationDescription
	dw ForewarnDescription
	dw UnawareDescription
	dw TintedLensDescription
	dw FilterDescription
	dw ScrappyDescription
	dw IceBodyDescription
	dw SolidRockDescription
	dw SnowWarningDescription
	dw FriskDescription
	dw RecklessDescription
	dw PickpocketDescription
	dw SheerForceDescription
	dw ContraryDescription
	dw UnnerveDescription
	dw DefiantDescription
	dw CursedBodyDescription
	dw WeakArmorDescription
	dw LightMetalDescription
	dw MultiscaleDescription
	dw HarvestDescription
	dw MoodyDescription
	dw OvercoatDescription
	dw PoisonTouchDescription
	dw RegeneratorDescription
	dw BigPecksDescription
	dw SandRushDescription
	dw WonderSkinDescription
	dw AnalyticDescription
	dw ImposterDescription
	dw InfiltratorDescription
	dw MoxieDescription
	dw JustifiedDescription
	dw RattledDescription
	dw MagicBounceDescription
	dw SapSipperDescription
	dw PranksterDescription
	dw SandForceDescription
	dw FurCoatDescription
	dw CompetitiveDescription
	dw MegaLauncherDescription
	dw ToughClawsDescription
	dw PixilateDescription
	dw ParentalBondDescription
	dw BerserkDescription
	dw SlushRushDescription
	dw GalvanizeDescription
	dw CorrosionDescription
	dw TanglingHairDescription
	dw GorillaTacticsDescription
	dw NeutralizingGasDescription
	dw PastelVeilDescription
	dw QuickDrawDescription
	assert_table_length NUM_ABILITIES

NoAbilityDescription:
	db    "Abilities are"
	next1 "disabled.@"

StenchDescription:
	db    "May cause the foe"
	next1 "to flinch.@"

DrizzleDescription:
	db    "Summons rain when"
	next1 "switched in.@"

SpeedBoostDescription:
	db    "Its Speed stat is"
	next1 "gradually boosted.@"

BattleArmorDescription:
ShellArmorDescription:
	db    "Protects from"
	next1 "critical hits.@"

SturdyDescription:
	db    "Cannot be knocked"
	next1 "out with one hit.@"

DampDescription:
	db    "Prevents self-"
	next1 "destructing moves.@"

LimberDescription:
	db    "Protects from"
	next1 "paralysis.@"

SandVeilDescription:
	db    "Boosts evasion in"
	next1 "a sandstorm.@"

StaticDescription:
	db    "Contact may cause"
	next1 "paralysis.@"

VoltAbsorbDescription:
	db    "Restores HP if hit"
	next1 "by Electric moves.@"

WaterAbsorbDescription:
	db    "Restores HP if hit"
	next1 "by Water moves.@"

ObliviousDescription:
	db    "Prevents it from"
	next1 "being infatuated.@"

CloudNineDescription:
	db    "Eliminates effects"
	next1 "of weather. @"

CompoundEyesDescription:
	db    "Boosts the Poké-"
	next1 "mon's accuracy.@"

InsomniaDescription:
VitalSpiritDescription:
	db    "Prevents it from"
	next1 "falling asleep.@"

ImmunityDescription:
PastelVeilDescription:
	db    "Prevents it from"
	next1 "getting poisoned.@"

FlashFireDescription:
	db    "Boosts Fire moves"
	next1 "if hit by one.@"

ShieldDustDescription:
	db    "Blocks additional"
	next1 "attack effects.@"

OwnTempoDescription:
	db    "Prevents it from"
	next1 "becoming confused.@"

SuctionCupsDescription:
	db    "Negates forced"
	next1 "switch-outs.@"

IntimidateDescription:
	db    "Lowers the foe's"
	next1 "Attack stat.@"

ShadowTagDescription:
	db    "Prevents the foe"
	next1 "from escaping.@"

LevitateDescription:
	db    "Gives immunity to"
	next1 "Ground-type moves.@"

EffectSporeDescription:
	db    "Contact may cause"
	next1 "Par, Psn, or Slp.@"

SynchronizeDescription:
	db    "Passes Psn, Par,"
	next1 "or Brn to foes.@"

ClearBodyDescription:
WhiteSmokeDescription:
	db    "Prevents foes from"
	next1 "lowering stats.@"

NaturalCureDescription:
	db    "Switch-outs heal"
	next1 "status problems.@"

LightningRodDescription:
	db    "Electric moves"
	next1 "boost Spcl.Atk.@"

SereneGraceDescription:
	db    "Boosts the rate of"
	next1 "added effects.@"

SwiftSwimDescription:
	db    "Boosts its Speed"
	next1 "in rain.@"

ChlorophyllDescription:
	db    "Boosts its Speed"
	next1 "in sunshine.@"

IlluminateDescription:
	db    "Raises the rate"
	next1 "of wild #mon.@"

TraceDescription:
	db    "Copies the foe's"
	next1 "Ability.@"

HugePowerDescription:
	db    "Boosts its Attack"
	next1 "stat.@"

PoisonPointDescription:
	db    "Contact may poison"
	next1 "the foe.@"

InnerFocusDescription:
	db    "Protects it from"
	next1 "flinching.@"

MagmaArmorDescription:
	db    "Prevents it from"
	next1 "becoming frozen.@"

WaterVeilDescription:
	db    "Prevents it from"
	next1 "getting a burn.@"

MagnetPullDescription:
	db    "Prevents escape by"
	next1 "Steel-type foes.@"

SoundproofDescription:
	db    "Gives immunity to"
	next1 "sound-based moves.@"

RainDishDescription:
	db    "Gradually regains"
	next1 "HP in rain.@"

SandStreamDescription:
	db    "Summons sandstorm"
	next1 "when switched in.@"

PressureDescription:
	db    "Raises the foe's"
	next1 "PP usage.@"

ThickFatDescription:
	db    "Ups resistance to"
	next1 "Fire and Ice.@"

EarlyBirdDescription:
	db    "Awakens quickly"
	next1 "from sleep.@"

FlameBodyDescription:
	db    "Contact may burn"
	next1 "the foe.@"

RunAwayDescription:
	db    "Sure getaway from"
	next1 "wild #mon.@"

KeenEyeDescription:
	db    "Prevents foes from"
	next1 "lowering accuracy.@"

HyperCutterDescription:
	db    "Prevents foes from"
	next1 "lowering Attack.@"

PickupDescription:
	db    "The #mon may"
	next1 "pick up items.@"

HustleDescription:
	db    "Boosts Attack, but"
	next1 "lowers accuracy.@"

CuteCharmDescription:
	db    "Contact may cause"
	next1 "infatuation.@"

StickyHoldDescription:
	db    "Protects it from"
	next1 "item theft.@"

ShedSkinDescription:
	db    "May heal its own"
	next1 "status problems.@"

GutsDescription:
	db    "Boosts Attack on"
	next1 "status problems.@"

MarvelScaleDescription:
	db    "Boosts Defense on"
	next1 "status problems.@"

LiquidOozeDescription:
	db    "Damages foes using"
	next1 "draining moves.@"

OvergrowDescription:
	db    "Boosts Grass moves"
	next1 "in a pinch.@"

BlazeDescription:
	db    "Boosts Fire moves"
	next1 "in a pinch.@"

TorrentDescription:
	db    "Boosts Water moves"
	next1 "in a pinch.@"

SwarmDescription:
	db    "Boosts Bug moves"
	next1 "in a pinch.@"

RockHeadDescription:
	db    "Protects it from"
	next1 "recoil damage.@"

DroughtDescription:
	db    "Summons sunlight"
	next1 "when switched in.@"

ArenaTrapDescription:
	db    "Prevents the foe"
	next1 "from fleeing.@"

TangledFeetDescription:
	db    "Boosts evasion if"
	next1 "it is confused.@"

MotorDriveDescription:
	db    "Electric moves"
	next1 "boost Speed.@"

RivalryDescription:
	db    "Boosts damage to"
	next1 "same-gender foes.@"

SteadfastDescription:
	db    "Boosts Speed when"
	next1 "it flinches.@"

SnowCloakDescription:
	db    "Boosts evasion in"
	next1 "hailstorms.@"

GluttonyDescription:
	db    "Encourages early"
	next1 "Berry use.@"

AngerPointDescription:
	db    "Maxes Attack after"
	next1 "a critical hit.@"

UnburdenDescription:
	db    "Boosts Speed when"
	next1 "held item is lost.@"

DrySkinDescription:
	db    "Reduces HP in sun."
	next1 "Water restores HP.@"

DownloadDescription:
	db    "Adjusts stats based"
	next1 "on foe's defenses.@"

IronFistDescription:
	db    "Boosts power of"
	next1 "punching moves.@"

PoisonHealDescription:
	db    "Restores HP if"
	next1 "it is poisoned.@"

AdaptabilityDescription:
	db    "Powers up same-"
	next1 "type moves.@"

SkillLinkDescription:
	db    "Increases multi-"
	next1 "strike move hits.@"

HydrationDescription:
	db    "Heals status"
	next1 "problems in rain.@"

SolarPowerDescription:
	db    "Ups Spcl.Atk but"
	next1 "lowers HP in sun.@"

QuickFeetDescription:
	db    "Boosts Speed with"
	next1 "status problems.@"

SniperDescription:
	db    "Powers up critical"
	next1 "hits.@"

MagicGuardDescription:
	db    "Only takes damage"
	next1 "from attacks.@"

NoGuardDescription:
	db    "Insures attacks by"
	next1 "or against it hit.@"

TechnicianDescription:
	db    "Powers up its"
	next1 "weaker moves.@"

LeafGuardDescription:
	db    "Prevents status"
	next1 "problems in sun.@"

MoldBreakerDescription:
	db    "Moves disregard"
	next1 "the foe's ability.@"

SuperLuckDescription:
	db    "Boosts the rate"
	next1 "of critical hits.@"

AftermathDescription:
	db    "Damages the foe on"
	next1 "fainting.@"

AnticipationDescription:
	db    "Senses the foe's"
	next1 "dangerous moves.@"

ForewarnDescription:
	db    "Determines the"
	next1 "foe's moves.@"

UnawareDescription:
	db    "Ignores the foe's"
	next1 "stat changes.@"

TintedLensDescription:
	db    "Powers up not very"
	next1 "effective moves.@"

FilterDescription:
SolidRockDescription:
	db    "Reduces super"
	next1 "effective damage.@"

ScrappyDescription:
	db    "Enables moves to"
	next1 "hit Ghost-types.@"

IceBodyDescription:
	db    "Gradually regains"
	next1 "HP in hail.@"

SnowWarningDescription:
	db    "Summons hailstorm"
	next1 "when switched in.@"

FriskDescription:
	db    "Checks the foe's"
	next1 "held item.@"

RecklessDescription:
	db    "Powers up moves"
	next1 "that recoil.@"

PickpocketDescription:
	db    "Steals foe's item"
	next1 "when contacted.@"

SheerForceDescription:
	db    "Removes effects to"
	next1 "increase damage.@"

ContraryDescription:
	db    "Inverts the effect"
	next1 "of stat changes.@"

UnnerveDescription:
	db    "Prevents foes from"
	next1 "eating Berries.@"

DefiantDescription:
	db    "Boosts Attack when"
	next1 "stats are lowered.@"

CursedBodyDescription:
	db    "May disable a move"
	next1 "used on it.@"

WeakArmorDescription:
	db    "Physical attacks"
	next1 "trade Def for Spd.@"

LightMetalDescription:
	db    "Halves the Poké-"
	next1 "mon's weight.@"

MultiscaleDescription:
	db    "Reduces damage"
	next1 "when HP is full.@"

HarvestDescription:
	db    "May recreate a"
	next1 "Berry after use.@"

MoodyDescription:
	db    "Raises a stat and"
	next1 "lowers another.@"

OvercoatDescription:
	db    "Protects it from"
	next1 "weather damage.@"

PoisonTouchDescription:
	db    "May poison the foe"
	next1 "on contact.@"

RegeneratorDescription:
	db    "Restores HP when"
	next1 "withdrawn.@"

BigPecksDescription:
	db    "Prevents foes from"
	next1 "lowering Defense.@"

SandRushDescription:
	db    "Boosts Speed in"
	next1 "a sandstorm.@"

WonderSkinDescription:
	db    "Makes status moves"
	next1 "miss more often.@"

AnalyticDescription:
	db    "Boosts move power"
	next1 "when moving last.@"

ImposterDescription:
	db    "Transforms itself"
	next1 "into the foe.@"

InfiltratorDescription:
	db    "Attacks bypass the"
	next1 "foe's barriers.@"

MoxieDescription:
	db    "Boosts Attack when"
	next1 "knocking out foes.@"

JustifiedDescription:
	db    "Boosts Attack when"
	next1 "hit by Dark moves.@"

RattledDescription:
	db    "Some scary move"
	next1 "types boost Speed.@"

MagicBounceDescription:
	db    "Reflects status-"
	next1 "changing moves.@"

SapSipperDescription:
	db    "Boosts Attack when"
	next1 "hit by Grass.@"

PranksterDescription:
	db    "Gives priority to"
	next1 "a status move.@"

SandForceDescription:
	db    "Boosts some moves"
	next1 "in a sandstorm.@"

FurCoatDescription:
	db    "Halves damage from"
	next1 "physical moves.@"

CompetitiveDescription:
	db    "Boosts Spcl.Atk on"
	next1 "stat reduction.@"

MegaLauncherDescription:
	db    "Powers up aura"
	next1 "and pulse moves.@"

ToughClawsDescription:
	db    "Boosts moves that"
	next1 "makes contact.@"

PixilateDescription:
	db    "Normal-type moves"
	next1 "become Fairy-type.@"

ParentalBondDescription:
	db    "Parent and child"
	next1 "attack together.@"

BerserkDescription:
	db    "Ups Spcl.Atk. when"
	next1 "damaged over half.@"

SlushRushDescription:
	db    "Boosts Speed in"
	next1 "a hailstorm.@"

GalvanizeDescription:
	db    "Normal-type moves"
	next1 "become Electric.@"

CorrosionDescription:
	db    "Foes of any type"
	next1 "can be poisoned.@"

TanglingHairDescription:
	db    "Contact may lower"
	next1 "the foe's Speed.@"

GorillaTacticsDescription:
	db    "Boosts Attack, but"
	next1 "allows one move.@"

NeutralizingGasDescription:
	db    "Suppresses all"
	next1 "other Abilities.@"

QuickDrawDescription:
	db    "Moves first"
	next1 "occasionally.@"
