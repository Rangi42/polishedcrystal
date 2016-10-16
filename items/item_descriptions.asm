PrintItemDescription: ; 0x1c8955
; Print the description for item [CurSpecies] at de.

	ld a, [CurSpecies]
	cp TM01
	jr c, .not_a_tm

	ld [CurTMHM], a
	push de
	predef GetTMHMMove
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
	dw DuskStoneDesc
	dw ShinyStoneDesc
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
	dw MysticTicketDesc
	dw OldSeaMapDesc
	dw OranBerryDesc
	dw SitrusBerryDesc
	dw PechaBerryDesc
	dw RawstBerryDesc
	dw CheriBerryDesc
	dw ChestoBerryDesc
	dw AspearBerryDesc
	dw PersimBerryDesc
	dw LumBerryDesc
	dw LeppaBerryDesc
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
	dw EvioliteDesc
	dw MuscleBandDesc
	dw WiseGlassesDesc
	dw DragonScaleDesc
	dw UpGradeDesc
	dw DubiousDiscDesc
	dw ProtectorDesc
	dw ElectirizerDesc
	dw MagmarizerDesc
	dw RazorFangDesc
	dw RazorClawDesc
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
	dw MirageMailDesc
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

PokeBallDesc:
	db   "An item for catch-"
	next "ing #mon.@"

GreatBallDesc:
	db   "A Ball with a de-"
	next "cent success rate.@"

UltraBallDesc:
	db   "A Ball with a high"
	next "rate of success.@"

MasterBallDesc:
	db   "The best Ball. It"
	next "never misses.@"

PotionDesc:
	db   "Restores #mon"
	next "HP by 20.@"

SuperPotionDesc:
	db   "Restores #mon"
	next "HP by 50.@"

HyperPotionDesc:
	db   "Restores #mon"
	next "HP by 200.@"

MaxPotionDesc:
	db   "Fully restores"
	next "#mon HP.@"

AntidoteDesc:
	db   "Cures poisoned"
	next "#mon.@"

BurnHealDesc:
	db   "Heals burned"
	next "#mon.@"

ParlyzHealDesc:
	db   "Heals paralyzed"
	next "#mon.@"

AwakeningDesc:
	db   "Awakens sleeping"
	next "#mon.@"

IceHealDesc:
	db   "Defrosts frozen"
	next "#mon.@"

FullHealDesc:
	db   "Eliminates all"
	next "status problems.@"

FullRestoreDesc:
	db   "Fully restores HP"
	next "& status.@"

ReviveDesc:
	db   "Restores a fainted"
	next "#mon to 1/2 HP.@"

MaxReviveDesc:
	db   "Fully restores a"
	next "fainted #mon.@"

EtherDesc:
	db   "Restores PP of one"
	next "move by 10.@"

MaxEtherDesc:
	db   "Fully restores PP"
	next "of one move.@"

ElixirDesc:
	db   "Restores PP of all"
	next "moves by 10.@"

MaxElixirDesc:
	db   "Fully restores the"
	next "PP of one #mon.@"

XAttackDesc:
	db   "Raises Attack."
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

XSpclDefDesc:
	db   "Raises Spcl. Def."
	next "(1 battle)@"

DireHitDesc:
	db   "Ups critical hit"
	next "ratio. (1 battle)@"

GuardSpecDesc:
	db   "Prevents stat"
	next "drops. (1 battle)@"

XAccuracyDesc:
	db   "Raises accuracy."
	next "(1 battle)@"

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

CalciumDesc:
	db   "Ups Special stats"
	next "of one #mon.@"

RareCandyDesc:
	db   "Raises level of a"
	next "#mon by one.@"

PPUpDesc:
	db   "Raises max PP of"
	next "a selected move.@"

FreshWaterDesc:
	db   "Restores #mon"
	next "HP by 50.@"

SodaPopDesc:
	db   "Restores #mon"
	next "HP by 60.@"

LemonadeDesc:
	db   "Restores #mon"
	next "HP by 80.@"

