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
	dw HoneyGatherDescription
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
	dw BulletproofDescription
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
	dw SteelySpiritDescription
	dw PerishBodyDescription
	dw ScreenCleanerDescription
	dw CudChewDescription
	dw SharpnessDescription
	dw ArmorTailDescription
	dw MindsEyeDescription
	assert_table_length NUM_ABILITIES

NoAbilityDescription:
	text  "Abilities are"
	next1 "disabled."
	done

StenchDescription:
	text  "May cause the foe"
	next1 "to flinch."
	done

DrizzleDescription:
	text  "Summons rain when"
	next1 "switched in."
	done

SpeedBoostDescription:
	text  "Its Speed stat is"
	next1 "gradually boosted."
	done

BattleArmorDescription:
ShellArmorDescription:
	text  "Protects from"
	next1 "critical hits."
	done

SturdyDescription:
	text  "Cannot be knocked"
	next1 "out with one hit."
	done

DampDescription:
	text  "Prevents self-"
	next1 "destructing moves."
	done

LimberDescription:
	text  "Protects from"
	next1 "paralysis."
	done

SandVeilDescription:
	text  "Boosts evasion in"
	next1 "a sandstorm."
	done

StaticDescription:
	text  "Contact may cause"
	next1 "paralysis."
	done

VoltAbsorbDescription:
	text  "Restores HP if hit"
	next1 "by Electric moves."
	done

WaterAbsorbDescription:
	text  "Restores HP if hit"
	next1 "by Water moves."
	done

ObliviousDescription:
	text  "Prevents it from"
	next1 "being infatuated."
	done

CloudNineDescription:
	text  "Eliminates effects"
	next1 "of weather."
	done

CompoundEyesDescription:
	text  "Boosts the Poké-"
	next1 "mon's accuracy."
	done

InsomniaDescription:
VitalSpiritDescription:
	text  "Prevents it from"
	next1 "falling asleep."
	done

ImmunityDescription:
PastelVeilDescription:
	text  "Prevents it from"
	next1 "getting poisoned."
	done

FlashFireDescription:
	text  "Boosts Fire moves"
	next1 "if hit by one."
	done

ShieldDustDescription:
	text  "Blocks additional"
	next1 "attack effects."
	done

OwnTempoDescription:
	text  "Prevents it from"
	next1 "becoming confused."
	done

SuctionCupsDescription:
	text  "Negates forced"
	next1 "switch-outs."
	done

IntimidateDescription:
	text  "Lowers the foe's"
	next1 "Attack stat."
	done

ShadowTagDescription:
	text  "Prevents the foe"
	next1 "from escaping."
	done

LevitateDescription:
	text  "Gives immunity to"
	next1 "Ground-type moves."
	done

EffectSporeDescription:
	text  "Contact may cause"
	next1 "Par, Psn, or Slp."
	done

SynchronizeDescription:
	text  "Passes Psn, Par,"
	next1 "or Brn to foes."
	done

ClearBodyDescription:
WhiteSmokeDescription:
	text  "Prevents foes from"
	next1 "lowering stats."
	done

NaturalCureDescription:
	text  "Switch-outs heal"
	next1 "status problems."
	done

LightningRodDescription:
	text  "Electric moves"
	next1 "boost Sp.Atk."
	done

SereneGraceDescription:
	text  "Boosts the rate of"
	next1 "added effects."
	done

SwiftSwimDescription:
	text  "Boosts its Speed"
	next1 "in rain."
	done

ChlorophyllDescription:
	text  "Boosts its Speed"
	next1 "in sunshine."
	done

IlluminateDescription:
	text  "Raises the rate"
	next1 "of wild #mon."
	done

TraceDescription:
	text  "Copies the foe's"
	next1 "Ability."
	done

HugePowerDescription:
	text  "Boosts its Attack"
	next1 "stat."
	done

PoisonPointDescription:
	text  "Contact may poison"
	next1 "the foe."
	done

InnerFocusDescription:
	text  "Protects it from"
	next1 "flinching."
	done

MagmaArmorDescription:
	text  "Prevents it from"
	next1 "becoming frozen."
	done

WaterVeilDescription:
	text  "Prevents it from"
	next1 "getting a burn."
	done

MagnetPullDescription:
	text  "Prevents escape by"
	next1 "Steel-type foes."
	done

SoundproofDescription:
	text  "Gives immunity to"
	next1 "sound-based moves."
	done

RainDishDescription:
	text  "Gradually regains"
	next1 "HP in rain."
	done

SandStreamDescription:
	text  "Summons sandstorm"
	next1 "when switched in."
	done

PressureDescription:
	text  "Raises the foe's"
	next1 "PP usage."
	done

ThickFatDescription:
	text  "Ups resistance to"
	next1 "Fire and Ice."
	done

EarlyBirdDescription:
	text  "Awakens quickly"
	next1 "from sleep."
	done

FlameBodyDescription:
	text  "Contact may burn"
	next1 "the foe."
	done

