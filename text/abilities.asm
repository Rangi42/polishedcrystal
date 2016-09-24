GetAbility:
; b is Spe+Spc DV, c is species
; returns ability in b
	ld a, c
	ld [CurSpecies], a
	call GetBaseData
	ld a, b
	swap a
	xor b
	and $f
	jr z, .hidden_abil
	and 1
	jr nz, .second_abil
	ld a, [BaseAbility1]
	ld b, a
	ret
.second_abil
	ld a, [BaseAbility2]
	ld b, a
	ret
.hidden_abil
	ld a, [BaseHiddenAbility]
	ld b, a
	ret

PrintAbility:
; Print ability b at hl.
	ld a, b

	push hl
	add a
	ld hl, AbilityNames
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	pop hl

	jp PlaceString


AbilityNames:
	dw Stench, Drizzle, SpeedBoost, BattleArmor, Sturdy, Damp
	dw Limber, SandVeil, Static, VoltAbsorb, WaterAbsorb, Oblivious
	dw CloudNine, CompoundEyes, Insomnia, Immunity, FlashFire, ShieldDust
	dw OwnTempo, SuctionCups, Intimidate, ShadowTag, Levitate, EffectSpore
	dw Synchronize, ClearBody, NaturalCure, LightningRod, SereneGrace, SwiftSwim
	dw Clorophyll, Illuminate, Trace, HugePower, PoisonPoint, InnerFocus
	dw MagmaArmor, WaterVeil, MagnetPull, Soundproof, RainDish, SandStream
	dw Pressure, ThickFat, EarlyBird, FlameBody, RunAway, KeenEye
	dw HyperCutter, Pickup, Hustle, CuteCharm, StickyHold, ShedSkin
	dw Guts, MarvelScale, LiquidOoze, Overgrow, Blaze, Torrent
	dw Swarm, RockHead, Drought, ArenaTrap, VitalSpirit, ShellArmor
	dw TangledFeet, MotorDrive, Rivalry, Steadfast, SnowCloak, AngerPoint
	dw Unburden, DrySkin, Download, IronFist, PoisonHeal, Adaptability
	dw SkillLink, Hydration, SolarPower, QuickFeet, Sniper, MagicGuard
	dw NoGuard, Technician, LeafGuard, MoldBreaker, SuperLuck, Aftermath
	dw Anticipation, Forewarn, Unaware, TintedLens, Filter, Scrappy
	dw IceBody, SolidRock, Frisk, Reckless, Pickpocket, SheerForce
	dw Contrary, Unnerve, Defiant, WeakArmor, Multiscale, Harvest
	dw Moody, Overcoat, PoisonTouch, Regenerator, BigPecks, SandRush
	dw WonderSkin, Analytic, Imposter, Infiltrator, Moxie, Justified
	dw Rattled, MagicBounce, SapSipper, Prankster, SandForce, Competitive
	dw Pixilate

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
Clorophyll:    db "Clorophyll@"
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
Frisk:         db "Frisk@"
Reckless:      db "Reckless@"
Pickpocket:    db "Pickpocket@"
SheerForce:    db "Sheer Force@"
Contrary:      db "Contrary@"
Unnerve:       db "Unnerve@"
Defiant:       db "Defiant@"
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
Competitive:   db "Competitive@"
Pixilate:      db "Pixilate@"

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

