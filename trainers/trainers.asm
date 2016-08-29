Trainers:

; All trainers follow a basic structure:
	; Name
		; String in format "TEXT@"
	; Type
		; 0: Level, species
		; 1: Level, species, moves
		; 2: Level, species, item
		; 3: Level, species, item, moves
	; Party
		; Up to six monsters following the data type
	; $ff


KayGroup:
; ================================
; ================

	; KAY
	db "Kay@"
	db 3 ; item + moves

	; party

	db 60, MEGANIUM, GOLD_BERRY
		db GIGA_DRAIN
		db PROTECT
		db LEECH_SEED
		db TOXIC

	db 60, TYPHLOSION, QUICK_CLAW
		db SUNNY_DAY
		db THUNDERPUNCH
		db FLAMETHROWER
		db SUBSTITUTE

	db 60, FERALIGATR, MIRACLEBERRY
		db SURF
		db CRUNCH
		db ICE_PUNCH
		db ROCK_SLIDE

	db 60, STEELIX, MINT_BERRY
		db IRON_TAIL
		db ROCK_SLIDE
		db EARTHQUAKE
		db REST

	db 60, UMBREON, LEFTOVERS
		db CONFUSE_RAY
		db CURSE
		db FEINT_ATTACK
		db PROTECT

	db 60, CLEFABLE, PINK_BOW
		db SING
		db MOONLIGHT
		db METRONOME
		db MOONBLAST

	db $ff ; end

; ================
; ================================


CalGroup:
; ================================
; ================

	; CAL
	db "Cal@"
	db 3 ; item + moves

	; party

	db 60, TYPHLOSION, QUICK_CLAW
		db SUNNY_DAY
		db THUNDERPUNCH
		db FLAMETHROWER
		db SUBSTITUTE

	db 60, MEGANIUM, GOLD_BERRY
		db GIGA_DRAIN
		db PROTECT
		db LEECH_SEED
		db TOXIC

	db 60, FERALIGATR, MIRACLEBERRY
		db SURF
		db CRUNCH
		db ICE_PUNCH
		db ROCK_SLIDE

	db 60, STEELIX, MINT_BERRY
		db IRON_TAIL
		db ROCK_SLIDE
		db EARTHQUAKE
		db REST

	db 60, UMBREON, LEFTOVERS
		db CONFUSE_RAY
		db CURSE
		db FEINT_ATTACK
		db PROTECT

	db 60, CLEFABLE, PINK_BOW
		db SING
		db MOONLIGHT
		db METRONOME
		db MOONBLAST

	db $ff ; end

; ================

	; CAL
	db "Cal@"
	db 0 ; normal

	; party
	db 60, BLISSEY

	db $ff ; end

; ================
; ================================


FalknerGroup:
; ================================
; ================

	; FALKNER
	db "Falkner@"
	db 3 ; item + moves

	; party

	db 10, PIDGEY, NO_ITEM
		db TACKLE
		db SAND_ATTACK
		db GUST
		db MUD_SLAP

	db 10, HOOTHOOT, NO_ITEM
		db TACKLE
		db GROWL
		db HYPNOSIS
		db MUD_SLAP

	db 13, PIDGEOTTO, MINT_BERRY
		db QUICK_ATTACK
		db SAND_ATTACK
		db GUST
		db MUD_SLAP

	db $ff ; end

; ================

	; FALKNER
	db "Falkner@"
	db 3 ; item + moves

	; party

	db 73, NOCTOWL, TWISTEDSPOON
		db AIR_SLASH
		db PSYCHIC_M
		db HYPNOSIS
		db DREAM_EATER

	db 70, GLISCOR, SCOPE_LENS
		db SWORDS_DANCE
		db EARTHQUAKE
		db X_SCISSOR
		db NIGHT_SLASH

	db 72, DODRIO, SILK_SCARF
		db DRILL_PECK
		db TRIPLE_KICK
		db PURSUIT
		db QUICK_ATTACK

	db 70, TOGEKISS, LEFTOVERS
		db ANCIENTPOWER
		db AIR_SLASH
		db NASTY_PLOT
		db SOFTBOILED

	db 72, HONCHKROW, BLACKGLASSES
		db DRILL_PECK
		db NIGHT_SLASH
		db PURSUIT
		db CONFUSE_RAY

	db 75, PIDGEOT, SHARP_BEAK
		db DRILL_PECK
		db TWISTER
		db STEEL_WING
		db WHIRLWIND

	db $ff ; end

; ================
; ================================


BugsyGroup:
; ================================
; ================

	; BUGSY
	db "Bugsy@"
	db 3 ; item + moves

	; party

	db 14, BUTTERFREE, NO_ITEM
		db TACKLE
		db POISONPOWDER
		db SLEEP_POWDER
		db CONFUSION

	db 14, BEEDRILL, NO_ITEM
		db POISON_STING
		db STRING_SHOT
		db HARDEN
		db FURY_ATTACK

	db 12, YANMA, NO_ITEM
		db TACKLE
		db FORESIGHT
		db QUICK_ATTACK
		db DOUBLE_TEAM

	db 17, SCYTHER, BERRY
		db QUICK_ATTACK
		db LEER
		db PURSUIT
		db FURY_CUTTER

	db $ff ; end

; ================

	; BUGSY
	db "Bugsy@"
	db 3 ; item + moves

	; party

	db 73, HERACROSS, BLACK_BELT
		db MEGAHORN
		db CROSS_CHOP
		db ROCK_SMASH
		db STONE_EDGE

	db 71, LEDIAN, KINGS_ROCK
		db REFLECT
		db LIGHT_SCREEN
		db BUG_BUZZ
		db ICE_PUNCH

	db 70, YANMEGA, QUICK_CLAW
		db BUG_BUZZ
		db AIR_SLASH
		db ANCIENTPOWER
		db PROTECT

	db 72, PARASECT, LEFTOVERS
		db SPORE
		db MORNING_SUN
		db SEED_BOMB
		db X_SCISSOR

	db 75, PINSIR, SCOPE_LENS
		db MEGAHORN
		db SWORDS_DANCE
		db SUBMISSION
		db EARTHQUAKE

	db 75, SCYTHER, EVIOLITE
		db SWORDS_DANCE
		db NIGHT_SLASH
		db X_SCISSOR
		db WING_ATTACK

	db $ff ; end

; ================
; ================================


WhitneyGroup:
; ================================
; ================

	; WHITNEY
	db "Whitney@"
	db 3 ; item + moves

	; party

	db 18, CLEFAIRY, NO_ITEM
		db METRONOME
		db DISARM_VOICE
		db DOUBLE_SLAP
		db ATTRACT

	db 19, TEDDIURSA, NO_ITEM
		db SCRATCH
		db ATTRACT
		db LICK
		db FEINT_ATTACK

	db 18, MUNCHLAX, NO_ITEM
		db ATTRACT
		db METRONOME
		db DEFENSE_CURL
		db ROLLOUT

	db 17, JIGGLYPUFF, NO_ITEM
		db SING
		db DIZZY_PUNCH
		db ATTRACT
		db ROLLOUT

	db 20, MILTANK, MIRACLEBERRY
		db DEFENSE_CURL
		db STOMP
		db MILK_DRINK
		db ROLLOUT

	db $ff ; end

; ================

	; WHITNEY
	db "Whitney@"
	db 3 ; item + moves

	; party

	db 72, CLEFABLE, PINK_BOW
		db CALM_MIND
		db MOONBLAST
		db SOFTBOILED
		db THUNDER_WAVE

	db 70, URSARING, BLACK_BELT
		db SWORDS_DANCE
		db CROSS_CHOP
		db CRUNCH
		db PLAY_ROUGH

	db 71, GIRAFARIG, TWISTEDSPOON
		db NASTY_PLOT
		db PSYCHIC_M
		db HYPER_VOICE
		db SHADOW_BALL

	db 72, WIGGLYTUFF, LEFTOVERS
		db FOCUS_BLAST
		db HYPER_VOICE
		db DAZZLINGLEAM
		db ICE_BEAM

	db 74, TAUROS, SILK_SCARF
		db BULK_UP
		db EARTHQUAKE
		db STRENGTH
		db IRON_TAIL

	db 75, MILTANK, BRIGHTPOWDER
		db DEFENSE_CURL
		db ROLLOUT
		db MILK_DRINK
		db BODY_SLAM

	db $ff ; end

; ================
; ================================


MortyGroup:
; ================================
; ================

	; MORTY
	db "Morty@"
	db 3 ; item + moves

	; party

	db 21, GASTLY, NO_ITEM
		db LICK
		db CURSE
		db NIGHT_SHADE
		db CONFUSE_RAY

	db 21, HAUNTER, NO_ITEM
		db HYPNOSIS
		db CURSE
		db NIGHT_SHADE
		db SHADOW_BALL

	db 23, NOCTOWL, NO_ITEM
		db HYPNOSIS
		db PECK
		db CONFUSION
		db SHADOW_BALL

	db 23, MISDREAVUS, NO_ITEM
		db ASTONISH
		db CONFUSE_RAY
		db NASTY_PLOT
		db SHADOW_BALL

	db 25, GENGAR, GOLD_BERRY
		db HYPNOSIS
		db MEAN_LOOK
		db SHADOW_CLAW
		db DREAM_EATER

	db 23, HAUNTER, NO_ITEM
		db HYPNOSIS
		db DISABLE
		db CONFUSE_RAY
		db SHADOW_BALL

	db $ff ; end

; ================

	; MORTY
	db "Morty@"
	db 3 ; item + moves

	; party

	db 72, GENGAR, LEFTOVERS
		db WILL_O_WISP
		db SHADOW_BALL
		db FOCUS_BLAST
		db SUBSTITUTE

	db 70, NINETALES, CHARCOAL
		db NASTY_PLOT
		db SHADOW_BALL
		db FLAMETHROWER
		db WILL_O_WISP

	db 71, MAROWAK, THICK_CLUB
		db BONEMERANG
		db STONE_EDGE
		db ICE_PUNCH
		db SHADOW_CLAW

	db 73, MISMAGIUS, PINK_BOW
		db DAZZLINGLEAM
		db SHADOW_BALL
		db NASTY_PLOT
		db THUNDERBOLT

	db 74, HAUNTER, EVIOLITE
		db SHADOW_BALL
		db SLUDGE_BOMB
		db DESTINY_BOND
		db PAIN_SPLIT

	db 75, GENGAR, SPELL_TAG
		db NASTY_PLOT
		db SHADOW_BALL
		db THUNDERBOLT
		db DESTINY_BOND

	db $ff ; end

; ================
; ================================


ChuckGroup:
; ================================
; ================

	; CHUCK
	db "Chuck@"
	db 3 ; item + moves

	; party

	db 28, MACHOKE, NO_ITEM
		db KARATE_CHOP
		db BULLET_PUNCH
		db MEDITATE
		db DYNAMICPUNCH

	db 29, PRIMEAPE, NO_ITEM
		db KARATE_CHOP
		db SEISMIC_TOSS
		db SCREECH
		db DYNAMICPUNCH

	db 27, HITMONCHAN, NO_ITEM
		db THUNDERPUNCH
		db ICE_PUNCH
		db FIRE_PUNCH
		db MACH_PUNCH

	db 27, HITMONLEE, NO_ITEM
		db LOCK_ON
		db BULK_UP
		db LOW_KICK
		db HI_JUMP_KICK

	db 27, HITMONTOP, NO_ITEM
		db BULK_UP
		db QUICK_ATTACK
		db TRIPLE_KICK
		db RAPID_SPIN

	db 30, POLIWRATH, GOLD_BERRY
		db LOCK_ON
		db HYPNOSIS
		db WATERFALL
		db DYNAMICPUNCH

	db $ff ; end

; ================

	; CHUCK
	db "Chuck@"
	db 3 ; item + moves

	; party

	db 73, MACHAMP, FOCUS_BAND
		db STONE_EDGE
		db CROSS_CHOP
		db ICE_PUNCH
		db BULLET_PUNCH

	db 71, PRIMEAPE, DRAGON_FANG
		db EARTHQUAKE
		db STONE_EDGE
		db OUTRAGE
		db CROSS_CHOP

	db 72, HITMONCHAN, NEVERMELTICE
		db THUNDERPUNCH
		db ICE_PUNCH
		db FIRE_PUNCH
		db MACH_PUNCH

	db 72, HITMONLEE, QUICK_CLAW
		db HI_JUMP_KICK
		db LOCK_ON
		db BULK_UP
		db REVERSAL

	db 72, HITMONTOP, KINGS_ROCK
		db RAPID_SPIN
		db TOXIC
		db SUBMISSION
		db TRIPLE_KICK

	db 75, POLIWRATH, LEFTOVERS
		db WATERFALL
		db BULK_UP
		db ICE_PUNCH
		db CROSS_CHOP

	db $ff ; end

; ================
; ================================


JasmineGroup:
; ================================
; ================

	; JASMINE
	db "Jasmine@"
	db 3 ; item + moves

	; party

	db 32, SKARMORY, NO_ITEM
		db SAND_ATTACK
		db DRILL_PECK
		db SPIKES
		db STEEL_WING

	db 29, MAGNEMITE, NO_ITEM
		db SUPERSONIC
		db SONIC_BOOM
		db THUNDER_WAVE
		db THUNDERBOLT

	db 31, FORRETRESS, NO_ITEM
		db SPIKES
		db FLASH_CANNON
		db DEFENSE_CURL
		db ROLLOUT

	db 30, MAGNETON, NO_ITEM
		db SUPERSONIC
		db THUNDER_WAVE
		db THUNDERBOLT
		db TRI_ATTACK

	db 32, SCIZOR, NO_ITEM
		db PURSUIT
		db WING_ATTACK
		db METAL_CLAW
		db SLASH

	db 35, STEELIX, GOLD_BERRY
		db BODY_SLAM
		db SCREECH
		db ROCK_SLIDE
		db IRON_TAIL

	db $ff ; end

; ================

	; JASMINE
	db "Jasmine@"
	db 3 ; item + moves

	; party

	db 74, SKARMORY, LEFTOVERS
		db SPIKES
		db WHIRLWIND
		db DRILL_PECK
		db STEEL_WING

	db 72, MAGNEZONE, MIRACLE_SEED
		db THUNDERBOLT
		db HIDDEN_POWER ; Grass
		db FLASH_CANNON
		db EXPLOSION

	db 70, FORRETRESS, SOFT_SAND
		db EARTHQUAKE
		db RAPID_SPIN
		db EXPLOSION
		db SPIKES

	db 73, MAGNEZONE, CHARCOAL
		db THUNDERBOLT
		db HIDDEN_POWER ; Fire
		db FLASH_CANNON
		db EXPLOSION

	db 73, SCIZOR, METAL_COAT
		db SWORDS_DANCE
		db BULLET_PUNCH
		db PURSUIT
		db IRON_HEAD

	db 75, STEELIX, LEFTOVERS
		db EARTHQUAKE
		db ROCK_SLIDE
		db CRUNCH
		db IRON_HEAD

	db $ff ; end

; ================
; ================================


PryceGroup:
; ================================
; ================

	; PRYCE
	db "Pryce@"
	db 3 ; item + moves

	; party

	db 37, DEWGONG, NO_ITEM
		db WATERFALL
		db REST
		db SLEEP_TALK
		db AURORA_BEAM

	db 36, PILOSWINE, NO_ITEM
		db MAGNITUDE
		db ICY_WIND
		db AVALANCHE
		db FURY_ATTACK

	db 36, SNEASEL, NO_ITEM
		db SWORDS_DANCE
		db ICE_PUNCH
		db SCREECH
		db SLASH

	db 37, CLOYSTER, NO_ITEM
		db DEFENSE_CURL
		db SUPERSONIC
		db AURORA_BEAM
		db RAZOR_SHELL

	db 38, LAPRAS, NO_ITEM
		db SING
		db CONFUSE_RAY
		db ANCIENTPOWER
		db ICE_BEAM

	db 40, MAMOSWINE, GOLD_BERRY
		db MAGNITUDE
		db ANCIENTPOWER
		db AVALANCHE
		db FURY_ATTACK

	db $ff ; end

; ================

	; PRYCE
	db "Pryce@"
	db 3 ; item + moves

	; party

	db 73, DEWGONG, FOCUS_BAND
		db PROTECT
		db TOXIC
		db SURF
		db ICE_BEAM

	db 73, CLOYSTER, KINGS_ROCK
		db SPIKES
		db RAZOR_SHELL
		db EXPLOSION
		db AVALANCHE

	db 72, WEAVILE, KINGS_ROCK
		db SWORDS_DANCE
		db ICE_PUNCH
		db SLASH
		db CRUNCH

	db 71, GLACEON, NEVERMELTICE
		db ICE_BEAM
		db HIDDEN_POWER ; Ground
		db BARRIER
		db BATON_PASS

	db 73, LAPRAS, LEFTOVERS
		db SING
		db TOXIC
		db ICE_BEAM
		db THUNDERBOLT

	db 75, MAMOSWINE, HARD_STONE
		db EARTHQUAKE
		db AVALANCHE
		db STONE_EDGE
		db ANCIENTPOWER

	db $ff ; end

; ================
; ================================


ClairGroup:
; ================================
; ================

	; CLAIR
	db "Clair@"
	db 3 ; item + moves

	; party

	db 41, GYARADOS, NO_ITEM
		db CRUNCH
		db TWISTER
		db DRAGONBREATH
		db AQUA_TAIL

	db 40, AMPHAROS, NO_ITEM
		db THUNDER_WAVE
		db CONFUSE_RAY
		db DRAGON_PULSE
		db LIGHT_SCREEN

	db 42, DRAGONAIR, NO_ITEM
		db THUNDER_WAVE
		db AQUA_TAIL
		db FLAMETHROWER
		db DRAGONBREATH

	db 42, DRAGONAIR, NO_ITEM
		db THUNDER_WAVE
		db AQUA_TAIL
		db THUNDERBOLT
		db DRAGONBREATH

	db 42, DRAGONAIR, NO_ITEM
		db THUNDER_WAVE
		db AQUA_TAIL
		db ICE_BEAM
		db DRAGONBREATH

	db 45, KINGDRA, GOLD_BERRY
		db SMOKESCREEN
		db HYPER_BEAM
		db DRAGON_PULSE
		db SURF

	db $ff ; end

; ================

	; CLAIR
	db "Clair@"
	db 3 ; item + moves

	; party

	db 74, DRAGONAIR, EVIOLITE
		db AQUA_TAIL
		db FLY
		db THUNDER_WAVE
		db SAFEGUARD

	db 72, GYARADOS, MIRACLEBERRY
		db DRAGON_DANCE
		db WATERFALL
		db FLY
		db EARTHQUAKE

	db 73, DRAGONITE, SILK_SCARF
		db OUTRAGE
		db EXTREMESPEED
		db FIRE_PUNCH
		db EARTHQUAKE

	db 73, DRAGONITE, LEFTOVERS
		db DRAGON_DANCE
		db DRAGON_CLAW
		db WATERFALL
		db HYPER_BEAM

	db 74, DRAGONAIR, DRAGON_FANG
		db DRAGON_DANCE
		db EXTREMESPEED
		db OUTRAGE
		db AQUA_TAIL

	db 75, KINGDRA, MINT_BERRY
		db DRAGON_DANCE
		db WATERFALL
		db OUTRAGE
		db REST

	db $ff ; end

; ================
; ================================


WillGroup:
; ================================
; ================

	; WILL
	db "Will@"
	db 3 ; item + moves

	; party

	db 47, XATU, NO_ITEM
		db QUICK_ATTACK
		db CONFUSE_RAY
		db RECOVER
		db PSYCHIC_M

	db 48, JYNX, NO_ITEM
		db NASTY_PLOT
		db DRAIN_KISS
		db ICE_BEAM
		db PSYCHIC_M

	db 49, EXEGGUTOR, NO_ITEM
		db REFLECT
		db LEECH_SEED
		db SEED_BOMB
		db PSYCHIC_M

	db 49, ALAKAZAM, NO_ITEM
		db CALM_MIND
		db RECOVER
		db LIGHT_SCREEN
		db PSYCHIC_M

	db 48, SLOWBRO, NO_ITEM
		db SURF
		db CALM_MIND
		db BODY_SLAM
		db PSYCHIC_M

	db 50, XATU, GOLD_BERRY
		db QUICK_ATTACK
		db CONFUSE_RAY
		db PSYCHIC_M
		db FUTURE_SIGHT

	db $ff ; end

; ================

	; WILL
	db "Will@"
	db 3 ; item + moves

	; party

	db 67, XATU, TWISTEDSPOON
		db AIR_SLASH
		db FUTURE_SIGHT
		db CONFUSE_RAY
		db PSYCHIC_M

	db 68, JYNX, BRIGHTPOWDER
		db NASTY_PLOT
		db DRAIN_KISS
		db ICE_BEAM
		db PSYCHIC_M

	db 68, EXEGGUTOR, MIRACLE_SEED
		db REFLECT
		db GIGA_DRAIN
		db SLEEP_POWDER
		db PSYCHIC_M

	db 69, ALAKAZAM, MIRACLEBERRY
		db HIDDEN_POWER ; Fighting
		db RECOVER
		db SHADOW_BALL
		db PSYCHIC_M

	db 69, SLOWBRO, LEFTOVERS
		db SURF
		db PSYCHIC_M
		db THUNDER_WAVE
		db REST

	db 70, XATU, GOLD_BERRY
		db QUICK_ATTACK
		db FUTURE_SIGHT
		db CONFUSE_RAY
		db PSYCHIC_M

	db $ff ; end

; ================
; ================================


KogaGroup:
; ================================
; ================

	; KOGA
	db "Koga@"
	db 3 ; item + moves

	; party

	db 49, ARIADOS, NO_ITEM
		db DOUBLE_TEAM
		db GLARE
		db BATON_PASS
		db GIGA_DRAIN

	db 49, VENOMOTH, NO_ITEM
		db SUPERSONIC
		db BUG_BUZZ
		db PSYCHIC_M
		db TOXIC

	db 51, FORRETRESS, NO_ITEM
		db PROTECT
		db EXPLOSION
		db SPIKES
		db IRON_HEAD

	db 50, MUK, NO_ITEM
		db MINIMIZE
		db SCREECH
		db SLUDGE_BOMB
		db TOXIC

	db 50, WEEZING, NO_ITEM
		db WILL_O_WISP
		db TOXIC
		db SLUDGE_BOMB
		db EXPLOSION

	db 52, CROBAT, GOLD_BERRY
		db DOUBLE_TEAM
		db POISON_JAB
		db SUPER_FANG
		db TOXIC

	db $ff ; end

; ================

	; KOGA
	db "Koga@"
	db 3 ; item + moves

	; party

	db 69, TENTACRUEL, LEFTOVERS
		db SUBSTITUTE
		db SWORDS_DANCE
		db SURF
		db SLUDGE_BOMB

	db 71, FORRETRESS, SILK_SCARF
		db PROTECT
		db TOXIC
		db EXPLOSION
		db SPIKES

	db 69, ARBOK, SOFT_SAND
		db SLUDGE_BOMB
		db GLARE
		db EARTHQUAKE
		db SCREECH

	db 70, MUK, BRIGHTPOWDER
		db MINIMIZE
		db FIRE_BLAST
		db GUNK_SHOT
		db TOXIC

	db 71, WEEZING, MAGNET
		db WILL_O_WISP
		db THUNDER
		db SLUDGE_BOMB
		db EXPLOSION

	db 72, CROBAT, GOLD_BERRY
		db SCREECH
		db TOXIC
		db CRUNCH
		db WING_ATTACK

	db $ff ; end

; ================
; ================================


BrunoGroup:
; ================================
; ================

	; BRUNO
	db "Bruno@"
	db 3 ; item + moves

	; party

	db 50, HITMONTOP, NO_ITEM
		db PURSUIT
		db TRIPLE_KICK
		db DIG
		db PROTECT

	db 52, PINSIR, NO_ITEM
		db SWORDS_DANCE
		db VITAL_THROW
		db EARTHQUAKE
		db X_SCISSOR

	db 50, HITMONLEE, NO_ITEM
		db SWAGGER
		db DOUBLE_KICK
		db HI_JUMP_KICK
		db FORESIGHT

	db 50, HITMONCHAN, NO_ITEM
		db THUNDERPUNCH
		db ICE_PUNCH
		db POISON_JAB
		db MACH_PUNCH

	db 52, ONIX, NO_ITEM
		db BODY_SLAM
		db EARTHQUAKE
		db CRUNCH
		db ROCK_SLIDE

	db 54, MACHAMP, GOLD_BERRY
		db ROCK_SLIDE
		db FORESIGHT
		db VITAL_THROW
		db CROSS_CHOP

	db $ff ; end

; ================

	; BRUNO
	db "Bruno@"
	db 3 ; item + moves

	; party

	db 70, HITMONTOP, QUICK_CLAW
		db BULK_UP
		db TRIPLE_KICK
		db COUNTER
		db HI_JUMP_KICK

	db 71, PINSIR, SILVERPOWDER
		db SWORDS_DANCE
		db VITAL_THROW
		db EARTHQUAKE
		db MEGAHORN

	db 70, HITMONLEE, FOCUS_BAND
		db MEDITATE
		db RETURN
		db HI_JUMP_KICK
		db REVERSAL

	db 70, HITMONCHAN, NEVERMELTICE
		db THUNDERPUNCH
		db ICE_PUNCH
		db POISON_JAB
		db MACH_PUNCH

	db 72, STEELIX, HARD_STONE
		db CURSE
		db EARTHQUAKE
		db STONE_EDGE
		db IRON_HEAD

	db 74, MACHAMP, LEFTOVERS
		db BULK_UP
		db STONE_EDGE
		db BODY_SLAM
		db CROSS_CHOP

	db $ff ; end

; ================
; ================================


KarenGroup:
; ================================
; ================

	; KAREN
	db "Karen@"
	db 3 ; item + moves

	; party

	db 52, UMBREON, NO_ITEM
		db SAND_ATTACK
		db CONFUSE_RAY
		db FEINT_ATTACK
		db MEAN_LOOK

	db 52, PERSIAN, NO_ITEM
		db NIGHT_SLASH
		db FEINT_ATTACK
		db SCREECH
		db PLAY_ROUGH

	db 53, WEAVILE, NO_ITEM
		db SWORDS_DANCE
		db SCREECH
		db NIGHT_SLASH
		db ICE_PUNCH

	db 54, GENGAR, NO_ITEM
		db SHADOW_BALL
		db WILL_O_WISP
		db CURSE
		db DESTINY_BOND

	db 53, HONCHKROW, NO_ITEM
		db DRILL_PECK
		db WHIRLWIND
		db PURSUIT
		db FEINT_ATTACK

	db 56, HOUNDOOM, GOLD_BERRY
		db ROAR
		db PURSUIT
		db FLAMETHROWER
		db DARK_PULSE

	db $ff ; end

