; Format:
;	Address
;	Length, Bank
;	Type, Palette

sprite_header: MACRO
; pointer, length, type, palette
	dw \1
	db \2 * 4 tiles, BANK(\1)
	db \3, \4
ENDM

ChrisSprite: ; 14736
	sprite_header ChrisSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED
; 1473c

ChrisBikeSprite: ; 1473c
	sprite_header ChrisBikeSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED
; 14742

KrisSprite: ; 14970
	sprite_header KrisSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE
; 14976

KrisBikeSprite: ; 14976
	sprite_header KrisBikeSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE
; 1497c

MomSprite: ; 14778
	sprite_header MomSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED
; 1477e

DadSprite: ; 148aa
	sprite_header DadSpriteGFX, 3, STANDING_SPRITE, PAL_OW_BROWN
; 148b0

LyraSprite:
	sprite_header LyraSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

SilverSprite: ; 14748
	sprite_header SilverSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED
; 1474e

FalknerSprite: ; 1479c
	sprite_header FalknerSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE
; 147a2

BugsySprite: ; 147a8
	sprite_header BugsySpriteGFX, 3, WALKING_SPRITE, PAL_OW_GREEN
; 147ae

WhitneySprite: ; 147a2
	sprite_header WhitneySpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED
; 147a8

MortySprite: ; 147ae
	sprite_header MortySpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN
; 147b4

ChuckSprite: ; 147b4
	sprite_header ChuckSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED
; 147ba

JasmineSprite: ; 147ba
	sprite_header JasmineSpriteGFX, 3, WALKING_SPRITE, PAL_OW_GREEN
; 147c0

PryceSprite: ; 147c0
	sprite_header PryceSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN
; 147c6

ClairSprite: ; 147c6
	sprite_header ClairSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED
; 147cc

WillSprite: ; 14796
	sprite_header WillSpriteGFX, 3, STANDING_SPRITE, PAL_OW_RED
; 1479c

KogaSprite: ; 147f6
	sprite_header KogaSpriteGFX, 3, WALKING_SPRITE, PAL_OW_PURPLE
; 147fc

BrunoSprite: ; 147d8
	sprite_header BrunoSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED
; 147de

KarenSprite: ; 147d2
	sprite_header KarenSpriteGFX, 3, STANDING_SPRITE, PAL_OW_BLUE
; 147d8

LanceSprite: ; 147e4
	sprite_header LanceSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED
; 147ea

BrockSprite: ; 147cc
	sprite_header BrockSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN
; 147d2

MistySprite: ; 147de
	sprite_header MistySpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE
; 147e4

SurgeSprite: ; 147ea
	sprite_header SurgeSpriteGFX, 3, WALKING_SPRITE, PAL_OW_GREEN
; 147f0

ErikaSprite: ; 147f0
	sprite_header ErikaSpriteGFX, 3, WALKING_SPRITE, PAL_OW_GREEN
; 147f6

JanineSprite: ; 1476c
	sprite_header JanineSpriteGFX, 3, WALKING_SPRITE, PAL_OW_PURPLE
; 14772

SabrinaSprite: ; 147fc
	sprite_header SabrinaSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED
; 14802

BlaineSprite: ; 1477e
	sprite_header BlaineSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN
; 14784

BlueSprite: ; 1475a
	sprite_header BlueSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE
; 14760

RedSprite: ; 14754
	sprite_header RedSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED
; 1475a

LeafSprite:
	sprite_header LeafSpriteGFX, 3, WALKING_SPRITE, PAL_OW_GREEN

YellowSprite:
	sprite_header YellowSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

OakSprite: ; 1474e
	sprite_header OakSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN
; 14754

ElmSprite: ; 14790
	sprite_header ElmSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN
; 14796

IvySprite:
	sprite_header IvySpriteGFX, 3, WALKING_SPRITE, PAL_OW_PURPLE

BillSprite: ; 14760
	sprite_header BillSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED
; 14766

KurtSprite: ; 14772
	sprite_header KurtSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN
; 14778

RedsMomSprite: ; 14784
	sprite_header RedsMomSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED
; 1478a