AbilityDescriptions: ; TODO: is there a saner way to do this
	dw StenchDescription, DrizzleDescription, SpeedBoostDescription
	dw BattleArmorDescription, SturdyDescription, DampDescription
	dw LimberDescription, SandVeilDescription, StaticDescription
	dw VoltAbsorbDescription, WaterAbsorbDescription, ObliviousDescription
	dw CloudNineDescription, CompoundEyesDescription, InsomniaDescription
	dw ImmunityDescription, FlashFireDescription, ShieldDustDescription
	dw OwnTempoDescription, SuctionCupsDescription, IntimidateDescription
	dw ShadowTagDescription, LevitateDescription, EffectSporeDescription
	dw SynchronizeDescription, ClearBodyDescription, NaturalCureDescription
	dw LightningRodDescription, SereneGraceDescription, SwiftSwimDescription
	dw ClorophyllDescription, IlluminateDescription, TraceDescription
	dw HugePowerDescription, PoisonPointDescription, InnerFocusDescription
	dw MagmaArmorDescription, WaterVeilDescription, MagnetPullDescription
	dw SoundproofDescription, RainDishDescription, SandStreamDescription
	dw PressureDescription, ThickFatDescription, EarlyBirdDescription
	dw FlameBodyDescription, RunAwayDescription, KeenEyeDescription
	dw HyperCutterDescription, PickupDescription, HustleDescription
	dw CuteCharmDescription, StickyHoldDescription, ShedSkinDescription
	dw GutsDescription, MarvelScaleDescription, LiquidOozeDescription
	dw OvergrowDescription, BlazeDescription, TorrentDescription
	dw SwarmDescription, RockHeadDescription, DroughtDescription
	dw ArenaTrapDescription, VitalSpiritDescription, ShellArmorDescription
	dw TangledFeetDescription, MotorDriveDescription, RivalryDescription
	dw SteadfastDescription, SnowCloakDescription, AngerPointDescription
	dw UnburdenDescription, DrySkinDescription, DownloadDescription
	dw IronFistDescription, PoisonHealDescription, AdaptabilityDescription
	dw SkillLinkDescription, HydrationDescription, SolarPowerDescription
	dw QuickFeetDescription, SniperDescription, MagicGuardDescription
	dw NoGuardDescription, TechnicianDescription, LeafGuardDescription
	dw MoldBreakerDescription, SuperLuckDescription, AftermathDescription
	dw AnticipationDescription, ForewarnDescription, UnawareDescription
	dw TintedLensDescription, FilterDescription, ScrappyDescription
	dw IceBodyDescription, SolidRockDescription, FriskDescription
	dw RecklessDescription, PickpocketDescription, SheerForceDescription
	dw ContraryDescription, UnnerveDescription, DefiantDescription
	dw WeakArmorDescription, MultiscaleDescription, HarvestDescription
	dw MoodyDescription, OvercoatDescription, PoisonTouchDescription
	dw RegeneratorDescription, BigPecksDescription, SandRushDescription
	dw WonderSkinDescription, AnalyticDescription, ImposterDescription
	dw InfiltratorDescription, MoxieDescription, JustifiedDescription
	dw RattledDescription, MagicBounceDescription, SapSipperDescription
	dw PranksterDescription, SandForceDescription, CompetitiveDescription
	dw PixilateDescription

StenchDescription:
	db "May cause the foe"
	next "to flinch.@"

DrizzleDescription:
	db "Summons rain when"
	next "switched in.@"

SpeedBoostDescription:
	db "Boosts Speed on"
	next "each turn's end.@"

BattleArmorDescription:
ShellArmorDescription:
	db "Protects from"
	next "critical hits.@"

SturdyDescription:
	db "Prevents knock-out"
	next "from full health.@"

DampDescription:
	db "Prevents usage of"
	next "self-destruction.@"

LimberDescription:
	db "Protects against"
	next "paralysis.@"

SandVeilDescription:
	db "Boosts evasion"
	next "during sandstorms.@"

StaticDescription:
	db "May paralyse foes"
	next "on contact.@"

VoltAbsorbDescription:
	db "Recovers HP from"
	next "electric moves.@"

WaterAbsorbDescription:
	db "Recovers HP if hit"
	next "by water moves.@"

ObliviousDescription:
	db "Ignores taunts"
	next "and infatuation.@"

CloudNineDescription:
	db "Negates weather on"
	next "being switched in.@"

CompoundEyesDescription:
	db "Boosts accuracy of"
	next "moves.@"

InsomniaDescription:
VitalSpiritDescription:
	db "Prevents sleep.@"

ImmunityDescription:
	db "Prevents"
	next "poisoning.@"

FlashFireDescription:
	db "Ups Fire power if"
	next "hit by fire.@"

ShieldDustDescription:
	db "Blocks additional"
	next "attack effects.@"

OwnTempoDescription:
	db "Prevents"
	next "confusion.@"

SuctionCupsDescription:
	db "Negates forced"
	next "switch-outs.@"

IntimidateDescription:
	db "Lowers a foe's"
	next "attack stat.@"

ShadowTagDescription:
	db "Prevents non-Ghost"
	next "foes escaping.@"

LevitateDescription:
	db "Gives immunity to"
	next "Ground-type moves.@"