; ================

	; KAREN
	db "Karen@"
	db 3 ; item + moves

	; party

	db 71, UMBREON, LEFTOVERS
		db CHARM
		db MOONLIGHT
		db PURSUIT
		db TOXIC

	db 72, WEAVILE, KINGS_ROCK
		db SWORDS_DANCE
		db SCREECH
		db SLASH
		db ICE_PUNCH

	db 74, GENGAR, MAGNET
		db HYPNOSIS
		db THUNDER
		db SHADOW_BALL
		db DESTINY_BOND

	db 72, HONCHKROW, BLACKGLASSES
		db DRILL_PECK
		db WHIRLWIND
		db PURSUIT
		db NIGHT_SLASH

	db 74, TYRANITAR, SOFT_SAND
		db EARTHQUAKE
		db CRUNCH
		db STONE_EDGE
		db PURSUIT

	db 76, HOUNDOOM, GOLD_BERRY
		db ROAR
		db NASTY_PLOT
		db FIRE_BLAST
		db DARK_PULSE

	db $ff ; end

; ================
; ================================


ChampionGroup:
; ================================
; ================

	; CHAMPION
	db "Lance@"
	db 3 ; item + moves

	; party

	db 56, GYARADOS, NO_ITEM
		db DRAGON_DANCE
		db FLY
		db WATERFALL
		db HYPER_BEAM

	db 57, DRAGONITE, NO_ITEM
		db THUNDER_WAVE
		db TWISTER
		db THUNDER
		db HYPER_BEAM

	db 57, DRAGONITE, NO_ITEM
		db SAFEGUARD
		db TWISTER
		db BLIZZARD
		db HYPER_BEAM

	db 56, AERODACTYL, NO_ITEM
		db WING_ATTACK
		db ANCIENTPOWER
		db ROCK_SLIDE
		db HYPER_BEAM

	db 56, CHARIZARD, NO_ITEM
		db DRAGON_DANCE
		db FLAME_WHEEL
		db WING_ATTACK
		db SLASH

	db 59, DRAGONITE, GOLD_BERRY
		db BARRIER
		db OUTRAGE
		db FIRE_BLAST
		db HYPER_BEAM

	db $ff ; end

; ================

	; CHAMPION
	db "Lance@"
	db 3 ; item + moves

	; party

	db 75, GYARADOS, QUICK_CLAW
		db DRAGON_DANCE
		db EARTHQUAKE
		db WATERFALL
		db HYPER_BEAM

	db 77, DRAGONITE, GOLD_BERRY
		db THUNDER_WAVE
		db BLIZZARD
		db THUNDER
		db LIGHT_SCREEN

	db 77, DRAGONITE, SILK_SCARF
		db THUNDER_WAVE
		db OUTRAGE
		db BODY_SLAM
		db HYPER_BEAM

	db 76, AERODACTYL, DRAGON_FANG
		db WING_ATTACK
		db ANCIENTPOWER
		db EARTHQUAKE
		db DRAGON_CLAW

	db 75, CHARIZARD, KINGS_ROCK
		db SWORDS_DANCE
		db FIRE_BLAST
		db ROCK_SLIDE
		db SLASH

	db 80, DRAGONITE, LEFTOVERS
		db DRAGON_DANCE
		db FIRE_BLAST
		db OUTRAGE
		db HYPER_BEAM

	db $ff ; end

; ================
; ================================


BrockGroup:
; ================================
; ================

	; BROCK
	db "Brock@"
	db 3 ; item + moves

	; party

	db 64, GOLEM, NO_ITEM
		db DEFENSE_CURL
		db ROLLOUT
		db ROCK_SLIDE
		db EARTHQUAKE

	db 63, RHYPERIOR, NO_ITEM
		db SCARY_FACE
		db ROCK_SLIDE
		db EARTHQUAKE
		db OUTRAGE

	db 65, OMASTAR, NO_ITEM
		db ANCIENTPOWER
		db SURF
		db PROTECT
		db SPIKES

	db 68, ONIX, NO_ITEM
		db IRON_TAIL
		db ROCK_SLIDE
		db EARTHQUAKE
		db SANDSTORM

	db 65, KABUTOPS, NO_ITEM
		db SLASH
		db SURF
		db ENDURE
		db GIGA_DRAIN

	db 65, AERODACTYL, NO_ITEM
		db WING_ATTACK
		db SUPERSONIC
		db ANCIENTPOWER
		db HYPER_BEAM

	db $ff ; end

; ================

	; BROCK
	db "Brock@"
	db 3 ; item + moves

	; party

	db 74, ONIX, SOFT_SAND
		db IRON_HEAD
		db ROCK_SLIDE
		db EARTHQUAKE
		db SANDSTORM

	db 73, RHYPERIOR, KINGS_ROCK
		db SCARY_FACE
		db ROCK_SLIDE
		db EARTHQUAKE
		db MEGAHORN

	db 72, OMASTAR, MYSTIC_WATER
		db ANCIENTPOWER
		db SURF
		db EARTH_POWER
		db SPIKES

	db 72, KABUTOPS, MIRACLE_SEED
		db SLASH
		db SURF
		db ENDURE
		db GIGA_DRAIN

	db 73, AERODACTYL, QUICK_CLAW
		db STONE_EDGE
		db EARTHQUAKE
		db WING_ATTACK
		db CRUNCH

	db 75, GOLEM, LEFTOVERS
		db EXPLOSION
		db BODY_SLAM
		db STONE_EDGE
		db EARTHQUAKE

	db $ff ; end

; ================
; ================================


MistyGroup:
; ================================
; ================

	; MISTY
	db "Misty@"
	db 3 ; item + moves

	; party

	db 61, GOLDUCK, NO_ITEM
		db SCALD
		db DISABLE
		db CALM_MIND
		db PSYCHIC_M

	db 60, QUAGSIRE, NO_ITEM
		db SCALD
		db CALM_MIND
		db EARTHQUAKE
		db RAIN_DANCE

	db 62, LAPRAS, NO_ITEM
		db SURF
		db PERISH_SONG
		db BLIZZARD
		db RAIN_DANCE

	db 60, KINGLER, NO_ITEM
		db HARDEN
		db STOMP
		db PROTECT
		db CRABHAMMER

	db 62, LANTURN, NO_ITEM
		db SCALD
		db THUNDERBOLT
		db ICE_BEAM
		db CONFUSE_RAY

	db 64, STARMIE, GOLD_BERRY
		db SCALD
		db CONFUSE_RAY
		db RECOVER
		db ICE_BEAM

	db $ff ; end

; ================

	; MISTY
	db "Misty@"
	db 3 ; item + moves

	; party

	db 73, GOLDUCK, TWISTEDSPOON
		db PSYCHIC_M
		db SURF
		db ICE_BEAM
		db CALM_MIND

	db 72, QUAGSIRE, NO_ITEM
		db EARTHQUAKE
		db SCALD
		db RECOVER
		db TOXIC

	db 72, KINGLER, KINGS_ROCK
		db SWORDS_DANCE
		db CRABHAMMER
		db X_SCISSOR
		db ROCK_SLIDE

	db 73, LANTURN, NEVERMELTICE
		db SURF
		db THUNDERBOLT
		db ICE_BEAM
		db CONFUSE_RAY

	db 74, OCTILLERY, CHARCOAL
		db FIRE_BLAST
		db ICE_BEAM
		db HYDRO_PUMP
		db SEED_BOMB

	db 75, STARMIE, LEFTOVERS
		db RECOVER
		db PSYCHIC_M
		db THUNDERBOLT
		db SURF

	db $ff ; end

; ================
; ================================


LtSurgeGroup:
; ================================
; ================

	; LT_SURGE
	db "Lt.Surge@"
	db 3 ; item + moves

	; party

	db 58, ELECTIVIRE, NO_ITEM
		db QUICK_ATTACK
		db THUNDERPUNCH
		db LIGHT_SCREEN
		db WILD_CHARGE

	db 56, ELECTRODE, NO_ITEM
		db SCREECH
		db DOUBLE_TEAM
		db THUNDERBOLT
		db EXPLOSION

	db 57, MAGNEZONE, NO_ITEM
		db LOCK_ON
		db DOUBLE_TEAM
		db WILD_CHARGE
		db ZAP_CANNON

	db 56, ELECTRODE, NO_ITEM
		db SCREECH
		db DOUBLE_TEAM
		db WILD_CHARGE
		db EXPLOSION

	db 58, JOLTEON, NO_ITEM
		db WILD_CHARGE
		db THUNDER_WAVE
		db AGILITY
		db THUNDER

	db 60, RAICHU, GOLD_BERRY
		db THUNDER_WAVE
		db QUICK_ATTACK
		db WILD_CHARGE
		db THUNDER

	db $ff ; end

; ================

	; LT_SURGE
	db "Lt.Surge@"
	db 3 ; item + moves

	; party

	db 74, ELECTIVIRE, BLACK_BELT
		db CROSS_CHOP
		db THUNDERPUNCH
		db LIGHT_SCREEN
		db WILD_CHARGE

	db 72, ELECTRODE, SILK_SCARF
		db REFLECT
		db DOUBLE_TEAM
		db SWIFT
		db EXPLOSION

	db 73, JOLTEON, NEVERMELTICE
		db HIDDEN_POWER ; Ice
		db THUNDER_WAVE
		db HYPER_VOICE
		db THUNDERBOLT

	db 73, LANTURN, LEFTOVERS
		db SURF
		db ICE_BEAM
		db THUNDERBOLT
		db RECOVER

	db 72, MAGNEZONE, CHARCOAL
		db LOCK_ON
		db DOUBLE_TEAM
		db HIDDEN_POWER ; Fire
		db THUNDERBOLT

	db 75, RAICHU, BRIGHTPOWDER
		db THUNDER_WAVE
		db NASTY_PLOT
		db THUNDERBOLT
		db FOCUS_BLAST

	db $ff ; end

; ================
; ================================


ErikaGroup:
; ================================
; ================

	; ERIKA
	db "Erika@"
	db 3 ; item + moves

	; party

	db 62, TANGROWTH, NO_ITEM
		db ANCIENTPOWER
		db MORNING_SUN
		db GIGA_DRAIN
		db SLEEP_POWDER

	db 61, SUNFLORA, NO_ITEM
		db SUNNY_DAY
		db MORNING_SUN
		db GIGA_DRAIN
		db FLAMETHROWER

	db 61, PARASECT, NO_ITEM
		db SPORE
		db SLASH
		db GROWTH
		db GIGA_DRAIN

	db 64, VICTREEBEL, NO_ITEM
		db SUNNY_DAY
		db MORNING_SUN
		db ACID
		db RAZOR_LEAF

	db 65, VILEPLUME, NO_ITEM
		db SUNNY_DAY
		db MOONLIGHT
		db PETAL_DANCE
		db SOLAR_BEAM

	db 65, BELLOSSOM, GOLD_BERRY
		db SUNNY_DAY
		db MORNING_SUN
		db PETAL_DANCE
		db SOLAR_BEAM

	db $ff ; end

; ================

	; ERIKA
	db "Erika@"
	db 3 ; item + moves

	; party

	db 73, TANGROWTH, LEFTOVERS
		db EARTHQUAKE
		db SWORDS_DANCE
		db GIGA_DRAIN
		db SLEEP_POWDER

	db 72, SUNFLORA, BRIGHTPOWDER
		db SUNNY_DAY
		db LEECH_SEED
		db GIGA_DRAIN
		db FIRE_BLAST

	db 73, VICTREEBEL, POISON_BARB
		db SWORDS_DANCE
		db GIGA_DRAIN
		db SLUDGE_BOMB
		db SEED_BOMB

	db 74, LEAFEON, MIRACLE_SEED
		db SWORDS_DANCE
		db SEED_BOMB
		db IRON_TAIL
		db X_SCISSOR

	db 74, VILEPLUME, QUICK_CLAW
		db PETAL_DANCE
		db MOONLIGHT
		db LEECH_SEED
		db TOXIC

	db 75, BELLOSSOM, PINK_BOW
		db SLEEP_POWDER
		db MOONBLAST
		db PETAL_DANCE
		db HIDDEN_POWER ; Rock

	db $ff ; end

; ================
; ================================


JanineGroup:
; ================================
; ================

	; JANINE
	db "Janine@"
	db 3 ; item + moves

	; party

	db 64, CROBAT, NO_ITEM
		db SCREECH
		db SUPERSONIC
		db CONFUSE_RAY
		db WING_ATTACK

	db 61, ARIADOS, NO_ITEM
		db AGILITY
		db POISON_JAB
		db MEAN_LOOK
		db PSYCHIC_M

	db 62, QWILFISH, NO_ITEM
		db AQUA_TAIL
		db POISON_JAB
		db SPIKES
		db MINIMIZE

	db 61, ARIADOS, NO_ITEM
		db SCARY_FACE
		db POISON_JAB
		db MEAN_LOOK
		db GIGA_DRAIN

	db 64, WEEZING, NO_ITEM
		db SLUDGE_BOMB
		db THUNDER
		db FIRE_BLAST
		db EXPLOSION

	db 66, VENOMOTH, GOLD_BERRY
		db SLUDGE_BOMB
		db DOUBLE_TEAM
		db GUST
		db PSYCHIC_M

	db $ff ; end

; ================

	; JANINE
	db "Janine@"
	db 3 ; item + moves

	; party

	db 73, CROBAT, KINGS_ROCK
		db DOUBLE_TEAM
		db POISON_JAB
		db WING_ATTACK
		db TOXIC

	db 72, ARIADOS, QUICK_CLAW
		db SCARY_FACE
		db POISON_JAB
		db MEAN_LOOK
		db GIGA_DRAIN

	db 72, QWILFISH, FOCUS_BAND
		db AQUA_TAIL
		db POISON_JAB
		db SPIKES
		db EXPLOSION

	db 74, NIDOQUEEN, LEFTOVERS
		db EARTHQUAKE
		db MOONLIGHT
		db SLUDGE_BOMB
		db ICE_BEAM

	db 73, WEEZING, CHARCOAL
		db SLUDGE_BOMB
		db FIRE_BLAST
		db WILL_O_WISP
		db EXPLOSION

	db 75, VENOMOTH, BRIGHTPOWDER
		db SLUDGE_BOMB
		db DOUBLE_TEAM
		db SLEEP_POWDER
		db PSYCHIC_M

	db $ff ; end

; ================
; ================================


SabrinaGroup:
; ================================
; ================

	; SABRINA
	db "Sabrina@"
	db 3 ; item + moves

	; party

	db 61, ESPEON, NO_ITEM
		db SAND_ATTACK
		db QUICK_ATTACK
		db SWIFT
		db PSYCHIC_M

	db 59, GIRAFARIG, NO_ITEM
		db PSYCHIC_M
		db CRUNCH
		db AGILITY
		db CALM_MIND

	db 60, MR__MIME, NO_ITEM
		db BARRIER
		db REFLECT
		db BATON_PASS
		db PSYCHIC_M

	db 59, HYPNO, NO_ITEM
		db HYPNOSIS
		db DREAM_EATER
		db NIGHTMARE
		db PSYCHIC_M

	db 58, WOBBUFFET, NO_ITEM
		db COUNTER
		db MIRROR_COAT
		db SAFEGUARD
		db DESTINY_BOND

	db 62, ALAKAZAM, GOLD_BERRY
		db RECOVER
		db FUTURE_SIGHT
		db PSYCHIC_M
		db REFLECT

	db $ff ; end

; ================

	; SABRINA
	db "Sabrina@"
	db 3 ; item + moves

	; party

	db 74, ESPEON, LEFTOVERS
		db PSYCHIC_M
		db BATON_PASS
		db REFLECT
		db LIGHT_SCREEN

	db 73, MR__MIME, NO_ITEM
		db PSYCHIC_M
		db DAZZLINGLEAM
		db NASTY_PLOT
		db ENCORE

	db 73, GIRAFARIG, BRIGHTPOWDER
		db NASTY_PLOT
		db SHADOW_BALL
		db HYPER_VOICE
		db PSYCHIC_M

	db 72, HYPNO, TWISTEDSPOON
		db NASTY_PLOT
		db PSYCHIC_M
		db HYPNOSIS
		db NIGHTMARE

	db 74, SLOWKING, KINGS_ROCK
		db THUNDER_WAVE
		db NASTY_PLOT
		db SCALD
		db PSYCHIC_M

	db 75, ALAKAZAM, FOCUS_BAND
		db RECOVER
		db SHADOW_BALL
		db PSYCHIC_M
		db FOCUS_BLAST

	db $ff ; end

; ================
; ================================


BlaineGroup:
; ================================
; ================

	; BLAINE
	db "Blaine@"
	db 3 ; item + moves

	; party

	db 65, MAGCARGO, NO_ITEM
		db CURSE
		db WILL_O_WISP
		db FLAMETHROWER
		db ROCK_SLIDE

	db 68, MAGMORTAR, NO_ITEM
		db SUNNY_DAY
		db THUNDERPUNCH
		db FLAMETHROWER
		db FLASH_CANNON

	db 66, ARCANINE, NO_ITEM
		db CRUNCH
		db FLAME_WHEEL
		db FLARE_BLITZ
		db TAKE_DOWN

	db 66, NINETALES, NO_ITEM
		db CONFUSE_RAY
		db FIRE_SPIN
		db FLAMETHROWER
		db WILL_O_WISP

	db 65, FLAREON, NO_ITEM
		db WILL_O_WISP
		db FLARE_BLITZ
		db QUICK_ATTACK
		db FIRE_BLAST

	db 69, RAPIDASH, GOLD_BERRY
		db QUICK_ATTACK
		db FIRE_SPIN
		db FURY_ATTACK
		db FIRE_BLAST

	db $ff ; end

	; BLAINE
	db "Blaine@"
	db 3 ; item + moves

	; party

	db 71, MAGCARGO, FOCUS_BAND
		db RECOVER
		db DRAGON_DANCE
		db FLAME_WHEEL
		db ROCK_SLIDE

	db 72, MAGMORTAR, BLACK_BELT
		db SUNNY_DAY
		db FOCUS_BLAST
		db FIRE_BLAST
		db FLASH_CANNON

	db 73, ARCANINE, KINGS_ROCK
		db CRUNCH
		db FLAME_WHEEL
		db FLARE_BLITZ
		db EXTREMESPEED

	db 74, FLAREON, CHARCOAL
		db WILL_O_WISP
		db FLARE_BLITZ
		db DOUBLE_EDGE
		db SCARY_FACE

	db 72, TYPHLOSION, LEFTOVERS
		db FIRE_BLAST
		db FOCUS_BLAST
		db EARTH_POWER
		db HIDDEN_POWER ; Grass

	db 75, RAPIDASH, POISON_BARB
		db MEGAHORN
		db POISON_JAB
		db FLARE_BLITZ
		db WILD_CHARGE

	db $ff ; end

; ================
; ================================


BlueGroup:
; ================================
; ================

	; BLUE
	db "Blue@"
	db 3 ; item + moves

	; party

	db 70, PIDGEOT, LEFTOVERS
		db QUICK_ATTACK
		db FLY
		db WING_ATTACK
		db AIR_SLASH

	db 66, MACHAMP, BLACK_BELT
		db DYNAMICPUNCH
		db EARTHQUAKE
		db STONE_EDGE
		db THUNDERPUNCH

	db 67, RHYPERIOR, SOFT_SAND
		db FURY_ATTACK
		db SANDSTORM
		db STONE_EDGE
		db EARTHQUAKE

	db 70, BLASTOISE, MYSTIC_WATER
		db SURF
		db ICE_BEAM
		db BODY_SLAM
		db FLASH_CANNON

	db 68, EXEGGUTOR, MIRACLE_SEED
		db PSYCHIC_M
		db LEECH_SEED
		db EGG_BOMB
		db GIGA_DRAIN

	db 68, ARCANINE, CHARCOAL
		db ROAR
		db FLAME_WHEEL
		db FLAMETHROWER
		db EXTREMESPEED

	db $ff ; end

	; BLUE
	db "Blue@"
	db 3 ; item + moves

	; party

	db 75, PIDGEOT, SHARP_BEAK
		db EXTREMESPEED
		db DRILL_PECK
		db STEEL_WING
		db TWISTER

	db 73, MACHAMP, BLACK_BELT
		db CROSS_CHOP
		db EARTHQUAKE
		db STONE_EDGE
		db THUNDERPUNCH

	db 74, TYRANITAR, BLACKGLASSES
		db EARTHQUAKE
		db STONE_EDGE
		db CRUNCH
		db PURSUIT

	db 75, BLASTOISE, LEFTOVERS
		db SURF
		db ICE_BEAM
		db REST
		db SLEEP_TALK

	db 74, EXEGGUTOR, MIRACLE_SEED
		db PSYCHIC_M
		db LEECH_SEED
		db SEED_BOMB
		db GIGA_DRAIN

	db 74, ARCANINE, CHARCOAL
		db ROAR
		db OUTRAGE
		db FLARE_BLITZ
		db EXTREMESPEED

	db $ff ; end

; ================
; ================================


RedGroup:
; ================================
; ================

	; RED
	db "Red@"
	db 3 ; item + moves

	; party

	db 90, PIKACHU, LIGHT_BALL
		db THUNDERBOLT
		db SURF
		db IRON_TAIL
		db WILD_CHARGE

	db 84, ESPEON, TWISTEDSPOON
		db PSYCHIC_M
		db MORNING_SUN
		db REFLECT
		db SHADOW_BALL

	db 85, SNORLAX, LEFTOVERS
		db CURSE
		db REST
		db SLEEP_TALK
		db DOUBLE_EDGE

	db 87, VENUSAUR, QUICK_CLAW
		db GIGA_DRAIN
		db SLUDGE_BOMB
		db MORNING_SUN
		db SLEEP_POWDER

	db 87, CHARIZARD, MIRACLEBERRY
		db FIRE_BLAST
		db SWORDS_DANCE
		db EARTHQUAKE
		db WING_ATTACK

	db 87, BLASTOISE, MYSTIC_WATER
		db SURF
		db BODY_SLAM
		db BLIZZARD
		db ROLLOUT

	db $ff ; end

; ================
; ================================


LeafGroup:
; ================================
; ================

	; LEAF
	db "Green@"
	db 3 ; item + moves

	; party

	db 96, LAPRAS, LEFTOVERS
		db ICE_BEAM
		db THUNDERBOLT
		db REST
		db SLEEP_TALK

	db 100, VENUSAUR, MIRACLE_SEED
		db GROWTH
		db GIGA_DRAIN
		db SLUDGE_BOMB
		db SLEEP_POWDER

	db 98, MOLTRES, CHARCOAL
		db FIRE_BLAST
		db HIDDEN_POWER ; Grass
		db COUNTER
		db EXTRASENSORY

	db 95, SYLVEON, BRIGHTPOWDER
		db MOONBLAST
		db LIGHT_SCREEN
		db CALM_MIND
		db HYPER_VOICE

	db 98, DRAGONITE, DRAGON_FANG
		db DRAGON_DANCE
		db OUTRAGE
		db EARTHQUAKE
		db BODY_SLAM

	db 99, MEW, TWISTEDSPOON
		db NASTY_PLOT
		db PSYCHIC_M
		db DARK_PULSE
		db GIGA_DRAIN

	db $ff ; end

; ================
; ================================


Rival1Group:
; ================================
; ================

	; RIVAL1
	db "?@"
	db 2 ; item

	; party
	db 4, SENTRET, NO_ITEM
	db 5, CHIKORITA, BERRY

	db $ff ; end

; ================

	; RIVAL1
	db "?@"
	db 2 ; item

	; party
	db 4, SENTRET, NO_ITEM
	db 5, CYNDAQUIL, BERRY

	db $ff ; end

; ================

	; RIVAL1
	db "?@"
	db 2 ; item

	; party
	db 4, SENTRET, NO_ITEM
	db 5, TOTODILE, BERRY

	db $ff ; end

; ================

	; RIVAL1
	db "?@"
	db 2 ; item

	; party
	db 14, GASTLY, NO_ITEM
	db 16, ZUBAT, NO_ITEM
	db 15, GEODUDE, NO_ITEM
	db 18, BAYLEEF, BERRY

	db $ff ; end

; ================

	; RIVAL1
	db "?@"
	db 2 ; item

	; party
	db 14, GASTLY, NO_ITEM
	db 16, ZUBAT, NO_ITEM
	db 15, GEODUDE, NO_ITEM
	db 18, QUILAVA, BERRY

	db $ff ; end

; ================

	; RIVAL1
	db "?@"
	db 2 ; item

	; party
	db 14, GASTLY, NO_ITEM
	db 16, ZUBAT, NO_ITEM
	db 15, GEODUDE, NO_ITEM
	db 18, CROCONAW, BERRY

	db $ff ; end

; ================

	; RIVAL1
	db "?@"
	db 3 ; item + moves

	; party

	db 20, HAUNTER, NO_ITEM
		db LICK
		db CONFUSE_RAY
		db MEAN_LOOK
		db CURSE

	db 18, MAGNEMITE, NO_ITEM
		db TACKLE
		db THUNDERSHOCK
		db SUPERSONIC
		db SONIC_BOOM

	db 19, DROWZEE, NO_ITEM
		db HYPNOSIS
		db CONFUSION
		db HEADBUTT
		db LOW_KICK

	db 20, ZUBAT, NO_ITEM
		db LEECH_LIFE
		db SUPERSONIC
		db BITE
		db CONFUSE_RAY

	db 22, BAYLEEF, BERRY
		db REFLECT
		db RAZOR_LEAF
		db POISONPOWDER
		db FAIRY_WIND

	db $ff ; end

; ================

	; RIVAL1
	db "?@"
	db 3 ; item + moves

	; party

	db 20, HAUNTER, NO_ITEM
		db LICK
		db CONFUSE_RAY
		db MEAN_LOOK
		db CURSE

	db 18, MAGNEMITE, NO_ITEM
		db TACKLE
		db THUNDERSHOCK
		db SUPERSONIC
		db SONIC_BOOM

	db 19, DROWZEE, NO_ITEM
		db HYPNOSIS
		db CONFUSION
		db HEADBUTT
		db LOW_KICK

	db 20, ZUBAT, NO_ITEM
		db LEECH_LIFE
		db SUPERSONIC
		db BITE
		db CONFUSE_RAY

	db 22, QUILAVA, BERRY
		db LEER
		db SMOKESCREEN
		db EMBER
		db QUICK_ATTACK

	db $ff ; end