MoomooMilkDesc:
	db   "Restores #mon"
	next "HP by 100.@"

RageCandyBarDesc:
	db   "Restores #mon"
	next "HP by 20.@"

SacredAshDesc:
	db   "Fully revives all"
	next "fainted #mon.@"

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

RepelDesc:
	db   "Repels weak #-"
	next "mon for 100 steps.@"

SuperRepelDesc:
	db   "Repels weak #-"
	next "mon for 200 steps.@"

MaxRepelDesc:
	db   "Repels weak #-"
	next "mon for 250 steps.@"

EscapeRopeDesc:
	db   "Use for escaping"
	next "from caves, etc.@"

PokeDollDesc:
	db   "Use to escape from"
	next "a wild #mon.@"

LeafStoneDesc:
	db   "Evolves certain"
	next "kinds of #mon.@"

FireStoneDesc:
	db   "Evolves certain"
	next "kinds of #mon.@"

WaterStoneDesc:
	db   "Evolves certain"
	next "kinds of #mon.@"

ThunderStoneDesc:
	db   "Evolves certain"
	next "kinds of #mon.@"

MoonStoneDesc:
	db   "Evolves certain"
	next "kinds of #mon.@"

SunStoneDesc:
	db   "Evolves certain"
	next "kinds of #mon.@"

DuskStoneDesc:
	db   "Evolves certain"
	next "kinds of #mon.@"

ShinyStoneDesc:
	db   "Evolves certain"
	next "kinds of #mon.@"

EverstoneDesc:
	db   "Stops evolution."
	next "(Hold)@"

BicycleDesc:
	db   "A collapsible bike"
	next "for fast movement.@"

OldRodDesc:
	db   "Use by water to"
	next "fish for #mon.@"

GoodRodDesc:
	db   "A good Rod for"
	next "catching #mon.@"

SuperRodDesc:
	db   "The best Rod for"
	next "catching #mon.@"

CoinCaseDesc:
	db   "Holds up to 50K"
	next "game coins.@"

ItemfinderDesc:
	db   "Checks for unseen"
	next "items in the area.@"

ExpShareDesc:
	db   "Shares battle Exp."
	next "Points. (Hold)@"

MysteryEggDesc:
	db   "An Egg obtained"
	next "from Mr.#mon.@"

SquirtBottleDesc:
	db   "A bottle used for"
	next "watering plants.@"

SecretPotionDesc:
	db   "Fully heals any"
	next "#mon.@"

RedScaleDesc:
	db   "A scale from the"
	next "red Gyarados.@"

CardKeyDesc:
	db   "Opens shutters in"
	next "the Radio Tower.@"

BasementKeyDesc:
	db   "Opens doors.@"

SSTicketDesc:
	db   "A ticket for the"
	next "S.S.Aqua.@"

PassDesc:
	db   "A ticket for the"
	next "Magnet Train.@"

MachinePartDesc:
	db   "A machine part for"
	next "the Power Plant.@"

LostItemDesc:
	db   "The # Doll lost"
	next "by the Copycat.@"

RainbowWingDesc:
	db   "A mystical feather"
	next "of rainbow colors.@"

SilverWingDesc:
	db   "A strange, silver-"
	next "colored feather.@"

ClearBellDesc:
	db   "Makes a gentle"
	next "ringing.@"

GSBallDesc:
	db   "The mysterious"
	next "Ball.@"

BlueCardDesc:
	db   "Card to save"
	next "points.@"

MysticTicketDesc:
	db   "A ticket for the"
	next "Seagallop Ferry.@"

OldSeaMapDesc:
	db   "A faded sea chart"
	next "of a small island.@"

OranBerryDesc:
	db   "A self-restore"
	next "item. (10HP, Hold)@"

SitrusBerryDesc:
	db   "Self-restore item."
	next "(1/4 max HP, Hold)@"

PechaBerryDesc:
	db   "A self-cure for"
	next "poison. (Hold)@"

