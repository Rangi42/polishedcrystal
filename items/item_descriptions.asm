PrintItemDescription: ; 0x1c8955
; Print the description for item [CurSpecies] at de.

	ld a, [CurSpecies]
	cp TM01
	jr c, .not_a_tm

	ld [CurItem], a
	push de
	callba GetTMHMItemMove
	pop hl
	ld a, [wd265]
	ld [CurSpecies], a
	predef PrintMoveDesc
	ret

.not_a_tm
	push de
	ld hl, ItemDescriptions
	ld a, [CurSpecies]
	dec a
	ld c, a
	ld b, 0
rept 2
	add hl, bc
endr
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop hl
	jp PlaceString
; 0x1c8987


ItemDescriptions:
	dw MasterBallDesc
	dw UltraBallDesc
	dw BrightpowderDesc
	dw GreatBallDesc
	dw PokeBallDesc
	dw TeruSama1Desc
	dw BicycleDesc
	dw MoonStoneDesc
	dw AntidoteDesc
	dw BurnHealDesc
	dw IceHealDesc
	dw AwakeningDesc
	dw ParlyzHealDesc
	dw FullRestoreDesc
	dw MaxPotionDesc
	dw HyperPotionDesc
	dw SuperPotionDesc
	dw PotionDesc
	dw EscapeRopeDesc
	dw RepelDesc
	dw MaxElixerDesc
	dw FireStoneDesc
	dw ThunderStoneDesc
	dw WaterStoneDesc
	dw TeruSama2Desc
	dw HPUpDesc
	dw ProteinDesc
	dw IronDesc
	dw CarbosDesc
	dw LuckyPunchDesc
	dw CalciumDesc
	dw RareCandyDesc
	dw XAccuracyDesc
	dw LeafStoneDesc
	dw MetalPowderDesc
	dw NuggetDesc
	dw PokeDollDesc
	dw FullHealDesc
	dw ReviveDesc
	dw MaxReviveDesc
	dw GuardSpecDesc
	dw SuperRepelDesc
	dw MaxRepelDesc
	dw DireHitDesc
	dw TeruSama3Desc
	dw FreshWaterDesc
	dw SodaPopDesc
	dw LemonadeDesc
	dw XAttackDesc
	dw TeruSama4Desc
	dw XDefendDesc
	dw XSpeedDesc
	dw XSpecialDesc
	dw CoinCaseDesc
	dw ItemfinderDesc
	dw TeruSama5Desc
	dw ExpShareDesc
	dw OldRodDesc
	dw GoodRodDesc
	dw SilverLeafDesc
	dw SuperRodDesc
	dw PPUpDesc
	dw EtherDesc
	dw MaxEtherDesc
	dw ElixerDesc
	dw RedScaleDesc
	dw SecretPotionDesc
	dw SSTicketDesc
	dw MysteryEggDesc
	dw ClearBellDesc
	dw SilverWingDesc
	dw MoomooMilkDesc
	dw QuickClawDesc
	dw PsnCureBerryDesc
	dw GoldLeafDesc
	dw SoftSandDesc
	dw SharpBeakDesc
	dw PrzCureBerryDesc
	dw BurntBerryDesc
	dw IceBerryDesc
	dw PoisonBarbDesc
	dw KingsRockDesc
	dw BitterBerryDesc
	dw MintBerryDesc
	dw RedApricornDesc
	dw TinyMushroomDesc
	dw BigMushroomDesc
	dw SilverPowderDesc
	dw BluApricornDesc
	dw TeruSama6Desc
	dw AmuletCoinDesc
	dw YlwApricornDesc
	dw GrnApricornDesc
	dw CleanseTagDesc
	dw MysticWaterDesc
	dw TwistedSpoonDesc
	dw WhtApricornDesc
	dw BlackbeltDesc
	dw BlkApricornDesc
	dw TeruSama7Desc
	dw PnkApricornDesc
	dw BlackGlassesDesc
	dw SlowpokeTailDesc
	dw SilkScarfDesc
	dw StickDesc
	dw SmokeBallDesc
	dw NeverMeltIceDesc
	dw MagnetDesc
	dw MiracleBerryDesc
	dw PearlDesc
	dw BigPearlDesc
	dw EverStoneDesc
	dw SpellTagDesc
	dw RageCandyBarDesc
	dw GSBallDesc
	dw BlueCardDesc
	dw MiracleSeedDesc
	dw ThickClubDesc
	dw FocusBandDesc
	dw TeruSama8Desc
	dw EnergyPowderDesc
	dw EnergyRootDesc
	dw HealPowderDesc
	dw RevivalHerbDesc
	dw HardStoneDesc
	dw LuckyEggDesc
	dw CardKeyDesc
	dw MachinePartDesc
	dw EggTicketDesc
	dw LostItemDesc
	dw StardustDesc
	dw StarPieceDesc
	dw BasementKeyDesc
	dw PassDesc
	dw TeruSama9Desc
	dw TeruSama10Desc
	dw TeruSama11Desc
	dw CharcoalDesc
	dw BerryJuiceDesc
	dw ScopeLensDesc
	dw TeruSama12Desc
	dw TeruSama13Desc
	dw MetalCoatDesc
	dw DragonFangDesc
	dw TeruSama14Desc
	dw LeftoversDesc
	dw TeruSama15Desc
	dw TeruSama16Desc
	dw TeruSama17Desc
	dw MysteryBerryDesc
	dw DragonScaleDesc
	dw BerserkGeneDesc
	dw TeruSama18Desc
	dw TeruSama19Desc
	dw TeruSama20Desc
	dw SacredAshDesc
	dw HeavyBallDesc
	dw FlowerMailDesc
	dw LevelBallDesc
	dw LureBallDesc
	dw FastBallDesc
	dw TeruSama21Desc
	dw LightBallDesc
	dw FriendBallDesc
	dw MoonBallDesc
	dw LoveBallDesc
	dw NormalBoxDesc
	dw GorgeousBoxDesc
	dw SunStoneDesc
	dw PinkBowDesc
	dw TeruSama22Desc
	dw UpGradeDesc
	dw BerryDesc
	dw GoldBerryDesc
	dw SquirtBottleDesc
	dw TeruSama23Desc
	dw ParkBallDesc
	dw RainbowWingDesc
	dw TeruSama24Desc
	dw BrickPieceDesc
	dw SurfMailDesc
	dw LiteBlueMailDesc
	dw PortraitMailDesc
	dw LovelyMailDesc
	dw EonMailDesc
	dw MorphMailDesc
	dw BlueSkyMailDesc
	dw MusicMailDesc
	dw MewMailDesc
	dw TeruSama25Desc
	dw TeruSama26Desc
	dw TeruSama26Desc
	dw TeruSama26Desc
	dw TeruSama26Desc
	dw TeruSama26Desc
	dw TeruSama27Desc
	dw TeruSama27Desc
	dw TeruSama27Desc
	dw TeruSama27Desc
	dw TeruSama27Desc
	dw TeruSama27Desc
	dw TeruSama27Desc
	dw TeruSama27Desc
	dw TeruSama27Desc
	dw TeruSama27Desc
	dw TeruSama27Desc
	dw TeruSama27Desc
	dw TeruSama27Desc
	dw TeruSama27Desc
	dw TeruSama27Desc
	dw TeruSama27Desc
	dw TeruSama27Desc
	dw TeruSama27Desc
	dw TeruSama27Desc
	dw TeruSama27Desc
	dw TeruSama27Desc
	dw TeruSama27Desc
	dw TeruSama27Desc
	dw TeruSama27Desc
	dw TeruSama27Desc
	dw TeruSama28Desc
	dw TeruSama28Desc
	dw TeruSama28Desc
	dw TeruSama28Desc
	dw TeruSama28Desc
	dw TeruSama28Desc
	dw TeruSama28Desc
	dw TeruSama28Desc
	dw TeruSama28Desc
	dw TeruSama28Desc
	dw TeruSama28Desc
	dw TeruSama28Desc
	dw TeruSama28Desc
	dw TeruSama28Desc
	dw TeruSama28Desc
	dw TeruSama28Desc
	dw TeruSama28Desc
	dw TeruSama28Desc
	dw TeruSama28Desc
	dw TeruSama28Desc
	dw TeruSama28Desc
	dw TeruSama28Desc
	dw TeruSama28Desc
	dw TeruSama28Desc
	dw TeruSama28Desc
	dw TeruSama28Desc
	dw TeruSama28Desc
	dw TeruSama28Desc
	dw TeruSama28Desc
	dw TeruSama28Desc
	dw TeruSama29Desc
	dw TeruSama30Desc
	dw TeruSama31Desc
	dw TeruSama32Desc
	dw TeruSama33Desc

