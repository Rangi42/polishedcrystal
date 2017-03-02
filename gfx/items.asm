UpdateItemIconAndDescription::
	farcall UpdateItemDescription
	ld hl, ItemIconPointers
	ld a, [CurSpecies]
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, VTiles2 tile $1c
	lb bc, BANK(NoItemIcon), $9
	call DecompressRequest2bpp
	farcall LoadItemIconPalette
	call SetPalettes
	call WaitBGMap
	ret

ItemIconPointers:
	dw NoItemIcon
	dw PokeBallIcon
	dw GreatBallIcon
	dw UltraBallIcon
	dw MasterBallIcon
	dw SafariBallIcon
	dw LevelBallIcon
	dw LureBallIcon
	dw MoonBallIcon
	dw FriendBallIcon
	dw FastBallIcon
	dw HeavyBallIcon
	dw LoveBallIcon
	dw ParkBallIcon
	dw RepeatBallIcon
	dw TimerBallIcon
	dw NestBallIcon
	dw NetBallIcon
	dw DiveBallIcon
	dw LuxuryBallIcon
	dw HealBallIcon
	dw QuickBallIcon
	dw DuskBallIcon
	dw PremierBallIcon
	dw CherishBallIcon
	dw PotionIcon
	dw SuperPotionIcon
	dw HyperPotionIcon
	dw MaxPotionIcon
	dw AntidoteIcon
	dw BurnHealIcon
	dw ParlyzHealIcon
	dw AwakeningIcon
	dw IceHealIcon
	dw FullHealIcon
	dw FullRestoreIcon
	dw ReviveIcon
	dw MaxReviveIcon
	dw EtherIcon
	dw MaxEtherIcon
	dw ElixirIcon
	dw MaxElixirIcon
	dw HPUpIcon
	dw ProteinIcon
	dw IronIcon
	dw CarbosIcon
	dw CalciumIcon
	dw ZincIcon
	dw RareCandyIcon
	dw PPUpIcon
	dw PPMaxIcon
	dw FreshWaterIcon
	dw SodaPopIcon
	dw LemonadeIcon
	dw MoomooMilkIcon
	dw RageCandyBarIcon
	dw SacredAshIcon
	dw EnergyPowderIcon
	dw EnergyRootIcon
	dw HealPowderIcon
	dw RevivalHerbIcon
	dw XAttackIcon
	dw XDefendIcon
	dw XSpeedIcon
	dw XSpclAtkIcon
	dw XSpclDefIcon
	dw DireHitIcon
	dw GuardSpecIcon
	dw XAccuracyIcon
	dw RepelIcon
	dw SuperRepelIcon
	dw MaxRepelIcon
	dw EscapeRopeIcon
	dw PokeDollIcon
	dw AbilityCapIcon
	dw LeafStoneIcon
	dw FireStoneIcon
	dw WaterStoneIcon
	dw ThunderStoneIcon
	dw MoonStoneIcon
	dw SunStoneIcon
	dw DuskStoneIcon
	dw ShinyStoneIcon
	dw IceStoneIcon
	dw EverstoneIcon
	dw BicycleIcon
	dw OldRodIcon
	dw GoodRodIcon
	dw SuperRodIcon
	dw CoinCaseIcon
	dw ItemfinderIcon
	dw ExpShareIcon
	dw MysteryEggIcon
	dw SquirtBottleIcon
	dw SecretPotionIcon
	dw RedScaleIcon
	dw CardKeyIcon
	dw BasementKeyIcon
	dw SSTicketIcon
	dw PassIcon
	dw MachinePartIcon
	dw LostItemIcon
	dw RainbowWingIcon
	dw SilverWingIcon
	dw ClearBellIcon
	dw GSBallIcon
	dw BlueCardIcon
	dw OrangeTicketIcon
	dw MysticTicketIcon
	dw OldSeaMapIcon
	dw ShinyCharmIcon
	dw OvalCharmIcon
	dw SilphScope2Icon
	dw OranBerryIcon
	dw SitrusBerryIcon
	dw PechaBerryIcon
	dw RawstBerryIcon
	dw CheriBerryIcon
	dw ChestoBerryIcon
	dw AspearBerryIcon
	dw PersimBerryIcon
	dw LumBerryIcon
	dw LeppaBerryIcon
	dw PomegBerryIcon
	dw KelpsyBerryIcon
	dw QualotBerryIcon
	dw HondewBerryIcon
	dw GrepaBerryIcon
	dw TamatoBerryIcon
	dw RedApricornIcon
	dw BluApricornIcon
	dw YlwApricornIcon
	dw GrnApricornIcon
	dw WhtApricornIcon
	dw BlkApricornIcon
	dw PnkApricornIcon
	dw SilkScarfIcon
	dw BlackBeltIcon
	dw SharpBeakIcon
	dw PoisonBarbIcon
	dw SoftSandIcon
	dw HardStoneIcon
	dw SilverPowderIcon
	dw SpellTagIcon
	dw MetalCoatIcon
	dw CharcoalIcon
	dw MysticWaterIcon
	dw MiracleSeedIcon
	dw MagnetIcon
	dw TwistedSpoonIcon
	dw NeverMeltIceIcon
	dw DragonFangIcon
	dw BlackGlassesIcon
	dw PinkBowIcon
	dw BrightPowderIcon
	dw ScopeLensIcon
	dw QuickClawIcon
	dw KingsRockIcon
	dw FocusBandIcon
	dw LeftoversIcon
	dw LuckyEggIcon
	dw AmuletCoinIcon
	dw CleanseTagIcon
	dw SmokeBallIcon
	dw BerserkGeneIcon
	dw LightBallIcon
	dw StickIcon
	dw ThickClubIcon
	dw LuckyPunchIcon
	dw MetalPowderIcon
	dw QuickPowderIcon
	dw ArmorSuitIcon
	dw AirBalloonIcon
	dw AssaultVestIcon
	dw BigRootIcon
	dw BindingBandIcon
	dw DestinyKnotIcon
	dw EvioliteIcon
	dw ExpertBeltIcon
	dw FocusSashIcon
	dw GripClawIcon
	dw LifeOrbIcon
	dw LightClayIcon
	dw MetronomeIIcon
	dw MuscleBandIcon
	dw ProtectPadsIcon
	dw RockyHelmetIcon
	dw SafeGogglesIcon
	dw ShedShellIcon
	dw ShellBellIcon
	dw SootheBellIcon
	dw WeakPolicyIcon
	dw WideLensIcon
	dw WiseGlassesIcon
	dw ZoomLensIcon
	dw MentalHerbIcon
	dw PowerHerbIcon
	dw WhiteHerbIcon
	dw DampRockIcon
	dw HeatRockIcon
	dw SmoothRockIcon
	dw IcyRockIcon
	dw ChoiceBandIcon
	dw ChoiceScarfIcon
	dw ChoiceSpecsIcon
	dw FlameOrbIcon
	dw ToxicOrbIcon
	dw BlackSludgeIcon
	dw MachoBraceIcon
	dw PowerWeightIcon
	dw PowerBracerIcon
	dw PowerBeltIcon
	dw PowerLensIcon
	dw PowerBandIcon
	dw PowerAnkletIcon
	dw DragonScaleIcon
	dw UpGradeIcon
	dw DubiousDiscIcon
	dw ProtectorIcon
	dw ElectirizerIcon
	dw MagmarizerIcon
	dw RazorFangIcon
	dw RazorClawIcon
	dw OddSouvenirIcon
	dw NuggetIcon
	dw BigNuggetIcon
	dw TinyMushroomIcon
	dw BigMushroomIcon
	dw BalmMushroomIcon
	dw PearlIcon
	dw BigPearlIcon
	dw PearlStringIcon
	dw StardustIcon
	dw StarPieceIcon
	dw BrickPieceIcon
	dw RareBoneIcon
	dw SilverLeafIcon
	dw GoldLeafIcon
	dw SlowpokeTailIcon
	dw BottleCapIcon
	dw HelixFossilIcon
	dw DomeFossilIcon
	dw OldAmberIcon
	dw MulchIcon
	dw SweetHoneyIcon
	dw FlowerMailIcon
	dw SurfMailIcon
	dw LiteBlueMailIcon
	dw PortraitMailIcon
	dw LovelyMailIcon
	dw EonMailIcon
	dw MorphMailIcon
	dw BlueSkyMailIcon
	dw MusicMailIcon
	dw MirageMailIcon
	dw NoItemIcon


