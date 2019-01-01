OutdoorSprites: ; 144b8
; Valid sprite IDs for each map group.
; Maximum 9 walking sprites and 18-32 total sprites used per group.
	dw Group1Sprites
	dw Group2Sprites
	dw Group3Sprites
	dw Group4Sprites
	dw Group5Sprites
	dw Group6Sprites
	dw Group7Sprites
	dw Group8Sprites
	dw Group9Sprites
	dw Group10Sprites
	dw Group11Sprites
	dw Group12Sprites
	dw Group13Sprites
	dw Group14Sprites
	dw Group15Sprites
	dw Group16Sprites
	dw Group17Sprites
	dw Group18Sprites
	dw Group19Sprites
	dw Group20Sprites
	dw Group21Sprites
	dw Group22Sprites
	dw Group23Sprites
	dw Group24Sprites
	dw Group25Sprites
	dw Group26Sprites
	dw Group27Sprites
	dw Group28Sprites
	dw Group29Sprites
	dw Group30Sprites
	dw Group31Sprites
	dw Group32Sprites
	dw Group33Sprites
	dw Group34Sprites
	dw Group35Sprites
	dw Group36Sprites


; OlivineCity connects to Route40
Group1Sprites:
; Route38
; Route39
; OlivineCity
; Route35Coast
Group22Sprites:
; Route40
; Route41
; CianwoodCity
; BattleTowerOutside
Group29Sprites:
; GoldenrodHarbor
	db SPRITE_BEAUTY
	db SPRITE_FISHER
	db SPRITE_LASS
	db SPRITE_POKEFAN_F
	db SPRITE_POKEFAN_M
	db SPRITE_SAILOR
	db SPRITE_SWIMMER_GIRL
	db SPRITE_SWIMMER_GUY
	db SPRITE_OLIVINE_RIVAL ; SPRITE_SILVER, SPRITE_EUSINE, SPRITE_COWGIRL
	db SPRITE_YOUNGSTER ; doesn't walk
	db SPRITE_ROCKET ; doesn't walk
	; 11 walking sprites (9 that walk)
	db SPRITE_BALL_CUT_FRUIT
	db SPRITE_BOULDER_ROCK_FOSSIL
	db SPRITE_BIG_LAPRAS
	db SPRITE_MAGIKARP
	db SPRITE_MILTANK
	db SPRITE_SUICUNE
	; 17 total sprites
	db 0


; Route42 connects to VioletOutskirts
; Route32 connects to CherrygroveBay
; Route29 connects to CherrygroveCity
Group2Sprites:
; Route42
; Route44
; MahoganyTown
Group10Sprites:
; Route32
; VioletCity
; MagnetTunnelEast
; VioletOutskirts
Group24Sprites:
; Route26
; Route27
; Route29
; NewBarkTown
Group26Sprites:
; Route30
; Route31
; CherrygroveBay
; CherrygroveCity
	db SPRITE_NEW_BARK_LYRA ; SPRITE_LYRA, SPRITE_LASS
	db SPRITE_CHERRYGROVE_RIVAL ; SPRITE_SILVER, SPRITE_BUG_CATCHER
	db SPRITE_GUIDE_GENT ; SPRITE_GRAMPS, SPRITE_SWIMMER_GUY
	db SPRITE_NEW_BARK_TEACHER ; SPRITE_TEACHER, SPRITE_OFFICER, SPRITE_POKEFAN_M, SPRITE_DRAGON_TAMER
	db SPRITE_COOLTRAINER_F
	db SPRITE_COOLTRAINER_M
	db SPRITE_FISHER
	db SPRITE_SWIMMER_GIRL
	db SPRITE_YOUNGSTER
	db SPRITE_GRAMPS ; doesn't walk
	db SPRITE_TEACHER ; doesn't walk
	db SPRITE_POKEFAN_M ; doesn't walk
	db SPRITE_SUPER_NERD ; doesn't walk
	db SPRITE_VETERAN_F ; doesn't walk
	db SPRITE_VETERAN_M ; doesn't walk
	db SPRITE_COSPLAYER ; doesn't walk
	; 16 walking sprites (9 that walk)
	db SPRITE_BALL_CUT_FRUIT
	db SPRITE_BOULDER_ROCK_FOSSIL
	db SPRITE_ROUTE_30_RATTATA ; SPRITE_RATTATA, SPRITE_SUICUNE
	db SPRITE_PIDGEY
	; 21 total sprites
	db 0