; ================

	; RIVAL1
	db "?@"
	db 3 ; item + moves

	; party

	db 20, HAUNTER, NO_ITEM
		db LICK
		db CONFUSE_RAY
		db MEAN_LOOK
		db CURSE

	db 18, MAGNEMITE, NO_ITEM
		db TACKLE
		db THUNDERSHOCK
		db SUPERSONIC
		db SONIC_BOOM

	db 19, DROWZEE, NO_ITEM
		db HYPNOSIS
		db CONFUSION
		db HEADBUTT
		db LOW_KICK

	db 20, ZUBAT, NO_ITEM
		db LEECH_LIFE
		db SUPERSONIC
		db BITE
		db CONFUSE_RAY

	db 22, CROCONAW, BERRY
		db LEER
		db RAGE
		db WATER_GUN
		db BITE

	db $ff ; end

; ================

	; RIVAL1
	db "?@"
	db 3 ; item + moves

	; party

	db 38, GOLBAT, NO_ITEM
		db LEECH_LIFE
		db BITE
		db CONFUSE_RAY
		db WING_ATTACK

	db 37, MAGNETON, NO_ITEM
		db TRI_ATTACK
		db THUNDERBOLT
		db FLASH_CANNON
		db THUNDER_WAVE

	db 37, HAUNTER, NO_ITEM
		db PAIN_SPLIT
		db MEAN_LOOK
		db CONFUSE_RAY
		db SHADOW_BALL

	db 39, SNEASEL, NO_ITEM
		db SLASH
		db ICE_PUNCH
		db SCREECH
		db FEINT_ATTACK

	db 41, MEGANIUM, GOLD_BERRY
		db REFLECT
		db LIGHT_SCREEN
		db PETAL_DANCE
		db ANCIENTPOWER

	db $ff ; end

; ================

	; RIVAL1
	db "?@"
	db 3 ; item + moves

	; party

	db 38, GOLBAT, NO_ITEM
		db LEECH_LIFE
		db BITE
		db CONFUSE_RAY
		db WING_ATTACK

	db 37, MAGNETON, NO_ITEM
		db TRI_ATTACK
		db THUNDERBOLT
		db FLASH_CANNON
		db THUNDER_WAVE

	db 37, HAUNTER, NO_ITEM
		db PAIN_SPLIT
		db MEAN_LOOK
		db CONFUSE_RAY
		db SHADOW_BALL

	db 39, SNEASEL, NO_ITEM
		db SLASH
		db ICE_PUNCH
		db SCREECH
		db FEINT_ATTACK

	db 41, TYPHLOSION, GOLD_BERRY
		db SMOKESCREEN
		db FLAME_WHEEL
		db DIG
		db SWIFT

	db $ff ; end

; ================

	; RIVAL1
	db "?@"
	db 3 ; item + moves

	; party

	db 38, GOLBAT, NO_ITEM
		db LEECH_LIFE
		db BITE
		db CONFUSE_RAY
		db WING_ATTACK

	db 37, MAGNETON, NO_ITEM
		db TRI_ATTACK
		db THUNDERBOLT
		db FLASH_CANNON
		db THUNDER_WAVE

	db 37, HAUNTER, NO_ITEM
		db PAIN_SPLIT
		db MEAN_LOOK
		db CONFUSE_RAY
		db SHADOW_BALL

	db 39, SNEASEL, NO_ITEM
		db SLASH
		db ICE_PUNCH
		db SCREECH
		db FEINT_ATTACK

	db 41, FERALIGATR, GOLD_BERRY
		db SLASH
		db SURF
		db CRUNCH
		db NIGHT_SLASH

	db $ff ; end

; ================

	; RIVAL1
	db "?@"
	db 3 ; item + moves

	; party

	db 44, WEAVILE, NO_ITEM
		db SWORDS_DANCE
		db SCREECH
		db NIGHT_SLASH
		db X_SCISSOR

	db 46, GOLBAT, NO_ITEM
		db POISON_JAB
		db SUPER_FANG
		db CONFUSE_RAY
		db WING_ATTACK

	db 45, MAGNETON, NO_ITEM
		db THUNDERBOLT
		db TRI_ATTACK
		db THUNDER_WAVE
		db FLASH_CANNON

	db 45, GENGAR, NO_ITEM
		db MEAN_LOOK
		db DARK_PULSE
		db SHADOW_BALL
		db CONFUSE_RAY

	db 45, ALAKAZAM, NO_ITEM
		db DISABLE
		db PSYCHIC_M
		db RECOVER
		db CONFUSE_RAY

	db 48, MEGANIUM, GOLD_BERRY
		db REFLECT
		db LIGHT_SCREEN
		db SEED_BOMB
		db ANCIENTPOWER

	db $ff ; end

; ================

	; RIVAL1
	db "?@"
	db 3 ; item + moves

	; party

	db 44, WEAVILE, NO_ITEM
		db SWORDS_DANCE
		db SCREECH
		db NIGHT_SLASH
		db X_SCISSOR

	db 46, GOLBAT, NO_ITEM
		db POISON_JAB
		db SUPER_FANG
		db CONFUSE_RAY
		db WING_ATTACK

	db 45, MAGNETON, NO_ITEM
		db THUNDERBOLT
		db TRI_ATTACK
		db THUNDER_WAVE
		db FLASH_CANNON

	db 45, GENGAR, NO_ITEM
		db MEAN_LOOK
		db DARK_PULSE
		db SHADOW_BALL
		db CONFUSE_RAY

	db 45, ALAKAZAM, NO_ITEM
		db DISABLE
		db PSYCHIC_M
		db RECOVER
		db CONFUSE_RAY

	db 48, TYPHLOSION, GOLD_BERRY
		db SMOKESCREEN
		db QUICK_ATTACK
		db DIG
		db FLAMETHROWER

	db $ff ; end

; ================

	; RIVAL1
	db "?@"
	db 3 ; item + moves

	; party

	db 44, WEAVILE, NO_ITEM
		db SWORDS_DANCE
		db SCREECH
		db NIGHT_SLASH
		db X_SCISSOR

	db 46, GOLBAT, NO_ITEM
		db POISON_JAB
		db SUPER_FANG
		db CONFUSE_RAY
		db WING_ATTACK

	db 45, MAGNETON, NO_ITEM
		db THUNDERBOLT
		db TRI_ATTACK
		db THUNDER_WAVE
		db FLASH_CANNON

	db 45, GENGAR, NO_ITEM
		db MEAN_LOOK
		db DARK_PULSE
		db SHADOW_BALL
		db CONFUSE_RAY

	db 45, ALAKAZAM, NO_ITEM
		db DISABLE
		db PSYCHIC_M
		db RECOVER
		db CONFUSE_RAY

	db 48, FERALIGATR, GOLD_BERRY
		db CRUNCH
		db SURF
		db SLASH
		db SCARY_FACE

	db $ff ; end

; ================
; ================================


Rival2Group:
; ================================
; ================

	; RIVAL2
	db "?@"
	db 3 ; item + moves

	; party

	db 61, WEAVILE, KINGS_ROCK
		db SWORDS_DANCE
		db ICE_PUNCH
		db SLASH
		db CRUNCH

	db 62, GOLBAT, EVIOLITE
		db POISON_JAB
		db SUPER_FANG
		db CONFUSE_RAY
		db WING_ATTACK

	db 61, MAGNEZONE, MAGNET
		db LOCK_ON
		db ZAP_CANNON
		db THUNDER_WAVE
		db FLASH_CANNON

	db 63, GENGAR, SPELL_TAG
		db MEAN_LOOK
		db CURSE
		db SHADOW_BALL
		db CONFUSE_RAY

	db 63, ALAKAZAM, BRIGHTPOWDER
		db DISABLE
		db RECOVER
		db FUTURE_SIGHT
		db PSYCHIC_M

	db 65, MEGANIUM, MIRACLE_SEED
		db SEED_BOMB
		db POISONPOWDER
		db BODY_SLAM
		db LIGHT_SCREEN

	db $ff ; end

; ================

	; RIVAL2
	db "?@"
	db 3 ; item + moves

	; party

	db 61, WEAVILE, KINGS_ROCK
		db SWORDS_DANCE
		db ICE_PUNCH
		db SLASH
		db CRUNCH

	db 62, GOLBAT, EVIOLITE
		db POISON_JAB
		db SUPER_FANG
		db CONFUSE_RAY
		db WING_ATTACK

	db 61, MAGNEZONE, MAGNET
		db LOCK_ON
		db ZAP_CANNON
		db THUNDER_WAVE
		db FLASH_CANNON

	db 63, GENGAR, SPELL_TAG
		db MEAN_LOOK
		db CURSE
		db SHADOW_BALL
		db CONFUSE_RAY

	db 63, ALAKAZAM, BRIGHTPOWDER
		db DISABLE
		db RECOVER
		db FUTURE_SIGHT
		db PSYCHIC_M

	db 65, TYPHLOSION, CHARCOAL
		db FLAMETHROWER
		db EARTH_POWER
		db THUNDERPUNCH
		db SMOKESCREEN

	db $ff ; end

; ================

	; RIVAL2
	db "?@"
	db 3 ; item + moves

	; party

	db 61, WEAVILE, KINGS_ROCK
		db SWORDS_DANCE
		db ICE_PUNCH
		db SLASH
		db CRUNCH

	db 62, GOLBAT, EVIOLITE
		db POISON_JAB
		db SUPER_FANG
		db CONFUSE_RAY
		db WING_ATTACK

	db 61, MAGNEZONE, MAGNET
		db LOCK_ON
		db ZAP_CANNON
		db THUNDER_WAVE
		db FLASH_CANNON

	db 63, GENGAR, SPELL_TAG
		db MEAN_LOOK
		db CURSE
		db SHADOW_BALL
		db CONFUSE_RAY

	db 63, ALAKAZAM, BRIGHTPOWDER
		db DISABLE
		db RECOVER
		db FUTURE_SIGHT
		db PSYCHIC_M

	db 65, FERALIGATR, MYSTIC_WATER
		db WATERFALL
		db CRUNCH
		db SLASH
		db SCARY_FACE

	db $ff ; end

; ================

	; RIVAL2
	db "?@"
	db 3 ; item + moves

	; party

	db 68, WEAVILE, KINGS_ROCK
		db SWORDS_DANCE
		db ICE_PUNCH
		db SLASH
		db CRUNCH

	db 69, CROBAT, POISON_BARB
		db POISON_JAB
		db CRUNCH
		db CONFUSE_RAY
		db TOXIC

	db 68, MAGNEZONE, MAGNET
		db THUNDERBOLT
		db TRI_ATTACK
		db THUNDER_WAVE
		db FLASH_CANNON

	db 70, GENGAR, SPELL_TAG
		db THUNDERBOLT
		db FOCUS_BLAST
		db SHADOW_BALL
		db CONFUSE_RAY

	db 70, ALAKAZAM, BRIGHTPOWDER
		db RECOVER
		db TRI_ATTACK
		db PSYCHIC_M
		db REFLECT

	db 72, MEGANIUM, LEFTOVERS
		db PETAL_DANCE
		db MOONBLAST
		db LIGHT_SCREEN
		db ANCIENTPOWER

	db $ff ; end

; ================

	; RIVAL2
	db "?@"
	db 3 ; item + moves

	; party

	db 68, WEAVILE, KINGS_ROCK
		db SWORDS_DANCE
		db ICE_PUNCH
		db SLASH
		db CRUNCH

	db 69, CROBAT, POISON_BARB
		db POISON_JAB
		db CRUNCH
		db CONFUSE_RAY
		db TOXIC

	db 68, MAGNEZONE, MAGNET
		db THUNDERBOLT
		db TRI_ATTACK
		db THUNDER_WAVE
		db FLASH_CANNON

	db 70, GENGAR, SPELL_TAG
		db THUNDERBOLT
		db FOCUS_BLAST
		db SHADOW_BALL
		db CONFUSE_RAY

	db 70, ALAKAZAM, BRIGHTPOWDER
		db RECOVER
		db TRI_ATTACK
		db PSYCHIC_M
		db REFLECT

	db 72, TYPHLOSION, LEFTOVERS
		db FIRE_BLAST
		db FOCUS_BLAST
		db EARTH_POWER
		db SMOKESCREEN

	db $ff ; end

; ================

	; RIVAL2
	db "?@"
	db 3 ; item + moves

	; party

	db 68, WEAVILE, KINGS_ROCK
		db SWORDS_DANCE
		db ICE_PUNCH
		db SLASH
		db CRUNCH

	db 69, CROBAT, POISON_BARB
		db POISON_JAB
		db CRUNCH
		db CONFUSE_RAY
		db TOXIC

	db 68, MAGNEZONE, MAGNET
		db THUNDERBOLT
		db TRI_ATTACK
		db THUNDER_WAVE
		db FLASH_CANNON

	db 70, GENGAR, SPELL_TAG
		db THUNDERBOLT
		db FOCUS_BLAST
		db SHADOW_BALL
		db CONFUSE_RAY

	db 70, ALAKAZAM, BRIGHTPOWDER
		db RECOVER
		db TRI_ATTACK
		db PSYCHIC_M
		db REFLECT

	db 72, FERALIGATR, LEFTOVERS
		db SURF
		db CRUNCH
		db SLASH
		db OUTRAGE

	db $ff ; end

; ================
; ================================


YoungsterGroup:
; ================================
; ================

	; YOUNGSTER
	db "Joey@"
	db 0 ; normal

	; party
	db 5, RATTATA

	db $ff ; end

; ================

	; YOUNGSTER
	db "Mikey@"
	db 0 ; normal

	; party
	db 2, RATTATA
	db 4, PIDGEY

	db $ff ; end

; ================

	; YOUNGSTER
	db "Albert@"
	db 0 ; normal

	; party
	db 6, RATTATA
	db 8, ZUBAT

	db $ff ; end

; ================

	; YOUNGSTER
	db "Gordon@"
	db 0 ; normal

	; party
	db 10, WOOPER

	db $ff ; end

; ================

	; YOUNGSTER
	db "Joey@"
	db 0 ; normal

	; party
	db 15, RATTATA

	db $ff ; end

; ================

	; YOUNGSTER
	db "Joey@"
	db 1 ; moves

	; party

	db 25, RATICATE
		db TAIL_WHIP
		db QUICK_ATTACK
		db HYPER_FANG
		db SCARY_FACE

	db $ff ; end

; ================

	; YOUNGSTER
	db "Warren@"
	db 0 ; normal

	; party
	db 38, PIDGEOTTO
	db 42, RATICATE

	db $ff ; end

; ================

	; YOUNGSTER
	db "Jimmy@"
	db 0 ; normal

	; party
	db 42, RATICATE
	db 42, ARBOK
	db 42, PARASECT

	db $ff ; end

; ================

	; YOUNGSTER
	db "Owen@"
	db 0 ; normal

	; party
	db 44, GROWLITHE

	db $ff ; end

; ================

	; YOUNGSTER
	db "Jason@"
	db 0 ; normal

	; party
	db 42, SANDSLASH
	db 42, CROBAT

	db $ff ; end

; ================

	; YOUNGSTER
	db "Joey@"
	db 1 ; moves

	; party

	db 30, RATICATE
		db TAIL_WHIP
		db QUICK_ATTACK
		db HYPER_FANG
		db PURSUIT

	db $ff ; end

; ================

	; YOUNGSTER
	db "Joey@"
	db 1 ; moves

	; party

	db 40, RATICATE
		db HYPER_BEAM
		db QUICK_ATTACK
		db HYPER_FANG
		db PURSUIT

	db $ff ; end

; ================
; ================================


BugCatcherGroup:
; ================================
; ================

	; BUG_CATCHER
	db "Don@"
	db 0 ; normal

	; party
	db 3, CATERPIE
	db 3, CATERPIE

	db $ff ; end

; ================

	; BUG_CATCHER
	db "Rob@"
	db 0 ; normal

	; party
	db 40, BEEDRILL
	db 39, BUTTERFREE

	db $ff ; end

; ================

	; BUG_CATCHER
	db "Ed@"
	db 0 ; normal

	; party
	db 43, YANMA
	db 43, BEEDRILL
	db 43, BUTTERFREE

	db $ff ; end

; ================

	; BUG_CATCHER
	db "Wade@"
	db 0 ; normal

	; party
	db 2, CATERPIE
	db 2, CATERPIE
	db 3, WEEDLE
	db 2, CATERPIE

	db $ff ; end

; ================

	; BUG_CATCHER
	db "Benny@"
	db 0 ; normal

	; party
	db 7, WEEDLE
	db 9, KAKUNA
	db 12, BEEDRILL

	db $ff ; end

; ================

	; BUG_CATCHER
	db "Al@"
	db 0 ; normal

	; party
	db 12, CATERPIE
	db 12, WEEDLE

	db $ff ; end

; ================

	; BUG_CATCHER
	db "Josh@"
	db 0 ; normal

	; party
	db 13, PARAS

	db $ff ; end

; ================

	; BUG_CATCHER
	db "Arnie@"
	db 0 ; normal

	; party
	db 15, VENONAT

	db $ff ; end

; ================

	; BUG_CATCHER
	db "Ken@"
	db 0 ; normal

	; party
	db 40, ARIADOS
	db 41, PINSIR

	db $ff ; end

; ================

	; BUG_CATCHER
	db "Wade@"
	db 0 ; normal

	; party
	db 9, METAPOD
	db 9, METAPOD
	db 10, KAKUNA
	db 9, METAPOD

	db $ff ; end

; ================

	; BUG_CATCHER
	db "Wade@"
	db 0 ; normal

	; party
	db 14, BUTTERFREE
	db 14, BUTTERFREE
	db 15, BEEDRILL
	db 14, BUTTERFREE

	db $ff ; end

; ================

	; BUG_CATCHER
	db "Doug@"
	db 0 ; normal

	; party
	db 39, BUTTERFREE
	db 37, ARIADOS

	db $ff ; end

; ================

	; BUG_CATCHER
	db "Arnie@"
	db 0 ; normal

	; party
	db 19, VENONAT

	db $ff ; end

; ================

	; BUG_CATCHER
	db "Arnie@"
	db 1 ; moves

	; party

	db 28, VENOMOTH
		db DISABLE
		db SUPERSONIC
		db CONFUSION
		db LEECH_LIFE

	db $ff ; end

; ================

	; BUG_CATCHER
	db "Wade@"
	db 1 ; moves

	; party

	db 24, BUTTERFREE
		db CONFUSION
		db POISONPOWDER
		db SUPERSONIC
		db WHIRLWIND

	db 24, BUTTERFREE
		db CONFUSION
		db STUN_SPORE
		db SUPERSONIC
		db WHIRLWIND

	db 25, BEEDRILL
		db FURY_ATTACK
		db FOCUS_ENERGY
		db TWINEEDLE
		db RAGE

	db 24, BUTTERFREE
		db CONFUSION
		db SLEEP_POWDER
		db SUPERSONIC
		db WHIRLWIND

	db $ff ; end

; ================

	; BUG_CATCHER
	db "Wade@"
	db 1 ; moves

	; party

	db 30, BUTTERFREE
		db CONFUSION
		db POISONPOWDER
		db SUPERSONIC
		db GUST

	db 30, BUTTERFREE
		db CONFUSION
		db STUN_SPORE
		db SUPERSONIC
		db GUST

	db 32, BEEDRILL
		db FURY_ATTACK
		db PURSUIT
		db TWINEEDLE
		db DOUBLE_TEAM

	db 34, BUTTERFREE
		db PSYBEAM
		db SLEEP_POWDER
		db GUST
		db WHIRLWIND

	db $ff ; end

; ================

	; BUG_CATCHER
	db "Arnie@"
	db 1 ; moves

	; party

	db 36, VENOMOTH
		db GUST
		db SUPERSONIC
		db PSYBEAM
		db LEECH_LIFE

	db $ff ; end

; ================

	; BUG_CATCHER
	db "Arnie@"
	db 1 ; moves

	; party

	db 40, VENOMOTH
		db GUST
		db SUPERSONIC
		db PSYCHIC_M
		db TOXIC

	db $ff ; end

; ================

	; BUG_CATCHER
	db "Wayne@"
	db 0 ; normal

	; party
	db 9, PARAS
	db 10, PINECO

	db $ff ; end

; ================

	; BUG_CATCHER
	db "Dane@"
	db 0 ; normal

	; party
	db 44, BEEDRILL
	db 48, BUTTERFREE

	db $ff ; end

; ================

	; BUG_CATCHER
	db "Dion@"
	db 0 ; normal

	; party
	db 50, ARIADOS

	db $ff ; end

; ================

	; BUG_CATCHER
	db "Stacey@"
	db 0 ; normal

	; party
	db 52, METAPOD
	db 56, METAPOD
	db 60, METAPOD

	db $ff ; end

; ================

	; BUG_CATCHER
	db "Ellis@"
	db 0 ; normal

	; party
	db 40, WEEDLE
	db 44, KAKUNA
	db 48, BEEDRILL

	db $ff ; end

; ================

	; BUG_CATCHER
	db "Abner@"
	db 0 ; normal

	; party
	db 44, BUTTERFREE
	db 44, BEEDRILL
	db 44, PIKACHU

	db $ff ; end

; ================
; ================================


CamperGroup:
; ================================
; ================

	; CAMPER
	db "Roland@"
	db 0 ; normal

	; party
	db 9, NIDORAN_M

	db $ff ; end

; ================

	; CAMPER
	db "Todd@"
	db 0 ; normal

	; party
	db 14, PSYDUCK

	db $ff ; end

; ================

	; CAMPER
	db "Ivan@"
	db 0 ; normal

	; party
	db 10, DIGLETT
	db 10, ZUBAT
	db 14, DIGLETT

	db $ff ; end

; ================

	; CAMPER
	db "Barry@"
	db 0 ; normal

	; party
	db 48, NIDOKING

	db $ff ; end

; ================

	; CAMPER
	db "Lloyd@"
	db 0 ; normal

	; party
	db 46, NIDOKING

	db $ff ; end

; ================

	; CAMPER
	db "Dean@"
	db 0 ; normal

	; party
	db 44, GOLDUCK
	db 42, SANDSLASH

	db $ff ; end

; ================

	; CAMPER
	db "Sid@"
	db 0 ; normal

	; party
	db 43, DUGTRIO
	db 40, PRIMEAPE
	db 40, POLIWRATH

	db $ff ; end

; ================

	; CAMPER
	db "Ted@"
	db 0 ; normal

	; party
	db 18, MANKEY

	db $ff ; end

; ================

	; CAMPER
	db "Todd@"
	db 0 ; normal

	; party
	db 17, GEODUDE
	db 17, GEODUDE
	db 23, PSYDUCK

	db $ff ; end

; ================

	; CAMPER
	db "Todd@"
	db 0 ; normal

	; party
	db 23, GEODUDE
	db 23, GEODUDE
	db 26, PSYDUCK

	db $ff ; end

; ================

	; CAMPER
	db "John@"
	db 0 ; normal

	; party
	db 33, GRAVELER
	db 36, GRAVELER
	db 40, GOLBAT
	db 42, GOLDUCK

	db $ff ; end

; ================

	; CAMPER
	db "Jerry@"
	db 0 ; normal

	; party
	db 50, RHYDON

	db $ff ; end

; ================

	; CAMPER
	db "Spencer@"
	db 0 ; normal

	; party
	db 28, SANDSHREW
	db 29, SANDSLASH
	db 30, GOLBAT

	db $ff ; end

; ================

	; CAMPER
	db "Todd@"
	db 0 ; normal

	; party
	db 30, GRAVELER
	db 30, GRAVELER
	db 30, SLUGMA
	db 32, PSYDUCK

	db $ff ; end

; ================

	; CAMPER
	db "Todd@"
	db 1 ; moves

	; party

	db 33, GRAVELER
		db SELFDESTRUCT
		db ROCK_THROW
		db HARDEN
		db MAGNITUDE

	db 33, GRAVELER
		db SELFDESTRUCT
		db ROCK_THROW
		db HARDEN
		db MAGNITUDE

	db 36, MAGCARGO
		db ROCK_THROW
		db HARDEN
		db CALM_MIND
		db FLAMETHROWER

	db 34, GOLDUCK
		db DISABLE
		db PSYCHIC_M
		db SURF
		db CALM_MIND

	db $ff ; end

; ================

	; CAMPER
	db "Quentin@"
	db 0 ; normal

	; party
	db 30, PIDGEOTTO
	db 30, PRIMEAPE
	db 30, TAUROS

	db $ff ; end

; ================

	; CAMPER
	db "Grant@"
	db 0 ; normal

	; party
	db 21, SUNFLORA
	db 21, MARILL

	db $ff ; end

; ================
; ================================


PicnickerGroup:
; ================================
; ================

	; PICNICKER
	db "Liz@"
	db 0 ; normal

	; party
	db 9, NIDORAN_F

	db $ff ; end

; ================

	; PICNICKER
	db "Gina@"
	db 0 ; normal

	; party
	db 9, SUNKERN
	db 9, SUNKERN
	db 12, BULBASAUR

	db $ff ; end

; ================

	; PICNICKER
	db "Kim@"
	db 0 ; normal

	; party
	db 15, VULPIX

	db $ff ; end

; ================

	; PICNICKER
	db "Cindy@"
	db 0 ; normal

	; party
	db 48, NIDOQUEEN

	db $ff ; end

; ================

	; PICNICKER
	db "Hope@"
	db 0 ; normal

	; party
	db 44, FLAAFFY

	db $ff ; end

; ================

	; PICNICKER
	db "Sharon@"
	db 0 ; normal

	; party
	db 41, FURRET
	db 43, RAPIDASH

	db $ff ; end

; ================

	; PICNICKER
	db "Debra@"
	db 0 ; normal

	; party
	db 41, AZUMARILL

	db $ff ; end

; ================

	; PICNICKER
	db "Gina@"
	db 0 ; normal

	; party
	db 14, SUNKERN
	db 14, SUNKERN
	db 17, IVYSAUR

	db $ff ; end

; ================

	; PICNICKER
	db "Erin@"
	db 0 ; normal

	; party
	db 18, PONYTA
	db 16, ODDISH

	db $ff ; end

; ================

	; PICNICKER
	db "Liz@"
	db 0 ; normal

	; party
	db 15, WEEPINBELL
	db 15, NIDORINA

	db $ff ; end

; ================

	; PICNICKER
	db "Liz@"
	db 0 ; normal

	; party
	db 19, WEEPINBELL
	db 19, NIDORINO
	db 21, NIDOQUEEN

	db $ff ; end