SECTION "Item Icons 1", ROMX, BANK[$41]

NoItemIcon:       INCBIN "gfx/items/no_item.2bpp.lz"
PokeBallIcon:     INCBIN "gfx/items/poke_ball.2bpp.lz"
GreatBallIcon:    INCBIN "gfx/items/great_ball.2bpp.lz"
UltraBallIcon:    INCBIN "gfx/items/ultra_ball.2bpp.lz"
MasterBallIcon:   INCBIN "gfx/items/master_ball.2bpp.lz"
SafariBallIcon:   INCBIN "gfx/items/safari_ball.2bpp.lz"
LevelBallIcon:    INCBIN "gfx/items/level_ball.2bpp.lz"
LureBallIcon:     INCBIN "gfx/items/lure_ball.2bpp.lz"
MoonBallIcon:     INCBIN "gfx/items/moon_ball.2bpp.lz"
FriendBallIcon:   INCBIN "gfx/items/friend_ball.2bpp.lz"
FastBallIcon:     INCBIN "gfx/items/fast_ball.2bpp.lz"
HeavyBallIcon:    INCBIN "gfx/items/heavy_ball.2bpp.lz"
LoveBallIcon:     INCBIN "gfx/items/love_ball.2bpp.lz"
ParkBallIcon:     INCBIN "gfx/items/park_ball.2bpp.lz"
RepeatBallIcon:   INCBIN "gfx/items/repeat_ball.2bpp.lz"
TimerBallIcon:    INCBIN "gfx/items/timer_ball.2bpp.lz"
NestBallIcon:     INCBIN "gfx/items/nest_ball.2bpp.lz"
NetBallIcon:      INCBIN "gfx/items/net_ball.2bpp.lz"
DiveBallIcon:     INCBIN "gfx/items/dive_ball.2bpp.lz"
LuxuryBallIcon:   INCBIN "gfx/items/luxury_ball.2bpp.lz"
HealBallIcon:     INCBIN "gfx/items/heal_ball.2bpp.lz"
QuickBallIcon:    INCBIN "gfx/items/quick_ball.2bpp.lz"
DuskBallIcon:     INCBIN "gfx/items/dusk_ball.2bpp.lz"
PremierBallIcon:  INCBIN "gfx/items/premier_ball.2bpp.lz"
CherishBallIcon:  INCBIN "gfx/items/cherish_ball.2bpp.lz"
PotionIcon:
SuperPotionIcon:
HyperPotionIcon:  INCBIN "gfx/items/potion.2bpp.lz"
MaxPotionIcon:
FullRestoreIcon:  INCBIN "gfx/items/max_potion.2bpp.lz"
AntidoteIcon:
BurnHealIcon:
ParlyzHealIcon:
AwakeningIcon:
IceHealIcon:      INCBIN "gfx/items/antidote.2bpp.lz"
FullHealIcon:     INCBIN "gfx/items/full_heal.2bpp.lz"
ReviveIcon:       INCBIN "gfx/items/revive.2bpp.lz"
MaxReviveIcon:    INCBIN "gfx/items/max_revive.2bpp.lz"
EtherIcon:
MaxEtherIcon:
ElixirIcon:
MaxElixirIcon:    INCBIN "gfx/items/ether.2bpp.lz"
HPUpIcon:         INCBIN "gfx/items/hp_up.2bpp.lz"
ProteinIcon:
IronIcon:
CarbosIcon:
CalciumIcon:
ZincIcon:         INCBIN "gfx/items/vitamin.2bpp.lz"
RareCandyIcon:    INCBIN "gfx/items/rare_candy.2bpp.lz"
PPUpIcon:         INCBIN "gfx/items/pp_up.2bpp.lz"
PPMaxIcon:        INCBIN "gfx/items/pp_max.2bpp.lz"
FreshWaterIcon:   INCBIN "gfx/items/fresh_water.2bpp.lz"
SodaPopIcon:      INCBIN "gfx/items/soda_pop.2bpp.lz"
LemonadeIcon:     INCBIN "gfx/items/lemonade.2bpp.lz"
MoomooMilkIcon:   INCBIN "gfx/items/moomoo_milk.2bpp.lz"
RageCandyBarIcon: INCBIN "gfx/items/ragecandybar.2bpp.lz"
SacredAshIcon:
SoftSandIcon:
BrightPowderIcon:
MetalPowderIcon:
QuickPowderIcon:
StardustIcon:     INCBIN "gfx/items/sand.2bpp.lz"
EnergyPowderIcon:
HealPowderIcon:
SilverPowderIcon: INCBIN "gfx/items/powder.2bpp.lz"
EnergyRootIcon:   INCBIN "gfx/items/energy_root.2bpp.lz"
RevivalHerbIcon:  INCBIN "gfx/items/revival_herb.2bpp.lz"
XAttackIcon:
XDefendIcon:
XSpeedIcon:
XSpclAtkIcon:
XSpclDefIcon:
DireHitIcon:
GuardSpecIcon:
XAccuracyIcon:    INCBIN "gfx/items/battle_item.2bpp.lz"
RepelIcon:
SuperRepelIcon:
MaxRepelIcon:     INCBIN "gfx/items/repel.2bpp.lz"
EscapeRopeIcon:   INCBIN "gfx/items/escape_rope.2bpp.lz"
PokeDollIcon:     INCBIN "gfx/items/poke_doll.2bpp.lz"
AbilityCapIcon:   INCBIN "gfx/items/ability_cap.2bpp.lz"
LeafStoneIcon:    INCBIN "gfx/items/leaf_stone.2bpp.lz"
FireStoneIcon:    INCBIN "gfx/items/fire_stone.2bpp.lz"
WaterStoneIcon:   INCBIN "gfx/items/water_stone.2bpp.lz"
ThunderStoneIcon: INCBIN "gfx/items/thunderstone.2bpp.lz"
MoonStoneIcon:    INCBIN "gfx/items/moon_stone.2bpp.lz"
SunStoneIcon:     INCBIN "gfx/items/sun_stone.2bpp.lz"
DuskStoneIcon:    INCBIN "gfx/items/dusk_stone.2bpp.lz"
ShinyStoneIcon:   INCBIN "gfx/items/shiny_stone.2bpp.lz"
IceStoneIcon:     INCBIN "gfx/items/ice_stone.2bpp.lz"
EverstoneIcon:    INCBIN "gfx/items/everstone.2bpp.lz"
BicycleIcon:      INCBIN "gfx/items/bicycle.2bpp.lz"
OldRodIcon:       INCBIN "gfx/items/old_rod.2bpp.lz"
GoodRodIcon:      INCBIN "gfx/items/good_rod.2bpp.lz"
SuperRodIcon:     INCBIN "gfx/items/super_rod.2bpp.lz"
CoinCaseIcon:     INCBIN "gfx/items/coin_case.2bpp.lz"
ItemfinderIcon:   INCBIN "gfx/items/itemfinder.2bpp.lz"
ExpShareIcon:     INCBIN "gfx/items/exp_share.2bpp.lz"
MysteryEggIcon:   INCBIN "gfx/items/mystery_egg.2bpp.lz"
SquirtBottleIcon: INCBIN "gfx/items/squirtbottle.2bpp.lz"
SecretPotionIcon: INCBIN "gfx/items/secretpotion.2bpp.lz"
RedScaleIcon:     INCBIN "gfx/items/red_scale.2bpp.lz"
CardKeyIcon:      INCBIN "gfx/items/card_key.2bpp.lz"
BasementKeyIcon:  INCBIN "gfx/items/basement_key.2bpp.lz"
SSTicketIcon:     INCBIN "gfx/items/s_s_ticket.2bpp.lz"
PassIcon:         INCBIN "gfx/items/pass.2bpp.lz"
MachinePartIcon:  INCBIN "gfx/items/machine_part.2bpp.lz"
LostItemIcon:     INCBIN "gfx/items/lost_item.2bpp.lz"
RainbowWingIcon:  INCBIN "gfx/items/rainbow_wing.2bpp.lz"
SilverWingIcon:   INCBIN "gfx/items/silver_wing.2bpp.lz"
ClearBellIcon:    INCBIN "gfx/items/clear_bell.2bpp.lz"
GSBallIcon:       INCBIN "gfx/items/gs_ball.2bpp.lz"
BlueCardIcon:     INCBIN "gfx/items/blue_card.2bpp.lz"
OrangeTicketIcon: INCBIN "gfx/items/orangeticket.2bpp.lz"
MysticTicketIcon: INCBIN "gfx/items/mysticticket.2bpp.lz"
OldSeaMapIcon:    INCBIN "gfx/items/old_sea_map.2bpp.lz"
ShinyCharmIcon:   INCBIN "gfx/items/shiny_charm.2bpp.lz"
OvalCharmIcon:    INCBIN "gfx/items/oval_charm.2bpp.lz"

