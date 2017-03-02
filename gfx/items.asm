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

NestBallIcon:
NetBallIcon:
DiveBallIcon:
LuxuryBallIcon:
HealBallIcon:
QuickBallIcon:
DuskBallIcon:
PremierBallIcon:
CherishBallIcon:

PotionIcon:
SuperPotionIcon:
HyperPotionIcon:  INCBIN "gfx/items/potion.2bpp.lz"

MaxPotionIcon:

AntidoteIcon:
BurnHealIcon:
ParlyzHealIcon:
AwakeningIcon:
IceHealIcon:      INCBIN "gfx/items/antidote.2bpp.lz"
FullHealIcon:     INCBIN "gfx/items/full_heal.2bpp.lz"

FullRestoreIcon:

ReviveIcon:       INCBIN "gfx/items/revive.2bpp.lz"
MaxReviveIcon:    INCBIN "gfx/items/max_revive.2bpp.lz"

EtherIcon:
MaxEtherIcon:
ElixirIcon:
MaxElixirIcon:

HPUpIcon:         INCBIN "gfx/items/hp_up.2bpp.lz"
ProteinIcon:
IronIcon:
CarbosIcon:
CalciumIcon:
ZincIcon:         INCBIN "gfx/items/vitamin.2bpp.lz"
RareCandyIcon:    INCBIN "gfx/items/rare_candy.2bpp.lz"
PPUpIcon:         INCBIN "gfx/items/pp_up.2bpp.lz"
PPMaxIcon:        INCBIN "gfx/items/pp_max.2bpp.lz"

FreshWaterIcon:
SodaPopIcon:
LemonadeIcon:
MoomooMilkIcon:
RageCandyBarIcon:
SacredAshIcon:
EnergyPowderIcon:
EnergyRootIcon:
HealPowderIcon:
RevivalHerbIcon:
XAttackIcon:
XDefendIcon:
XSpeedIcon:
XSpclAtkIcon:
XSpclDefIcon:
DireHitIcon:
GuardSpecIcon:
XAccuracyIcon:
RepelIcon:
SuperRepelIcon:
MaxRepelIcon:
EscapeRopeIcon:
PokeDollIcon:
AbilityCapIcon:
LeafStoneIcon:
FireStoneIcon:
WaterStoneIcon:
ThunderStoneIcon:
MoonStoneIcon:
SunStoneIcon:
DuskStoneIcon:
ShinyStoneIcon:
IceStoneIcon:
EverstoneIcon:
BicycleIcon:
OldRodIcon:
GoodRodIcon:
SuperRodIcon:
CoinCaseIcon:
ItemfinderIcon:
ExpShareIcon:
MysteryEggIcon:
SquirtBottleIcon:
SecretPotionIcon:
RedScaleIcon:
CardKeyIcon:
BasementKeyIcon:
SSTicketIcon:
PassIcon:
MachinePartIcon:
LostItemIcon:
RainbowWingIcon:
SilverWingIcon:
ClearBellIcon:
GSBallIcon:
BlueCardIcon:
OrangeTicketIcon:
MysticTicketIcon:
OldSeaMapIcon:
ShinyCharmIcon:
OvalCharmIcon:
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
BlackBeltIcon:
SharpBeakIcon:
PoisonBarbIcon:
SoftSandIcon:
HardStoneIcon:
SilverPowderIcon:
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
BrightPowderIcon:
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
MetalPowderIcon:
QuickPowderIcon:
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
DampRockIcon:
HeatRockIcon:
SmoothRockIcon:
IcyRockIcon:
ChoiceBandIcon:
ChoiceScarfIcon:
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
StardustIcon:
StarPieceIcon:
BrickPieceIcon:
RareBoneIcon:
SilverLeafIcon:
GoldLeafIcon:
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