; ================

	; PICNICKER
	db "Heidi@"
	db 0 ; normal

	; party
	db 43, SUNFLORA
	db 43, SUNFLORA

	db $ff ; end

; ================

	; PICNICKER
	db "Edna@"
	db 0 ; normal

	; party
	db 41, NIDORINA
	db 45, RAICHU

	db $ff ; end

; ================

	; PICNICKER
	db "Gina@"
	db 0 ; normal

	; party
	db 26, SUNFLORA
	db 27, SUNFLORA
	db 29, IVYSAUR

	db $ff ; end

; ================

	; PICNICKER
	db "Tiffany@"
	db 1 ; moves

	; party

	db 40, CLEFABLE
		db REFLECT
		db TRI_ATTACK
		db MINIMIZE
		db METRONOME

	db $ff ; end

; ================

	; PICNICKER
	db "Tiffany@"
	db 1 ; moves

	; party

	db 49, CLEFABLE
		db MOONLIGHT
		db TRI_ATTACK
		db MINIMIZE
		db METRONOME

	db $ff ; end

; ================

	; PICNICKER
	db "Erin@"
	db 0 ; normal

	; party
	db 32, PONYTA
	db 32, GLOOM

	db $ff ; end

; ================

	; PICNICKER
	db "Tanya@"
	db 0 ; normal

	; party
	db 49, EXEGGUTOR

	db $ff ; end

; ================

	; PICNICKER
	db "Tiffany@"
	db 1 ; moves

	; party

	db 31, CLEFAIRY
		db ENCORE
		db SING
		db TRI_ATTACK
		db MINIMIZE

	db $ff ; end

; ================

	; PICNICKER
	db "Erin@"
	db 1 ; moves

	; party

	db 36, RAPIDASH
		db DOUBLE_TEAM
		db STOMP
		db FIRE_SPIN
		db SUNNY_DAY

	db 34, RAICHU
		db SWIFT
		db MUD_SLAP
		db QUICK_ATTACK
		db THUNDERBOLT

	db 36, VILEPLUME
		db SLEEP_POWDER
		db ACID
		db MOONLIGHT
		db PETAL_DANCE

	db $ff ; end

; ================

	; PICNICKER
	db "Liz@"
	db 0 ; normal

	; party
	db 24, WEEPINBELL
	db 26, NIDORINO
	db 26, NIDOQUEEN

	db $ff ; end

; ================

	; PICNICKER
	db "Liz@"
	db 1 ; moves

	; party

	db 30, WEEPINBELL
		db SLEEP_POWDER
		db POISONPOWDER
		db STUN_SPORE
		db SLUDGE_BOMB

	db 32, NIDOKING
		db EARTHQUAKE
		db DOUBLE_KICK
		db POISON_STING
		db IRON_TAIL

	db 32, NIDOQUEEN
		db EARTHQUAKE
		db DOUBLE_KICK
		db TAIL_WHIP
		db BODY_SLAM

	db $ff ; end

; ================

	; PICNICKER
	db "Gina@"
	db 0 ; normal

	; party
	db 30, SUNFLORA
	db 31, SUNFLORA
	db 32, IVYSAUR

	db $ff ; end

; ================

	; PICNICKER
	db "Gina@"
	db 1 ; moves

	; party

	db 33, SUNFLORA
		db LEECH_SEED
		db GIGA_DRAIN
		db FLAMETHROWER
		db SUNNY_DAY

	db 34, SUNFLORA
		db GIGA_DRAIN
		db FLAMETHROWER
		db SOLAR_BEAM
		db SUNNY_DAY

	db 38, VENUSAUR
		db SOLAR_BEAM
		db RAZOR_LEAF
		db HEADBUTT
		db MUD_SLAP

	db $ff ; end

; ================

	; PICNICKER
	db "Tiffany@"
	db 1 ; moves

	; party

	db 44, CLEFAIRY
		db METRONOME
		db ENCORE
		db MOONLIGHT
		db MINIMIZE

	db $ff ; end

; ================
; ================================


TwinsGroup:
; ================================
; ================

	; TWINS
	db "Amy & Mimi@"
	db 0 ; normal

	; party
	db 10, SPINARAK
	db 10, LEDYBA

	db $ff ; end

; ================

	; TWINS
	db "Amy & Mimi@"
	db 0 ; normal

	; party
	db 10, LEDYBA
	db 10, SPINARAK

	db $ff ; end

; ================

	; TWINS
	db "Tori & Til@"
	db 1 ; moves

	; party

	db 16, MARILL
		db DEFENSE_CURL
		db ROLLOUT
		db BUBBLE_BEAM
		db DIZZY_PUNCH

	db 16, MAREEP
		db GROWL
		db THUNDER_WAVE
		db THUNDERSHOCK
		db SAND_ATTACK

	db $ff ; end

; ================

	; TWINS
	db "Tori & Til@"
	db 1 ; moves

	; party

	db 16, MAREEP
		db GROWL
		db THUNDER_WAVE
		db THUNDERSHOCK
		db SAND_ATTACK

	db 16, MARILL
		db DEFENSE_CURL
		db ROLLOUT
		db BUBBLE_BEAM
		db DIZZY_PUNCH

	db $ff ; end

; ================

	; TWINS
	db "Jo & Zoe@"
	db 0 ; normal

	; party
	db 47, VICTREEBEL
	db 47, VILEPLUME

	db $ff ; end

; ================

	; TWINS
	db "Jo & Zoe@"
	db 0 ; normal

	; party
	db 35, VILEPLUME
	db 35, VICTREEBEL

	db $ff ; end

; ================

	; TWINS
	db "Meg & Peg@"
	db 0 ; normal

	; party
	db 39, TEDDIURSA
	db 39, PHANPY

	db $ff ; end

; ================

	; TWINS
	db "Meg & Peg@"
	db 0 ; normal

	; party
	db 39, PHANPY
	db 39, TEDDIURSA

	db $ff ; end

; ================

	; TWINS
	db "Lea & Pia@"
	db 1 ; moves

	; party

	db 38, DRATINI
		db THUNDER_WAVE
		db TWISTER
		db FLAMETHROWER
		db HEADBUTT

	db 38, DRATINI
		db THUNDER_WAVE
		db TWISTER
		db ICE_BEAM
		db HEADBUTT

	db $ff ; end

; ================

	; TWINS
	db "Lea & Pia@"
	db 1 ; moves

	; party

	db 38, DRATINI
		db THUNDER_WAVE
		db TWISTER
		db ICE_BEAM
		db HEADBUTT

	db 38, DRATINI
		db THUNDER_WAVE
		db TWISTER
		db FLAMETHROWER
		db HEADBUTT

	db $ff ; end

; ================

	; TWINS
	db "Day & Dani@"
	db 0 ; normal

	; party
	db 41, PIKACHU
	db 41, PIKACHU

	db $ff ; end

; ================

	; TWINS
	db "Day & Dani@"
	db 0 ; normal

	; party
	db 41, PIKACHU
	db 41, PIKACHU

	db $ff ; end

; ================

	; TWINS
	db "Kay & Tia@"
	db 0 ; normal

	; party
	db 41, QUAGSIRE
	db 41, QUAGSIRE

	db $ff ; end

; ================

	; TWINS
	db "Kay & Tia@"
	db 0 ; normal

	; party
	db 41, QUAGSIRE
	db 41, QUAGSIRE

	db $ff ; end

; ================
; ================================


FisherGroup:
; ================================
; ================

	; FISHER
	db "Justin@"
	db 0 ; normal

	; party
	db 5, MAGIKARP
	db 5, MAGIKARP
	db 15, MAGIKARP
	db 5, MAGIKARP

	db $ff ; end

; ================

	; FISHER
	db "Ralph@"
	db 0 ; normal

	; party
	db 10, CHINCHOU

	db $ff ; end

; ================

	; FISHER
	db "Arnold@"
	db 0 ; normal

	; party
	db 44, SHELLDER

	db $ff ; end

; ================

	; FISHER
	db "Kyle@"
	db 0 ; normal

	; party
	db 39, POLIWHIRL
	db 35, QWILFISH
	db 39, GYARADOS

	db $ff ; end

; ================

	; FISHER
	db "Henry@"
	db 0 ; normal

	; party
	db 8, POLIWAG
	db 8, POLIWAG

	db $ff ; end

; ================

	; FISHER
	db "Marvin@"
	db 0 ; normal

	; party
	db 20, MAGIKARP
	db 25, MAGIKARP
	db 30, GYARADOS

	db $ff ; end

; ================

	; FISHER
	db "Tully@"
	db 0 ; normal

	; party
	db 30, QWILFISH

	db $ff ; end

; ================

	; FISHER
	db "Andre@"
	db 0 ; normal

	; party
	db 32, GYARADOS

	db $ff ; end

; ================

	; FISHER
	db "Raymond@"
	db 1 ; moves

	; party

	db 30, MAGIKARP
		db SPLASH
		db TACKLE
		db FLAIL
		db DRAGON_RAGE

	db 30, MAGIKARP
		db SPLASH
		db TACKLE
		db FLAIL
		db DRAGON_RAGE

	db 30, MAGIKARP
		db SPLASH
		db TACKLE
		db FLAIL
		db DRAGON_RAGE

	db 30, MAGIKARP
		db SPLASH
		db TACKLE
		db FLAIL
		db DRAGON_RAGE

	db $ff ; end

; ================

	; FISHER
	db "Wilton@"
	db 0 ; normal

	; party
	db 34, QWILFISH
	db 34, REMORAID
	db 36, GYARADOS

	db $ff ; end

; ================

	; FISHER
	db "Edgar@"
	db 1 ; moves

	; party

	db 36, REMORAID
		db LOCK_ON
		db PSYBEAM
		db AURORA_BEAM
		db BUBBLE_BEAM

	db 36, REMORAID
		db LOCK_ON
		db PSYBEAM
		db AURORA_BEAM
		db BUBBLE_BEAM

	db $ff ; end

; ================

	; FISHER
	db "Jonah@"
	db 0 ; normal

	; party
	db 37, SHELLDER
	db 40, OCTILLERY
	db 37, REMORAID
	db 40, CLOYSTER

	db $ff ; end

; ================

	; FISHER
	db "Martin@"
	db 0 ; normal

	; party
	db 36, REMORAID
	db 42, OCTILLERY

	db $ff ; end

; ================

	; FISHER
	db "Stephen@"
	db 0 ; normal

	; party
	db 45, MAGIKARP
	db 43, QUAGSIRE
	db 38, QWILFISH
	db 38, TENTACRUEL

	db $ff ; end

; ================

	; FISHER
	db "Barney@"
	db 0 ; normal

	; party
	db 40, GYARADOS
	db 37, GYARADOS
	db 37, GYARADOS

	db $ff ; end

; ================

	; FISHER
	db "Ralph@"
	db 0 ; normal

	; party
	db 17, CHINCHOU

	db $ff ; end

; ================

	; FISHER
	db "Ralph@"
	db 0 ; normal

	; party
	db 17, QWILFISH
	db 19, CHINCHOU

	db $ff ; end

; ================

	; FISHER
	db "Tully@"
	db 0 ; normal

	; party
	db 23, QWILFISH

	db $ff ; end

; ================

	; FISHER
	db "Tully@"
	db 0 ; normal

	; party
	db 32, POLIWHIRL
	db 32, QWILFISH
	db 32, QWILFISH

	db $ff ; end

; ================

	; FISHER
	db "Wilton@"
	db 0 ; normal

	; party
	db 32, QWILFISH
	db 32, REMORAID
	db 36, GYARADOS

	db $ff ; end

; ================

	; FISHER
	db "Scott@"
	db 0 ; normal

	; party
	db 40, QWILFISH
	db 40, QWILFISH
	db 42, GYARADOS

	db $ff ; end

; ================

	; FISHER
	db "Wilton@"
	db 1 ; moves

	; party

	db 38, QWILFISH
		db WATERFALL
		db TAKE_DOWN
		db PIN_MISSILE
		db ROLLOUT

	db 38, GYARADOS
		db WATERFALL
		db TWISTER
		db DRAGON_RAGE
		db RAIN_DANCE

	db 42, OCTILLERY
		db PSYBEAM
		db AURORA_BEAM
		db BUBBLE_BEAM
		db HYPER_BEAM

	db $ff ; end

; ================

	; FISHER
	db "Ralph@"
	db 0 ; normal

	; party
	db 30, QWILFISH
	db 32, LANTURN

	db $ff ; end

; ================

	; FISHER
	db "Ralph@"
	db 1 ; moves

	; party

	db 35, QWILFISH
		db TOXIC
		db MINIMIZE
		db SURF
		db PIN_MISSILE

	db 39, LANTURN
		db FLAIL
		db WATERFALL
		db SPARK
		db CONFUSE_RAY

	db $ff ; end

; ================

	; FISHER
	db "Tully@"
	db 1 ; moves

	; party

	db 34, POLIWRATH
		db RAIN_DANCE
		db HYPNOSIS
		db WATERFALL
		db SUBMISSION

	db 34, QWILFISH
		db ROLLOUT
		db SURF
		db PIN_MISSILE
		db TAKE_DOWN

	db 37, QWILFISH
		db ROLLOUT
		db WATERFALL
		db PIN_MISSILE
		db TAKE_DOWN

	db $ff ; end

; ================
; ================================


BirdKeeperGroup:
; ================================
; ================

	; BIRD_KEEPER
	db "Rod@"
	db 0 ; normal

	; party
	db 7, PIDGEY
	db 7, PIDGEY

	db $ff ; end

; ================

	; BIRD_KEEPER
	db "Abe@"
	db 0 ; normal

	; party
	db 9, PIDGEY

	db $ff ; end

; ================

	; BIRD_KEEPER
	db "Theo@"
	db 0 ; normal

	; party
	db 17, PIDGEY
	db 16, PIDGEY
	db 19, PIDGEY
	db 16, PIDGEY
	db 16, PIDGEY

	db $ff ; end

; ================

	; BIRD_KEEPER
	db "Toby@"
	db 0 ; normal

	; party
	db 16, DODUO
	db 17, DODUO
	db 18, DODUO

	db $ff ; end

; ================

	; BIRD_KEEPER
	db "Denis@"
	db 0 ; normal

	; party
	db 18, PIDGEY
	db 20, PIDGEOTTO
	db 18, FARFETCH_D

	db $ff ; end

; ================

	; BIRD_KEEPER
	db "Vance@"
	db 0 ; normal

	; party
	db 36, PIDGEOTTO
	db 36, PIDGEOTTO

	db $ff ; end

; ================

	; BIRD_KEEPER
	db "Hank@"
	db 0 ; normal

	; party
	db 13, PIDGEY
	db 44, PIDGEOT

	db $ff ; end

; ================

	; BIRD_KEEPER
	db "Roy@"
	db 0 ; normal

	; party
	db 38, PIDGEOTTO
	db 44, PIDGEOT

	db $ff ; end

; ================

	; BIRD_KEEPER
	db "Boris@"
	db 0 ; normal

	; party
	db 39, DODUO
	db 37, DODUO
	db 41, DODRIO

	db $ff ; end

; ================

	; BIRD_KEEPER
	db "Bob@"
	db 0 ; normal

	; party
	db 48, NOCTOWL

	db $ff ; end

; ================

	; BIRD_KEEPER
	db "Jose@"
	db 0 ; normal

	; party
	db 40, FARFETCH_D

	db $ff ; end

; ================

	; BIRD_KEEPER
	db "Peter@"
	db 0 ; normal

	; party
	db 6, PIDGEY
	db 6, PIDGEY
	db 8, HOOTHOOT

	db $ff ; end

; ================

	; BIRD_KEEPER
	db "Jose@"
	db 0 ; normal

	; party
	db 44, FARFETCH_D

	db $ff ; end

; ================

	; BIRD_KEEPER
	db "Perry@"
	db 0 ; normal

	; party
	db 42, FARFETCH_D

	db $ff ; end

; ================

	; BIRD_KEEPER
	db "Bret@"
	db 0 ; normal

	; party
	db 41, PIDGEOTTO
	db 41, FARFETCH_D

	db $ff ; end

; ================

	; BIRD_KEEPER
	db "Jose@"
	db 1 ; moves

	; party

	db 48, FARFETCH_D
		db SWORDS_DANCE
		db NIGHT_SLASH
		db PROTECT
		db FLY

	db $ff ; end

; ================

	; BIRD_KEEPER
	db "Vance@"
	db 0 ; normal

	; party
	db 32, PIDGEOTTO
	db 32, PIDGEOTTO

	db $ff ; end

; ================

	; BIRD_KEEPER
	db "Vance@"
	db 1 ; moves

	; party

	db 38, PIDGEOT
		db TOXIC
		db QUICK_ATTACK
		db WHIRLWIND
		db FLY

	db 38, PIDGEOT
		db SWIFT
		db PROTECT
		db STEEL_WING
		db FLY

	db $ff ; end

; ================
; ================================


HikerGroup:
; ================================
; ================

	; HIKER
	db "Anthony@"
	db 0 ; normal

	; party
	db 16, GEODUDE
	db 18, MACHOKE

	db $ff ; end

; ================

	; HIKER
	db "Russell@"
	db 0 ; normal

	; party
	db 4, GEODUDE
	db 6, GEODUDE
	db 8, GEODUDE

	db $ff ; end

; ================

	; HIKER
	db "Phillip@"
	db 0 ; normal

	; party
	db 23, GEODUDE
	db 23, GEODUDE
	db 25, GRAVELER

	db $ff ; end

; ================

	; HIKER
	db "Leonard@"
	db 0 ; normal

	; party
	db 23, GEODUDE
	db 25, MACHOP

	db $ff ; end

; ================

	; HIKER
	db "Anthony@"
	db 0 ; normal

	; party
	db 11, GEODUDE
	db 11, MACHOP

	db $ff ; end

; ================

	; HIKER
	db "Benjamin@"
	db 0 ; normal

	; party
	db 24, DIGLETT
	db 24, GEODUDE
	db 28, DUGTRIO

	db $ff ; end

; ================

	; HIKER
	db "Erik@"
	db 0 ; normal

	; party
	db 35, GRAVELER
	db 37, DONPHAN
	db 37, GLIGAR

	db $ff ; end

; ================

	; HIKER
	db "Michael@"
	db 0 ; normal

	; party
	db 35, GEODUDE
	db 35, GRAVELER
	db 35, GOLEM

	db $ff ; end

; ================

	; HIKER
	db "Parry@"
	db 0 ; normal

	; party
	db 36, ONIX
	db 35, PILOSWINE

	db $ff ; end

; ================

	; HIKER
	db "Timothy@"
	db 1 ; moves

	; party

	db 36, DIGLETT
		db MAGNITUDE
		db DIG
		db SAND_ATTACK
		db SLASH

	db 37, DUGTRIO
		db MAGNITUDE
		db DIG
		db SAND_ATTACK
		db SLASH

	db $ff ; end

; ================

	; HIKER
	db "Bailey@"
	db 0 ; normal

	; party
	db 15, GEODUDE
	db 15, GEODUDE
	db 15, GEODUDE
	db 15, GEODUDE
	db 15, GEODUDE

	db $ff ; end

; ================

	; HIKER
	db "Anthony@"
	db 0 ; normal

	; party
	db 25, GRAVELER
	db 27, GRAVELER
	db 29, MACHOKE

	db $ff ; end

; ================

	; HIKER
	db "Eoin@"
	db 0 ; normal

	; party
	db 42, GRAVELER
	db 42, GRAVELER
	db 42, GRAVELER

	db $ff ; end

; ================

	; HIKER
	db "Noland@"
	db 0 ; normal

	; party
	db 39, SANDSLASH
	db 42, GOLEM

	db $ff ; end

; ================

	; HIKER
	db "Clarke@"
	db 0 ; normal

	; party
	db 43, DUGTRIO
	db 45, ONIX

	db $ff ; end

; ================

	; HIKER
	db "Kenny@"
	db 0 ; normal

	; party
	db 34, SANDSLASH
	db 36, GRAVELER
	db 40, GOLEM
	db 36, GRAVELER

	db $ff ; end

; ================

	; HIKER
	db "Jim@"
	db 0 ; normal

	; party
	db 45, MACHAMP

	db $ff ; end

; ================

	; HIKER
	db "Daniel@"
	db 0 ; normal

	; party
	db 11, ONIX

	db $ff ; end

; ================

	; HIKER
	db "Parry@"
	db 1 ; moves

	; party

	db 36, PILOSWINE
		db EARTHQUAKE
		db BLIZZARD
		db REST
		db TAKE_DOWN

	db 36, DUGTRIO
		db MAGNITUDE
		db DIG
		db MUD_SLAP
		db SLASH

	db 39, STEELIX
		db DIG
		db IRON_TAIL
		db SANDSTORM
		db SLAM

	db $ff ; end

; ================

	; HIKER
	db "Parry@"
	db 0 ; normal

	; party
	db 30, ONIX

	db $ff ; end

; ================

	; HIKER
	db "Anthony@"
	db 0 ; normal

	; party
	db 30, GRAVELER
	db 30, GRAVELER
	db 32, MACHOKE

	db $ff ; end

; ================

	; HIKER
	db "Anthony@"
	db 1 ; moves

	; party

	db 34, GRAVELER
		db MAGNITUDE
		db SELFDESTRUCT
		db DEFENSE_CURL
		db ROLLOUT

	db 36, GOLEM
		db MAGNITUDE
		db SELFDESTRUCT
		db DEFENSE_CURL
		db ROLLOUT

	db 34, MACHAMP
		db KARATE_CHOP
		db VITAL_THROW
		db HEADBUTT
		db DIG

	db $ff ; end

; ================

	; HIKER
	db "Edwin@"
	db 0 ; normal

	; party
	db 50, GOLEM

	db $ff ; end

; ================

	; HIKER
	db "Devin@"
	db 0 ; normal

	; party
	db 22, DUNSPARCE
	db 22, DUNSPARCE
	db 22, DUNSPARCE

	db $ff ; end

; ================

	; HIKER
	db "Seamus@"
	db 0 ; normal

	; party
	db 42, DUNSPARCE
	db 40, ONIX
	db 41, GOLEM
	db 40, ONIX

	db $ff ; end

; ================
; ================================


GruntMGroup:
; ================================
; ================

	; unused
	; GRUNTM
	db "Grunt@"
	db 0 ; normal

	; party
	db 10, ZUBAT
	db 12, QWILFISH
	db 14, KOFFING

	db $ff ; end

; ================

	; GRUNTM
	db "Grunt@"
	db 0 ; normal

	; party
	db 7, RATTATA
	db 9, ZUBAT
	db 9, GASTLY

	db $ff ; end

; ================

	; GRUNTM
	db "Grunt@"
	db 0 ; normal

	; party
	db 33, RATICATE
	db 33, SNEASEL

	db $ff ; end

; ================

	; GRUNTM
	db "Grunt@"
	db 0 ; normal

	; party
	db 32, GRIMER
	db 33, HOUNDOUR
	db 34, MUK

	db $ff ; end

; ================

	; GRUNTM
	db "Grunt@"
	db 0 ; normal

	; party
	db 31, RATTATA
	db 33, HOUNDOUR
	db 32, RATICATE
	db 32, RATICATE
	db 33, MEOWTH

	db $ff ; end

; ================

	; GRUNTM
	db "Grunt@"
	db 0 ; normal

	; party
	db 34, GOLBAT
	db 34, VENOMOTH

	db $ff ; end

; ================

	; GRUNTM
	db "Grunt@"
	db 0 ; normal

	; party
	db 33, KOFFING
	db 33, GRIMER
	db 34, GOLBAT
	db 34, RATICATE

	db $ff ; end

; ================

	; GRUNTM
	db "Grunt@"
	db 0 ; normal

	; party
	db 36, WEEZING

	db $ff ; end

; ================

	; GRUNTM
	db "Grunt@"
	db 0 ; normal

	; party
	db 35, RATICATE
	db 36, WEEZING

	db $ff ; end

; ================

	; GRUNTM
	db "Grunt@"
	db 0 ; normal

	; party
	db 32, ZUBAT
	db 35, GOLBAT
	db 33, MUK

	db $ff ; end

; ================

	; GRUNTM
	db "Grunt@"
	db 0 ; normal

	; party
	db 34, MUK
	db 35, HAUNTER
	db 36, RATICATE

	db $ff ; end

; ================

	; GRUNTM
	db "Grunt@"
	db 0 ; normal

	; party
	db 23, RATICATE
	db 24, PERSIAN

	db $ff ; end

; ================

	; GRUNTM
	db "Grunt@"
	db 0 ; normal

	; party
	db 37, RATICATE

	db $ff ; end

; ================

	; GRUNTM
	db "Grunt@"
	db 0 ; normal

	; party
	db 35, RATICATE
	db 35, GOLBAT

	db $ff ; end

; ================

	; GRUNTM
	db "Grunt@"
	db 0 ; normal

	; party
	db 35, MUK
	db 35, WEEZING

	db $ff ; end

; ================

	; GRUNTM
	db "Grunt@"
	db 0 ; normal

	; party
	db 26, MEOWTH
	db 26, GASTLY
	db 27, RATICATE
	db 26, RATTATA

	db $ff ; end

; ================

	; GRUNTM
	db "Grunt@"
	db 0 ; normal

	; party
	db 32, GOLBAT

	db $ff ; end

; ================

	; GRUNTM
	db "Grunt@"
	db 0 ; normal

	; party
	db 27, HOUNDOUR
	db 28, GOLBAT
	db 28, RATICATE

	db $ff ; end

; ================

	; GRUNTM
	db "Grunt@"
	db 0 ; normal

	; party
	db 28, VENONAT
	db 28, VENOMOTH

	db $ff ; end

; ================

	; GRUNTM
	db "Grunt@"
	db 0 ; normal

	; party
	db 26, ZUBAT
	db 27, GRIMER
	db 28, MEOWTH

	db $ff ; end

; ================

	; GRUNTM
	db "Grunt@"
	db 0 ; normal

	; party
	db 26, DROWZEE
	db 27, ZUBAT
	db 28, HAUNTER

	db $ff ; end

; ================

	; GRUNTM
	db "Grunt@"
	db 0 ; normal

	; party
	db 23, GOLBAT
	db 23, HAUNTER
	db 23, GOLBAT

	db $ff ; end

; ================

	; GRUNTM
	db "Grunt@"
	db 0 ; normal

	; party
	db 23, KOFFING
	db 25, HOUNDOUR
	db 23, TENTACOOL

	db $ff ; end