SilphScope2Icon:
OranBerryIcon:
SitrusBerryIcon:
PechaBerryIcon:
RawstBerryIcon:
CheriBerryIcon:
ChestoBerryIcon:
AspearBerryIcon:
PersimBerryIcon:
LumBerryIcon:
LeppaBerryIcon:
PomegBerryIcon:
KelpsyBerryIcon:
QualotBerryIcon:
HondewBerryIcon:
GrepaBerryIcon:
TamatoBerryIcon:

RedApricornIcon:
BluApricornIcon:
YlwApricornIcon:
GrnApricornIcon:
WhtApricornIcon:
BlkApricornIcon:
PnkApricornIcon:  INCBIN "gfx/items/apricorn.2bpp.lz"
SilkScarfIcon:
ChoiceScarfIcon:  INCBIN "gfx/items/scarf.2bpp.lz"

BlackBeltIcon:
SharpBeakIcon:
PoisonBarbIcon:
HardStoneIcon:
SpellTagIcon:
MetalCoatIcon:
CharcoalIcon:
MysticWaterIcon:
MiracleSeedIcon:
MagnetIcon:
TwistedSpoonIcon:
NeverMeltIceIcon:
DragonFangIcon:
BlackGlassesIcon:
PinkBowIcon:
ScopeLensIcon:
QuickClawIcon:
KingsRockIcon:
FocusBandIcon:
LeftoversIcon:
LuckyEggIcon:
AmuletCoinIcon:
CleanseTagIcon:
SmokeBallIcon:
BerserkGeneIcon:
LightBallIcon:
StickIcon:
ThickClubIcon:
LuckyPunchIcon:
ArmorSuitIcon:
AirBalloonIcon:
AssaultVestIcon:
BigRootIcon:
BindingBandIcon:
DestinyKnotIcon:
EvioliteIcon:
ExpertBeltIcon:
FocusSashIcon:
GripClawIcon:
LifeOrbIcon:
LightClayIcon:
MetronomeIIcon:
MuscleBandIcon:
ProtectPadsIcon:
RockyHelmetIcon:
SafeGogglesIcon:
ShedShellIcon:
ShellBellIcon:
SootheBellIcon:
WeakPolicyIcon:
WideLensIcon:
WiseGlassesIcon:
ZoomLensIcon:

