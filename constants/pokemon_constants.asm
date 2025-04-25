; pokemon ids
; indexes for (only species):
; - PokemonNames (see data/pokemon/names.asm)
; - PokemonCries (see data/pokemon/cries.asm)
; - AlphabeticalPokedexOrder (see data/pokemon/dex_order_alpha.asm)
; - NewPokedexOrder (see data/pokemon/dex_order_new.asm)
; - ValidPokemonLevels (see data/pokemon/valid_levels.asm)
; indexes for (species + non-cosmetic variants):
; - BaseData (see data/pokemon/base_stats.asm)
; - EvosAttacksPointers (see data/pokemon/evos_attacks_pointers.asm)
; - EggSpeciesMovesPointers (see data/pokemon/egg_move_pointers.asm)
; - EvolutionMoves (see data/pokemon/evolution_moves.asm)
; - PokemonBodyData (see data/pokemon/body_data.asm)
; - PokemonPalettes (see data/pokemon/palettes.asm)
; - PokedexDataPointerTable (see data/pokemon/dex_entry_pointers.asm)
; - FootprintPointers (see data/pokemon/footprint_pointers.asm)
; indexes for (species + all variants):
; - MiniIconPointers (see data/pokemon/mini_icon_pointers.asm)
; - OverworldMonIconColors (see data/pokemon/overworld_icon_pals.asm)
; - PokemonPicPointers (see data/pokemon/pic_pointers.asm)
; - PokemonPicSizes (see data/pokemon/pic_sizes.asm)
; - AnimationPointers (see gfx/pokemon/anim_pointers.asm)
; - AnimationIdlePointers (see gfx/pokemon/extra_pointers.asm)
; - BitmasksPointers (see gfx/pokemon/bitmask_pointers.asm)
; - FramesPointers (see gfx/pokemon/frame_pointers.asm)
	const_def 1
	const BULBASAUR  ; 01
	const IVYSAUR    ; 02
	const VENUSAUR   ; 03
	const CHARMANDER ; 04
	const CHARMELEON ; 05
	const CHARIZARD  ; 06
	const SQUIRTLE   ; 07
	const WARTORTLE  ; 08
	const BLASTOISE  ; 09
	const CATERPIE   ; 0a
	const METAPOD    ; 0b
	const BUTTERFREE ; 0c
	const WEEDLE     ; 0d
	const KAKUNA     ; 0e
	const BEEDRILL   ; 0f
	const PIDGEY     ; 10
	const PIDGEOTTO  ; 11
	const PIDGEOT    ; 12
	const RATTATA    ; 13
	const RATICATE   ; 14
	const SPEAROW    ; 15
	const FEAROW     ; 16
	const EKANS      ; 17
	const ARBOK      ; 18
	const PIKACHU    ; 19
	const RAICHU     ; 1a
	const SANDSHREW  ; 1b
	const SANDSLASH  ; 1c
	const NIDORAN_F  ; 1d
	const NIDORINA   ; 1e
	const NIDOQUEEN  ; 1f
	const NIDORAN_M  ; 20
	const NIDORINO   ; 21
	const NIDOKING   ; 22
	const CLEFAIRY   ; 23
	const CLEFABLE   ; 24
	const VULPIX     ; 25
	const NINETALES  ; 26
	const JIGGLYPUFF ; 27
	const WIGGLYTUFF ; 28
	const ZUBAT      ; 29
	const GOLBAT     ; 2a
	const ODDISH     ; 2b
	const GLOOM      ; 2c
	const VILEPLUME  ; 2d
	const PARAS      ; 2e
	const PARASECT   ; 2f
	const VENONAT    ; 30
	const VENOMOTH   ; 31
	const DIGLETT    ; 32
	const DUGTRIO    ; 33
	const MEOWTH     ; 34
	const PERSIAN    ; 35
	const PSYDUCK    ; 36
	const GOLDUCK    ; 37
	const MANKEY     ; 38
	const PRIMEAPE   ; 39
	const GROWLITHE  ; 3a
	const ARCANINE   ; 3b
	const POLIWAG    ; 3c
	const POLIWHIRL  ; 3d
	const POLIWRATH  ; 3e
	const ABRA       ; 3f
	const KADABRA    ; 40
	const ALAKAZAM   ; 41
	const MACHOP     ; 42
	const MACHOKE    ; 43
	const MACHAMP    ; 44
	const BELLSPROUT ; 45
	const WEEPINBELL ; 46
	const VICTREEBEL ; 47
	const TENTACOOL  ; 48
	const TENTACRUEL ; 49
	const GEODUDE    ; 4a
	const GRAVELER   ; 4b
	const GOLEM      ; 4c
	const PONYTA     ; 4d
	const RAPIDASH   ; 4e
	const SLOWPOKE   ; 4f
	const SLOWBRO    ; 50
	const MAGNEMITE  ; 51
	const MAGNETON   ; 52
	const FARFETCH_D ; 53
	const DODUO      ; 54
	const DODRIO     ; 55
	const SEEL       ; 56
	const DEWGONG    ; 57
	const GRIMER     ; 58
	const MUK        ; 59
	const SHELLDER   ; 5a
	const CLOYSTER   ; 5b
	const GASTLY     ; 5c
	const HAUNTER    ; 5d
	const GENGAR     ; 5e
	const ONIX       ; 5f
	const DROWZEE    ; 60
	const HYPNO      ; 61
	const KRABBY     ; 62
	const KINGLER    ; 63
	const VOLTORB    ; 64
	const ELECTRODE  ; 65
	const EXEGGCUTE  ; 66
	const EXEGGUTOR  ; 67
	const CUBONE     ; 68
	const MAROWAK    ; 69
	const HITMONLEE  ; 6a
	const HITMONCHAN ; 6b
	const LICKITUNG  ; 6c
	const KOFFING    ; 6d
	const WEEZING    ; 6e
	const RHYHORN    ; 6f
	const RHYDON     ; 70
	const CHANSEY    ; 71
	const TANGELA    ; 72
	const KANGASKHAN ; 73
	const HORSEA     ; 74
	const SEADRA     ; 75
	const GOLDEEN    ; 76
	const SEAKING    ; 77
	const STARYU     ; 78
	const STARMIE    ; 79
	const MR__MIME   ; 7a
	const SCYTHER    ; 7b
	const JYNX       ; 7c
	const ELECTABUZZ ; 7d
	const MAGMAR     ; 7e
	const PINSIR     ; 7f
	const TAUROS     ; 80
	const MAGIKARP   ; 81
	const GYARADOS   ; 82
	const LAPRAS     ; 83
	const DITTO      ; 84
	const EEVEE      ; 85
	const VAPOREON   ; 86
	const JOLTEON    ; 87
	const FLAREON    ; 88
	const PORYGON    ; 89
	const OMANYTE    ; 8a
	const OMASTAR    ; 8b
	const KABUTO     ; 8c
	const KABUTOPS   ; 8d
	const AERODACTYL ; 8e
	const SNORLAX    ; 8f
	const ARTICUNO   ; 90
	const ZAPDOS     ; 91
	const MOLTRES    ; 92
	const DRATINI    ; 93
	const DRAGONAIR  ; 94
	const DRAGONITE  ; 95
	const MEWTWO     ; 96
	const MEW        ; 97
	const CHIKORITA  ; 98
	const BAYLEEF    ; 99
	const MEGANIUM   ; 9a
	const CYNDAQUIL  ; 9b
	const QUILAVA    ; 9c
	const TYPHLOSION ; 9d
	const TOTODILE   ; 9e
	const CROCONAW   ; 9f
	const FERALIGATR ; a0
	const SENTRET    ; a1
	const FURRET     ; a2
	const HOOTHOOT   ; a3
	const NOCTOWL    ; a4
	const LEDYBA     ; a5
	const LEDIAN     ; a6
	const SPINARAK   ; a7
	const ARIADOS    ; a8
	const CROBAT     ; a9
	const CHINCHOU   ; aa
	const LANTURN    ; ab
	const PICHU      ; ac
	const CLEFFA     ; ad
	const IGGLYBUFF  ; ae
	const TOGEPI     ; af
	const TOGETIC    ; b0
	const NATU       ; b1
	const XATU       ; b2
	const MAREEP     ; b3
	const FLAAFFY    ; b4
	const AMPHAROS   ; b5
	const BELLOSSOM  ; b6
	const MARILL     ; b7
	const AZUMARILL  ; b8
	const SUDOWOODO  ; b9
	const POLITOED   ; ba
	const HOPPIP     ; bb
	const SKIPLOOM   ; bc
	const JUMPLUFF   ; bd
	const AIPOM      ; be
	const SUNKERN    ; bf
	const SUNFLORA   ; c0
	const YANMA      ; c1
	const WOOPER     ; c2
	const QUAGSIRE   ; c3
	const ESPEON     ; c4
	const UMBREON    ; c5
	const MURKROW    ; c6
	const SLOWKING   ; c7
	const MISDREAVUS ; c8
	const UNOWN      ; c9
	const WOBBUFFET  ; ca
	const GIRAFARIG  ; cb
	const PINECO     ; cc
	const FORRETRESS ; cd
	const DUNSPARCE  ; ce
	const GLIGAR     ; cf
	const STEELIX    ; d0
	const SNUBBULL   ; d1
	const GRANBULL   ; d2
	const QWILFISH   ; d3
	const SCIZOR     ; d4
	const SHUCKLE    ; d5
	const HERACROSS  ; d6
	const SNEASEL    ; d7
	const TEDDIURSA  ; d8
	const URSARING   ; d9
	const SLUGMA     ; da
	const MAGCARGO   ; db
	const SWINUB     ; dc
	const PILOSWINE  ; dd
	const CORSOLA    ; de
	const REMORAID   ; df
	const OCTILLERY  ; e0
	const DELIBIRD   ; e1
	const MANTINE    ; e2
	const SKARMORY   ; e3
	const HOUNDOUR   ; e4
	const HOUNDOOM   ; e5
	const KINGDRA    ; e6
	const PHANPY     ; e7
	const DONPHAN    ; e8
	const PORYGON2   ; e9
	const STANTLER   ; ea
	const SMEARGLE   ; eb
	const TYROGUE    ; ec
	const HITMONTOP  ; ed
	const SMOOCHUM   ; ee
	const ELEKID     ; ef
	const MAGBY      ; f0
	const MILTANK    ; f1
	const BLISSEY    ; f2
	const RAIKOU     ; f3
	const ENTEI      ; f4
	const SUICUNE    ; f5
	const LARVITAR   ; f6
	const PUPITAR    ; f7
	const TYRANITAR  ; f8
	const LUGIA      ; f9
	const HO_OH      ; fa
	const CELEBI     ; fb
	const AZURILL    ; fc
	const WYNAUT     ; fd
	const AMBIPOM    ; fe
	const EGG        ; ff
	const_skip       ; 100 is unused
	const MISMAGIUS  ; 101
	const HONCHKROW  ; 102
	const BONSLY     ; 103
	const MIME_JR_   ; 104
	const HAPPINY    ; 105
	const MUNCHLAX   ; 106
	const MANTYKE    ; 107
	const WEAVILE    ; 108
	const MAGNEZONE  ; 109
	const LICKILICKY ; 10a
	const RHYPERIOR  ; 10b
	const TANGROWTH  ; 10c
	const ELECTIVIRE ; 10d
	const MAGMORTAR  ; 10e
	const TOGEKISS   ; 10f
	const YANMEGA    ; 110
	const LEAFEON    ; 111
	const GLACEON    ; 112
	const GLISCOR    ; 113
	const MAMOSWINE  ; 114
	const PORYGON_Z  ; 115
	const SYLVEON    ; 116
	const PERRSERKER ; 117
	const CURSOLA    ; 118
	const SIRFETCH_D ; 119
	const MR__RIME   ; 11a
	const WYRDEER    ; 11b
	const KLEAVOR    ; 11c
	const URSALUNA   ; 11d
	const SNEASLER   ; 11e
	const OVERQWIL   ; 11f
	const DUDUNSPARCE ; 120
	const FARIGIRAF  ; 121
	const CLODSIRE   ; 122
	const ANNIHILAPE ; 123
