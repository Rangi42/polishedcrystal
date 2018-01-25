PrintAbility:
; Print ability b at hl.
	ld l, b
	ld h, 0
	ld bc, AbilityNames
	add hl, hl
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
	hlcoord 3, 13
	jp PlaceString

BufferAbility:
; Buffer name for b into StringBuffer1
	ld l, b
	ld h, 0
	ld bc, AbilityNames
	add hl, hl
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, StringBuffer1
.loop
	ld a, [hli]
	ld [de], a
	inc de
	cp "@"
	ret z
	jr .loop


AbilityNames:
	dw NoAbility
	dw Stench
	dw Drizzle
	dw SpeedBoost
	dw BattleArmor
	dw Sturdy
	dw Damp
	dw Limber
	dw SandVeil
	dw Static
	dw VoltAbsorb
	dw WaterAbsorb
	dw Oblivious
	dw CloudNine
	dw CompoundEyes
	dw Insomnia
	dw Immunity
	dw FlashFire
	dw ShieldDust
	dw OwnTempo
	dw SuctionCups
	dw Intimidate
	dw ShadowTag
	dw Levitate
	dw EffectSpore
	dw Synchronize
	dw ClearBody
	dw NaturalCure
	dw LightningRod
	dw SereneGrace
	dw SwiftSwim
	dw Chlorophyll
	dw Illuminate
	dw Trace
	dw HugePower
	dw PoisonPoint
	dw InnerFocus
	dw MagmaArmor
	dw WaterVeil
	dw MagnetPull
	dw Soundproof
	dw RainDish
	dw SandStream
	dw Pressure
	dw ThickFat
	dw EarlyBird
	dw FlameBody
	dw RunAway
	dw KeenEye
	dw HyperCutter
	dw Pickup
	dw Hustle
	dw CuteCharm
	dw StickyHold
	dw ShedSkin
	dw Guts
	dw MarvelScale
	dw LiquidOoze
	dw Overgrow
	dw Blaze
	dw Torrent
	dw Swarm
	dw RockHead
	dw Drought
	dw ArenaTrap
	dw VitalSpirit
	dw ShellArmor
	dw TangledFeet
	dw MotorDrive
	dw Rivalry
	dw Steadfast
	dw SnowCloak
	dw Gluttony
	dw AngerPoint
	dw Unburden
	dw DrySkin
	dw Download
	dw IronFist
	dw PoisonHeal
	dw Adaptability
	dw SkillLink
	dw Hydration
	dw SolarPower
	dw QuickFeet
	dw Sniper
	dw MagicGuard
	dw NoGuard
	dw Technician
	dw LeafGuard
	dw MoldBreaker
	dw SuperLuck
	dw Aftermath
	dw Anticipation
	dw Forewarn
	dw Unaware
	dw TintedLens
	dw Filter
	dw Scrappy
	dw IceBody
	dw SolidRock
	dw SnowWarning
	dw Frisk
	dw Reckless
	dw Pickpocket
	dw SheerForce
	dw Unnerve
	dw Defiant
	dw CursedBody
	dw WeakArmor
	dw Multiscale
	dw Harvest
	dw Moody
	dw Overcoat
	dw PoisonTouch
	dw Regenerator
	dw BigPecks
	dw SandRush
	dw WonderSkin
	dw Analytic
	dw Imposter
	dw Infiltrator
	dw Moxie
	dw Justified
	dw Rattled
	dw MagicBounce
	dw SapSipper
	dw Prankster
	dw SandForce
	dw FurCoat
	dw Competitive
	dw Pixilate
	dw TanglingHair