MentalHerbIcon:
PowerHerbIcon:
WhiteHerbIcon:
SilverLeafIcon:
GoldLeafIcon:     INCBIN "gfx/items/leaf.2bpp.lz"

DampRockIcon:
HeatRockIcon:
SmoothRockIcon:
IcyRockIcon:
ChoiceBandIcon:
ChoiceSpecsIcon:
FlameOrbIcon:
ToxicOrbIcon:
BlackSludgeIcon:
MachoBraceIcon:
PowerWeightIcon:
PowerBracerIcon:
PowerBeltIcon:
PowerLensIcon:
PowerBandIcon:
PowerAnkletIcon:
DragonScaleIcon:
UpGradeIcon:
DubiousDiscIcon:
ProtectorIcon:
ElectirizerIcon:
MagmarizerIcon:
RazorFangIcon:
RazorClawIcon:
OddSouvenirIcon:
NuggetIcon:
BigNuggetIcon:
TinyMushroomIcon:
BigMushroomIcon:
BalmMushroomIcon:
PearlIcon:
BigPearlIcon:
PearlStringIcon:
StarPieceIcon:

BrickPieceIcon:   INCBIN "gfx/items/brick_piece.2bpp.lz"

RareBoneIcon:
SlowpokeTailIcon:
BottleCapIcon:
HelixFossilIcon:
DomeFossilIcon:
OldAmberIcon:
MulchIcon:
SweetHoneyIcon:
FlowerMailIcon:
SurfMailIcon:
LiteBlueMailIcon:
PortraitMailIcon:
LovelyMailIcon:
EonMailIcon:
MorphMailIcon:
BlueSkyMailIcon:
MusicMailIcon:
MirageMailIcon: INCBIN "gfx/items/no_item.2bpp.lz"

;SECTION "Item Icons 2", ROMX, BANK[$43]