MasterBallDesc:
	db   "The best Ball. It"
	next "never misses.@"

UltraBallDesc:
	db   "A Ball with a high"
	next "rate of success.@"

BrightpowderDesc:
	db   "Lowers the foe's"
	next "accuracy. (Hold)@"

GreatBallDesc:
	db   "A Ball with a de-"
	next "cent success rate.@"

PokeBallDesc:
	db   "An item for catch-"
	next "ing #mon.@"

TeruSama1Desc:
	db   "?@"

BicycleDesc:
	db   "A collapsible bike"
	next "for fast movement.@"

MoonStoneDesc:
	db   "Evolves certain"
	next "kinds of #mon.@"

AntidoteDesc:
	db   "Cures poisoned"
	next "#mon.@"

BurnHealDesc:
	db   "Heals burned"
	next "#mon.@"

IceHealDesc:
	db   "Defrosts frozen"
	next "#mon.@"

AwakeningDesc:
	db   "Awakens sleeping"
	next "#mon.@"

ParlyzHealDesc:
	db   "Heals paralyzed"
	next "#mon.@"

FullRestoreDesc:
	db   "Fully restores HP"
	next "& status.@"

MaxPotionDesc:
	db   "Fully restores"
	next "#mon HP.@"

HyperPotionDesc:
	db   "Restores #mon"
	next "HP by 200.@"