RawstBerryDesc:
	db   "A self-heal for a"
	next "burn. (Hold)@"

CheriBerryDesc:
	db   "A self-cure for"
	next "paralysis. (Hold)@"

ChestoBerryDesc:
	db   "A self-awakening"
	next "for sleep. (Hold)@"

AspearBerryDesc:
	db   "A self-cure for"
	next "freezing. (Hold)@"

PersimBerryDesc:
	db   "A self-cure for"
	next "confusion. (Hold)@"

LumBerryDesc:
	db   "Cures all status"
	next "problems. (Hold)@"

LeppaBerryDesc:
	db   "A self-restore"
	next "for PP. (Hold)@"

RedApricornDesc:
	db   "A red Apricorn.@"

BluApricornDesc:
	db   "A blue Apricorn.@"

YlwApricornDesc:
	db   "A yellow Apricorn.@"

GrnApricornDesc:
	db   "A green Apricorn.@"

WhtApricornDesc:
	db   "A white Apricorn.@"

BlkApricornDesc:
	db   "A black Apricorn."
	next "@"

PnkApricornDesc:
	db   "A pink Apricorn."
	next "@"

HeavyBallDesc:
	db   "A Ball for catch-"
	next "ing heavy #mon.@"

LevelBallDesc:
	db   "A Ball for lower-"
	next "level #mon.@"

LureBallDesc:
	db   "A Ball for #mon"
	next "hooked by a Rod.@"

FastBallDesc:
	db   "A Ball for catch-"
	next "ing fast #mon.@"

FriendBallDesc:
	db   "A Ball that makes"
	next "#mon friendly.@"

MoonBallDesc:
	db   "A Ball for Moon"
	next "Stone evolvers.@"

LoveBallDesc:
	db   "A Ball for the"
	next "opposite gender.@"

SilkScarfDesc:
	db   "Powers up Normal-"
	next "type moves. (Hold)@"

BlackBeltDesc:
	db   "Boosts Fighting-"
	next "type moves. (Hold)@"

SharpBeakDesc:
	db   "Powers up Flying-"
	next "type moves. (Hold)@"

PoisonBarbDesc:
	db   "Powers up Poison-"
	next "type moves. (Hold)@"

SoftSandDesc:
	db   "Powers up Ground-"
	next "type moves. (Hold)@"

HardStoneDesc:
	db   "Powers up Rock-"
	next "type moves. (Hold)@"

SilverPowderDesc:
	db   "Powers up Bug-type"
	next "moves. (Hold)@"

SpellTagDesc:
	db   "Powers up Ghost-"
	next "type moves. (Hold)@"

MetalCoatDesc:
	db   "Powers up Steel-"
	next "type moves. (Hold)@"

CharcoalDesc:
	db   "Powers up Fire-"
	next "type moves. (Hold)@"

MysticWaterDesc:
	db   "Powers up Water-"
	next "type moves. (Hold)@"

MiracleSeedDesc:
	db   "Powers up Grass-"
	next "type moves. (Hold)@"

MagnetDesc:
	db   "Boosts Electric-"
	next "type moves. (Hold)@"

TwistedSpoonDesc:
	db   "Powers up Psychic-"
	next "type moves. (Hold)@"

NeverMeltIceDesc:
	db   "Powers up Ice-type"
	next "moves. (Hold)@"

DragonFangDesc:
	db   "Powers up Dragon-"
	next "type moves. (Hold)@"

BlackGlassesDesc:
	db   "Powers up Dark-"
	next "type moves. (Hold)@"

PinkBowDesc:
	db   "Powers up Fairy-"
	next "type moves. (Hold)@"

BrightPowderDesc:
	db   "Lowers the foe's"
	next "accuracy. (Hold)@"

ScopeLensDesc:
	db   "Raises critical"
	next "hit ratio. (Hold)@"

QuickClawDesc:
	db   "Raises 1st strike"
	next "ratio. (Hold)@"

KingsRockDesc:
	db   "May make the foe"
	next "flinch. (Hold)@"