NoAbility:     db "---@"
Stench:        db "Stench@"
Drizzle:       db "Drizzle@"
SpeedBoost:    db "Speed Boost@"
BattleArmor:   db "Battle Armor@"
Sturdy:        db "Sturdy@"
Damp:          db "Damp@"
Limber:        db "Limber@"
SandVeil:      db "Sand Veil@"
Static:        db "Static@"
VoltAbsorb:    db "Volt Absorb@"
WaterAbsorb:   db "Water Absorb@"
Oblivious:     db "Oblivious@"
CloudNine:     db "Cloud Nine@"
CompoundEyes:  db "Compound Eyes@"
Insomnia:      db "Insomnia@"
Immunity:      db "Immunity@"
FlashFire:     db "Flash Fire@"
ShieldDust:    db "Shield Dust@"
OwnTempo:      db "Own Tempo@"
SuctionCups:   db "Suction Cups@"
Intimidate:    db "Intimidate@"
ShadowTag:     db "Shadow Tag@"
Levitate:      db "Levitate@"
EffectSpore:   db "Effect Spore@"
Synchronize:   db "Synchronize@"
ClearBody:     db "Clear Body@"
NaturalCure:   db "Natural Cure@"
LightningRod:  db "Lightning Rod@"
SereneGrace:   db "Serene Grace@"
SwiftSwim:     db "Swift Swim@"
Chlorophyll:   db "Chlorophyll@"
Illuminate:    db "Illuminate@"
Trace:         db "Trace@"
HugePower:     db "Huge Power@"
PoisonPoint:   db "Poison Point@"
InnerFocus:    db "Inner Focus@"
MagmaArmor:    db "Magma Armor@"
WaterVeil:     db "Water Veil@"
MagnetPull:    db "Magnet Pull@"
Soundproof:    db "Soundproof@"
RainDish:      db "Rain Dish@"
SandStream:    db "Sand Stream@"
Pressure:      db "Pressure@"
ThickFat:      db "Thick Fat@"
EarlyBird:     db "Early Bird@"
FlameBody:     db "Flame Body@"
RunAway:       db "Run Away@"
KeenEye:       db "Keen Eye@"
HyperCutter:   db "Hyper Cutter@"
Pickup:        db "Pickup@"
Hustle:        db "Hustle@"
CuteCharm:     db "Cute Charm@"
StickyHold:    db "Sticky Hold@"
ShedSkin:      db "Shed Skin@"
Guts:          db "Guts@"
MarvelScale:   db "Marvel Scale@"
LiquidOoze:    db "Liquid Ooze@"
Overgrow:      db "Overgrow@"
Blaze:         db "Blaze@"
Torrent:       db "Torrent@"
Swarm:         db "Swarm@"
RockHead:      db "Rock Head@"
Drought:       db "Drought@"
ArenaTrap:     db "Arena Trap@"
VitalSpirit:   db "Vital Spirit@"
ShellArmor:    db "Shell Armor@"
TangledFeet:   db "Tangled Feet@"
MotorDrive:    db "Motor Drive@"
Rivalry:       db "Rivalry@"
Steadfast:     db "Steadfast@"
SnowCloak:     db "Snow Cloak@"
Gluttony:      db "Gluttony@"
AngerPoint:    db "Anger Point@"
Unburden:      db "Unburden@"
DrySkin:       db "Dry Skin@"
Download:      db "Download@"
IronFist:      db "Iron Fist@"
PoisonHeal:    db "Poison Heal@"
Adaptability:  db "Adaptability@"
SkillLink:     db "Skill Link@"
Hydration:     db "Hydration@"
SolarPower:    db "Solar Power@"
QuickFeet:     db "Quick Feet@"
Sniper:        db "Sniper@"
MagicGuard:    db "Magic Guard@"
NoGuard:       db "No Guard@"
Technician:    db "Technician@"
LeafGuard:     db "Leaf Guard@"
MoldBreaker:   db "Mold Breaker@"
SuperLuck:     db "Super Luck@"
Aftermath:     db "Aftermath@"
Anticipation:  db "Anticipation@"
Forewarn:      db "Forewarn@"
Unaware:       db "Unaware@"
TintedLens:    db "Tinted Lens@"
Filter:        db "Filter@"
Scrappy:       db "Scrappy@"
IceBody:       db "Ice Body@"
SolidRock:     db "Solid Rock@"
SnowWarning:   db "Snow Warning@"
Frisk:         db "Frisk@"
Reckless:      db "Reckless@"
Pickpocket:    db "Pickpocket@"
SheerForce:    db "Sheer Force@"
Unnerve:       db "Unnerve@"
Defiant:       db "Defiant@"
CursedBody:    db "Cursed Body@"
WeakArmor:     db "Weak Armor@"
Multiscale:    db "Multiscale@"
Harvest:       db "Harvest@"
Moody:         db "Moody@"
Overcoat:      db "Overcoat@"
PoisonTouch:   db "Poison Touch@"
Regenerator:   db "Regenerator@"
BigPecks:      db "Big Pecks@"
SandRush:      db "Sand Rush@"
WonderSkin:    db "Wonder Skin@"
Analytic:      db "Analytic@"
Imposter:      db "Imposter@"
Infiltrator:   db "Infiltrator@"
Moxie:         db "Moxie@"
Justified:     db "Justified@"
Rattled:       db "Rattled@"
MagicBounce:   db "Magic Bounce@"
SapSipper:     db "Sap Sipper@"
Prankster:     db "Prankster@"
SandForce:     db "Sand Force@"
FurCoat:       db "Fur Coat@"
Competitive:   db "Competitive@"
Pixilate:      db "Pixilate@"
TanglingHair:  db "Tangling Hair@"