RunAwayDescription:
	text  "Sure getaway from"
	next1 "wild #mon."
	done

KeenEyeDescription:
	text  "Prevents foes from"
	next1 "lowering accuracy."
	done

HyperCutterDescription:
	text  "Prevents foes from"
	next1 "lowering Attack."
	done

PickupDescription:
	text  "The #mon may"
	next1 "pick up items."
	done

HustleDescription:
	text  "Boosts Attack, but"
	next1 "lowers accuracy."
	done

CuteCharmDescription:
	text  "Contact may cause"
	next1 "infatuation."
	done

StickyHoldDescription:
	text  "Protects it from"
	next1 "item theft."
	done

ShedSkinDescription:
	text  "May heal its own"
	next1 "status problems."
	done

GutsDescription:
	text  "Boosts Attack on"
	next1 "status problems."
	done

MarvelScaleDescription:
	text  "Boosts Defense on"
	next1 "status problems."
	done

LiquidOozeDescription:
	text  "Damages foes using"
	next1 "draining moves."
	done

OvergrowDescription:
	text  "Boosts Grass moves"
	next1 "in a pinch."
	done

BlazeDescription:
	text  "Boosts Fire moves"
	next1 "in a pinch."
	done

TorrentDescription:
	text  "Boosts Water moves"
	next1 "in a pinch."
	done

SwarmDescription:
	text  "Boosts Bug moves"
	next1 "in a pinch."
	done

RockHeadDescription:
	text  "Protects it from"
	next1 "recoil damage."
	done

DroughtDescription:
	text  "Summons sunlight"
	next1 "when switched in."
	done

ArenaTrapDescription:
	text  "Prevents the foe"
	next1 "from fleeing."
	done

TangledFeetDescription:
	text  "Boosts evasion if"
	next1 "it is confused."
	done

MotorDriveDescription:
	text  "Electric moves"
	next1 "boost Speed."
	done

RivalryDescription:
	text  "Boosts damage to"
	next1 "same-gender foes."
	done

SteadfastDescription:
	text  "Boosts Speed when"
	next1 "it flinches."
	done

SnowCloakDescription:
	text  "Boosts evasion in"
	next1 "hailstorms."
	done

GluttonyDescription:
	text  "Encourages early"
	next1 "Berry use."
	done

AngerPointDescription:
	text  "Maxes Attack after"
	next1 "a critical hit."
	done

UnburdenDescription:
	text  "Boosts Speed when"
	next1 "held item is lost."
	done

DrySkinDescription:
	text  "Reduces HP in sun."
	next1 "Water restores HP."
	done

DownloadDescription:
	text  "Adjusts stats based"
	next1 "on foe's defenses."
	done

IronFistDescription:
	text  "Boosts power of"
	next1 "punching moves."
	done

PoisonHealDescription:
	text  "Restores HP if"
	next1 "it is poisoned."
	done

AdaptabilityDescription:
	text  "Powers up same-"
	next1 "type moves."
	done

SkillLinkDescription:
	text  "Increases multi-"
	next1 "strike move hits."
	done

HydrationDescription:
	text  "Heals status"
	next1 "problems in rain."
	done

SolarPowerDescription:
	text  "Boosts Sp.Atk but"
	next1 "lowers HP in sun."
	done

QuickFeetDescription:
	text  "Boosts Speed with"
	next1 "status problems."
	done

SniperDescription:
	text  "Powers up critical"
	next1 "hits."
	done

MagicGuardDescription:
	text  "Only takes damage"
	next1 "from attacks."
	done

NoGuardDescription:
	text  "Ensures attacks by"
	next1 "or against it hit."
	done

TechnicianDescription:
	text  "Powers up its"
	next1 "weaker moves."
	done

LeafGuardDescription:
	text  "Prevents status"
	next1 "problems in sun."
	done

MoldBreakerDescription:
	text  "Moves disregard"
	next1 "the foe's ability."
	done

SuperLuckDescription:
	text  "Boosts the rate"
	next1 "of critical hits."
	done

AftermathDescription:
	text  "Damages the foe on"
	next1 "fainting."
	done

AnticipationDescription:
	text  "Senses the foe's"
	next1 "dangerous moves."
	done

ForewarnDescription:
	text  "Determines the"
	next1 "foe's moves."
	done

UnawareDescription:
	text  "Ignores the foe's"
	next1 "stat changes."
	done

TintedLensDescription:
	text  "Powers up not very"
	next1 "effective moves."
	done

FilterDescription:
SolidRockDescription:
	text  "Reduces super"
	next1 "effective damage."
	done

ScrappyDescription:
	text  "Enables moves to"
	next1 "hit Ghost-types."
	done

IceBodyDescription:
	text  "Gradually regains"
	next1 "HP in hail."
	done

SnowWarningDescription:
	text  "Summons hailstorm"
	next1 "when switched in."
	done

HoneyGatherDescription:
	text  "The #mon may"
if DEF(FAITHFUL)
	next1 "gather Honey."