; ================

	; GRUNTM
	db "Grunt@"
	db 0 ; normal

	; party
	db 37, HAUNTER
	db 36, WEEZING

	db $ff ; end

; ================

	; GRUNTM
	db "Grunt@"
	db 0 ; normal

	; party
	db 36, TENTACRUEL
	db 35, MUK

	db $ff ; end

; ================

	; GRUNTM
	db "Grunt@"
	db 0 ; normal

	; party
	db 23, ZUBAT
	db 24, RATICATE
	db 25, MURKROW

	db $ff ; end

; ================

	; unused
	; GRUNTM
	db "Grunt@"
	db 0 ; normal

	; party
	db 22, ZUBAT

	db $ff ; end

; ================

	; GRUNTM
	db "Grunt@"
	db 0 ; normal

	; party
	db 19, RATICATE

	db $ff ; end

; ================

	; GRUNTM
	db "Grunt@"
	db 0 ; normal

	; party
	db 9, RATTATA
	db 9, MEOWTH

	db $ff ; end

; ================

	; GRUNTM
	db "Grunt@"
	db 0 ; normal

	; party
	db 25, GOLBAT
	db 25, GOLBAT
	db 30, ARBOK

	db $ff ; end

; ================

	; GRUNTM
	db "Grunt@"
	db 0 ; normal

	; party
	db 39, GOLBAT
	db 40, WEEZING
	db 39, MUK

	db $ff ; end

; ================
; ================================


GruntFGroup:
; ================================
; ================

	; GRUNTF
	db "Grunt@"
	db 0 ; normal

	; party
	db 9, ZUBAT
	db 11, EKANS

	db $ff ; end

; ================

	; GRUNTF
	db "Grunt@"
	db 0 ; normal

	; party
	db 35, ARBOK

	db $ff ; end

; ================

	; GRUNTF
	db "Grunt@"
	db 0 ; normal

	; party
	db 36, UMBREON
	db 35, GLOOM

	db $ff ; end

; ================

	; GRUNTF
	db "Grunt@"
	db 0 ; normal

	; party
	db 33, EKANS
	db 34, ODDISH
	db 35, ARBOK
	db 36, GLOOM

	db $ff ; end

; ================

	; GRUNTF
	db "Grunt@"
	db 0 ; normal

	; party
	db 29, ARBOK
		db GLARE
		db SCREECH
		db ACID
		db CRUNCH

	db 28, QWILFISH
		db DEFENSE_CURL
		db MINIMIZE
		db BUBBLE
		db ROLLOUT

	db 28, GLOOM
		db GROWTH
		db STUN_SPORE
		db SLEEP_POWDER
		db MEGA_DRAIN

	db $ff ; end

; ================

	; GRUNTF
	db "Grunt@"
	db 0 ; normal

	; party
	db 22, EKANS
	db 23, ARBOK
	db 23, GLOOM

	db $ff ; end

; ================
; ================================


JessieJamesGroup:
; ================================
; ================

	; JESSIE_JAMES
	db "& James@"
	db 0 ; normal

	; party
	db 25, WEEZING
	db 25, ARBOK
	db 23, VICTREEBEL
	db 23, WOBBUFFET
	db 27, MEOWTH

	db $ff ; end

; ================
; ================================


PokefanMGroup:
; ================================
; ================

	; POKEFANM
	db "William@"
	db 2 ; item

	; party
	db 16, RAICHU, BERRY

	db $ff ; end

; ================

	; POKEFANM
	db "Derek@"
	db 2 ; item

	; party
	db 18, PIKACHU, BERRY

	db $ff ; end

; ================

	; POKEFANM
	db "Robert@"
	db 2 ; item

	; party
	db 43, QUAGSIRE, GOLD_BERRY

	db $ff ; end

; ================

	; POKEFANM
	db "Joshua@"
	db 2 ; item

	; party
	db 32, PIKACHU, GOLD_BERRY
	db 32, PIKACHU, GOLD_BERRY
	db 32, PIKACHU, GOLD_BERRY
	db 32, PIKACHU, GOLD_BERRY
	db 32, PIKACHU, GOLD_BERRY
	db 32, PIKACHU, GOLD_BERRY

	db $ff ; end

; ================

	; POKEFANM
	db "Carter@"
	db 2 ; item

	; party
	db 38, BULBASAUR, GOLD_BERRY
	db 38, CHARMANDER, GOLD_BERRY
	db 38, SQUIRTLE, GOLD_BERRY

	db $ff ; end

; ================

	; POKEFANM
	db "Trevor@"
	db 2 ; item

	; party
	db 42, PSYDUCK, GOLD_BERRY

	db $ff ; end

; ================

	; POKEFANM
	db "Brandon@"
	db 2 ; item

	; party
	db 13, SNUBBULL, BERRY
	db 13, MAREEP, NO_ITEM

	db $ff ; end

; ================

	; POKEFANM
	db "Jeremy@"
	db 2 ; item

	; party
	db 38, MEOWTH, GOLD_BERRY
	db 39, PERSIAN, GOLD_BERRY
	db 38, MEOWTH, GOLD_BERRY

	db $ff ; end

; ================

	; POKEFANM
	db "Colin@"
	db 2 ; item

	; party
	db 42, GLACEON, GOLD_BERRY

	db $ff ; end

; ================

	; POKEFANM
	db "Derek@"
	db 2 ; item

	; party
	db 19, PIKACHU, BERRY

	db $ff ; end

; ================

	; POKEFANM
	db "Derek@"
	db 2 ; item

	; party
	db 36, PIKACHU, GOLD_BERRY

	db $ff ; end

; ================

	; POKEFANM
	db "Alex@"
	db 2 ; item

	; party
	db 36, NIDOKING, KINGS_ROCK
	db 36, SLOWKING, KINGS_ROCK
	db 36, KINGLER, KINGS_ROCK

	db $ff ; end

; ================

	; POKEFANM
	db "Rex@"
	db 2 ; item

	; party
	db 43, PHANPY, GOLD_BERRY

	db $ff ; end

; ================

	; POKEFANM
	db "Allan@"
	db 2 ; item

	; party
	db 43, TEDDIURSA, GOLD_BERRY

	db $ff ; end

; ================
; ================================


PokefanFGroup:
; ================================
; ================

	; POKEFANF
	db "Beverly@"
	db 2 ; item

	; party
	db 16, SNUBBULL, BERRY

	db $ff ; end

; ================

	; POKEFANF
	db "Ruth@"
	db 2 ; item

	; party
	db 20, PIKACHU, BERRY

	db $ff ; end

; ================

	; POKEFANF
	db "Beverly@"
	db 2 ; item

	; party
	db 18, SNUBBULL, BERRY

	db $ff ; end

; ================

	; POKEFANF
	db "Beverly@"
	db 2 ; item

	; party
	db 30, GRANBULL, GOLD_BERRY

	db $ff ; end

; ================

	; POKEFANF
	db "Georgia@"
	db 2 ; item

	; party
	db 37, SENTRET, BERRY
	db 37, SENTRET, BERRY
	db 37, SENTRET, BERRY
	db 38, FURRET, GOLD_BERRY
	db 37, SENTRET, BERRY

	db $ff ; end

; ================

	; POKEFANF
	db "Jaime@"
	db 2 ; item

	; party
	db 16, MEOWTH, BERRY

	db $ff ; end

; ================

	; POKEFANF
	db "Boone@"
	db 2 ; item

	; party
	db 43, PERSIAN, GOLD_BERRY
	db 41, WIGGLYTUFF, GOLD_BERRY

	db $ff ; end

; ================

	; POKEFANF
	db "Eleanor@"
	db 2 ; item

	; party
	db 43, GRANBULL, GOLD_BERRY
	db 41, CLEFABLE, GOLD_BERRY

	db $ff ; end

; ================
; ================================


OfficerMGroup:
; ================================
; ================

	; OFFICERM
	db "Keith@"
	db 0 ; normal

	; party
	db 30, GROWLITHE

	db $ff ; end

; ================

	; OFFICERM
	db "Dirk@"
	db 0 ; normal

	; party
	db 14, GROWLITHE
	db 14, MACHOP

	db $ff ; end

; ================
; ================================


OfficerFGroup:
; ================================
; ================

	; OFFICERF
	db "Jenny@"
	db 0 ; normal

	; party
	db 47, ARCANINE
	db 46, ARCANINE
	db 46, BLASTOISE

	db $ff ; end

; ================

	; OFFICERF
	db "Mara@"
	db 0 ; normal

	; party
	db 17, GROWLITHE

	db $ff ; end

; ================
; ================================


PokemaniacGroup:
; ================================
; ================

	; POKEMANIAC
	db "Larry@"
	db 0 ; normal

	; party
	db 11, SLOWPOKE

	db $ff ; end

; ================

	; POKEMANIAC
	db "Andrew@"
	db 0 ; normal

	; party
	db 24, MAROWAK
	db 24, MAROWAK

	db $ff ; end

; ================

	; POKEMANIAC
	db "Calvin@"
	db 0 ; normal

	; party
	db 26, KANGASKHAN

	db $ff ; end

; ================

	; POKEMANIAC
	db "Shane@"
	db 0 ; normal

	; party
	db 27, NIDORINA
	db 27, NIDORINO

	db $ff ; end

; ================

	; POKEMANIAC
	db "Beckett@"
	db 0 ; normal

	; party
	db 30, SLOWBRO

	db $ff ; end

; ================

	; POKEMANIAC
	db "Brent@"
	db 0 ; normal

	; party
	db 32, MAROWAK

	db $ff ; end

; ================

	; POKEMANIAC
	db "Ron@"
	db 0 ; normal

	; party
	db 30, NIDOKING

	db $ff ; end

; ================

	; POKEMANIAC
	db "Ethan@"
	db 0 ; normal

	; party
	db 39, RHYHORN
	db 40, RHYDON

	db $ff ; end

; ================

	; POKEMANIAC
	db "Brent@"
	db 0 ; normal

	; party
	db 28, KANGASKHAN

	db $ff ; end

; ================

	; POKEMANIAC
	db "Brent@"
	db 1 ; moves

	; party

	db 39, PORYGON
		db RECOVER
		db PSYCHIC_M
		db CONVERSION2
		db TRI_ATTACK

	db $ff ; end

; ================

	; POKEMANIAC
	db "Issac@"
	db 0 ; normal

	; party
	db 12, SLOWPOKE

	db $ff ; end

; ================

	; POKEMANIAC
	db "Donald@"
	db 0 ; normal

	; party
	db 11, SLOWPOKE
	db 11, NIDORAN_M

	db $ff ; end

; ================

	; POKEMANIAC
	db "Zach@"
	db 0 ; normal

	; party
	db 37, RHYHORN

	db $ff ; end

; ================

	; POKEMANIAC
	db "Brent@"
	db 1 ; moves

	; party

	db 44, CHANSEY
		db ROLLOUT
		db ATTRACT
		db EGG_BOMB
		db SOFTBOILED

	db $ff ; end

; ================

	; POKEMANIAC
	db "Miller@"
	db 0 ; normal

	; party
	db 28, NIDOKING
	db 28, NIDOQUEEN

	db $ff ; end

; ================

	; POKEMANIAC
	db "Moe@"
	db 0 ; normal

	; party
	db 43, GLOOM
	db 43, WEEPINBELL

	db $ff ; end

; ================

	; POKEMANIAC
	db "Aidan@"
	db 1 ; moves

	; party

	db 36, SNORLAX
		db HEADBUTT
		db DEFENSE_CURL
		db ROLLOUT
		db SELFDESTRUCT

	db 36, PORYGON2
		db CONVERSION
		db RECOVER
		db PSYBEAM
		db TRI_ATTACK

	db $ff ; end

; ================
; ================================


SuperNerdGroup:
; ================================
; ================

	; SUPER_NERD
	db "Stan@"
	db 0 ; normal

	; party
	db 20, GRIMER

	db $ff ; end

; ================

	; SUPER_NERD
	db "Eric@"
	db 0 ; normal

	; party
	db 11, GRIMER
	db 11, GRIMER

	db $ff ; end

; ================

	; SUPER_NERD
	db "Sam@"
	db 0 ; normal

	; party
	db 44, GRIMER
	db 44, MUK

	db $ff ; end

; ================

	; SUPER_NERD
	db "Tyrone@"
	db 0 ; normal

	; party
	db 40, MAGNEMITE
	db 40, MAGNEMITE
	db 40, MAGNEMITE

	db $ff ; end

; ================

	; SUPER_NERD
	db "Pat@"
	db 0 ; normal

	; party
	db 47, PORYGON

	db $ff ; end

; ================

	; SUPER_NERD
	db "Shawn@"
	db 0 ; normal

	; party
	db 37, MAGNEMITE
	db 41, MUK
	db 37, MAGNEMITE

	db $ff ; end

; ================

	; SUPER_NERD
	db "Teru@"
	db 0 ; normal

	; party
	db 7, MAGNEMITE
	db 11, VOLTORB
	db 7, MAGNEMITE
	db 9, MAGNEMITE

	db $ff ; end

; ================

	; SUPER_NERD
	db "Hugh@"
	db 1 ; moves

	; party

	db 39, SEADRA
		db SMOKESCREEN
		db TWISTER
		db SURF
		db WATERFALL

	db $ff ; end

; ================

	; SUPER_NERD
	db "Markus@"
	db 1 ; moves

	; party

	db 30, SLOWBRO
		db CONFUSION
		db HEADBUTT
		db BUBBLE_BEAM
		db STRENGTH

	db $ff ; end

; ================

	; SUPER_NERD
	db "Cary@"
	db 0 ; normal

	; party
	db 53, FLAREON

	db $ff ; end

; ================

	; SUPER_NERD
	db "Waldo@"
	db 0 ; normal

	; party
	db 53, CHARIZARD

	db $ff ; end

; ================

	; SUPER_NERD
	db "Merle@"
	db 0 ; normal

	; party
	db 53, MAGCARGO

	db $ff ; end

; ================

	; SUPER_NERD
	db "Luis@"
	db 0 ; normal

	; party
	db 48, MAGMAR
	db 50, WEEZING
	db 48, MAGMAR

	db $ff ; end

; ================
; ================================


LassGroup:
; ================================
; ================

	; LASS
	db "Carrie@"
	db 1 ; moves

	; party

	db 18, SNUBBULL
		db SCARY_FACE
		db CHARM
		db BITE
		db LICK

	db $ff ; end

; ================

	; LASS
	db "Cathy@"
	db 0 ; normal

	; party
	db 15, JIGGLYPUFF
	db 15, JIGGLYPUFF
	db 15, JIGGLYPUFF

	db $ff ; end

; ================

	; LASS
	db "Alice@"
	db 0 ; normal

	; party
	db 41, GLOOM
	db 45, ARBOK
	db 41, GLOOM

	db $ff ; end

; ================

	; LASS
	db "Krise@"
	db 0 ; normal

	; party
	db 14, ODDISH
	db 17, CUBONE

	db $ff ; end

; ================

	; LASS
	db "Connie@"
	db 0 ; normal

	; party
	db 21, MARILL

	db $ff ; end

; ================

	; LASS
	db "Linda@"
	db 0 ; normal

	; party
	db 41, BULBASAUR
	db 43, IVYSAUR
	db 45, VENUSAUR

	db $ff ; end

; ================

	; LASS
	db "Laura@"
	db 2 ; item

	; party
	db 38, GLOOM, GOLD_BERRY
	db 41, PIDGEOTTO, NO_ITEM
	db 41, BELLOSSOM, NO_ITEM

	db $ff ; end

; ================

	; LASS
	db "Shannon@"
	db 0 ; normal

	; party
	db 38, PARAS
	db 38, PARAS
	db 42, PARASECT

	db $ff ; end

; ================

	; LASS
	db "Michelle@"
	db 0 ; normal

	; party
	db 44, LEAFEON
	db 45, TANGELA
	db 46, SUNFLORA

	db $ff ; end

; ================

	; LASS
	db "Dana@"
	db 1 ; moves

	; party

	db 19, FLAAFFY
		db TACKLE
		db GROWL
		db THUNDERSHOCK
		db THUNDER_WAVE

	db 19, PSYDUCK
		db SCRATCH
		db TAIL_WHIP
		db DISABLE
		db CONFUSION

	db $ff ; end

; ================

	; LASS
	db "Ellen@"
	db 0 ; normal

	; party
	db 40, WIGGLYTUFF
	db 44, GRANBULL

	db $ff ; end

; ================

	; LASS
	db "Connie@"
	db 0 ; normal

	; party
	db 21, MARILL

	db $ff ; end

; ================

	; LASS
	db "Connie@"
	db 0 ; normal

	; party
	db 21, MARILL

	db $ff ; end

; ================

	; LASS
	db "Dana@"
	db 1 ; moves

	; party

	db 21, FLAAFFY
		db TACKLE
		db GROWL
		db THUNDERSHOCK
		db THUNDER_WAVE

	db 21, PSYDUCK
		db SCRATCH
		db TAIL_WHIP
		db DISABLE
		db CONFUSION

	db $ff ; end

; ================

	; LASS
	db "Dana@"
	db 1 ; moves

	; party

	db 29, PSYDUCK
		db SCRATCH
		db DISABLE
		db CONFUSION
		db SCREECH

	db 29, AMPHAROS
		db TACKLE
		db THUNDERSHOCK
		db THUNDER_WAVE
		db THUNDERBOLT

	db $ff ; end

; ================

	; LASS
	db "Dana@"
	db 1 ; moves

	; party

	db 32, PSYDUCK
		db SCRATCH
		db DISABLE
		db CONFUSION
		db SCREECH

	db 32, AMPHAROS
		db TACKLE
		db THUNDERPUNCH
		db THUNDER_WAVE
		db THUNDERBOLT

	db $ff ; end

; ================

	; LASS
	db "Dana@"
	db 1 ; moves

	; party

	db 36, AMPHAROS
		db SWIFT
		db THUNDERPUNCH
		db THUNDER_WAVE
		db THUNDERBOLT

	db 36, GOLDUCK
		db DISABLE
		db SURF
		db PSYCHIC_M
		db SCREECH

	db $ff ; end

; ================
; ================================


BeautyGroup:
; ================================
; ================

	; BEAUTY
	db "Victoria@"
	db 0 ; normal

	; party
	db 9, SENTRET
	db 13, SENTRET
	db 17, SENTRET

	db $ff ; end

; ================

	; BEAUTY
	db "Samantha@"
	db 1 ; moves

	; party

	db 16, MEOWTH
		db SCRATCH
		db GROWL
		db BITE
		db PAY_DAY

	db 16, MEOWTH
		db SCRATCH
		db GROWL
		db BITE
		db SLASH

	db $ff ; end

; ================

	; BEAUTY
	db "Cassie@"
	db 0 ; normal

	; party
	db 41, VILEPLUME
	db 43, BUTTERFREE

	db $ff ; end

; ================

	; BEAUTY
	db "Julia@"
	db 0 ; normal

	; party
	db 44, PARAS
	db 44, EXEGGCUTE
	db 47, PARASECT

	db $ff ; end

; ================

	; BEAUTY
	db "Valencia@"
	db 0 ; normal

	; party
	db 18, SUNKERN
	db 18, SUNFLORA
	db 18, SUNFLORA

	db $ff ; end

; ================

	; BEAUTY
	db "Olivia@"
	db 0 ; normal

	; party
	db 19, CORSOLA

	db $ff ; end

; ================

	; BEAUTY
	db "Callie@"
	db 0 ; normal

	; party
	db 16, CLEFABLE
	db 16, WIGGLYTUFF

	db $ff ; end

; ================

	; BEAUTY
	db "Cassandra@"
	db 0 ; normal

	; party
	db 16, CLEFABLE
	db 16, WIGGLYTUFF

	db $ff ; end

; ================

	; BEAUTY
	db "Charlotte@"
	db 0 ; normal

	; party
	db 20, BELLOSSOM

	db $ff ; end

; ================
; ================================


FirebreatherGroup:
; ================================
; ================

	; FIREBREATHER
	db "Otis@"
	db 0 ; normal

	; party
	db 43, MAGMAR
	db 40, WEEZING
	db 47, MAGMAR

	db $ff ; end

; ================

	; FIREBREATHER
	db "Dick@"
	db 0 ; normal

	; party
	db 36, CHARMANDER
	db 40, CHARMELEON
	db 44, CHARIZARD

	db $ff ; end

; ================

	; FIREBREATHER
	db "Ned@"
	db 0 ; normal

	; party
	db 16, KOFFING
	db 17, GROWLITHE
	db 16, KOFFING

	db $ff ; end

; ================

	; FIREBREATHER
	db "Burt@"
	db 0 ; normal

	; party
	db 42, WEEZING
	db 45, MAGCARGO

	db $ff ; end

; ================

	; FIREBREATHER
	db "Bill@"
	db 0 ; normal

	; party
	db 6, KOFFING
	db 6, KOFFING

	db $ff ; end

; ================

	; FIREBREATHER
	db "Walt@"
	db 0 ; normal

	; party
	db 11, MAGMAR
	db 16, MAGMAR

	db $ff ; end

; ================

	; FIREBREATHER
	db "Ray@"
	db 0 ; normal

	; party
	db 9, VULPIX

	db $ff ; end

; ================

	; FIREBREATHER
	db "Lyle@"
	db 0 ; normal

	; party
	db 38, KOFFING
	db 40, FLAREON
	db 38, WEEZING

	db $ff ; end

; ================
; ================================


JugglerGroup:
; ================================
; ================

	; JUGGLER
	db "Irwin@"
	db 0 ; normal

	; party
	db 2, VOLTORB
	db 6, VOLTORB
	db 10, VOLTORB
	db 14, VOLTORB

	db $ff ; end

; ================

	; JUGGLER
	db "Fritz@"
	db 0 ; normal

	; party
	db 37, MR__MIME
	db 37, MAGMAR
	db 37, MACHOKE

	db $ff ; end

; ================

	; JUGGLER
	db "Horton@"
	db 0 ; normal

	; party
	db 43, ELECTRODE
	db 43, ELECTRODE
	db 43, ELECTRODE

	db $ff ; end

; ================

	; JUGGLER
	db "Irwin@"
	db 0 ; normal

	; party
	db 6, VOLTORB
	db 10, VOLTORB
	db 14, VOLTORB
	db 18, VOLTORB

	db $ff ; end

; ================

	; JUGGLER
	db "Irwin@"
	db 0 ; normal

	; party
	db 18, VOLTORB
	db 22, VOLTORB
	db 26, VOLTORB
	db 30, ELECTRODE

	db $ff ; end

; ================

	; JUGGLER
	db "Irwin@"
	db 0 ; normal

	; party
	db 18, VOLTORB
	db 22, VOLTORB
	db 26, VOLTORB
	db 30, ELECTRODE

	db $ff ; end

; ================
; ================================


SchoolboyGroup:
; ================================
; ================

	; SCHOOLBOY
	db "Jack@"
	db 0 ; normal

	; party
	db 12, ODDISH
	db 15, VOLTORB

	db $ff ; end

; ================

	; SCHOOLBOY
	db "Kipp@"
	db 0 ; normal

	; party
	db 36, VOLTORB
	db 40, VOLTORB
	db 36, MAGNEMITE
	db 40, MAGNETON

	db $ff ; end

; ================

	; SCHOOLBOY
	db "Alan@"
	db 0 ; normal

	; party
	db 17, TANGELA

	db $ff ; end

; ================

	; SCHOOLBOY
	db "Johnny@"
	db 2 ; item

	; party
	db 18, BELLSPROUT, GOLD_LEAF
	db 16, SPINARAK, NO_ITEM
	db 17, RATTATA, BERRY

	db $ff ; end

; ================

	; SCHOOLBOY
	db "Danny@"
	db 0 ; normal

	; party
	db 43, JYNX
	db 43, ELECTABUZZ
	db 43, MAGMAR

	db $ff ; end

; ================

	; SCHOOLBOY
	db "Tommy@"
	db 0 ; normal

	; party
	db 41, XATU
	db 43, ALAKAZAM

	db $ff ; end

; ================

	; SCHOOLBOY
	db "Dudley@"
	db 2 ; item

	; party
	db 45, ODDISH, GOLD_BERRY

	db $ff ; end

; ================

	; SCHOOLBOY
	db "Joe@"
	db 2 ; item

	; party
	db 44, TANGROWTH, GOLD_BERRY
	db 44, VAPOREON, NO_ITEM

	db $ff ; end

; ================

	; SCHOOLBOY
	db "Billy@"
	db 0 ; normal

	; party
	db 37, PARAS
	db 39, PARASECT
	db 37, POLIWHIRL
	db 35, DITTO

	db $ff ; end

; ================

	; SCHOOLBOY
	db "Chad@"
	db 0 ; normal

	; party
	db 20, MR__MIME

	db $ff ; end

; ================

	; SCHOOLBOY
	db "Nate@"
	db 0 ; normal

	; party
	db 40, LEDIAN
	db 42, EXEGGUTOR

	db $ff ; end

; ================

	; SCHOOLBOY
	db "Ricky@"
	db 0 ; normal

	; party
	db 38, GIRAFARIG
	db 40, DITTO

	db $ff ; end

; ================

	; SCHOOLBOY
	db "Jack@"
	db 0 ; normal

	; party
	db 14, ODDISH
	db 17, VOLTORB

	db $ff ; end

; ================

	; SCHOOLBOY
	db "Jack@"
	db 0 ; normal

	; party
	db 28, GLOOM
	db 31, ELECTRODE

	db $ff ; end

; ================

	; SCHOOLBOY
	db "Alan@"
	db 0 ; normal

	; party
	db 17, TANGELA
	db 17, YANMA

	db $ff ; end

; ================

	; SCHOOLBOY
	db "Alan@"
	db 0 ; normal

	; party
	db 20, NATU
	db 22, TANGELA
	db 20, QUAGSIRE
	db 25, YANMA

	db $ff ; end

; ================

	; SCHOOLBOY
	db "Chad@"
	db 0 ; normal

	; party
	db 19, MR__MIME
	db 19, MAGNEMITE

	db $ff ; end

; ================

	; SCHOOLBOY
	db "Chad@"
	db 0 ; normal

	; party
	db 27, MR__MIME
	db 31, MAGNETON

	db $ff ; end

; ================

	; SCHOOLBOY
	db "Jack@"
	db 0 ; normal

	; party
	db 30, GLOOM
	db 33, GROWLITHE
	db 33, ELECTRODE

	db $ff ; end