DEF NUM_SPECIES EQU const_value - 1 ; 123
DEF NUM_POKEMON EQU NUM_SPECIES - (2 * HIGH(NUM_SPECIES)) ; 121

DEF CANCEL EQU -1

; form values
; related to:
; - CosmeticSpeciesAndFormTable (see data/pokemon/variant_forms.asm)
; - ValidVariantRanges (see data/pokemon/valid_variants.asm)

MACRO ext_const_def
	if _NARG >= 1
		def ext_const_value = \1
	else
		def ext_const_value = 0
	endc
	if _NARG >= 2
		DEF \2 EQU ext_const_value
		redef ext_const_value += const_inc
	endc
ENDM

MACRO ext_const
	const_skip
	DEF \1 EQU ext_const_value
	redef ext_const_value += const_inc
ENDM

DEF NO_FORM EQU 0
DEF PLAIN_FORM EQU 1

DEF FIRST_COSMETIC_FORM_MON EQU const_value ; 124

; unown
	ext_const_def 1, UNOWN_A_FORM    ;     (01)
	ext_const UNOWN_B_FORM           ; 124 (02)
	ext_const UNOWN_C_FORM           ; 125 (03)
	ext_const UNOWN_D_FORM           ; 126 (04)
	ext_const UNOWN_E_FORM           ; 127 (05)
	ext_const UNOWN_F_FORM           ; 128 (06)
	ext_const UNOWN_G_FORM           ; 129 (07)
	ext_const UNOWN_H_FORM           ; 12a (08)
	ext_const UNOWN_I_FORM           ; 12b (09)
	ext_const UNOWN_J_FORM           ; 12c (0a)
	ext_const UNOWN_K_FORM           ; 12d (0b)
	ext_const UNOWN_L_FORM           ; 12e (0c)
	ext_const UNOWN_M_FORM           ; 12f (0d)
	ext_const UNOWN_N_FORM           ; 130 (0e)
	ext_const UNOWN_O_FORM           ; 131 (0f)
	ext_const UNOWN_P_FORM           ; 132 (10)
	ext_const UNOWN_Q_FORM           ; 133 (11)
	ext_const UNOWN_R_FORM           ; 134 (12)
	ext_const UNOWN_S_FORM           ; 135 (13)
	ext_const UNOWN_T_FORM           ; 136 (14)
	ext_const UNOWN_U_FORM           ; 137 (15)
	ext_const UNOWN_V_FORM           ; 138 (16)
	ext_const UNOWN_W_FORM           ; 139 (17)
	ext_const UNOWN_X_FORM           ; 13a (18)
	ext_const UNOWN_Y_FORM           ; 13b (19)
	ext_const UNOWN_Z_FORM           ; 13c (1a)
	ext_const UNOWN_EXCLAMATION_FORM ; 13d (1b)
	ext_const UNOWN_QUESTION_FORM    ; 13e (1c)
