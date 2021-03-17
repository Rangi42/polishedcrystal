; item ids
; indexes for:
; - ItemNames (see data/items/names.asm)
; - ItemNameOrder (see data/items/name_order.asm)
; - ItemDescriptions (see data/items/descriptions.asm)
; - ItemAttributes (see data/items/attributes.asm)
; - ItemIconPointers (see data/items/icon_pointers.asm)
; - ItemEffects (see engine/items/item_effects.asm)
	const_def
	const NO_ITEM      ; 00

	const POKE_BALL    ; 01
	const GREAT_BALL   ; 02
	const ULTRA_BALL   ; 03
	const MASTER_BALL  ; 04

	const SAFARI_BALL  ; 05

	const LEVEL_BALL   ; 06
	const LURE_BALL    ; 07
	const MOON_BALL    ; 08
	const FRIEND_BALL  ; 09
	const FAST_BALL    ; 0a
	const HEAVY_BALL   ; 0b
	const LOVE_BALL    ; 0c

	const ABILITYPATCH ; 0d

	const REPEAT_BALL  ; 0e
	const TIMER_BALL   ; 0f
	const NEST_BALL    ; 10
	const NET_BALL     ; 11
	const DIVE_BALL    ; 12
	const LUXURY_BALL  ; 13
	const HEAL_BALL    ; 14
	const QUICK_BALL   ; 15
	const DUSK_BALL    ; 16
	const DREAM_BALL   ; 17
	const PREMIER_BALL ; 18
	const CHERISH_BALL ; 19

	const POTION       ; 1a
	const SUPER_POTION ; 1b
	const HYPER_POTION ; 1c
	const MAX_POTION   ; 1d

	const ANTIDOTE     ; 1e
	const BURN_HEAL    ; 1f
	const PARALYZEHEAL ; 20
	const AWAKENING    ; 21
	const ICE_HEAL     ; 22
	const FULL_HEAL    ; 23
	const FULL_RESTORE ; 24

	const REVIVE       ; 25
	const MAX_REVIVE   ; 26

	const ETHER        ; 27
	const MAX_ETHER    ; 28
	const ELIXIR       ; 29
	const MAX_ELIXIR   ; 2a

	const HP_UP        ; 2b
	const PROTEIN      ; 2c
	const IRON         ; 2d
	const CARBOS       ; 2e
	const CALCIUM      ; 2f
	const ZINC         ; 30
	const RARE_CANDY   ; 31
	const PP_UP        ; 32
	const PP_MAX       ; 33

	const FRESH_WATER  ; 34
	const SODA_POP     ; 35
	const LEMONADE     ; 36
	const MOOMOO_MILK  ; 37
	const RAGECANDYBAR ; 38
	const PEWTERCRUNCH ; 39

	const SACRED_ASH   ; 3a
	const ENERGYPOWDER ; 3b
	const ENERGY_ROOT  ; 3c
	const HEAL_POWDER  ; 3d
	const REVIVAL_HERB ; 3e

	const X_ATTACK     ; 3f
	const X_DEFEND     ; 40
	const X_SPEED      ; 41
	const X_SPCL_ATK   ; 42
	const X_SPCL_DEF   ; 43
	const X_ACCURACY   ; 44
	const DIRE_HIT     ; 45
	const GUARD_SPEC   ; 46

	const REPEL        ; 47
	const SUPER_REPEL  ; 48
	const MAX_REPEL    ; 49
	const ESCAPE_ROPE  ; 4a
	const POKE_DOLL    ; 4b

	const ABILITY_CAP  ; 4c

	const LEAF_STONE   ; 4d
	const FIRE_STONE   ; 4e
	const WATER_STONE  ; 4f
	const THUNDERSTONE ; 50
	const MOON_STONE   ; 51
	const SUN_STONE    ; 52
	const DUSK_STONE   ; 53
	const DAWN_STONE   ; 54
	const SHINY_STONE  ; 55
	const ICE_STONE    ; 56
	const EVERSTONE    ; 57

	const EXP_SHARE    ; 58

	const CHERI_BERRY  ; 59
	const CHESTO_BERRY ; 5a
	const PECHA_BERRY  ; 5b
	const RAWST_BERRY  ; 5c
	const ASPEAR_BERRY ; 5d
	const LEPPA_BERRY  ; 5e
	const ORAN_BERRY   ; 5f
	const PERSIM_BERRY ; 60
	const LUM_BERRY    ; 61
	const SITRUS_BERRY ; 62
	const FIGY_BERRY   ; 63
	const POMEG_BERRY  ; 64
	const KELPSY_BERRY ; 65
	const QUALOT_BERRY ; 66
	const HONDEW_BERRY ; 67
	const GREPA_BERRY  ; 68
	const TAMATO_BERRY ; 69
	const LIECHI_BERRY ; 6a
	const GANLON_BERRY ; 6b
	const SALAC_BERRY  ; 6c
	const PETAYA_BERRY ; 6d
	const APICOT_BERRY ; 6e
	const LANSAT_BERRY ; 6f
	const STARF_BERRY  ; 70
	const ENIGMA_BERRY ; 71
	const CUSTAP_BERRY ; 72
	const JABOCA_BERRY ; 73
	const ROWAP_BERRY  ; 74
	const KEE_BERRY    ; 75
	const MARANGABERRY ; 76

	const BERRY_JUICE  ; 77

	const SILK_SCARF   ; 78
	const BLACK_BELT   ; 79
	const SHARP_BEAK   ; 7a
	const POISON_BARB  ; 7b
	const SOFT_SAND    ; 7c
	const HARD_STONE   ; 7d
	const SILVERPOWDER ; 7e
	const SPELL_TAG    ; 7f
	const METAL_COAT   ; 80
	const CHARCOAL     ; 81
	const MYSTIC_WATER ; 82
	const MIRACLE_SEED ; 83
	const MAGNET       ; 84
	const TWISTEDSPOON ; 85
	const NEVERMELTICE ; 86
	const DRAGON_FANG  ; 87
	const BLACKGLASSES ; 88
	const PINK_BOW     ; 89

	const BRIGHTPOWDER ; 8a
	const SCOPE_LENS   ; 8b
	const QUICK_CLAW   ; 8c
	const KINGS_ROCK   ; 8d
	const FOCUS_BAND   ; 8e
	const LEFTOVERS    ; 8f
	const LUCKY_EGG    ; 90
	const AMULET_COIN  ; 91
	const CLEANSE_TAG  ; 92
	const SMOKE_BALL   ; 93
	const BERSERK_GENE ; 94

	const LIGHT_BALL   ; 95
	const STICK        ; 96
	const THICK_CLUB   ; 97
	const LUCKY_PUNCH  ; 98
	const METAL_POWDER ; 99
	const QUICK_POWDER ; 9a
	const ARMOR_SUIT   ; 9b

	const AIR_BALLOON  ; 9c
	const ASSAULT_VEST ; 9d
	const BIG_ROOT     ; 9e
	const BINDING_BAND ; 9f
	const DESTINY_KNOT ; a0
	const EVIOLITE     ; a1
	const EXPERT_BELT  ; a2
	const FOCUS_SASH   ; a3
	const GRIP_CLAW    ; a4
	const LIFE_ORB     ; a5
	const LIGHT_CLAY   ; a6
	const METRONOME_I  ; a7
	const MUSCLE_BAND  ; a8
	const PROTECT_PADS ; a9
	const ROCKY_HELMET ; aa
	const SAFE_GOGGLES ; ab
	const SHED_SHELL   ; ac
	const SHELL_BELL   ; ad
	const SOOTHE_BELL  ; ae
	const WEAK_POLICY  ; af
	const WIDE_LENS    ; b0
	const WISE_GLASSES ; b1
	const ZOOM_LENS    ; b2

	const EJECT_BUTTON ; b3
	const LAGGING_TAIL ; b4
	const IRON_BALL    ; b5
	const RING_TARGET  ; b6
	const RED_CARD     ; b7
	const ABSORB_BULB  ; b8
	const CELL_BATTERY ; b9
	const LUMINOUSMOSS ; ba
	const SNOWBALL     ; bb

	const EJECT_PACK   ; bc
	const ROOM_SERVICE ; bd
	const BLUNDRPOLICY ; be
	const THROAT_SPRAY ; bf
	const HEAVY_BOOTS  ; c0
	const UTILUMBRELLA ; c1

	const MENTAL_HERB  ; c2
	const POWER_HERB   ; c3
	const WHITE_HERB   ; c4

	const DAMP_ROCK    ; c5
	const HEAT_ROCK    ; c6
	const SMOOTH_ROCK  ; c7
	const ICY_ROCK     ; c8

	const CHOICE_BAND  ; c9
	const CHOICE_SCARF ; ca
	const CHOICE_SPECS ; cb

	const FLAME_ORB    ; cc
	const TOXIC_ORB    ; cd
	const BLACK_SLUDGE ; ce

	const MACHO_BRACE  ; cf
	const POWER_WEIGHT ; d0
	const POWER_BRACER ; d1
	const POWER_BELT   ; d2
	const POWER_LENS   ; d3
	const POWER_BAND   ; d4
	const POWER_ANKLET ; d5

	const DRAGON_SCALE ; d6
	const UP_GRADE     ; d7
	const DUBIOUS_DISC ; d8
	const PROTECTOR    ; d9
	const ELECTIRIZER  ; da
	const MAGMARIZER   ; db
	const RAZOR_FANG   ; dc
	const RAZOR_CLAW   ; dd
	const ODD_SOUVENIR ; de

	const NUGGET       ; df
	const BIG_NUGGET   ; e0
	const TINYMUSHROOM ; e1
	const BIG_MUSHROOM ; e2
	const BALMMUSHROOM ; e3
	const PEARL        ; e4
	const BIG_PEARL    ; e5
	const PEARL_STRING ; e6
	const STARDUST     ; e7
	const STAR_PIECE   ; e8
	const BRICK_PIECE  ; e9
	const RARE_BONE    ; ea
	const SILVER_LEAF  ; eb
	const GOLD_LEAF    ; ec
	const SLOWPOKETAIL ; ed
	const BOTTLE_CAP   ; ee

	const HELIX_FOSSIL ; ef
	const DOME_FOSSIL  ; f0
	const OLD_AMBER    ; f1

	const MULCH        ; f2
	const SWEET_HONEY  ; f3
	const MINT_LEAF    ; f4

	const FLOWER_MAIL  ; f5
	const SURF_MAIL    ; f6
	const LITEBLUEMAIL ; f7
	const PORTRAITMAIL ; f8
	const LOVELY_MAIL  ; f9
	const EON_MAIL     ; fa
	const MORPH_MAIL   ; fb
	const BLUESKY_MAIL ; fc
	const MUSIC_MAIL   ; fd
	const MIRAGE_MAIL  ; fe