; ================

	; SCHOOLBOY
	db "Jack@"
	db 1 ; moves

	; party

	db 35, ELECTRODE
		db SCREECH
		db SONIC_BOOM
		db ROLLOUT
		db LIGHT_SCREEN

	db 35, GROWLITHE
		db SUNNY_DAY
		db LEER
		db TAKE_DOWN
		db FLAME_WHEEL

	db 37, VILEPLUME
		db SOLAR_BEAM
		db SLEEP_POWDER
		db ACID
		db MOONLIGHT

	db $ff ; end

; ================

	; SCHOOLBOY
	db "Alan@"
	db 0 ; normal

	; party
	db 27, NATU
	db 27, TANGELA
	db 30, QUAGSIRE
	db 30, YANMA

	db $ff ; end

; ================

	; SCHOOLBOY
	db "Alan@"
	db 1 ; moves

	; party

	db 35, XATU
		db PECK
		db NIGHT_SHADE
		db SWIFT
		db FUTURE_SIGHT

	db 38, TANGROWTH
		db ANCIENTPOWER
		db POISONPOWDER
		db VINE_WHIP
		db MEGA_DRAIN

	db 37, YANMEGA
		db ANCIENTPOWER
		db QUICK_ATTACK
		db DOUBLE_TEAM
		db SONIC_BOOM

	db 35, QUAGSIRE
		db TAIL_WHIP
		db SLAM
		db CALM_MIND
		db EARTHQUAKE

	db $ff ; end

; ================

	; SCHOOLBOY
	db "Chad@"
	db 0 ; normal

	; party
	db 30, MR__MIME
	db 34, MAGNETON

	db $ff ; end

; ================

	; SCHOOLBOY
	db "Chad@"
	db 1 ; moves

	; party

	db 34, MR__MIME
		db PSYCHIC_M
		db LIGHT_SCREEN
		db REFLECT
		db ENCORE

	db 38, MAGNETON
		db ZAP_CANNON
		db THUNDER_WAVE
		db LOCK_ON
		db SWIFT

	db $ff ; end

; ================

	; SCHOOLBOY
	db "Sherman@"
	db 0 ; normal

	; party
	db 43, FURRET
	db 43, PIDGEOT

	db $ff ; end

; ================
; ================================


SchoolgirlGroup:
; ================================
; ================

	; SCHOOLGIRL
	db "Audrey@"
	db 0 ; normal

	; party
	db 6, VULPIX
	db 5, MAREEP
	db 7, TEDDIURSA

	db $ff ; end

; ================

	; SCHOOLGIRL
	db "Eliza@"
	db 2 ; item

	; party
	db 18, ODDISH, SILVER_LEAF
	db 16, LEDYBA, NO_ITEM
	db 17, SENTRET, BERRY

	db $ff ; end

; ================

	; SCHOOLGIRL
	db "Faith@"
	db 0 ; normal

	; party
	db 39, BELLSPROUT
	db 40, WEEPINBELL
	db 42, VICTREEBEL

	db $ff ; end

; ================

	; SCHOOLGIRL
	db "Sarah@"
	db 0 ; normal

	; party
	db 25, CHARMANDER
	db 23, SENTRET
	db 24, MARILL

	db $ff ; end

; ================

	; SCHOOLGIRL
	db "Isabel@"
	db 0 ; normal

	; party
	db 25, SQUIRTLE
	db 23, PIDGEY
	db 24, PIKACHU

	db $ff ; end

; ================

	; SCHOOLGIRL
	db "Imogen@"
	db 0 ; normal

	; party
	db 10, BULBASAUR
	db 9, SANDSHREW
	db 9, POLIWAG

	db $ff ; end

; ================
; ================================


PsychicGroup:
; ================================
; ================

	; PSYCHIC_T
	db "Nathan@"
	db 0 ; normal

	; party
	db 26, GIRAFARIG

	db $ff ; end

; ================

	; PSYCHIC_T
	db "Franklin@"
	db 0 ; normal

	; party
	db 44, KADABRA
	db 47, GIRAFARIG

	db $ff ; end

; ================

	; PSYCHIC_T
	db "Herman@"
	db 0 ; normal

	; party
	db 39, EXEGGCUTE
	db 39, EXEGGCUTE
	db 39, EXEGGUTOR

	db $ff ; end

; ================

	; PSYCHIC_T
	db "Fidel@"
	db 0 ; normal

	; party
	db 43, XATU

	db $ff ; end

; ================

	; PSYCHIC_T
	db "Greg@"
	db 1 ; moves

	; party

	db 17, DROWZEE
		db HYPNOSIS
		db DISABLE
		db DREAM_EATER
		db 0

	db $ff ; end

; ================

	; PSYCHIC_T
	db "Norman@"
	db 1 ; moves

	; party

	db 17, SLOWPOKE
		db TACKLE
		db GROWL
		db WATER_GUN
		db 0

	db 20, SLOWPOKE
		db CURSE
		db BODY_SLAM
		db WATER_GUN
		db CONFUSION

	db $ff ; end

; ================

	; PSYCHIC_T
	db "Mark@"
	db 1 ; moves

	; party

	db 14, ABRA
		db TELEPORT
		db FLASH
		db 0
		db 0

	db 14, ABRA
		db TELEPORT
		db FLASH
		db 0
		db 0

	db 16, KADABRA
		db TELEPORT
		db CALM_MIND
		db CONFUSION
		db 0

	db $ff ; end

; ================

	; PSYCHIC_T
	db "Phil@"
	db 0 ; normal

	; party
	db 35, XATU
	db 36, KADABRA

	db $ff ; end

; ================

	; PSYCHIC_T
	db "Vernon@"
	db 0 ; normal

	; party
	db 44, ESPEON

	db $ff ; end

; ================

	; PSYCHIC_T
	db "Gilbert@"
	db 0 ; normal

	; party
	db 38, STARMIE
	db 36, EXEGGCUTE
	db 40, GIRAFARIG

	db $ff ; end

; ================

	; PSYCHIC_T
	db "Jared@"
	db 0 ; normal

	; party
	db 44, MR__MIME
	db 46, EXEGGCUTE
	db 46, EXEGGCUTE

	db $ff ; end

; ================

	; PSYCHIC_T
	db "Rodney@"
	db 0 ; normal

	; party
	db 39, DROWZEE
	db 41, HYPNO

	db $ff ; end

; ================

	; PSYCHIC_T
	db "Leon@"
	db 0 ; normal

	; party
	db 45, NOCTOWL
	db 46, HYPNO
	db 44, GIRAFARIG

	db $ff ; end

; ================
; ================================


HexManiacGroup:
; ================================
; ================

	; HEX_MANIAC
	db "Tamara@"
	db 0 ; normal

	; party
	db 16, GASTLY
	db 18, MISDREAVUS

	db $ff ; end

; ================

	; HEX_MANIAC
	db "Ashley@"
	db 0 ; normal

	; party
	db 35, HAUNTER
	db 36, MISMAGIUS

	db $ff ; end

; ================

	; HEX_MANIAC
	db "Amy@"
	db 0 ; normal

	; party
	db 42, MISDREAVUS
	db 44, GENGAR
	db 42, HAUNTER
	db 44, MISMAGIUS

	db $ff ; end

; ================

	; HEX_MANIAC
	db "Luna@"
	db 1 ; moves

	; party

	db 45, KADABRA
		db BATON_PASS
		db PSYCHIC_M
		db CONFUSE_RAY
		db FUTURE_SIGHT

	db 47, NINETALES
		db FLAMETHROWER
		db CONFUSE_RAY
		db PSYCHIC_M
		db SHADOW_BALL

	db $ff ; end

; ================

	; HEX_MANIAC
	db "Natalie@"
	db 0 ; normal

	; party
	db 45, DROWZEE
	db 45, DROWZEE
	db 47, HYPNO

	db $ff ; end

; ================

	; HEX_MANIAC
	db "Vivian@"
	db 0 ; normal

	; party
	db 39, HAUNTER
	db 38, HAUNTER
	db 39, HAUNTER
	db 42, ALAKAZAM

	db $ff ; end

; ================
; ================================


SageGroup:
; ================================
; ================

	; SAGE
	db "Chow@"
	db 0 ; normal

	; party
	db 3, BELLSPROUT
	db 3, BELLSPROUT
	db 3, BELLSPROUT

	db $ff ; end

; ================

	; SAGE
	db "Nico@"
	db 0 ; normal

	; party
	db 3, BELLSPROUT
	db 3, BELLSPROUT
	db 3, BELLSPROUT

	db $ff ; end

; ================

	; SAGE
	db "Jin@"
	db 0 ; normal

	; party
	db 6, BELLSPROUT

	db $ff ; end

; ================

	; SAGE
	db "Troy@"
	db 0 ; normal

	; party
	db 7, BELLSPROUT
	db 7, HOOTHOOT

	db $ff ; end

; ================

	; SAGE
	db "Jeffrey@"
	db 0 ; normal

	; party
	db 22, HAUNTER
	db 20, VULPIX

	db $ff ; end

; ================

	; SAGE
	db "Ping@"
	db 0 ; normal

	; party
	db 17, GASTLY
	db 17, HOOTHOOT
	db 18, VULPIX
	db 17, GASTLY
	db 18, NOCTOWL

	db $ff ; end

; ================

	; SAGE
	db "Edmond@"
	db 0 ; normal

	; party
	db 3, BELLSPROUT
	db 3, BELLSPROUT
	db 3, BELLSPROUT

	db $ff ; end

; ================

	; SAGE
	db "Neal@"
	db 0 ; normal

	; party
	db 6, BELLSPROUT

	db $ff ; end

; ================
; ================================


MediumGroup:
; ================================
; ================

	; MEDIUM
	db "Martha@"
	db 0 ; normal

	; party
	db 18, GASTLY
	db 20, HAUNTER
	db 20, MISDREAVUS

	db $ff ; end

; ================

	; MEDIUM
	db "Grace@"
	db 0 ; normal

	; party
	db 20, HAUNTER
	db 20, MISDREAVUS

	db $ff ; end

; ================

	; MEDIUM
	db "Rebecca@"
	db 0 ; normal

	; party
	db 45, DROWZEE
	db 45, HYPNO

	db $ff ; end

; ================

	; MEDIUM
	db "Doris@"
	db 0 ; normal

	; party
	db 44, SLOWPOKE
	db 46, SLOWBRO

	db $ff ; end

; ================
; ================================


KimonoGirlGroup:
; ================================
; ================

	; KIMONO_GIRL
	db "Naoko@"
	db 0 ; normal

	; party
	db 20, FLAREON

	db $ff ; end

; ================

	; KIMONO_GIRL
	db "Sayo@"
	db 0 ; normal

	; party
	db 20, ESPEON

	db $ff ; end

; ================

	; KIMONO_GIRL
	db "Zuki@"
	db 0 ; normal

	; party
	db 20, UMBREON

	db $ff ; end

; ================

	; KIMONO_GIRL
	db "Kuni@"
	db 0 ; normal

	; party
	db 20, VAPOREON

	db $ff ; end

; ================

	; KIMONO_GIRL
	db "Miki@"
	db 0 ; normal

	; party
	db 20, JOLTEON

	db $ff ; end

; ================
; ================================


ElderGroup:
; ================================
; ================

	; ELDER
	db "Li@"
	db 0 ; normal

	; party
	db 7, BELLSPROUT
	db 7, BELLSPROUT
	db 10, HOOTHOOT

	db $ff ; end

; ================

	; ELDER
	db "Gaku@"
	db 0 ; normal

	; party
	db 37, NOCTOWL
	db 38, FLAREON
	db 38, WEEPINBELL

	db $ff ; end

; ================

	; ELDER
	db "Masa@"
	db 0 ; normal

	; party
	db 37, NOCTOWL
	db 38, JOLTEON
	db 38, WARTORTLE

	db $ff ; end

; ================

	; ELDER
	db "Koji@"
	db 0 ; normal

	; party
	db 37, NOCTOWL
	db 38, VAPOREON
	db 38, NINETALES

	db $ff ; end

; ================
; ================================


SrAndJrGroup:
; ================================
; ================
; ================
; ================================


CoupleGroup:
; ================================
; ================

	; COUPLE
	db "Gail & Eli@"
	db 0 ; normal

	; party
	db 13, SANDSHREW
	db 15, MARILL
	db 15, PIKACHU
	db 13, POLIWAG

	db $ff ; end

; ================

	; COUPLE
	db "Gail & Eli@"
	db 0 ; normal

	; party
	db 15, PIKACHU
	db 13, POLIWAG
	db 13, SANDSHREW
	db 15, MARILL

	db $ff ; end

; ================

	; COUPLE
	db "Duff & Eda@"
	db 0 ; normal

	; party
	db 25, CLOYSTER
	db 25, ONIX

	db $ff ; end

; ================

	; COUPLE
	db "Duff & Eda@"
	db 0 ; normal

	; party
	db 25, ONIX
	db 25, CLOYSTER

	db $ff ; end

; ================
; ================================


GentlemanGroup:
; ================================
; ================

	; GENTLEMAN
	db "Preston@"
	db 0 ; normal

	; party
	db 18, GROWLITHE
	db 18, GROWLITHE

	db $ff ; end

; ================

	; GENTLEMAN
	db "Edward@"
	db 0 ; normal

	; party
	db 43, PERSIAN

	db $ff ; end

; ================

	; GENTLEMAN
	db "Gregory@"
	db 0 ; normal

	; party
	db 46, PIKACHU
	db 43, FLAAFFY
	db 43, CHINCHOU

	db $ff ; end

; ================

	; GENTLEMAN
	db "Alfred@"
	db 0 ; normal

	; party
	db 22, NOCTOWL

	db $ff ; end

; ================

	; GENTLEMAN
	db "Milton@"
	db 0 ; normal

	; party
	db 45, GROWLITHE

	db $ff ; end

; ================
; ================================


RichBoyGroup:
; ================================
; ================

	; RICH_BOY
	db "Winston@"
	db 0 ; normal

	; party
	db 40, PIDGEOT
	db 37, FURRET
	db 38, AMPHAROS

	db $ff ; end

; ================

	; RICH_BOY
	db "Gerald@"
	db 2 ; item

	; party
	db 42, AZUMARILL, NUGGET
	db 40, BLISSEY, NUGGET

	db $ff ; end

; ================

	; RICH_BOY
	db "Irving@"
	db 2 ; item

	; party
	db 10, CLEFAIRY, NUGGET
	db 12, FURRET, NUGGET

	db $ff ; end

; ================
; ================================


BreederGroup:
; ================================
; ================

	; BREEDER
	db "Julie@"
	db 2 ; item

	; party
	db 7, PICHU, EVIOLITE
	db 10, DITTO, METAL_POWDER
	db 8, TOGEPI, EVIOLITE

	db $ff ; end

; ================

	; BREEDER
	db "Theresa@"
	db 2 ; item

	; party
	db 14, ELEKID, EVIOLITE
	db 14, MAGBY, EVIOLITE

	db $ff ; end

; ================

	; BREEDER
	db "Jody@"
	db 3 ; item + moves

	; party

	db 27, TYROGUE, EVIOLITE
		db TACKLE
		db RAGE
		db FORESIGHT
		db HI_JUMP_KICK

	db 28, MUNCHLAX, EVIOLITE
		db METRONOME
		db BODY_SLAM
		db SCREECH
		db GUNK_SHOT

	db 29, DITTO, METAL_POWDER
		db TRANSFORM
		db NO_MOVE
		db NO_MOVE
		db NO_MOVE

	db $ff ; end

; ================

	; BREEDER
	db "Carlene@"
	db 3 ; item + moves

	; party

	db 49, SMEARGLE, EXPERT_BELT
		db SPORE
		db NASTY_PLOT
		db HYPER_VOICE
		db PSYCHIC_M

	db 49, SMEARGLE, MUSCLE_BAND
		db SPORE
		db SWORDS_DANCE
		db BODY_SLAM
		db EARTHQUAKE

	db 55, DITTO, METAL_POWDER
		db TRANSFORM
		db NO_MOVE
		db NO_MOVE
		db NO_MOVE

	db $ff ; end

; ================
; ================================


CowgirlGroup:
; ================================
; ================

	; COWGIRL
	db "Annie@"
	db 0 ; normal

	; party
	db 18, MILTANK
	db 18, TAUROS

	db $ff ; end

; ================

	; COWGIRL
	db "April@"
	db 0 ; normal

	; party
	db 46, TAUROS
	db 47, TAUROS
	db 46, TAUROS

	db $ff ; end

; ================

	; COWGIRL
	db "Daniela@"
	db 0 ; normal

	; party
	db 25, TAUROS
	db 25, MILTANK

	db $ff ; end

; ================
; ================================


SailorGroup:
; ================================
; ================

	; SAILOR
	db "Eugene@"
	db 0 ; normal

	; party
	db 17, POLIWHIRL
	db 17, RATICATE
	db 19, KRABBY

	db $ff ; end

; ================

	; SAILOR
	db "Huey@"
	db 0 ; normal

	; party
	db 18, POLIWAG
	db 20, POLIWHIRL

	db $ff ; end

; ================

	; SAILOR
	db "Terrell@"
	db 0 ; normal

	; party
	db 20, POLIWHIRL

	db $ff ; end

; ================

	; SAILOR
	db "Kent@"
	db 1 ; moves

	; party

	db 18, KRABBY
		db BUBBLE
		db LEER
		db SCRATCH
		db HARDEN

	db 20, KRABBY
		db BUBBLE_BEAM
		db LEER
		db SCRATCH
		db HARDEN

	db $ff ; end

; ================

	; SAILOR
	db "Roberto@"
	db 0 ; normal

	; party
	db 18, MACHOP
	db 18, MACHOP
	db 18, POLIWHIRL

	db $ff ; end

; ================

	; SAILOR
	db "Jeff@"
	db 0 ; normal

	; party
	db 40, RATICATE
	db 40, RATICATE

	db $ff ; end

; ================

	; SAILOR
	db "Garrett@"
	db 0 ; normal

	; party
	db 42, KINGLER

	db $ff ; end

; ================

	; SAILOR
	db "Kenneth@"
	db 0 ; normal

	; party
	db 38, MACHOP
	db 39, MACHOKE
	db 40, POLIWRATH
	db 39, MACHOKE

	db $ff ; end

; ================

	; SAILOR
	db "Stanly@"
	db 0 ; normal

	; party
	db 39, MACHOP
	db 41, MACHOKE
	db 34, PSYDUCK

	db $ff ; end

; ================

	; SAILOR
	db "Harry@"
	db 0 ; normal

	; party
	db 20, WOOPER

	db $ff ; end

; ================

	; SAILOR
	db "Huey@"
	db 0 ; normal

	; party
	db 28, POLIWHIRL
	db 28, POLIWHIRL

	db $ff ; end

; ================

	; SAILOR
	db "Huey@"
	db 0 ; normal

	; party
	db 34, POLIWHIRL
	db 34, POLIWRATH

	db $ff ; end

; ================

	; SAILOR
	db "Huey@"
	db 1 ; moves

	; party

	db 38, POLITOED
		db WHIRLPOOL
		db RAIN_DANCE
		db BODY_SLAM
		db PERISH_SONG

	db 38, POLIWRATH
		db SURF
		db STRENGTH
		db ICE_PUNCH
		db SUBMISSION

	db $ff ; end

; ================

	; SAILOR
	db "Parker@"
	db 0 ; normal

	; party
	db 43, HORSEA
	db 45, SEADRA

	db $ff ; end

; ================

	; SAILOR
	db "Eddie@"
	db 0 ; normal

	; party
	db 48, AZUMARILL

	db $ff ; end

; ================
; ================================


SwimmerMGroup:
; ================================
; ================

	; SWIMMERM
	db "Harold@"
	db 0 ; normal

	; party
	db 42, REMORAID
	db 40, SEADRA

	db $ff ; end

; ================

	; SWIMMERM
	db "Simon@"
	db 0 ; normal

	; party
	db 20, TENTACOOL
	db 20, TENTACOOL

	db $ff ; end

; ================

	; SWIMMERM
	db "Randall@"
	db 0 ; normal

	; party
	db 18, SHELLDER
	db 20, WARTORTLE
	db 18, SHELLDER

	db $ff ; end

; ================

	; SWIMMERM
	db "Charlie@"
	db 0 ; normal

	; party
	db 21, SHELLDER
	db 19, TENTACOOL
	db 19, TENTACRUEL

	db $ff ; end

; ================

	; SWIMMERM
	db "George@"
	db 0 ; normal

	; party
	db 16, TENTACOOL
	db 17, TENTACOOL
	db 16, TENTACOOL
	db 19, STARYU
	db 17, TENTACOOL
	db 19, REMORAID

	db $ff ; end

; ================

	; SWIMMERM
	db "Berke@"
	db 0 ; normal

	; party
	db 23, QWILFISH

	db $ff ; end

; ================

	; SWIMMERM
	db "Kirk@"
	db 0 ; normal

	; party
	db 20, GYARADOS
	db 20, GYARADOS

	db $ff ; end

; ================

	; SWIMMERM
	db "Matthew@"
	db 0 ; normal

	; party
	db 23, KRABBY

	db $ff ; end

; ================

	; SWIMMERM
	db "Hal@"
	db 0 ; normal

	; party
	db 24, SEEL
	db 25, DEWGONG
	db 24, SEEL

	db $ff ; end

; ================

	; SWIMMERM
	db "Jerome@"
	db 0 ; normal

	; party
	db 36, SEADRA
	db 38, TENTACOOL
	db 40, TENTACRUEL
	db 38, GOLDUCK

	db $ff ; end

; ================

	; SWIMMERM
	db "Tucker@"
	db 0 ; normal

	; party
	db 40, SHELLDER
	db 44, CLOYSTER

	db $ff ; end

; ================

	; SWIMMERM
	db "Rick@"
	db 0 ; normal

	; party
	db 13, STARYU
	db 18, STARMIE
	db 16, HORSEA

	db $ff ; end

; ================

	; SWIMMERM
	db "Frankie@"
	db 0 ; normal

	; party
	db 44, AZUMARILL

	db $ff ; end

; ================

	; SWIMMERM
	db "Tyson@"
	db 0 ; normal

	; party
	db 42, QUAGSIRE
	db 42, OCTILLERY
	db 44, QUAGSIRE

	db $ff ; end

; ================

	; SWIMMERM
	db "James@"
	db 0 ; normal

	; party
	db 13, STARYU
	db 18, STARMIE
	db 16, HORSEA

	db $ff ; end

; ================
; ================================


SwimmerFGroup:
; ================================
; ================

	; SWIMMERF
	db "Elaine@"
	db 0 ; normal

	; party
	db 21, STARYU

	db $ff ; end

; ================

	; SWIMMERF
	db "Paula@"
	db 0 ; normal

	; party
	db 19, STARYU
	db 19, SHELLDER

	db $ff ; end

; ================

	; SWIMMERF
	db "Kaylee@"
	db 0 ; normal

	; party
	db 18, MARILL
	db 20, MARILL
	db 20, AZUMARILL

	db $ff ; end

; ================

	; SWIMMERF
	db "Susie@"
	db 0 ; normal

	; party
	db 20, PSYDUCK
	db 22, SEEL

	db $ff ; end

; ================

	; SWIMMERF
	db "Denise@"
	db 0 ; normal

	; party
	db 22, SEEL

	db $ff ; end

; ================

	; SWIMMERF
	db "Kara@"
	db 0 ; normal

	; party
	db 20, STARYU
	db 20, STARMIE

	db $ff ; end

; ================

	; SWIMMERF
	db "Wendy@"
	db 1 ; moves

	; party

	db 21, HORSEA
		db BUBBLE
		db SMOKESCREEN
		db LEER
		db WATER_GUN

	db 21, HORSEA
		db DRAGON_RAGE
		db SMOKESCREEN
		db LEER
		db WATER_GUN

	db $ff ; end

; ================

	; SWIMMERF
	db "Mary@"
	db 0 ; normal

	; party
	db 20, GYARADOS

	db $ff ; end

; ================

	; SWIMMERF
	db "Debbie@"
	db 0 ; normal

	; party
	db 46, AZUMARILL

	db $ff ; end

; ================

	; SWIMMERF
	db "Nicole@"
	db 0 ; normal

	; party
	db 39, MARILL
	db 39, MARILL
	db 42, LAPRAS

	db $ff ; end

; ================

	; SWIMMERF
	db "Lori@"
	db 0 ; normal

	; party
	db 42, STARMIE
	db 42, STARMIE
	db 42, STARMIE

	db $ff ; end

; ================

	; SWIMMERF
	db "Nikki@"
	db 0 ; normal

	; party
	db 37, SEEL
	db 37, SEEL
	db 37, SEEL
	db 42, DEWGONG

	db $ff ; end

; ================

	; SWIMMERF
	db "Diana@"
	db 0 ; normal

	; party
	db 48, GOLDUCK

	db $ff ; end

; ================

	; SWIMMERF
	db "Briana@"
	db 0 ; normal

	; party
	db 46, GYARADOS
	db 46, LAPRAS

	db $ff ; end

; ================

	; SWIMMERF
	db "Joy@"
	db 0 ; normal

	; party
	db 48, CLOYSTER

	db $ff ; end

; ================
; ================================


BurglarGroup:
; ================================
; ================

	; BURGLAR
	db "Duncan@"
	db 0 ; normal

	; party
	db 34, KOFFING
	db 35, MAGMAR
	db 34, WEEZING

	db $ff ; end

; ================

	; BURGLAR
	db "Eddie@"
	db 0 ; normal

	; party
	db 36, GROWLITHE
	db 34, WEEZING

	db $ff ; end

; ================

	; BURGLAR
	db "Corey@"
	db 0 ; normal

	; party
	db 37, KOFFING
	db 39, MAGMAR
	db 37, KOFFING
	db 40, WEEZING

	db $ff ; end

; ================

	; BURGLAR
	db "Pete@"
	db 0 ; normal

	; party
	db 40, CHARMELEON
	db 42, MAGMAR

	db $ff ; end

; ================

	; BURGLAR
	db "Louis@"
	db 0 ; normal

	; party
	db 42, ARCANINE
	db 42, RAPIDASH

	db $ff ; end

; ================
; ================================


PIGroup:
; ================================
; ================
; ================
; ================================


ScientistGroup:
; ================================
; ================

	; SCIENTIST
	db "Ross@"
	db 0 ; normal

	; party
	db 30, KOFFING
	db 30, KOFFING

	db $ff ; end

; ================

	; SCIENTIST
	db "Mitch@"
	db 0 ; normal

	; party
	db 25, DITTO
	db 25, PORYGON

	db $ff ; end

; ================

	; SCIENTIST
	db "Jed@"
	db 0 ; normal

	; party
	db 29, MAGNEMITE
	db 30, MAGNETON
	db 29, MAGNEMITE

	db $ff ; end

