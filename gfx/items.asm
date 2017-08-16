UpdateItemIconAndDescription::
	farcall UpdateItemDescription
	jr UpdateItemIcon

UpdateTMHMIconAndDescriptionAndOwnership::
	farcall UpdateTMHMDescriptionAndOwnership
	farcall LoadTMHMIconPalette
	jp SetPalettes

UpdateItemIconAndDescriptionAndBagQuantity::
	farcall UpdateItemDescriptionAndBagQuantity
UpdateItemIcon::
	ld hl, ItemIconPointers
	ld a, [CurSpecies]
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, VTiles2 tile $17
	call GetItemIconBank
	call DecompressRequest2bpp
	farcall LoadItemIconPalette
	jp SetPalettes

GetItemIconBank:
	lb bc, BANK(ItemIcons1), $9
	ld a, [CurSpecies]
	cp SCOPE_LENS ; first icon in ItemIcons2
	ret c
	cp METAL_POWDER ; after Scope Lens, but in ItemIcons1
	ret z
	cp QUICK_POWDER ; after Scope Lens, but in ItemIcons1
	ret z
	cp STARDUST ; after Scope Lens, but in ItemIcons1
	ret z
	cp CHOICE_SCARF ; after Scope Lens, but in ItemIcons1
	ret z
	cp ITEM_FROM_MEM
	ret z
	lb bc, BANK(ItemIcons2), $9
	ret

LoadTMHMIcon::
	ld hl, TMHMIcon
	ld de, VTiles2 tile $17
	lb bc, BANK(TMHMIcon), $9
	jp DecompressRequest2bpp

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
	dw CheriBerryIcon
	dw ChestoBerryIcon
	dw PechaBerryIcon
	dw RawstBerryIcon
	dw AspearBerryIcon
	dw LeppaBerryIcon
	dw OranBerryIcon
	dw PersimBerryIcon
	dw LumBerryIcon
	dw SitrusBerryIcon
	dw FigyBerryIcon
	dw LiechiBerryIcon
	dw GanlonBerryIcon
	dw SalacBerryIcon
	dw PetayaBerryIcon
	dw ApicotBerryIcon
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


SECTION "Item Icons 1", ROMX

ItemIcons1:
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
SilphScope2Icon:  INCBIN "gfx/items/silphscope2.2bpp.lz"
CheriBerryIcon:   INCBIN "gfx/items/cheri_berry.2bpp.lz"
ChestoBerryIcon:  INCBIN "gfx/items/chesto_berry.2bpp.lz"
PechaBerryIcon:   INCBIN "gfx/items/pecha_berry.2bpp.lz"
RawstBerryIcon:   INCBIN "gfx/items/rawst_berry.2bpp.lz"
AspearBerryIcon:  INCBIN "gfx/items/aspear_berry.2bpp.lz"
LeppaBerryIcon:   INCBIN "gfx/items/leppa_berry.2bpp.lz"
OranBerryIcon:    INCBIN "gfx/items/oran_berry.2bpp.lz"
PersimBerryIcon:  INCBIN "gfx/items/persim_berry.2bpp.lz"
LumBerryIcon:     INCBIN "gfx/items/lum_berry.2bpp.lz"
SitrusBerryIcon:  INCBIN "gfx/items/sitrus_berry.2bpp.lz"
FigyBerryIcon:    INCBIN "gfx/items/figy_berry.2bpp.lz"
LiechiBerryIcon:  INCBIN "gfx/items/liechi_berry.2bpp.lz"
GanlonBerryIcon:  INCBIN "gfx/items/ganlon_berry.2bpp.lz"
SalacBerryIcon:   INCBIN "gfx/items/salac_berry.2bpp.lz"
PetayaBerryIcon:  INCBIN "gfx/items/petaya_berry.2bpp.lz"
ApicotBerryIcon:  INCBIN "gfx/items/apicot_berry.2bpp.lz"
RedApricornIcon:
BluApricornIcon:
YlwApricornIcon:
GrnApricornIcon:
WhtApricornIcon:
BlkApricornIcon:
PnkApricornIcon:  INCBIN "gfx/items/apricorn.2bpp.lz"
SilkScarfIcon:
ChoiceScarfIcon:  INCBIN "gfx/items/scarf.2bpp.lz"
BlackBeltIcon:    INCBIN "gfx/items/black_belt.2bpp.lz"
SharpBeakIcon:    INCBIN "gfx/items/sharp_beak.2bpp.lz"
PoisonBarbIcon:   INCBIN "gfx/items/poison_barb.2bpp.lz"
HardStoneIcon:    INCBIN "gfx/items/hard_stone.2bpp.lz"
SpellTagIcon:     INCBIN "gfx/items/spell_tag.2bpp.lz"
MetalCoatIcon:    INCBIN "gfx/items/metal_coat.2bpp.lz"
CharcoalIcon:     INCBIN "gfx/items/charcoal.2bpp.lz"
MysticWaterIcon:  INCBIN "gfx/items/mystic_water.2bpp.lz"
MiracleSeedIcon:  INCBIN "gfx/items/miracle_seed.2bpp.lz"
MagnetIcon:       INCBIN "gfx/items/magnet.2bpp.lz"
TwistedSpoonIcon: INCBIN "gfx/items/twistedspoon.2bpp.lz"
NeverMeltIceIcon: INCBIN "gfx/items/nevermeltice.2bpp.lz"
DragonFangIcon:   INCBIN "gfx/items/dragon_fang.2bpp.lz"
BlackGlassesIcon: INCBIN "gfx/items/blackglasses.2bpp.lz"
PinkBowIcon:      INCBIN "gfx/items/pink_bow.2bpp.lz"


