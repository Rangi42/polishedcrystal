; item ids
; indexes for:
; - ItemNames (see data/items/names.asm)
; - ItemNameOrder (see data/items/name_order.asm)
; - ItemDescriptions (see data/items/descriptions.asm)
; - ItemAttributes (see data/items/attributes.asm)
; - ItemIconPointers (see data/items/icon_pointers.asm)
; - ItemIconPalettes (see gfx/items/items.pal)
; - _DoItemEffect.ItemEffects (see engine/items/item_effects.asm)
	const_def
	const NO_ITEM      ; 00
DEF PARK_BALL EQU NO_ITEM

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

	const REPEAT_BALL  ; 0d
	const TIMER_BALL   ; 0e
	const NEST_BALL    ; 0f
	const NET_BALL     ; 10
	const DIVE_BALL    ; 11
	const LUXURY_BALL  ; 12
	const HEAL_BALL    ; 13
	const QUICK_BALL   ; 14
	const DUSK_BALL    ; 15
	const DREAM_BALL   ; 16

	const PREMIER_BALL ; 17
	const CHERISH_BALL ; 18
DEF NUM_POKE_BALLS EQU const_value ; PARK_BALL counts

	const POTION       ; 19
	const SUPER_POTION ; 1a
	const HYPER_POTION ; 1b
	const MAX_POTION   ; 1c

	const ANTIDOTE     ; 1d
	const BURN_HEAL    ; 1e
	const PARALYZEHEAL ; 1f
	const AWAKENING    ; 20
	const ICE_HEAL     ; 21
	const FULL_HEAL    ; 22
	const FULL_RESTORE ; 23

	const REVIVE       ; 24
	const MAX_REVIVE   ; 25

	const ETHER        ; 26
	const MAX_ETHER    ; 27
	const ELIXIR       ; 28
	const MAX_ELIXIR   ; 29

	const HP_UP        ; 2a
	const PROTEIN      ; 2b
	const IRON         ; 2c
	const CARBOS       ; 2d
	const CALCIUM      ; 2e
	const ZINC         ; 2f
	const RARE_CANDY   ; 30
	const PP_UP        ; 31
	const PP_MAX       ; 32

	const FRESH_WATER  ; 33
	const SODA_POP     ; 34
	const LEMONADE     ; 35
	const MOOMOO_MILK  ; 36
	const RAGECANDYBAR ; 37
	const PEWTERCRUNCH ; 38

	const ENERGYPOWDER ; 39
	const ENERGY_ROOT  ; 3a
	const HEAL_POWDER  ; 3b
	const REVIVAL_HERB ; 3c

	const SACRED_ASH   ; 3d

DEF FIRST_BERRY EQU const_value
	const CHERI_BERRY  ; 3e
	const CHESTO_BERRY ; 3f
	const PECHA_BERRY  ; 40
	const RAWST_BERRY  ; 41
	const ASPEAR_BERRY ; 42
	const LEPPA_BERRY  ; 43
	const ORAN_BERRY   ; 44
	const PERSIM_BERRY ; 45
	const LUM_BERRY    ; 46
	const SITRUS_BERRY ; 47

	const FIGY_BERRY   ; 48

	const POMEG_BERRY  ; 49
	const KELPSY_BERRY ; 4a
	const QUALOT_BERRY ; 4b
	const HONDEW_BERRY ; 4c
	const GREPA_BERRY  ; 4d
	const TAMATO_BERRY ; 4e

	const LIECHI_BERRY ; 4f
	const GANLON_BERRY ; 50
	const SALAC_BERRY  ; 51
	const PETAYA_BERRY ; 52
	const APICOT_BERRY ; 53
	const LANSAT_BERRY ; 54
	const STARF_BERRY  ; 55

	const ENIGMA_BERRY ; 56

	const CUSTAP_BERRY ; 57

	const JABOCA_BERRY ; 58
	const ROWAP_BERRY  ; 59

	const KEE_BERRY    ; 5a
	const MARANGABERRY ; 5b
DEF NUM_BERRIES EQU const_value - FIRST_BERRY

	const BERRY_JUICE  ; 5c

	const REPEL        ; 5d
	const SUPER_REPEL  ; 5e
	const MAX_REPEL    ; 5f

	const ESCAPE_ROPE  ; 60
	const POKE_DOLL    ; 61

	const MULCH        ; 62

	const SWEET_HONEY  ; 63

	const X_ATTACK     ; 64
	const X_DEFEND     ; 65
	const X_SPEED      ; 66
	const X_SP_ATK     ; 67
	const X_SP_DEF     ; 68
	const X_ACCURACY   ; 69
	const DIRE_HIT     ; 6a
	const GUARD_SPEC   ; 6b

	const ABILITY_CAP  ; 6c
	const ABILITYPATCH ; 6d