Group3Sprites:
; NationalPark
; NationalParkBugContest
	db SPRITE_BUG_CATCHER
	db SPRITE_BUG_MANIAC
	db SPRITE_COOLTRAINER_M
	db SPRITE_LASS
	db SPRITE_POKEFAN_F
	db SPRITE_POKEFAN_M
	db SPRITE_TEACHER
	db SPRITE_TWIN
	db SPRITE_YOUNGSTER
	db SPRITE_OFFICER ; doesn't walk
	; 10 walking sprites (9 that walk)
	db SPRITE_BALL_CUT_FRUIT
	db SPRITE_GAMEBOY_KID
	db SPRITE_PERSIAN
	; 13 total sprites
	db 0


; EcruteakCity connects to Route36
Group4Sprites:
; EcruteakCity
; Route37
Group36Sprites:
; Route35
; Route36
	db SPRITE_BREEDER
	db SPRITE_BEAUTY
	db SPRITE_BUG_CATCHER
	db SPRITE_FISHER
	db SPRITE_GRAMPS
	db SPRITE_LASS
	db SPRITE_SUPER_NERD
	db SPRITE_TWIN
	db SPRITE_YOUNGSTER
	db SPRITE_COOLTRAINER_F ; doesn't walk
	db SPRITE_SIGHTSEER_M ; doesn't walk
	db SPRITE_HEX_MANIAC ; doesn't walk
	db SPRITE_OFFICER ; doesn't walk
	; 13 walking sprites (9 that walk)
	db SPRITE_BALL_CUT_FRUIT
	db SPRITE_MISC_OVERHEAD
	db SPRITE_WEIRD_TREE
	db SPRITE_SMEARGLE
	db SPRITE_SUICUNE
	; 18 total sprites
	db 0


Group5Sprites:
; Route45
; Route46
; BlackthornCity
	db SPRITE_BLACK_BELT
	db SPRITE_COOLTRAINER_F
	db SPRITE_COOLTRAINER_M
	db SPRITE_DRAGON_TAMER
	db SPRITE_GRAMPS
	db SPRITE_LASS
	db SPRITE_POKEFAN_M
	db SPRITE_SUPER_NERD
	db SPRITE_YOUNGSTER
	; 9 walking sprites
	db SPRITE_BALL_CUT_FRUIT
	; 10 total sprites
	db 0


; Route21 connects to PalletTown
Group6Sprites:
; Route19
; Route20
; Route21
; UragaChannelWest
; CinnabarIsland
Group13Sprites:
; Route1
; PalletTown
	db SPRITE_COOLTRAINER_F
	db SPRITE_COOLTRAINER_M
	db SPRITE_ENGINEER
	db SPRITE_FISHER
	db SPRITE_LASS
	db SPRITE_SWIMMER_GIRL
	db SPRITE_SWIMMER_GUY
	db SPRITE_TEACHER
	db SPRITE_YOUNGSTER
	db SPRITE_BLUE ; doesn't walk
	db SPRITE_COSPLAYER ; doesn't walk
	; 11 walking sprites (9 that walk)
	db SPRITE_BALL_CUT_FRUIT
	db SPRITE_BOULDER_ROCK_FOSSIL
	; 13 total sprites
	db 0


; CeruleanCity connects to Route5
; CeruleanCity connects to Route9
Group7Sprites:
; Route4
; Route24
; Route25
; CeruleanCape
; CeruleanCity
Group25Sprites:
; Route5
Group28Sprites:
; Route9
; Route10North
	db SPRITE_VERMILION_LAWRENCE ; SPRITE_LAWRENCE, SPRITE_MISTY, SPRITE_COOLTRAINER_F
	db SPRITE_COOLTRAINER_M
	db SPRITE_BEAUTY
	db SPRITE_GENTLEMAN
	db SPRITE_LASS
	db SPRITE_POKEFAN_M
	db SPRITE_SUPER_NERD
	db SPRITE_YOUNGSTER
	db SPRITE_SWIMMER_GUY
	db SPRITE_ENGINEER ; doesn't walk
	db SPRITE_FISHER ; doesn't walk
	db SPRITE_LADY ; doesn't walk
	db SPRITE_ROCKET ; doesn't walk
	db SPRITE_MISTY ; doesn't walk
	; 14 walking sprites (9 that walk)
	db SPRITE_BALL_CUT_FRUIT
	db SPRITE_SLOWPOKE
	db SPRITE_SLOWBRO
	db SPRITE_ZAPDOS
	; 18 total sprites
	db 0