PrintAbilityDescription:
; Print ability description for b
; we can't use PlaceString, because it would linebreak with an empty line inbetween
	ld l, b
	ld h, 0
	ld bc, AbilityDescriptions
	add hl, hl
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	decoord 1, 15
	push de
.loop
	ld a, [hli]
	cp "@"
	jr z, .done
	cp $4e
	jr z, .line
	ld [de], a
	inc de
	jr .loop

.line
	pop de
	push hl
	ld hl, $0014
	add hl, de
	ld d, h
	ld e, l
	pop hl
	push de
	jr .loop

.done
	pop de
	ret

AbilityDescriptions:
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
	dw UnnerveDescription
	dw DefiantDescription
	dw CursedBodyDescription
	dw WeakArmorDescription
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
	dw PixilateDescription
	dw TanglingHairDescription

NoAbilityDescription:
	db   "Abilities are"
	next "disabled.@"

StenchDescription:
	db   "May cause the foe"
	next "to flinch.@"

DrizzleDescription:
	db   "Summons rain when"
	next "switched in.@"

SpeedBoostDescription:
	db   "Its Speed stat is"
	next "gradually boosted.@"

BattleArmorDescription:
ShellArmorDescription:
	db   "Protects from"
	next "critical hits.@"

SturdyDescription:
	db   "Cannot be knocked"
	next "out with one hit.@"

DampDescription:
	db   "Prevents self-"
	next "destructing moves.@"

LimberDescription:
	db   "Protects from"
	next "paralysis.@"

SandVeilDescription:
	db   "Boosts evasion in"
	next "a sandstorm.@"

StaticDescription:
	db   "Contact may cause"
	next "paralysis.@"

VoltAbsorbDescription:
	db   "Restores HP if hit"
	next "by Electric moves.@"

WaterAbsorbDescription:
	db   "Restores HP if hit"
	next "by Water moves.@"

ObliviousDescription:
	db   "Prevents it from"
	next "being infatuated.@"

CloudNineDescription:
	db   "Eliminates effects"
	next "of weather. @"

CompoundEyesDescription:
	db   "Boosts the Poké-"
	next "mon's accuracy.@"

InsomniaDescription:
VitalSpiritDescription:
	db   "Prevents it from"
	next "falling asleep.@"

ImmunityDescription:
	db   "Prevents it from"
	next "getting poisoned.@"

FlashFireDescription:
	db   "Boosts Fire moves"
	next "if hit by one.@"

ShieldDustDescription:
	db   "Blocks additional"
	next "attack effects.@"

OwnTempoDescription:
	db   "Prevents it from"
	next "becoming confused.@"

SuctionCupsDescription:
	db   "Negates forced"
	next "switch-outs.@"

IntimidateDescription:
	db   "Lowers the foe's"
	next "Attack stat.@"

ShadowTagDescription:
	db   "Prevents the foe"
	next "from escaping.@"

LevitateDescription:
	db   "Gives immunity to"
	next "Ground-type moves.@"

EffectSporeDescription:
	db   "Contact may cause"
	next "Par, Psn, or Slp.@"

SynchronizeDescription:
	db   "Passes Psn, Par,"
	next "or Brn to foes.@"

ClearBodyDescription:
	db   "Prevents foes from"
	next "lowering stats.@"

NaturalCureDescription:
	db   "Switch-outs heal"
	next "status problems.@"

LightningRodDescription:
	db   "Electric moves"
	next "boost Spcl.Atk.@"

SereneGraceDescription:
	db   "Boosts the rate of"
	next "added effects.@"

SwiftSwimDescription:
	db   "Boosts its Speed"
	next "in rain.@"

