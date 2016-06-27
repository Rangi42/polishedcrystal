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
	dw PokeBallDesc
	dw GreatBallDesc
	dw UltraBallDesc
	dw MasterBallDesc
	dw PotionDesc
	dw SuperPotionDesc
	dw HyperPotionDesc
	dw MaxPotionDesc
	dw AntidoteDesc
	dw BurnHealDesc
	dw ParlyzHealDesc
	dw AwakeningDesc
	dw IceHealDesc
	dw FullHealDesc
	dw FullRestoreDesc
	dw ReviveDesc
	dw MaxReviveDesc
	dw EtherDesc
	dw MaxEtherDesc
	dw ElixirDesc
	dw MaxElixirDesc
	dw XAttackDesc
	dw XDefendDesc
	dw XSpeedDesc
	dw XSpclAtkDesc
	dw XSpclDefDesc
	dw DireHitDesc
	dw GuardSpecDesc
	dw XAccuracyDesc
	dw HPUpDesc
	dw ProteinDesc
	dw IronDesc
	dw CarbosDesc
	dw CalciumDesc
	dw RareCandyDesc
	dw PPUpDesc
	dw FreshWaterDesc
	dw SodaPopDesc
	dw LemonadeDesc
	dw MoomooMilkDesc
	dw RageCandyBarDesc
	dw SacredAshDesc
	dw EnergyPowderDesc
	dw EnergyRootDesc
	dw HealPowderDesc
	dw RevivalHerbDesc
	dw RepelDesc
	dw SuperRepelDesc
	dw MaxRepelDesc
	dw EscapeRopeDesc
	dw PokeDollDesc
	dw LeafStoneDesc
	dw FireStoneDesc
	dw WaterStoneDesc
	dw ThunderStoneDesc
	dw MoonStoneDesc
	dw SunStoneDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw EverstoneDesc
	dw BicycleDesc
	dw OldRodDesc
	dw GoodRodDesc
	dw SuperRodDesc
	dw CoinCaseDesc
	dw ItemfinderDesc
	dw ExpShareDesc
	dw MysteryEggDesc
	dw SquirtBottleDesc
	dw SecretPotionDesc
	dw RedScaleDesc
	dw CardKeyDesc
	dw BasementKeyDesc
	dw SSTicketDesc
	dw PassDesc
	dw MachinePartDesc
	dw LostItemDesc
	dw RainbowWingDesc
	dw SilverWingDesc
	dw ClearBellDesc
	dw GSBallDesc
	dw BlueCardDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw BerryDesc
	dw GoldBerryDesc
	dw PsnCureBerryDesc
	dw IceBerryDesc
	dw PrzCureBerryDesc
	dw MintBerryDesc
	dw BurntBerryDesc
	dw BitterBerryDesc
	dw MiracleBerryDesc
	dw MysteryBerryDesc
	dw RedApricornDesc
	dw BluApricornDesc
	dw YlwApricornDesc
	dw GrnApricornDesc
	dw WhtApricornDesc
	dw BlkApricornDesc
	dw PnkApricornDesc
	dw HeavyBallDesc
	dw LevelBallDesc
	dw LureBallDesc
	dw FastBallDesc
	dw FriendBallDesc
	dw MoonBallDesc
	dw LoveBallDesc
	dw SilkScarfDesc
	dw BlackBeltDesc
	dw SharpBeakDesc
	dw PoisonBarbDesc
	dw SoftSandDesc
	dw HardStoneDesc
	dw SilverPowderDesc
	dw SpellTagDesc
	dw MetalCoatDesc
	dw CharcoalDesc
	dw MysticWaterDesc
	dw MiracleSeedDesc
	dw MagnetDesc
	dw TwistedSpoonDesc
	dw NeverMeltIceDesc
	dw DragonFangDesc
	dw BlackGlassesDesc
	dw PinkBowDesc
	dw BrightPowderDesc
	dw ScopeLensDesc
	dw QuickClawDesc
	dw KingsRockDesc
	dw FocusBandDesc
	dw LeftoversDesc
	dw LuckyEggDesc
	dw AmuletCoinDesc
	dw CleanseTagDesc
	dw SmokeBallDesc
	dw LightBallDesc
	dw StickDesc
	dw ThickClubDesc
	dw LuckyPunchDesc
	dw MetalPowderDesc
	dw BerserkGeneDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw DragonScaleDesc
	dw UpGradeDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw NuggetDesc
	dw TinyMushroomDesc
	dw BigMushroomDesc
	dw PearlDesc
	dw BigPearlDesc
	dw StardustDesc
	dw StarPieceDesc
	dw SilverLeafDesc
	dw GoldLeafDesc
	dw SlowpokeTailDesc
	dw ParkBallDesc
	dw RepeatBallDesc
	dw TimerBallDesc
	dw QuickBallDesc
	dw DuskBallDesc
	dw HelixFossilDesc
	dw DomeFossilDesc
	dw OldAmberDesc
	dw FlowerMailDesc
	dw SurfMailDesc
	dw LiteBlueMailDesc
	dw PortraitMailDesc
	dw LovelyMailDesc
	dw EonMailDesc
	dw MorphMailDesc
	dw BlueSkyMailDesc
	dw MusicMailDesc
	dw MewMailDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc
	dw TeruSamaDesc