DEF NUM_UNOWN EQU ext_const_value - 1

; arbok
	ext_const_def 1, ARBOK_JOHTO_FORM ; (1)
	ext_const ARBOK_KANTO_FORM    ; 13f (2)
	ext_const ARBOK_KOGA_FORM     ; 140 (3)
	ext_const ARBOK_AGATHA_FORM   ; 141 (4)
	ext_const ARBOK_ARIANA_FORM   ; 142 (5)
DEF NUM_ARBOK EQU ext_const_value - 1

; pikachu
	ext_const_def 2
	ext_const PIKACHU_FLY_FORM    ; 143 (2)
	ext_const PIKACHU_SURF_FORM   ; 144 (3)
	ext_const PIKACHU_RED_FORM    ; 145 (4)
	ext_const PIKACHU_YELLOW_FORM ; 146 (5)
	ext_const PIKACHU_SPARK_FORM  ; 147 (6)
DEF NUM_PIKACHU EQU ext_const_value - 1

; pichu
	ext_const_def 2
	ext_const PICHU_SPIKY_EARED_FORM ; 148 (2)

; magikarp
	ext_const_def 2
	ext_const MAGIKARP_SKELLY_FORM    ; 149 (02)
	ext_const MAGIKARP_CALICO1_FORM   ; 14a (03)
	ext_const MAGIKARP_CALICO2_FORM   ; 14b (04)
	ext_const MAGIKARP_CALICO3_FORM   ; 14c (05)
	ext_const MAGIKARP_TWO_TONE_FORM  ; 14d (06)
	ext_const MAGIKARP_ORCA_FORM      ; 14e (07)
	ext_const MAGIKARP_DAPPLES_FORM   ; 14f (08)
	ext_const MAGIKARP_TIGER_FORM     ; 150 (09)
	ext_const MAGIKARP_ZEBRA_FORM     ; 151 (0a)
	ext_const MAGIKARP_STRIPE_FORM    ; 152 (0b)
	ext_const MAGIKARP_BUBBLES_FORM   ; 153 (0c)
	ext_const MAGIKARP_DIAMONDS_FORM  ; 154 (0d)
	ext_const MAGIKARP_PATCHES_FORM   ; 155 (0e)
	ext_const MAGIKARP_FOREHEAD1_FORM ; 156 (0f)
	ext_const MAGIKARP_MASK1_FORM     ; 157 (10)
	ext_const MAGIKARP_FOREHEAD2_FORM ; 158 (11)
	ext_const MAGIKARP_MASK2_FORM     ; 159 (12)
	ext_const MAGIKARP_SAUCY_FORM     ; 15a (13)
	ext_const MAGIKARP_RAINDROP_FORM  ; 15b (14)