SECTION "Item Icons 2", ROMX

ItemIcons2:
ScopeLensIcon:    INCBIN "gfx/items/scope_lens.2bpp.lz"
QuickClawIcon:    INCBIN "gfx/items/quick_claw.2bpp.lz"
KingsRockIcon:    INCBIN "gfx/items/kings_rock.2bpp.lz"
FocusBandIcon:    INCBIN "gfx/items/focus_band.2bpp.lz"
LeftoversIcon:    INCBIN "gfx/items/leftovers.2bpp.lz"
LuckyEggIcon:     INCBIN "gfx/items/lucky_egg.2bpp.lz"
AmuletCoinIcon:   INCBIN "gfx/items/amulet_coin.2bpp.lz"
CleanseTagIcon:   INCBIN "gfx/items/cleanse_tag.2bpp.lz"
SmokeBallIcon:    INCBIN "gfx/items/smoke_ball.2bpp.lz"
BerserkGeneIcon:  INCBIN "gfx/items/berserk_gene.2bpp.lz"
LightBallIcon:    INCBIN "gfx/items/light_ball.2bpp.lz"
StickIcon:        INCBIN "gfx/items/stick.2bpp.lz"
ThickClubIcon:
RareBoneIcon:     INCBIN "gfx/items/bone.2bpp.lz"
LuckyPunchIcon:   INCBIN "gfx/items/lucky_punch.2bpp.lz"
ArmorSuitIcon:    INCBIN "gfx/items/armor_suit.2bpp.lz"
AirBalloonIcon:   INCBIN "gfx/items/air_balloon.2bpp.lz"
AssaultVestIcon:  INCBIN "gfx/items/assault_vest.2bpp.lz"
BigRootIcon:      INCBIN "gfx/items/big_root.2bpp.lz"
BindingBandIcon:  INCBIN "gfx/items/binding_band.2bpp.lz"
DestinyKnotIcon:  INCBIN "gfx/items/destiny_knot.2bpp.lz"
EvioliteIcon:     INCBIN "gfx/items/eviolite.2bpp.lz"
ExpertBeltIcon:   INCBIN "gfx/items/expert_belt.2bpp.lz"
FocusSashIcon:    INCBIN "gfx/items/focus_sash.2bpp.lz"
GripClawIcon:     INCBIN "gfx/items/grip_claw.2bpp.lz"
LifeOrbIcon:      INCBIN "gfx/items/life_orb.2bpp.lz"
LightClayIcon:    INCBIN "gfx/items/light_clay.2bpp.lz"
MetronomeIIcon:   INCBIN "gfx/items/metronome_i.2bpp.lz"
MuscleBandIcon:   INCBIN "gfx/items/muscle_band.2bpp.lz"
ProtectPadsIcon:  INCBIN "gfx/items/protect_pads.2bpp.lz"
RockyHelmetIcon:  INCBIN "gfx/items/rocky_helmet.2bpp.lz"
SafeGogglesIcon:  INCBIN "gfx/items/safe_goggles.2bpp.lz"
ShedShellIcon:    INCBIN "gfx/items/shed_shell.2bpp.lz"
ShellBellIcon:    INCBIN "gfx/items/shell_bell.2bpp.lz"
SootheBellIcon:   INCBIN "gfx/items/soothe_bell.2bpp.lz"
WeakPolicyIcon:   INCBIN "gfx/items/weak_policy.2bpp.lz"
WideLensIcon:     INCBIN "gfx/items/wide_lens.2bpp.lz"
WiseGlassesIcon:  INCBIN "gfx/items/wise_glasses.2bpp.lz"
ZoomLensIcon:     INCBIN "gfx/items/zoom_lens.2bpp.lz"
MentalHerbIcon:
PowerHerbIcon:
WhiteHerbIcon:
SilverLeafIcon:
GoldLeafIcon:     INCBIN "gfx/items/leaf.2bpp.lz"
DampRockIcon:     INCBIN "gfx/items/damp_rock.2bpp.lz"
HeatRockIcon:     INCBIN "gfx/items/heat_rock.2bpp.lz"
SmoothRockIcon:   INCBIN "gfx/items/smooth_rock.2bpp.lz"
IcyRockIcon:      INCBIN "gfx/items/icy_rock.2bpp.lz"
ChoiceBandIcon:   INCBIN "gfx/items/choice_band.2bpp.lz"
ChoiceSpecsIcon:  INCBIN "gfx/items/choice_specs.2bpp.lz"
FlameOrbIcon:     INCBIN "gfx/items/flame_orb.2bpp.lz"
ToxicOrbIcon:     INCBIN "gfx/items/toxic_orb.2bpp.lz"
BlackSludgeIcon:  INCBIN "gfx/items/black_sludge.2bpp.lz"
MachoBraceIcon:   INCBIN "gfx/items/macho_brace.2bpp.lz"
PowerWeightIcon:  INCBIN "gfx/items/power_weight.2bpp.lz"
PowerBracerIcon:  INCBIN "gfx/items/power_bracer.2bpp.lz"
PowerBeltIcon:    INCBIN "gfx/items/power_belt.2bpp.lz"
PowerLensIcon:    INCBIN "gfx/items/power_lens.2bpp.lz"
PowerBandIcon:    INCBIN "gfx/items/power_band.2bpp.lz"
PowerAnkletIcon:  INCBIN "gfx/items/power_anklet.2bpp.lz"
DragonScaleIcon:  INCBIN "gfx/items/dragon_scale.2bpp.lz"
UpGradeIcon:      INCBIN "gfx/items/up_grade.2bpp.lz"
DubiousDiscIcon:  INCBIN "gfx/items/dubious_disc.2bpp.lz"
ProtectorIcon:    INCBIN "gfx/items/protector.2bpp.lz"
ElectirizerIcon:  INCBIN "gfx/items/electirizer.2bpp.lz"
MagmarizerIcon:   INCBIN "gfx/items/magmarizer.2bpp.lz"
RazorFangIcon:    INCBIN "gfx/items/razor_fang.2bpp.lz"
RazorClawIcon:    INCBIN "gfx/items/razor_claw.2bpp.lz"
OddSouvenirIcon:  INCBIN "gfx/items/odd_souvenir.2bpp.lz"
NuggetIcon:       INCBIN "gfx/items/nugget.2bpp.lz"
BigNuggetIcon:    INCBIN "gfx/items/big_nugget.2bpp.lz"
TinyMushroomIcon: INCBIN "gfx/items/tinymushroom.2bpp.lz"
BigMushroomIcon:  INCBIN "gfx/items/big_mushroom.2bpp.lz"
BalmMushroomIcon: INCBIN "gfx/items/balmmushroom.2bpp.lz"
PearlIcon:        INCBIN "gfx/items/pearl.2bpp.lz"
BigPearlIcon:     INCBIN "gfx/items/big_pearl.2bpp.lz"
PearlStringIcon:  INCBIN "gfx/items/pearl_string.2bpp.lz"
StarPieceIcon:    INCBIN "gfx/items/star_piece.2bpp.lz"
BrickPieceIcon:   INCBIN "gfx/items/brick_piece.2bpp.lz"
SlowpokeTailIcon: INCBIN "gfx/items/slowpoketail.2bpp.lz"
BottleCapIcon:    INCBIN "gfx/items/bottle_cap.2bpp.lz"
HelixFossilIcon:  INCBIN "gfx/items/helix_fossil.2bpp.lz"
DomeFossilIcon:   INCBIN "gfx/items/dome_fossil.2bpp.lz"
OldAmberIcon:     INCBIN "gfx/items/old_amber.2bpp.lz"
MulchIcon:        INCBIN "gfx/items/mulch.2bpp.lz"
SweetHoneyIcon:   INCBIN "gfx/items/sweet_honey.2bpp.lz"
FlowerMailIcon:   INCBIN "gfx/items/flower_mail.2bpp.lz"
SurfMailIcon:
LiteBlueMailIcon: INCBIN "gfx/items/mail.2bpp.lz"
PortraitMailIcon: INCBIN "gfx/items/portraitmail.2bpp.lz"
LovelyMailIcon:   INCBIN "gfx/items/lovely_mail.2bpp.lz"
EonMailIcon:      INCBIN "gfx/items/eon_mail.2bpp.lz"
MorphMailIcon:    INCBIN "gfx/items/morph_mail.2bpp.lz"
BlueSkyMailIcon:  INCBIN "gfx/items/bluesky_mail.2bpp.lz"
MusicMailIcon:    INCBIN "gfx/items/music_mail.2bpp.lz"
MirageMailIcon:   INCBIN "gfx/items/mirage_mail.2bpp.lz"

TMHMIcon:         INCBIN "gfx/items/tm_hm.2bpp.lz"