FocusBandDesc:
	db   "May prevent faint-"
	next "ing. (Hold)@"

LeftoversDesc:
	db   "Restores HP during"
	next "battle. (Hold)@"

LuckyEggDesc:
	db   "Earns extra Exp."
	next "points. (Hold)@"

AmuletCoinDesc:
	db   "Doubles monetary"
	next "earnings. (Hold)@"

CleanseTagDesc:
	db   "Helps repel wild"
	next "#mon. (Hold)@"

SmokeBallDesc:
	db   "Escape from wild"
	next "#mon. (Hold)@"

LightBallDesc:
	db   "An odd, electrical"
	next "orb. (Hold)@"

StickDesc:
	db   "An ordinary stick."
	next "Sell low.@"

ThickClubDesc:
	db   "A bone of some"
	next "sort. Sell low.@"

LuckyPunchDesc:
	db   "Ups critical hit"
	next "ratio of Chansey.@"

MetalPowderDesc:
	db   "Raises Defense of"
	next "Ditto. (Hold)@"

BerserkGeneDesc:
	db   "Boosts Attack but"
	next "causes confusion.@"

EvioliteDesc:
	db   "Ups Def and Spcl."
	next "Def of evolvers.@"

MuscleBandDesc:
	db   "Powers up physical"
	next "moves. (Hold)@"

WiseGlassesDesc:
	db   "Powers up special"
	next "moves. (Hold)@"

DragonScaleDesc:
	db   "A rare Dragon-type"
	next "item.@"

UpGradeDesc:
	db   "A mysterious box"
	next "made by Silph Co.@"

DubiousDiscDesc:
	db   "A transparent disc"
	next "of unknown origin.@"

ProtectorDesc:
	db   "A protective item."
	next "Stiff and heavy.@"

ElectirizerDesc:
	db   "A box packed with"
	next "electric energy.@"

MagmarizerDesc:
	db   "A box packed with"
	next "magma energy.@"

RazorFangDesc:
	db   "May make the foe"
	next "flinch. (Hold)@"

RazorClawDesc:
	db   "Raises critical"
	next "hit ratio. (Hold)@"

NuggetDesc:
	db   "Made of pure gold."
	next "Sell high.@"

TinyMushroomDesc:
	db   "An ordinary mush-"
	next "room. Sell low.@"

BigMushroomDesc:
	db   "A rare mushroom."
	next "Sell high.@"

PearlDesc:
	db   "A beautiful pearl."
	next "Sell low.@"

BigPearlDesc:
	db   "A big, beautiful"
	next "pearl. Sell high.@"

StardustDesc:
	db   "Pretty, red sand."
	next "Sell high.@"

StarPieceDesc:
	db   "A hunk of red gem."
	next "Sell very high.@"

SilverLeafDesc:
	db   "A strange, silver-"
	next "colored leaf.@"

GoldLeafDesc:
	db   "A strange, gold-"
	next "colored leaf.@"

SlowpokeTailDesc:
	db   "Very tasty. Sell"
	next "high.@"

ParkBallDesc:
	db   "The Bug-Catching"
	next "Contest Ball.@"

RepeatBallDesc:
	db   "A Ball for #mon"
	next "caught before.@"

TimerBallDesc:
	db   "A Ball for late"
	next "in a battle.@"

QuickBallDesc:
	db   "A Ball for early"
	next "in a battle.@"

DuskBallDesc:
	db   "A Ball for night-"
	next "time or caves.@"

HelixFossilDesc:
	db   "A fossilized"
	next "#mon shell.@"

DomeFossilDesc:
	db   "A fossilized"
	next "#mon shell.@"

OldAmberDesc:
	db   "Fossilized resin"
	next "containing DNA.@"

FlowerMailDesc:
	db   "Flower-print Mail."
	next "(Hold)@"

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

MirageMailDesc:
	db   "Mew-print Mail."
	next "(Hold)@"

TeruSamaDesc:
	db   "?@"
