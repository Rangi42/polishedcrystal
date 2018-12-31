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

ChrisSprite:
	sprite_header ChrisSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

ChrisBikeSprite:
	sprite_header ChrisBikeSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

ChrisSurfSprite:
	sprite_header ChrisSurfSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

KrisSprite:
	sprite_header KrisSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

KrisBikeSprite:
	sprite_header KrisBikeSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

KrisSurfSprite:
	sprite_header KrisSurfSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

MomSprite:
	sprite_header MomSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

DadSprite:
	sprite_header DadSpriteGFX, 3, STANDING_SPRITE, PAL_OW_BROWN

LyraSprite:
	sprite_header LyraSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

SilverSprite:
	sprite_header SilverSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

FalknerSprite:
	sprite_header FalknerSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

BugsySprite:
	sprite_header BugsySpriteGFX, 3, WALKING_SPRITE, PAL_OW_GREEN

WhitneySprite:
	sprite_header WhitneySpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

MortySprite:
	sprite_header MortySpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN

ChuckSprite:
	sprite_header ChuckSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

JasmineSprite:
	sprite_header JasmineSpriteGFX, 3, WALKING_SPRITE, PAL_OW_GREEN

PryceSprite:
	sprite_header PryceSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN

ClairSprite:
	sprite_header ClairSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

WillSprite:
	sprite_header WillSpriteGFX, 3, STANDING_SPRITE, PAL_OW_RED

KogaSprite:
	sprite_header KogaSpriteGFX, 3, WALKING_SPRITE, PAL_OW_PURPLE

BrunoSprite:
	sprite_header BrunoSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

KarenSprite:
	sprite_header KarenSpriteGFX, 3, STANDING_SPRITE, PAL_OW_BLUE

LanceSprite:
	sprite_header LanceSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

BrockSprite:
	sprite_header BrockSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN

MistySprite:
	sprite_header MistySpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

SurgeSprite:
	sprite_header SurgeSpriteGFX, 3, WALKING_SPRITE, PAL_OW_GREEN

ErikaSprite:
	sprite_header ErikaSpriteGFX, 3, WALKING_SPRITE, PAL_OW_GREEN

JanineSprite:
	sprite_header JanineSpriteGFX, 3, WALKING_SPRITE, PAL_OW_PURPLE

SabrinaSprite:
	sprite_header SabrinaSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

BlaineSprite:
	sprite_header BlaineSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN

BlueSprite:
	sprite_header BlueSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

RedSprite:
	sprite_header RedSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

LeafSprite:
	sprite_header LeafSpriteGFX, 3, WALKING_SPRITE, PAL_OW_GREEN

YellowSprite:
	sprite_header YellowSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

OakSprite:
	sprite_header OakSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN

ElmSprite:
	sprite_header ElmSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN

IvySprite:
	sprite_header IvySpriteGFX, 3, WALKING_SPRITE, PAL_OW_PURPLE

WestwoodSprite:
	sprite_header WestwoodSpriteGFX, 3, STANDING_SPRITE, PAL_OW_BROWN

WillowSprite:
	sprite_header WillowSpriteGFX, 3, STANDING_SPRITE, PAL_OW_BROWN

AndySprite:
	sprite_header AndySpriteGFX, 3, STANDING_SPRITE, PAL_OW_RED

BillSprite:
	sprite_header BillSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

EusineSprite:
	sprite_header EusineSpriteGFX, 3, WALKING_SPRITE, PAL_OW_PURPLE

KurtSprite:
	sprite_header KurtSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN

RedsMomSprite:
	sprite_header RedsMomSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

DaisySprite:
	sprite_header DaisySpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

LoreleiSprite:
	sprite_header LoreleiSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

AgathaSprite:
	sprite_header AgathaSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN

PalmerSprite:
	sprite_header PalmerSpriteGFX, 3, WALKING_SPRITE, PAL_OW_GREEN

WalkerSprite:
	sprite_header WalkerSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

ImakuniSprite:
	sprite_header ImakuniSpriteGFX, 3, WALKING_SPRITE, PAL_OW_PURPLE

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
	sprite_header ArcherSpriteGFX, 3, STANDING_SPRITE, PAL_OW_BLUE

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

AnabelSprite:
	sprite_header AnabelSpriteGFX, 3, WALKING_SPRITE, PAL_OW_PURPLE

FlannerySprite:
	sprite_header FlannerySpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

MayleneSprite:
	sprite_header MayleneSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

SkylaSprite:
	sprite_header SkylaSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

ValerieSprite:
	sprite_header ValerieSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

KukuiSprite:
	sprite_header KukuiSpriteGFX, 3, STANDING_SPRITE, PAL_OW_BROWN