DEF FIRST_STONE EQU const_value
	const LEAF_STONE   ; 6e
	const FIRE_STONE   ; 6f
	const WATER_STONE  ; 70
	const THUNDERSTONE ; 71
	const ICE_STONE    ; 72
	const MOON_STONE   ; 73
	const SUN_STONE    ; 74
	const DUSK_STONE   ; 75
	const SHINY_STONE  ; 76
	const EVERSTONE    ; 77
DEF NUM_STONES EQU const_value - FIRST_STONE

	const EXP_SHARE    ; 78

	const SILK_SCARF   ; 79
	const BLACK_BELT   ; 7a
	const SHARP_BEAK   ; 7b
	const POISON_BARB  ; 7c
	const SOFT_SAND    ; 7d
	const HARD_STONE   ; 7e
	const SILVERPOWDER ; 7f
	const SPELL_TAG    ; 80
	const METAL_COAT   ; 81
	const CHARCOAL     ; 82
	const MYSTIC_WATER ; 83
	const MIRACLE_SEED ; 84
	const MAGNET       ; 85
	const TWISTEDSPOON ; 86
	const NEVERMELTICE ; 87
	const DRAGON_FANG  ; 88
	const BLACKGLASSES ; 89
	const PINK_BOW     ; 8a

	const BERSERK_GENE ; 8b
	const BRIGHTPOWDER ; 8c
	const QUICK_CLAW   ; 8d
	const KINGS_ROCK   ; 8e
	const AMULET_COIN  ; 8f
	const CLEANSE_TAG  ; 90
	const SMOKE_BALL   ; 91
	const FOCUS_BAND   ; 92
	const LUCKY_EGG    ; 93
	const LEFTOVERS    ; 94

	const SOOTHE_BELL  ; 95
	const SHELL_BELL   ; 96

	const MUSCLE_BAND  ; 97
	const WISE_GLASSES ; 98
	const EXPERT_BELT  ; 99
	const LIGHT_CLAY   ; 9a
	const LIFE_ORB     ; 9b
	const FOCUS_SASH   ; 9c
	const METRONOME_I  ; 9d
	const IRON_BALL    ; 9e
	const LAGGING_TAIL ; 9f
	const DESTINY_KNOT ; a0
	const GRIP_CLAW    ; a1
	const SHED_SHELL   ; a2
	const BIG_ROOT     ; a3

	const EVIOLITE     ; a4
	const ROCKY_HELMET ; a5
	const AIR_BALLOON  ; a6
	const RED_CARD     ; a7
	const BINDING_BAND ; a8
	const EJECT_BUTTON ; a9

	const WEAK_POLICY  ; aa
	const ASSAULT_VEST ; ab
	const SAFE_GOGGLES ; ac

	const PROTECT_PADS ; ad

	const THROAT_SPRAY ; ae
	const EJECT_PACK   ; af
	const HEAVY_BOOTS  ; b0
	const BLUNDRPOLICY ; b1
	const ROOM_SERVICE ; b2

	const CLEAR_AMULET ; b3
	const MIRROR_HERB  ; b4
	const PUNCHINGLOVE ; b5
	const COVERT_CLOAK ; b6
	const LOADED_DICE  ; b7

	const LIGHT_BALL   ; b8
	const LEEK         ; b9
	const THICK_CLUB   ; ba
	const LUCKY_PUNCH  ; bb
	const METAL_POWDER ; bc
	const QUICK_POWDER ; bd
	const ARMOR_SUIT   ; be

	const SCOPE_LENS   ; bf
	const WIDE_LENS    ; c0
	const ZOOM_LENS    ; c1

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
	const UPGRADE      ; d7
	const DUBIOUS_DISC ; d8
	const PROTECTOR    ; d9
	const ELECTIRIZER  ; da
	const MAGMARIZER   ; db
	const RAZOR_FANG   ; dc
	const RAZOR_CLAW   ; dd
	const OVAL_STONE   ; de
	const ODD_SOUVENIR ; df
	const LINKING_CORD ; e0

	const SILVER_LEAF  ; e1
	const GOLD_LEAF    ; e2
	const MINT_LEAF    ; e3
	const BOTTLE_CAP   ; e4

	const NUGGET       ; e5
	const BIG_NUGGET   ; e6
	const TINYMUSHROOM ; e7
	const BIG_MUSHROOM ; e8
	const BALMMUSHROOM ; e9
	const PEARL        ; ea
	const BIG_PEARL    ; eb
	const PEARL_STRING ; ec
	const STARDUST     ; ed
	const STAR_PIECE   ; ee
	const BRICK_PIECE  ; ef
	const RARE_BONE    ; f0
	const SLOWPOKETAIL ; f1

	const HELIX_FOSSIL ; f2
	const DOME_FOSSIL  ; f3
	const OLD_AMBER    ; f4