EffectSporeDescription:
	db "Contact may cause"
	next "status ailments.@"

SynchronizeDescription:
	db "Passes on status"
	next "ailments to foes.@"

ClearBodyDescription:
	db "Prevents foes from"
	next "lowering stats.@"

NaturalCureDescription:
	db "Switch-outs heal"
	next "status ailments.@"

LightningRodDescription:
	db "Electric moves"
	next "raises Spcl.Atk.@"

SereneGraceDescription:
	db "Doubles rate of"
	next "added effects.@"

SwiftSwimDescription:
	db "Doubles speed"
	next "during rain.@"

ClorophyllDescription:
	db "Doubles speed"
	next "during sunshine.@"

IlluminateDescription:
	db "Doubles the rate"
	next "of wild Pokémon.@"

TraceDescription:
	db "Copies the foe's"
	next "special ability.@"

HugePowerDescription:
	db "Doubles the Attack"
	next "stat.@"

PoisonPointDescription:
	db "May poison the foe"
	next "on contact.@"

InnerFocusDescription:
	db "Prevents flinches.@"

MagmaArmorDescription:
	db "Prevents freezes"
	next "and hastens Eggs.@"

WaterVeilDescription:
	db "Increases evasion"
	next "during rain.@"

MagnetPullDescription:
	db "Prevents escape by"
	next "Steel-type foes.@"

SoundproofDescription:
	db "Grants immunity to"
	next "sound moves.@"

RainDishDescription:
	db "Gradually recovers"
	next "health in rain.@"

SandStreamDescription:
	db "Summons sandstorm"
	next "when switched in.@"

PressureDescription:
	db "Doubles the foe's"
	next "PP usage.@"

ThickFatDescription:
	db "Halves damage from"
	next "fire and ice.@"

EarlyBirdDescription:
	db "Causes rapid wake-"
	next "up from sleep.@"

FlameBodyDescription:
	db "Hits burn foes,"
	next "also hastens Eggs.@"

RunAwayDescription:
	db "Gurantees running"
	next "away successfully.@"

KeenEyeDescription:
	db "Prevents foes from"
	next "lowering accuracy.@"

HyperCutterDescription:
	db "Prevents foes from"
	next "lowering Attack.@"

PickupDescription:
	db "May pickup items"
	next "after battles.@"

HustleDescription:
	db "Boosts Attack, but"
	next "lowers accuracy.@"

CuteCharmDescription:
	db "Contact may cause"
	next "infatuation.@"

StickyHoldDescription:
	db "Prevents item"
	next "theft.@"

ShedSkinDescription:
	db "Occasionally heals"
	next "status ailments.@"

GutsDescription:
	db "Boosts Attack on"
	next "status conditions.@"

MarvelScaleDescription:
	db "Boosts Defense on"
	next "status conditions.@"

LiquidOozeDescription:
	db "Injures foes using"
	next "draining moves.@"

OvergrowDescription:
	db "Boosts Grass moves"
	next "in a pinch.@"

BlazeDescription:
	db "Boosts Fire moves"
	next "in a pinch.@"

TorrentDescription:
	db "Boosts Water moves"
	next "in a pinch.@"

SwarmDescription:
	db "Boosts Bug moves"
	next "in a pinch.@"

RockHeadDescription:
	db "Prevents recoil"
	next "except Struggle.@"

DroughtDescription:
	db "Summons harsh"
	next "sunlight.@"

ArenaTrapDescription:
	db "Prevents grounded"
	next "foes from escape.@"

TangledFeetDescription:
	db "Boosts evasiveness"
	next "on confusion.@"

MotorDriveDescription:
	db "Electric moves"
	next "raises Speed.@"

RivalryDescription:
	db "Raises Attack if"
	next "foes gender match.@"

SteadfastDescription:
	db "Raises Speed when"
	next "flinching.@"

SnowCloakDescription:
	db "Raises evasion in"
	next "hailstorms.@"

AngerPointDescription:
	db "Maxes Attack after"
	next "a critical hit.@"

UnburdenDescription:
	db "Doubles Speed when"
	next "losing held items.@"

DrySkinDescription:
	db "Water heals, heat"
	next "damages.@"

DownloadDescription:
	db "Ups power based on"
	next "foes' abilities.@"

IronFistDescription:
	db "Boosts power of"
	next "punch-based moves.@"

