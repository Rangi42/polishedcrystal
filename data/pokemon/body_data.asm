MACRO body_data
	db \1 ; height
	dw \2 ; weight
	dn SHAPE_\3, BODY_COLOR_\4
ENDM

PokemonBodyData:
; entries correspond to constants/pokemon_constants.asm
	table_width BODY_DATA_SIZE, PokemonBodyData
	body_data   7,   69, QUADRUPED,    GREEN  ; BULBASAUR
	body_data  10,  130, QUADRUPED,    GREEN  ; IVYSAUR
	body_data  20, 1000, QUADRUPED,    GREEN  ; VENUSAUR
	body_data   6,   85, BIPEDAL_TAIL, RED    ; CHARMANDER
	body_data  11,  190, BIPEDAL_TAIL, RED    ; CHARMELEON
	body_data  17,  905, BIPEDAL_TAIL, RED    ; CHARIZARD
	body_data   5,   90, BIPEDAL_TAIL, BLUE   ; SQUIRTLE
	body_data  10,  225, BIPEDAL_TAIL, BLUE   ; WARTORTLE
	body_data  16,  855, BIPEDAL_TAIL, BLUE   ; BLASTOISE
	body_data   3,   29, INSECTOID,    GREEN  ; CATERPIE
	body_data   7,   99, SERPENTINE,   GREEN  ; METAPOD
	body_data  11,  320, MULTIWINGS,   WHITE  ; BUTTERFREE
	body_data   3,   32, INSECTOID,    BROWN  ; WEEDLE
	body_data   6,  100, SERPENTINE,   YELLOW ; KAKUNA
	body_data  10,  295, MULTIWINGS,   YELLOW ; BEEDRILL
	body_data   3,   18, WINGS,        BROWN  ; PIDGEY
	body_data  11,  300, WINGS,        BROWN  ; PIDGEOTTO
	body_data  15,  395, WINGS,        BROWN  ; PIDGEOT
	body_data   3,   35, QUADRUPED,    PURPLE ; RATTATA
	body_data   7,  185, QUADRUPED,    BROWN  ; RATICATE
	body_data   3,   20, WINGS,        BROWN  ; SPEAROW
	body_data  12,  380, WINGS,        BROWN  ; FEAROW
	body_data  20,   69, SERPENTINE,   PURPLE ; EKANS
	body_data  35,  650, SERPENTINE,   PURPLE ; ARBOK
	body_data   4,   60, QUADRUPED,    YELLOW ; PIKACHU
	body_data   8,  300, BIPEDAL_TAIL, YELLOW ; RAICHU
	body_data   6,  120, BIPEDAL_TAIL, YELLOW ; SANDSHREW
	body_data  10,  295, BIPEDAL_TAIL, YELLOW ; SANDSLASH
	body_data   4,   70, QUADRUPED,    BLUE   ; NIDORAN_F
	body_data   8,  200, QUADRUPED,    BLUE   ; NIDORINA
	body_data  13,  600, BIPEDAL_TAIL, BLUE   ; NIDOQUEEN
	body_data   5,   90, QUADRUPED,    PURPLE ; NIDORAN_M
	body_data   9,  195, QUADRUPED,    PURPLE ; NIDORINO
	body_data  14,  620, BIPEDAL_TAIL, PURPLE ; NIDOKING
	body_data   6,   75, BIPEDAL_TAIL, PINK   ; CLEFAIRY
	body_data  13,  400, BIPEDAL_TAIL, PINK   ; CLEFABLE
	body_data   6,   99, QUADRUPED,    BROWN  ; VULPIX
	body_data  11,  199, QUADRUPED,    YELLOW ; NINETALES
	body_data   5,   55, BIPEDAL,      PINK   ; JIGGLYPUFF
	body_data  10,  120, BIPEDAL,      PINK   ; WIGGLYTUFF
	body_data   8,   75, WINGS,        PURPLE ; ZUBAT
	body_data  16,  550, WINGS,        PURPLE ; GOLBAT
	body_data   5,   54, HEAD_LEGS,    BLUE   ; ODDISH
	body_data   8,   86, BIPEDAL,      BLUE   ; GLOOM
	body_data  12,  186, BIPEDAL,      RED    ; VILEPLUME
	body_data   3,   54, INSECTOID,    RED    ; PARAS
	body_data  10,  295, INSECTOID,    RED    ; PARASECT
	body_data  10,  300, BIPEDAL,      PURPLE ; VENONAT
	body_data  15,  125, MULTIWINGS,   PURPLE ; VENOMOTH
	body_data   2,    8, HEAD_BASE,    BROWN  ; DIGLETT
	body_data   7,  333, MULTIBODY,    BROWN  ; DUGTRIO
	body_data   4,   42, QUADRUPED,    YELLOW ; MEOWTH
	body_data  10,  320, QUADRUPED,    YELLOW ; PERSIAN
	body_data   8,  196, BIPEDAL_TAIL, YELLOW ; PSYDUCK
	body_data  17,  766, BIPEDAL_TAIL, BLUE   ; GOLDUCK
	body_data   5,  280, BIPEDAL_TAIL, BROWN  ; MANKEY
	body_data  10,  320, BIPEDAL_TAIL, BROWN  ; PRIMEAPE
	body_data   7,  190, QUADRUPED,    BROWN  ; GROWLITHE
	body_data  19, 1550, QUADRUPED,    BROWN  ; ARCANINE
	body_data   6,  124, HEAD_LEGS,    BLUE   ; POLIWAG
	body_data  10,  200, BIPEDAL,      BLUE   ; POLIWHIRL
	body_data  13,  540, BIPEDAL,      BLUE   ; POLIWRATH
	body_data   9,  195, BIPEDAL_TAIL, BROWN  ; ABRA
	body_data  13,  565, BIPEDAL_TAIL, BROWN  ; KADABRA
	body_data  15,  480, BIPEDAL,      BROWN  ; ALAKAZAM
	body_data   8,  195, BIPEDAL_TAIL, GRAY   ; MACHOP
	body_data  15,  705, BIPEDAL,      GRAY   ; MACHOKE
	body_data  16, 1300, BIPEDAL,      GRAY   ; MACHAMP
	body_data   7,   40, BIPEDAL,      GREEN  ; BELLSPROUT
	body_data  10,   64, HEAD_BASE,    GREEN  ; WEEPINBELL
	body_data  17,  155, HEAD_BASE,    GREEN  ; VICTREEBEL
	body_data   9,  455, TENTACLES,    BLUE   ; TENTACOOL
	body_data  16,  550, TENTACLES,    BLUE   ; TENTACRUEL
	body_data   4,  200, HEAD_ARMS,    BROWN  ; GEODUDE
	body_data  10, 1050, BIPEDAL,      BROWN  ; GRAVELER
	body_data  14, 3000, BIPEDAL,      BROWN  ; GOLEM
	body_data  10,  300, QUADRUPED,    YELLOW ; PONYTA
	body_data  17,  950, QUADRUPED,    YELLOW ; RAPIDASH
	body_data  12,  360, QUADRUPED,    PINK   ; SLOWPOKE
	body_data  16,  785, BIPEDAL_TAIL, PINK   ; SLOWBRO
	body_data   3,   60, HEAD_ARMS,    GRAY   ; MAGNEMITE
	body_data  10,  600, MULTIBODY,    GRAY   ; MAGNETON
	body_data   8,  150, WINGS,        BROWN  ; FARFETCH_D
	body_data  14,  392, HEAD_LEGS,    BROWN  ; DODUO
	body_data  18,  852, HEAD_LEGS,    BROWN  ; DODRIO
	body_data  11,  900, FINS,         WHITE  ; SEEL
	body_data  17, 1200, FINS,         WHITE  ; DEWGONG
	body_data   9,  300, HEAD_ARMS,    PURPLE ; GRIMER
	body_data  12,  300, HEAD_ARMS,    PURPLE ; MUK
	body_data   3,   40, HEAD,         PURPLE ; SHELLDER
	body_data  15, 1325, HEAD,         PURPLE ; CLOYSTER
	body_data  13,    1, HEAD,         PURPLE ; GASTLY
	body_data  16,    1, HEAD_ARMS,    PURPLE ; HAUNTER
	body_data  15,  405, BIPEDAL_TAIL, PURPLE ; GENGAR
	body_data  88, 2100, SERPENTINE,   GRAY   ; ONIX
	body_data  10,  324, BIPEDAL,      YELLOW ; DROWZEE
	body_data  16,  756, BIPEDAL,      YELLOW ; HYPNO
	body_data   4,   65, INSECTOID,    RED    ; KRABBY
	body_data  13,  600, INSECTOID,    RED    ; KINGLER
	body_data   5,  104, HEAD,         RED    ; VOLTORB
	body_data  12,  666, HEAD,         RED    ; ELECTRODE
	body_data   4,   25, MULTIBODY,    PINK   ; EXEGGCUTE
	body_data  20, 1200, HEAD_LEGS,    YELLOW ; EXEGGUTOR
	body_data   4,   65, BIPEDAL_TAIL, BROWN  ; CUBONE
	body_data  10,  450, BIPEDAL_TAIL, BROWN  ; MAROWAK
	body_data  15,  498, BIPEDAL,      BROWN  ; HITMONLEE
	body_data  14,  502, BIPEDAL,      BROWN  ; HITMONCHAN
	body_data  12,  655, BIPEDAL_TAIL, PINK   ; LICKITUNG
	body_data   6,   10, HEAD,         PURPLE ; KOFFING
	body_data  12,   95, MULTIBODY,    PURPLE ; WEEZING
	body_data  10, 1150, QUADRUPED,    GRAY   ; RHYHORN
	body_data  19, 1200, BIPEDAL_TAIL, GRAY   ; RHYDON
	body_data  11,  346, BIPEDAL_TAIL, PINK   ; CHANSEY
	body_data  10,  350, HEAD_LEGS,    BLUE   ; TANGELA
	body_data  22,  800, BIPEDAL_TAIL, BROWN  ; KANGASKHAN
	body_data   4,   80, HEAD_BASE,    BLUE   ; HORSEA
	body_data  12,  250, HEAD_BASE,    BLUE   ; SEADRA
	body_data   6,  150, FINS,         RED    ; GOLDEEN
	body_data  13,  390, FINS,         RED    ; SEAKING
	body_data   8,  345, HEAD_BASE,    BROWN  ; STARYU
	body_data  11,  800, HEAD_BASE,    PURPLE ; STARMIE
	body_data  13,  545, BIPEDAL,      PINK   ; MR__MIME
	body_data  15,  560, MULTIWINGS,   GREEN  ; SCYTHER
	body_data  14,  406, BIPEDAL,      RED    ; JYNX
	body_data  11,  300, BIPEDAL_TAIL, YELLOW ; ELECTABUZZ
	body_data  13,  445, BIPEDAL_TAIL, RED    ; MAGMAR
	body_data  15,  550, BIPEDAL,      BROWN  ; PINSIR
	body_data  14,  884, QUADRUPED,    BROWN  ; TAUROS
	body_data   9,  100, FINS,         RED    ; MAGIKARP
	body_data  65, 2350, SERPENTINE,   BLUE   ; GYARADOS
	body_data  25, 2200, FINS,         BLUE   ; LAPRAS
	body_data   3,   40, HEAD,         PURPLE ; DITTO
	body_data   3,   65, QUADRUPED,    BROWN  ; EEVEE
	body_data  10,  290, QUADRUPED,    BLUE   ; VAPOREON
	body_data   8,  245, QUADRUPED,    YELLOW ; JOLTEON
	body_data   9,  250, QUADRUPED,    RED    ; FLAREON
	body_data   8,  365, HEAD_LEGS,    PINK   ; PORYGON
	body_data   4,   75, TENTACLES,    BLUE   ; OMANYTE
	body_data  10,  350, TENTACLES,    BLUE   ; OMASTAR
	body_data   5,  115, INSECTOID,    BROWN  ; KABUTO
	body_data  13,  405, BIPEDAL_TAIL, BROWN  ; KABUTOPS
	body_data  18,  590, WINGS,        PURPLE ; AERODACTYL
	body_data  21, 4600, BIPEDAL,      BLACK  ; SNORLAX
	body_data  17,  554, WINGS,        BLUE   ; ARTICUNO
	body_data  16,  526, WINGS,        YELLOW ; ZAPDOS
	body_data  20,  600, WINGS,        YELLOW ; MOLTRES
	body_data  18,   33, SERPENTINE,   BLUE   ; DRATINI
	body_data  40,  165, SERPENTINE,   BLUE   ; DRAGONAIR
	body_data  22, 2100, BIPEDAL_TAIL, BROWN  ; DRAGONITE
	body_data  20, 1220, BIPEDAL_TAIL, PURPLE ; MEWTWO
	body_data   4,   40, BIPEDAL_TAIL, PINK   ; MEW
	body_data   9,   64, QUADRUPED,    GREEN  ; CHIKORITA
	body_data  12,  158, QUADRUPED,    GREEN  ; BAYLEEF
	body_data  18, 1005, QUADRUPED,    GREEN  ; MEGANIUM
	body_data   5,   79, BIPEDAL,      YELLOW ; CYNDAQUIL
	body_data   9,  190, QUADRUPED,    YELLOW ; QUILAVA
	body_data  17,  795, QUADRUPED,    YELLOW ; TYPHLOSION
	body_data   6,   95, BIPEDAL_TAIL, BLUE   ; TOTODILE
	body_data  11,  250, BIPEDAL_TAIL, BLUE   ; CROCONAW
	body_data  23,  888, BIPEDAL_TAIL, BLUE   ; FERALIGATR
	body_data   8,   60, QUADRUPED,    BROWN  ; SENTRET
	body_data  18,  325, QUADRUPED,    BROWN  ; FURRET
	body_data   7,  212, WINGS,        BROWN  ; HOOTHOOT
	body_data  16,  408, WINGS,        BROWN  ; NOCTOWL
	body_data  10,  108, WINGS,        RED    ; LEDYBA
	body_data  14,  356, WINGS,        RED    ; LEDIAN
	body_data   5,   85, INSECTOID,    GREEN  ; SPINARAK
	body_data  11,  335, INSECTOID,    RED    ; ARIADOS
	body_data  18,  750, MULTIWINGS,   PURPLE ; CROBAT
	body_data   5,  120, FINS,         BLUE   ; CHINCHOU
	body_data  12,  225, FINS,         BLUE   ; LANTURN
	body_data   3,   20, QUADRUPED,    YELLOW ; PICHU
	body_data   3,   30, BIPEDAL_TAIL, PINK   ; CLEFFA
	body_data   3,   10, BIPEDAL,      PINK   ; IGGLYBUFF
	body_data   3,   15, BIPEDAL,      WHITE  ; TOGEPI
	body_data   6,   32, BIPEDAL,      WHITE  ; TOGETIC
	body_data   2,   20, WINGS,        GREEN  ; NATU
	body_data  15,  150, WINGS,        GREEN  ; XATU
	body_data   6,   78, QUADRUPED,    WHITE  ; MAREEP
	body_data   8,  133, BIPEDAL_TAIL, PINK   ; FLAAFFY
	body_data  14,  615, BIPEDAL_TAIL, YELLOW ; AMPHAROS
	body_data   4,   58, BIPEDAL,      GREEN  ; BELLOSSOM
	body_data   4,   85, BIPEDAL_TAIL, BLUE   ; MARILL
	body_data   8,  285, BIPEDAL_TAIL, BLUE   ; AZUMARILL
	body_data  12,  380, BIPEDAL,      BROWN  ; SUDOWOODO
	body_data  11,  339, BIPEDAL,      GREEN  ; POLITOED
	body_data   4,    5, BIPEDAL_TAIL, PINK   ; HOPPIP
	body_data   6,   10, BIPEDAL_TAIL, GREEN  ; SKIPLOOM
	body_data   8,   30, BIPEDAL_TAIL, BLUE   ; JUMPLUFF
	body_data   8,  115, BIPEDAL_TAIL, PURPLE ; AIPOM
	body_data   3,   18, HEAD,         YELLOW ; SUNKERN
	body_data   8,   85, BIPEDAL,      YELLOW ; SUNFLORA
	body_data  12,  380, MULTIWINGS,   RED    ; YANMA
	body_data   4,   85, HEAD_LEGS,    BLUE   ; WOOPER
	body_data  14,  750, BIPEDAL_TAIL, BLUE   ; QUAGSIRE
	body_data   9,  265, QUADRUPED,    PURPLE ; ESPEON
	body_data  10,  270, QUADRUPED,    BLACK  ; UMBREON
	body_data   5,   21, WINGS,        BLACK  ; MURKROW
	body_data  20,  795, BIPEDAL_TAIL, PINK   ; SLOWKING
	body_data   7,   10, HEAD,         GRAY   ; MISDREAVUS
	body_data   5,   50, HEAD,         BLACK  ; UNOWN
	body_data  13,  285, HEAD_BASE,    BLUE   ; WOBBUFFET
	body_data  15,  415, QUADRUPED,    YELLOW ; GIRAFARIG
	body_data   6,   72, HEAD,         GRAY   ; PINECO
	body_data  12, 1258, HEAD,         PURPLE ; FORRETRESS
	body_data  15,  140, SERPENTINE,   YELLOW ; DUNSPARCE
	body_data  11,  648, WINGS,        PURPLE ; GLIGAR
	body_data  92, 4000, SERPENTINE,   GRAY   ; STEELIX
	body_data   6,   78, BIPEDAL,      PINK   ; SNUBBULL
	body_data  14,  487, BIPEDAL_TAIL, PURPLE ; GRANBULL
	body_data   5,   39, FINS,         GRAY   ; QWILFISH
	body_data  18, 1180, MULTIWINGS,   RED    ; SCIZOR
	body_data   6,  205, INSECTOID,    YELLOW ; SHUCKLE
	body_data  15,  540, BIPEDAL,      BLUE   ; HERACROSS
	body_data   9,  280, BIPEDAL_TAIL, BLACK  ; SNEASEL
	body_data   6,   88, BIPEDAL_TAIL, BROWN  ; TEDDIURSA
	body_data  18, 1258, BIPEDAL_TAIL, BROWN  ; URSARING
	body_data   7,  350, SERPENTINE,   RED    ; SLUGMA
	body_data   8,  550, SERPENTINE,   RED    ; MAGCARGO
	body_data   4,   65, QUADRUPED,    BROWN  ; SWINUB
	body_data  11,  558, QUADRUPED,    BROWN  ; PILOSWINE
	body_data   6,   50, INSECTOID,    PINK   ; CORSOLA
	body_data   6,  120, FINS,         GRAY   ; REMORAID
	body_data   9,  285, TENTACLES,    RED    ; OCTILLERY
	body_data   9,  160, WINGS,        RED    ; DELIBIRD
	body_data  21, 2200, WINGS,        PURPLE ; MANTINE
	body_data  17,  505, WINGS,        GRAY   ; SKARMORY
	body_data   6,  108, QUADRUPED,    BLACK  ; HOUNDOUR
	body_data  14,  350, QUADRUPED,    BLACK  ; HOUNDOOM
	body_data  18, 1520, HEAD_BASE,    BLUE   ; KINGDRA
	body_data   5,  335, QUADRUPED,    BLUE   ; PHANPY
	body_data  11, 1200, QUADRUPED,    GRAY   ; DONPHAN
	body_data   6,  325, HEAD_LEGS,    RED    ; PORYGON2
	body_data  14,  712, QUADRUPED,    BROWN  ; STANTLER
	body_data  12,  580, BIPEDAL_TAIL, WHITE  ; SMEARGLE
	body_data   7,  210, BIPEDAL,      PURPLE ; TYROGUE
	body_data  14,  480, BIPEDAL_TAIL, BROWN  ; HITMONTOP
	body_data   4,   60, BIPEDAL,      PINK   ; SMOOCHUM
	body_data   6,  235, BIPEDAL,      YELLOW ; ELEKID
	body_data   7,  214, BIPEDAL_TAIL, RED    ; MAGBY
	body_data  12,  755, BIPEDAL_TAIL, PINK   ; MILTANK
	body_data  15,  468, BIPEDAL,      PINK   ; BLISSEY
	body_data  19, 1780, QUADRUPED,    YELLOW ; RAIKOU
	body_data  21, 1980, QUADRUPED,    BROWN  ; ENTEI
	body_data  20, 1870, QUADRUPED,    BLUE   ; SUICUNE
	body_data   6,  720, BIPEDAL_TAIL, GREEN  ; LARVITAR
	body_data  12, 1520, SERPENTINE,   GRAY   ; PUPITAR
	body_data  20, 2020, BIPEDAL_TAIL, GREEN  ; TYRANITAR
	body_data  52, 2160, WINGS,        WHITE  ; LUGIA
	body_data  38, 1990, WINGS,        RED    ; HO_OH
	body_data   6,   50, BIPEDAL,      GREEN  ; CELEBI
	body_data   2,   20, HEAD_LEGS,    BLUE   ; AZURILL
	body_data   6,  140, BIPEDAL_TAIL, BLUE   ; WYNAUT
	body_data  12,  203, BIPEDAL_TAIL, PURPLE ; AMBIPOM
	body_data   0,    0, HEAD,         RED    ; EGG
	body_data   0,    0, HEAD,         RED    ; $100
	body_data   9,   44, HEAD,         PURPLE ; MISMAGIUS
	body_data   9,  273, WINGS,        BLACK  ; HONCHKROW
	body_data   5,  150, HEAD_LEGS,    BROWN  ; BONSLY
	body_data   6,  130, BIPEDAL,      PINK   ; MIME_JR_
	body_data   6,  244, BIPEDAL,      PINK   ; HAPPINY
	body_data   6, 1050, BIPEDAL,      BLACK  ; MUNCHLAX
	body_data  10,  650, WINGS,        BLUE   ; MANTYKE
	body_data  11,  340, BIPEDAL_TAIL, BLACK  ; WEAVILE
	body_data  12, 1800, HEAD_ARMS,    GRAY   ; MAGNEZONE
	body_data  17, 1400, BIPEDAL,      PINK   ; LICKILICKY
	body_data  24, 2828, BIPEDAL_TAIL, GRAY   ; RHYPERIOR
	body_data  20, 1286, BIPEDAL,      BLUE   ; TANGROWTH
	body_data  18, 1386, BIPEDAL_TAIL, YELLOW ; ELECTIVIRE
	body_data  16,  680, BIPEDAL_TAIL, RED    ; MAGMORTAR
	body_data  15,  380, WINGS,        WHITE  ; TOGEKISS
	body_data  19,  515, MULTIWINGS,   GREEN  ; YANMEGA
	body_data  10,  255, QUADRUPED,    GREEN  ; LEAFEON
	body_data   8,  259, QUADRUPED,    BLUE   ; GLACEON
	body_data  20,  425, WINGS,        PURPLE ; GLISCOR
	body_data  25, 2910, QUADRUPED,    BROWN  ; MAMOSWINE
	body_data   9,  340, HEAD_ARMS,    RED    ; PORYGON_Z
	body_data  10,  235, QUADRUPED,    PINK   ; SYLVEON
	body_data   8,  280, BIPEDAL_TAIL, BROWN  ; PERRSERKER
	body_data  10,    4, HEAD_ARMS,    WHITE  ; CURSOLA
	body_data   8, 1170, WINGS,        WHITE  ; SIRFETCH_D
	body_data  15,  582, BIPEDAL,      PURPLE ; MR__RIME
	body_data  18,  951, QUADRUPED,    GRAY   ; WYRDEER
	body_data  18,  890, MULTIWINGS,   BROWN  ; KLEAVOR
	body_data  24, 2900, BIPEDAL_TAIL, BROWN  ; URSALUNA
	body_data  13,  430, BIPEDAL_TAIL, GRAY   ; SNEASLER
	body_data  25,  605, FINS,         BLACK  ; OVERQWIL
	body_data  36,  392, SERPENTINE,   YELLOW ; DUDUNSPARCE
	body_data  32, 1600, QUADRUPED,    YELLOW ; FARIGIRAF
	body_data  18, 2230, QUADRUPED,    BROWN  ; CLODSIRE
	body_data  12,  560, BIPEDAL_TAIL, GRAY   ; ANNIHILAPE
	assert_table_length NUM_SPECIES

	body_data  65, 2350, SERPENTINE,   RED    ; GYARADOS (GYARADOS_RED_FORM)

	body_data  22, 1370, BIPEDAL_TAIL, GRAY   ; MEWTWO (MEWTWO_ARMORED_FORM)

	body_data  45,  474, SERPENTINE,   YELLOW ; DUDUNSPARCE (DUDUNSPARCE_THREE_SEGMENT_FORM)

	body_data   3,   38, QUADRUPED,    BLACK  ; RATTATA (ALOLAN_FORM)
	body_data   7,  255, QUADRUPED,    BLACK  ; RATICATE (ALOLAN_FORM)
	body_data   7,  210, BIPEDAL_TAIL, BROWN  ; RAICHU (ALOLAN_FORM)
	body_data   7,  400, BIPEDAL_TAIL, WHITE  ; SANDSHREW (ALOLAN_FORM)
	body_data  12,  550, BIPEDAL_TAIL, BLUE   ; SANDSLASH (ALOLAN_FORM)
	body_data   6,   99, QUADRUPED,    WHITE  ; VULPIX (ALOLAN_FORM)
	body_data  11,  199, QUADRUPED,    BLUE   ; NINETALES (ALOLAN_FORM)
	body_data   2,   10, HEAD_BASE,    BROWN  ; DIGLETT (ALOLAN_FORM)
	body_data   7,  666, MULTIBODY,    BROWN  ; DUGTRIO (ALOLAN_FORM)
	body_data   4,   42, QUADRUPED,    BLUE   ; MEOWTH (ALOLAN_FORM)
	body_data  11,  330, QUADRUPED,    BLUE   ; PERSIAN (ALOLAN_FORM)
	body_data   4,  203, HEAD_ARMS,    GRAY   ; GEODUDE (ALOLAN_FORM)
	body_data  10, 1100, BIPEDAL,      GRAY   ; GRAVELER (ALOLAN_FORM)
	body_data  17, 3160, BIPEDAL,      GRAY   ; GOLEM (ALOLAN_FORM)
	body_data   7,  420, HEAD_ARMS,    GREEN  ; GRIMER (ALOLAN_FORM)
	body_data  10,  520, HEAD_ARMS,    GREEN  ; MUK (ALOLAN_FORM)
	body_data 109, 4156, HEAD_LEGS,    YELLOW ; EXEGGUTOR (ALOLAN_FORM)
	body_data  10,  340, BIPEDAL_TAIL, PURPLE ; MAROWAK (ALOLAN_FORM)

	body_data   4,   75, BIPEDAL_TAIL, BROWN  ; MEOWTH (GALARIAN_FORM)
	body_data   8,  240, QUADRUPED,    WHITE  ; PONYTA (GALARIAN_FORM)
	body_data  17,  800, QUADRUPED,    WHITE  ; RAPIDASH (GALARIAN_FORM)
	body_data  12,  360, QUADRUPED,    PINK   ; SLOWPOKE (GALARIAN_FORM)
	body_data  16,  705, BIPEDAL_TAIL, PINK   ; SLOWBRO (GALARIAN_FORM)
	body_data   8,  420, WINGS,        BROWN  ; FARFETCH_D (GALARIAN_FORM)
	body_data  30,  160, MULTIBODY,    GRAY   ; WEEZING (GALARIAN_FORM)
	body_data  14,  568, BIPEDAL,      WHITE  ; MR__MIME (GALARIAN_FORM)
	body_data  17,  509, WINGS,        PURPLE ; ARTICUNO (GALARIAN_FORM)
	body_data  16,  582, WINGS,        YELLOW ; ZAPDOS (GALARIAN_FORM)
	body_data  20,  660, WINGS,        RED    ; MOLTRES (GALARIAN_FORM)
	body_data  18,  795, BIPEDAL_TAIL, PINK   ; SLOWKING (GALARIAN_FORM)
	body_data   6,    5, INSECTOID,    WHITE  ; CORSOLA (GALARIAN_FORM)

	body_data   8,  227, QUADRUPED,    RED    ; GROWLITHE (HISUIAN_FORM)
	body_data  20, 1680, QUADRUPED,    RED    ; ARCANINE (HISUIAN_FORM)
	body_data   5,  130, HEAD,         BROWN  ; VOLTORB (HISUIAN_FORM)
	body_data  12,  710, HEAD,         BROWN  ; ELECTRODE (HISUIAN_FORM)
	body_data  16,  698, QUADRUPED,    YELLOW ; TYPHLOSION (HISUIAN_FORM)
	body_data   5,   39, FINS,         BLACK  ; QWILFISH (HISUIAN_FORM)
	body_data   9,  270, BIPEDAL_TAIL, GRAY   ; SNEASEL (HISUIAN_FORM)

	body_data   4,  110, HEAD_LEGS,    BROWN  ; WOOPER (PALDEAN_FORM)
	body_data  14, 1150, QUADRUPED,    BLACK  ; TAUROS (PALDEAN_FORM)
	body_data  14,  850, QUADRUPED,    BLACK  ; TAUROS (TAUROS_PALDEAN_FIRE_FORM)
	body_data  14, 1100, QUADRUPED,    BLACK  ; TAUROS (TAUROS_PALDEAN_WATER_FORM)

	body_data  27, 3330, BIPEDAL_TAIL, BROWN  ; URSALUNA (URSALUNA_BLOODMOON_FORM)

	assert_table_length NUM_EXT_POKEMON