Group8Sprites:
; Route33
; AzaleaTown
	db SPRITE_GRAMPS
	db SPRITE_LASS
	db SPRITE_POKEFAN_M
	db SPRITE_ROCKET
	db SPRITE_SILVER
	db SPRITE_TEACHER
	db SPRITE_TWIN
	db SPRITE_YOUNGSTER
	db SPRITE_KURT ; doesn't walk
	; 9 walking sprites (8 that walk)
	db SPRITE_BALL_CUT_FRUIT
	db SPRITE_SLOWPOKE
	; 11 total sprites
	db 0


Group9Sprites:
; Route43
; LakeofRage
	db SPRITE_BIG_GYARADOS
	db SPRITE_BREEDER
	db SPRITE_COOLTRAINER_F
	db SPRITE_FISHER
	db SPRITE_SUPER_NERD
	db SPRITE_YOUNGSTER
	db SPRITE_LASS
	db SPRITE_LAKE_OF_RAGE_LANCE ; doesn't walk
	db SPRITE_GRAMPS ; doesn't walk
	db SPRITE_COOLTRAINER_M ; doesn't walk
	db SPRITE_LADY ; doesn't walk
	; 11/14 walking sprites (7/10 that walk) (SPRITE_BIG_GYARADOS counts as 4)
	db SPRITE_BALL_CUT_FRUIT
	; 12/15 total sprites
	db 0


Group11Sprites:
; Route34
; Route34Coast
; StormyBeach
; GoldenrodCity
; MagnetTunnelWest
	db SPRITE_BREEDER
	db SPRITE_COOLTRAINER_F
	db SPRITE_GOLDENROD_LYRA ; SPRITE_LYRA, SPRITE_SWIMMER_GIRL
	db SPRITE_GRAMPS
	db SPRITE_LASS
	db SPRITE_POKEFAN_M
	db SPRITE_RICH_BOY
	db SPRITE_YOUNGSTER
	db SPRITE_SWIMMER_GUY
	db SPRITE_FISHER ; doesn't walk
	db SPRITE_OFFICER_F ; doesn't walk
	db SPRITE_ROCKET ; doesn't walk
	; 12 walking sprites (9 that walk)
	db SPRITE_BALL_CUT_FRUIT
	db SPRITE_BOULDER_ROCK_FOSSIL
	db SPRITE_DAYCARE_MON_1
	db SPRITE_DAYCARE_MON_2
	; 16 total sprites
	db 0


Group12Sprites:
; Route6
; Route11
; VermilionCity
	db SPRITE_VERMILION_LAWRENCE ; SPRITE_LAWRENCE, SPRITE_COOLTRAINER_F
	db SPRITE_ENGINEER
	db SPRITE_POKEFAN_M
	db SPRITE_ROCKER
	db SPRITE_SAILOR
	db SPRITE_TWIN
	db SPRITE_YOUNGSTER
	db SPRITE_GRAMPS ; doesn't walk
	db SPRITE_OFFICER_F ; doesn't walk
	db SPRITE_SUPER_NERD ; doesn't walk
	; 10 walking sprites (8 that walk)
	db SPRITE_BALL_CUT_FRUIT
	db SPRITE_BOULDER_ROCK_FOSSIL
	db SPRITE_BIG_SNORLAX
	db SPRITE_MACHOKE
	; 14 total sprites
	db 0


Group14Sprites:
; Route2North
; Route3
; PewterCity
	db SPRITE_CHILD
	db SPRITE_BLACK_BELT
	db SPRITE_BUG_MANIAC
	db SPRITE_FISHER
	db SPRITE_GRAMPS
	db SPRITE_POKEFAN_M
	db SPRITE_YOUNGSTER
	db SPRITE_COOLTRAINER_M ; doesn't walk
	db SPRITE_COOLTRAINER_F ; doesn't walk
	; 9 walking sprites (7 that walk)
	db SPRITE_BALL_CUT_FRUIT
	; 10 total sprites
	db 0


Group15Sprites:
; OlivinePort
; VermilionPort
; MountMoonSquare
; TinTowerRoof
	db SPRITE_COOLTRAINER_F
	db SPRITE_CLEFAIRY
	db SPRITE_FISHING_GURU
	db SPRITE_SAILOR
	db SPRITE_SUPER_NERD
	db SPRITE_YOUNGSTER
	; 6 walking sprites
	db SPRITE_N64
	db SPRITE_HO_OH
	; 8 total sprites
	db 0