SuperPotionDesc:
	db   "Restores #mon"
	next "HP by 50.@"

PotionDesc:
	db   "Restores #mon"
	next "HP by 20.@"

EscapeRopeDesc:
	db   "Use for escaping"
	next "from caves, etc.@"

RepelDesc:
	db   "Repels weak #-"
	next "MON for 100 steps.@"

MaxElixerDesc:
	db   "Fully restores the"
	next "PP of one #mon.@"

FireStoneDesc:
	db   "Evolves certain"
	next "kinds of #mon.@"

ThunderStoneDesc:
	db   "Evolves certain"
	next "kinds of #mon.@"

WaterStoneDesc:
	db   "Evolves certain"
	next "kinds of #mon.@"

TeruSama2Desc:
	db   "?@"

HPUpDesc:
	db   "Raises the HP of"
	next "one #mon.@"

ProteinDesc:
	db   "Raises Attack of"
	next "one #mon.@"

IronDesc:
	db   "Raises Defense of"
	next "one #mon.@"

CarbosDesc:
	db   "Raises Speed of"
	next "one #mon.@"

LuckyPunchDesc:
	db   "Ups critical hit"
	next "ratio of Chansey.@"

CalciumDesc:
	db   "Ups Special stats"
	next "of one #mon.@"

RareCandyDesc:
	db   "Raises level of a"
	next "#mon by one.@"

XAccuracyDesc:
	db   "Raises accuracy."
	next "(1 battle)@"

LeafStoneDesc:
	db   "Evolves certain"
	next "kinds of #mon.@"

MetalPowderDesc:
	db   "Raises Defense of"
	next "Ditto. (Hold)@"

NuggetDesc:
	db   "Made of pure gold."
	next "Sell high.@"

PokeDollDesc:
	db   "Use to escape from"
	next "a wild #mon.@"

FullHealDesc:
	db   "Eliminates all"
	next "status problems.@"

ReviveDesc:
	db   "Restores a fainted"
	next "#mon to 1/2 HP.@"

MaxReviveDesc:
	db   "Fully restores a"
	next "fainted #mon.@"

GuardSpecDesc:
	db   "Prevents stat"
	next "drops. (1 battle)@"

SuperRepelDesc:
	db   "Repels weak #-"
	next "MON for 200 steps.@"

MaxRepelDesc:
	db   "Repels weak #-"
	next "MON for 250 steps.@"

DireHitDesc:
	db   "Ups critical hit"
	next "ratio. (1 battle)@"