NUM_ITEMS EQU const_value - 1

PARK_BALL      EQU $00
USE_SCRIPT_VAR EQU $00
ITEM_FROM_MEM  EQU $ff
ALWAYS_ITEM_2  EQU $ff

; Alphabetical order (see data/items/name_order.asm)
	const_def
	const NAM_NO_ITEM
	const NAM_ABILITY_CAP
	const NAM_ABILITYPATCH
	const NAM_ABSORB_BULB
	const NAM_AIR_BALLOON
	const NAM_AMULET_COIN
	const NAM_ANTIDOTE
	const NAM_APICOT_BERRY
	const NAM_ARMOR_SUIT
	const NAM_ASPEAR_BERRY
	const NAM_ASSAULT_VEST
	const NAM_AWAKENING
	const NAM_BALMMUSHROOM
	const NAM_BERRY_JUICE
	const NAM_BERSERK_GENE
	const NAM_BIG_MUSHROOM
	const NAM_BIG_NUGGET
	const NAM_BIG_PEARL
	const NAM_BIG_ROOT
	const NAM_BINDING_BAND
	const NAM_BLACK_BELT
	const NAM_BLACK_SLUDGE
	const NAM_BLACKGLASSES
	const NAM_BLUESKY_MAIL
	const NAM_BLUNDRPOLICY
	const NAM_BOTTLE_CAP
	const NAM_BRICK_PIECE
	const NAM_BRIGHTPOWDER
	const NAM_BURN_HEAL