Group16Sprites:
; Route23
; IndigoPlateau
; BellchimeTrail
	db SPRITE_VALERIE
	db SPRITE_OFFICER
	db SPRITE_OFFICER_F
	db SPRITE_SWIMMING_OFFICER
	db SPRITE_SWIMMING_OFFICER_F
	; 5 walking sprites
	; 5 total sprites
	db 0


Group17Sprites:
; Route12South
; Route13East
; Route13West
; Route14
; Route15
; Route18East
; FuchsiaCity
; LuckyIsland
	db SPRITE_FISHER
	db SPRITE_POKEFAN_F
	db SPRITE_POKEFAN_M
	db SPRITE_TEACHER
	db SPRITE_TWIN
	db SPRITE_YOUNGSTER
	db SPRITE_LASS
	db SPRITE_BAKER
	db SPRITE_ARTIST
	db SPRITE_GRAMPS ; doesn't walk
	db SPRITE_SIGHTSEER_M ; doesn't walk
	db SPRITE_LADY ; doesn't walk
	; 12 walking sprites (9 that walk)
	db SPRITE_BALL_CUT_FRUIT
	; 13 total sprites
	db 0


Group18Sprites:
; Route8
; Route10South
; Route12North
; LavenderTown
	db SPRITE_BIKER
	db SPRITE_GENTLEMAN
	db SPRITE_FISHER
	db SPRITE_GRAMPS
	db SPRITE_HEX_MANIAC
	db SPRITE_POKEFAN_M
	db SPRITE_SUPER_NERD
	db SPRITE_TEACHER
	db SPRITE_YOUNGSTER
	db SPRITE_COOLTRAINER_F ; doesn't walk
	db SPRITE_LASS ; doesn't walk
	db SPRITE_ROCKER ; doesn't walk
	; 11 walking sprites (9 that walk)
	db SPRITE_BALL_CUT_FRUIT
	; 12 total sprites
	db 0


Group19Sprites:
; Route28
; SilverCaveOutside
; FarawayIsland
; FarawayJungle
	db SPRITE_SAILOR
	db SPRITE_LAWRENCE
	; 2 walking sprites
	db SPRITE_BALL_CUT_FRUIT
	db SPRITE_MEW
	; 4 total sprites
	db 0


Group20Sprites:
; YellowForest
; EcruteakShrineOutside
	db SPRITE_BREEDER
	db SPRITE_COOLTRAINER_M
	db SPRITE_SAGE
	db SPRITE_SUPER_NERD
	db SPRITE_TEACHER
	db SPRITE_TWIN
	db SPRITE_WALKER
	db SPRITE_YELLOW
	; 8 walking sprites
	db SPRITE_BALL_CUT_FRUIT
	db SPRITE_HOOTHOOT
	db SPRITE_SKARMORY
	; 11 total sprites
	db 0


Group21Sprites:
; Route7
; Route16North
; Route16South
; Route17
; UragaChannelEast
; CeladonCity
	db SPRITE_BIKER
	db SPRITE_BREEDER
	db SPRITE_FISHER
	db SPRITE_GRAMPS
	db SPRITE_LASS
	db SPRITE_RICH_BOY
	db SPRITE_TEACHER
	db SPRITE_ROUGHNECK
	db SPRITE_YOUNGSTER
	db SPRITE_OFFICER_F ; doesn't walk
	db SPRITE_SWIMMER_GIRL ; doesn't walk
	db SPRITE_COOLTRAINER_M ; doesn't walk
	; 12 walking sprites (9 that walk)
	db SPRITE_BALL_CUT_FRUIT
	db SPRITE_BIG_SNORLAX
	db SPRITE_POLIWRATH
	; 15 total sprites
	db 0


Group23Sprites:
; Route2South
; Route22
; ViridianCity
; ViridianForest
; Route16West
	db SPRITE_BEAUTY
	db SPRITE_BUG_CATCHER
	db SPRITE_BUG_MANIAC
	db SPRITE_COSPLAYER
	db SPRITE_FISHER
	db SPRITE_GRAMPS
	db SPRITE_LADY
	db SPRITE_LASS
	db SPRITE_YOUNGSTER
	db SPRITE_COOLTRAINER_F ; doesn't walk
	; 10 walking sprites (9 that walk)
	db SPRITE_KUKUI
	db SPRITE_BALL_CUT_FRUIT
	; 12 total sprites
	db 0