ChlorophyllDescription:
	db   "Boosts its Speed"
	next "in sunshine.@"

IlluminateDescription:
	db   "Raises the rate"
	next "of wild Pokémon.@"

TraceDescription:
	db   "Copies the foe's"
	next "Ability.@"

HugePowerDescription:
	db   "Boosts its Attack"
	next "stat.@"

PoisonPointDescription:
	db   "Contact may poison"
	next "the foe.@"

InnerFocusDescription:
	db   "Protects it from"
	next "flinching.@"

MagmaArmorDescription:
	db   "Prevents it from"
	next "becoming frozen.@"

WaterVeilDescription:
	db   "Prevents it from"
	next "getting a burn.@"

MagnetPullDescription:
	db   "Prevents escape by"
	next "Steel-type foes.@"

SoundproofDescription:
	db   "Gives immunity to"
	next "sound-based moves.@"

RainDishDescription:
	db   "Gradually regains"
	next "HP in rain.@"

SandStreamDescription:
	db   "Summons sandstorm"
	next "when switched in.@"

PressureDescription:
	db   "Raises the foe's"
	next "PP usage.@"

ThickFatDescription:
	db   "Ups resistance to"
	next "Fire and Ice.@"

EarlyBirdDescription:
	db   "Awakens quickly"
	next "from sleep.@"

FlameBodyDescription:
	db   "Contact may burn"
	next "the foe.@"

RunAwayDescription:
	db   "Sure getaway from"
	next "wild Pokémon.@"

KeenEyeDescription:
	db   "Prevents foes from"
	next "lowering accuracy.@"

HyperCutterDescription:
	db   "Prevents foes from"
	next "lowering Attack.@"

PickupDescription:
	db   "The Pokémon may"
	next "pick up items.@"

HustleDescription:
	db   "Boosts Attack, but"
	next "lowers accuracy.@"

CuteCharmDescription:
	db   "Contact may cause"
	next "infatuation.@"

StickyHoldDescription:
	db   "Protects it from"
	next "item theft.@"

ShedSkinDescription:
	db   "May heal its own"
	next "status problems.@"

GutsDescription:
	db   "Boosts Attack on"
	next "status problems.@"

MarvelScaleDescription:
	db   "Boosts Defense on"
	next "status problems.@"

LiquidOozeDescription:
	db   "Damages foes using"
	next "draining moves.@"

OvergrowDescription:
	db   "Boosts Grass moves"
	next "in a pinch.@"

BlazeDescription:
	db   "Boosts Fire moves"
	next "in a pinch.@"

TorrentDescription:
	db   "Boosts Water moves"
	next "in a pinch.@"

SwarmDescription:
	db   "Boosts Bug moves"
	next "in a pinch.@"

RockHeadDescription:
	db   "Protects it from"
	next "recoil damage.@"

DroughtDescription:
	db   "Summons sunlight"
	next "when switched in.@"

ArenaTrapDescription:
	db   "Prevents the foe"
	next "from fleeing.@"

TangledFeetDescription:
	db   "Boosts evasion if"
	next "it is confused.@"

MotorDriveDescription:
	db   "Electric moves"
	next "boost Speed.@"

RivalryDescription:
	db   "Boosts damage to"
	next "same-gender foes.@"

SteadfastDescription:
	db   "Boosts Speed when"
	next "it flinches.@"

SnowCloakDescription:
	db   "Boosts evasion in"
	next "hailstorms.@"

GluttonyDescription:
	db   "Encourages early"
	next "Berry use.@"

AngerPointDescription:
	db   "Maxes Attack after"
	next "a critical hit.@"

UnburdenDescription:
	db   "Boosts Speed when"
	next "held item is lost.@"

DrySkinDescription:
	db   "Reduces HP in sun."
	next "Water restores HP.@"

DownloadDescription:
	db   "Adjusts stats based"
	next "on foe's defenses.@"

IronFistDescription:
	db   "Boosts power of"
	next "punching moves.@"

PoisonHealDescription:
	db   "Restores HP if"
	next "it is poisoned.@"

AdaptabilityDescription:
	db   "Powers up same-"
	next "type moves.@"

SkillLinkDescription:
	db   "Increases multi-"
	next "strike move hits.@"

HydrationDescription:
	db   "Heals status"
	next "problems in rain.@"