MasterBallDesc:
	db   "The best Ball. It"
	next "never misses.@"

UltraBallDesc:
	db   "A Ball with a high"
	next "rate of success.@"

BrightPowderDesc:
	db   "Lowers the foe's"
	next "accuracy. (Hold)@"

GreatBallDesc:
	db   "A Ball with a de-"
	next "cent success rate.@"

PokeBallDesc:
	db   "An item for catch-"
	next "ing #mon.@"

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
	next "mon for 100 steps.@"

MaxElixirDesc:
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
	next "mon for 200 steps.@"

MaxRepelDesc:
	db   "Repels weak #-"
	next "mon for 250 steps.@"

DireHitDesc:
	db   "Ups critical hit"
	next "ratio. (1 battle)@"

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

XSpclDefDesc:
	db   "Raises Spcl. Def."
	next "(1 battle)@"

XDefendDesc:
	db   "Raises Defense."
	next "(1 battle)@"

XSpeedDesc:
	db   "Raises Speed."
	next "(1 battle)@"

XSpclAtkDesc:
	db   "Raises Spcl. Atk."
	next "(1 battle)@"

CoinCaseDesc:
	db   "Holds up to 50K"
	next "game coins.@"

ItemfinderDesc:
	db   "Checks for unseen"
	next "items in the area.@"

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

ElixirDesc:
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

BlackBeltDesc:
	db   "Boosts Fighting-"
	next "type moves. (Hold)@"

BlkApricornDesc:
	db   "A black Apricorn."
	next "@"

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

EverstoneDesc:
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

CharcoalDesc:
	db   "Powers up Fire-"
	next "type moves. (Hold)@"

ScopeLensDesc:
	db   "Raises critical"
	next "hit ratio. (Hold)@"

MetalCoatDesc:
	db   "Powers up Steel-"
	next "type moves. (Hold)@"

DragonFangDesc:
	db   "Powers up Dragon-"
	next "type moves. (Hold)@"

RepeatBallDesc:
	db   "A Ball for #mon"
	next "caught before.@"

LeftoversDesc:
	db   "Restores HP during"
	next "battle. (Hold)@"

TimerBallDesc:
	db   "A Ball for late"
	next "in a battle.@"

QuickBallDesc:
	db   "A Ball for early"
	next "in a battle.@"

DuskBallDesc:
	db   "A Ball for night-"
	next "time or caves.@"

MysteryBerryDesc:
	db   "A self-restore"
	next "for PP. (Hold)@"

DragonScaleDesc:
	db   "A rare Dragon-type"
	next "item.@"

BerserkGeneDesc:
	db   "Boosts Attack but"
	next "causes confusion.@"

HelixFossilDesc:
	db   "A fossilized"
	next "#mon shell.@"

DomeFossilDesc:
	db   "A fossilized"
	next "#mon shell.@"

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

SunStoneDesc:
	db   "Evolves certain"
	next "kinds of #mon.@"

PinkBowDesc:
	db   "Powers up Fairy-"
	next "type moves. (Hold)@"

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

ParkBallDesc:
	db   "The Bug-Catching"
	next "Contest Ball.@"

RainbowWingDesc:
	db   "A mystical feather"
	next "of rainbow colors.@"

OldAmberDesc:
	db   "Fossilized resin"
	next "containing DNA.@"

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

TeruSamaDesc:
	db   "?@"
