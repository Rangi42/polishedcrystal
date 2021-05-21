; Battle Tower Pokemon proposed by Salamandar#8272 (Discord)
; organized by data/pokemon/dex_order_new.asm

; CAGE sets classification:
; (C) = Crap
; (A) = Average
; (G) = Good
; (E) = Excellent

; implement check to set Speed EV to 0 in case
; of BTDVS_TRICK_ROOM EQUS "$ff, $f0, $ff"

; Please note that the stats listed here assume NONFAITHFUL,
; faithful parties are TODO

; last update 02/09/2020

BattleTowerMons:
BattleTowerPokemon1:
	; MEGANIUM type: Grass, Fairy
	; 80,  82, 100,  80,  83, 100
	; hp  atk  def  spd  sat  sdf
	db MEGANIUM, LEFTOVERS ;(G)
	db PETAL_DANCE, MOONBLAST, HIDDEN_POWER, CALM_MIND ; HP Rock
	db BTDVS_HP_ROCK
	db ABILITY_2 | BOLD, MALE ; Natural Cure, +Def -Atk

BattleTowerPokemon2:
	db MEGANIUM, BIG_ROOT ;(A)
	db GIGA_DRAIN, PROTECT, LEECH_SEED, TOXIC
	db PERFECT_DVS
	db ABILITY_2 | CALM, FEMALE ; Natural Cure, +SpDef -Atk

	db MEGANIUM, LIFE_ORB ;(A)
	db SEED_BOMB, PLAY_ROUGH, EARTHQUAKE, SWORDS_DANCE
	db PERFECT_DVS
	db ABILITY_1 | ADAMANT, MALE ; Overgrow, +Atk -SpAtk

	; TYPHLOSION type: Fire, Ground
	; 78,  84,  78, 100, 109,  85
	; hp  atk  def  spd  sat  sdf
	db TYPHLOSION, CHOICE_SPECS ;(G)
	db FLAMETHROWER, EARTH_POWER, HIDDEN_POWER, FOCUS_BLAST ; HP Grass
	db BTDVS_HP_GRASS
	db HIDDEN_ABILITY | TIMID, FEMALE ; Flash Fire, +Speed -Atk

	db TYPHLOSION, LIFE_ORB ;(A)
	db FLAMETHROWER, EARTH_POWER, SOLAR_BEAM, SUNNY_DAY
	db PERFECT_DVS
	db ABILITY_1 | TIMID, FEMALE ; Blaze, +Speed -Atk

	; FERALIGATR type: Water, Dark
	; 85, 105, 100,  78,  79,  83
	; hp  atk  def  spd  sat  sdf
	db FERALIGATR, LIFE_ORB ;(E)
	db WATERFALL, CRUNCH, ICE_PUNCH, DRAGON_DANCE
	db PERFECT_DVS
	db HIDDEN_ABILITY | JOLLY, MALE ; Sheer Force, +Speed -SpAtk

	db FERALIGATR, LIFE_ORB ;(E)
	db WATERFALL, CRUNCH, ICE_PUNCH, AGILITY
	db PERFECT_DVS
	db HIDDEN_ABILITY | ADAMANT, MALE ; Sheer Force, +Atk -SpAtk

	; PIDGEOT type: Normal, Flying
	; 93,  81,  75, 101,  90,  70
	; hp  atk  def  spd  sat  sdf
	db PIDGEOT, LIFE_ORB ;(A)
	db HURRICANE, FOCUS_BLAST, ROOST, U_TURN
	db PERFECT_DVS
	db HIDDEN_ABILITY | TIMID, FEMALE ; No Guard, +Speed -Atk

	db PIDGEOT, BERSERK_GENE ;(C)
	db BRAVE_BIRD, EXTREMESPEED, ROOST, THIEF
	db PERFECT_DVS
	db ABILITY_2 | ADAMANT, MALE ; Tangled Feet, +Atk -SpAtk

	; NOCTOWL type: Ghost, Flying
	; 100,  50,  50,  70,  96,  96
	;  hp  atk  def  spd  sat  sdf
	db NOCTOWL, LEFTOVERS ;(A)
	db AIR_SLASH, HEX, ROOST, TOXIC
	db PERFECT_DVS
	db ABILITY_1 | CALM, MALE ; Insomnia, +SpDef -Atk

	; RATICATE type: Normal
	; 65,  91,  60, 107,  50,  70
	; hp  atk  def  spd  sat  sdf
	db RATICATE, FLAME_ORB ;(C)
	db FACADE, SUPER_FANG, SUCKER_PUNCH, U_TURN
	db PERFECT_DVS
	db ABILITY_2 | JOLLY, MALE ; Guts, +Speed -SpAtk

	; RATICATE(alola) type: Dark, Normal 
	; 85,  81,  70,  87,  40,  80
	; hp  atk  def  spd  sat  sdf
	db RATICATE, LIFE_ORB ;(C)
	db SUCKER_PUNCH, DOUBLE_EDGE, U_TURN, SWORDS_DANCE
	db PERFECT_DVS
	db ABILITY_2 | JOLLY, FEMALE | ALOLAN_FORM ; Hustle, +Speed -SpAtk

	; FURRET type: Normal
	; 85,  86,  64, 108,  45,  55
	; hp  atk  def  spd  sat  sdf
	db FURRET, CHOICE_SCARF ;(C)
	db DOUBLE_EDGE, STRENGTH, KNOCK_OFF, U_TURN ; TRICK if better AI
	db PERFECT_DVS
	db ABILITY_2 | ADAMANT, FEMALE ; Keen Eye, +Atk -SpAtk

	; RAICHU type: Electric
	; 60, 100,  55, 121, 100,  80
	; hp  atk  def  spd  sat  sdf
	db RAICHU, LIFE_ORB ;(E)
	db THUNDERBOLT, HIDDEN_POWER, FOCUS_BLAST, NASTY_PLOT ; HP Ice
	db BTDVS_HP_ICE
	db HIDDEN_ABILITY | TIMID, FEMALE ; Lightning Rod, +Speed -Atk

	db RAICHU, CHOICE_BAND ;(G)
	db WILD_CHARGE, STRENGTH, KNOCK_OFF, EXTREMESPEED
	db PERFECT_DVS
	db ABILITY_1 | JOLLY, MALE ; Static, +Speed -SpAtk

	; RAICHU(alola) type: Electric, Psychic
	; 60, 95,  50, 121, 105,  85
	; hp  atk  def  spd  sat  sdf
	db RAICHU, LIFE_ORB ;(E)
	db THUNDERBOLT, HIDDEN_POWER, HIDDEN_POWER, NASTY_PLOT ; HP Fighting
	db BTDVS_HP_FIGHTING
	db HIDDEN_ABILITY | TIMID, MALE | ALOLAN_FORM ; Motor Drive, +Speed -Atk

	db RAICHU, CHOICE_SPECS ;(G)
	db VOLT_SWITCH, PSYCHIC_M, SURF, FOCUS_BLAST
	db PERFECT_DVS
	db ABILITY_1 | TIMID, MALE | ALOLAN_FORM ; Static, +Speed -Atk

	; BUTTERFREE type: Bug, Psychic
	; 60,  45, 50,  80,  110, 110
	; hp  atk  def  spd  sat  sdf
	db BUTTERFREE, SILVERPOWDER ;(A)
	db BUG_BUZZ, CALM_MIND, ROOST, SLEEP_POWDER
	db PERFECT_DVS
	db HIDDEN_ABILITY | MODEST, FEMALE ; Tinted Lens, +SpAtk -Atk

	db BUTTERFREE, CHOICE_SCARF ;(A)
	db BUG_BUZZ, PSYCHIC_M, GIGA_DRAIN, HIDDEN_POWER ; HP Ground
	db BTDVS_HP_GROUND
	db ABILITY_2 | TIMID, FEMALE ; Levitate, +Speed -Atk

	; BEEDRILL type: Bug, Poison
	; 65, 100,  40, 115, 45,  90
	; hp  atk  def  spd  sat  sdf
	db BEEDRILL, CHOICE_BAND ;(A)
	db U_TURN, POISON_JAB, KNOCK_OFF, OUTRAGE
	db PERFECT_DVS
	db HIDDEN_ABILITY | JOLLY, MALE ; Adaptability, +Speed -SpAtk

	; LEDIAN type: Bug, Fighting
	; 55,  95,  50,  85,  35, 110
	; hp  atk  def  spd  sat  sdf
	db LEDIAN, LIFE_ORB ;(A)
	db DRAIN_PUNCH, ICE_PUNCH, THUNDERPUNCH, SWORDS_DANCE
	db PERFECT_DVS
	db HIDDEN_ABILITY | JOLLY, MALE ; Iron Fist, +Speed -SpAtk

	db LEDIAN, LEFTOVERS ;(C)
	db KNOCK_OFF, BATON_PASS, ROOST, AGILITY
	db PERFECT_DVS
	db ABILITY_2 | JOLLY, FEMALE ; Early Bird, +Speed -SpAtk

	; ARIADOS type: Bug, Poison
	; 70,  90,  70,  80,  60,  70 
	; hp  atk  def  spd  sat  sdf
	db ARIADOS, FOCUS_SASH ;(C)
	db MEGAHORN, POISON_JAB, TOXIC_SPIKES, GLARE
	db PERFECT_DVS
	db ABILITY_1 | JOLLY, FEMALE ; Swarm, +Speed -SpAtk

	; GOLEM type: Rock, Ground
	; 80, 120, 130,  45,  55,  65
	; hp  atk  def  spd  sat  sdf
	db GOLEM, CUSTAP_BERRY ;(A)
	db EARTHQUAKE, STONE_EDGE, THUNDERPUNCH, EXPLOSION
	db PERFECT_DVS
	db ABILITY_2 | ADAMANT, MALE ; Sturdy, +Atk -SpAtk

	; GOLEM(alola) type: Rock, Electric
	; 80, 120, 130,  45,  55,  65
	; hp  atk  def  spd  sat  sdf
	db GOLEM, AIR_BALLOON ;(A)
	db DOUBLE_EDGE, STONE_EDGE, EARTHQUAKE, EXPLOSION ; Double Edge is Electric
	db PERFECT_DVS
	db HIDDEN_ABILITY | ADAMANT, MALE | ALOLAN_FORM ; Galvanize, +Atk -SpAtk

	db GOLEM, ASSAULT_VEST ;(A)
	db RAPID_SPIN, STONE_EDGE, EARTHQUAKE, EXPLOSION ; Rapid Spin is Electric
	db PERFECT_DVS
	db HIDDEN_ABILITY | ADAMANT, FEMALE | ALOLAN_FORM ; Galvanize, +Atk -SpAtk

	; CROBAT type: Poison, Flying
	; 85,  90,  80, 130,  70,  80
	; hp  atk  def  spd  sat  sdf
	db CROBAT, CHOICE_BAND ;(G)
	db BRAVE_BIRD, POISON_JAB, CRUNCH, U_TURN
	db PERFECT_DVS
	db HIDDEN_ABILITY | JOLLY, MALE ; Infiltrator, +Speed -SpAtk

	db CROBAT, RED_CARD ;(A)
	db BRAVE_BIRD, SUPER_FANG, ROOST, TOXIC
	db PERFECT_DVS
	db HIDDEN_ABILITY | JOLLY, MALE ; Infiltrator, +Speed -SpAtk

	; CLEFABLE type: Fairy
	; 95,  70,  73,  60,  95,  90
	; hp  atk  def  spd  sat  sdf
	db CLEFABLE, LIFE_ORB ;(E)
	db MOONBLAST, FLAMETHROWER, THUNDERBOLT, FRESH_SNACK
	db PERFECT_DVS
	db ABILITY_2 | MODEST, FEMALE ; Magic Guard, +SpAtk -Atk

	db CLEFABLE, LEFTOVERS ;(G)
	db MOONBLAST, FLAMETHROWER, FRESH_SNACK, CALM_MIND
	db PERFECT_DVS
	db HIDDEN_ABILITY | BOLD, MALE ; Unaware, +Def -Atk

	db CLEFABLE, LEFTOVERS ;(G)
	db MOONBLAST, KNOCK_OFF, FRESH_SNACK, SING ; Flame Orb with Trick if better AI
	db PERFECT_DVS
	db ABILITY_2 | CALM, FEMALE ; Magic Guard, +SpDef -Atk

	; WIGGLYTUFF type: Normal, Fairy
	; 148,  70,  55,  45,  85,  65
	;  hp  atk  def  spd  sat  sdf
	db WIGGLYTUFF, LIFE_ORB ;(A)
	db MOONBLAST, PSYCHIC_M, FIRE_BLAST, SING
	db PERFECT_DVS
	db ABILITY_2 | TIMID, MALE ; Competitive, +Speed -Atk

	db WIGGLYTUFF, LEFTOVERS ;(C)
	db SING, PROTECT, MEAN_LOOK, PERISH_SONG
	db PERFECT_DVS
	db HIDDEN_ABILITY | CALM, FEMALE ; Soundproof, +SpDef -Atk

	; TOGEKISS type: Fairy, Flying
	; 85,  50,  95,  80, 120, 115
	; hp  atk  def  spd  sat  sdf
	db TOGEKISS, LEFTOVERS ;(E)
	db AIR_SLASH, THUNDER_WAVE, ROOST, NASTY_PLOT
	db PERFECT_DVS
	db ABILITY_2 | BOLD, MALE ; Serene Grace, +Def -Atk

	db TOGEKISS, CHOICE_SCARF ;(E)
	db MOONBLAST, AEROBLAST, FIRE_BLAST, AURA_SPHERE ; Event moves, TRICK if better AI
	db PERFECT_DVS
	db ABILITY_2 | TIMID, FEMALE ; Serene Grace, +Speed -Atk

	db TOGEKISS, SCOPE_LENS ;(G)
	db MOONBLAST, AEROBLAST, AURA_SPHERE, ROOST ; Event moves
	db PERFECT_DVS
	db HIDDEN_ABILITY | TIMID, FEMALE ; Super Luck, +Speed -Atk

	; SANDSLASH type: Ground
	; 75, 100, 110,  65,  45,  55
	; hp  atk  def  spd  sat  sdf
	db SANDSLASH, LEFTOVERS ;(C)
	db EARTHQUAKE, STONE_EDGE, SUPER_FANG, SANDSTORM
	db PERFECT_DVS
	db ABILITY_1 | IMPISH, FEMALE ; Sand Veil, +Def -SpAtk

	; SANDSLASH(alola) type: Ice, Steel
	; 75, 100, 120,  65,  25,  65
	; hp  atk  def  spd  sat  sdf
	db SANDSLASH, LIFE_ORB ;(A)
	db ICICLE_CRASH, IRON_HEAD, EARTHQUAKE, HAIL
	db PERFECT_DVS
	db HIDDEN_ABILITY | JOLLY, MALE | ALOLAN_FORM ; Slush Rush, +Speed -SpAtk

	; ARBOK type: Poison
	; 60,  95,  69,  80,  65,  79
	; hp  atk  def  spd  sat  sdf
	db ARBOK, BLACK_SLUDGE ;(C)
	db GUNK_SHOT, EARTHQUAKE, CRUNCH, GLARE
	db PERFECT_DVS
	db ABILITY_1 | ADAMANT, MALE | ARBOK_KOGA_FORM ; Intimidate, +Atk -SpAtk

	; DUNSPARCE type: Normal, Ground
	; 105,  80,  70,  45,  65,  65
	;  hp  atk  def  spd  sat  sdf
	db DUNSPARCE, LEFTOVERS ;(C)
	db HEADBUTT, EARTHQUAKE, ROOST, GLARE
	db PERFECT_DVS
	db ABILITY_1 | ADAMANT, MALE ; Serene Grace, +Atk -SpAtk

	; AMPHAROS type: Electric, Dragon
	; 95,  75,  90,  65, 125,  95
	; hp  atk  def  spd  sat  sdf
	db AMPHAROS, ASSAULT_VEST ;(G)
	db VOLT_SWITCH, DRAGON_PULSE, FOCUS_BLAST, HIDDEN_POWER ; HP Ice
	db BTDVS_HP_ICE
	db ABILITY_1 | MODEST, MALE ; Static, +SpAtk -Atk

	db AMPHAROS, LEFTOVERS ;(G)
	db VOLT_SWITCH, DRAGON_PULSE, REST, SLEEP_TALK
	db PERFECT_DVS
	db HIDDEN_ABILITY | BOLD, FEMALE ; Mold Breaker, +Def -Atk

	db AMPHAROS, LIFE_ORB ;(A)
	db THUNDERBOLT, DRAGON_PULSE, FOCUS_BLAST, AGILITY
	db PERFECT_DVS
	db ABILITY_1 | MODEST, MALE ; Static, +SpAtk -Atk

	db AMPHAROS, LIGHT_CLAY ;(C)
	db VOLT_SWITCH, DRAGON_PULSE, REFLECT, LIGHT_SCREEN
	db PERFECT_DVS
	db HIDDEN_ABILITY | BOLD, FEMALE ; Mold Breaker, +Def -Atk

	; QUAGSIRE type: Water, Ground
	; 95,  95,  95,  35,  65,  65
	; hp  atk  def  spd  sat  sdf
	db QUAGSIRE, LEFTOVERS ;(A)
	db SCALD, EARTHQUAKE, RECOVER, TOXIC
	db PERFECT_DVS
	db HIDDEN_ABILITY | RELAXED, FEMALE ; Unaware, +Def -Speed

	; GENGAR type: Ghost, Poison
	; 60,  65,  60, 110, 130,  75
	; hp  atk  def  spd  sat  sdf
	db GENGAR, LIFE_ORB ;(E)
	db SHADOW_BALL, SLUDGE_BOMB, THUNDERBOLT, NASTY_PLOT
	db PERFECT_DVS
	db ABILITY_2 | TIMID, MALE ; Levitate, +Speed -Atk

	db GENGAR, BLACK_SLUDGE ;(G)
	db HEX, SLUDGE_BOMB, DESTINY_BOND, WILL_O_WISP
	db PERFECT_DVS
	db HIDDEN_ABILITY | TIMID, FEMALE ; Shadow Tag, +Speed -Atk

	db GENGAR, FOCUS_SASH ;(G)
	db SHADOW_BALL, DISABLE, PROTECT, PERISH_SONG
	db PERFECT_DVS
	db HIDDEN_ABILITY | TIMID, FEMALE ; Shadow Tag, +Speed -Atk

	; WOBBUFFET type: Psychic
	; 190,  33,  58,  33,  33,  58
	;  hp  atk  def  spd  sat  sdf
	db WOBBUFFET, LEFTOVERS ;(G)
	db COUNTER, MIRROR_COAT, RECOVER, ENCORE
	db PERFECT_DVS
	db ABILITY_1 | BOLD, FEMALE ; Shadow Tag, +Def -Atk

	; STEELIX type: Steel, Ground
	; 75,  90, 200,  30,  55,  65
	; hp  atk  def  spd  sat  sdf
	db STEELIX, LEFTOVERS ;(A)
	db GYRO_BALL, EARTHQUAKE, STONE_EDGE, CURSE
	db BTDVS_TRICK_ROOM ; Minimize speed for Gyro Ball
	db ABILITY_2 | BRAVE, MALE ; Sturdy, +Atk -Speed

	db STEELIX, LIFE_ORB ;(G)
	db IRON_HEAD, EARTHQUAKE, ROCK_SLIDE, CRUNCH
	db PERFECT_DVS
	db ABILITY_1 | ADAMANT, MALE ; Sheer Force, +Atk -SpAtk

	; VICTREEBEL type: Grass, Poison
	; 80, 115,  65,  70, 110,  70
	; hp  atk  def  spd  sat  sdf
	db VICTREEBEL, FIGY_BERRY ;(A)
	db POWER_WHIP, POISON_JAB, KNOCK_OFF, SWORDS_DANCE
	db PERFECT_DVS
	db HIDDEN_ABILITY | JOLLY, MALE ; Gluttony, +Speed -SpAtk

	; PARASECT type: Bug, Grass
	; 60, 115, 100,  30,  60,  80
	; hp  atk  def  spd  sat  sdf
	db PARASECT, LEFTOVERS ;(A)
	db LEECH_LIFE, SEED_BOMB, KNOCK_OFF, SPORE
	db PERFECT_DVS
	db ABILITY_2 | IMPISH, FEMALE ; Dry Skin, +Def -SpAtk

	; POLIWRATH type: Water, Fighting
	; 90,  95, 100,  70,  70,  90
	; hp  atk  def  spd  sat  sdf
	db POLIWRATH, LEFTOVERS ;(A)
	db WATERFALL, CLOSE_COMBAT, ICE_PUNCH, BULK_UP
	db PERFECT_DVS
	db ABILITY_1 | IMPISH, MALE ; Water Absorb, +Def -SpAtk

	db POLIWRATH, SITRUS_BERRY ;(C)
	db AQUA_JET, MACH_PUNCH, HYPNOSIS, BELLY_DRUM
	db PERFECT_DVS
	db ABILITY_1 | ADAMANT, FEMALE ; Water Absorb, +Atk -SpAtk

	; POLITOED type: Water, Grass
	; 90,  75,  80,  80,  90, 100
	; hp  atk  def  spd  sat  sdf
	db POLITOED, LEFTOVERS ;(G)
	db SCALD, GIGA_DRAIN, TOXIC, ENCORE
	db PERFECT_DVS
	db ABILITY_1 | TIMID, FEMALE ; Water Absorb, +Speed -Atk

	db POLITOED, CHOICE_SPECS ;(A)
	db HYDRO_PUMP, GIGA_DRAIN, ICE_BEAM, PSYCHIC_M
	db PERFECT_DVS
	db HIDDEN_ABILITY | MODEST, MALE ; Drizzle, +SpAtk -Atk

	db POLITOED, LEFTOVERS ;(C)
	db ENCORE, PROTECT, WHIRLPOOL, PERISH_SONG
	db PERFECT_DVS
	db ABILITY_1 | BOLD, FEMALE ; Water Absorb, +Def -Atk

	; GYARADOS type: Water, Flying
	; 95, 125,  79,  81,  60, 100
	; hp  atk  def  spd  sat  sdf
	db GYARADOS, LIFE_ORB ;(E)
	db WATERFALL, FLY, STRENGTH, DRAGON_DANCE
	db PERFECT_DVS
	db ABILITY_2 | JOLLY, MALE | GYARADOS_RED_FORM ; Moxie, +Speed -SpAtk

	db GYARADOS, LEFTOVERS ;(G)
	db WATERFALL, STONE_EDGE, POWER_WHIP, THUNDER_WAVE ; POWER_WHIP is unobtainable yet
	db PERFECT_DVS
	db ABILITY_1 | ADAMANT, FEMALE ; Intimidate, +Atk -SpAtk

	; SLOWBRO type: Water, Psychic
	; 95,  75, 120,  30, 100,  80
	; hp  atk  def  spd  sat  sdf
	db SLOWBRO, LEFTOVERS ;(E)
	db SCALD, ICE_BEAM, RECOVER, TOXIC
	db PERFECT_DVS
	db HIDDEN_ABILITY | BOLD, FEMALE ; Regenerator, +Def -Atk

	db SLOWBRO, LEFTOVERS ;(G)
	db SCALD, PSYCHIC_M, RECOVER, CALM_MIND
	db PERFECT_DVS
	db HIDDEN_ABILITY | BOLD, MALE ; Regenerator, +Def -Atk

	db SLOWBRO, CHOICE_SPECS ;(G)
	db SURF, PSYCHIC_M, ICE_BEAM, FIRE_BLAST
	db PERFECT_DVS
	db HIDDEN_ABILITY | BOLD, MALE ; Regenerator, +Def -Atk

	; SLOWBRO(galar) type: Poison, Psychic
	; 95, 100, 100,  30, 100,  75
	; hp  atk  def  spd  sat  sdf
	db SLOWBRO, BLACK_SLUDGE ;(E)
	db SLUDGE_BOMB, PSYCHIC_M, FLAMETHROWER, NASTY_PLOT
	db PERFECT_DVS
	db HIDDEN_ABILITY | BOLD, MALE | GALARIAN_FORM ; Regenerator, +Def -Atk

	db SLOWBRO, LIFE_ORB ;(E)
	db SLUDGE_BOMB, PSYCHIC_M, EARTHQUAKE, TRICK_ROOM
	db BTDVS_TRICK_ROOM
	db HIDDEN_ABILITY | QUIET, MALE | GALARIAN_FORM ; Regenerator, +SpAtk -Speed

	db SLOWBRO, BERSERK_GENE ;(G)
	db POISON_JAB, ZEN_HEADBUTT, DRAIN_PUNCH, RECOVER
	db PERFECT_DVS
	db ABILITY_2 | CAREFUL, MALE | GALARIAN_FORM ; Own Tempo, +SpDef -SpAtk

	; SLOWKING type: Water, Psychic
	; 95,  75,  80,  30, 100, 120
	; hp  atk  def  spd  sat  sdf
	db SLOWKING, LEFTOVERS ;(E)
	db SCALD, PSYCHIC_M, RECOVER, NASTY_PLOT
	db PERFECT_DVS
	db HIDDEN_ABILITY | CALM, FEMALE ; Regenerator, +SpDef -Atk

	db SLOWKING, ASSAULT_VEST ;(E)
	db SCALD, FUTURE_SIGHT, ICE_BEAM, FLAMETHROWER
	db PERFECT_DVS
	db HIDDEN_ABILITY | MODEST, MALE ; Regenerator, +SpAtk -Atk

	db SLOWKING, LIFE_ORB ;(G)
	db SURF, PSYCHIC_M, FLAMETHROWER, TRICK_ROOM
	db BTDVS_TRICK_ROOM
	db HIDDEN_ABILITY | QUIET, FEMALE ; Regenerator, +SpAtk -Speed

	; VILEPLUME type: Grass, Poison
	; 75,  80,  85,  50, 110, 100
	; hp  atk  def  spd  sat  sdf
	db VILEPLUME, BLACK_SLUDGE ;(A)
	db GIGA_DRAIN, SLUDGE_BOMB, HEALINGLIGHT, SLEEP_POWDER
	db PERFECT_DVS
	db HIDDEN_ABILITY | BOLD, MALE ; Effect Spore, +Def -Atk

	db VILEPLUME, BIG_ROOT ;(A)
	db GIGA_DRAIN, PROTECT, LEECH_SEED, TOXIC
	db PERFECT_DVS
	db HIDDEN_ABILITY | CALM, FEMALE ; Effect Spore, +SpDef -Atk

	; BELLOSSOM type: Grass, Fairy
	; 75,  80,  95,  50, 100, 110
	; hp  atk  def  spd  sat  sdf
	db BELLOSSOM, LEFTOVERS ;(G)
	db PETAL_DANCE, MOONBLAST, HIDDEN_POWER, SLEEP_POWDER ; HP Rock
	db BTDVS_HP_ROCK
	db HIDDEN_ABILITY | BOLD, MALE ; Own Tempo, +Def -Atk

	db BELLOSSOM, LIFE_ORB ;(A)
	db SOLAR_BEAM, HIDDEN_POWER, EARTH_POWER, SUNNY_DAY ; HP Fire
	db BTDVS_HP_FIRE
	db ABILITY_1 | MODEST, FEMALE ; Chlorophyll, +SpAtk -Atk

	db BELLOSSOM, BERSERK_GENE ;(A)
	db SEED_BOMB, PLAY_ROUGH, DRAIN_PUNCH, SLEEP_POWDER
	db PERFECT_DVS
	db HIDDEN_ABILITY | IMPISH, MALE ; Own Tempo, +Def -SpAtk

	; HYPNO type Psychic
	; 85,  73,  70,  67,  73, 115
	; hp  atk  def  spd  sat  sdf
	db HYPNO, SITRUS_BERRY ;(C)
	db ZEN_HEADBUTT, DRAIN_PUNCH, BELLY_DRUM, HYPNOSIS
	db PERFECT_DVS
	db ABILITY_1 | JOLLY, MALE ; Insomnia, +Speed -SpAtk

	db HYPNO, LIGHT_CLAY ;(C)
	db PSYCHIC_M, REFLECT, LIGHT_SCREEN, DISABLE
	db PERFECT_DVS
	db ABILITY_1 | BOLD, FEMALE ; Insomnia, +Def -Atk

	; ALAKAZAM type: Psychic
	; 55,  50,  45, 120, 135,  95
	; hp  atk  def  spd  sat  sdf
	db ALAKAZAM, LIFE_ORB ;(E)
	db PSYCHIC_M, HIDDEN_POWER, SHADOW_BALL, RECOVER ; NASTY_PLOT if available HP Fighting
	db BTDVS_HP_FIGHTING
	db HIDDEN_ABILITY | TIMID, MALE ; Trace, +Speed -Atk

	db ALAKAZAM, FOCUS_SASH ;(G)
	db PSYCHIC_M, HIDDEN_POWER, COUNTER, THUNDER_WAVE ; HP Fighting
	db BTDVS_HP_FIGHTING
	db ABILITY_2 | TIMID, FEMALE ; Magic Guard, +Speed -Atk

	; DITTO type: Normal
	; 78,  28,  48, 108,  28,  48
	; hp  atk  def  spd  sat  sdf
	db DITTO, CHOICE_SCARF ;(G)
	db TRANSFORM, NO_MOVE, NO_MOVE, NO_MOVE ; HP Ice
	db BTDVS_TRICK_ROOM ; Minimize speed for mirror match and HP type
	db SHINY_MASK | HIDDEN_ABILITY | RELAXED, $0 ; Imposter, +Def -Speed

	; FORRETRESS type: Bug, Steel
	; 75,  90, 140,  40,  60,  60
	; hp  atk  def  spd  sat  sdf
	db FORRETRESS, CUSTAP_BERRY ;(A)
	db IRON_HEAD, EARTHQUAKE, EXPLOSION, TOXIC
	db PERFECT_DVS
	db ABILITY_1 | IMPISH, MALE ; Sturdy, +Def -SpAtk

	db FORRETRESS, ASSAULT_VEST ;(A)
	db GYRO_BALL, EARTHQUAKE, VOLT_SWITCH, EXPLOSION
	db BTDVS_TRICK_ROOM ; Minimize speed for Gyro Ball & Volt Switch
	db HIDDEN_ABILITY | RELAXED, FEMALE ; Overcoat, +Def -Speed

	; NIDOQUEEN type: Poison, Ground
	; 90,  92,  87,  76,  75,  85
	; hp  atk  def  spd  sat  sdf
	db NIDOQUEEN, BLACK_SLUDGE ;(A)
	db SLUDGE_BOMB, EARTH_POWER, ICE_BEAM, HEALINGLIGHT
	db PERFECT_DVS
	db HIDDEN_ABILITY | BOLD, FEMALE ; Sheer Force, +Def -Atk

	db NIDOQUEEN, LIFE_ORB ;(G)
	db SLUDGE_BOMB, EARTH_POWER, STONE_EDGE, CLOSE_COMBAT
	db PERFECT_DVS
	db HIDDEN_ABILITY | HASTY, FEMALE ; Sheer Force, +Speed -Def

	; NIDOKING type: Poison, Ground
	; 81, 102,  77,  85,  85,  75
	; hp  atk  def  spd  sat  sdf
	db NIDOKING, LIFE_ORB ;(G)
	db SLUDGE_BOMB, EARTH_POWER, ICE_BEAM, FLAMETHROWER
	db PERFECT_DVS
	db HIDDEN_ABILITY | TIMID, MALE ; Sheer Force, +Speed -Atk

	db NIDOKING, LIFE_ORB ;(G)
	db POISON_JAB, EARTHQUAKE, ICE_PUNCH, THUNDERPUNCH
	db PERFECT_DVS
	db HIDDEN_ABILITY | JOLLY, MALE ; Sheer Force, +Speed -SpAtk

	; YANMEGA type Bug, Dragon
	; 86,  76,  86,  95, 116,  56
	; hp  atk  def  spd  sat  sdf
	db YANMEGA, CHOICE_SPECS ;(G)
	db BUG_BUZZ, DRAGON_PULSE, GIGA_DRAIN, HIDDEN_POWER ; HP Ground
	db BTDVS_HP_GROUND
	db ABILITY_2 | TIMID, MALE ; Tinted Lens, +Speed -Atk

	db YANMEGA, LIFE_ORB ;(E)
	db BUG_BUZZ, DRAGON_PULSE, HIDDEN_POWER, PROTECT ; HP Ground
	db BTDVS_HP_GROUND
	db ABILITY_1 | MODEST, FEMALE ; Speed Boost, +SpAtk -Atk

	; SUNFLORA, type: Grass, Fire
	; 75,  55,  75,  85, 105,  85
	; hp  atk  def  spd  sat  sdf
	db SUNFLORA, HEAT_ROCK ;(G)
	db GIGA_DRAIN, FLAMETHROWER, HEALINGLIGHT, SUNNY_DAY
	db PERFECT_DVS
	db ABILITY_1 | MODEST, FEMALE ; Chlorophyll, +SpAtk -Atk

	; EXEGGUTOR type: Grass, Psychic
	; 95,  95,  85,  55, 125,  75
	; hp  atk  def  spd  sat  sdf
	db EXEGGUTOR, LIFE_ORB ;(G)
	db SOLAR_BEAM, PSYCHIC_M, HIDDEN_POWER, SUNNY_DAY ; HP Fire
	db BTDVS_HP_FIRE
	db ABILITY_1 | MODEST, MALE ; Chlorophyll, +SpAtk -Atk

	db EXEGGUTOR, LIFE_ORB ;(G)
	db GIGA_DRAIN, PSYCHIC_M, HIDDEN_POWER, TRICK_ROOM ; HP Ice
	db BTDVS_TRICK_ROOM
	db HIDDEN_ABILITY | QUIET, FEMALE ; Harvest, +SpAtk -Speed

	db EXEGGUTOR, LUM_BERRY ;(E)
	db PETAL_DANCE, PSYCHIC_M, REST, SLEEP_POWDER
	db PERFECT_DVS
	db HIDDEN_ABILITY | MODEST, FEMALE ; Harvest, +SpAtk -Atk

	db EXEGGUTOR, LUM_BERRY ;(G)
	db POWER_WHIP, ZEN_HEADBUTT, REST, CURSE
	db PERFECT_DVS
	db HIDDEN_ABILITY | ADAMANT, MALE ; Harvest, +Atk, -SpAtk

	db EXEGGUTOR, SITRUS_BERRY ;(G)
	db PSYCHIC_M, PROTECT, LEECH_SEED, SUBSTITUTE
	db PERFECT_DVS
	db HIDDEN_ABILITY | BOLD, FEMALE ; Harvest, +Def -Atk

	; EXEGGUTOR(alola) type: Grass, Dragon
	; 95, 105,  85,  45, 125,  75
	; hp  atk  def  spd  sat  sdf
	db EXEGGUTOR, CHOICE_SPECS ;(G)
	db GIGA_DRAIN, DRAGON_PULSE, FLAMETHROWER, SLUDGE_BOMB
	db PERFECT_DVS
	db ABILITY_1 | MODEST, MALE | ALOLAN_FORM ; Frisk, +SpAtk -Atk

	db EXEGGUTOR, LUM_BERRY ;(E)
	db GIGA_DRAIN, DRAGON_PULSE, REST, TRICK_ROOM
	db BTDVS_TRICK_ROOM
	db HIDDEN_ABILITY | QUIET, FEMALE | ALOLAN_FORM ; Harvest, +SpAtk, -Speed

	db EXEGGUTOR, SITRUS_BERRY ;(G)
	db POWER_WHIP, OUTRAGE, EARTHQUAKE, SLEEP_POWDER
	db PERFECT_DVS
	db HIDDEN_ABILITY | ADAMANT, MALE | ALOLAN_FORM ; Harvest, +SpAtk -Atk

	; SUDOWOODO type: Rock
	; 75, 115, 130,  30,  30,  80
	; hp  atk  def  spd  sat  sdf
	db SUDOWOODO, CHOICE_BAND ;(A)
	db STONE_EDGE, EARTHQUAKE, SUCKER_PUNCH, CLOSE_COMBAT
	db PERFECT_DVS
	db ABILITY_1 | ADAMANT, MALE ; Sturdy, +Atk -SpAtk

	db SUDOWOODO, CUSTAP_BERRY ;(A)
	db STONE_EDGE, EARTHQUAKE, SUCKER_PUNCH, EXPLOSION
	db PERFECT_DVS
	db ABILITY_1 | ADAMANT, FEMALE ; Sturdy, +Atk -SpAtk

	; VENOMOTH type: Bug, Poison
	; 70,  65,  60,  90, 115,  75
	; hp  atk  def  spd  sat  sdf
	db VENOMOTH, LIFE_ORB ;(A)
	db BUG_BUZZ, SLUDGE_BOMB, ROOST, SLEEP_POWDER
	db PERFECT_DVS
	db ABILITY_2 | TIMID, FEMALE ; Tinted Lens, +Speed -Atk

	; SCYTHER type: Bug, Flying
	; 70, 110,  80, 105,  55,  80
	; hp  atk  def  spd  sat  sdf
	db SCYTHER, CHOICE_BAND ;(A)
	db U_TURN, AERIAL_ACE, KNOCK_OFF, ROCK_SMASH ; -> "BRICK_BREAK"
	db PERFECT_DVS
	db ABILITY_2 | JOLLY, MALE ; Technician, +Speed -SpAtk

	db SCYTHER, EVIOLITE ;(G)
	db BUG_BITE, AERIAL_ACE, ROOST, SWORDS_DANCE
	db PERFECT_DVS
	db ABILITY_2 | JOLLY, FEMALE ; Technician, +Speed -SpAtk

	; SCIZOR type: Bug, Steel
	; 70, 130, 100,  65,  55,  80
	; hp  atk  def  spd  sat  sdf
	db SCIZOR, CHOICE_BAND ;(E)
	db BULLET_PUNCH, U_TURN, CLOSE_COMBAT, CRABHAMMER ; Wild move
	db PERFECT_DVS
	db ABILITY_2 | ADAMANT, MALE ; Technician, +Atk -SpAtk

	db SCIZOR, LIFE_ORB ;(G)
	db BULLET_PUNCH, BUG_BITE, ROOST, SWORDS_DANCE
	db PERFECT_DVS
	db ABILITY_2 | ADAMANT, FEMALE ; Technician, +Atk -SpAtk

	db SCIZOR, ROCKY_HELMET ;(G)
	db BULLET_PUNCH, U_TURN, ROOST, TOXIC
	db PERFECT_DVS
	db ABILITY_2 | IMPISH, FEMALE ; Technician, +Def -SpAtk

	; PINSIR type: Bug
	; 65, 125, 100,  85,  55,  70
	; hp  atk  def  spd  sat  sdf
	db PINSIR, LIFE_ORB ;(A)
	db LEECH_LIFE, STONE_EDGE, EARTHQUAKE, SWORDS_DANCE
	db PERFECT_DVS
	db ABILITY_2 | JOLLY, MALE ; Mold Breaker, +Speed -SpAtk

	db PINSIR, CHOICE_SCARF ;(C)
	db MEGAHORN, STONE_EDGE, EARTHQUAKE, KNOCK_OFF
	db PERFECT_DVS
	db HIDDEN_ABILITY | ADAMANT, FEMALE ; Moxie, +Atk -SpAtk

	; HERACROSS type: Bug, Fighting
	; 80, 125,  75,  85,  40,  95
	; hp  atk  def  spd  sat  sdf
	db HERACROSS, CHOICE_SCARF ;(A)
	db MEGAHORN, CLOSE_COMBAT, STONE_EDGE, KNOCK_OFF
	db PERFECT_DVS
	db ABILITY_1 | JOLLY, FEMALE ; Moxie, +Speed -SpAtk

	db HERACROSS, FLAME_ORB ;(G)
	db CLOSE_COMBAT, STONE_EDGE, FACADE, KNOCK_OFF
	db PERFECT_DVS
	db ABILITY_2 | JOLLY, MALE ; Guts, +Speed -SpAtk

	db HERACROSS, LIFE_ORB ;(E)
	db PIN_MISSILE, CLOSE_COMBAT, ROCK_BLAST, SWORDS_DANCE
	db PERFECT_DVS
	db HIDDEN_ABILITY | JOLLY, FEMALE ; Skill Link, +Speed -SpAtk

	; WEEZING: Poison
	; 65,  90, 120,  60,  85,  70
	; hp  atk  def  spd  sat  sdf
	db WEEZING, ROCKY_HELMET ;(G)
	db SLUDGE_BOMB, FIRE_BLAST, EXPLOSION, WILL_O_WISP
	db PERFECT_DVS
	db ABILITY_1 | BOLD, MALE ; Levitate, +Def -Atk

	db WEEZING, BLACK_SLUDGE ;(A)
	db DARK_PULSE, FLAMETHROWER, PAIN_SPLIT, TOXIC
	db PERFECT_DVS
	db ABILITY_1 | BOLD, FEMALE ; Levitate, +Def -Atk

	; WEEZING(galar) type: Poison, Fairy
	; 65,  90, 120,  60,  85,  70
	; hp  atk  def  spd  sat  sdf
	db WEEZING, ASSAULT_VEST ;(E)
	db SLUDGE_BOMB, MOONBLAST, FIRE_BLAST, EXPLOSION
	db PERFECT_DVS
	db ABILITY_1 | MODEST, MALE | GALARIAN_FORM ; Levitate, +SpAtk -Atk

	db WEEZING, BLACK_SLUDGE ;(G)
	db MOONBLAST, FLAMETHROWER, PAIN_SPLIT, WILL_O_WISP
	db PERFECT_DVS
	db ABILITY_1 | BOLD, FEMALE | GALARIAN_FORM ; Levitate, +Def -Atk

	; MUK type: Poison
	; 105, 105,  75,  50,  65, 100
	;  hp  atk  def  spd  sat  sdf
	db MUK, CHOICE_BAND ;(A)
	db GUNK_SHOT, FIRE_PUNCH, ICE_PUNCH, STRENGTH
	db PERFECT_DVS
	db HIDDEN_ABILITY | ADAMANT, MALE ; Poison Touch, +Atk -SpAtk

	db MUK, BLACK_SLUDGE ;(A)
	db POISON_JAB, CURSE, REST, SLEEP_TALK
	db PERFECT_DVS
	db ABILITY_2 | CAREFUL, FEMALE ; Sticky Hold, +SpDef -SpAtk

	; MUK(alola) type: Poison, Dark
	; 105, 105,  75,  50,  65, 100
	;  hp  atk  def  spd  sat  sdf
	db MUK, ASSAULT_VEST ;(E)
	db GUNK_SHOT, KNOCK_OFF, FIRE_PUNCH, EXPLOSION
	db PERFECT_DVS
	db ABILITY_1 | ADAMANT, MALE | ALOLAN_FORM ; Poison Touch, +Atk -SpAtk

	db MUK, FIGY_BERRY ;(G)
	db POISON_JAB, KNOCK_OFF, MINIMIZE, CURSE
	db PERFECT_DVS
	db ABILITY_2 | CAREFUL, FEMALE | ALOLAN_FORM ; Gluttony, +Atk -SpAtk

	; MAGNETON type: Electric, Steel
	; 50,  60,  95,  70, 120,  70
	; hp  atk  def  spd  sat  sdf
	db MAGNETON, EVIOLITE ;(G)
	db THUNDERBOLT, FLASH_CANNON, HIDDEN_POWER, SUBSTITUTE ; HP Fire
	db BTDVS_HP_FIRE
	db ABILITY_2 | MODEST, $0 ; Levitate, +SpAtk -Atk

	; MAGNEZONE type: Electric, Steel
	; 70,  70, 115,  60, 130,  90
	; hp  atk  def  spd  sat  sdf
	db MAGNEZONE, CHOICE_SCARF ;(G)
	db THUNDERBOLT, FLASH_CANNON, HIDDEN_POWER, THUNDER_WAVE ; HP Fire
	db BTDVS_HP_FIRE
	db ABILITY_1 | TIMID, $0 ; Magnet Pull, +Speed -Atk

	db MAGNEZONE, CHOICE_SPECS ;(E)
	db VOLT_SWITCH, THUNDERBOLT, FLASH_CANNON, HIDDEN_POWER ; HP Ice
	db BTDVS_HP_ICE
	db ABILITY_2 | MODEST, $0 ; Levitate, +SpAtk -Atk

	db MAGNEZONE, ASSAULT_VEST ;(E)
	db THUNDERBOLT, FLASH_CANNON, HIDDEN_POWER, EXPLOSION; HP Fire
	db BTDVS_HP_FIRE
	db ABILITY_2 | MODEST, $0 ; Levitate, +SpAtk -Atk

	; ELECTRODE type Electric
	; 60,  50,  70, 150,  80,  80
	; hp  atk  def  spd  sat  sdf
	db ELECTRODE, FOCUS_SASH ;(C)
	db THUNDERBOLT, HIDDEN_POWER, BUG_BUZZ, EXPLOSION ; HP Grass
	db BTDVS_HP_GRASS
	db HIDDEN_ABILITY | MODEST, $0 ; Aftermath, +SpAtk -Atk

	db ELECTRODE, LIGHT_CLAY ;(C)
	db THUNDERBOLT, EXPLOSION, REFLECT, LIGHT_SCREEN
	db PERFECT_DVS
	db HIDDEN_ABILITY | MODEST, $0 ; Aftermath, +SpAtk -Atk

	; GRANBULL type: Fairy
	; 90, 120,  75,  45,  60,  60
	; hp  atk  def  spd  sat  sdf
	db GRANBULL, LEFTOVERS ;(C)
	db PLAY_ROUGH, EARTHQUAKE, FIRE_PUNCH, THUNDER_WAVE
	db PERFECT_DVS
	db ABILITY_1 | ADAMANT, FEMALE ; Intimidate, +Atk -SpAtk

	; NINETALES type: Fire, Ghost
	; 73,  76,  75, 100,  81, 100
	; hp  atk  def  spd  sat  sdf
	db NINETALES, LEFTOVERS ;(A)
	db FIRE_BLAST, SHADOW_BALL, SOLAR_BEAM, NASTY_PLOT
	db PERFECT_DVS
	db HIDDEN_ABILITY | TIMID, FEMALE ; Drought, +Speed -Atk

	; NINETALES(alola) type: Ice, Fairy
	; 73,  67,  75, 109,  81, 100
	; hp  atk  def  spd  sat  sdf
	db NINETALES, LEFTOVERS ;(A)
	db BLIZZARD, MOONBLAST, HIDDEN_POWER, NASTY_PLOT ; HP Ground
	db BTDVS_HP_GROUND
	db HIDDEN_ABILITY | TIMID, FEMALE | ALOLAN_FORM ; Snow Warning, +Speed -Atk

	; ARCANINE type: Fire
	; 90, 110,  80,  95, 100,  80
	; hp  atk  def  spd  sat  sdf
	db ARCANINE, LIFE_ORB ;(E)
	db FLARE_BLITZ, WILD_CHARGE, CLOSE_COMBAT, DRAGON_DANCE
	db PERFECT_DVS
	db ABILITY_1 | JOLLY, MALE ; Intimidate, +Speed -SpAtk

	db ARCANINE, CHOICE_BAND ;(G)
	db FLARE_BLITZ, WILD_CHARGE, CLOSE_COMBAT, EXTREMESPEED
	db PERFECT_DVS
	db ABILITY_1 | JOLLY, MALE ; Intimidate, +Speed -SpAtk

	db ARCANINE, LEFTOVERS ;(A)
	db FLAMETHROWER, ROAR, HEALINGLIGHT, WILL_O_WISP
	db PERFECT_DVS
	db ABILITY_1 | CALM, FEMALE ; Intimidate, +SpDef -Atk

	db -1

	; AZUMARILL type: Water, Fairy
	; 100,  50,  80,  50,  90,  80
	;  hp  atk  def  spd  sat  sdf
	db AZUMARILL, CHOICE_BAND ;(G)
	db AQUA_JET, WATERFALL, PLAY_ROUGH, CLOSE_COMBAT
	db PERFECT_DVS
	db ABILITY_2 | ADAMANT, FEMALE ; Huge Power, +Atk -SpAtk

	db AZUMARILL, SITRUS_BERRY ;(A)
	db AQUA_JET, PLAY_ROUGH, KNOCK_OFF, BELLY_DRUM
	db PERFECT_DVS
	db ABILITY_2 | ADAMANT, MALE ; Huge Power, +Atk -SpAtk

	db AZUMARILL, ASSAULT_VEST ;(A)
	db AQUA_JET, WATERFALL, PLAY_ROUGH, KNOCK_OFF
	db PERFECT_DVS
	db ABILITY_2 | ADAMANT, MALE ; Huge Power, +Atk -SpAtk

	db AZUMARILL, LEFTOVERS ;(C)
	db WHIRLPOOL, TOXIC, PROTECT, PERISH_SONG
	db PERFECT_DVS
	db HIDDEN_ABILITY | CALM, FEMALE ; Sap Sipper, +SpDef -Atk

	; DUGTRIO type: Ground
	; 35, 100,  50, 120,  50,  70
	; hp  atk  def  spd  sat  sdf
	db DUGTRIO, CHOICE_BAND ;(A)
	db EARTHQUAKE, STONE_EDGE, SUCKER_PUNCH, TOXIC
	db PERFECT_DVS
	db ABILITY_2 | JOLLY, MALE ; Arena Trap, +Speed -SpAtk

	; DUGTRIO(alola) type: Ground, Steel
	; 35, 100,  60, 110,  50,  70
	; hp  atk  def  spd  sat  sdf
	db DUGTRIO, FOCUS_SASH ;(A)
	db EARTHQUAKE, IRON_HEAD, STONE_EDGE, SANDSTORM
	db PERFECT_DVS
	db HIDDEN_ABILITY | JOLLY, MALE | ALOLAN_FORM ; Sand Force, +Speed -SpAtk

	; PRIMEAPE type: Fighting
	; 65, 105,  60,  95,  60,  70
	; hp  atk  def  spd  sat  sdf
	db PRIMEAPE, CHOICE_SCARF ;(C)
	db CLOSE_COMBAT, STONE_EDGE, GUNK_SHOT, ICE_PUNCH
	db PERFECT_DVS
	db HIDDEN_ABILITY | ADAMANT, MALE ; Defiant, +Atk -SpAtk

	; PERSIAN type: Normal
	; 65,  70,  60, 115,  65,  65
	; hp  atk  def  spd  sat  sdf
	db PERSIAN, LIFE_ORB ;(A)
	db HYPER_VOICE, DARK_PULSE, WATER_PULSE, NASTY_PLOT
	db PERFECT_DVS
	db ABILITY_2 | TIMID, MALE ; Technician, +Speed -Atk

	db PERSIAN, RED_CARD ;(C)
	db THIEF, AERIAL_ACE, HYPNOSIS, HONE_CLAWS
	db PERFECT_DVS
	db ABILITY_2 | JOLLY, FEMALE ; Technician, +Speed -SpAtk

	; PERSIAN(alola) type: Dark
	; 65,  60,  60, 115,  75,  65
	; hp  atk  def  spd  sat  sdf
	db PERSIAN, EXPERT_BELT ;(A)
	db DARK_PULSE, ICY_WIND, POWER_GEM, NASTY_PLOT
	db PERFECT_DVS
	db ABILITY_1 | TIMID, MALE | ALOLAN_FORM ; Fur Coat, +Speed -Atk

	db PERSIAN, LEFTOVERS ;(C)
	db DARK_PULSE, ATTRACT, REST, TOXIC
	db PERFECT_DVS
	db ABILITY_1 | TIMID, MALE | ALOLAN_FORM ; Fur Coat, +Speed -Atk

	db PERSIAN, BLUNDRPOLICY ;(C)
	db THIEF, PLAY_ROUGH, HYPNOSIS, HONE_CLAWS
	db PERFECT_DVS
	db ABILITY_1 | JOLLY, FEMALE | ALOLAN_FORM ; Fur Coat, +Speed -SpAtk

	; GOLDUCK type: Water, Psychic
	; 80,  82,  78,  85,  95,  80
	; hp  atk  def  spd  sat  sdf
	db GOLDUCK, LIFE_ORB ;(A)
	db HYDRO_PUMP, ICE_BEAM, HIDDEN_POWER, RAIN_DANCE ; HP Grass
	db BTDVS_HP_GRASS
	db HIDDEN_ABILITY | MODEST, MALE ; Swift Swim, +SpAtk -Atk

	db GOLDUCK, LEFTOVERS ;(C), HORRIBLE
	db SCALD, PSYCHIC_M, CALM_MIND, CONFUSE_RAY
	db PERFECT_DVS
	db ABILITY_1 | MODEST, FEMALE ; Cloud Nine, +SpAtk -Atk

	; MACHAMP type: Fighting
	; 90, 130,  80,  55,  65,  85
	; hp  atk  def  spd  sat  sdf
	db MACHAMP, ASSAULT_VEST ;(G)
	db DYNAMICPUNCH, KNOCK_OFF, BULLET_PUNCH, ICE_PUNCH
	db PERFECT_DVS
	db ABILITY_2 | ADAMANT, MALE ; No Guard, +Atk -SpAtk

	db MACHAMP, FLAME_ORB ;(A)
	db CLOSE_COMBAT, KNOCK_OFF, BULLET_PUNCH, FACADE
	db PERFECT_DVS
	db ABILITY_1 | ADAMANT, FEMALE ; Guts, +Atk -SpAtk

	; HITMONLEE type: Fighting
	; 50, 120,  53,  87,  35, 110
	; hp  atk  def  spd  sat  sdf
	db HITMONLEE, LIFE_ORB ;(A)
	db MACH_PUNCH, HI_JUMP_KICK, KNOCK_OFF, POISON_JAB
	db PERFECT_DVS
	db ABILITY_2 | JOLLY, MALE ; Reckless, +Speed -SpAtk

	db HITMONLEE, WHITE_HERB ;(G)
	db CLOSE_COMBAT, KNOCK_OFF, POISON_JAB, CURSE
	db PERFECT_DVS
	db HIDDEN_ABILITY | ADAMANT, MALE ; Unburden, +Atk -SpAtk

	; HITMONCHAN type: Fighting
	; 50, 105,  79,  76,  35, 110
	; hp  atk  def  spd  sat  sdf
	db HITMONCHAN, ASSAULT_VEST ;(A)
	db MACH_PUNCH, DRAIN_PUNCH, THUNDERPUNCH, ICE_PUNCH
	db PERFECT_DVS
	db ABILITY_2 | ADAMANT, MALE ; Iron Fist, +Atk -SpAtk

	; HITMONTOP type: Fighting
	; 50,  95,  95,  70,  35, 110
	; hp  atk  def  spd  sat  sdf
	db HITMONTOP, LEFTOVERS ;(A)
	db HI_JUMP_KICK, SUCKER_PUNCH, STONE_EDGE, BULK_UP
	db PERFECT_DVS
	db ABILITY_1 | IMPISH, MALE ; Intimidate, +Def -SpAtk

	db HITMONTOP, LIFE_ORB ;(A)
	db MACH_PUNCH, FEINT_ATTACK, BULLDOZE, AERIAL_ACE
	db PERFECT_DVS
	db ABILITY_2 | ADAMANT, MALE ; Technician, +Atk -SpAtk

	; GIRAFARIG type: Normal, Psychic
	; 70,  80,  65, 105, 110,  65
	; hp  atk  def  spd  sat  sdf
	db GIRAFARIG, LIFE_ORB ;(A)
	db PSYCHIC_M, SHADOW_BALL, THUNDERBOLT, NASTY_PLOT
	db PERFECT_DVS
	db HIDDEN_ABILITY | TIMID, MALE ; Sap Sipper, +Speed -Atk

	db GIRAFARIG, LEFTOVERS ;(C)
	db PSYCHIC_M, BATON_PASS, SUBSTITUTE, AGILITY
	db PERFECT_DVS
	db HIDDEN_ABILITY | TIMID, FEMALE ; Sap Sipper, +Speed -Atk

	; TAUROS type: Normal
	; 75, 100,  95, 110,  40,  70
	; hp  atk  def  spd  sat  sdf
	db TAUROS, LIFE_ORB ;(G)
	db BODY_SLAM, EARTHQUAKE, ZEN_HEADBUTT, BULK_UP
	db PERFECT_DVS
	db HIDDEN_ABILITY | JOLLY, MALE ; Sheer Force, +Speed -SpAtk

	db TAUROS, CHOICE_SCARF ;(A)
	db DOUBLE_EDGE, EARTHQUAKE, ZEN_HEADBUTT, STONE_EDGE
	db PERFECT_DVS
	db HIDDEN_ABILITY | ADAMANT, MALE ; Intimidate, +Atk -SpAtk

	; MILTANK type: Normal
	; 95,  80, 105, 100,  40,  70
	; hp  atk  def  spd  sat  sdf
	db MILTANK, LEFTOVERS ;(G)
	db BODY_SLAM, HEAL_BELL, FRESH_SNACK, TOXIC
	db PERFECT_DVS
	db ABILITY_1 | IMPISH, FEMALE ; Thick Fat, +Def -SpAtk

	db MILTANK, LIFE_ORB ;(A)
	db DOUBLE_EDGE, EARTHQUAKE, ROLLOUT, FRESH_SNACK
	db PERFECT_DVS
	db HIDDEN_ABILITY | JOLLY, FEMALE ; Sap Sipper, +Speed -SpAtk

	; MAGMAR type: Fire
	; 65,  95,  57,  93, 100,  85
	; hp  atk  def  spd  sat  sdf
	db MAGMAR, EVIOLITE ;(A)
	db FLARE_BLITZ, CROSS_CHOP, THUNDERPUNCH, WILL_O_WISP
	db PERFECT_DVS
	db HIDDEN_ABILITY | IMPISH, FEMALE ; Vital Spirit, +Def -SpAtk

	; MAGMORTAR type: Fire, Fighting
	; 75,  95,  67,  93, 125,  95
	; hp  atk  def  spd  sat  sdf
	db MAGMORTAR, ASSAULT_VEST ;(G)
	db FIRE_BLAST, FOCUS_BLAST, THUNDERBOLT, HIDDEN_POWER ; HP Grass
	db BTDVS_HP_GRASS
	db HIDDEN_ABILITY | MODEST, FEMALE ; Vital Spirit, +SpAtk -Atk

	db MAGMORTAR, CHOICE_BAND ;(A)
	db FLARE_BLITZ, CROSS_CHOP, EARTHQUAKE, THUNDERPUNCH
	db PERFECT_DVS
	db HIDDEN_ABILITY | ADAMANT, MALE ; Vital Spirit, +Atk -SpAtk

	; ELECTABUZZ type: Electric
	; 65,  88,  57, 105,  95,  85
	; hp  atk  def  spd  sat  sdf
	db ELECTABUZZ, EVIOLITE ;(A)
	db VOLT_SWITCH, FOCUS_BLAST, HIDDEN_POWER, PSYCHIC_M ; HP Ice
	db BTDVS_HP_ICE
	db HIDDEN_ABILITY | TIMID, MALE ; Vital Spirit, +Speed -Atk

	; ELECTIVIRE type: Electric, Fighting
	; 75, 123,  67, 105,  95,  85
	; hp  atk  def  spd  sat  sdf
	db ELECTIVIRE, LIFE_ORB ;(G)
	db THUNDERBOLT, CROSS_CHOP, FLAMETHROWER, EARTHQUAKE
	db PERFECT_DVS
	db ABILITY_1 | MILD, FEMALE ; Motor Drive, +SpAtk -Def

	db ELECTIVIRE, EXPERT_BELT ;(G)
	db WILD_CHARGE, CROSS_CHOP, ICE_PUNCH, EARTHQUAKE
	db PERFECT_DVS
	db ABILITY_1 | ADAMANT, MALE ; Motor Drive, +Atk -SpAtk

	; JYNX type: Ice, Psychic
	; 70,  60,  40,  95, 120, 100
	; hp  atk  def  spd  sat  sdf
	db JYNX, FOCUS_SASH ;(E)
	db ICE_BEAM, PSYCHIC_M, SING, NASTY_PLOT
	db PERFECT_DVS
	db ABILITY_2 | TIMID, FEMALE ; Filter, +Speed -Atk

	db JYNX, CHOICE_SCARF ;(G)
	db ICE_BEAM, PSYCHIC_M, FOCUS_BLAST, HIDDEN_POWER ; HP Fire TRICK if better AI
	db BTDVS_HP_FIRE
	db ABILITY_2 | TIMID, FEMALE ; Filter, +Speed -Atk

	; MR__MIME type: Psychic, Fairy
	; 50,  45,  65, 100, 100, 125
	; hp  atk  def  spd  sat  sdf
	db MR__MIME, LIFE_ORB ;(A)
	db PSYCHIC_M, DAZZLINGLEAM, SHADOW_BALL, NASTY_PLOT
	db PERFECT_DVS
	db ABILITY_2 | TIMID, FEMALE ; Filter, +Speed -Atk

	db MR__MIME, CHOICE_SCARF ;(G)
	db PSYCHIC_M, DAZZLINGLEAM, THUNDERBOLT, FOCUS_BLAST ; TRICK if better AI
	db PERFECT_DVS
	db ABILITY_1 | TIMID, MALE ; Soundproof, +Speed -Atk

	; SMEARGLE type: Normal
	; 55,  20,  35, 100,  20,  45
	; hp  atk  def  spd  sat  sdf
	db SMEARGLE, FOCUS_SASH ;(G)
	db SPORE, SUBSTITUTE, BATON_PASS, SHELL_SMASH
	db PERFECT_DVS
	db HIDDEN_ABILITY | TIMID, FEMALE ; Moody, +Speed -Atk

	db SMEARGLE, FOCUS_SASH ;(A)
	db SPORE, EXTREMESPEED, SUCKER_PUNCH, BELLY_DRUM
	db PERFECT_DVS
	db ABILITY_1 | JOLLY, MALE ; Own Tempo, +Speed -SpAtk

	db SMEARGLE, FOCUS_SASH ;(A)
	db SPORE, SUBSTITUTE, MEAN_LOOK, PERISH_SONG
	db PERFECT_DVS
	db ABILITY_1 | TIMID, MALE ; Own Tempo, +Speed -Atk

	db SMEARGLE, LEFTOVERS ;(G)
	db SPORE, TRANSFORM, PROTECT, EXPLOSION
	db PERFECT_DVS
	db ABILITY_1 | JOLLY, MALE ; Own Tempo, +Speed -SpAtk

	; FARFETCH_D type: Flying, Fighting
	; 55, 110,  55, 105,  60,  65
	; hp  atk  def  spd  sat  sdf
	db FARFETCH_D, STICK ;(A)
	db BRAVE_BIRD, HI_JUMP_KICK, KNOCK_OFF, POISON_JAB
	db PERFECT_DVS
	db HIDDEN_ABILITY | JOLLY, MALE ; Defiant, +Speed -SpAtk

	; XATU type: Psychic, Flying
	; 65,  75,  70, 100, 100,  70 
	; hp  atk  def  spd  sat  sdf
	db XATU, LIGHT_CLAY ;(A)
	db U_TURN, REFLECT, LIGHT_SCREEN, THUNDER_WAVE
	db PERFECT_DVS
	db HIDDEN_ABILITY | JOLLY, FEMALE ; Magic Bounce, +Speed -SpAtk

	db XATU, ROCKY_HELMET ;(A)
	db PSYCHIC_M, HEX, ROOST, TOXIC
	db PERFECT_DVS
	db HIDDEN_ABILITY | BOLD, MALE ; Magic Bounce, +Def -Atk

	; QWILFISH type: Water, Poison
	; 65, 100, 100,  85,  75,  55
	; hp  atk  def  spd  sat  sdf
	db QWILFISH, LIFE_ORB ;(A)
	db WATERFALL, POISON_JAB, EXPLOSION, RAIN_DANCE
	db PERFECT_DVS
	db ABILITY_2 | ADAMANT, MALE ; Swift Swim, +Atk -SpAtk

	db QWILFISH, ROCKY_HELMET ;(A)
	db WATERFALL, POISON_JAB, DESTINY_BOND, THUNDER_WAVE
	db PERFECT_DVS
	db HIDDEN_ABILITY | JOLLY, MALE ; Intimidate, +Speed -SpAtk

	; TENTACRUEL type: Water, Poison
	; 80,  70,  65, 100,  80, 120
	; hp  atk  def  spd  sat  sdf
	db TENTACRUEL, BLACK_SLUDGE ;(E)
	db SCALD, SLUDGE_BOMB, RECOVER, TOXIC ; Wild move
	db PERFECT_DVS
	db ABILITY_1 | BOLD, FEMALE ; Clear Body, +Def -Atk

	db TENTACRUEL, LIFE_ORB ;(G)
	db WATERFALL, POISON_JAB, KNOCK_OFF, SWORDS_DANCE
	db PERFECT_DVS
	db ABILITY_1 | JOLLY, MALE ; Clear Body, +Speed -SpAtk

	; KINGLER type: Water
	; 55, 130, 115,  75,  50,  50
	; hp  atk  def  spd  sat  sdf
	db KINGLER, LIFE_ORB ;(A)
	db AQUA_JET, CRABHAMMER, CLOSE_COMBAT, KNOCK_OFF
	db PERFECT_DVS
	db ABILITY_1 | ADAMANT, MALE ; Hyper Cutter, +Atk -SpAtk

	; SHUCKLE type: Bug, Rock
	; 20,  10, 230,  05,  10, 230
	; hp  atk  def  spd  sat  sdf
	db SHUCKLE, LEFTOVERS ;(C)
	db KNOCK_OFF, ENCORE, PROTECT, TOXIC
	db PERFECT_DVS
	db ABILITY_1 | IMPISH, FEMALE ; Sturdy, +Def -SpAtk

	db SHUCKLE, LEFTOVERS ;(C)
	db ROLLOUT, ENCORE, DEFENSE_CURL, TOXIC
	db PERFECT_DVS
	db ABILITY_1 | CAREFUL, FEMALE ; Sturdy, +SpDef -SpAtk

	; STARMIE type: Water, Psychic
	; 60,  75,  85, 115, 100,  85
	; hp  atk  def  spd  sat  sdf
	db STARMIE, LIFE_ORB ;(G)
	db HYDRO_PUMP, PSYCHIC_M, ICE_BEAM, THUNDERBOLT ; CHOICE_SPECS with TRICK if better AI
	db PERFECT_DVS
	db HIDDEN_ABILITY | TIMID, $0 ; Analytic, +Speed -Atk

	db STARMIE, LEFTOVERS ;(A)
	db SCALD, ICE_BEAM, RECOVER, TOXIC
	db PERFECT_DVS
	db ABILITY_2 | TIMID, $0 ; Natural Cure, +Speed -Atk

	; CLOYSTER type: Water, Ice
	; 50,  95, 180,  70,  85,  45
	; hp  atk  def  spd  sat  sdf
	db CLOYSTER, KINGS_ROCK ;(E)
	db ICE_SHARD, ICICLE_SPEAR, ROCK_BLAST, SHELL_SMASH
	db PERFECT_DVS
	db ABILITY_2 | JOLLY, MALE ; Skill Link, +Speed -SpAtk

	db CLOYSTER, FOCUS_SASH ;(A)
	db ICICLE_SPEAR, ROCK_BLAST, EXPLOSION, TOXIC_SPIKES
	db PERFECT_DVS
	db ABILITY_2 | ADAMANT, MALE ; Skill Link, +Speed -SpAtk

	db CLOYSTER, LIFE_ORB ;(G)
	db HYDRO_PUMP, ICE_BEAM, EXPLOSION, SHELL_SMASH
	db PERFECT_DVS
	db HIDDEN_ABILITY | TIMID, MALE ; Overcoat, +Speed -Atk

	; CORSOLA type: Water, Rock
	; 65,  55, 115,  35, 105, 115
	; hp  atk  def  spd  sat  sdf
	db CORSOLA, ROCKY_HELMET ;(A)
	db SCALD, POWER_GEM, RECOVER, TOXIC
	db PERFECT_DVS
	db HIDDEN_ABILITY | BOLD, FEMALE ; Regenerator, +Def -Atk

	; OCTILLERY, type: Water, Fire
	; 75, 105,  75,  45, 105,  75
	; hp  atk  def  spd  sat  sdf
	db OCTILLERY, CHOICE_SPECS ;(C)
	db OCTAZOOKA, FIRE_BLAST, ICE_BEAM, ENERGY_BALL ; OCTAZOOKA is still special
	db PERFECT_DVS
	db HIDDEN_ABILITY | MODEST, FEMALE ; Moody, +SpAtk -Atk

	db OCTILLERY, CHOICE_BAND ;(C)
	db CRABHAMMER, SACRED_FIRE, GUNK_SHOT, POWER_WHIP ; OCTAZOOKA is not buffed, Moves are not legal
	db PERFECT_DVS
	db SHINY_MASK | HIDDEN_ABILITY | ADAMANT, MALE ; Moody, +Atk -SpAtk

	; LANTURN type: Water, Electric
	; 125,  58,  58,  67,  86,  86
	;  hp  atk  def  spd  sat  sdf
	db LANTURN, LEFTOVERS ;(G)
	db SCALD, VOLT_SWITCH, RECOVER, TOXIC
	db PERFECT_DVS
	db ABILITY_1 | CALM, MALE ; Volt Absorb, +SpDef -Atk

	db LANTURN, ASSAULT_VEST ;(G)
	db SCALD, VOLT_SWITCH, ICE_BEAM, HIDDEN_POWER ; HP Grass
	db BTDVS_HP_GRASS
	db ABILITY_1 | MODEST, FEMALE ; Volt Absorb, +SpAtk -Atk

	db LANTURN, LIFE_ORB ;(A)
	db HYDRO_PUMP, THUNDER, RECOVER, RAIN_DANCE
	db PERFECT_DVS
	db ABILITY_1 | MODEST, FEMALE ; Volt Absorb, +SpAtk -Atk

	; DEWGONG type: Water, Ice
	; 90,  70,  80,  70,  80,  95
	; hp  atk  def  spd  sat  sdf
	db DEWGONG, LEFTOVERS ;(A)
	db WATERFALL, AVALANCHE, MEGAHORN, CURSE
	db PERFECT_DVS
	db HIDDEN_ABILITY | CAREFUL, MALE ; Ice Body, +SpDef -SpAtk

	db DEWGONG, LEFTOVERS ;(C)
	db HAIL, ENCORE, PROTECT, TOXIC
	db PERFECT_DVS
	db HIDDEN_ABILITY | BOLD, MALE ; Ice Body, +Def -Atk

	db DEWGONG, LEFTOVERS ;(C)
	db WHIRLPOOL, RAIN_DANCE, REST, PERISH_SONG
	db PERFECT_DVS
	db ABILITY_2 | CALM, FEMALE ; Hydration, +SpDef -Atk

	; TANGELA type: Grass
	; 65,  55, 115,  60, 100,  40
	; hp  atk  def  spd  sat  sdf
	db TANGELA, EVIOLITE ;(G)
	db GIGA_DRAIN, KNOCK_OFF, LEECH_SEED, SLEEP_POWDER
	db PERFECT_DVS
	db HIDDEN_ABILITY | BOLD, MALE ; Regenerator, +Def -Atk

	; TANGROWTH type: Grass
	; 100, 100, 125,  50, 110,  50
	;  hp  atk  def  spd  sat  sdf
	db TANGROWTH, ASSAULT_VEST ;(E)
	db GIGA_DRAIN, HIDDEN_POWER, KNOCK_OFF, EARTHQUAKE ; HP Ice
	db BTDVS_HP_ICE
	db HIDDEN_ABILITY | SASSY, MALE ; Regenerator, +SpDef -Speed

	db TANGROWTH, ROCKY_HELMET ;(E)
	db GIGA_DRAIN, HIDDEN_POWER, KNOCK_OFF, SLEEP_POWDER ; HP Ice
	db BTDVS_HP_ICE
	db HIDDEN_ABILITY | RELAXED, FEMALE ; Regenerator, +Def -Speed

	db TANGROWTH, ROCKY_HELMET ;(G)
	db GIGA_DRAIN, HIDDEN_POWER, KNOCK_OFF, TOXIC ; HP Fire
	db BTDVS_HP_FIRE
	db HIDDEN_ABILITY | RELAXED, MALE ; Regenerator, +Def -Speed

	; VAPOREON type: Water
	; 130,  65,  60,  65, 110,  95
	;  hp  atk  def  spd  sat  sdf
	db VAPOREON, ROCKY_HELMET ;(E)
	db SCALD, ICE_BEAM, RECOVER, TOXIC
	db PERFECT_DVS
	db ABILITY_1 | BOLD, MALE ; Water Absorb, +Def -Atk

	db VAPOREON, ASSAULT_VEST ;(G)
	db SCALD, ICE_BEAM, EARTH_POWER, HIDDEN_POWER ; HP Electric
	db BTDVS_HP_ELECTRIC
	db ABILITY_2 | CALM, FEMALE ; Drizzle, +SpDef -Atk

	; JOLTEON type: Electric
	; 65,  65,  60, 130, 110,  95
	; hp  atk  def  spd  sat  sdf
	db JOLTEON, LIFE_ORB ;(E)
	db THUNDERBOLT, SHADOW_BALL, HIDDEN_POWER, TOXIC ; HP Ice
	db BTDVS_HP_ICE
	db ABILITY_1 | TIMID, MALE ; Volt Absorb, +Speed -Atk

	; FLAREON type: Fire
	; 65, 130,  60,  65,  95, 110
	; hp  atk  def  spd  sat  sdf
	db FLAREON, TOXIC_ORB ;(A)
	db FLARE_BLITZ, FACADE, STRENGTH, PROTECT
	db PERFECT_DVS
	db HIDDEN_ABILITY | ADAMANT, MALE ; Guts, +Atk -SpAtk

	db FLAREON, LIFE_ORB ;(C)
	db FLAMETHROWER, EARTH_POWER, SHADOW_BALL, SMOKESCREEN
	db PERFECT_DVS
	db ABILITY_2 | ADAMANT, MALE ; Drought, +SpAtk -Atk

	; ESPEON type: Psychic
	; 65,  65,  60, 110, 130,  95
	; hp  atk  def  spd  sat  sdf
	db ESPEON, LEFTOVERS ;(G)
	db PSYCHIC_M, DAZZLINGLEAM, HEALINGLIGHT, CALM_MIND
	db PERFECT_DVS
	db HIDDEN_ABILITY | TIMID, MALE ; Magic Bounce, +Speed -Atk

	db ESPEON, LIFE_ORB ;(G)
	db PSYCHIC_M, SHADOW_BALL, EARTH_POWER, HEALINGLIGHT
	db PERFECT_DVS
	db ABILITY_2 | TIMID, FEMALE ; Magic Guard, +Speed -Atk

	db ESPEON, LIGHT_CLAY ;(A)
	db PSYCHIC_M, REFLECT, LIGHT_SCREEN, TOXIC
	db PERFECT_DVS
	db HIDDEN_ABILITY | TIMID, MALE ; Magic Bounce, +Speed -Atk

	; UMBREON type: Dark
	; 95,  65, 110,  65,  60, 130
	; hp  atk  def  spd  sat  sdf
	db UMBREON, LEFTOVERS ;(G)
	db DARK_PULSE, MEAN_LOOK, HEALINGLIGHT, TOXIC
	db PERFECT_DVS
	db ABILITY_2 | BOLD, MALE ; Magic Guard, +Def, -Atk

	; LEAFEON type: Grass
	; 65, 110, 130,  95,  60,  65
	; hp  atk  def  spd  sat  sdf
	db LEAFEON, LEFTOVERS ;(G)
	db SEED_BOMB, KNOCK_OFF, STRENGTH, SWORDS_DANCE
	db PERFECT_DVS
	db ABILITY_2 | JOLLY, MALE ; Natural Cure, +Speed -SpAtk

	db LEAFEON, LIFE_ORB ;(A)
	db SEED_BOMB, KNOCK_OFF, STRENGTH, SUNNY_DAY
	db PERFECT_DVS
	db ABILITY_2 | ADAMANT, FEMALE ; Chlorophyll, +Atk -SpAtk

	; GLACEON type: Ice
	; 65,  60, 110,  65, 130,  95
	; hp  atk  def  spd  sat  sdf
	db GLACEON, CHOICE_SPECS ;(G)
	db BLIZZARD, SHADOW_BALL, EARTH_POWER, HIDDEN_POWER ; HP Flying
	db BTDVS_HP_FLYING
	db ABILITY_2 | MODEST, FEMALE ; Snow Warning, +SpAtk -Atk

	; SYLVEON type: Fairy
	; 95,  65,  65,  60, 110, 130
	; hp  atk  def  spd  sat  sdf
	db SYLVEON, CHOICE_SPECS ;(G)
	db HYPER_VOICE, SHADOW_BALL, HIDDEN_POWER, EARTH_POWER ; HP Fire
	db BTDVS_HP_FIRE
	db HIDDEN_ABILITY | MODEST, MALE ; Pixilate, +SpAtk -Atk

	db SYLVEON, LEFTOVERS ;(E)
	db HYPER_VOICE, EARTH_POWER, HIDDEN_POWER, CALM_MIND
	db BTDVS_HP_FIRE
	db HIDDEN_ABILITY | BOLD, FEMALE ; Pixilate, +Def -Atk

	db SYLVEON, LEFTOVERS ;(G)
	db HYPER_VOICE, EARTH_POWER, REST, SLEEP_TALK
	db PERFECT_DVS
	db HIDDEN_ABILITY | BOLD, FEMALE ; Pixilate, +Def -Atk

	; KINGDRA type: Water, Dragon
	; 75,  95,  95,  85,  95,  95
	; hp  atk  def  spd  sat  sdf
	db KINGDRA, LIFE_ORB ;(G)
	db HYDRO_PUMP, DRAGON_PULSE, ICE_BEAM, RAIN_DANCE
	db PERFECT_DVS
	db ABILITY_1 | MODEST, FEMALE ; Swift Swim, +SpAtk -Atk

	db KINGDRA, LUM_BERRY ;(G)
	db WATERFALL, OUTRAGE, REST, DRAGON_DANCE
	db PERFECT_DVS
	db ABILITY_2 | JOLLY, MALE ; Sniper, +Atk -SpAtk

	; GLISCOR type: Ground, Flying
	; 75,  95, 125,  95,  45,  75
	; hp  atk  def  spd  sat  sdf
	db GLISCOR, TOXIC_ORB ;(E)
	db EARTHQUAKE, FACADE, KNOCK_OFF, SWORDS_DANCE
	db PERFECT_DVS
	db HIDDEN_ABILITY | JOLLY, MALE ; Poison Heal, +Speed -SpAtk

	db GLISCOR, TOXIC_ORB ;(E)
	db EARTHQUAKE, SUBSTITUTE, ROOST, TOXIC
	db PERFECT_DVS
	db HIDDEN_ABILITY | CAREFUL, FEMALE ; Poison Heal, +SpDef -SpAtk

	; PILOSWINE type: Ice, Ground
	; 100, 100,  80,  50,  60,  60
	;  hp  atk  def  spd  sat  sdf
	db PILOSWINE, EVIOLITE ;(G)
	db ICE_SHARD, ICICLE_CRASH, EARTHQUAKE, KNOCK_OFF
	db PERFECT_DVS
	db HIDDEN_ABILITY | ADAMANT, MALE ; Thick Fat, +Atk -SpAtk

	; MAMOSWINE type: Ice, Ground
	; 110, 130,  80,  80,  70,  60
	;  hp  atk  def  spd  sat  sdf
	db MAMOSWINE, CHOICE_BAND ;(E)
	db ICE_SHARD, ICICLE_CRASH, EARTHQUAKE, KNOCK_OFF
	db PERFECT_DVS
	db HIDDEN_ABILITY | JOLLY, MALE ; Thick Fat, +Atk -SpAtk

	db MAMOSWINE, LEFTOVERS ;(G)
	db ICICLE_CRASH, EARTHQUAKE, REST, SLEEP_TALK
	db PERFECT_DVS
	db HIDDEN_ABILITY | IMPISH, FEMALE ; Thick Fat, +Def -SpAtk

	; URSARING type: Normal
	; 90, 130,  75,  55,  75,  75
	; hp  atk  def  spd  sat  sdf
	db URSARING, FLAME_ORB ;(A)
	db FACADE, EARTHQUAKE, CRUNCH, SWORDS_DANCE
	db PERFECT_DVS
	db ABILITY_1 | ADAMANT, MALE ; Guts, +Atk -SpAtk

	db URSARING, TOXIC_ORB ;(A)
	db FACADE, CLOSE_COMBAT, CRUNCH, SWORDS_DANCE
	db PERFECT_DVS
	db ABILITY_2 | JOLLY, FEMALE ; Quick Feet, +Speed -SpAtk

	; DONPHAN type: Ground
	; 90, 120, 120,  50,  60,  60
	; hp  atk  def  spd  sat  sdf
	db DONPHAN, CHOICE_BAND ;(G)
	db EARTHQUAKE, KNOCK_OFF, ICE_SHARD, SEED_BOMB
	db PERFECT_DVS
	db ABILITY_1 | ADAMANT, MALE ; Sturdy, +Atk -SpAtk

	; MANTINE type: Water, Flying
	; 85,  40,  70,  70,  80, 140
	; hp  atk  def  spd  sat  sdf
	db MANTINE, DAMP_ROCK ;(A)
	db SURF, HURRICANE, ROOST, RAIN_DANCE
	db PERFECT_DVS
	db ABILITY_1 | MODEST, MALE ; Swift Swim, +SpDef -Atk

	db MANTINE, LEFTOVERS ;(A)
	db SCALD, AIR_SLASH, ROOST, TOXIC
	db PERFECT_DVS
	db ABILITY_2 | CALM, FEMALE ; Water Absorb, +SpDef -Atk

	; SKARMORY type: Steel, Flying
	; 65,  80, 140,  70,  40,  70
	; hp  atk  def  spd  sat  sdf
	db SKARMORY, LEFTOVERS ;(G)
	db BRAVE_BIRD, IRON_HEAD, ROOST, SWORDS_DANCE
	db PERFECT_DVS
	db ABILITY_2 | IMPISH, MALE ; Sturdy, +Def -SpAtk

	db SKARMORY, ROCKY_HELMET ;(E)
	db SPIKES, TOXIC, ROOST, ROAR
	db PERFECT_DVS
	db ABILITY_2 | BOLD, FEMALE ; Sturdy, +Def -Atk

	; DODRIO type: Normal, Flying
	; 60, 110,  70, 110,  60,  60
	; hp  atk  def  spd  sat  sdf
	db DODRIO, LIFE_ORB ;(A)
	db BRAVE_BIRD, HI_JUMP_KICK, KNOCK_OFF, SWORDS_DANCE
	db PERFECT_DVS
	db ABILITY_2 | JOLLY, FEMALE ; Early Bird, +Speed -SpAtk

	db DODRIO, BERSERK_GENE ;(C)
	db BRAVE_BIRD, THRASH, ROOST, KNOCK_OFF
	db PERFECT_DVS
	db HIDDEN_ABILITY | ADAMANT, FEMALE ; Tangled Feet, +Atk -SpAtk

	; RAPIDASH type: Fire, Fairy
	; 65, 100,  70, 105,  80,  80
	; hp  atk  def  spd  sat  sdf
	db RAPIDASH, LIFE_ORB ;(A)
	db FLARE_BLITZ, PLAY_ROUGH, WILD_CHARGE, SWORDS_DANCE
	db PERFECT_DVS
	db ABILITY_2 | JOLLY, MALE ; Flash Fire, +Speed -SpAtk

	; RAPIDASH(galar) type: Psychic, Fairy
	; 65, 100,  70, 105,  80,  80
	; hp  atk  def  spd  sat  sdf
	db RAPIDASH, LIFE_ORB ;(A)
	db PLAY_ROUGH, STRENGTH, EXTREMESPEED, SWORDS_DANCE
	db PERFECT_DVS
	db ABILITY_2 | JOLLY, MALE | GALARIAN_FORM ; Pastel Veil, +Speed -SpAtk

	db RAPIDASH, LEFTOVERS ;(A)
	db PSYCHIC_M, MOONBLAST, HEALINGLIGHT, CALM_MIND
	db PERFECT_DVS
	db ABILITY_2 | TIMID, FEMALE | GALARIAN_FORM ; Pastel Veil, +Speed -Atk

	; MAROWAK type: Ground
	; 60,  80, 110,  70,  50,  80
	; hp  atk  def  spd  sat  sdf
	db MAROWAK, THICK_CLUB ;(A)
	db BONEMERANG, STONE_EDGE, KNOCK_OFF, FIRE_PUNCH
	db PERFECT_DVS
	db HIDDEN_ABILITY | ADAMANT, MALE ; Battle Armor, +Atk -SpAtk

	; MAROWAK(alola) type: Fire, Ghost
	; 60,  80, 110,  70,  50,  80
	; hp  atk  def  spd  sat  sdf
	db MAROWAK, THICK_CLUB ;(G)
	db FLARE_BLITZ, SHADOW_CLAW, STRENGTH, SWORDS_DANCE
	db PERFECT_DVS
	db HIDDEN_ABILITY | ADAMANT, FEMALE | ALOLAN_FORM ; Rock Head, +Atk -SpAtk

	db MAROWAK, THICK_CLUB ;(A)
	db FLARE_BLITZ, SHADOW_CLAW, BONEMERANG, STONE_EDGE
	db PERFECT_DVS
	db ABILITY_2 | ADAMANT, MALE | ALOLAN_FORM ; Lightning Rod, +Atk -SpAtk

	; KANGASKHAN type: Normal
	; 105,  95,  80,  90,  40,  80
	;  hp  atk  def  spd  sat  sdf
	db KANGASKHAN, LUM_BERRY ;(E)
	db BODY_SLAM, SEISMIC_TOSS, ICE_PUNCH, CRUNCH
	db PERFECT_DVS
	db HIDDEN_ABILITY | JOLLY, FEMALE ; Parental Bond, +Speed -SpAtk

	db KANGASKHAN, LEFTOVERS ;(A)
	db DOUBLE_EDGE, EARTHQUAKE, CRUNCH, REST
	db PERFECT_DVS
	db ABILITY_1 | ADAMANT, FEMALE ; Early Bird, +Atk -SpAtk

	; RHYDON type: Ground, Rock
	; 110, 135, 125,  40,  48,  48
	;  hp  atk  def  spd  sat  sdf
	db RHYDON, EVIOLITE ;(A)
	db ROCK_SLIDE, EARTHQUAKE, AVALANCHE, SWORDS_DANCE
	db PERFECT_DVS
	db ABILITY_2 | ADAMANT, MALE ; Solid Rock, +Atk -SpAtk

	; RHYPERIOR type Steel, Rock
	; 120, 145, 135,  40,  58,  58
	;  hp  atk  def  spd  sat  sdf
	db RHYPERIOR, ASSAULT_VEST ;(G)
	db IRON_HEAD, STONE_EDGE, EARTHQUAKE, AVALANCHE
	db PERFECT_DVS
	db ABILITY_2 | ADAMANT, MALE ; Solid Rock, +Atk -SpAtk

	; MURKROW type: Dark, Flying
	; 60,  85,  42,  91,  85,  42
	; hp  atk  def  spd  sat  sdf
	db MURKROW, EVIOLITE ;(C)
	db ROOST, SUBSTITUTE, MEAN_LOOK, PERISH_SONG
	db PERFECT_DVS
	db HIDDEN_ABILITY | IMPISH, FEMALE ; Prankster, +Def -SpAtk

	; HONCHKROW type: Dark, Flying
	; 105, 125,  52,  71, 105,  52
	;  hp  atk  def  spd  sat  sdf
	db HONCHKROW, LIFE_ORB ;(G)
	db SUCKER_PUNCH, BRAVE_BIRD, ROOST, THUNDER_WAVE ; PURSUIT if better AI
	db PERFECT_DVS
	db HIDDEN_ABILITY | JOLLY, MALE ; Moxie, +Speed -SpAtk

	; HOUNDOOM, type: Dark, Fire
	; 75,  90,  50,  95, 110,  80
	; hp  atk  def  spd  sat  sdf
	db HOUNDOOM, LIFE_ORB ;(A)
	db DARK_PULSE, FLAMETHROWER, SLUDGE_BOMB, NASTY_PLOT
	db PERFECT_DVS
	db ABILITY_2 | TIMID, MALE ; Flash Fire, +Speed -Atk

	; MAGCARGO type: Fire, Rock
	; 60,  50, 135,  30, 115, 115
	; hp  atk  def  spd  sat  sdf
	db MAGCARGO, LEFTOVERS ;(C)
	db FLAMETHROWER, HIDDEN_POWER, EARTH_POWER, RECOVER ; HP Rock
	db BTDVS_HP_ROCK
	db ABILITY_2 | CALM, FEMALE ; Flame Body, +SpDef -Atk

	; WEAVILE type: Dark, Ice
	; 70, 120,  65, 125,  45,  85
	; hp  atk  def  spd  sat  sdf
	db WEAVILE, CHOICE_BAND ;(E)
	db ICE_SHARD, ICICLE_CRASH, KNOCK_OFF, STRENGTH
	db PERFECT_DVS
	db ABILITY_2 | JOLLY, MALE ; Technician, +Speed -SpAtk

	db WEAVILE, LIFE_ORB ;(E)
	db ICE_SHARD, KNOCK_OFF, STRENGTH, SWORDS_DANCE ; Wild move LOW_KICK when it's not bugged
	db PERFECT_DVS
	db ABILITY_2 | JOLLY, FEMALE ; Technician, +Speed -SpAtk

	; MISDREAVUS type: Ghost
	; 60,  60,  60,  85,  85,  85
	; hp  atk  def  spd  sat  sdf
	db MISDREAVUS, EVIOLITE ;(A)
	db PAIN_SPLIT, PROTECT, MEAN_LOOK, PERISH_SONG
	db PERFECT_DVS
	db ABILITY_1 | CALM, FEMALE ; Levitate, +SpDef -Atk

	db MISDREAVUS, EVIOLITE ;(A)
	db HEX, PAIN_SPLIT, WILL_O_WISP, THUNDER_WAVE
	db PERFECT_DVS
	db ABILITY_1 | BOLD, MALE ; Levitate, +Def -Atk

	; MISMAGIUS type: Ghost, Fairy
	; 60,  60,  60, 110, 110, 110
	; hp  atk  def  spd  sat  sdf
	db MISMAGIUS, LIFE_ORB ;(E)
	db SHADOW_BALL, DAZZLINGLEAM, FLAMETHROWER, NASTY_PLOT
	db PERFECT_DVS
	db ABILITY_1 | TIMID, MALE ; Levitate, +Speed -Atk

	db MISMAGIUS, LEFTOVERS ;(G)
	db HEX, DAZZLINGLEAM, DESTINY_BOND, WILL_O_WISP
	db PERFECT_DVS
	db ABILITY_1 | TIMID, FEMALE ; Levitate, +Speed -Atk

	; PORYGON2 type: Normal
	; 85,  80,  90,  60, 105,  95
	; hp  atk  def  spd  sat  sdf
	db PORYGON2, EVIOLITE ;(G)
	db TRI_ATTACK, ICE_BEAM, RECOVER, THUNDER_WAVE
	db PERFECT_DVS
	db ABILITY_1 | CALM, $0 ; Trace, +SpDef -Atk

	db PORYGON2, EVIOLITE ;(G)
	db RETURN, SHADOW_BALL, RECOVER, TRICK_ROOM
	db BTDVS_TRICK_ROOM
	db ABILITY_2 | SASSY, $0 ; Download, +SpDef -Speed

	; PORYGON_Z type: Normal
	; 85,  80,  70,  90, 135,  75
	; hp  atk  def  spd  sat  sdf
	db PORYGON_Z, LIFE_ORB ;(G)
	db TRI_ATTACK, DARK_PULSE, HIDDEN_POWER, AGILITY ; HP Fighting
	db BTDVS_HP_FIGHTING
	db ABILITY_1 | MODEST, $0 ; Adaptability, +SpAtk -Atk

	db PORYGON_Z, CHOICE_SCARF ;(G)
	db TRI_ATTACK, SHADOW_BALL, THUNDERBOLT, ICE_BEAM
	db PERFECT_DVS
	db ABILITY_1 | MODEST, $0 ; Adaptability, +SpAtk -Atk

	; CHANSEY type: Normal
	; 250,  05,  05,  50,  35, 105
	;  hp  atk  def  spd  sat  sdf
	db CHANSEY, EVIOLITE ;(E)
	db SEISMIC_TOSS, MINIMIZE, FRESH_SNACK, TOXIC
	db PERFECT_DVS
	db ABILITY_1 | BOLD, FEMALE ; Natural Cure, +Def -Atk

	db CHANSEY, EVIOLITE ;(A)
	db TRI_ATTACK, SHADOW_BALL, FRESH_SNACK, MINIMIZE ; Wild move
	db PERFECT_DVS
	db ABILITY_2 | TIMID, FEMALE ; Serene Grace, +Speed -Atk

	; BLISSEY type: Normal
	; 255,  10,  10,  55,  75, 135
	;  hp  atk  def  spd  sat  sdf
	db BLISSEY, LEFTOVERS ;(E)
	db SEISMIC_TOSS, MINIMIZE, FRESH_SNACK, TOXIC
	db PERFECT_DVS
	db ABILITY_1 | BOLD, FEMALE ; Natural Cure, +Def -Atk

	db BLISSEY, ROCKY_HELMET ;(G)
	db SEISMIC_TOSS, SHADOW_BALL, FRESH_SNACK, SING
	db PERFECT_DVS
	db ABILITY_1 | BOLD, FEMALE ; Natural Cure, +Def -Atk

	db BLISSEY, RAZOR_FANG ;(A)
	db TRI_ATTACK, THUNDERBOLT, ICE_BEAM, CALM_MIND ; Wild move
	db PERFECT_DVS
	db ABILITY_2 | MODEST, FEMALE ; Serene Grace, +SpAtk -Atk

	; LAPRAS type: Water, Ice
	; 130,  85,  80,  60,  85,  95
	;  hp  atk  def  spd  sat  sdf
	db LAPRAS, LEFTOVERS ;(G)
	db SURF, ICE_BEAM, THUNDERBOLT, SHELL_SMASH ; Wild move
	db PERFECT_DVS
	db ABILITY_1 | MODEST, FEMALE ; Water Absorb, +SpAtk -Atk

	db LAPRAS, LIFE_ORB ;(G)
	db WATERFALL, ICE_SHARD, STRENGTH, SHELL_SMASH ; Wild move
	db PERFECT_DVS
	db ABILITY_1 | ADAMANT, MALE ; Water Absorb, +Atk -SpAtk

	db LAPRAS, LEFTOVERS ;(G)
	db ICE_BEAM, THUNDERBOLT, REST, SLEEP_TALK
	db PERFECT_DVS
	db ABILITY_1 | CALM, MALE ; Water Absorb, +SpDef -Atk

	db LAPRAS, LEFTOVERS ;(A)
	db SING, PROTECT, WHIRLPOOL, PERISH_SONG
	db PERFECT_DVS
	db HIDDEN_ABILITY | BOLD, FEMALE ; Hydration, +Def -Atk

	; OMASTAR type: Rock, Water
	; 70,  60, 125,  55, 115,  70
	; hp  atk  def  spd  sat  sdf
	db OMASTAR, WHITE_HERB ;(G)
	db POWER_GEM, HYDRO_PUMP, ICE_BEAM, SHELL_SMASH
	db PERFECT_DVS
	db HIDDEN_ABILITY | MODEST, FEMALE ; Weak Armor, +SpAtk -Atk

	; KABUTOPS type: Rock, Water
	; 60, 115, 105,  80,  65,  70
	; hp  atk  def  spd  sat  sdf
	db KABUTOPS, LEFTOVERS ;(A)
	db STONE_EDGE, WATERFALL, KNOCK_OFF, RAIN_DANCE
	db PERFECT_DVS
	db ABILITY_1 | ADAMANT, MALE ; Swift Swim, +Atk -SpAtk

	db KABUTOPS, WHITE_HERB ;(G)
	db STONE_EDGE, WATERFALL, LEECH_LIFE, SHELL_SMASH
	db PERFECT_DVS
	db HIDDEN_ABILITY | ADAMANT, MALE ; Weak Armor, +Atk -SpAtk

	; AERODACTYL type: Rock, Flying
	; 80, 105,  65, 130,  60,  75
	; hp  atk  def  spd  sat  sdf
	db AERODACTYL, CHOICE_BAND ;(G)
	db STONE_EDGE, BRAVE_BIRD, EARTHQUAKE, AQUA_TAIL
	db PERFECT_DVS
	db HIDDEN_ABILITY | JOLLY, MALE ; Tough Claws, +Speed -SpAtk

	; SNORLAX type: Normal
	; 160, 110,  65,  30,  65, 110
	;  hp  atk  def  spd  sat  sdf
	db SNORLAX, CHOICE_BAND ;(E)
	db DOUBLE_EDGE, PURSUIT, WILD_CHARGE, IRON_HEAD
	db PERFECT_DVS
	db ABILITY_1 | ADAMANT, MALE ; Immunity, +Atk -SpAtk

	db SNORLAX, LEFTOVERS ;(E)
	db RETURN, CRUNCH, EARTHQUAKE, CURSE
	db PERFECT_DVS
	db ABILITY_2 | ADAMANT, MALE ; Thick Fat, +Atk -SpAtk

	db SNORLAX, LEFTOVERS ;(G)
	db BODY_SLAM, CRUNCH, REST, CURSE ; SLEEP_TALK, WHIRLWIND not in P.C
	db PERFECT_DVS
	db ABILITY_2 | CAREFUL, MALE ; Thick Fat, +SpDef -SpAtk

	db SNORLAX, FIGY_BERRY ;(E)
	db BODY_SLAM, EARTHQUAKE, FIRE_PUNCH, CURSE
	db PERFECT_DVS
	db HIDDEN_ABILITY | CAREFUL, FEMALE ; Gluttony, +SpDef -SpAtk

	db SNORLAX, CUSTAP_BERRY ;(G)
	db RETURN, CRUNCH, FIRE_PUNCH, BELLY_DRUM
	db PERFECT_DVS
	db HIDDEN_ABILITY | CAREFUL, FEMALE ; Gluttony, +SpDef -SpAtk

	; VENUSAUR type: Grass, Poison
	; 80,  82,  83,  80, 100, 100
	; hp  atk  def  spd  sat  sdf
	db VENUSAUR, LIFE_ORB ;(G)
	db SOLAR_BEAM, SLUDGE_BOMB, HIDDEN_POWER, SUNNY_DAY ; HP Fire
	db BTDVS_HP_FIRE
	db ABILITY_2 | MODEST, FEMALE ; Chlorophyll, +SpAtk -Atk

	db VENUSAUR, BIG_ROOT ;(A)
	db GIGA_DRAIN, PROTECT, LEECH_SEED, TOXIC
	db PERFECT_DVS
	db HIDDEN_ABILITY | CALM, FEMALE ; Thick Fat, +SpDef -Atk

	db VENUSAUR, BLACK_SLUDGE ;(G)
	db POWER_WHIP, EARTHQUAKE, SWORDS_DANCE, SLEEP_POWDER
	db PERFECT_DVS
	db HIDDEN_ABILITY | JOLLY, MALE ; Thick Fat, +Speed -SpAtk

	db VENUSAUR, WIDE_LENS ;(A)
	db POWER_WHIP, KNOCK_OFF, HEALINGLIGHT, SLEEP_POWDER
	db PERFECT_DVS
	db HIDDEN_ABILITY | JOLLY, MALE ; Thick Fat, +Speed -SpAtk

	; CHARIZARD type: Fire, Dragon
	; 78,  94,  78, 100,  99,  85
	; hp  atk  def  spd  sat  sdf
	db CHARIZARD, LIFE_ORB ;(E)
	db FLARE_BLITZ, DRAGON_CLAW, ROOST, DRAGON_DANCE
	db PERFECT_DVS
	db HIDDEN_ABILITY | JOLLY, MALE ; Tough Claws, +Speed -SpAtk

	db CHARIZARD, CHOICE_SPECS ;(G)
	db FIRE_BLAST, DRAGON_PULSE, HIDDEN_POWER, FOCUS_BLAST ; HP Grass
	db BTDVS_HP_GRASS
	db ABILITY_1 | TIMID, FEMALE ; Blaze, +Speed -Atk

	; BLASTOISE type: Water, Steel
	; 79,  83, 100,  78,  85, 105
	; hp  atk  def  spd  sat  sdf
	db BLASTOISE, WHITE_HERB ;(E)
	db WATERFALL, IRON_HEAD, CLOSE_COMBAT, SHELL_SMASH
	db PERFECT_DVS
	db ABILITY_1 | CAREFUL, MALE ; Torrent, +SpDef -SpAtk

	db BLASTOISE, CHOICE_SPECS ;(G)
	db WATER_PULSE, FLASH_CANNON, DARK_PULSE, AURA_SPHERE
	db PERFECT_DVS
	db HIDDEN_ABILITY | TIMID, FEMALE ; Mega Launcher, +Speed -SpAtk

	db BLASTOISE, LEFTOVERS ;(A)
	db SCALD, ICE_BEAM, REST, SLEEP_TALK
	db PERFECT_DVS
	db ABILITY_1 | BOLD, MALE ; Torrent, +Def -Atk

	; ARTICUNO type: Ice, Flying
	; 90,  85, 100,  85,  95, 125
	; hp  atk  def  spd  sat  sdf
	db ARTICUNO, ICY_ROCK ;(E)
	db BLIZZARD, AEROBLAST, ROOST, ROAR
	db PERFECT_DVS
	db ABILITY_2 | MODEST, $0 ; Snow Warning, +SpAtk -Atk

	db ARTICUNO, LIFE_ORB ;(G)
	db ICE_SHARD, BRAVE_BIRD, ROOST, U_TURN
	db PERFECT_DVS
	db ABILITY_2 | ADAMANT, $0 ; Snow Warning, +Atk -SpAtk

	db ARTICUNO, LEFTOVERS ;(E)
	db ICE_BEAM, AEROBLAST, ROOST, TOXIC
	db PERFECT_DVS
	db ABILITY_1 | CALM, $0 ; Pressure, +SpDef -Atk

	; ZAPDOS type: Electric, Flying
	; 90,  90,  85, 100, 125,  90
	; hp  atk  def  spd  sat  sdf
	db ZAPDOS, DAMP_ROCK ;(E)
	db THUNDER, HURRICANE, ROOST, TOXIC
	db PERFECT_DVS
	db ABILITY_2 | MODEST, $0 ; Drizzle, +SpAtk -Atk

	db ZAPDOS, LEFTOVERS ;(E)
	db THUNDERBOLT, HIDDEN_POWER, REST, SLEEP_TALK ; HP Ice
	db BTDVS_HP_ICE
	db ABILITY_1 | BOLD, $0 ; Pressure, +Def -Atk

	db ZAPDOS, LIFE_ORB ;(G)
	db THUNDERBOLT, HIDDEN_POWER, BRAVE_BIRD, ROOST ; HP Grass
	db BTDVS_HP_GRASS
	db HIDDEN_ABILITY | MILD, $0 ; Static, +SpAtk -Def

	; MOLTRES type: Fire, Flying
	; 90, 100,  90,  90, 125,  85
	; hp  atk  def  spd  sat  sdf
	db MOLTRES, HEAT_ROCK ;(E)
	db FLAMETHROWER, SOLAR_BEAM, ROOST, WILL_O_WISP
	db PERFECT_DVS
	db ABILITY_2 | MODEST, $0 ; Drought, +SpAtk -Atk

	db MOLTRES, LEFTOVERS ;(G)
	db FLAMETHROWER, SUBSTITUTE, ROOST, ROAR
	db PERFECT_DVS
	db HIDDEN_ABILITY | TIMID, $0 ; Flame Body, +Speed -Atk

	; RAIKOU type: Electric
	; 90,  85,  75, 115, 115, 100
	; hp  atk  def  spd  sat  sdf
	db RAIKOU, CHOICE_SPECS ;(E)
	db VOLT_SWITCH, HIDDEN_POWER, AURA_SPHERE, SHADOW_BALL ; HP Ice
	db BTDVS_HP_ICE
	db HIDDEN_ABILITY | TIMID, $0 ; Volt Absorb, +Speed -Atk

	db RAIKOU, LEFTOVERS ;(E)
	db THUNDERBOLT, HIDDEN_POWER, AURA_SPHERE, CALM_MIND ; HP Ice
	db BTDVS_HP_ICE
	db HIDDEN_ABILITY | TIMID, $0 ; Volt Absorb, +Speed -Atk

	db RAIKOU, LIGHT_CLAY ;(G)
	db VOLT_SWITCH, HIDDEN_POWER, REFLECT, LIGHT_SCREEN ; HP Ice
	db BTDVS_HP_ICE
	db HIDDEN_ABILITY | TIMID, MALE ; Volt Absorb, +Speed -Atk

	; ENTEI type: Fire
	; 115, 115,  85, 100,  90,  75
	;  hp  atk  def  spd  sat  sdf
	db ENTEI, CHOICE_BAND ;(E)
	db SACRED_FIRE, STONE_EDGE, EXTREMESPEED, IRON_HEAD
	db PERFECT_DVS
	db HIDDEN_ABILITY | ADAMANT, $0 ; Flash Fire, +Atk -SpAtk

	db ENTEI, LIFE_ORB ;(E)
	db SACRED_FIRE, EARTHQUAKE, STRENGTH, ROAR
	db PERFECT_DVS
	db HIDDEN_ABILITY | ADAMANT, $0 ; Flash Fire, +Atk -SpAtk

	db ENTEI, LEFTOVERS ;(G)
	db SACRED_FIRE, PROTECT, SUBSTITUTE, TOXIC
	db PERFECT_DVS
	db ABILITY_1 | JOLLY, $0 ; Pressure, +Speed -SpAtk

	; SUICUNE type: Water
	; 100,  75, 115,  85,  90, 115
	;  hp  atk  def  spd  sat  sdf
	db SUICUNE, LEFTOVERS ;(E)
	db SCALD, SLEEP_TALK, REST, CALM_MIND
	db PERFECT_DVS
	db HIDDEN_ABILITY | BOLD, $0 ; Water Absorb, +Def -Atk

	db SUICUNE, ASSAULT_VEST ;(E)
	db SCALD, ICE_BEAM, HIDDEN_POWER, MIRROR_COAT ; HP Electric
	db BTDVS_HP_ELECTRIC 
	db HIDDEN_ABILITY | MODEST, $0 ; Water Absorb, +SpAtk -Atk

	; DRAGONITE type: Dragon, Flying
	; 91, 134,  95,  80, 100, 100
	; hp  atk  def  spd  sat  sdf
	db DRAGONITE, CHOICE_BAND ;(E)
	db OUTRAGE, FIRE_PUNCH, EARTHQUAKE, EXTREMESPEED
	db PERFECT_DVS
	db SHINY_MASK | HIDDEN_ABILITY | ADAMANT, MALE ; Multiscale, +Atk -SpAtk

	db DRAGONITE, LUM_BERRY ;(E)
	db OUTRAGE, FLY, ROOST, DRAGON_DANCE
	db PERFECT_DVS
	db HIDDEN_ABILITY | ADAMANT, FEMALE ; Multiscale, +Atk -SpAtk

	db DRAGONITE, LEFTOVERS ;(G)
	db HURRICANE, THUNDER, SURF, RAIN_DANCE
	db PERFECT_DVS
	db HIDDEN_ABILITY | MODEST, MALE ; Multiscale, +SpAtk -Atk

	db DRAGONITE, WEAK_POLICY ;(E)
	db DRAGON_CLAW, IRON_HEAD, FIRE_PUNCH, DRAGON_DANCE
	db PERFECT_DVS
	db HIDDEN_ABILITY | JOLLY, FEMALE ; Multiscale, +Speed -SpAtk

	; TYRANITAR type: Rock, Dark
	; 100, 134, 110,  61,  95, 100
	;  hp  atk  def  spd  sat  sdf
	db TYRANITAR, CHOICE_BAND ;(E)
	db STONE_EDGE, PURSUIT, ICE_PUNCH, CLOSE_COMBAT
	db PERFECT_DVS
	db ABILITY_1 | ADAMANT, MALE ; Sand Stream, +Atk -SpAtk

	db TYRANITAR, LUM_BERRY ;(E)
	db STONE_EDGE, CRUNCH, EARTHQUAKE, DRAGON_DANCE
	db PERFECT_DVS
	db ABILITY_1 | JOLLY, MALE ; Sand Stream, +Speed -SpAtk

	db TYRANITAR, ASSAULT_VEST ;(E)
	db ROCK_SLIDE, CRUNCH, IRON_HEAD, FIRE_PUNCH
	db PERFECT_DVS
	db ABILITY_1 | CAREFUL, FEMALE ; Sand Stream, +SpDef -SpAtk

	db TYRANITAR, CHOICE_SCARF ;(G)
	db ROCK_SLIDE, CRUNCH, IRON_HEAD, FIRE_PUNCH ; MISMAGIUS revenge killer
	db PERFECT_DVS
	db ABILITY_1 | JOLLY, MALE ; Sand Stream, +Speed -SpAtk

	db TYRANITAR, WEAK_POLICY ;(G)
	db STONE_EDGE, DARK_PULSE, FIRE_BLAST, THUNDERBOLT
	db PERFECT_DVS
	db ABILITY_1 | TIMID, FEMALE ; Sand Stream, +Speed -Atk

	db TYRANITAR, LEFTOVERS ;(G)
	db ROCK_SLIDE, CRUNCH, ROAR, THUNDER_WAVE
	db PERFECT_DVS
	db ABILITY_1 | CAREFUL, FEMALE ; Sand Stream, +SpDef -SpAtk

	db -1