CaitlinSprite:
	sprite_header CaitlinSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

DarachSprite:
	sprite_header DarachSpriteGFX, 3, WALKING_SPRITE, PAL_OW_PURPLE

StevenSprite:
	sprite_header StevenSpriteGFX, 3, WALKING_SPRITE, PAL_OW_PURPLE

CynthiaSprite:
	sprite_header CynthiaSpriteGFX, 3, WALKING_SPRITE, PAL_OW_PURPLE

CandelaSprite:
	sprite_header CandelaSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

BlancheSprite:
	sprite_header BlancheSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

SparkSprite:
	sprite_header SparkSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

BuenaSprite:
	sprite_header BuenaSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

CaptainSprite:
	sprite_header CaptainSpriteGFX, 3, STANDING_SPRITE, PAL_OW_BROWN

MatsumotoSprite:
	sprite_header MatsumotoSpriteGFX, 3, STANDING_SPRITE, PAL_OW_BLUE

ArtistSprite:
	sprite_header ArtistSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

BakerSprite:
	sprite_header BakerSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

BeautySprite:
	sprite_header BeautySpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

BikerSprite:
	sprite_header BikerSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN

BlackBeltSprite:
	sprite_header BlackBeltSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN

BoarderSprite:
	sprite_header BoarderSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

BreederSprite:
	sprite_header BreederSpriteGFX, 3, WALKING_SPRITE, PAL_OW_GREEN

BugCatcherSprite:
	sprite_header BugCatcherSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

BugManiacSprite:
	sprite_header BugManiacSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

ChildSprite:
	sprite_header ChildSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN

CooltrainerFSprite:
	sprite_header CooltrainerFSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

CooltrainerMSprite:
	sprite_header CooltrainerMSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

CosplayerSprite:
	sprite_header CosplayerSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

CowgirlSprite:
	sprite_header CowgirlSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN

DragonTamerSprite:
	sprite_header DragonTamerSpriteGFX, 3, WALKING_SPRITE, PAL_OW_PURPLE

ElderSprite:
	sprite_header ElderSpriteGFX, 3, WALKING_SPRITE, PAL_OW_GREEN

EngineerSprite:
	sprite_header EngineerSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

FisherSprite:
	sprite_header FisherSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

GentlemanSprite:
	sprite_header GentlemanSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

GrampsSprite:
	sprite_header GrampsSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN

GrannySprite:
	sprite_header GrannySpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN

HexManiacSprite:
	sprite_header HexManiacSpriteGFX, 3, WALKING_SPRITE, PAL_OW_PURPLE

KimonoGirlSprite:
	sprite_header KimonoGirlSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

LadySprite:
	sprite_header LadySpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

LassSprite:
	sprite_header LassSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

NurseSprite:
	sprite_header NurseSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

OfficerSprite:
	sprite_header OfficerSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

OfficerFSprite:
	sprite_header OfficerFSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

PharmacistSprite:
	sprite_header PharmacistSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

PISprite:
	sprite_header PISpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN

PokefanFSprite:
	sprite_header PokefanFSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN

PokefanMSprite:
	sprite_header PokefanMSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN

RichBoySprite:
	sprite_header RichBoySpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

RockerSprite:
	sprite_header RockerSpriteGFX, 3, WALKING_SPRITE, PAL_OW_GREEN

RocketSprite:
	sprite_header RocketSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN

RocketGirlSprite:
	sprite_header RocketGirlSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN

RoughneckSprite:
	sprite_header RoughneckSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

SageSprite:
	sprite_header SageSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN

SailorSprite:
	sprite_header SailorSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

ScientistSprite:
	sprite_header ScientistSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

SightseerMSprite:
	sprite_header SightseerMSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

SkierSprite:
	sprite_header SkierSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

SuperNerdSprite:
	sprite_header SuperNerdSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

SwimmerGirlSprite:
	sprite_header SwimmerGirlSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

SwimmerGuySprite:
	sprite_header SwimmerGuySpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

TeacherSprite:
	sprite_header TeacherSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

TwinSprite:
	sprite_header TwinSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

VeteranMSprite:
	sprite_header VeteranMSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN

VeteranFSprite:
	sprite_header VeteranFSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN

YoungsterSprite:
	sprite_header YoungsterSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

BowingNurseSprite:
	sprite_header BowingNurseSpriteGFX, 3, STANDING_SPRITE, PAL_OW_RED

ClerkSprite:
	sprite_header ClerkSpriteGFX, 3, WALKING_SPRITE, PAL_OW_GREEN

ReceptionistSprite:
	sprite_header ReceptionistSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