; ================

	; SCIENTIST
	db "Garrett@"
	db 0 ; normal

	; party
	db 35, MAGNETON
	db 36, MAGNEMITE
	db 35, MAGNETON

	db $ff ; end

; ================

	; SCIENTIST
	db "Trenton@"
	db 1 ; moves

	; party

	db 35, PORYGON_Z
		db CONVERSION
		db CONVERSION2
		db RECOVER
		db TRI_ATTACK

	db $ff ; end

; ================

	; SCIENTIST
	db "Lowell@"
	db 0 ; normal

	; party
	db 50, ARCANINE

	db $ff ; end

; ================

	; SCIENTIST
	db "Dennett@"
	db 0 ; normal

	; party
	db 50, NINETALES

	db $ff ; end

; ================

	; SCIENTIST
	db "Linden@"
	db 0 ; normal

	; party
	db 50, MAGMAR

	db $ff ; end

; ================

	; SCIENTIST
	db "Oskar@"
	db 0 ; normal

	; party
	db 48, PORYGON2
	db 45, NINETALES
	db 47, MAGNEZONE

	db $ff ; end

; ================

	; SCIENTIST
	db "Braydon@"
	db 0 ; normal

	; party
	db 42, MAGNETON
	db 44, MAGNEZONE
	db 46, ELECTRODE

	db $ff ; end

; ================
; ================================


BoarderGroup:
; ================================
; ================

	; BOARDER
	db "Ronald@"
	db 0 ; normal

	; party
	db 33, SEEL
	db 35, DEWGONG
	db 33, SEEL

	db $ff ; end

; ================

	; BOARDER
	db "Brad@"
	db 0 ; normal

	; party
	db 35, SWINUB
	db 35, SWINUB

	db $ff ; end

; ================

	; BOARDER
	db "Douglas@"
	db 0 ; normal

	; party
	db 33, SHELLDER
	db 35, CLOYSTER
	db 33, SHELLDER

	db $ff ; end

; ================

	; BOARDER
	db "Shaun@"
	db 0 ; normal

	; party
	db 55, CLOYSTER
	db 50, DEWGONG

	db $ff ; end

; ================

	; BOARDER
	db "Bryce@"
	db 0 ; normal

	; party
	db 55, DEWGONG
	db 50, LAPRAS

	db $ff ; end

; ================

	; BOARDER
	db "Stefan@"
	db 0 ; normal

	; party
	db 36, SWINUB
	db 36, PILOSWINE
	db 38, SNEASEL

	db $ff ; end

; ================

	; BOARDER
	db "Max@"
	db 0 ; normal

	; party
	db 36, PILOSWINE
	db 37, LAPRAS

	db $ff ; end

; ================
; ================================


SkierGroup:
; ================================
; ================

	; SKIER
	db "Roxanne@"
	db 0 ; normal

	; party
	db 36, JYNX

	db $ff ; end

; ================

	; SKIER
	db "Clarissa@"
	db 0 ; normal

	; party
	db 36, DEWGONG

	db $ff ; end

; ================

	; SKIER
	db "Cady@"
	db 0 ; normal

	; party
	db 53, MAMOSWINE

	db $ff ; end

; ================

	; SKIER
	db "Maria@"
	db 0 ; normal

	; party
	db 39, JYNX

	db $ff ; end

; ================

	; SKIER
	db "Becky@"
	db 0 ; normal

	; party
	db 37, LAPRAS
	db 38, DEWGONG
	db 38, DEWGONG

	db $ff ; end

; ================
; ================================


BlackbeltGroup:
; ================================
; ================

	; BLACKBELT_T
	db "Kenji@"
	db 0 ; normal

	; party
	db 36, ONIX
	db 38, HITMONLEE
	db 36, ONIX
	db 39, MACHOKE

	db $ff ; end

; ================

	; BLACKBELT_T
	db "Yoshi@"
	db 1 ; moves

	; party

	db 27, HITMONLEE
		db DOUBLE_KICK
		db MEDITATE
		db LOW_KICK
		db FOCUS_ENERGY

	db $ff ; end

; ================

	; BLACKBELT_T
	db "Kenji@"
	db 1 ; moves

	; party

	db 33, ONIX
		db WRAP
		db ROCK_THROW
		db TOXIC
		db DIG

	db 38, MACHAMP
		db HEADBUTT
		db SWAGGER
		db THUNDERPUNCH
		db VITAL_THROW

	db 33, STEELIX
		db EARTHQUAKE
		db ROCK_THROW
		db IRON_TAIL
		db SANDSTORM

	db 36, HITMONLEE
		db DOUBLE_TEAM
		db HI_JUMP_KICK
		db MUD_SLAP
		db SWIFT

	db $ff ; end

; ================

	; BLACKBELT_T
	db "Lao@"
	db 1 ; moves

	; party

	db 27, HITMONCHAN
		db COMET_PUNCH
		db THUNDERPUNCH
		db ICE_PUNCH
		db FIRE_PUNCH

	db $ff ; end

; ================

	; BLACKBELT_T
	db "Nob@"
	db 1 ; moves

	; party

	db 25, MACHOP
		db LEER
		db FOCUS_ENERGY
		db KARATE_CHOP
		db SEISMIC_TOSS

	db 25, MACHOKE
		db LEER
		db KARATE_CHOP
		db SEISMIC_TOSS
		db ROCK_SLIDE

	db $ff ; end

; ================

	; BLACKBELT_T
	db "Kiyo@"
	db 3 ; item + moves

	; party

	db 40, HITMONLEE, BLACK_BELT
		db MEDITATE
		db FOCUS_ENERGY
		db HI_JUMP_KICK
		db LOCK_ON

	db 40, HITMONCHAN, KINGS_ROCK
		db THUNDERPUNCH
		db ICE_PUNCH
		db FIRE_PUNCH
		db MACH_PUNCH

	db 40, HITMONTOP, FOCUS_BAND
		db BULK_UP
		db TRIPLE_KICK
		db RAPID_SPIN
		db COUNTER

	db $ff ; end

; ================

	; BLACKBELT_T
	db "Lung@"
	db 0 ; normal

	; party
	db 23, MANKEY
	db 23, MANKEY
	db 25, PRIMEAPE

	db $ff ; end

; ================

	; BLACKBELT_T
	db "Kenji@"
	db 0 ; normal

	; party
	db 39, MACHOKE

	db $ff ; end

; ================

	; BLACKBELT_T
	db "Wai@"
	db 0 ; normal

	; party
	db 40, MACHOKE
	db 42, MACHOKE
	db 44, MACHOKE

	db $ff ; end

; ================
; ================================


BattleGirlGroup:
; ================================
; ================

	; BATTLE_GIRL
	db "Subaru@"
	db 0 ; normal

	; party
	db 26, MACHOP
	db 27, MACHOKE
	db 28, PRIMEAPE

	db $ff ; end

; ================

	; BATTLE_GIRL
	db "Diane@"
	db 0 ; normal

	; party
	db 28, PRIMEAPE
	db 28, HITMONLEE

	db $ff ; end

; ================

	; BATTLE_GIRL
	db "Kagami@"
	db 0 ; normal

	; party
	db 37, HITMONCHAN
	db 35, PRIMEAPE
	db 35, MACHOKE

	db $ff ; end

; ================

	; BATTLE_GIRL
	db "Nozomi@"
	db 0 ; normal

	; party
	db 36, MACHOKE
	db 36, MACHOKE
	db 37, HITMONTOP

	db $ff ; end

; ================

	; BATTLE_GIRL
	db "Ronda@"
	db 0 ; normal

	; party
	db 37, MACHOKE
	db 39, MACHAMP
	db 38, PRIMEAPE

	db $ff ; end

; ================

	; BATTLE_GIRL
	db "Padma@"
	db 0 ; normal

	; party
	db 47, HITMONLEE
	db 47, HITMONCHAN
	db 47, HITMONTOP

	db $ff ; end

; ================
; ================================


DragonTamerGroup:
; ================================
; ================

	; DRAGON_TAMER
	db "Paul@"
	db 0 ; normal

	; party
	db 37, DRATINI
	db 37, DRATINI
	db 37, DRATINI

	db $ff ; end

; ================

	; DRAGON_TAMER
	db "Darin@"
	db 1 ; moves

	; party

	db 38, DRAGONAIR
		db SLAM
		db SURF
		db DRAGON_PULSE
		db AQUA_TAIL

	db $ff ; end

; ================

	; DRAGON_TAMER
	db "Adam@"
	db 0 ; normal

	; party
	db 37, HORSEA
	db 38, DRATINI
	db 39, SEADRA

	db $ff ; end

; ================

	; DRAGON_TAMER
	db "Erick@"
	db 1 ; moves

	; party

	db 39, DRAGONAIR
		db THUNDER_WAVE
		db DRAGON_RAGE
		db AQUA_TAIL
		db SLAM

	db 38, SEADRA
		db SMOKESCREEN
		db TWISTER
		db BUBBLE_BEAM
		db OUTRAGE

	db 40, DRAGONAIR
		db WRAP
		db DRAGON_RAGE
		db AQUA_TAIL
		db DRAGON_PULSE

	db $ff ; end

; ================

	; DRAGON_TAMER
	db "Kazu@"
	db 1 ; moves

	; party

	db 40, DRAGONAIR
		db THUNDER_WAVE
		db DRAGON_RAGE
		db AQUA_TAIL
		db FLAMETHROWER

	db 40, DRAGONAIR
		db THUNDER_WAVE
		db DRAGON_RAGE
		db AQUA_TAIL
		db THUNDERBOLT

	db 40, DRAGONAIR
		db THUNDER_WAVE
		db DRAGON_RAGE
		db AQUA_TAIL
		db ICE_BEAM

	db $ff ; end

; ================
; ================================


TeacherGroup:
; ================================
; ================

	; TEACHER
	db "Colette@"
	db 0 ; normal

	; party
	db 46, CLEFAIRY

	db $ff ; end

; ================

	; TEACHER
	db "Hillary@"
	db 0 ; normal

	; party
	db 37, PERSIAN
	db 36, SUNFLORA
	db 41, CUBONE

	db $ff ; end

; ================

	; TEACHER
	db "Shirley@"
	db 0 ; normal

	; party
	db 40, WIGGLYTUFF

	db $ff ; end

; ================

	; TEACHER
	db "Kathryn@"
	db 0 ; normal

	; party
	db 26, BELLOSSOM
	db 25, PIDGEOTTO
	db 24, FURRET

	db $ff ; end

; ================
; ================================



GuitaristMGroup:
; ================================
; ================

	; GUITARISTM
	db "Clyde@"
	db 0 ; normal

	; party
	db 44, ELECTABUZZ

	db $ff ; end

; ================

	; GUITARISTM
	db "Vincent@"
	db 0 ; normal

	; party
	db 43, VOLTORB
	db 42, MAGNEMITE
	db 45, JOLTEON

	db $ff ; end

; ================
; ================================


GuitaristFGroup:
; ================================
; ================

	; GUITARISTF
	db "Janet@"
	db 1 ; moves

	; party

	db 46, PIKACHU
		db IRON_TAIL
		db EXTREMESPEED
		db SURF
		db THUNDERBOLT

	db 44, ELECTABUZZ
		db LIGHT_SCREEN
		db THUNDERPUNCH
		db CROSS_CHOP
		db SCREECH

	db 45, RAICHU
		db EXTREMESPEED
		db SURF
		db THUNDERBOLT
		db AGILITY

	db $ff ; end

; ================
; ================================


BikerGroup:
; ================================
; ================

	; BIKER
	db "Dwayne@"
	db 0 ; normal

	; party
	db 38, KOFFING
	db 39, KOFFING
	db 40, KOFFING
	db 41, KOFFING

	db $ff ; end

; ================

	; BIKER
	db "Harris@"
	db 0 ; normal

	; party
	db 45, FLAREON

	db $ff ; end

; ================

	; BIKER
	db "Zeke@"
	db 0 ; normal

	; party
	db 43, KOFFING
	db 43, KOFFING

	db $ff ; end

; ================

	; BIKER
	db "Charles@"
	db 0 ; normal

	; party
	db 41, KOFFING
	db 41, CHARMELEON
	db 42, WEEZING

	db $ff ; end

; ================

	; BIKER
	db "Riley@"
	db 0 ; normal

	; party
	db 45, WEEZING

	db $ff ; end

; ================

	; BIKER
	db "Joel@"
	db 0 ; normal

	; party
	db 43, MAGMAR
	db 43, MAGMAR

	db $ff ; end

; ================

	; BIKER
	db "Glenn@"
	db 0 ; normal

	; party
	db 39, KOFFING
	db 41, MAGMAR
	db 43, WEEZING

	db $ff ; end

; ================

	; BIKER
	db "Dale@"
	db 0 ; normal

	; party
	db 47, MUK
	db 47, WEEZING

	db $ff ; end

; ================

	; BIKER
	db "Jacob@"
	db 0 ; normal

	; party
	db 43, MAGMAR
	db 43, TENTACRUEL

	db $ff ; end

; ================

	; BIKER
	db "Aiden@"
	db 0 ; normal

	; party
	db 43, URSARING
	db 43, AZUMARILL

	db $ff ; end

; ================
; ================================


RoughneckGroup:
; ================================
; ================

	; ROUGHNECK
	db "Brian@"
	db 0 ; normal

	; party
	db 45, TENTACRUEL
	db 45, WEEZING
	db 45, WEEZING

	db $ff ; end

; ================

	; ROUGHNECK
	db "Theron@"
	db 0 ; normal

	; party
	db 45, MUK
	db 45, POLIWRATH

	db $ff ; end

; ================

	; ROUGHNECK
	db "Markey@"
	db 0 ; normal

	; party
	db 47, ARBOK
	db 46, HOUNDOOM

	db $ff ; end

; ================
; ================================


CooltrainerMGroup:
; ================================
; ================

	; COOLTRAINERM
	db "Nick@"
	db 1 ; moves

	; party

	db 26, CHARMANDER
		db EMBER
		db SMOKESCREEN
		db RAGE
		db SCARY_FACE

	db 26, SQUIRTLE
		db DEFENSE_CURL
		db WATER_GUN
		db BITE
		db CURSE

	db 26, BULBASAUR
		db LEECH_SEED
		db POISONPOWDER
		db SLEEP_POWDER
		db RAZOR_LEAF

	db $ff ; end

; ================

	; COOLTRAINERM
	db "Aaron@"
	db 0 ; normal

	; party
	db 28, IVYSAUR
	db 28, CHARMELEON
	db 28, WARTORTLE

	db $ff ; end

; ================

	; COOLTRAINERM
	db "Cody@"
	db 0 ; normal

	; party
	db 36, HORSEA
	db 38, SEADRA

	db $ff ; end

; ================

	; COOLTRAINERM
	db "Mike@"
	db 0 ; normal

	; party
	db 38, DRAGONAIR

	db $ff ; end

; ================

	; COOLTRAINERM
	db "Gaven@"
	db 1 ; moves

	; party

	db 41, VICTREEBEL
		db WRAP
		db TOXIC
		db ACID
		db RAZOR_LEAF

	db 41, KINGLER
		db BUBBLE_BEAM
		db STOMP
		db DIG
		db PROTECT

	db 41, FLAREON
		db SAND_ATTACK
		db QUICK_ATTACK
		db BITE
		db FIRE_SPIN

	db $ff ; end

; ================

	; COOLTRAINERM
	db "Gaven@"
	db 3 ; item + moves

	; party

	db 45, VICTREEBEL, NO_ITEM
		db GIGA_DRAIN
		db TOXIC
		db SLUDGE_BOMB
		db RAZOR_LEAF

	db 45, KINGLER, KINGS_ROCK
		db SURF
		db STOMP
		db DIG
		db BLIZZARD

	db 45, FLAREON, NO_ITEM
		db FLAMETHROWER
		db QUICK_ATTACK
		db BITE
		db FIRE_SPIN

	db $ff ; end

; ================

	; COOLTRAINERM
	db "Ryan@"
	db 1 ; moves

	; party

	db 35, PIDGEOT
		db SAND_ATTACK
		db QUICK_ATTACK
		db WHIRLWIND
		db WING_ATTACK

	db 37, ELECTABUZZ
		db THUNDERPUNCH
		db LIGHT_SCREEN
		db SWIFT
		db SCREECH

	db $ff ; end

; ================

	; COOLTRAINERM
	db "Gaven@"
	db 1 ; moves

	; party

	db 39, VICTREEBEL
		db WRAP
		db TOXIC
		db ACID
		db RAZOR_LEAF

	db 39, KINGLER
		db BUBBLE_BEAM
		db STOMP
		db DIG
		db PROTECT

	db 39, FLAREON
		db SAND_ATTACK
		db QUICK_ATTACK
		db BITE
		db FIRE_SPIN

	db $ff ; end

; ================

	; COOLTRAINERM
	db "Blake@"
	db 1 ; moves

	; party

	db 38, MAGNETON
		db THUNDERBOLT
		db SUPERSONIC
		db SWIFT
		db SCREECH

	db 36, QUAGSIRE
		db WATER_GUN
		db SLAM
		db CALM_MIND
		db EARTHQUAKE

	db 36, EXEGGCUTE
		db LEECH_SEED
		db CONFUSION
		db SLEEP_POWDER
		db SOLAR_BEAM

	db $ff ; end

; ================

	; COOLTRAINERM
	db "Andy@"
	db 0 ; normal

	; party
	db 10, BULBASAUR
	db 10, CHARMANDER
	db 10, SQUIRTLE

	db $ff ; end

; ================

	; COOLTRAINERM
	db "Sean@"
	db 0 ; normal

	; party
	db 40, FLAREON
	db 40, TANGELA
	db 40, TAUROS

	db $ff ; end

; ================

	; COOLTRAINERM
	db "Kevin@"
	db 0 ; normal

	; party
	db 48, RHYHORN
	db 46, CHARMELEON
	db 46, WARTORTLE

	db $ff ; end

; ================

	; COOLTRAINERM
	db "Allen@"
	db 1 ; moves

	; party

	db 36, CHARMELEON
		db SMOKESCREEN
		db METAL_CLAW
		db DRAGON_RAGE
		db FLAME_WHEEL

	db 35, MAGNETON
		db THUNDER_WAVE
		db THUNDERBOLT
		db TRI_ATTACK
		db FLASH_CANNON

	db $ff ; end

; ================

	; COOLTRAINERM
	db "French@"
	db 0 ; normal

	; party
	db 47, HOUNDOOM
	db 47, ALAKAZAM

	db $ff ; end

; ================

	; COOLTRAINERM
	db "Henri@"
	db 0 ; normal

	; party
	db 26, CHARMELEON
	db 26, WARTORTLE
	db 26, IVYSAUR

	db $ff ; end

; ================
; ================================


CooltrainerFGroup:
; ================================
; ================

	; COOLTRAINERF
	db "Gwen@"
	db 0 ; normal

	; party
	db 26, EEVEE
	db 22, FLAREON
	db 22, VAPOREON
	db 22, JOLTEON

	db $ff ; end

; ================

	; COOLTRAINERF
	db "Lois@"
	db 0 ; normal

	; party
	db 29, SUNFLORA
	db 29, NINETALES

	db $ff ; end

; ================

	; COOLTRAINERF
	db "Fran@"
	db 0 ; normal

	; party
	db 39, SEADRA

	db $ff ; end

; ================

	; COOLTRAINERF
	db "Lola@"
	db 0 ; normal

	; party
	db 36, DRATINI
	db 38, DRAGONAIR

	db $ff ; end

; ================

	; COOLTRAINERF
	db "Kate@"
	db 0 ; normal

	; party
	db 26, SHELLDER
	db 28, CLOYSTER

	db $ff ; end

; ================

	; COOLTRAINERF
	db "Irene@"
	db 0 ; normal

	; party
	db 22, PSYDUCK
	db 24, GOLDUCK

	db $ff ; end

; ================

	; COOLTRAINERF
	db "Kelly@"
	db 0 ; normal

	; party
	db 37, MARILL
	db 35, WARTORTLE
	db 35, CROCONAW

	db $ff ; end

; ================

	; COOLTRAINERF
	db "Joyce@"
	db 1 ; moves

	; party

	db 37, PIKACHU
		db QUICK_ATTACK
		db DOUBLE_TEAM
		db THUNDERBOLT
		db THUNDER

	db 38, BLASTOISE
		db BITE
		db CURSE
		db SURF
		db RAIN_DANCE

	db $ff ; end

; ================

	; COOLTRAINERF
	db "Beth@"
	db 1 ; moves

	; party

	db 40, RAPIDASH
		db STOMP
		db FIRE_SPIN
		db FURY_ATTACK
		db AGILITY

	db 39, FLAAFFY
		db SWIFT
		db THUNDERSHOCK
		db THUNDER_WAVE
		db LIGHT_SCREEN

	db $ff ; end

; ================

	; COOLTRAINERF
	db "Reena@"
	db 0 ; normal

	; party
	db 37, GROWLITHE
	db 40, NIDOQUEEN
	db 38, STARMIE

	db $ff ; end

; ================

	; COOLTRAINERF
	db "Megan@"
	db 1 ; moves

	; party

	db 35, BULBASAUR
		db GROWL
		db LEECH_SEED
		db POISONPOWDER
		db RAZOR_LEAF

	db 36, IVYSAUR
		db GROWL
		db LEECH_SEED
		db POISONPOWDER
		db RAZOR_LEAF

	db 37, VENUSAUR
		db BODY_SLAM
		db SLEEP_POWDER
		db RAZOR_LEAF
		db GROWTH

	db $ff ; end

; ================

	; COOLTRAINERF
	db "Beth@"
	db 1 ; moves

	; party

	db 39, RAPIDASH
		db STOMP
		db FIRE_SPIN
		db FURY_ATTACK
		db AGILITY

	db 39, AMPHAROS
		db SWIFT
		db THUNDERBOLT
		db THUNDER_WAVE
		db LIGHT_SCREEN

	db $ff ; end

; ================

	; COOLTRAINERF
	db "Carol@"
	db 0 ; normal

	; party
	db 40, ELECTRODE
	db 40, STARMIE
	db 40, NINETALES

	db $ff ; end

; ================

	; COOLTRAINERF
	db "Quinn@"
	db 0 ; normal

	; party
	db 47, VENUSAUR
	db 47, STARMIE

	db $ff ; end

; ================

	; COOLTRAINERF
	db "Emma@"
	db 0 ; normal

	; party
	db 28, POLIWHIRL

	db $ff ; end

; ================

	; COOLTRAINERF
	db "Cybil@"
	db 1 ; moves

	; party

	db 35, BUTTERFREE
		db SUPERSONIC
		db PSYBEAM
		db HYPNOSIS
		db MORNING_SUN

	db 36, BELLOSSOM
		db ACID
		db SLEEP_POWDER
		db GIGA_DRAIN
		db MOONLIGHT

	db $ff ; end

; ================

	; COOLTRAINERF
	db "Jenn@"
	db 0 ; normal

	; party
	db 24, STARYU
	db 26, STARMIE

	db $ff ; end

; ================

	; COOLTRAINERF
	db "Beth@"
	db 3 ; item + moves

	; party

	db 43, RAPIDASH, FOCUS_BAND
		db STOMP
		db FIRE_SPIN
		db FURY_ATTACK
		db FIRE_BLAST

	db $ff ; end

; ================

	; COOLTRAINERF
	db "Reena@"
	db 0 ; normal

	; party
	db 36, GROWLITHE
	db 39, NIDOQUEEN
	db 36, STARMIE

	db $ff ; end

; ================

	; COOLTRAINERF
	db "Reena@"
	db 3 ; item + moves

	; party

	db 40, ARCANINE, NO_ITEM
		db BITE
		db LEER
		db TAKE_DOWN
		db FLAME_WHEEL

	db 42, NIDOQUEEN, SILK_SCARF
		db EARTHQUAKE
		db DOUBLE_KICK
		db TOXIC
		db BODY_SLAM

	db 40, STARMIE, NO_ITEM
		db BLIZZARD
		db PSYCHIC_M
		db WATERFALL
		db RECOVER

	db $ff ; end

; ================

	; COOLTRAINERF
	db "Salma@"
	db 0 ; normal

	; party
	db 50, SLOWKING
	db 53, KANGASKHAN

	db $ff ; end

; ================

	; COOLTRAINERF
	db "Bonita@"
	db 0 ; normal

	; party
	db 50, GIRAFARIG
	db 52, SUDOWOODO

	db $ff ; end

; ================
; ================================


AceDuoGroup:
; ================================
; ================

	; ACE_DUO
	db "Elan & Ida@"
	db 0 ; normal

	; party
	db 55, PORYGON2
	db 55, AZUMARILL

	db $ff ; end

; ================

	; ACE_DUO
	db "Elan & Ida@"
	db 0 ; normal

	; party
	db 55, AZUMARILL
	db 55, PORYGON2

	db $ff ; end

; ================

	; ACE_DUO
	db "Ara & Bela@"
	db 0 ; normal

	; party
	db 53, GIRAFARIG
	db 52, TAUROS

	db $ff ; end

; ================

	; ACE_DUO
	db "Ara & Bela@"
	db 0 ; normal

	; party
	db 52, TAUROS
	db 53, GIRAFARIG

	db $ff ; end

; ================

	; ACE_DUO
	db "Thom & Kae@"
	db 0 ; normal

	; party
	db 25, MAGMAR
	db 25, ELECTABUZZ

	db $ff ; end

; ================

	; ACE_DUO
	db "Thom & Kae@"
	db 0 ; normal

	; party
	db 25, ELECTABUZZ
	db 25, MAGMAR

	db $ff ; end

; ================

	; ACE_DUO
	db "Zac & Jen@"
	db 0 ; normal

	; party
	db 47, DUGTRIO
	db 47, ELECTABUZZ

	db $ff ; end

; ================

	; ACE_DUO
	db "Zac & Jen@"
	db 0 ; normal

	; party
	db 47, ELECTABUZZ
	db 47, DUGTRIO

	db $ff ; end

; ================

	; ACE_DUO
	db "Jake & Bri@"
	db 0 ; normal

	; party
	db 37, SANDSLASH
	db 39, GOLDUCK
	db 37, PARASECT
	db 39, VAPOREON

	db $ff ; end

; ================

	; ACE_DUO
	db "Jake & Bri@"
	db 0 ; normal

	; party
	db 37, PARASECT
	db 39, VAPOREON
	db 37, SANDSLASH
	db 39, GOLDUCK

	db $ff ; end

