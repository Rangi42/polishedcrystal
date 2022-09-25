MACRO unique_moves
	db \1 ; landmark
	dp \2 ; species
	db \3 ; move
ENDM

; TODO: finish unique moves
UniqueWildMoves:
	; event mons (100% chance, see engine/battle/unique_wild_moves.asm)
	unique_moves MAHOGANY_TOWN,    VOLTORB,    EXPLOSION    ; TeamRocketBaseB1F
	unique_moves MAHOGANY_TOWN,    KOFFING,    EXPLOSION    ; TeamRocketBaseB1F
	unique_moves MAHOGANY_TOWN,    GEODUDE,    EXPLOSION    ; TeamRocketBaseB1F
	unique_moves UNION_CAVE,       LAPRAS,     SHELL_SMASH  ; UnionCaveB2F, Fridays
	; wild mons
	unique_moves CHERRYGROVE_BAY,  CORSOLA,    SUCKER_PUNCH ; HGSS tutor move
	unique_moves SPROUT_TOWER,     BELLSPROUT, GROWTH       ; knows Growth early
	unique_moves ROUTE_32_COAST,   FLAAFFY,    PURSUIT      ; Prism tutor move
	unique_moves RUINS_OF_ALPH,    SHUCKLE,    ANCIENTPOWER ; Sw/Sh move
	unique_moves RUINS_OF_ALPH,    SMEARGLE,   SKETCH       ; knows Sketch twice
	unique_moves SLOWPOKE_WELL,    SLOWPOKE,   GROWTH       ; Prism tutor move
	unique_moves ILEX_FOREST,      0,          0
	unique_moves ROUTE_34_COAST,   STARYU,     DREAM_EATER  ; new move
	unique_moves STORMY_BEACH,     VENOMOTH,   0
	unique_moves MURKY_SWAMP,      MISDREAVUS, SUCKER_PUNCH ; HGSS tutor move
	unique_moves MAGNET_TUNNEL,    MAGNEMITE,  PSYBEAM      ; new move
	unique_moves GOLDENROD_HARBOR, PSYDUCK,    ENCORE       ; Dream World move
	unique_moves ROUTE_35_COAST,   0,          0
	unique_moves NATIONAL_PARK,    0,          0
	unique_moves TIN_TOWER,        0,          0
	unique_moves BURNED_TOWER,     0,          0
	unique_moves WHIRL_ISLANDS,    0,          0
	unique_moves CLIFF_CAVE,       0,          0
	unique_moves YELLOW_FOREST,    PIKACHU,    FLY          ; replaced with Surf if Surfing
	unique_moves QUIET_CAVE,       MUNCHLAX,   GIGA_IMPACT  ; Snorlax move
	unique_moves MT_MORTAR,        0,          0
	unique_moves LAKE_OF_RAGE,     MAGIKARP,   HYDRO_PUMP   ; Pokéwalker move
	unique_moves ICE_PATH,         0,          0
	unique_moves DRAGONS_DEN,      0,          0
	unique_moves DARK_CAVE,        0,          0
	unique_moves SILVER_CAVE,      TYRANITAR,  DRAGON_DANCE ; event move
	unique_moves VIRIDIAN_FOREST,  PIKACHU,    DISARM_VOICE ; Sketch-breed move
	unique_moves MT_MOON,          0,          0
	unique_moves CERULEAN_CAVE,    MACHAMP,    METRONOME    ; RBY TM move
	unique_moves CERULEAN_CAVE,    GOLEM,      METRONOME    ; RBY TM move
	unique_moves CERULEAN_CAVE,    GENGAR,     METRONOME    ; RBY TM move
	unique_moves CERULEAN_CAVE,    ALAKAZAM,   METRONOME    ; RBY TM move
	unique_moves CERULEAN_CAPE,    POLIWHIRL,  METRONOME    ; RBY TM move
	unique_moves DIGLETTS_CAVE,    DUGTRIO,    SCREECH      ; Sw/Sh move
	unique_moves ROCK_TUNNEL,      ELECTABUZZ, METRONOME    ; RBY TM move
	unique_moves DIM_CAVE,         GRAVELER,   SUCKER_PUNCH ; HGSS tutor move
	unique_moves DIM_CAVE,         RHYDON,     CRUNCH       ; Prism tutor move
	unique_moves SOUL_HOUSE,       HAUNTER,    MOONBLAST    ; Prism tutor move
	unique_moves SOUL_HOUSE,       MISDREAVUS, HEAL_BELL    ; HGSS tutor move
	unique_moves LAV_RADIO_TOWER,  MAROWAK,    PERISH_SONG  ; Dream World move
	unique_moves LUCKY_ISLAND,     CHANSEY,    TRI_ATTACK   ; RBY TM move
	unique_moves LUCKY_ISLAND,     TOGETIC,    0
	unique_moves SAFARI_ZONE,      TANGELA,    LEECH_SEED   ; Dream World move (hub)
	unique_moves SAFARI_ZONE,      TAUROS,     STOMP        ; RBY move (east)
	unique_moves SAFARI_ZONE,      PINSIR,     SLASH        ; RBY move (north)
	unique_moves SAFARI_ZONE,      KANGASKHAN, 0            ; (west)
	unique_moves URAGA_CHANNEL,    TENTACRUEL, RECOVER      ; TCG move
	unique_moves SCARY_CAVE,       GOLBAT,     HYPNOSIS     ; Dream World move
	unique_moves SCARY_CAVE,       LANTURN,    SUCKER_PUNCH ; HGSS tutor move
	unique_moves SEAFOAM_ISLANDS,  JYNX,       METRONOME    ; RBY TM move
	unique_moves POKEMON_MANSION,  WEEZING,    CRUNCH       ; Prism tutor move
	unique_moves POKEMON_MANSION,  RAPIDASH,   NASTY_PLOT   ; Prism tutor move
	unique_moves CINNABAR_VOLCANO, MAGMAR,     METRONOME    ; RBY TM move
	unique_moves TOHJO_FALLS,      0,          0
	unique_moves VICTORY_ROAD,     0,          0
	unique_moves SHAMOUTI_ISLAND,  0,          0
	unique_moves BEAUTIFUL_BEACH,  0,          0
	unique_moves ROCKY_BEACH,      DONPHAN,    LOW_KICK     ; HGSS tutor move
	unique_moves NOISY_FOREST,     SCIZOR,     CRABHAMMER   ; new move
	unique_moves NOISY_FOREST,     PINECO,     PAIN_SPLIT   ; HGSS tutor move
	unique_moves SHRINE_RUINS,     HYPNO,      METRONOME    ; RBY TM move
	unique_moves SHAMOUTI_TUNNEL,  GOLBAT,     OUTRAGE      ; Prism tutor move
	unique_moves WARM_BEACH,       SEADRA,     FLAMETHROWER ; new move
	unique_moves SHAMOUTI_COAST,   0,          0
	unique_moves FIRE_ISLAND,      HOUNDOOM,   SUCKER_PUNCH ; HGSS tutor move
	unique_moves ICE_ISLAND,       WEAVILE,    LOW_KICK     ; HGSS tutor move
	unique_moves LIGHTNING_ISLAND, ELECTRODE,  SUCKER_PUNCH ; HGSS tutor move
	unique_moves ROUTE_23,         GYARADOS,   POWER_WHIP   ; Sw/Sh TR move
	unique_moves ROUTE_44,         AIPOM,      ROCK_BLAST   ; new move
	unique_moves ROUTE_49,         PARASECT,   CONFUSE_RAY  ; Prism tutor move
	db -1