TeruSama3Desc:
	db   "?@"

FreshWaterDesc:
	db   "Restores #mon"
	next "HP by 50.@"

SodaPopDesc:
	db   "Restores #mon"
	next "HP by 60.@"

LemonadeDesc:
	db   "Restores #mon"
	next "HP by 80.@"

XAttackDesc:
	db   "Raises Attack."
	next "(1 battle)@"

TeruSama4Desc:
	db   "?@"

XDefendDesc:
	db   "Raises Defense."
	next "(1 battle)@"

XSpeedDesc:
	db   "Raises Speed."
	next "(1 battle)@"

XSpecialDesc:
	db   "Raises Spcl."
	next "Atk. (1 battle)@"

CoinCaseDesc:
	db   "Holds up to 9,999"
	next "game coins.@"

ItemfinderDesc:
	db   "Checks for unseen"
	next "items in the area.@"

TeruSama5Desc:
	db   "?@"

ExpShareDesc:
	db   "Shares battle Exp."
	next "Points. (Hold)@"

OldRodDesc:
	db   "Use by water to"
	next "fish for #mon.@"

GoodRodDesc:
	db   "A good Rod for"
	next "catching #mon.@"

SilverLeafDesc:
	db   "A strange, silver-"
	next "colored leaf.@"

SuperRodDesc:
	db   "The best Rod for"
	next "catching #mon.@"

PPUpDesc:
	db   "Raises max PP of"
	next "a selected move.@"

EtherDesc:
	db   "Restores PP of one"
	next "move by 10.@"

MaxEtherDesc:
	db   "Fully restores PP"
	next "of one move.@"

ElixerDesc:
	db   "Restores PP of all"
	next "moves by 10.@"

RedScaleDesc:
	db   "A scale from the"
	next "red Gyarados.@"

SecretPotionDesc:
	db   "Fully heals any"
	next "#mon.@"

SSTicketDesc:
	db   "A ticket for the"
	next "S.S.Aqua.@"

MysteryEggDesc:
	db   "An Egg obtained"
	next "from Mr.#mon.@"

ClearBellDesc:
	db   "Makes a gentle"
	next "ringing.@"

SilverWingDesc:
	db   "A strange, silver-"
	next "colored feather.@"

MoomooMilkDesc:
	db   "Restores #mon"
	next "HP by 100.@"

QuickClawDesc:
	db   "Raises 1st strike"
	next "ratio. (Hold)@"

PsnCureBerryDesc:
	db   "A self-cure for"
	next "poison. (Hold)@"

GoldLeafDesc:
	db   "A strange, gold-"
	next "colored leaf.@"

SoftSandDesc:
	db   "Powers up Ground-"
	next "type moves. (Hold)@"

SharpBeakDesc:
	db   "Powers up Flying-"
	next "type moves. (Hold)@"

PrzCureBerryDesc:
	db   "A self-cure for"
	next "paralysis. (Hold)@"

BurntBerryDesc:
	db   "A self-cure for"
	next "freezing. (Hold)@"

IceBerryDesc:
	db   "A self-heal for a"
	next "burn. (Hold)@"

PoisonBarbDesc:
	db   "Powers up Poison-"
	next "type moves. (Hold)@"

KingsRockDesc:
	db   "May make the foe"
	next "flinch. (Hold)@"

BitterBerryDesc:
	db   "A self-cure for"
	next "confusion. (Hold)@"

MintBerryDesc:
	db   "A self-awakening"
	next "for sleep. (Hold)@"

RedApricornDesc:
	db   "A red Apricorn.@"

TinyMushroomDesc:
	db   "An ordinary mush-"
	next "room. Sell low.@"

BigMushroomDesc:
	db   "A rare mushroom."
	next "Sell high.@"

SilverPowderDesc:
	db   "Powers up Bug-type"
	next "moves. (Hold)@"

BluApricornDesc:
	db   "A blue Apricorn.@"

TeruSama6Desc:
	db   "?@"

AmuletCoinDesc:
	db   "Doubles monetary"
	next "earnings. (Hold)@"

YlwApricornDesc:
	db   "A yellow Apricorn.@"

GrnApricornDesc:
	db   "A green Apricorn.@"