if !DEF(FAITHFUL)
	const NAM_RAGECANDYBAR ; Cake of Rage
endc
	const NAM_CALCIUM
	const NAM_CARBOS
	const NAM_CELL_BATTERY
	const NAM_CHARCOAL
	const NAM_CHERI_BERRY
	const NAM_CHERISH_BALL
	const NAM_CHESTO_BERRY
	const NAM_CHOICE_BAND
	const NAM_CHOICE_SCARF
	const NAM_CHOICE_SPECS
	const NAM_CLEANSE_TAG
	const NAM_CUSTAP_BERRY
	const NAM_DAMP_ROCK
	const NAM_DAWN_STONE
	const NAM_DESTINY_KNOT
	const NAM_DIRE_HIT
	const NAM_DIVE_BALL
	const NAM_DOME_FOSSIL
	const NAM_DRAGON_FANG
	const NAM_DRAGON_SCALE
	const NAM_DREAM_BALL
	const NAM_DUBIOUS_DISC
	const NAM_DUSK_BALL
	const NAM_DUSK_STONE
	const NAM_EJECT_BUTTON
	const NAM_EJECT_PACK
	const NAM_ELECTIRIZER
	const NAM_ELIXIR
	const NAM_ENERGY_ROOT
	const NAM_ENERGYPOWDER
	const NAM_ENIGMA_BERRY
	const NAM_EON_MAIL
	const NAM_ESCAPE_ROPE
	const NAM_ETHER
	const NAM_EVERSTONE
	const NAM_EVIOLITE
	const NAM_EXP_SHARE
	const NAM_EXPERT_BELT
	const NAM_FAST_BALL
	const NAM_FIGY_BERRY
	const NAM_FIRE_STONE
	const NAM_FLAME_ORB
	const NAM_FLOWER_MAIL
	const NAM_FOCUS_BAND
	const NAM_FOCUS_SASH
	const NAM_FRESH_WATER
	const NAM_FRIEND_BALL
	const NAM_FULL_HEAL
	const NAM_FULL_RESTORE
	const NAM_GANLON_BERRY
	const NAM_GOLD_LEAF
	const NAM_GREAT_BALL
	const NAM_GREPA_BERRY
	const NAM_GRIP_CLAW
	const NAM_GUARD_SPEC
	const NAM_HARD_STONE
	const NAM_HEAL_BALL
	const NAM_HEAL_POWDER
	const NAM_HEAT_ROCK
	const NAM_HEAVY_BALL
	const NAM_HEAVY_BOOTS
	const NAM_HELIX_FOSSIL
	const NAM_HONDEW_BERRY
	const NAM_HP_UP
	const NAM_HYPER_POTION
	const NAM_ICE_HEAL
	const NAM_ICE_STONE
	const NAM_ICY_ROCK
	const NAM_IRON
	const NAM_IRON_BALL
	const NAM_JABOCA_BERRY
	const NAM_KEE_BERRY
	const NAM_KELPSY_BERRY
	const NAM_KINGS_ROCK
	const NAM_LAGGING_TAIL
	const NAM_LANSAT_BERRY
	const NAM_LEAF_STONE
	const NAM_LEFTOVERS
	const NAM_LEMONADE
	const NAM_LEPPA_BERRY
	const NAM_LEVEL_BALL
	const NAM_LIECHI_BERRY
	const NAM_LIFE_ORB
	const NAM_LIGHT_BALL
	const NAM_LIGHT_CLAY
	const NAM_LITEBLUEMAIL
	const NAM_LOVE_BALL
	const NAM_LOVELY_MAIL
	const NAM_LUCKY_EGG
	const NAM_LUCKY_PUNCH
	const NAM_LUM_BERRY
	const NAM_LUMINOUSMOSS
	const NAM_LURE_BALL
	const NAM_LUXURY_BALL
	const NAM_MACHO_BRACE
	const NAM_MAGMARIZER
	const NAM_MAGNET
	const NAM_MARANGABERRY
	const NAM_MASTER_BALL
	const NAM_MAX_ELIXIR
	const NAM_MAX_ETHER
	const NAM_MAX_POTION
	const NAM_MAX_REPEL
	const NAM_MAX_REVIVE
	const NAM_MENTAL_HERB
	const NAM_METAL_COAT
	const NAM_METAL_POWDER
	const NAM_METRONOME_I
	const NAM_MINT_LEAF
	const NAM_MIRACLE_SEED
	const NAM_MIRAGE_MAIL
	const NAM_MOOMOO_MILK
	const NAM_MOON_BALL
	const NAM_MOON_STONE
	const NAM_MORPH_MAIL
	const NAM_MULCH
	const NAM_MUSCLE_BAND
	const NAM_MUSIC_MAIL
	const NAM_MYSTIC_WATER
	const NAM_NEST_BALL
	const NAM_NET_BALL
	const NAM_NEVERMELTICE
	const NAM_NUGGET
	const NAM_ODD_SOUVENIR
	const NAM_OLD_AMBER
	const NAM_ORAN_BERRY
	const NAM_PARALYZEHEAL
	const NAM_PEARL
	const NAM_PEARL_STRING
	const NAM_PECHA_BERRY
	const NAM_PERSIM_BERRY
	const NAM_PETAYA_BERRY
	const NAM_PEWTERCRUNCH
	const NAM_PINK_BOW
	const NAM_POISON_BARB
	const NAM_POKE_BALL
	const NAM_POKE_DOLL
	const NAM_POMEG_BERRY
	const NAM_PORTRAITMAIL
	const NAM_POTION
	const NAM_POWER_ANKLET
	const NAM_POWER_BAND
	const NAM_POWER_BELT
	const NAM_POWER_BRACER
	const NAM_POWER_HERB
	const NAM_POWER_LENS
	const NAM_POWER_WEIGHT
	const NAM_PP_MAX
	const NAM_PP_UP
	const NAM_PREMIER_BALL
	const NAM_PROTECT_PADS
	const NAM_PROTECTOR
	const NAM_PROTEIN
	const NAM_QUALOT_BERRY
	const NAM_QUICK_BALL
	const NAM_QUICK_CLAW
	const NAM_QUICK_POWDER