Group27Sprites:
; Route47
; Route48
	db SPRITE_COOLTRAINER_F
	db SPRITE_COOLTRAINER_M
	db SPRITE_COWGIRL
	db SPRITE_JAMES
	db SPRITE_JESSIE
	db SPRITE_POKEFAN_M
	db SPRITE_ROCKET
	db SPRITE_ROCKET_GIRL
	db SPRITE_YOUNGSTER
	db SPRITE_ARCHER ; doesn't walk
	db SPRITE_LASS ; doesn't walk
	; 11 walking sprites (9 that walk)
	db SPRITE_BALL_CUT_FRUIT
	; 12 total sprites
	db 0


Group30Sprites:
; RuinsofAlphOutside
; Route22Past
	db SPRITE_FISHER
	db SPRITE_SCIENTIST
	db SPRITE_SUPER_NERD
	db SPRITE_YOUNGSTER
	db SPRITE_CELEBI
	db SPRITE_LYRA
	db SPRITE_SILVER
	db SPRITE_GIOVANNI
	; 8 walking sprites
	db SPRITE_BOULDER_ROCK_FOSSIL
	; 9 total sprites
	db 0


Group31Sprites:
; ShamoutiIsland
; BeautifulBeach
; RockyBeach
; WarmBeach
; ShamoutiCoast
	db SPRITE_ARTIST
	db SPRITE_COOLTRAINER_M
	db SPRITE_COOLTRAINER_F
	db SPRITE_SIGHTSEER_M
	db SPRITE_SWIMMER_GIRL
	db SPRITE_SWIMMER_GUY
	db SPRITE_LADY
	db SPRITE_LASS
	db SPRITE_BREEDER
	db SPRITE_YOUNGSTER ; doesnt walk
	db SPRITE_BEAUTY ; doesn't walk
	db SPRITE_FISHER ; doesn't walk
	db SPRITE_GRAMPS ; doesnt walk
	db SPRITE_CANDELA ; doesn't walk
	db SPRITE_BLANCHE ; doesn't walk
	db SPRITE_SPARK ; doesn't walk
	; 16 walking sprites (9 that walk)
	db SPRITE_BALL_CUT_FRUIT
	db SPRITE_MARILL
	db SPRITE_VILEPLUME
	db SPRITE_SLOWKING
	; 20 total sprites
	db 0


Group32Sprites:
; SafariZoneEast
; SafariZoneHub
; SafariZoneNorth
; SafariZoneWest
	db SPRITE_BEAUTY
	db SPRITE_COOLTRAINER_F
	db SPRITE_COOLTRAINER_M
	db SPRITE_COWGIRL
	db SPRITE_LASS
	db SPRITE_BUG_MANIAC
	db SPRITE_YOUNGSTER
	; 7 walking sprites
	db SPRITE_BALL_CUT_FRUIT
	; 8 total sprites
	db 0


Group33Sprites:
; ValenciaIsland
; Route49
	db SPRITE_ARTIST
	db SPRITE_COOLTRAINER_F
	db SPRITE_COOLTRAINER_M
	db SPRITE_FISHER
	db SPRITE_LADY
	db SPRITE_LASS
	db SPRITE_SAILOR
	db SPRITE_SIGHTSEER_M
	db SPRITE_YOUNGSTER
	db SPRITE_ROCKER ; doesn't walk
	; 10 walking sprites (9 that walk)
	db SPRITE_BALL_CUT_FRUIT
	; 11 total sprites
	db 0


Group34Sprites:
; SinjohRuins
	; 0 walking sprites
	; 0 total sprites
	db 0


Group35Sprites:
; SaffronCity
; ShamoutiShrineRuins
	db SPRITE_BLACK_BELT
	db SPRITE_COOLTRAINER_F
	db SPRITE_COOLTRAINER_M
	db SPRITE_LADY
	db SPRITE_LASS
	db SPRITE_POKEFAN_M
	db SPRITE_YOUNGSTER
	db SPRITE_LAWRENCE ; doesn't walk
	db SPRITE_FISHER ; doesn't walk
	db SPRITE_GRAMPS ; doesn't walk
	db SPRITE_SCIENTIST ; doesn't walk
	db SPRITE_SUPER_NERD ; doesn't walk
	; 12 walking sprites (6 that walk)
	db SPRITE_SILPH_EMPLOYEE
	db SPRITE_BALL_CUT_FRUIT
	; 14 total sprites
	db 0