DaisySprite: ; 1478a
	sprite_header DaisySpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE
; 14790

LoreleiSprite:
	sprite_header LoreleiSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

AgathaSprite:
	sprite_header AgathaSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN

PalmerSprite:
	sprite_header PalmerSpriteGFX, 3, WALKING_SPRITE, PAL_OW_GREEN

WalkerSprite:
	sprite_header WalkerSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

LawrenceSprite:
	sprite_header LawrenceSpriteGFX, 3, WALKING_SPRITE, PAL_OW_GREEN

JamesSprite:
	sprite_header JamesSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

JessieSprite:
	sprite_header JessieSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

ProtonSprite:
	sprite_header ProtonSpriteGFX, 3, WALKING_SPRITE, PAL_OW_GREEN

PetrelSprite:
	sprite_header PetrelSpriteGFX, 3, WALKING_SPRITE, PAL_OW_PURPLE

ArcherSprite:
	sprite_header ArcherSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

ArianaSprite:
	sprite_header ArianaSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

GiovanniSprite:
	sprite_header GiovanniSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN

CherylSprite:
	sprite_header CherylSpriteGFX, 3, WALKING_SPRITE, PAL_OW_GREEN

RileySprite:
	sprite_header RileySpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

BuckSprite:
	sprite_header BuckSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

MarleySprite:
	sprite_header MarleySpriteGFX, 3, WALKING_SPRITE, PAL_OW_PURPLE

MiraSprite:
	sprite_header MiraSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

ValerieSprite:
	sprite_header ValerieSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

CaitlinSprite:
	sprite_header CaitlinSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

DarachSprite:
	sprite_header DarachSpriteGFX, 3, WALKING_SPRITE, PAL_OW_PURPLE

StevenSprite:
	sprite_header StevenSpriteGFX, 3, WALKING_SPRITE, PAL_OW_PURPLE

CynthiaSprite:
	sprite_header CynthiaSpriteGFX, 3, WALKING_SPRITE, PAL_OW_PURPLE

ElderSprite: ; 14766
	sprite_header ElderSpriteGFX, 3, WALKING_SPRITE, PAL_OW_GREEN
; 1476c

CaptainSprite: ; 148d4
	sprite_header CaptainSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN
; 148da

BikerSprite: ; 148ec
	sprite_header BikerSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN
; 148f2

BlackBeltSprite: ; 148b6
	sprite_header BlackBeltSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN
; 148bc

BreederSprite:
	sprite_header BreederSpriteGFX, 3, WALKING_SPRITE, PAL_OW_GREEN

BuenaSprite: ; 1482c
	sprite_header BuenaSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE
; 14832

BugCatcherSprite: ; 1480e
	sprite_header BugCatcherSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE
; 14814

CooltrainerFSprite: ; 14808
	sprite_header CooltrainerFSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE
; 1480e

CooltrainerMSprite: ; 14802
	sprite_header CooltrainerMSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE
; 14808

CowgirlSprite:
	sprite_header CowgirlSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN

DragonTamerSprite:
	sprite_header DragonTamerSpriteGFX, 3, WALKING_SPRITE, PAL_OW_PURPLE

FisherSprite: ; 1488c
	sprite_header FisherSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE
; 14892

GentlemanSprite: ; 148b0
	sprite_header GentlemanSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE
; 148b6

GrampsSprite: ; 1484a
	sprite_header GrampsSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN
; 14850

GrannySprite: ; 14850
	sprite_header GrannySpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN
; 14856

HexManiacSprite:
	sprite_header HexManiacSpriteGFX, 3, WALKING_SPRITE, PAL_OW_PURPLE

KimonoGirlSprite: ; 1489e
	sprite_header KimonoGirlSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED
; 148a4

LadySprite:
	sprite_header LadySpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

LassSprite: ; 14820
	sprite_header LassSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED
; 14826

OfficerSprite: ; 148c2
	sprite_header OfficerSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE
; 148c8

OfficerFSprite:
	sprite_header OfficerFSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

PharmacistSprite: ; 148f2
	sprite_header PharmacistSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE
; 148f8

PISprite:
	sprite_header PISpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN

PokefanFSprite: ; 14844
	sprite_header PokefanFSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN
; 1484a

PokefanMSprite: ; 1483e
	sprite_header PokefanMSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN
; 14844

RichBoySprite:
	sprite_header RichBoySpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

RockerSprite: ; 14838
	sprite_header RockerSpriteGFX, 3, WALKING_SPRITE, PAL_OW_GREEN
; 1483e

RocketSprite: ; 1486e
	sprite_header RocketSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN
; 14874

RocketGirlSprite: ; 14874
	sprite_header RocketGirlSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN
; 1487a

SageSprite: ; 148a4
	sprite_header SageSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN
; 148aa

SailorSprite: ; 148e6
	sprite_header SailorSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE
; 148ec

ScientistSprite: ; 14898
	sprite_header ScientistSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE
; 1489e

SuperNerdSprite: ; 14832
	sprite_header SuperNerdSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE
; 14838

SwimmerGirlSprite: ; 1485c
	sprite_header SwimmerGirlSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE
; 14862

SwimmerGuySprite: ; 14856
	sprite_header SwimmerGuySpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE
; 1485c

TeacherSprite: ; 14826
	sprite_header TeacherSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED
; 1482c

TwinSprite: ; 14814
	sprite_header TwinSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED
; 1481a

VeteranMSprite:
	sprite_header VeteranMSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN

VeteranFSprite:
	sprite_header VeteranFSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN

YoungsterSprite: ; 1481a
	sprite_header YoungsterSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE
; 14820

NurseSprite: ; 1487a
	sprite_header NurseSpriteGFX, 3, STANDING_SPRITE, PAL_OW_RED
; 14880

ClerkSprite: ; 14886
	sprite_header ClerkSpriteGFX, 3, WALKING_SPRITE, PAL_OW_GREEN
; 1488c

ReceptionistSprite: ; 148bc
	sprite_header ReceptionistSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE
; 148c2

LinkReceptionistSprite: ; 14880
	sprite_header LinkReceptionistSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED
; 14886

GymGuySprite: ; 148e0
	sprite_header GymGuySpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE
; 148e6

FishingGuruSprite: ; 14892
	sprite_header FishingGuruSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE
; 14898

GameboyKidSprite: ; 14742
	sprite_header GameboyKidSpriteGFX, 3, STANDING_SPRITE, PAL_OW_GREEN
; 14748

StandingYoungsterSprite: ; 14994
	sprite_header StandingYoungsterSpriteGFX, 3, STANDING_SPRITE, PAL_OW_BLUE
; 1499a

SwimmingOfficerSprite:
	sprite_header SwimmingOfficerSpriteGFX, 3, STANDING_SPRITE, PAL_OW_BLUE

SwimmingOfficerFSprite:
	sprite_header SwimmingOfficerFSpriteGFX, 3, STANDING_SPRITE, PAL_OW_BLUE

CalSprite: ; 148c8
	sprite_header CalSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN
; 148ce

KurtOutsideSprite: ; 1497c
	sprite_header KurtOutsideSpriteGFX, 3, STANDING_SPRITE, PAL_OW_BROWN
; 14982

SurfSprite: ; 14922
	sprite_header SurfSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE
; 14928

SurfingPikachuSprite: ; 14868
	sprite_header SurfingPikachuSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED
; 1486e

BirdSprite: ; 14904
	sprite_header BirdSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED
; 1490a

FairySprite: ; 148fe
	sprite_header FairySpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED
; 14904

DragoniteSprite: ; 1490a
	sprite_header DragoniteSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED
; 14910

ArmoredMewtwoSprite:
	sprite_header ArmoredMewtwoSpriteGFX, 3, WALKING_SPRITE, PAL_OW_PURPLE

MewSprite:
	sprite_header MewSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

CelebiSprite:
	sprite_header CelebiSpriteGFX, 3, WALKING_SPRITE, PAL_OW_GREEN

BigSnorlaxSprite: ; 14862
	sprite_header BigSnorlaxSpriteGFX, 3, STANDING_SPRITE, PAL_OW_BLUE
; 14868

BigLaprasSprite: ; 148da
	sprite_header BigLaprasSpriteGFX, 3, STANDING_SPRITE, PAL_OW_BLUE