if DEF(FAITHFUL)
	const NAM_RAGECANDYBAR
endc
	const NAM_RARE_BONE
	const NAM_RARE_CANDY
	const NAM_RAWST_BERRY
	const NAM_RAZOR_CLAW
	const NAM_RAZOR_FANG
	const NAM_RED_CARD
	const NAM_REPEAT_BALL
	const NAM_REPEL
	const NAM_REVIVAL_HERB
	const NAM_REVIVE
	const NAM_RING_TARGET
	const NAM_ROCKY_HELMET
	const NAM_ROOM_SERVICE
	const NAM_ROWAP_BERRY
	const NAM_SACRED_ASH
	const NAM_SAFARI_BALL
	const NAM_SAFE_GOGGLES
	const NAM_SALAC_BERRY
	const NAM_SCOPE_LENS
	const NAM_SHARP_BEAK
	const NAM_SHED_SHELL
	const NAM_SHELL_BELL
	const NAM_SHINY_STONE
	const NAM_SILK_SCARF
	const NAM_SILVER_LEAF
	const NAM_SILVERPOWDER
	const NAM_SITRUS_BERRY
	const NAM_SLOWPOKETAIL
	const NAM_SMOKE_BALL
	const NAM_SMOOTH_ROCK
	const NAM_SNOWBALL
	const NAM_SODA_POP
	const NAM_SOFT_SAND
	const NAM_SOOTHE_BELL
	const NAM_SPELL_TAG
	const NAM_STAR_PIECE
	const NAM_STARDUST
	const NAM_STARF_BERRY
	const NAM_STICK
	const NAM_SUN_STONE
	const NAM_SUPER_POTION
	const NAM_SUPER_REPEL
	const NAM_SURF_MAIL
	const NAM_SWEET_HONEY
	const NAM_TAMATO_BERRY
	const NAM_THICK_CLUB
	const NAM_THROAT_SPRAY
	const NAM_THUNDERSTONE
	const NAM_TIMER_BALL
	const NAM_TINYMUSHROOM
	const NAM_TOXIC_ORB
	const NAM_TWISTEDSPOON
	const NAM_ULTRA_BALL
	const NAM_UP_GRADE
	const NAM_UTILUMBRELLA
	const NAM_WATER_STONE
	const NAM_WEAK_POLICY
	const NAM_WHITE_HERB
	const NAM_WIDE_LENS
	const NAM_WISE_GLASSES
	const NAM_X_ACCURACY
	const NAM_X_ATTACK
	const NAM_X_DEFEND
	const NAM_X_SPCL_ATK
	const NAM_X_SPCL_DEF
	const NAM_X_SPEED
	const NAM_ZINC
	const NAM_ZOOM_LENS