DEF NUM_MAGIKARP EQU ext_const_value - 1 ; 14

DEF NUM_COSMETIC_FORMS EQU const_value - FIRST_COSMETIC_FORM_MON ; 38

DEF FIRST_VARIANT_FORM_MON EQU const_value ; 15c

; gyarados
	ext_const_def NUM_MAGIKARP + 1
	ext_const GYARADOS_RED_FORM ; 15c (15)

; mewtwo
	ext_const_def 2
	ext_const MEWTWO_ARMORED_FORM ; 15d (2)

; dudunsparce
	ext_const_def 1, DUDUNSPARCE_TWO_SEGMENT_FORM ;     (1)
	ext_const DUDUNSPARCE_THREE_SEGMENT_FORM      ; 15e (2)

; alolan forms
DEF ALOLAN_FORM EQU 2
	const_skip ; 15f rattata
	const_skip ; 160 raticate
	const_skip ; 161 raichu
	const_skip ; 162 sandshrew
	const_skip ; 163 sandslash
	const_skip ; 164 vulpix
	const_skip ; 165 ninetales
	const_skip ; 166 diglett
	const_skip ; 167 dugtrio
	const_skip ; 168 meowth
	const_skip ; 169 persian
	const_skip ; 16a geodude
	const_skip ; 16b graveler
	const_skip ; 16c golem
	const_skip ; 16d grimer
	const_skip ; 16e muk
	const_skip ; 16f exeggutor
	const_skip ; 170 marowak