CleanseTagDesc:
	db   "Helps repel wild"
	next "#mon. (Hold)@"

MysticWaterDesc:
	db   "Powers up Water-"
	next "type moves. (Hold)@"

TwistedSpoonDesc:
	db   "Powers up Psychic-"
	next "type moves. (Hold)@"

WhtApricornDesc:
	db   "A white Apricorn.@"

BlackbeltDesc:
	db   "Boosts Fighting-"
	next "type moves. (Hold)@"

BlkApricornDesc:
	db   "A black Apricorn."
	next "@"

TeruSama7Desc:
	db   "?@"

PnkApricornDesc:
	db   "A pink Apricorn."
	next "@"

BlackGlassesDesc:
	db   "Powers up Dark-"
	next "type moves. (Hold)@"

SlowpokeTailDesc:
	db   "Very tasty. Sell"
	next "high.@"

SilkScarfDesc:
	db   "Powers up Normal-"
	next "type moves. (Hold)@"

StickDesc:
	db   "An ordinary stick."
	next "Sell low.@"

SmokeBallDesc:
	db   "Escape from wild"
	next "#mon. (Hold)@"

NeverMeltIceDesc:
	db   "Powers up Ice-type"
	next "moves. (Hold)@"

MagnetDesc:
	db   "Boosts Electric-"
	next "type moves. (Hold)@"

MiracleBerryDesc:
	db   "Cures all status"
	next "problems. (Hold)@"

PearlDesc:
	db   "A beautiful pearl."
	next "Sell low.@"

BigPearlDesc:
	db   "A big, beautiful"
	next "pearl. Sell high.@"

EverStoneDesc:
	db   "Stops evolution."
	next "(Hold)@"

SpellTagDesc:
	db   "Powers up Ghost-"
	next "type moves. (Hold)@"

RageCandyBarDesc:
	db   "Restores #mon"
	next "HP by 20.@"

GSBallDesc:
	db   "The mysterious"
	next "Ball.@"

BlueCardDesc:
	db   "Card to save"
	next "points.@"

MiracleSeedDesc:
	db   "Powers up Grass-"
	next "type moves. (Hold)@"

ThickClubDesc:
	db   "A bone of some"
	next "sort. Sell low.@"

FocusBandDesc:
	db   "May prevent faint-"
	next "ing. (Hold)@"

TeruSama8Desc:
	db   "?@"

EnergyPowderDesc:
	db   "Restores #mon"
	next "HP by 50. Bitter.@"

EnergyRootDesc:
	db   "Restores #mon"
	next "HP by 200. Bitter.@"

HealPowderDesc:
	db   "Cures all status"
	next "problems. Bitter.@"

RevivalHerbDesc:
	db   "Revives fainted"
	next "#mon. Bitter.@"

HardStoneDesc:
	db   "Powers up Rock-"
	next "type moves. (Hold)@"

LuckyEggDesc:
	db   "Earns extra Exp."
	next "points. (Hold)@"

CardKeyDesc:
	db   "Opens shutters in"
	next "the Radio Tower.@"

MachinePartDesc:
	db   "A machine part for"
	next "the Power Plant.@"

EggTicketDesc:
	db   "May use at Golden-"
	next "rod trade corner.@"

LostItemDesc:
	db   "The # Doll lost"
	next "by the Copycat.@"

StardustDesc:
	db   "Pretty, red sand."
	next "Sell high.@"

StarPieceDesc:
	db   "A hunk of red gem."
	next "Sell very high.@"

BasementKeyDesc:
	db   "Opens doors.@"

PassDesc:
	db   "A ticket for the"
	next "Magnet Train.@"

TeruSama9Desc:
	db   "?@"

TeruSama10Desc:
	db   "?@"

TeruSama11Desc:
	db   "?@"

CharcoalDesc:
	db   "Powers up Fire-"
	next "type moves. (Hold)@"

BerryJuiceDesc:
	db   "Restores #mon"
	next "HP by 20.@"

ScopeLensDesc:
	db   "Raises critical"
	next "hit ratio. (Hold)@"

TeruSama12Desc:
	db   "?@"

TeruSama13Desc:
	db   "?@"

MetalCoatDesc:
	db   "Powers up Steel-"
	next "type moves. (Hold)@"