; ================

	; ACE_DUO
	db "Dan & Cara@"
	db 1 ; moves

	; party

	db 38, SEADRA
		db SMOKESCREEN
		db BUBBLE_BEAM
		db OUTRAGE
		db WATERFALL

	db 38, SEADRA
		db SMOKESCREEN
		db BUBBLE_BEAM
		db OUTRAGE
		db WHIRLPOOL

	db $ff ; end

; ================

	; ACE_DUO
	db "Dan & Cara@"
	db 1 ; moves

	; party

	db 38, SEADRA
		db SMOKESCREEN
		db BUBBLE_BEAM
		db OUTRAGE
		db WHIRLPOOL

	db 38, SEADRA
		db SMOKESCREEN
		db BUBBLE_BEAM
		db OUTRAGE
		db WATERFALL

	db $ff ; end

; ================
; ================================


VeteranMGroup:
; ================================
; ================

	; VETERANM
	db "Matt@"
	db 3 ; item + moves

	; party

	db 40, FERALIGATR, KINGS_ROCK
		db SCARY_FACE
		db METAL_CLAW
		db CRUNCH
		db WATERFALL

	db 38, AMPHAROS, MAGNET
		db HEAL_BELL
		db CONFUSE_RAY
		db FIRE_PUNCH
		db THUNDERBOLT

	db 37, URSARING, LEFTOVERS
		db BELLY_DRUM
		db PLAY_ROUGH
		db SLASH
		db STRENGTH

	db 37, NOCTOWL, QUICK_CLAW
		db REFLECT
		db PSYBEAM
		db SHADOW_BALL
		db FLY

	db 39, ARCANINE, CHARCOAL
		db FLAME_WHEEL
		db FLAMETHROWER
		db DOUBLE_KICK
		db TAKE_DOWN

	db 36, SANDSLASH, HARD_STONE
		db SLASH
		db EARTHQUAKE
		db DEFENSE_CURL
		db ROLLOUT

	db $ff ; end

; ================

	; VETERANM
	db "Ringo@"
	db 3 ; item + moves

	; party

	db 42, BLASTOISE, MYSTIC_WATER
		db SURF
		db AQUA_TAIL
		db FLASH_CANNON
		db ICE_BEAM

	db 41, NINETALES, CHARCOAL
		db FLAMETHROWER
		db SHADOW_BALL
		db CONFUSE_RAY
		db EXTRASENSORY

	db 39, VICTREEBEL, MIRACLE_SEED
		db SLUDGE_BOMB
		db SEED_BOMB
		db SLEEP_POWDER
		db SWORDS_DANCE

	db 39, RAICHU, SILK_SCARF
		db SURF
		db THUNDERBOLT
		db EXTREMESPEED
		db NASTY_PLOT

	db 40, ALAKAZAM, TWISTEDSPOON
		db TRI_ATTACK
		db PSYBEAM
		db RECOVER
		db REFLECT

	db 38, SKARMORY, SHARP_BEAK
		db DRILL_PECK
		db SWIFT
		db STEEL_WING
		db ROCK_SMASH

	db $ff ; end

; ================
; ================================


VeteranFGroup:
; ================================
; ================

	; VETERANF
	db "Joanne@"
	db 3 ; item + moves

	; party

	db 41, VENUSAUR, MIRACLE_SEED
		db GROWTH
		db SLUDGE_BOMB
		db PETAL_DANCE
		db SLEEP_POWDER

	db 38, PIDGEOT, QUICK_CLAW
		db FLY
		db SWIFT
		db TWISTER
		db WHIRLWIND

	db 39, SCYTHER, EVIOLITE
		db SLASH
		db WING_ATTACK
		db SWORDS_DANCE
		db PURSUIT

	db 38, ELECTABUZZ, MAGNET
		db THUNDERBOLT
		db MEDITATE
		db KARATE_CHOP
		db LIGHT_SCREEN

	db 40, POLIWRATH, KINGS_ROCK
		db WATERFALL
		db SURF
		db STRENGTH
		db BODY_SLAM

	db 37, FLAREON, CHARCOAL
		db SMOKESCREEN
		db FLAME_WHEEL
		db QUICK_ATTACK
		db IRON_TAIL

	db $ff ; end

; ================

	; VETERANF
	db "Kotori@"
	db 3 ; item + moves

	; party

	db 41, TYPHLOSION, CHARCOAL
		db FLAME_WHEEL
		db THUNDERPUNCH
		db DIG
		db STRENGTH

	db 40, GLACEON, NEVERMELTICE
		db ICE_BEAM
		db RECOVER
		db BARRIER
		db IRON_TAIL

	db 39, TOGEKISS, LEFTOVERS
		db FLY
		db SOFTBOILED
		db FOCUS_BLAST
		db EXTREMESPEED

	db 39, OCTILLERY, QUICK_CLAW
		db SURF
		db ICE_BEAM
		db PSYBEAM
		db SEED_BOMB

	db 37, HERACROSS, KINGS_ROCK
		db ROCK_SMASH
		db STRENGTH
		db COUNTER
		db DOUBLE_TEAM

	db 38, PUPITAR, EVIOLITE
		db EARTHQUAKE
		db ROCK_SLIDE
		db SCARY_FACE
		db DARK_PULSE

	db $ff ; end

; ================
; ================================


ProtonGroup:
; ================================
; ================

	; PROTON
	db "Proton@"
	db 3 ; item + moves

	; party

	db 38, GOLBAT, KINGS_ROCK
		db WING_ATTACK
		db CONFUSE_RAY
		db SUPER_FANG
		db POISON_JAB

	db 39, QWILFISH, BRIGHTPOWDER
		db MINIMIZE
		db BUBBLE_BEAM
		db PAIN_SPLIT
		db ROLLOUT

	db 40, WEEZING, CHARCOAL
		db FIRE_BLAST
		db SELFDESTRUCT
		db SLUDGE_BOMB
		db SMOKESCREEN

	db $ff ; end

; ================

	; PROTON
	db "Proton@"
	db 0 ; normal

	; party
	db 10, ZUBAT
	db 12, QWILFISH
	db 14, KOFFING

	db $ff ; end

; ================
; ================================


PetrelGroup:
; ================================
; ================

	; PETREL
	db "Petrel@"
	db 3 ; item + moves

	; party

	db 37, KOFFING, EVIOLITE
		db TACKLE
		db SELFDESTRUCT
		db SLUDGE
		db SMOKESCREEN

	db 37, GOLBAT, EVIOLITE
		db LEECH_LIFE
		db WING_ATTACK
		db CONFUSE_RAY
		db SUPER_FANG

	db 40, PERSIAN, BLACKGLASSES
		db PLAY_ROUGH
		db SCREECH
		db FEINT_ATTACK
		db SLASH

	db 38, WEEZING, SILK_SCARF
		db TACKLE
		db EXPLOSION
		db SLUDGE
		db SMOKESCREEN

	db 37, RATICATE, KINGS_ROCK
		db QUICK_ATTACK
		db SCREECH
		db CRUNCH
		db SUPER_FANG

	db $ff ; end

; ================

	; PETREL
	db "Petrel@"
	db 3 ; item + moves

	; party

	db 33, GOLBAT, BLACKGLASSES
		db BITE
		db WING_ATTACK
		db CONFUSE_RAY
		db SUPER_FANG

	db 34, PERSIAN, HARD_STONE
		db PLAY_ROUGH
		db FURY_SWIPES
		db SCREECH
		db FEINT_ATTACK

	db 34, RATICATE, KINGS_ROCK
		db SWORDS_DANCE
		db CRUNCH
		db SUPER_FANG
		db HYPER_FANG

	db 35, WEEZING, POISON_BARB
		db ENDURE
		db WILL_O_WISP
		db SLUDGE_BOMB
		db SELFDESTRUCT

	db $ff ; end

; ================
; ================================


ArcherGroup:
; ================================
; ================

	; ARCHER
	db "Archer@"
	db 3 ; item + moves

	; party

	db 39, HOUNDOUR, EVIOLITE
		db SUPER_FANG
		db FIRE_SPIN
		db FEINT_ATTACK
		db WILL_O_WISP

	db 41, RATICATE, BLACKGLASSES
		db CRUNCH
		db SUPER_FANG
		db HYPER_FANG
		db DOUBLE_EDGE

	db 39, GENGAR, SPELL_TAG
		db HYPNOSIS
		db CONFUSE_RAY
		db PAIN_SPLIT
		db SHADOW_BALL

	db 40, WEEZING, BRIGHTPOWDER
		db SMOKESCREEN
		db WILL_O_WISP
		db PAIN_SPLIT
		db SLUDGE_BOMB

	db 42, HOUNDOOM, KINGS_ROCK
		db SMOKESCREEN
		db SUPER_FANG
		db FEINT_ATTACK
		db FLAMETHROWER

	db $ff ; end

; ================

	; ARCHER
	db "Archer@"
	db 3 ; item + moves

	; party

	db 27, HAUNTER, SPELL_TAG
		db DISABLE
		db NIGHT_SHADE
		db CONFUSE_RAY
		db SHADOW_BALL

	db 29, RATICATE, BLACKGLASSES
		db PURSUIT
		db HYPER_FANG
		db SCARY_FACE
		db CRUNCH

	db 27, WEEZING, SILK_SCARF
		db WILL_O_WISP
		db SELFDESTRUCT
		db SLUDGE
		db SMOKESCREEN

	db 31, HOUNDOUR, KINGS_ROCK
		db EMBER
		db SMOKESCREEN
		db BITE
		db SUPER_FANG

	db $ff ; end

; ================
; ================================


ArianaGroup:
; ================================
; ================

	; ARIANA
	db "Ariana@"
	db 3 ; item + moves

	; party

	db 38, ARBOK, POISON_BARB
		db GLARE
		db SCREECH
		db ACID
		db CRUNCH

	db 39, GLOOM, MIRACLE_SEED
		db LEECH_SEED
		db ACID
		db SLEEP_POWDER
		db GIGA_DRAIN

	db 40, MURKROW, BLACKGLASSES
		db WING_ATTACK
		db NIGHT_SHADE
		db CONFUSE_RAY
		db FEINT_ATTACK

	db $ff ; end

; ================

	; ARIANA
	db "Ariana@"
	db 3 ; item + moves

	; party

	db 33, ARBOK, BLACKGLASSES
		db WRAP
		db ACID
		db CRUNCH
		db GLARE

	db 34, VILEPLUME, MIRACLE_SEED
		db MEGA_DRAIN
		db GROWTH
		db SLEEP_POWDER
		db ACID

	db 35, HONCHKROW, KINGS_ROCK
		db WING_ATTACK
		db PURSUIT
		db CONFUSE_RAY
		db NIGHT_SHADE

	db $ff ; end

; ================
; ================================


PokemonProfGroup:
; ================================
; ================

	; POKEMON_PROF
	db "Oak@"
	db 0 ; normal

	; party
	db 78, TAUROS
	db 76, DODRIO
	db 80, VENUSAUR
	db 80, CHARIZARD
	db 80, BLASTOISE
	db 82, KANGASKHAN

	db $ff ; end

; ================
; ================================


MysticalmanGroup:
; ================================
; ================

	; MYSTICALMAN
	db "Eusine@"
	db 3 ; item + moves

	; party

	db 26, DROWZEE, TWISTEDSPOON
		db DREAM_EATER
		db HYPNOSIS
		db DISABLE
		db PSYBEAM

	db 26, HAUNTER, EVIOLITE
		db SHADOW_BALL
		db HYPNOSIS
		db CONFUSE_RAY
		db CURSE

	db 26, SUNFLORA, CHARCOAL
		db GROWTH
		db LEECH_SEED
		db GIGA_DRAIN
		db FLAMETHROWER

	db 28, ELECTRODE, MAGNET
		db THUNDER
		db SCREECH
		db SONIC_BOOM
		db ROLLOUT

	db $ff ; end

; ================
; ================================


LyraGroup:
; ================================
; ================

	; LYRA
	db "Lyra@"
	db 0 ; normal

	; party
	db 5, CHIKORITA

	db $ff ; end

; ================

	; LYRA
	db "Lyra@"
	db 0 ; normal

	; party
	db 5, CYNDAQUIL

	db $ff ; end

; ================

	; LYRA
	db "Lyra@"
	db 0 ; normal

	; party
	db 5, TOTODILE

	db $ff ; end

; ================

	; LYRA
	db "Lyra@"
	db 2 ; item

	; party
	db 15, PIDGEY, NO_ITEM
	db 17, MARILL, NO_ITEM
	db 16, SENTRET, NO_ITEM
	db 18, BAYLEEF, BERRY

	db $ff ; end

; ================

	; LYRA
	db "Lyra@"
	db 2 ; item

	; party
	db 15, PIDGEY, NO_ITEM
	db 17, SUNKERN, NO_ITEM
	db 16, SENTRET, NO_ITEM
	db 18, QUILAVA, BERRY

	db $ff ; end

; ================

	; LYRA
	db "Lyra@"
	db 2 ; item

	; party
	db 15, PIDGEY, NO_ITEM
	db 17, GROWLITHE, NO_ITEM
	db 16, SENTRET, NO_ITEM
	db 18, CROCONAW, BERRY

	db $ff ; end

; ================

	; LYRA
	db "Lyra@"
	db 2 ; item

	; party
	db 30, PIDGEOTTO, NO_ITEM
	db 32, GROWLITHE, NO_ITEM
	db 32, AZUMARILL, NO_ITEM
	db 31, FURRET, NO_ITEM
	db 35, BAYLEEF, BERRY

	db $ff ; end

; ================

	; LYRA
	db "Lyra@"
	db 2 ; item

	; party
	db 30, PIDGEOTTO, NO_ITEM
	db 32, SUNFLORA, NO_ITEM
	db 32, AZUMARILL, NO_ITEM
	db 31, FURRET, NO_ITEM
	db 35, QUILAVA, BERRY

	db $ff ; end

; ================

	; LYRA
	db "Lyra@"
	db 2 ; item

	; party
	db 30, PIDGEOTTO, NO_ITEM
	db 32, SUNFLORA, NO_ITEM
	db 32, GROWLITHE, NO_ITEM
	db 31, FURRET, NO_ITEM
	db 35, CROCONAW, BERRY

	db $ff ; end

; ================

	; LYRA
	db "Lyra@"
	db 2 ; item

	; party
	db 42, PIDGEOT, NO_ITEM
	db 44, ARCANINE, NO_ITEM
	db 44, AZUMARILL, NO_ITEM
	db 43, FURRET, NO_ITEM
	db 45, GIRAFARIG, NO_ITEM
	db 46, MEGANIUM, GOLD_BERRY

	db $ff ; end

; ================

	; LYRA
	db "Lyra@"
	db 2 ; item

	; party
	db 42, PIDGEOT, NO_ITEM
	db 44, SUNFLORA, NO_ITEM
	db 44, AZUMARILL, NO_ITEM
	db 43, FURRET, NO_ITEM
	db 45, GIRAFARIG, NO_ITEM
	db 46, TYPHLOSION, GOLD_BERRY

	db $ff ; end

; ================

	; LYRA
	db "Lyra@"
	db 2 ; item

	; party
	db 42, PIDGEOT, NO_ITEM
	db 44, SUNFLORA, NO_ITEM
	db 44, ARCANINE, NO_ITEM
	db 43, FURRET, NO_ITEM
	db 45, GIRAFARIG, NO_ITEM
	db 46, FERALIGATR, GOLD_BERRY

	db $ff ; end

; ================
; ================================


LoreleiGroup:
; ================================
; ================

	; LORELEI
	db "Lorelei@"
	db 3 ; item + moves

	; party

	db 37, GLACEON, NO_ITEM
		db ICE_BEAM
		db BARRIER
		db RECOVER
		db QUICK_ATTACK

	db 39, DEWGONG, NO_ITEM
		db WATERFALL
		db AURORA_BEAM
		db SLEEP_TALK
		db REST

	db 38, CLOYSTER, NO_ITEM
		db RAZOR_SHELL
		db SELFDESTRUCT
		db AURORA_BEAM
		db DEFENSE_CURL

	db 39, SLOWBRO, NO_ITEM
		db PSYCHIC_M
		db BUBBLE_BEAM
		db HEADBUTT
		db DISABLE

	db 42, JYNX, GOLD_BERRY
		db DRAIN_KISS
		db SING
		db NIGHTMARE
		db PETAL_DANCE

	db 41, LAPRAS, NO_ITEM
		db ICE_BEAM
		db ANCIENTPOWER
		db CONFUSE_RAY
		db SURF

	db $ff ; end

; ================

	; LORELEI
	db "Lorelei@"
	db 3 ; item + moves

	; party

	db 58, DEWGONG, LEFTOVERS
		db AQUA_TAIL
		db ICE_BEAM
		db REST
		db SLEEP_TALK

	db 57, CLOYSTER, SILK_SCARF
		db EXPLOSION
		db RAZOR_SHELL
		db AVALANCHE
		db BARRIER

	db 58, SLOWBRO, TWISTEDSPOON
		db PSYCHIC_M
		db SURF
		db ICE_BEAM
		db CALM_MIND

	db 56, GLACEON, NEVERMELTICE
		db ICE_BEAM
		db BARRIER
		db HYPER_VOICE
		db QUICK_ATTACK

	db 60, JYNX, PINK_BOW
		db DRAIN_KISS
		db NASTY_PLOT
		db ICE_BEAM
		db PSYCHIC_M

	db 59, LAPRAS, BRIGHTPOWDER
		db ICE_BEAM
		db ANCIENTPOWER
		db CONFUSE_RAY
		db OUTRAGE

	db $ff ; end

; ================
; ================================


AgathaGroup:
; ================================
; ================

	; AGATHA
	db "Agatha@"
	db 3 ; item + moves

	; party

	db 62, GENGAR, SPELL_TAG
		db SHADOW_BALL
		db WILL_O_WISP
		db CURSE
		db DESTINY_BOND

	db 62, CROBAT, POISON_BARB
		db AIR_SLASH
		db CRUNCH
		db X_SCISSOR
		db POISON_JAB

	db 61, MISMAGIUS, CHARCOAL
		db SHADOW_BALL
		db FLAMETHROWER
		db DAZZLINGLEAM
		db POWER_GEM

	db 61, MUK, SILK_SCARF
		db EXPLOSION
		db SLUDGE_BOMB
		db SCREECH
		db MINIMIZE

	db 63, ARBOK, KINGS_ROCK
		db SLUDGE_BOMB
		db GLARE
		db CRUNCH
		db BODY_SLAM

	db 65, GENGAR, QUICK_CLAW
		db SHADOW_BALL
		db THUNDERBOLT
		db WILL_O_WISP
		db DESTINY_BOND

	db $ff ; end

; ================
; ================================


YellowGroup:
; ================================
; ================

	; YELLOW
	db "Yellow@"
	db 3 ; item + moves

	; party

	db 28, RATTATA, BERRY
		db TAIL_WHIP
		db QUICK_ATTACK
		db HYPER_FANG
		db FOCUS_ENERGY

	db 26, BUTTERFREE, BERRY
		db CONFUSION
		db SLEEP_POWDER
		db POISONPOWDER
		db STUN_SPORE

	db 29, DODUO, BERRY
		db PECK
		db TRI_ATTACK
		db RETURN
		db MUD_SLAP

	db 28, GRAVELER, BERRY
		db ROLLOUT
		db DEFENSE_CURL
		db MAGNITUDE
		db ROCK_THROW

	db 27, OMANYTE, BERRY
		db WATER_GUN
		db BITE
		db DEFENSE_CURL
		db ICY_WIND

	db 32, PIKACHU, LIGHT_BALL
		db SURF
		db FLY
		db THUNDERBOLT
		db QUICK_ATTACK

	db $ff ; end

; ================
; ================================


WalkerGroup:
; ================================
; ================

	; WALKER
	db "Walker@"
	db 3 ; item + moves

	; party

	db 28, NOCTOWL, NO_ITEM
		db WING_ATTACK
		db NIGHT_SHADE
		db REFLECT
		db CONFUSION

	db 29, PIDGEOT, NO_ITEM
		db GUST
		db TWISTER
		db SWIFT
		db MUD_SLAP

	db 28, AERODACTYL, NO_ITEM
		db WING_ATTACK
		db SUPERSONIC
		db BITE
		db ANCIENTPOWER

	db 31, SKARMORY, GOLD_BERRY
		db METAL_CLAW
		db FURY_ATTACK
		db DRILL_PECK
		db SWIFT

	db $ff ; end

; ================
; ================================


BillGroup:
; ================================
; ================

	; BILL_T
	db "Bill@"
	db 3 ; item + moves

	; party

	db 62, VAPOREON, MYSTIC_WATER
		db RECOVER
		db BARRIER
		db HAZE
		db SCALD

	db 62, JOLTEON, MAGNET
		db THUNDER_WAVE
		db THUNDERBOLT
		db LIGHT_SCREEN
		db QUICK_ATTACK

	db 62, FLAREON, CHARCOAL
		db FLARE_BLITZ
		db DOUBLE_EDGE
		db SMOKESCREEN
		db ROCK_SMASH

	db 63, LEAFEON, MIRACLE_SEED
		db SEED_BOMB
		db SWORDS_DANCE
		db MORNING_SUN
		db X_SCISSOR

	db 63, GLACEON, NEVERMELTICE
		db ICE_BEAM
		db MIRROR_COAT
		db RECOVER
		db QUICK_ATTACK

	db 66, PORYGON2, EVIOLITE
		db TRI_ATTACK
		db THUNDERBOLT
		db ICE_BEAM
		db RECOVER

	db $ff ; end

; ================
; ================================


LawrenceGroup:
; ================================
; ================

	; LAWRENCE
	db "Lawrence@"
	db 3 ; item + moves

	; party

	db 70, ARTICUNO, BRIGHTPOWDER
		db ICE_BEAM
		db AIR_SLASH
		db ANCIENTPOWER
		db WHIRLWIND

	db 66, CHARIZARD, DRAGON_FANG
		db SWORDS_DANCE
		db FLARE_BLITZ
		db DRAGON_CLAW
		db SLASH

	db 68, DRAGONITE, LEFTOVERS
		db DRAGON_DANCE
		db OUTRAGE
		db HYPER_BEAM
		db AQUA_TAIL

	db 67, TYRANITAR, KINGS_ROCK
		db EARTHQUAKE
		db STONE_EDGE
		db CRUNCH
		db SCARY_FACE

	db 66, HONCHKROW, QUICK_CLAW
		db NASTY_PLOT
		db DARK_PULSE
		db CONFUSE_RAY
		db PURSUIT

	db 70, ZAPDOS, SHARP_BEAK
		db DRILL_PECK
		db THUNDER
		db ANCIENTPOWER
		db LIGHT_SCREEN

	db $ff ; end

; ================
; ================================


GiovanniGroup:
; ================================
; ================

	; unused
	; GIOVANNI
	db "Giovanni@"
	db 3 ; item + moves

	; party

	db 32, RHYHORN, EVIOLITE
		db CRUNCH
		db MAGNITUDE
		db SCARY_FACE
		db STOMP

	db 34, HONCHKROW, BLACKGLASSES
		db ASTONISH
		db PURSUIT
		db STEEL_WING
		db FLY

	db 36, NIDOKING, KINGS_ROCK
		db EARTHQUAKE
		db THRASH
		db OUTRAGE
		db SHADOW_CLAW

	db 34, KANGASKHAN, SILK_SCARF
		db EARTHQUAKE
		db STOMP
		db DIZZY_PUNCH
		db SEISMIC_TOSS

	db 36, NIDOQUEEN, SOFT_SAND
		db EARTHQUAKE
		db BODY_SLAM
		db OUTRAGE
		db FOCUS_BLAST

	db 38, RHYDON, HARD_STONE
		db EARTHQUAKE
		db ROCK_SLIDE
		db STOMP
		db SURF

	db $ff ; end

; ================
; ================================


StevenGroup:
; ================================
; ================

	; STEVEN
	db "Steven@"
	db 0 ; normal

	; party
	db 61, SKARMORY
	db 60, FORRETRESS
if DEF(FAITHFUL)
	db 58, SCIZOR
	db 58, MAGNEZONE
else
	db 58, BLASTOISE
	db 58, RHYPERIOR
endc
	db 58, AERODACTYL
	db 62, STEELIX

	db $ff ; end

; ================
; ================================


CynthiaGroup:
; ================================
; ================

	; CYNTHIA
	db "Cynthia@"
	db 0 ; normal

	; party
	db 60, TOGEKISS
	db 58, LEAFEON
	db 58, ELECTIVIRE
	db 58, YANMEGA
	db 62, KINGDRA
	db 61, GLISCOR

	db $ff ; end

; ================
; ================================


TowerTycoonGroup:
; ================================
; ================

	; unused
	; TOWERTYCOON
	db "Palmer@"
	db 0 ; normal

	; party
	db 50, GYARADOS
	db 50, RHYPERIOR
	db 50, DRAGONITE

	db $ff ; end

; ================
; ================================


ValerieGroup:
; ================================
; ================

	; VALERIE
	db "Valerie@"
	db 3 ; item + moves

	; party

	db 35, CLEFABLE, NO_ITEM
		db DISARM_VOICE
		db MINIMIZE
		db BATON_PASS
		db METRONOME

	db 35, MR__MIME, NO_ITEM
		db PSYBEAM
		db CONFUSE_RAY
		db LIGHT_SCREEN
		db REFLECT

	db 34, WIGGLYTUFF, NO_ITEM
		db REST
		db SLEEP_TALK
		db DISARM_VOICE
		db ROLLOUT

	db 34, AZUMARILL, NO_ITEM
		db PLAY_ROUGH
		db AQUA_TAIL
		db DIZZY_PUNCH
		db ROLLOUT

	db 36, TOGETIC, NO_ITEM
		db ANCIENTPOWER
		db SOFTBOILED
		db FAIRY_WIND
		db ENCORE

	db 38, SYLVEON, GOLD_BERRY
		db MOONBLAST
		db CALM_MIND
		db DRAIN_KISS
		db SWIFT

	db $ff ; end

; ================
; ================================


ReiGroup:
; ================================
; ================

	; REI
	db "Maiden Rei@"
	db 0 ; normal

	; party
	db 20, FLAREON
	db 19, MURKROW
	db 18, NOCTOWL
	db 18, KADABRA
	db 21, NINETALES

	db $ff ; end

; ================
; ================================


OmastarFossilGroup:
; ================================
; ================
; ================
; ================================


KabutopsFossilGroup:
; ================================
; ================
; ================
; ================================


AerodactylFossilGroup:
; ================================
; ================
; ================
; ================================