; 148e0

BigOnixSprite: ; 14910
	sprite_header BigOnixSpriteGFX, 3, STANDING_SPRITE, PAL_OW_BROWN
; 14916

WeirdTreeSprite: ; 1491c
	sprite_header WeirdTreeSpriteGFX, 3, STANDING_SPRITE, PAL_OW_GREEN
; 14922

UnownWSprite:
	sprite_header UnownWSpriteGFX, 3, STANDING_SPRITE, PAL_OW_PURPLE

UnownASprite:
	sprite_header UnownASpriteGFX, 3, STANDING_SPRITE, PAL_OW_PURPLE

UnownRSprite:
	sprite_header UnownRSpriteGFX, 3, STANDING_SPRITE, PAL_OW_PURPLE

UnownPSprite:
	sprite_header UnownPSpriteGFX, 3, STANDING_SPRITE, PAL_OW_PURPLE

GyaradosTopLeftSprite:
	sprite_header GyaradosTopLeftSpriteGFX, 3, STANDING_SPRITE, PAL_OW_RED

GyaradosTopRightSprite:
	sprite_header GyaradosTopRightSpriteGFX, 3, STANDING_SPRITE, PAL_OW_RED

GyaradosBottomLeftSprite:
	sprite_header GyaradosBottomLeftSpriteGFX, 3, STANDING_SPRITE, PAL_OW_RED

GyaradosBottomRightSprite:
	sprite_header GyaradosBottomRightSpriteGFX, 3, STANDING_SPRITE, PAL_OW_RED

PokeBallSprite: ; 14928
	sprite_header PokeBallSpriteGFX, 1, STILL_SPRITE, PAL_OW_RED
; 1492e

PokedexSprite:
	sprite_header PokedexSpriteGFX, 1, STILL_SPRITE, PAL_OW_RED

BookSprite: ; 1492e
	sprite_header BookSpriteGFX, 1, STILL_SPRITE, PAL_OW_BROWN
; 14934

PaperSprite: ; 14934
	sprite_header PaperSpriteGFX, 1, STILL_SPRITE, PAL_OW_BLUE
; 1493a

RockSprite: ; 14946
	sprite_header RockSpriteGFX, 1, STILL_SPRITE, PAL_OW_ROCK
; 1494c

BoulderSprite: ; 1494c
	sprite_header BoulderSpriteGFX, 1, STILL_SPRITE, PAL_OW_ROCK
; 14952

CutTreeSprite:
	sprite_header CutTreeSpriteGFX, 1, STILL_SPRITE, PAL_OW_TREE

FruitTreeSprite: ; 1495e
	sprite_header FruitTreeSpriteGFX, 1, STILL_SPRITE, PAL_OW_TREE
; 14964

ElectricFenceLeftSprite:
	sprite_header ElectricFenceLeftSpriteGFX, 3, STANDING_SPRITE, PAL_OW_SILVER

ElectricFenceRightSprite:
	sprite_header ElectricFenceRightSpriteGFX, 3, STANDING_SPRITE, PAL_OW_SILVER

FossilSprite:
	sprite_header FossilSpriteGFX, 1, STILL_SPRITE, PAL_OW_BROWN

SnesSprite: ; 14952
	sprite_header SnesSpriteGFX, 1, STILL_SPRITE, PAL_OW_RED
; 14958

N64Sprite: ; 14916
	sprite_header N64SpriteGFX, 1, STILL_SPRITE, PAL_OW_BROWN
; 1491c

GameCubeSprite: ; 1493a
	sprite_header GameCubeSpriteGFX, 1, STILL_SPRITE, PAL_OW_PURPLE
; 14940

WiiSprite: ; 14958
	sprite_header WiiSpriteGFX, 1, STILL_SPRITE, PAL_OW_BLUE
; 1495e

SilverTrophySprite: ; 1496a
	sprite_header SilverTrophySpriteGFX, 1, STILL_SPRITE, PAL_OW_SILVER
; 14970

GoldTrophySprite: ; 14964
	sprite_header GoldTrophySpriteGFX, 1, STILL_SPRITE, PAL_OW_BROWN
; 1496a