DragonFangDesc:
	db   "Powers up Dragon-"
	next "type moves. (Hold)@"

TeruSama14Desc:
	db   "?@"

LeftoversDesc:
	db   "Restores HP during"
	next "battle. (Hold)@"

TeruSama15Desc:
	db   "?@"

TeruSama16Desc:
	db   "?@"

TeruSama17Desc:
	db   "?@"

MysteryBerryDesc:
	db   "A self-restore"
	next "for PP. (Hold)@"

DragonScaleDesc:
	db   "A rare Dragon-type"
	next "item.@"

BerserkGeneDesc:
	db   "Boosts Attack but"
	next "causes confusion.@"

TeruSama18Desc:
	db   "?@"

TeruSama19Desc:
	db   "?@"

TeruSama20Desc:
	db   "?@"

SacredAshDesc:
	db   "Fully revives all"
	next "fainted #mon.@"

HeavyBallDesc:
	db   "A Ball for catch-"
	next "ing heavy #mon.@"

FlowerMailDesc:
	db   "Flower-print Mail."
	next "(Hold)@"

LevelBallDesc:
	db   "A Ball for lower-"
	next "level #mon.@"

LureBallDesc:
	db   "A Ball for #mon"
	next "hooked by a Rod.@"

FastBallDesc:
	db   "A Ball for catch-"
	next "ing fast #mon.@"

TeruSama21Desc:
	db   "?@"

LightBallDesc:
	db   "An odd, electrical"
	next "orb. (Hold)@"

FriendBallDesc:
	db   "A Ball that makes"
	next "#mon friendly.@"

MoonBallDesc:
	db   "A Ball for Moon"
	next "Stone evolvers.@"

LoveBallDesc:
	db   "For catching the"
	next "opposite gender.@"

NormalBoxDesc:
	db   "Open it and see"
	next "what's inside.@"

GorgeousBoxDesc:
	db   "Open it and see"
	next "what's inside.@"

SunStoneDesc:
	db   "Evolves certain"
	next "kinds of #mon.@"

PinkBowDesc:
	db   "Powers up Fairy-"
	next "type moves. (Hold)@"

TeruSama22Desc:
	db   "?@"

UpGradeDesc:
	db   "A mysterious box"
	next "made by Silph Co.@"

BerryDesc:
	db   "A self-restore"
	next "item. (10HP, Hold)@"

GoldBerryDesc:
	db   "A self-restore"
	next "item. (30HP, Hold)@"

SquirtBottleDesc:
	db   "A bottle used for"
	next "watering plants.@"

TeruSama23Desc:
	db   "?@"

ParkBallDesc:
	db   "The Bug-Catching"
	next "Contest Ball.@"

RainbowWingDesc:
	db   "A mystical feather"
	next "of rainbow colors.@"

TeruSama24Desc:
	db   "?@"

BrickPieceDesc:
	db   "A rare chunk of"
	next "tile.@"

SurfMailDesc:
	db   "Lapras-print Mail."
	next "(Hold)@"

LiteBlueMailDesc:
	db   "Dratini-print"
	next "Mail. (Hold)@"

PortraitMailDesc:
	db   "Mail featuring the"
	next "holder's likeness.@"

LovelyMailDesc:
	db   "Heart-print Mail."
	next "(Hold)@"

EonMailDesc:
	db   "Eevee-print Mail."
	next "(Hold)@"

MorphMailDesc:
	db   "Ditto-print Mail."
	next "(Hold)@"

BlueSkyMailDesc:
	db   "Sky-print Mail."
	next "(Hold)@"

MusicMailDesc:
	db   "Natu-print Mail."
	next "(Hold)@"

MewMailDesc:
	db   "Mew-print Mail."
	next "(Hold)@"

TeruSama25Desc:
	db   "?@"

TeruSama26Desc:
	db   "?@"

TeruSama27Desc:
	db   "?@"

TeruSama28Desc:
	db   "?@"

TeruSama29Desc:
	db   "?@"

TeruSama30Desc:
	db   "?@"

TeruSama31Desc:
	db   "?@"

TeruSama32Desc:
	db   "?@"

TeruSama33Desc:
	db   "?@"