; APRICORN_BOX contents
	const_def 1
	const RED_APRICORN ; 1
	const BLU_APRICORN ; 2
	const YLW_APRICORN ; 3
	const GRN_APRICORN ; 4
	const WHT_APRICORN ; 5
	const BLK_APRICORN ; 6
	const PNK_APRICORN ; 7
NUM_APRICORNS EQU const_value - 1

; key item ids
; indexes for:
; - KeyItemNames (see data/items/key_names.asm)
; - KeyItemDescriptions (see data/items/descriptions.asm)
; - KeyItemAttributes (see data/items/attributes.asm)
; - KeyItemEffects (see engine/items/item_effects.asm)
	const_def
	const BICYCLE      ; 00
	const OLD_ROD      ; 01
	const GOOD_ROD     ; 02
	const SUPER_ROD    ; 03
	const COIN_CASE    ; 04
	const ITEMFINDER   ; 05
	const MYSTERY_EGG  ; 06
	const SQUIRTBOTTLE ; 07
	const SECRETPOTION ; 08
	const RED_SCALE    ; 09
	const CARD_KEY     ; 0a
	const BASEMENT_KEY ; 0b
	const S_S_TICKET   ; 0c
	const PASS         ; 0d
	const MACHINE_PART ; 0e
	const LOST_ITEM    ; 0f
	const RAINBOW_WING ; 10
	const SILVER_WING  ; 11
	const CLEAR_BELL   ; 12
	const GS_BALL      ; 13
	const BLUE_CARD    ; 14
	const ORANGETICKET ; 15
	const MYSTICTICKET ; 16
	const OLD_SEA_MAP  ; 17
	const SHINY_CHARM  ; 18
	const OVAL_CHARM   ; 19
	const CATCH_CHARM  ; 1a
	const SILPHSCOPE2  ; 1b
	const APRICORN_BOX ; 1c
	const TYPE_CHART   ; 1d
NUM_KEY_ITEMS EQU const_value