; galarian forms
DEF GALARIAN_FORM EQU 3
	const_skip ; 171 meowth
	const_skip ; 172 ponyta
	const_skip ; 173 rapidash
	const_skip ; 174 slowpoke
	const_skip ; 175 slowbro
	const_skip ; 176 farfetch'd
	const_skip ; 177 weezing
	const_skip ; 178 mr. mime
	const_skip ; 179 articuno
	const_skip ; 17a zapdos
	const_skip ; 17b moltres
	const_skip ; 17c slowking
	const_skip ; 17d corsola

; hisuian forms
DEF HISUIAN_FORM EQU 4
	const_skip ; 17e growlithe
	const_skip ; 17f arcanine
	const_skip ; 180 voltorb
	const_skip ; 181 electrode
	const_skip ; 182 typhlosion
	const_skip ; 183 qwilfish
	const_skip ; 184 sneasel

; paldean forms
DEF PALDEAN_FORM EQU 5
	const_skip ; 185 wooper
	const_skip ; 186 tauros

; tauros
	ext_const_def 2
	ext_const TAUROS_PALDEAN_FIRE_FORM  ; 187 (2)
	ext_const TAUROS_PALDEAN_WATER_FORM ; 188 (3)

; ursaluna
	ext_const_def 2
	ext_const URSALUNA_BLOODMOON_FORM ; 189 (2)

DEF NUM_VARIANT_FORMS EQU const_value - FIRST_VARIANT_FORM_MON ; 2e

; these constants include EGG and a dummy entry as species
DEF NUM_UNIQUE_POKEMON EQU const_value - 1 ; 189
DEF NUM_EXT_POKEMON EQU NUM_UNIQUE_POKEMON - NUM_COSMETIC_FORMS ; 150

; padding for wDexMons
; NUM_POKEMON_PADDED % DEXLIST_WIDTH == 0
DEF NUM_POKEMON_PADDED EQU NUM_POKEMON
if FMOD(NUM_POKEMON, DEXLIST_WIDTH)
	REDEF NUM_POKEMON_PADDED EQU NUM_POKEMON + DEXLIST_WIDTH - FMOD(NUM_POKEMON, DEXLIST_WIDTH)
endc