DEF FIRST_MAIL EQU const_value
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
DEF NUM_MAILS EQU const_value - FIRST_MAIL
DEF NUM_ITEMS EQU const_value - 1

DEF USE_SCRIPT_VAR EQU $00
DEF ITEM_FROM_MEM  EQU $ff
DEF ALWAYS_ITEM_2  EQU $ff

; Alphabetical order (see data/items/name_order.asm)
	const_def
	const NAM_NO_ITEM
	const NAM_ABILITY_CAP
	const NAM_ABILITYPATCH
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
	const NAM_CHARCOAL
	const NAM_CHERI_BERRY
	const NAM_CHERISH_BALL
	const NAM_CHESTO_BERRY
	const NAM_CHOICE_BAND
	const NAM_CHOICE_SCARF
	const NAM_CHOICE_SPECS
	const NAM_CLEANSE_TAG
	const NAM_CLEAR_AMULET
	const NAM_COVERT_CLOAK
	const NAM_CUSTAP_BERRY
	const NAM_DAMP_ROCK
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
if DEF(FAITHFUL)
	const NAM_SWEET_HONEY
endc
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
	const NAM_LEEK
	const NAM_LEFTOVERS
	const NAM_LEMONADE
	const NAM_LEPPA_BERRY
	const NAM_LEVEL_BALL
	const NAM_LIECHI_BERRY
	const NAM_LIFE_ORB
	const NAM_LIGHT_BALL
	const NAM_LIGHT_CLAY
	const NAM_LINKING_CORD
	const NAM_LITEBLUEMAIL
	const NAM_LOADED_DICE
	const NAM_LOVE_BALL
	const NAM_LOVELY_MAIL
	const NAM_LUCKY_EGG
	const NAM_LUCKY_PUNCH
	const NAM_LUM_BERRY
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
	const NAM_MIRROR_HERB
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
	const NAM_OVAL_STONE
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
	const NAM_PUNCHINGLOVE
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
	const NAM_SODA_POP
	const NAM_SOFT_SAND
	const NAM_SOOTHE_BELL
	const NAM_SPELL_TAG
	const NAM_STAR_PIECE
	const NAM_STARDUST
	const NAM_STARF_BERRY
	const NAM_SUN_STONE
	const NAM_SUPER_POTION
	const NAM_SUPER_REPEL
	const NAM_SURF_MAIL
if !DEF(FAITHFUL)
	const NAM_SWEET_HONEY
endc
	const NAM_TAMATO_BERRY
	const NAM_THICK_CLUB
	const NAM_THROAT_SPRAY
	const NAM_THUNDERSTONE
	const NAM_TIMER_BALL
	const NAM_TINYMUSHROOM
	const NAM_TOXIC_ORB
	const NAM_TWISTEDSPOON
	const NAM_ULTRA_BALL
	const NAM_UPGRADE
	const NAM_WATER_STONE
	const NAM_WEAK_POLICY
	const NAM_WHITE_HERB
	const NAM_WIDE_LENS
	const NAM_WISE_GLASSES
	const NAM_X_ACCURACY
	const NAM_X_ATTACK
	const NAM_X_DEFEND
	const NAM_X_SP_ATK
	const NAM_X_SP_DEF
	const NAM_X_SPEED
	const NAM_ZINC
	const NAM_ZOOM_LENS
	assert const_value - 1 == NUM_ITEMS

; APRICORN_BOX contents
	const_def 1
	const RED_APRICORN ; 1
	const BLU_APRICORN ; 2
	const YLW_APRICORN ; 3
	const GRN_APRICORN ; 4
	const WHT_APRICORN ; 5
	const BLK_APRICORN ; 6
	const PNK_APRICORN ; 7
DEF NUM_APRICORNS EQU const_value - 1

; WING_CASE contents
	const_def
	const HEALTH_WING ; 0
	const MUSCLE_WING ; 1
	const RESIST_WING ; 2
	const SWIFT_WING  ; 3
	const GENIUS_WING ; 4
	const CLEVER_WING ; 5
DEF NUM_WINGS EQU const_value