SolarPowerDescription:
	db   "Ups Spcl.Atk but"
	next "lowers HP in sun.@"

QuickFeetDescription:
	db   "Boosts Speed with"
	next "status problems.@"

SniperDescription:
	db   "Powers up critical"
	next "hits.@"

MagicGuardDescription:
	db   "Only takes damage"
	next "from attacks.@"

NoGuardDescription:
	db   "Insures attacks by"
	next "or against it hit.@"

TechnicianDescription:
	db   "Powers up its"
	next "weaker moves.@"

LeafGuardDescription:
	db   "Prevents status"
	next "problems in sun.@"

MoldBreakerDescription:
	db   "Moves disregard"
	next "the foe's ability.@"

SuperLuckDescription:
	db   "Boosts the rate"
	next "of critical hits.@"

AftermathDescription:
	db   "Damages the foe on"
	next "fainting.@"

AnticipationDescription:
	db   "Senses the foe's"
	next "dangerous moves.@"

ForewarnDescription:
	db   "Determines the"
	next "foe's moves.@"

UnawareDescription:
	db   "Ignores the foe's"
	next "stat changes.@"

TintedLensDescription:
	db   "Powers up not very"
	next "effective moves.@"

FilterDescription:
SolidRockDescription:
	db   "Reduces super-"
	next "effective damage.@"

ScrappyDescription:
	db   "Enables moves to"
	next "hit Ghost-types.@"

IceBodyDescription:
	db   "Gradually regains"
	next "HP in hail.@"

SnowWarningDescription:
	db   "Summons hailstorm"
	next "when switched in.@"

FriskDescription:
	db   "Checks the foe's"
	next "held item.@"

RecklessDescription:
	db   "Powers up moves"
	next "that recoil.@"

PickpocketDescription:
	db   "Steals foe's item"
	next "when contacted.@"

SheerForceDescription:
	db   "Removes effects to"
	next "increase damage.@"

UnnerveDescription:
	db   "Prevents foes from"
	next "eating Berries.@"

DefiantDescription:
	db   "Boosts Attack when"
	next "stats are lowered.@"

CursedBodyDescription:
	db   "May disable a move"
	next "used on it.@"

WeakArmorDescription:
	db   "Physical attacks"
	next "trade Def for Spd.@"

MultiscaleDescription:
	db   "Reduces damage"
	next "when HP is full.@"

HarvestDescription:
	db   "May recreate a"
	next "Berry after use.@"

MoodyDescription:
	db   "Raises a stat and"
	next "lowers another.@"

OvercoatDescription:
	db   "Protects it from"
	next "weather damage.@"

PoisonTouchDescription:
	db   "May poison the foe"
	next "on contact.@"

RegeneratorDescription:
	db   "Restores HP when"
	next "withdrawn.@"

BigPecksDescription:
	db   "Prevents foes from"
	next "lowering Defense.@"

SandRushDescription:
	db   "Boosts Speed in"
	next "a sandstorm.@"

WonderSkinDescription:
	db   "Makes status moves"
	next "miss more often.@"

AnalyticDescription:
	db   "Boosts move power"
	next "when moving last.@"

ImposterDescription:
	db   "Transforms itself"
	next "into the foe.@"

InfiltratorDescription:
	db   "Attacks bypass the"
	next "foe's barriers.@"

MoxieDescription:
	db   "Boosts Attack when"
	next "knocking out foes.@"

JustifiedDescription:
	db   "Boosts Attack when"
	next "hit by Dark moves.@"

RattledDescription:
	db   "Some scary move"
	next "types boost Speed.@"

MagicBounceDescription:
	db   "Reflects status-"
	next "changing moves.@"

SapSipperDescription:
	db   "Boosts Attack when"
	next "hit by Grass.@"

PranksterDescription:
	db   "Gives priority to"
	next "a status move.@"

SandForceDescription:
	db   "Boosts some moves"
	next "in a sandstorm.@"

FurCoatDescription:
	db   "Halves damage from"
	next "physical moves.@"

CompetitiveDescription:
	db   "Boosts Spcl.Atk on"
	next "stat reduction.@"

PixilateDescription:
	db   "Normal-type moves"
	next "become Fairy-type.@"

TanglingHairDescription:
	db   "Contact may lower"
	next "the foe's Speed.@"