PoisonHealDescription:
	db "Recovers health"
	next "when poisoned.@"

AdaptabilityDescription:
	db "Powers up same-"
	next "type moves more.@"

SkillLinkDescription:
	db "Multi-hit moves"
	next "strike 5 times.@"

HydrationDescription:
	db "Heals status"
	next "ailments on rain.@"

SolarPowerDescription:
	db "Trades HP in sun"
	next "for Spcl.Atk.@"

QuickFeetDescription:
	db "Boosts Speed on"
	next "status conditions.@"

SniperDescription:
	db "Increases damage"
	next "of critical hits.@"

MagicGuardDescription:
	db "Prevents most"
	next "indirect damage.@"

NoGuardDescription:
	db "Gurantees own and"
	next "foe moves to hit.@"

TechnicianDescription:
	db "Powers up weaker"
	next "moves.@"

LeafGuardDescription:
	db "Prevents status"
	next "conditions in sun.@"

MoldBreakerDescription:
	db "Bypasses defensive"
	next "abilities.@"

SuperLuckDescription:
	db "Increases the rate"
	next "of critical hits.@"

AftermathDescription:
	db "Damages the foe on"
	next "fainting.@"

AnticipationDescription:
	db "Alerts the user to"
	next "dangerous moves.@"

ForewarnDescription:
	db "Senses foes' most"
	next "powerful move.@"

UnawareDescription:
	db "Ignores changes to"
	next "stats.@"

TintedLensDescription:
	db "Doubles not very"
	next "effective moves.@"

FilterDescription:
SolidRockDescription:
	db "Halves foes' super"
	next "effective moves.@"

ScrappyDescription:
	db "Allows any move to"
	next "hit Ghosts-types.@"

IceBodyDescription:
	db "Gradually recovers"
	next "health in hail.@"

FriskDescription:
	db "Senses foes' held"
	next "item.@"

RecklessDescription:
	db "Powers up moves"
	next "that have recoil.@"

PickpocketDescription:
	db "Steals foes' item"
	next "when attacked.@"

SheerForceDescription:
	db "Trades additional"
	next "effects for power.@"

ContraryDescription:
	db "Inverts changes to"
	next "stats.@"

UnnerveDescription:
	db "Prevents foes from"
	next "consuming Berries.@"

DefiantDescription:
	db "On stat reduction,"
	next "raise Attack.@"

WeakArmorDescription:
	db "Physical moves add"
	next "Speed for defense.@"

MultiscaleDescription:
	db "Reduces damage"
	next "when HP is full.@"

HarvestDescription:
	db "Recreates used up"
	next "Berries over time.@"

MoodyDescription:
	db "Raises a stat and"
	next "lowers another.@"

OvercoatDescription:
	db "Protects from"
	next "weather damage.@"

PoisonTouchDescription:
	db "May poison foes on"
	next "attacking.@"

RegeneratorDescription:
	db "Recovers health on"
	next "switching out.@"

BigPecksDescription:
	db "Prevents foes from"
	next "reducing Defense.@"

SandRushDescription:
	db "Boosts Speed in"
	next "sandstorms.@"

WonderSkinDescription:
	db "Makes status moves"
	next "hit half as often.@"

AnalyticDescription:
	db "Power is boosted"
	next "when moving last.@"

ImposterDescription:
	db "Transforms into"
	next "foes instantly.@"

InfiltratorDescription:
	db "Moves bypass enemy"
	next "decoys or shields.@"

MoxieDescription:
	db "Raises Attack when"
	next "knocking out foes.@"

JustifiedDescription:
	db "Raises Attack when"
	next "hit by Dark moves.@"

RattledDescription:
	db "Bug, Ghost or Dark"
	next "moves boost Speed.@"

MagicBounceDescription:
	db "Reflects offensive"
	next "Status moves.@"

SapSipperDescription:
	db "Recovers HP if hit"
	next "by Grass moves.@"

PranksterDescription:
	db "Increases priority"
	next "of status moves.@"

SandForceDescription:
	db "Ups Ground, Rock"
	next "and Steel in sand.@"

CompetitiveDescription:
	db "On stat reduction,"
	next "raise Spcl.Atk.@"

PixilateDescription:
	db "Changes Normal to"
	next "Fairy and powerup.@"