else
	next1 "find Sweet Honey."
endc
	done

FriskDescription:
	text  "Checks the foe's"
	next1 "held item."
	done

RecklessDescription:
	text  "Powers up moves"
	next1 "that recoil."
	done

PickpocketDescription:
	text  "Steals foe's item"
	next1 "when contacted."
	done

SheerForceDescription:
	text  "Removes effects to"
	next1 "increase damage."
	done

ContraryDescription:
	text  "Inverts the effect"
	next1 "of stat changes."
	done

UnnerveDescription:
	text  "Prevents foes from"
	next1 "eating Berries."
	done

DefiantDescription:
	text  "Boosts Attack when"
	next1 "stats are lowered."
	done

CursedBodyDescription:
	text  "May disable a move"
	next1 "used on it."
	done

WeakArmorDescription:
	text  "Physical attacks"
	next1 "trade Def for Spe."
	done

LightMetalDescription:
	text  "Halves the Poké-"
	next1 "mon's weight."
	done

MultiscaleDescription:
	text  "Reduces damage"
	next1 "when HP is full."
	done

HarvestDescription:
	text  "May recreate a"
	next1 "Berry after use."
	done

MoodyDescription:
	text  "Raises a stat and"
	next1 "lowers another."
	done

OvercoatDescription:
	text  "Protects it from"
	next1 "weather damage."
	done

PoisonTouchDescription:
	text  "May poison the foe"
	next1 "on contact."
	done

RegeneratorDescription:
	text  "Restores HP when"
	next1 "withdrawn."
	done

BigPecksDescription:
	text  "Prevents foes from"
	next1 "lowering Defense."
	done

SandRushDescription:
	text  "Boosts Speed in"
	next1 "a sandstorm."
	done

WonderSkinDescription:
	text  "Makes status moves"
	next1 "miss more often."
	done

AnalyticDescription:
	text  "Boosts move power"
	next1 "when moving last."
	done

ImposterDescription:
	text  "Transforms itself"
	next1 "into the foe."
	done

InfiltratorDescription:
	text  "Attacks bypass the"
	next1 "foe's barriers."
	done

MoxieDescription:
	text  "Boosts Attack when"
	next1 "knocking out foes."
	done

JustifiedDescription:
	text  "Boosts Attack when"
	next1 "hit by Dark moves."
	done

RattledDescription:
	text  "Dark, Ghost or Bug"
	next1 "moves boost Speed."
	done

MagicBounceDescription:
	text  "Reflects status-"
	next1 "changing moves."
	done

SapSipperDescription:
	text  "Boosts Attack when"
	next1 "hit by Grass."
	done

PranksterDescription:
	text  "Gives priority to"
	next1 "a status move."
	done

SandForceDescription:
	text  "Boosts some moves"
	next1 "in a sandstorm."
	done

FurCoatDescription:
	text  "Halves damage from"
	next1 "physical moves."
	done

BulletproofDescription:
	text  "Protects from ball"
	next1 "and bomb moves."
	done

CompetitiveDescription:
	text  "Boosts Sp.Atk on"
	next1 "stat reduction."
	done

MegaLauncherDescription:
	text  "Powers up aura"
	next1 "and pulse moves."
	done

ToughClawsDescription:
	text  "Boosts moves that"
	next1 "makes contact."
	done

PixilateDescription:
	text  "Normal-type moves"
	next1 "become Fairy-type."
	done

ParentalBondDescription:
	text  "Parent and child"
	next1 "attack together."
	done

BerserkDescription:
	text  "Boosts Sp.Atk when"
	next1 "damaged over half."
	done

SlushRushDescription:
	text  "Boosts Speed in"
	next1 "a hailstorm."
	done

GalvanizeDescription:
	text  "Normal-type moves"
	next1 "become Electric."
	done

CorrosionDescription:
	text  "Foes of any type"
	next1 "can be poisoned."
	done

TanglingHairDescription:
	text  "Contact may lower"
	next1 "the foe's Speed."
	done

GorillaTacticsDescription:
	text  "Boosts Attack, but"
	next1 "allows one move."
	done

NeutralizingGasDescription:
	text  "Suppresses all"
	next1 "other Abilities."
	done

QuickDrawDescription:
	text  "Moves first"
	next1 "occasionally."
	done

SteelySpiritDescription:
	text  "Boosts Steel-type"
	next1 "moves."
	done

PerishBodyDescription:
	text  "Contact causes Pe-"
	next1 "rish Song status."
	done

ScreenCleanerDescription:
	text  "Removes screens"
	next1 "when switched in."
	done

CudChewDescription:
	text  "Eats a Berry again"
	next1 "after first use."
	done

SharpnessDescription:
	text  "Boosts power of"
	next1 "slicing moves."
	done

ArmorTailDescription:
	text  "Stops foes using"
	next1 "priority moves."
	done

MindsEyeDescription:
	text  "Ignores the foe's"
	next1 "efforts to evade."
	done