LinkReceptionistSprite:
	sprite_header LinkReceptionistSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

GymGuySprite:
	sprite_header GymGuySpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

FishingGuruSprite:
	sprite_header FishingGuruSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

GameboyKidSprite:
	sprite_header GameboyKidSpriteGFX, 3, STANDING_SPRITE, PAL_OW_GREEN

SilphEmployeeSprite:
	sprite_header SilphEmployeeSpriteGFX, 3, STANDING_SPRITE, PAL_OW_BROWN

SwimmingOfficerSprite:
	sprite_header SwimmingOfficerSpriteGFX, 3, STANDING_SPRITE, PAL_OW_BLUE

SwimmingOfficerFSprite:
	sprite_header SwimmingOfficerFSpriteGFX, 3, STANDING_SPRITE, PAL_OW_BLUE

ClefairyWalkSprite:
	sprite_header ClefairyWalkSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

FarfetchDSprite:
	sprite_header FarfetchDSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN

LaprasSprite:
	sprite_header LaprasSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BLUE

EeveeSprite:
	sprite_header EeveeSpriteGFX, 3, WALKING_SPRITE, PAL_OW_BROWN

DragoniteSprite:
	sprite_header DragoniteSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

MewSprite:
	sprite_header MewSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

CelebiSprite:
	sprite_header CelebiSpriteGFX, 3, WALKING_SPRITE, PAL_OW_GREEN

SurfingPikachuSprite:
	sprite_header SurfingPikachuSpriteGFX, 3, WALKING_SPRITE, PAL_OW_RED

ArmoredMewtwoSprite:
	sprite_header ArmoredMewtwoSpriteGFX, 3, WALKING_SPRITE, PAL_OW_PURPLE

BigSnorlaxSprite:
	sprite_header BigSnorlaxSpriteGFX, 3, STANDING_SPRITE, PAL_OW_BLUE

BigLaprasSprite:
	sprite_header BigLaprasSpriteGFX, 3, STANDING_SPRITE, PAL_OW_BLUE

BigOnixSprite:
	sprite_header BigOnixSpriteGFX, 3, STANDING_SPRITE, PAL_OW_BROWN

BigGyaradosSprite:
; sprite_header BigGyaradosSpriteGFX, 4, BIG_GYARADOS_SPRITE, PAL_OW_RED
	dw BigGyaradosSpriteGFX
	db 15 tiles, BANK(BigGyaradosSpriteGFX)
	db BIG_GYARADOS_SPRITE, PAL_OW_RED

SlowpoketailSprite:
	sprite_header SlowpoketailSpriteGFX, 3, STANDING_SPRITE, PAL_OW_PURPLE

WeirdTreeSprite:
	sprite_header WeirdTreeSpriteGFX, 3, STANDING_SPRITE, PAL_OW_GREEN

BallCutFruitSprite:
	sprite_header BallCutFruitSpriteGFX, 3, STANDING_SPRITE, PAL_OW_TREE

BoulderRockFossilSprite:
	sprite_header BoulderRockFossilSpriteGFX, 3, STANDING_SPRITE, PAL_OW_ROCK

PaperSprite:
	sprite_header PaperSpriteGFX, 3, STANDING_SPRITE, PAL_OW_PURPLE

PokedexSprite:
	sprite_header PokedexSpriteGFX, 3, STANDING_SPRITE, PAL_OW_PURPLE

BookSprite:
	sprite_header BookSpriteGFX, 3, STANDING_SPRITE, PAL_OW_PURPLE

ElectricFenceLeftSprite:
	sprite_header ElectricFenceLeftSpriteGFX, 3, STANDING_SPRITE, PAL_OW_SILVER

ElectricFenceRightSprite:
	sprite_header ElectricFenceRightSpriteGFX, 3, STANDING_SPRITE, PAL_OW_SILVER

SnesSprite:
	sprite_header SnesSpriteGFX, 3, STANDING_SPRITE, PAL_OW_RED

N64Sprite:
	sprite_header N64SpriteGFX, 3, STANDING_SPRITE, PAL_OW_BROWN

GameCubeSprite:
	sprite_header GameCubeSpriteGFX, 3, STANDING_SPRITE, PAL_OW_PURPLE

WiiSprite:
	sprite_header WiiSpriteGFX, 3, STANDING_SPRITE, PAL_OW_BLUE

SilverTrophySprite:
	sprite_header SilverTrophySpriteGFX, 1, STILL_SPRITE, PAL_OW_SILVER

GoldTrophySprite:
	sprite_header GoldTrophySpriteGFX, 1, STILL_SPRITE, PAL_OW_BROWN