; CANDY_JAR contents
	const_def 1
	const EXP_CANDY_XS ; 1
	const EXP_CANDY_S  ; 2
	const EXP_CANDY_M  ; 3
	const EXP_CANDY_L  ; 4
	const EXP_CANDY_XL ; 5
DEF NUM_CANDIES EQU const_value - 1

; key item ids
; indexes for:
; - KeyItemNames (see data/items/key_names.asm)
; - KeyItemDescriptions (see data/items/descriptions.asm)
; - KeyItemAttributes (see data/items/attributes.asm)
; - KeyItemIconPointers (see data/items/icon_pointers.asm)
; - KeyItemIconPalettes (see gfx/items/key_items.pal)
; - DoKeyItemEffect.KeyItemEffects (see engine/items/item_effects.asm)
	const_def 1
	const BICYCLE      ; 01
	const OLD_ROD      ; 02
	const GOOD_ROD     ; 03
	const SUPER_ROD    ; 04
	const ITEMFINDER   ; 05
	const COIN_CASE    ; 06
	const APRICORN_BOX ; 07
	const WING_CASE    ; 08
	const CANDY_JAR    ; 09
	const TYPE_CHART   ; 0a
	const GBC_SOUNDS   ; 0b
	const BLUE_CARD    ; 0c
	const SQUIRTBOTTLE ; 0d
	const SILPHSCOPE2  ; 0e
	const MYSTERY_EGG  ; 0f
	const SECRETPOTION ; 10
	const GO_GOGGLES   ; 11
	const RED_SCALE    ; 12
	const CARD_KEY     ; 13
	const BASEMENT_KEY ; 14
	const LOST_ITEM    ; 15
	const MACHINE_PART ; 16
	const RAINBOW_WING ; 17
	const SILVER_WING  ; 18
	const CLEAR_BELL   ; 19
	const GS_BALL      ; 1a
	const S_S_TICKET   ; 1b
	const PASS         ; 1c
	const ORANGETICKET ; 1d
	const MYSTICTICKET ; 1e
	const OLD_SEA_MAP  ; 1f
	const LIFT_KEY     ; 20
	const HARSH_LURE   ; 21
	const POTENT_LURE  ; 22
	const MALIGN_LURE  ; 23
DEF CHARMS_START EQU const_value
	; Only charms below this point!
	const SHINY_CHARM  ; 24
	const OVAL_CHARM   ; 25
	const CATCH_CHARM  ; 26
DEF NUM_KEY_ITEMS EQU const_value - 1

; Alphabetical order (see data/items/name_order.asm)
	const_def 1
	const NAM_APRICORN_BOX
	const NAM_BASEMENT_KEY
	const NAM_BICYCLE
	const NAM_BLUE_CARD
	const NAM_CANDY_JAR
	const NAM_CARD_KEY
	const NAM_CATCH_CHARM
	const NAM_CLEAR_BELL
	const NAM_COIN_CASE
	const NAM_GBC_SOUNDS
	const NAM_GO_GOGGLES
	const NAM_GOOD_ROD
	const NAM_GS_BALL
	const NAM_HARSH_LURE
	const NAM_ITEMFINDER
	const NAM_LIFT_KEY
	const NAM_LOST_ITEM
	const NAM_MACHINE_PART
	const NAM_MALIGN_LURE
	const NAM_MYSTERY_EGG
	const NAM_MYSTICTICKET
	const NAM_OLD_ROD
	const NAM_OLD_SEA_MAP
	const NAM_ORANGETICKET
	const NAM_OVAL_CHARM
	const NAM_PASS
	const NAM_POTENT_LURE
	const NAM_RAINBOW_WING
	const NAM_RED_SCALE
	const NAM_S_S_TICKET
	const NAM_SECRETPOTION
	const NAM_SHINY_CHARM
	const NAM_SILPHSCOPE2
	const NAM_SILVER_WING
	const NAM_SQUIRTBOTTLE
	const NAM_SUPER_ROD
	const NAM_TYPE_CHART
	const NAM_WING_CASE
	assert const_value - 1 == NUM_KEY_ITEMS

; special items ids
; story items that have names and icons but do not go in the bag
; Pokegear must be highest value due to special palette handling
; indexes for:
; - SpecialItemNames (see data/items/special_names.asm)
; - SpecialItemIconPointers (see data/items/icon_pointers.asm)
; - SpecialItemIconPalettes (see gfx/items/special_items.pal)
	const_def
	const POKEDEX
	const MAP_CARD
	const RADIO_CARD
	const EXPN_CARD
	const POKEGEAR
DEF NUM_SPECIAL_ITEMS EQU const_value
