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


FalknerGroup:
; ================================
; ================

	; FALKNER (1)
	db "Falkner@"
	db 3 ; item + moves

	; party

	db 9, PIDGEY, NO_ITEM
		db TACKLE
		db SAND_ATTACK
		db GUST
		db MUD_SLAP

	db 9, HOOTHOOT, NO_ITEM
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

	; FALKNER (2)
	db "Falkner@"
	db 3 ; item + moves

	; party

	db 63, NOCTOWL, TWISTEDSPOON
		db AIR_SLASH
		db PSYCHIC_M
		db HYPNOSIS
		db DREAM_EATER

	db 60, GLISCOR, SCOPE_LENS
		db SWORDS_DANCE
		db EARTHQUAKE
		db X_SCISSOR
		db SLASH

	db 62, DODRIO, SILK_SCARF
		db DRILL_PECK
		db TRIPLE_KICK
		db PURSUIT
		db QUICK_ATTACK

	db 60, TOGEKISS, LEFTOVERS
		db ANCIENTPOWER
		db AIR_SLASH
		db NASTY_PLOT
		db SOFTBOILED

	db 62, HONCHKROW, BLACKGLASSES
		db DRILL_PECK
		db DARK_PULSE
		db PURSUIT
		db CONFUSE_RAY

	db 65, PIDGEOT, SHARP_BEAK
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

	; BUGSY (1)
	db "Bugsy@"
	db 3 ; item + moves

	; party

	db 15, BUTTERFREE, NO_ITEM
		db TACKLE
		db POISONPOWDER
		db SLEEP_POWDER
		db CONFUSION

	db 15, BEEDRILL, NO_ITEM
		db POISON_STING
		db STRING_SHOT
		db HARDEN
		db FURY_ATTACK

	db 14, YANMA, NO_ITEM
		db FORESIGHT
		db QUICK_ATTACK
		db DOUBLE_TEAM
		db SONIC_BOOM

	db 17, SCYTHER, BERRY
		db QUICK_ATTACK
		db LEER
		db PURSUIT
		db FURY_CUTTER

	db $ff ; end

; ================

	; BUGSY (2)
	db "Bugsy@"
	db 3 ; item + moves

	; party

	db 63, HERACROSS, BLACK_BELT
		db MEGAHORN
		db CROSS_CHOP
		db ROCK_SMASH
		db STONE_EDGE

	db 61, LEDIAN, KINGS_ROCK
		db REFLECT
		db LIGHT_SCREEN
		db BUG_BUZZ
		db ICE_PUNCH

	db 60, YANMEGA, QUICK_CLAW
		db BUG_BUZZ
		db AIR_SLASH
		db ANCIENTPOWER
		db PROTECT

	db 62, PARASECT, LEFTOVERS
		db SPORE
		db SYNTHESIS
		db SEED_BOMB
		db X_SCISSOR

	db 63, PINSIR, SCOPE_LENS
		db GUILLOTINE
		db SWORDS_DANCE
		db SUBMISSION
		db EARTHQUAKE

	db 65, SCYTHER, EVIOLITE
		db SWORDS_DANCE
		db SLASH
		db X_SCISSOR
		db QUICK_ATTACK

	db $ff ; end

; ================
; ================================


WhitneyGroup:
; ================================
; ================

	; WHITNEY (1)
	db "Whitney@"
	db 3 ; item + moves

	; party

	db 18, CLEFAIRY, NO_ITEM
		db METRONOME
		db DISARM_VOICE
		db DOUBLE_SLAP
		db ENCORE

	db 19, TEDDIURSA, NO_ITEM
		db SCRATCH
		db GROWL
		db LICK
		db FEINT_ATTACK

	db 18, MUNCHLAX, NO_ITEM
		db SWEET_KISS
		db METRONOME
		db DEFENSE_CURL
		db ROLLOUT

	db 18, JIGGLYPUFF, NO_ITEM
		db SING
		db DIZZY_PUNCH
		db DEFENSE_CURL
		db ROLLOUT

	db 20, MILTANK, MIRACLEBERRY
		db DEFENSE_CURL
		db STOMP
		db MILK_DRINK
		db ROLLOUT

	db $ff ; end

; ================

	; WHITNEY (2)
	db "Whitney@"
	db 3 ; item + moves

	; party

	db 62, CLEFABLE, PINK_BOW
		db CALM_MIND
		db MOONBLAST
		db SOFTBOILED
		db THUNDER_WAVE

	db 60, URSARING, BLACK_BELT
		db SWORDS_DANCE
		db CROSS_CHOP
		db CRUNCH
		db PLAY_ROUGH

	db 61, GIRAFARIG, TWISTEDSPOON
		db NASTY_PLOT
		db PSYCHIC_M
		db HYPER_VOICE
		db SHADOW_BALL

	db 62, WIGGLYTUFF, LEFTOVERS
		db FOCUS_BLAST
		db HYPER_VOICE
		db DAZZLINGLEAM
		db ICE_BEAM

	db 64, TAUROS, SILK_SCARF
		db BULK_UP
		db EARTHQUAKE
		db STRENGTH
		db IRON_TAIL

	db 65, MILTANK, BRIGHTPOWDER
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

	; MORTY (1)
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

	; MORTY (2)
	db "Morty@"
	db 3 ; item + moves

	; party

	db 62, GENGAR, LEFTOVERS
		db WILL_O_WISP
		db SHADOW_BALL
		db FOCUS_BLAST
		db SUBSTITUTE

	db 60, NINETALES, CHARCOAL
		db NASTY_PLOT
		db SHADOW_BALL
		db FLAMETHROWER
		db WILL_O_WISP

	db 61, MAROWAK, THICK_CLUB
		db BONEMERANG
		db STONE_EDGE
		db ICE_PUNCH
		db SHADOW_CLAW

	db 63, MISMAGIUS, PINK_BOW
		db DAZZLINGLEAM
		db SHADOW_BALL
		db NASTY_PLOT
		db THUNDERBOLT

	db 64, HAUNTER, EVIOLITE
		db SHADOW_BALL
		db SLUDGE_BOMB
		db DESTINY_BOND
		db PAIN_SPLIT

	db 65, GENGAR, SPELL_TAG
		db SHADOW_BALL
		db THUNDERBOLT
		db DARK_PULSE
		db DESTINY_BOND

	db $ff ; end

; ================
; ================================


ChuckGroup:
; ================================
; ================

	; CHUCK (1)
	db "Chuck@"
	db 3 ; item + moves

	; party

	db 29, MACHOKE, NO_ITEM
		db KARATE_CHOP
		db BULLET_PUNCH
		db MEDITATE
		db DYNAMICPUNCH

	db 29, PRIMEAPE, NO_ITEM
		db KARATE_CHOP
		db SEISMIC_TOSS
		db SCREECH
		db DYNAMICPUNCH

	db 28, HITMONCHAN, NO_ITEM
		db THUNDERPUNCH
		db ICE_PUNCH
		db FIRE_PUNCH
		db MACH_PUNCH

	db 28, HITMONLEE, NO_ITEM
		db LOCK_ON
		db BULK_UP
		db LOW_KICK
		db HI_JUMP_KICK

	db 28, HITMONTOP, NO_ITEM
		db BULK_UP
		db QUICK_ATTACK
		db TRIPLE_KICK
		db RAPID_SPIN

	db 31, POLIWRATH, GOLD_BERRY
		db LOCK_ON
		db HYPNOSIS
		db WATERFALL
		db DYNAMICPUNCH

	db $ff ; end

; ================

	; CHUCK (2)
	db "Chuck@"
	db 3 ; item + moves

	; party

	db 63, MACHAMP, FOCUS_BAND
		db STONE_EDGE
		db CROSS_CHOP
		db ICE_PUNCH
		db BULLET_PUNCH

	db 61, PRIMEAPE, DRAGON_FANG
		db EARTHQUAKE
		db STONE_EDGE
		db OUTRAGE
		db CROSS_CHOP

	db 62, HITMONCHAN, NEVERMELTICE
		db THUNDERPUNCH
		db ICE_PUNCH
		db FIRE_PUNCH
		db MACH_PUNCH

	db 62, HITMONLEE, QUICK_CLAW
		db HI_JUMP_KICK
		db LOCK_ON
		db BULK_UP
		db REVERSAL

	db 62, HITMONTOP, KINGS_ROCK
		db RAPID_SPIN
		db TOXIC
		db SUBMISSION
		db TRIPLE_KICK

	db 65, POLIWRATH, LEFTOVERS
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

	; JASMINE (1)
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

	db 29, MAGNEMITE, NO_ITEM
		db SUPERSONIC
		db THUNDER_WAVE
		db METAL_SOUND
		db THUNDERBOLT

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

	; JASMINE (2)
	db "Jasmine@"
	db 3 ; item + moves

	; party

	db 64, SKARMORY, LEFTOVERS
		db SPIKES
		db WHIRLWIND
		db DRILL_PECK
		db STEEL_WING

	db 62, MAGNEZONE, MIRACLE_SEED
		db THUNDERBOLT
		db HIDDEN_POWER ; Grass
		db FLASH_CANNON
		db EXPLOSION

	db 60, AMPHAROS, MAGNET
		db THUNDERBOLT
		db FOCUS_BLAST
		db SAFEGUARD
		db LIGHT_SCREEN

	db 63, MAGNEZONE, CHARCOAL
		db THUNDERBOLT
		db HIDDEN_POWER ; Fire
		db FLASH_CANNON
		db EXPLOSION

	db 63, SCIZOR, METAL_COAT
		db SWORDS_DANCE
		db BULLET_PUNCH
		db PURSUIT
		db IRON_HEAD

	db 65, STEELIX, LEFTOVERS
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

	; PRYCE (1)
	db "Pryce@"
	db 3 ; item + moves

	; party

	db 30, SEEL, NO_ITEM
		db HEADBUTT
		db ICY_WIND
		db REST
		db AURORA_BEAM

	db 32, DEWGONG, NO_ITEM
		db HEADBUTT
		db REST
		db SLEEP_TALK
		db AURORA_BEAM

	db 30, SHELLDER, NO_ITEM
		db SUPERSONIC
		db AURORA_BEAM
		db PROTECT
		db SELFDESTRUCT

	db 32, CLOYSTER, NO_ITEM
		db DEFENSE_CURL
		db SUPERSONIC
		db AURORA_BEAM
		db RAZOR_SHELL

	db 31, LAPRAS, NO_ITEM
		db SING
		db CONFUSE_RAY
		db ANCIENTPOWER
		db ICY_WIND

	db 34, PILOSWINE, GOLD_BERRY
		db MAGNITUDE
		db ICY_WIND
		db AVALANCHE
		db FURY_ATTACK

	db $ff ; end

; ================

	; PRYCE (2)
	db "Pryce@"
	db 3 ; item + moves

	; party

	db 63, DEWGONG, FOCUS_BAND
		db PROTECT
		db TOXIC
		db SURF
		db ICE_BEAM

	db 63, CLOYSTER, KINGS_ROCK
		db SPIKES
		db RAZOR_SHELL
		db EXPLOSION
		db AVALANCHE

	db 62, WEAVILE, KINGS_ROCK
		db SWORDS_DANCE
		db ICE_PUNCH
		db SLASH
		db CRUNCH

	db 61, GLACEON, NEVERMELTICE
		db ICE_BEAM
		db HIDDEN_POWER ; Ground
		db BARRIER
		db BATON_PASS

	db 63, LAPRAS, LEFTOVERS
		db SING
		db TOXIC
		db ICE_BEAM
		db THUNDERBOLT

	db 65, MAMOSWINE, HARD_STONE
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

	; CLAIR (1)
	db "Clair@"
	db 3 ; item + moves

	; party

	db 38, GYARADOS, NO_ITEM
		db DRAGON_RAGE
		db TWISTER
		db DRAGONBREATH
		db AQUA_TAIL

	db 38, AMPHAROS, NO_ITEM
		db THUNDER_WAVE
		db CONFUSE_RAY
		db DRAGON_PULSE
		db LIGHT_SCREEN

	db 38, DRAGONAIR, NO_ITEM
		db THUNDER_WAVE
		db AQUA_TAIL
		db FLAMETHROWER
		db DRAGONBREATH

	db 38, DRAGONAIR, NO_ITEM
		db THUNDER_WAVE
		db AQUA_TAIL
		db THUNDERBOLT
		db DRAGONBREATH

	db 38, DRAGONAIR, NO_ITEM
		db THUNDER_WAVE
		db AQUA_TAIL
		db ICE_BEAM
		db DRAGONBREATH

	db 41, KINGDRA, GOLD_BERRY
		db SMOKESCREEN
		db HYPER_BEAM
		db DRAGONBREATH
		db SURF

	db $ff ; end

; ================

	; CLAIR (2)
	db "Clair@"
	db 3 ; item + moves

	; party

	db 64, DRAGONAIR, EVIOLITE
		db AQUA_TAIL
		db FLY
		db THUNDER_WAVE
		db SAFEGUARD

	db 62, GYARADOS, MIRACLEBERRY
		db DRAGON_DANCE
		db WATERFALL
		db FLY
		db EARTHQUAKE

	db 63, DRAGONITE, SILK_SCARF
		db OUTRAGE
		db EXTREMESPEED
		db FIRE_PUNCH
		db EARTHQUAKE

	db 63, DRAGONITE, LEFTOVERS
		db DRAGON_DANCE
		db DRAGON_CLAW
		db WATERFALL
		db HYPER_BEAM

	db 64, DRAGONAIR, DRAGON_FANG
		db DRAGON_DANCE
		db EXTREMESPEED
		db OUTRAGE
		db AQUA_TAIL

	db 65, KINGDRA, MINT_BERRY
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

	; WILL (1)
	db "Will@"
	db 3 ; item + moves

	; party

	db 40, XATU, NO_ITEM
		db QUICK_ATTACK
		db FUTURE_SIGHT
		db CONFUSE_RAY
		db PSYCHIC_M

	db 41, JYNX, NO_ITEM
		db DOUBLE_SLAP
		db DRAIN_KISS
		db ICE_PUNCH
		db PSYCHIC_M

	db 41, EXEGGUTOR, NO_ITEM
		db REFLECT
		db LEECH_SEED
		db EGG_BOMB
		db PSYCHIC_M

	db 41, ALAKAZAM, NO_ITEM
		db CALM_MIND
		db RECOVER
		db FUTURE_SIGHT
		db PSYCHIC_M

	db 41, SLOWBRO, NO_ITEM
		db CURSE
		db CALM_MIND
		db BODY_SLAM
		db PSYCHIC_M

	db 42, XATU, GOLD_BERRY
		db QUICK_ATTACK
		db FUTURE_SIGHT
		db CONFUSE_RAY
		db PSYCHIC_M

	db $ff ; end

; ================

	; WILL (2)
	db "Will@"
	db 3 ; item + moves

	; party

	db 60, XATU, TWISTEDSPOON
		db DRILL_PECK
		db FUTURE_SIGHT
		db CONFUSE_RAY
		db PSYCHIC_M

	db 61, JYNX, BRIGHTPOWDER
		db NIGHTMARE
		db DRAIN_KISS
		db ICE_PUNCH
		db PSYCHIC_M

	db 61, EXEGGUTOR, MIRACLE_SEED
		db REFLECT
		db GIGA_DRAIN
		db SLEEP_POWDER
		db PSYCHIC_M

	db 61, ALAKAZAM, MIRACLEBERRY
		db HIDDEN_POWER ; Fighting
		db RECOVER
		db SHADOW_BALL
		db PSYCHIC_M

	db 61, SLOWBRO, LEFTOVERS
		db SURF
		db PSYCHIC_M
		db THUNDER_WAVE
		db REST

	db 62, XATU, GOLD_BERRY
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

	; KOGA (1)
	db "Koga@"
	db 3 ; item + moves

	; party

	db 40, ARIADOS, NO_ITEM
		db DOUBLE_TEAM
		db MEAN_LOOK
		db BATON_PASS
		db GIGA_DRAIN

	db 41, VENOMOTH, NO_ITEM
		db SUPERSONIC
		db GUST
		db PSYCHIC_M
		db TOXIC

	db 43, FORRETRESS, NO_ITEM
		db PROTECT
		db SWIFT
		db EXPLOSION
		db SPIKES

	db 42, MUK, NO_ITEM
		db MINIMIZE
		db SCREECH
		db SLUDGE_BOMB
		db TOXIC

	db 43, WEEZING, NO_ITEM
		db HAZE
		db TOXIC
		db SLUDGE_BOMB
		db EXPLOSION

	db 44, CROBAT, GOLD_BERRY
		db DOUBLE_TEAM
		db QUICK_ATTACK
		db WING_ATTACK
		db TOXIC

	db $ff ; end

; ================

	; KOGA (2)
	db "Koga@"
	db 3 ; item + moves

	; party

	db 60, TENTACRUEL, LEFTOVERS
		db SUBSTITUTE
		db SWORDS_DANCE
		db SURF
		db SLUDGE_BOMB

	db 63, FORRETRESS, SILK_SCARF
		db PROTECT
		db TOXIC
		db EXPLOSION
		db SPIKES

	db 61, ARBOK, BRIGHTPOWDER
		db SLUDGE_BOMB
		db GLARE
		db EARTHQUAKE
		db SCREECH

	db 62, MUK, CHARCOAL
		db FIRE_BLAST
		db CURSE
		db GUNK_SHOT
		db TOXIC

	db 63, WEEZING, MAGNET
		db THUNDER
		db FIRE_BLAST
		db SLUDGE_BOMB
		db EXPLOSION

	db 64, CROBAT, GOLD_BERRY
		db SCREECH
		db TOXIC
		db CONFUSE_RAY
		db WING_ATTACK

	db $ff ; end

; ================
; ================================


BrunoGroup:
; ================================
; ================

	; BRUNO (1)
	db "Bruno@"
	db 3 ; item + moves

	; party

	db 42, HITMONTOP, NO_ITEM
		db PURSUIT
		db QUICK_ATTACK
		db DIG
		db PROTECT

	db 43, ONIX, NO_ITEM
		db WRAP
		db EARTHQUAKE
		db SANDSTORM
		db ROCK_SLIDE

	db 42, HITMONLEE, NO_ITEM
		db SWAGGER
		db DOUBLE_KICK
		db HI_JUMP_KICK
		db FORESIGHT

	db 42, HITMONCHAN, NO_ITEM
		db THUNDERPUNCH
		db ICE_PUNCH
		db FIRE_PUNCH
		db MACH_PUNCH

	db 43, ONIX, NO_ITEM
		db WRAP
		db EARTHQUAKE
		db SANDSTORM
		db ROCK_SLIDE

	db 46, MACHAMP, GOLD_BERRY
		db ROCK_SLIDE
		db FORESIGHT
		db VITAL_THROW
		db CROSS_CHOP

	db $ff ; end

; ================

	; BRUNO (2)
	db "Bruno@"
	db 3 ; item + moves

	; party

	db 62, HITMONTOP, QUICK_CLAW
		db CURSE
		db TRIPLE_KICK
		db COUNTER
		db HI_JUMP_KICK

	db 43, ONIX, SOFT_SAND
		db SCREECH
		db EARTHQUAKE
		db SANDSTORM
		db ROCK_SLIDE

	db 62, HITMONLEE, FOCUS_BAND
		db MEDITATE
		db RETURN
		db HI_JUMP_KICK
		db REVERSAL

	db 62, HITMONCHAN, NEVERMELTICE
		db THUNDERPUNCH
		db ICE_PUNCH
		db FIRE_PUNCH
		db HI_JUMP_KICK

	db 63, STEELIX, HARD_STONE
		db CURSE
		db EARTHQUAKE
		db ROCK_SLIDE
		db IRON_TAIL

	db 66, MACHAMP, LEFTOVERS
		db CURSE
		db STONE_EDGE
		db BODY_SLAM
		db CROSS_CHOP

	db $ff ; end

; ================
; ================================


KarenGroup:
; ================================
; ================

	; KAREN (1)
	db "Karen@"
	db 3 ; item + moves

	; party

	db 42, UMBREON, NO_ITEM
		db SAND_ATTACK
		db CONFUSE_RAY
		db FEINT_ATTACK
		db MEAN_LOOK

	db 42, PERSIAN, NO_ITEM
		db SLASH
		db FEINT_ATTACK
		db SCREECH
		db CHARM

	db 44, WEAVILE, NO_ITEM
		db SCREECH
		db FEINT_ATTACK
		db ICE_PUNCH
		db AGILITY

	db 45, GENGAR, NO_ITEM
		db SHADOW_BALL
		db WILL_O_WISP
		db CURSE
		db DESTINY_BOND

	db 44, HONCHKROW, NO_ITEM
		db QUICK_ATTACK
		db WHIRLWIND
		db PURSUIT
		db FEINT_ATTACK

	db 47, HOUNDOOM, GOLD_BERRY
		db ROAR
		db PURSUIT
		db FLAMETHROWER
		db DARK_PULSE

	db $ff ; end

; ================

	; KAREN (2)
	db "Karen@"
	db 3 ; item + moves

	; party

	db 62, UMBREON, LEFTOVERS
		db CHARM
		db MOONLIGHT
		db PURSUIT
		db TOXIC

	db 64, WEAVILE, KINGS_ROCK
		db SCREECH
		db SLASH
		db ICE_PUNCH
		db FEINT_ATTACK

	db 65, GENGAR, MAGNET
		db HYPNOSIS
		db THUNDER
		db SHADOW_BALL
		db DESTINY_BOND

	db 64, HONCHKROW, BLACKGLASSES
		db DRILL_PECK
		db WHIRLWIND
		db PURSUIT
		db FEINT_ATTACK

	db 63, TYRANITAR, SOFT_SAND
		db EARTHQUAKE
		db CRUNCH
		db STONE_EDGE
		db PURSUIT

	db 67, HOUNDOOM, GOLD_BERRY
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

	; CHAMPION (1)
	db "Lance@"
	db 3 ; item + moves

	; party

	db 46, GYARADOS, NO_ITEM
		db DRAGON_DANCE
		db FLY
		db WATERFALL
		db HYPER_BEAM

	db 49, DRAGONITE, NO_ITEM
		db THUNDER_WAVE
		db TWISTER
		db THUNDER
		db HYPER_BEAM

	db 49, DRAGONITE, NO_ITEM
		db SAFEGUARD
		db TWISTER
		db BLIZZARD
		db HYPER_BEAM

	db 48, AERODACTYL, NO_ITEM
		db WING_ATTACK
		db ANCIENTPOWER
		db ROCK_SLIDE
		db HYPER_BEAM

	db 48, CHARIZARD, NO_ITEM
		db FLAMETHROWER
		db WING_ATTACK
		db SLASH
		db HYPER_BEAM

	db 50, DRAGONITE, GOLD_BERRY
		db THUNDER_WAVE
		db OUTRAGE
		db FIRE_BLAST
		db HYPER_BEAM

	db $ff ; end

; ================

	; CHAMPION (2)
	db "Lance@"
	db 3 ; item + moves

	; party

	db 68, GYARADOS, QUICK_CLAW
		db DRAGON_DANCE
		db EARTHQUAKE
		db WATERFALL
		db HYPER_BEAM

	db 72, DRAGONITE, GOLD_BERRY
		db THUNDER_WAVE
		db BLIZZARD
		db THUNDER
		db LIGHT_SCREEN

	db 72, DRAGONITE, DRAGON_SCALE
		db THUNDER_WAVE
		db OUTRAGE
		db BODY_SLAM
		db HYPER_BEAM

	db 70, AERODACTYL, CHARCOAL
		db WING_ATTACK
		db ANCIENTPOWER
		db EARTHQUAKE
		db FIRE_BLAST

	db 70, CHARIZARD, KINGS_ROCK
		db FIRE_BLAST
		db SWORDS_DANCE
		db ROCK_SLIDE
		db SLASH

	db 75, DRAGONITE, LEFTOVERS
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

	; BROCK (1)
	db "Brock@"
	db 3 ; item + moves

	; party

	db 51, GRAVELER, NO_ITEM
		db DEFENSE_CURL
		db ROLLOUT
		db ROCK_SLIDE
		db EARTHQUAKE

	db 51, RHYHORN, NO_ITEM
		db SCARY_FACE
		db ROCK_SLIDE
		db EARTHQUAKE
		db HORN_DRILL

	db 53, OMASTAR, NO_ITEM
		db ANCIENTPOWER
		db SURF
		db PROTECT
		db SPIKES

	db 54, ONIX, NO_ITEM
		db IRON_TAIL
		db ROCK_SLIDE
		db EARTHQUAKE
		db SANDSTORM

	db 53, KABUTOPS, NO_ITEM
		db SLASH
		db SURF
		db ENDURE
		db GIGA_DRAIN

	db 52, AERODACTYL, NO_ITEM
		db WING_ATTACK
		db SUPERSONIC
		db ANCIENTPOWER
		db HYPER_BEAM

	db $ff ; end

; ================

	; BROCK (2)
	db "Brock@"
	db 0 ; normal

	; party
	db 64, ONIX
	db 63, RHYDON
	db 62, OMASTAR
	db 62, KABUTOPS
	db 63, AERODACTYL
	db 65, GOLEM

; ================
; ================================


MistyGroup:
; ================================
; ================

	; MISTY (1)
	db "Misty@"
	db 3 ; item + moves

	; party

	db 49, GOLDUCK, NO_ITEM
		db SCALD
		db DISABLE
		db CALM_MIND
		db PSYCHIC_M

	db 49, QUAGSIRE, NO_ITEM
		db SCALD
		db CALM_MIND
		db EARTHQUAKE
		db RAIN_DANCE

	db 52, LAPRAS, NO_ITEM
		db SURF
		db PERISH_SONG
		db BLIZZARD
		db RAIN_DANCE

	db 49, KINGLER, NO_ITEM
		db HARDEN
		db STOMP
		db PROTECT
		db CRABHAMMER

	db 52, LANTURN, NO_ITEM
		db SCALD
		db THUNDERBOLT
		db ICE_BEAM
		db CONFUSE_RAY

	db 54, STARMIE, GOLD_BERRY
		db SCALD
		db CONFUSE_RAY
		db RECOVER
		db ICE_BEAM

	db $ff ; end

; ================

	; MISTY (2)
	db "Misty@"
	db 0 ; normal

	; party
	db 63, GOLDUCK
	db 62, QUAGSIRE
	db 62, KINGLER
	db 63, AZUMARILL
	db 64, OCTILLERY
	db 65, STARMIE

; ================
; ================================


LtSurgeGroup:
; ================================
; ================

	; LT_SURGE (1)
	db "Lt.Surge@"
	db 3 ; item + moves

	; party

	db 51, ELECTABUZZ, NO_ITEM
		db QUICK_ATTACK
		db THUNDERPUNCH
		db LIGHT_SCREEN
		db WILD_CHARGE

	db 47, ELECTRODE, NO_ITEM
		db SCREECH
		db DOUBLE_TEAM
		db WILD_CHARGE
		db EXPLOSION

	db 47, MAGNEZONE, NO_ITEM
		db LOCK_ON
		db DOUBLE_TEAM
		db WILD_CHARGE
		db ZAP_CANNON

	db 47, ELECTRODE, NO_ITEM
		db SCREECH
		db DOUBLE_TEAM
		db SWIFT
		db EXPLOSION

	db 52, JOLTEON, NO_ITEM
		db WILD_CHARGE
		db THUNDER_WAVE
		db AGILITY
		db THUNDER

	db 53, RAICHU, GOLD_BERRY
		db THUNDER_WAVE
		db QUICK_ATTACK
		db WILD_CHARGE
		db THUNDER

	db $ff ; end

; ================

	; LT_SURGE (2)
	db "Lt.Surge@"
	db 0 ; normal

	; party
	db 64, ELECTABUZZ
	db 62, ELECTRODE
	db 63, JOLTEON
	db 63, LANTURN
	db 62, MAGNEZONE
	db 65, RAICHU

; ================
; ================================


ErikaGroup:
; ================================
; ================

	; ERIKA (1)
	db "Erika@"
	db 3 ; item + moves

	; party

	db 52, TANGROWTH, NO_ITEM
		db ANCIENTPOWER
		db SYNTHESIS
		db GIGA_DRAIN
		db SLEEP_POWDER

	db 51, JUMPLUFF, NO_ITEM
		db FAIRY_WIND
		db SYNTHESIS
		db LEECH_SEED
		db GIGA_DRAIN

	db 54, PARASECT, NO_ITEM
		db SPORE
		db SLASH
		db GROWTH
		db GIGA_DRAIN

	db 56, VICTREEBEL, NO_ITEM
		db SUNNY_DAY
		db SYNTHESIS
		db ACID
		db RAZOR_LEAF

	db 56, VILEPLUME, NO_ITEM
		db SUNNY_DAY
		db MOONLIGHT
		db PETAL_DANCE
		db SOLAR_BEAM

	db 56, BELLOSSOM, GOLD_BERRY
		db SUNNY_DAY
		db SYNTHESIS
		db PETAL_DANCE
		db SOLAR_BEAM

	db $ff ; end

; ================

	; ERIKA (2)
	db "Erika@"
	db 0 ; normal

	; party
	db 63, TANGROWTH
	db 62, JUMPLUFF
	db 63, VICTREEBEL
	db 64, LEAFEON
	db 64, VILEPLUME
	db 65, BELLOSSOM

; ================
; ================================


JanineGroup:
; ================================
; ================

	; JANINE (1)
	db "Janine@"
	db 3 ; item + moves

	; party

	db 47, CROBAT, NO_ITEM
		db SCREECH
		db SUPERSONIC
		db CONFUSE_RAY
		db WING_ATTACK

	db 47, ARIADOS, NO_ITEM
		db AGILITY
		db POISON_JAB
		db MEAN_LOOK
		db PSYCHIC_M

	db 46, QWILFISH, NO_ITEM
		db AQUA_TAIL
		db POISON_JAB
		db SPIKES
		db MINIMIZE

	db 44, ARIADOS, NO_ITEM
		db SCARY_FACE
		db POISON_JAB
		db MEAN_LOOK
		db GIGA_DRAIN

	db 47, WEEZING, NO_ITEM
		db SLUDGE_BOMB
		db THUNDER
		db FIRE_BLAST
		db EXPLOSION

	db 50, VENOMOTH, GOLD_BERRY
		db SLUDGE_BOMB
		db DOUBLE_TEAM
		db GUST
		db PSYCHIC_M

	db $ff ; end

; ================

	; JANINE (2)
	db "Janine@"
	db 0 ; normal

	; party
	db 63, CROBAT
	db 62, ARIADOS
	db 62, QWILFISH
	db 64, NIDOQUEEN
	db 63, WEEZING
	db 65, VENOMOTH

; ================
; ================================


SabrinaGroup:
; ================================
; ================

	; SABRINA (1)
	db "Sabrina@"
	db 3 ; item + moves

	; party

	db 53, ESPEON, NO_ITEM
		db SAND_ATTACK
		db QUICK_ATTACK
		db SWIFT
		db PSYCHIC_M

	db 54, GIRAFARIG, NO_ITEM
		db PSYCHIC_M
		db CRUNCH
		db AGILITY
		db BATON_PASS

	db 53, MR__MIME, NO_ITEM
		db BARRIER
		db REFLECT
		db BATON_PASS
		db PSYCHIC_M

	db 52, HYPNO, NO_ITEM
		db HYPNOSIS
		db DREAM_EATER
		db NIGHTMARE
		db PSYCHIC_M

	db 52, NOCTOWL, NO_ITEM
		db PSYCHIC_M
		db NIGHTMARE
		db HYPNOSIS
		db AIR_SLASH

	db 55, ALAKAZAM, GOLD_BERRY
		db RECOVER
		db FUTURE_SIGHT
		db PSYCHIC_M
		db REFLECT

	db $ff ; end

; ================

	; SABRINA (2)
	db "Sabrina@"
	db 0 ; normal

	; party
	db 64, ESPEON
	db 63, MR__MIME
	db 63, GIRAFARIG
	db 62, HYPNO
	db 64, SLOWKING
	db 65, ALAKAZAM

; ================
; ================================


BlaineGroup:
; ================================
; ================

	; BLAINE (1)
	db "Blaine@"
	db 3 ; item + moves

	; party

	db 54, MAGCARGO, NO_ITEM
		db CURSE
		db WILL_O_WISP
		db FLAMETHROWER
		db ROCK_SLIDE

	db 54, MAGMAR, NO_ITEM
		db THUNDERPUNCH
		db FIRE_PUNCH
		db SUNNY_DAY
		db CONFUSE_RAY

	db 56, ARCANINE, NO_ITEM
		db CRUNCH
		db FLAME_WHEEL
		db FLARE_BLITZ
		db TAKE_DOWN

	db 56, NINETALES, NO_ITEM
		db CONFUSE_RAY
		db FIRE_SPIN
		db FLAMETHROWER
		db WILL_O_WISP

	db 55, FLAREON, NO_ITEM
		db WILL_O_WISP
		db FLARE_BLITZ
		db QUICK_ATTACK
		db FIRE_BLAST

	db 59, RAPIDASH, GOLD_BERRY
		db QUICK_ATTACK
		db FIRE_SPIN
		db FURY_ATTACK
		db FIRE_BLAST

	db $ff ; end

	; BLAINE (2)
	db "Blaine@"
	db 0 ; normal

	; party
	db 61, MAGCARGO
	db 62, MAGMAR
	db 63, ARCANINE
	db 64, FLAREON
	db 62, TYPHLOSION
	db 65, RAPIDASH

; ================
; ================================


BlueGroup:
; ================================
; ================

	; BLUE (1)
	db "Blue@"
	db 3 ; item + moves

	; party

	db 60, PIDGEOT, SHARP_BEAK
		db QUICK_ATTACK
		db FLY
		db WING_ATTACK
		db AIR_SLASH

	db 56, MACHAMP, BLACK_BELT
		db DYNAMICPUNCH
		db EARTHQUAKE
		db STONE_EDGE
		db THUNDERPUNCH

	db 58, RHYDON, SOFT_SAND
		db FURY_ATTACK
		db SANDSTORM
		db STONE_EDGE
		db EARTHQUAKE

	db 58, GYARADOS, MYSTIC_WATER
		db STONE_EDGE
		db WATERFALL
		db DRAGON_DANCE
		db HYPER_BEAM

	db 58, EXEGGUTOR, MIRACLE_SEED
		db PSYCHIC_M
		db LEECH_SEED
		db EGG_BOMB
		db GIGA_DRAIN

	db 58, ARCANINE, CHARCOAL
		db ROAR
		db FLAME_WHEEL
		db FLAMETHROWER
		db EXTREMESPEED

	db $ff ; end

	; BLUE (2)
	db "Blue@"
	db 0 ; normal

	; party
	db 63, EXEGGUTOR
	db 62, MACHAMP
	db 64, RHYDON
	db 64, ARCANINE
	db 63, TYRANITAR
	db 65, PIDGEOT

; ================
; ================================


RedGroup:
; ================================
; ================

	; RED (1)
	db "Red@"
	db 3 ; item + moves

	; party

	db 90, PIKACHU, LIGHT_BALL
		db THUNDERBOLT
		db SURF
		db IRON_TAIL
		db THUNDER

	db 80, ESPEON, TWISTEDSPOON
		db PSYCHIC_M
		db MORNING_SUN
		db REFLECT
		db SHADOW_BALL

	db 82, SNORLAX, LEFTOVERS
		db CURSE
		db REST
		db SLEEP_TALK
		db DOUBLE_EDGE

	db 84, VENUSAUR, QUICK_CLAW
		db GIGA_DRAIN
		db SLUDGE_BOMB
		db SYNTHESIS
		db SLEEP_POWDER

	db 84, CHARIZARD, MIRACLEBERRY
		db FLAMETHROWER
		db SWORDS_DANCE
		db EARTHQUAKE
		db WING_ATTACK

	db 84, BLASTOISE, MYSTIC_WATER
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

	; LEAF (1)
	db "Green@"
	db 3 ; item + moves

	; party

	db 88, LAPRAS, LEFTOVERS
		db ICE_BEAM
		db THUNDERBOLT
		db REST
		db SLEEP_TALK

	db 90, VENUSAUR, MIRACLE_SEED
		db GROWTH
		db GIGA_DRAIN
		db SLUDGE_BOMB
		db SLEEP_POWDER

	db 89, MOLTRES, CHARCOAL
		db FIRE_BLAST
		db HIDDEN_POWER ; Grass; DVS $EE $FF
		db COUNTER
		db RETURN

	db 86, SYLVEON, BRIGHTPOWDER
		db MOONBLAST
		db LIGHT_SCREEN
		db CALM_MIND
		db HYPER_VOICE

	db 89, DRAGONITE, NEVERMELTICE
		db ICE_BEAM
		db FIRE_BLAST
		db THUNDER
		db BODY_SLAM

	db 90, BLASTOISE, MYSTIC_WATER
		db SURF
		db ICE_BEAM
		db EARTHQUAKE
		db BODY_SLAM

	db $ff ; end

; ================
; ================================


Rival1Group:
; ================================
; ================

	; RIVAL1 (1)
	db "?@"
	db 0 ; normal

	; party
	db 5, CHIKORITA

	db $ff ; end

; ================

	; RIVAL1 (2)
	db "?@"
	db 0 ; normal

	; party
	db 5, CYNDAQUIL

	db $ff ; end

; ================

	; RIVAL1 (3)
	db "?@"
	db 0 ; normal

	; party
	db 5, TOTODILE

	db $ff ; end

; ================

	; RIVAL1 (4)
	db "?@"
	db 0 ; normal

	; party
	db 14, GASTLY
	db 16, ZUBAT
	db 18, BAYLEEF

	db $ff ; end

; ================

	; RIVAL1 (5)
	db "?@"
	db 0 ; normal

	; party
	db 14, GASTLY
	db 16, ZUBAT
	db 18, QUILAVA

	db $ff ; end

; ================

	; RIVAL1 (6)
	db "?@"
	db 0 ; normal

	; party
	db 14, GASTLY
	db 16, ZUBAT
	db 18, CROCONAW

	db $ff ; end

; ================

	; RIVAL1 (7)
	db "?@"
	db 1 ; moves

	; party

	db 20, HAUNTER
		db LICK
		db WILL_O_WISP
		db MEAN_LOOK
		db CURSE

	db 18, MAGNEMITE
		db TACKLE
		db THUNDERSHOCK
		db SUPERSONIC
		db SONIC_BOOM

	db 20, ZUBAT
		db LEECH_LIFE
		db SUPERSONIC
		db BITE
		db CONFUSE_RAY

	db 22, BAYLEEF
		db GROWL
		db REFLECT
		db RAZOR_LEAF
		db POISONPOWDER

	db $ff ; end

; ================

	; RIVAL1 (8)
	db "?@"
	db 1 ; moves

	; party

	db 20, HAUNTER
		db LICK
		db WILL_O_WISP
		db MEAN_LOOK
		db CURSE

	db 18, MAGNEMITE
		db TACKLE
		db THUNDERSHOCK
		db SUPERSONIC
		db SONIC_BOOM

	db 20, ZUBAT
		db LEECH_LIFE
		db SUPERSONIC
		db BITE
		db CONFUSE_RAY

	db 22, QUILAVA
		db LEER
		db SMOKESCREEN
		db EMBER
		db QUICK_ATTACK

	db $ff ; end

; ================

	; RIVAL1 (9)
	db "?@"
	db 1 ; moves

	; party

	db 20, HAUNTER
		db LICK
		db WILL_O_WISP
		db MEAN_LOOK
		db CURSE

	db 18, MAGNEMITE
		db TACKLE
		db THUNDERSHOCK
		db SUPERSONIC
		db SONIC_BOOM

	db 20, ZUBAT
		db LEECH_LIFE
		db SUPERSONIC
		db BITE
		db CONFUSE_RAY

	db 22, CROCONAW
		db LEER
		db RAGE
		db WATER_GUN
		db BITE

	db $ff ; end

; ================

	; RIVAL1 (10)
	db "?@"
	db 1 ; moves

	; party

	db 32, GOLBAT
		db LEECH_LIFE
		db BITE
		db CONFUSE_RAY
		db WING_ATTACK

	db 30, MAGNEMITE
		db TACKLE
		db THUNDERSHOCK
		db SONIC_BOOM
		db THUNDER_WAVE

	db 30, HAUNTER
		db LICK
		db MEAN_LOOK
		db CURSE
		db SHADOW_BALL

	db 34, SNEASEL
		db LEER
		db QUICK_ATTACK
		db SCREECH
		db FEINT_ATTACK

	db 34, MEGANIUM
		db REFLECT
		db RAZOR_LEAF
		db POISONPOWDER
		db BODY_SLAM

	db $ff ; end

; ================

	; RIVAL1 (11)
	db "?@"
	db 1 ; moves

	; party

	db 32, GOLBAT
		db LEECH_LIFE
		db BITE
		db CONFUSE_RAY
		db WING_ATTACK

	db 30, MAGNEMITE
		db TACKLE
		db THUNDERSHOCK
		db SONIC_BOOM
		db THUNDER_WAVE

	db 30, HAUNTER
		db LICK
		db MEAN_LOOK
		db CURSE
		db SHADOW_BALL

	db 34, SNEASEL
		db LEER
		db QUICK_ATTACK
		db SCREECH
		db FEINT_ATTACK

	db 34, QUILAVA
		db SMOKESCREEN
		db EMBER
		db QUICK_ATTACK
		db FLAME_WHEEL

	db $ff ; end

; ================

	; RIVAL1 (12)
	db "?@"
	db 1 ; moves

	; party

	db 32, GOLBAT
		db LEECH_LIFE
		db BITE
		db CONFUSE_RAY
		db WING_ATTACK

	db 30, MAGNEMITE
		db TACKLE
		db THUNDERSHOCK
		db SONIC_BOOM
		db THUNDER_WAVE

	db 30, HAUNTER
		db LICK
		db MEAN_LOOK
		db CURSE
		db SHADOW_BALL

	db 34, SNEASEL
		db LEER
		db QUICK_ATTACK
		db SCREECH
		db FEINT_ATTACK

	db 34, FERALIGATR
		db RAGE
		db WATER_GUN
		db BITE
		db SCARY_FACE

	db $ff ; end

; ================

	; RIVAL1 (13)
	db "?@"
	db 1 ; moves

	; party

	db 36, SNEASEL
		db QUICK_ATTACK
		db SCREECH
		db FEINT_ATTACK
		db FURY_CUTTER

	db 38, GOLBAT
		db LEECH_LIFE
		db BITE
		db CONFUSE_RAY
		db WING_ATTACK

	db 37, MAGNETON
		db THUNDERSHOCK
		db SONIC_BOOM
		db THUNDER_WAVE
		db SWIFT

	db 37, HAUNTER
		db MEAN_LOOK
		db CURSE
		db SHADOW_BALL
		db CONFUSE_RAY

	db 37, KADABRA
		db DISABLE
		db PSYBEAM
		db RECOVER
		db FUTURE_SIGHT

	db 40, MEGANIUM
		db REFLECT
		db RAZOR_LEAF
		db POISONPOWDER
		db BODY_SLAM

	db $ff ; end

; ================

	; RIVAL1 (14)
	db "?@"
	db 1 ; moves

	; party

	db 36, SNEASEL
		db QUICK_ATTACK
		db SCREECH
		db FEINT_ATTACK
		db FURY_CUTTER

	db 38, GOLBAT
		db LEECH_LIFE
		db BITE
		db CONFUSE_RAY
		db WING_ATTACK

	db 37, MAGNETON
		db THUNDERSHOCK
		db SONIC_BOOM
		db THUNDER_WAVE
		db SWIFT

	db 37, HAUNTER
		db MEAN_LOOK
		db CURSE
		db SHADOW_BALL
		db CONFUSE_RAY

	db 37, KADABRA
		db DISABLE
		db PSYBEAM
		db RECOVER
		db FUTURE_SIGHT

	db 40, TYPHLOSION
		db SMOKESCREEN
		db EMBER
		db QUICK_ATTACK
		db FLAME_WHEEL

	db $ff ; end

; ================

	; RIVAL1 (15)
	db "?@"
	db 1 ; moves

	; party

	db 36, SNEASEL
		db QUICK_ATTACK
		db SCREECH
		db FEINT_ATTACK
		db FURY_CUTTER

	db 38, GOLBAT
		db LEECH_LIFE
		db BITE
		db CONFUSE_RAY
		db WING_ATTACK

	db 37, MAGNETON
		db THUNDERSHOCK
		db SONIC_BOOM
		db THUNDER_WAVE
		db SWIFT

	db 37, HAUNTER
		db MEAN_LOOK
		db CURSE
		db SHADOW_BALL
		db CONFUSE_RAY

	db 37, KADABRA
		db DISABLE
		db PSYBEAM
		db RECOVER
		db FUTURE_SIGHT

	db 40, FERALIGATR
		db RAGE
		db SURF
		db SCARY_FACE
		db SLASH

	db $ff ; end

; ================
; ================================


Rival2Group:
; ================================
; ================

	; RIVAL2 (1)
	db "?@"
	db 1 ; moves

	; party

	db 46, WEAVILE
		db QUICK_ATTACK
		db SCREECH
		db FEINT_ATTACK
		db FURY_CUTTER

	db 47, GOLBAT
		db LEECH_LIFE
		db BITE
		db CONFUSE_RAY
		db WING_ATTACK

	db 46, MAGNEZONE
		db THUNDERSHOCK
		db SONIC_BOOM
		db THUNDER_WAVE
		db SWIFT

	db 48, GENGAR
		db MEAN_LOOK
		db CURSE
		db SHADOW_BALL
		db CONFUSE_RAY

	db 48, ALAKAZAM
		db DISABLE
		db RECOVER
		db FUTURE_SIGHT
		db PSYCHIC_M

	db 50, MEGANIUM
		db RAZOR_LEAF
		db POISONPOWDER
		db BODY_SLAM
		db LIGHT_SCREEN

	db $ff ; end

; ================

	; RIVAL2 (2)
	db "?@"
	db 1 ; moves

	; party

	db 46, WEAVILE
		db QUICK_ATTACK
		db SCREECH
		db FEINT_ATTACK
		db FURY_CUTTER

	db 47, GOLBAT
		db LEECH_LIFE
		db BITE
		db CONFUSE_RAY
		db WING_ATTACK

	db 46, MAGNEZONE
		db THUNDERSHOCK
		db SONIC_BOOM
		db THUNDER_WAVE
		db SWIFT

	db 48, GENGAR
		db MEAN_LOOK
		db CURSE
		db SHADOW_BALL
		db CONFUSE_RAY

	db 48, ALAKAZAM
		db DISABLE
		db RECOVER
		db FUTURE_SIGHT
		db PSYCHIC_M

	db 50, TYPHLOSION
		db SMOKESCREEN
		db QUICK_ATTACK
		db FLAME_WHEEL
		db SWIFT

	db $ff ; end

; ================

	; RIVAL2 (3)
	db "?@"
	db 1 ; moves

	; party

	db 46, WEAVILE
		db QUICK_ATTACK
		db SCREECH
		db FEINT_ATTACK
		db FURY_CUTTER

	db 47, GOLBAT
		db LEECH_LIFE
		db BITE
		db CONFUSE_RAY
		db WING_ATTACK

	db 46, MAGNEZONE
		db THUNDERSHOCK
		db SONIC_BOOM
		db THUNDER_WAVE
		db SWIFT

	db 48, GENGAR
		db MEAN_LOOK
		db CURSE
		db SHADOW_BALL
		db CONFUSE_RAY

	db 48, ALAKAZAM
		db DISABLE
		db RECOVER
		db FUTURE_SIGHT
		db PSYCHIC_M

	db 50, FERALIGATR
		db RAGE
		db WATER_GUN
		db SCARY_FACE
		db SLASH

	db $ff ; end

; ================

	; RIVAL2 (4)
	db "?@"
	db 1 ; moves

	; party

	db 45, WEAVILE
		db QUICK_ATTACK
		db SCREECH
		db FEINT_ATTACK
		db FURY_CUTTER

	db 48, CROBAT
		db TOXIC
		db BITE
		db CONFUSE_RAY
		db WING_ATTACK

	db 45, MAGNEZONE
		db THUNDER
		db SONIC_BOOM
		db THUNDER_WAVE
		db SWIFT

	db 46, GENGAR
		db MEAN_LOOK
		db CURSE
		db SHADOW_BALL
		db CONFUSE_RAY

	db 46, ALAKAZAM
		db RECOVER
		db FUTURE_SIGHT
		db PSYCHIC_M
		db REFLECT

	db 50, MEGANIUM
		db GIGA_DRAIN
		db BODY_SLAM
		db LIGHT_SCREEN
		db SAFEGUARD

	db $ff ; end

; ================

	; RIVAL2 (5)
	db "?@"
	db 1 ; moves

	; party

	db 45, WEAVILE
		db QUICK_ATTACK
		db SCREECH
		db FEINT_ATTACK
		db FURY_CUTTER

	db 48, CROBAT
		db TOXIC
		db BITE
		db CONFUSE_RAY
		db WING_ATTACK

	db 45, MAGNEZONE
		db THUNDER
		db SONIC_BOOM
		db THUNDER_WAVE
		db SWIFT

	db 46, GENGAR
		db MEAN_LOOK
		db CURSE
		db SHADOW_BALL
		db CONFUSE_RAY

	db 46, ALAKAZAM
		db RECOVER
		db FUTURE_SIGHT
		db PSYCHIC_M
		db REFLECT

	db 50, TYPHLOSION
		db SMOKESCREEN
		db QUICK_ATTACK
		db FIRE_BLAST
		db SWIFT

	db $ff ; end

; ================

	; RIVAL2 (6)
	db "?@"
	db 1 ; moves

	; party

	db 45, WEAVILE
		db QUICK_ATTACK
		db SCREECH
		db FEINT_ATTACK
		db FURY_CUTTER

	db 48, CROBAT
		db TOXIC
		db BITE
		db CONFUSE_RAY
		db WING_ATTACK

	db 45, MAGNEZONE
		db THUNDER
		db SONIC_BOOM
		db THUNDER_WAVE
		db SWIFT

	db 46, GENGAR
		db MEAN_LOOK
		db CURSE
		db SHADOW_BALL
		db CONFUSE_RAY

	db 46, ALAKAZAM
		db RECOVER
		db FUTURE_SIGHT
		db PSYCHIC_M
		db REFLECT

	db 50, FERALIGATR
		db SURF
		db RAIN_DANCE
		db SLASH
		db SCREECH

	db $ff ; end

; ================
; ================================


PKMNTrainerGroup:
; ================================
; ================

	; CAL (1)
	db "Cal@"
	db 3 ; item + moves

	; party

	db 50, MEGANIUM, GOLD_BERRY
		db GIGA_DRAIN
		db PROTECT
		db LEECH_SEED
		db TOXIC

	db 50, TYPHLOSION, QUICK_CLAW
		db SUNNY_DAY
		db THUNDERPUNCH
		db FLAMETHROWER
		db SUBSTITUTE

	db 50, FERALIGATR, MIRACLEBERRY
		db SURF
		db CRUNCH
		db ICE_PUNCH
		db ROCK_SLIDE

	db 50, STEELIX, MINT_BERRY
		db IRON_TAIL
		db ROCK_SLIDE
		db EARTHQUAKE
		db REST

	db 50, UMBREON, LEFTOVERS
		db CONFUSE_RAY
		db CURSE
		db FEINT_ATTACK
		db PROTECT

	db 50, CLEFABLE, PINK_BOW
		db SING
		db MOONLIGHT
		db METRONOME
		db MOONBLAST

	db $ff ; end

; ================

	; CAL (2)
	db "Cal@"
	db 0 ; normal

	; party
	db 50, BLISSEY

	db $ff ; end

; ================
; ================================


YoungsterGroup:
; ================================
; ================

	; YOUNGSTER (1)
	db "Joey@"
	db 0 ; normal

	; party
	db 4, RATTATA

	db $ff ; end

; ================

	; YOUNGSTER (2)
	db "Mikey@"
	db 0 ; normal

	; party
	db 2, PIDGEY
	db 4, RATTATA

	db $ff ; end

; ================

	; YOUNGSTER (3)
	db "Albert@"
	db 0 ; normal

	; party
	db 6, RATTATA
	db 8, ZUBAT

	db $ff ; end

; ================

	; YOUNGSTER (4)
	db "Gordon@"
	db 0 ; normal

	; party
	db 10, WOOPER

	db $ff ; end

; ================

	; YOUNGSTER (5)
	db "Samuel@"
	db 0 ; normal

	; party
	db 7, RATTATA
	db 10, SANDSHREW
	db 8, PIDGEY
	db 8, RATTATA

	db $ff ; end

; ================

	; YOUNGSTER (6)
	db "Ian@"
	db 0 ; normal

	; party
	db 10, MANKEY
	db 12, DIGLETT

	db $ff ; end

; ================

	; YOUNGSTER (7)
	db "Joey@"
	db 0 ; normal

	; party
	db 15, RATTATA

	db $ff ; end

; ================

	; YOUNGSTER (8)
	db "Joey@"
	db 1 ; moves

	; party

	db 21, RATICATE
		db TAIL_WHIP
		db QUICK_ATTACK
		db HYPER_FANG
		db SCARY_FACE

	db $ff ; end

; ================

	; YOUNGSTER (9)
	db "Warren@"
	db 0 ; normal

	; party
	db 38, PIDGEOTTO
	db 42, RATICATE

	db $ff ; end

; ================

	; YOUNGSTER (10)
	db "Jimmy@"
	db 0 ; normal

	; party
	db 42, RATICATE
	db 42, ARBOK
	db 42, PARASECT

	db $ff ; end

; ================

	; YOUNGSTER (11)
	db "Owen@"
	db 0 ; normal

	; party
	db 44, GROWLITHE

	db $ff ; end

; ================

	; YOUNGSTER (12)
	db "Jason@"
	db 0 ; normal

	; party
	db 42, SANDSLASH
	db 42, CROBAT

	db $ff ; end

; ================

	; YOUNGSTER (13)
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

	; YOUNGSTER (14)
	db "Joey@"
	db 1 ; moves

	; party

	db 37, RATICATE
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

	; BUG_CATCHER (1)
	db "Don@"
	db 0 ; normal

	; party
	db 3, CATERPIE
	db 3, CATERPIE

	db $ff ; end

; ================

	; BUG_CATCHER (2)
	db "Rob@"
	db 0 ; normal

	; party
	db 40, BEEDRILL
	db 39, BUTTERFREE

	db $ff ; end

; ================

	; BUG_CATCHER (3)
	db "Ed@"
	db 0 ; normal

	; party
	db 43, YANMA
	db 43, BEEDRILL
	db 43, BUTTERFREE

	db $ff ; end

; ================

	; BUG_CATCHER (4)
	db "Wade@"
	db 0 ; normal

	; party
	db 2, CATERPIE
	db 2, CATERPIE
	db 3, WEEDLE
	db 2, CATERPIE

	db $ff ; end

; ================

	; BUG_CATCHER (5)
	db "Benny@"
	db 0 ; normal

	; party
	db 7, WEEDLE
	db 9, KAKUNA
	db 12, BEEDRILL

	db $ff ; end

; ================

	; BUG_CATCHER (6)
	db "Al@"
	db 0 ; normal

	; party
	db 12, CATERPIE
	db 12, WEEDLE

	db $ff ; end

; ================

	; BUG_CATCHER (7)
	db "Josh@"
	db 0 ; normal

	; party
	db 13, PARAS

	db $ff ; end

; ================

	; BUG_CATCHER (8)
	db "Arnie@"
	db 0 ; normal

	; party
	db 15, VENONAT

	db $ff ; end

; ================

	; BUG_CATCHER (9)
	db "Ken@"
	db 0 ; normal

	; party
	db 30, ARIADOS
	db 32, PINSIR

	db $ff ; end

; ================

	; BUG_CATCHER (10)
	db "Wade@"
	db 0 ; normal

	; party
	db 9, METAPOD
	db 9, METAPOD
	db 10, KAKUNA
	db 9, METAPOD

	db $ff ; end

; ================

	; BUG_CATCHER (11)
	db "Wade@"
	db 0 ; normal

	; party
	db 14, BUTTERFREE
	db 14, BUTTERFREE
	db 15, BEEDRILL
	db 14, BUTTERFREE

	db $ff ; end

; ================

	; BUG_CATCHER (12)
	db "Doug@"
	db 0 ; normal

	; party
	db 39, BUTTERFREE
	db 37, ARIADOS

	db $ff ; end

; ================

	; BUG_CATCHER (13)
	db "Arnie@"
	db 0 ; normal

	; party
	db 19, VENONAT

	db $ff ; end

; ================

	; BUG_CATCHER (14)
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

	; BUG_CATCHER (15)
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

	; BUG_CATCHER (16)
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

	; BUG_CATCHER (17)
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

	; BUG_CATCHER (18)
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

	; BUG_CATCHER (19)
	db "Wayne@"
	db 0 ; normal

	; party
	db 8, LEDYBA
	db 10, PARAS

	db $ff ; end

; ================

	; BUG_CATCHER (20)
	db "Dane@"
	db 0 ; normal

	; party
	db 44, BEEDRILL
	db 48, BUTTERFREE

	db $ff ; end

; ================

	; BUG_CATCHER (21)
	db "Dion@"
	db 0 ; normal

	; party
	db 50, ARIADOS

	db $ff ; end

; ================

	; BUG_CATCHER (22)
	db "Stacey@"
	db 0 ; normal

	; party
	db 52, METAPOD
	db 56, METAPOD
	db 60, METAPOD

	db $ff ; end

; ================

	; BUG_CATCHER (23)
	db "Ellis@"
	db 0 ; normal

	; party
	db 28, WEEDLE
	db 38, KAKUNA
	db 48, BEEDRILL

	db $ff ; end

; ================

	; BUG_CATCHER (34)
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

	; CAMPER (1)
	db "Roland@"
	db 0 ; normal

	; party
	db 9, NIDORAN_M

	db $ff ; end

; ================

	; CAMPER (2)
	db "Todd@"
	db 0 ; normal

	; party
	db 14, PSYDUCK

	db $ff ; end

; ================

	; CAMPER (3)
	db "Ivan@"
	db 0 ; normal

	; party
	db 10, DIGLETT
	db 10, ZUBAT
	db 14, DIGLETT

	db $ff ; end

; ================

	; CAMPER (4)
	db "Elliot@"
	db 0 ; normal

	; party
	db 13, SANDSHREW
	db 15, MARILL

	db $ff ; end

; ================

	; CAMPER (5)
	db "Barry@"
	db 0 ; normal

	; party
	db 48, NIDOKING

	db $ff ; end

; ================

	; CAMPER (6)
	db "Lloyd@"
	db 0 ; normal

	; party
	db 46, NIDOKING

	db $ff ; end

; ================

	; CAMPER (7)
	db "Dean@"
	db 0 ; normal

	; party
	db 44, GOLDUCK
	db 42, SANDSLASH

	db $ff ; end

; ================

	; CAMPER (8)
	db "Sid@"
	db 0 ; normal

	; party
	db 43, DUGTRIO
	db 40, PRIMEAPE
	db 40, POLIWRATH

	db $ff ; end

; ================

	; CAMPER (9)
	db "Harvey@"
	db 0 ; normal

	; party
	db 15, NIDORINO

	db $ff ; end

; ================

	; CAMPER (10)
	db "Dale@"
	db 0 ; normal

	; party
	db 15, NIDORINO

	db $ff ; end

; ================

	; CAMPER (11)
	db "Ted@"
	db 0 ; normal

	; party
	db 17, MANKEY

	db $ff ; end

; ================

	; CAMPER (12)
	db "Todd@"
	db 0 ; normal

	; party
	db 17, GEODUDE
	db 17, GEODUDE
	db 23, PSYDUCK

	db $ff ; end

; ================

	; CAMPER (13)
	db "Todd@"
	db 0 ; normal

	; party
	db 23, GEODUDE
	db 23, GEODUDE
	db 26, PSYDUCK

	db $ff ; end

; ================

	; CAMPER (14)
	db "Thomas@"
	db 0 ; normal

	; party
	db 33, GRAVELER
	db 36, GRAVELER
	db 40, GOLBAT
	db 42, GOLDUCK

	db $ff ; end

; ================

	; CAMPER (15)
	db "Leroy@"
	db 0 ; normal

	; party
	db 33, GRAVELER
	db 36, GRAVELER
	db 40, GOLBAT
	db 42, GOLDUCK

	db $ff ; end

; ================

	; CAMPER (16)
	db "David@"
	db 0 ; normal

	; party
	db 33, GRAVELER
	db 36, GRAVELER
	db 40, GOLBAT
	db 42, GOLDUCK

	db $ff ; end

; ================

	; CAMPER (17)
	db "John@"
	db 0 ; normal

	; party
	db 33, GRAVELER
	db 36, GRAVELER
	db 40, GOLBAT
	db 42, GOLDUCK

	db $ff ; end

; ================

	; CAMPER (18)
	db "Jerry@"
	db 0 ; normal

	; party
	db 50, RHYDON

	db $ff ; end

; ================

	; CAMPER (19)
	db "Spencer@"
	db 0 ; normal

	; party
	db 18, SANDSHREW
	db 18, SANDSLASH
	db 20, ZUBAT

	db $ff ; end

; ================

	; CAMPER (20)
	db "Todd@"
	db 0 ; normal

	; party
	db 30, GRAVELER
	db 30, GRAVELER
	db 30, SLUGMA
	db 32, PSYDUCK

	db $ff ; end

; ================

	; CAMPER (21)
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

	; CAMPER (22)
	db "Quentin@"
	db 0 ; normal

	; party
	db 30, PIDGEOTTO
	db 30, PRIMEAPE
	db 30, TAUROS

	db $ff ; end

; ================

	; CAMPER (23)
	db "Grant@"
	db 0 ; normal

	; party
	db 21, SKIPLOOM
	db 21, MARILL

	db $ff ; end

; ================
; ================================


PicnickerGroup:
; ================================
; ================

	; PICNICKER (1)
	db "Liz@"
	db 0 ; normal

	; party
	db 9, NIDORAN_F

	db $ff ; end

; ================

	; PICNICKER (2)
	db "Gina@"
	db 0 ; normal

	; party
	db 9, HOPPIP
	db 9, HOPPIP
	db 12, BULBASAUR

	db $ff ; end

; ================

	; PICNICKER (3)
	db "Brooke@"
	db 1 ; moves

	; party

	db 16, PIKACHU
		db THUNDERSHOCK
		db GROWL
		db QUICK_ATTACK
		db DOUBLE_TEAM

	db $ff ; end

; ================

	; PICNICKER (4)
	db "Kim@"
	db 0 ; normal

	; party
	db 15, VULPIX

	db $ff ; end

; ================

	; PICNICKER (5)
	db "Cindy@"
	db 0 ; normal

	; party
	db 48, NIDOQUEEN

	db $ff ; end

; ================

	; PICNICKER (6)
	db "Hope@"
	db 0 ; normal

	; party
	db 44, FLAAFFY

	db $ff ; end

; ================

	; PICNICKER (7)
	db "Sharon@"
	db 0 ; normal

	; party
	db 41, FURRET
	db 43, RAPIDASH

	db $ff ; end

; ================

	; PICNICKER (8)
	db "Debra@"
	db 0 ; normal

	; party
	db 41, AZUMARILL

	db $ff ; end

; ================

	; PICNICKER (9)
	db "Gina@"
	db 0 ; normal

	; party
	db 14, HOPPIP
	db 14, HOPPIP
	db 17, IVYSAUR

	db $ff ; end

; ================

	; PICNICKER (10)
	db "Erin@"
	db 0 ; normal

	; party
	db 17, PONYTA
	db 16, ODDISH

	db $ff ; end

; ================

	; PICNICKER (11)
	db "Liz@"
	db 0 ; normal

	; party
	db 15, WEEPINBELL
	db 15, NIDORINA

	db $ff ; end

; ================

	; PICNICKER (12)
	db "Liz@"
	db 0 ; normal

	; party
	db 19, WEEPINBELL
	db 19, NIDORINO
	db 21, NIDOQUEEN

	db $ff ; end

; ================

	; PICNICKER (13)
	db "Heidi@"
	db 0 ; normal

	; party
	db 43, SKIPLOOM
	db 43, SKIPLOOM

	db $ff ; end

; ================

	; PICNICKER (14)
	db "Edna@"
	db 0 ; normal

	; party
	db 41, NIDORINA
	db 45, RAICHU

	db $ff ; end

; ================

	; PICNICKER (15)
	db "Gina@"
	db 0 ; normal

	; party
	db 26, SKIPLOOM
	db 26, SKIPLOOM
	db 29, IVYSAUR

	db $ff ; end

; ================

	; PICNICKER (16)
	db "Tiffany@"
	db 1 ; moves

	; party

	db 32, CLEFAIRY
		db ENCORE
		db SING
		db DOUBLE_SLAP
		db MINIMIZE

	db $ff ; end

; ================

	; PICNICKER (17)
	db "Tiffany@"
	db 1 ; moves

	; party

	db 38, CLEFAIRY
		db ENCORE
		db DOUBLE_SLAP
		db MINIMIZE
		db METRONOME

	db $ff ; end

; ================

	; PICNICKER (18)
	db "Erin@"
	db 0 ; normal

	; party
	db 32, PONYTA
	db 32, GLOOM

	db $ff ; end

; ================

	; PICNICKER (19)
	db "Tanya@"
	db 0 ; normal

	; party
	db 49, EXEGGUTOR

	db $ff ; end

; ================

	; PICNICKER (20)
	db "Tiffany@"
	db 1 ; moves

	; party

	db 21, CLEFAIRY
		db ENCORE
		db SING
		db DOUBLE_SLAP
		db MINIMIZE

	db $ff ; end

; ================

	; PICNICKER (21)
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

	; PICNICKER (22)
	db "Liz@"
	db 0 ; normal

	; party
	db 24, WEEPINBELL
	db 26, NIDORINO
	db 26, NIDOQUEEN

	db $ff ; end

; ================

	; PICNICKER (23)
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

	; PICNICKER (24)
	db "Gina@"
	db 0 ; normal

	; party
	db 30, SKIPLOOM
	db 30, SKIPLOOM
	db 32, IVYSAUR

	db $ff ; end

; ================

	; PICNICKER (25)
	db "Gina@"
	db 1 ; moves

	; party

	db 33, JUMPLUFF
		db SUNNY_DAY
		db STUN_SPORE
		db LEECH_SEED
		db SYNTHESIS

	db 33, JUMPLUFF
		db SUNNY_DAY
		db SLEEP_POWDER
		db LEECH_SEED
		db SYNTHESIS

	db 38, VENUSAUR
		db SOLAR_BEAM
		db RAZOR_LEAF
		db HEADBUTT
		db MUD_SLAP

	db $ff ; end

; ================

	; PICNICKER (26)
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

	; TWINS (1)
	db "Amy & Mimi@"
	db 0 ; normal

	; party
	db 10, SPINARAK
	db 10, LEDYBA

	db $ff ; end

; ================

	; TWINS (2)
	db "Tori & Til@"
	db 1 ; moves

	; party

	db 16, CLEFAIRY
		db GROWL
		db ENCORE
		db DOUBLE_SLAP
		db METRONOME

	db 16, JIGGLYPUFF
		db SING
		db DEFENSE_CURL
		db POUND
		db DISABLE

	db $ff ; end

; ================

	; TWINS (3)
	db "Ann & Anne@"
	db 1 ; moves

	; party

	db 16, JIGGLYPUFF
		db SING
		db DEFENSE_CURL
		db POUND
		db DISABLE

	db 16, CLEFAIRY
		db GROWL
		db ENCORE
		db DOUBLE_SLAP
		db METRONOME

	db $ff ; end

; ================

	; TWINS (4)
	db "Amy & May@"
	db 0 ; normal

	; party
	db 10, LEDYBA
	db 10, SPINARAK

	db $ff ; end

; ================

	; TWINS (5)
	db "Jo & Zoe@"
	db 0 ; normal

	; party
	db 47, VICTREEBEL
	db 47, VILEPLUME

	db $ff ; end

; ================

	; TWINS (6)
	db "Jo & Zoe@"
	db 0 ; normal

	; party
	db 35, VILEPLUME
	db 35, VICTREEBEL

	db $ff ; end

; ================

	; TWINS (7)
	db "Meg & Peg@"
	db 0 ; normal

	; party
	db 39, TEDDIURSA
	db 39, PHANPY

	db $ff ; end

; ================

	; TWINS (8)
	db "Meg & Peg@"
	db 0 ; normal

	; party
	db 31, PHANPY
	db 31, TEDDIURSA

	db $ff ; end

; ================

	; TWINS (9)
	db "Lea & Pia@"
	db 1 ; moves

	; party

	db 35, DRATINI
		db THUNDER_WAVE
		db TWISTER
		db FLAMETHROWER
		db HEADBUTT

	db 35, DRATINI
		db THUNDER_WAVE
		db TWISTER
		db ICE_BEAM
		db HEADBUTT

	db $ff ; end

; ================

	; TWINS (10)
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

	; TWINS (11)
	db "Day & Dani@"
	db 0 ; normal

	; party
	db 41, PIKACHU
	db 41, PIKACHU

	db $ff ; end

; ================

	; TWINS (12)
	db "Day & Dani@"
	db 0 ; normal

	; party
	db 41, PIKACHU
	db 41, PIKACHU

	db $ff ; end

; ================

	; TWINS (13)
	db "Kay & Tia@"
	db 0 ; normal

	; party
	db 41, QUAGSIRE
	db 41, QUAGSIRE

	db $ff ; end

; ================

	; TWINS (14)
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

	; FISHER (1)
	db "Justin@"
	db 0 ; normal

	; party
	db 5, MAGIKARP
	db 5, MAGIKARP
	db 15, MAGIKARP
	db 5, MAGIKARP

	db $ff ; end

; ================

	; FISHER (2)
	db "Ralph@"
	db 0 ; normal

	; party
	db 10, CHINCHOU

	db $ff ; end

; ================

	; FISHER (3)
	db "Arnold@"
	db 0 ; normal

	; party
	db 44, SHELLDER

	db $ff ; end

; ================

	; FISHER (4)
	db "Kyle@"
	db 0 ; normal

	; party
	db 39, POLIWHIRL
	db 35, QWILFISH
	db 39, GYARADOS

	db $ff ; end

; ================

	; FISHER (5)
	db "Henry@"
	db 0 ; normal

	; party
	db 8, POLIWAG
	db 8, POLIWAG

	db $ff ; end

; ================

	; FISHER (6)
	db "Marvin@"
	db 0 ; normal

	; party
	db 10, MAGIKARP
	db 15, MAGIKARP
	db 20, GYARADOS

	db $ff ; end

; ================

	; FISHER (7)
	db "Tully@"
	db 0 ; normal

	; party
	db 19, QWILFISH

	db $ff ; end

; ================

	; FISHER (8)
	db "Andre@"
	db 0 ; normal

	; party
	db 27, GYARADOS

	db $ff ; end

; ================

	; FISHER (9)
	db "Raymond@"
	db 1 ; moves

	; party

	db 22, MAGIKARP
		db SPLASH
		db TACKLE
		db DRAGON_RAGE
		db NO_MOVE

	db 22, MAGIKARP
		db SPLASH
		db TACKLE
		db DRAGON_RAGE
		db NO_MOVE

	db 22, MAGIKARP
		db SPLASH
		db TACKLE
		db DRAGON_RAGE
		db NO_MOVE

	db 22, MAGIKARP
		db SPLASH
		db TACKLE
		db DRAGON_RAGE
		db NO_MOVE

	db $ff ; end

; ================

	; FISHER (10)
	db "Wilton@"
	db 0 ; normal

	; party
	db 26, QWILFISH
	db 26, REMORAID
	db 28, GYARADOS

	db $ff ; end

; ================

	; FISHER (11)
	db "Edgar@"
	db 1 ; moves

	; party

	db 28, REMORAID
		db LOCK_ON
		db PSYBEAM
		db AURORA_BEAM
		db BUBBLE_BEAM

	db 28, REMORAID
		db LOCK_ON
		db PSYBEAM
		db AURORA_BEAM
		db BUBBLE_BEAM

	db $ff ; end

; ================

	; FISHER (12)
	db "Jonah@"
	db 0 ; normal

	; party
	db 25, SHELLDER
	db 29, OCTILLERY
	db 25, REMORAID
	db 29, CLOYSTER

	db $ff ; end

; ================

	; FISHER (13)
	db "Martin@"
	db 0 ; normal

	; party
	db 36, REMORAID
	db 42, OCTILLERY

	db $ff ; end

; ================

	; FISHER (14)
	db "Stephen@"
	db 0 ; normal

	; party
	db 45, MAGIKARP
	db 43, QUAGSIRE
	db 38, QWILFISH
	db 38, TENTACRUEL

	db $ff ; end

; ================

	; FISHER (15)
	db "Barney@"
	db 0 ; normal

	; party
	db 40, GYARADOS
	db 37, GYARADOS
	db 37, GYARADOS

	db $ff ; end

; ================

	; FISHER (16)
	db "Ralph@"
	db 0 ; normal

	; party
	db 17, CHINCHOU

	db $ff ; end

; ================

	; FISHER (17)
	db "Ralph@"
	db 0 ; normal

	; party
	db 17, QWILFISH
	db 19, CHINCHOU

	db $ff ; end

; ================

	; FISHER (18)
	db "Tully@"
	db 0 ; normal

	; party
	db 23, QWILFISH

	db $ff ; end

; ================

	; FISHER (19)
	db "Tully@"
	db 0 ; normal

	; party
	db 32, POLIWHIRL
	db 32, QWILFISH
	db 32, QWILFISH

	db $ff ; end

; ================

	; FISHER (20)
	db "Wilton@"
	db 0 ; normal

	; party
	db 32, QWILFISH
	db 32, REMORAID
	db 36, GYARADOS

	db $ff ; end

; ================

	; FISHER (21)
	db "Scott@"
	db 0 ; normal

	; party
	db 30, QWILFISH
	db 30, QWILFISH
	db 34, GYARADOS

	db $ff ; end

; ================

	; FISHER (22)
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

	; FISHER (23)
	db "Ralph@"
	db 0 ; normal

	; party
	db 30, QWILFISH
	db 32, LANTURN

	db $ff ; end

; ================

	; FISHER (24)
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

	; FISHER (25)
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

	; BIRD_KEEPER (1)
	db "Rod@"
	db 0 ; normal

	; party
	db 7, PIDGEY
	db 7, PIDGEY

	db $ff ; end

; ================

	; BIRD_KEEPER (2)
	db "Abe@"
	db 0 ; normal

	; party
	db 9, PIDGEY

	db $ff ; end

; ================

	; BIRD_KEEPER (3)
	db "Bryan@"
	db 0 ; normal

	; party
	db 12, PIDGEY
	db 14, PIDGEOTTO

	db $ff ; end

; ================

	; BIRD_KEEPER (4)
	db "Theo@"
	db 0 ; normal

	; party
	db 17, PIDGEY
	db 15, PIDGEY
	db 19, PIDGEY
	db 15, PIDGEY
	db 15, PIDGEY

	db $ff ; end

; ================

	; BIRD_KEEPER (5)
	db "Toby@"
	db 0 ; normal

	; party
	db 16, DODUO
	db 17, DODUO
	db 18, DODUO

	db $ff ; end

; ================

	; BIRD_KEEPER (6)
	db "Denis@"
	db 0 ; normal

	; party
	db 18, PIDGEY
	db 20, PIDGEOTTO
	db 18, FARFETCH_D

	db $ff ; end

; ================

	; BIRD_KEEPER (7)
	db "Vance@"
	db 0 ; normal

	; party
	db 28, PIDGEOTTO
	db 28, PIDGEOTTO

	db $ff ; end

; ================

	; BIRD_KEEPER (8)
	db "Hank@"
	db 0 ; normal

	; party
	db 13, PIDGEY
	db 44, PIDGEOT

	db $ff ; end

; ================

	; BIRD_KEEPER (9)
	db "Roy@"
	db 0 ; normal

	; party
	db 38, PIDGEOTTO
	db 44, PIDGEOT

	db $ff ; end

; ================

	; BIRD_KEEPER (10)
	db "Boris@"
	db 0 ; normal

	; party
	db 39, DODUO
	db 37, DODUO
	db 41, DODRIO

	db $ff ; end

; ================

	; BIRD_KEEPER (11)
	db "Bob@"
	db 0 ; normal

	; party
	db 48, NOCTOWL

	db $ff ; end

; ================

	; BIRD_KEEPER (12)
	db "Jose@"
	db 0 ; normal

	; party
	db 40, FARFETCH_D

	db $ff ; end

; ================

	; BIRD_KEEPER (13)
	db "Peter@"
	db 0 ; normal

	; party
	db 6, PIDGEY
	db 6, PIDGEY
	db 8, HOOTHOOT

	db $ff ; end

; ================

	; BIRD_KEEPER (14)
	db "Jose@"
	db 0 ; normal

	; party
	db 44, FARFETCH_D

	db $ff ; end

; ================

	; BIRD_KEEPER (15)
	db "Perry@"
	db 0 ; normal

	; party
	db 42, FARFETCH_D

	db $ff ; end

; ================

	; BIRD_KEEPER (16)
	db "Bret@"
	db 0 ; normal

	; party
	db 41, PIDGEOTTO
	db 41, FARFETCH_D

	db $ff ; end

; ================

	; BIRD_KEEPER (17)
	db "Jose@"
	db 1 ; moves

	; party

	db 48, FARFETCH_D
		db SWORDS_DANCE
		db SLASH
		db PROTECT
		db FLY

	db $ff ; end

; ================

	; BIRD_KEEPER (18)
	db "Vance@"
	db 0 ; normal

	; party
	db 32, PIDGEOTTO
	db 32, PIDGEOTTO

	db $ff ; end

; ================

	; BIRD_KEEPER (19)
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

	; HIKER (1)
	db "Anthony@"
	db 0 ; normal

	; party
	db 16, GEODUDE
	db 18, MACHOKE

	db $ff ; end

; ================

	; HIKER (2)
	db "Russell@"
	db 0 ; normal

	; party
	db 4, GEODUDE
	db 6, GEODUDE
	db 8, GEODUDE

	db $ff ; end

; ================

	; HIKER (3)
	db "Phillip@"
	db 0 ; normal

	; party
	db 23, GEODUDE
	db 23, GEODUDE
	db 25, GRAVELER

	db $ff ; end

; ================

	; HIKER (4)
	db "Leonard@"
	db 0 ; normal

	; party
	db 23, GEODUDE
	db 25, MACHOP

	db $ff ; end

; ================

	; HIKER (5)
	db "Anthony@"
	db 0 ; normal

	; party
	db 11, GEODUDE
	db 11, MACHOP

	db $ff ; end

; ================

	; HIKER (6)
	db "Benjamin@"
	db 0 ; normal

	; party
	db 15, DIGLETT
	db 15, GEODUDE
	db 17, DUGTRIO

	db $ff ; end

; ================

	; HIKER (7)
	db "Erik@"
	db 0 ; normal

	; party
	db 24, MACHOP
	db 27, GRAVELER
	db 27, MACHOP

	db $ff ; end

; ================

	; HIKER (8)
	db "Michael@"
	db 0 ; normal

	; party
	db 25, GEODUDE
	db 25, GRAVELER
	db 25, GOLEM

	db $ff ; end

; ================

	; HIKER (9)
	db "Parry@"
	db 0 ; normal

	; party
	db 36, ONIX
	db 34, SWINUB

	db $ff ; end

; ================

	; HIKER (10)
	db "Timothy@"
	db 1 ; moves

	; party

	db 27, DIGLETT
		db MAGNITUDE
		db DIG
		db SAND_ATTACK
		db SLASH

	db 27, DUGTRIO
		db MAGNITUDE
		db DIG
		db SAND_ATTACK
		db SLASH

	db $ff ; end

; ================

	; HIKER (11)
	db "Bailey@"
	db 0 ; normal

	; party
	db 13, GEODUDE
	db 13, GEODUDE
	db 13, GEODUDE
	db 13, GEODUDE
	db 13, GEODUDE

	db $ff ; end

; ================

	; HIKER (12)
	db "Anthony@"
	db 0 ; normal

	; party
	db 25, GRAVELER
	db 27, GRAVELER
	db 29, MACHOKE

	db $ff ; end

; ================

	; HIKER (13)
	db "Eoin@"
	db 0 ; normal

	; party
	db 42, GRAVELER
	db 42, GRAVELER
	db 42, GRAVELER

	db $ff ; end

; ================

	; HIKER (14)
	db "Noland@"
	db 0 ; normal

	; party
	db 39, SANDSLASH
	db 42, GOLEM

	db $ff ; end

; ================

	; HIKER (15)
	db "Clarke@"
	db 0 ; normal

	; party
	db 43, DUGTRIO
	db 45, ONIX

	db $ff ; end

; ================

	; HIKER (16)
	db "Kenny@"
	db 0 ; normal

	; party
	db 27, SANDSLASH
	db 29, GRAVELER
	db 33, GOLEM
	db 29, GRAVELER

	db $ff ; end

; ================

	; HIKER (17)
	db "Jim@"
	db 0 ; normal

	; party
	db 45, MACHAMP

	db $ff ; end

; ================

	; HIKER (18)
	db "Daniel@"
	db 0 ; normal

	; party
	db 11, ONIX

	db $ff ; end

; ================

	; HIKER (19)
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

	; HIKER (20)
	db "Parry@"
	db 0 ; normal

	; party
	db 30, ONIX

	db $ff ; end

; ================

	; HIKER (21)
	db "Anthony@"
	db 0 ; normal

	; party
	db 30, GRAVELER
	db 30, GRAVELER
	db 32, MACHOKE

	db $ff ; end

; ================

	; HIKER (22)
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

	; HIKER (23)
	db "Edwin@"
	db 0 ; normal

	; party
	db 50, GOLEM

	db $ff ; end

; ================

	; HIKER (24)
	db "Devin@"
	db 0 ; normal

	; party
	db 19, DUNSPARCE
	db 19, DUNSPARCE
	db 19, DUNSPARCE

	db $ff ; end

; ================
; ================================


GruntMGroup:
; ================================
; ================

	; GRUNTM (1)
	; (HGSS Executive Proton)
	db "Grunt@"
	db 0 ; normal

	; party
	db 8, ZUBAT
	db 14, KOFFING

	db $ff ; end

; ================

	; GRUNTM (2)
	db "Grunt@"
	db 0 ; normal

	; party
	db 7, RATTATA
	db 9, ZUBAT
	db 9, ZUBAT

	db $ff ; end

; ================

	; GRUNTM (3)
	db "Grunt@"
	db 0 ; normal

	; party
	db 24, RATICATE
	db 24, RATICATE

	db $ff ; end

; ================

	; GRUNTM (4)
	db "Grunt@"
	db 0 ; normal

	; party
	db 23, GRIMER
	db 23, GRIMER
	db 25, MUK

	db $ff ; end

; ================

	; GRUNTM (5)
	db "Grunt@"
	db 0 ; normal

	; party
	db 21, RATTATA
	db 21, RATTATA
	db 23, RATTATA
	db 23, RATTATA
	db 23, RATTATA

	db $ff ; end

; ================

	; GRUNTM (6)
	db "Grunt@"
	db 0 ; normal

	; party
	db 26, ZUBAT
	db 26, ZUBAT

	db $ff ; end

; ================

	; GRUNTM (7)
	db "Grunt@"
	db 0 ; normal

	; party
	db 23, KOFFING
	db 23, GRIMER
	db 23, ZUBAT
	db 23, RATTATA

	db $ff ; end

; ================

	; GRUNTM (8)
	db "Grunt@"
	db 0 ; normal

	; party
	db 26, WEEZING

	db $ff ; end

; ================

	; GRUNTM (9)
	db "Grunt@"
	db 0 ; normal

	; party
	db 24, RATICATE
	db 26, KOFFING

	db $ff ; end

; ================

	; GRUNTM (10)
	db "Grunt@"
	db 0 ; normal

	; party
	db 22, ZUBAT
	db 24, GOLBAT
	db 22, GRIMER

	db $ff ; end

; ================

	; GRUNTM (11)
	db "Grunt@"
	db 0 ; normal

	; party
	db 23, MUK
	db 23, KOFFING
	db 25, RATTATA

	db $ff ; end

; ================

	; unused
	; GRUNTM (12)
	db "Executive@"
	db 0 ; normal

	; party
	db 33, HOUNDOUR

	db $ff ; end

; ================

	; GRUNTM (13)
	db "Grunt@"
	db 0 ; normal

	; party
	db 27, RATTATA

	db $ff ; end

; ================

	; GRUNTM (14)
	db "Grunt@"
	db 0 ; normal

	; party
	db 24, RATICATE
	db 24, GOLBAT

	db $ff ; end

; ================

	; GRUNTM (15)
	db "Grunt@"
	db 0 ; normal

	; party
	db 26, GRIMER
	db 23, WEEZING

	db $ff ; end

; ================

	; GRUNTM (16)
	db "Grunt@"
	db 0 ; normal

	; party
	db 16, RATTATA
	db 16, RATTATA
	db 16, RATTATA
	db 16, RATTATA

	db $ff ; end

; ================

	; GRUNTM (17)
	db "Grunt@"
	db 0 ; normal

	; party
	db 18, GOLBAT

	db $ff ; end

; ================

	; GRUNTM (18)
	db "Grunt@"
	db 0 ; normal

	; party
	db 17, RATTATA
	db 17, ZUBAT
	db 17, RATTATA

	db $ff ; end

; ================

	; GRUNTM (19)
	db "Grunt@"
	db 0 ; normal

	; party
	db 18, VENONAT
	db 18, VENONAT

	db $ff ; end

; ================

	; GRUNTM (20)
	db "Grunt@"
	db 0 ; normal

	; party
	db 17, DROWZEE
	db 19, ZUBAT

	db $ff ; end

; ================

	; GRUNTM (21)
	db "Grunt@"
	db 0 ; normal

	; party
	db 16, ZUBAT
	db 17, GRIMER
	db 18, RATTATA

	db $ff ; end

; ================

	; unused
	; GRUNTM (22)
	db "Executive@"
	db 0 ; normal

	; party
	db 36, GOLBAT

	db $ff ; end

; ================

	; unused
	; GRUNTM (23)
	db "Executive@"
	db 0 ; normal

	; party
	db 30, KOFFING

	db $ff ; end

; ================

	; GRUNTM (24)
	db "Grunt@"
	db 0 ; normal

	; party
	db 25, KOFFING
	db 25, KOFFING

	db $ff ; end

; ================

	; GRUNTM (25)
	db "Grunt@"
	db 0 ; normal

	; party
	db 24, KOFFING
	db 24, MUK

	db $ff ; end

; ================

	; unused
	; GRUNTM (26)
	db "Grunt@"
	db 0 ; normal

	; party
	db 15, RATTATA
	db 15, RATTATA

	db $ff ; end

; ================

	; unused
	; GRUNTM (27)
	db "Executive@"
	db 0 ; normal

	; party
	db 22, ZUBAT

	db $ff ; end

; ================

	; GRUNTM (28)
	db "Grunt@"
	db 0 ; normal

	; party
	db 19, RATICATE

	db $ff ; end

; ================

	; GRUNTM (29)
	db "Grunt@"
	db 0 ; normal

	; party
	db 9, RATTATA
	db 9, RATTATA

	db $ff ; end

; ================

	; GRUNTM (30)
	db "Grunt@"
	db 0 ; normal

	; party
	db 25, GOLBAT
	db 25, GOLBAT
	db 30, ARBOK

	db $ff ; end

; ================
; ================================


GruntFGroup:
; ================================
; ================

	; GRUNTF (1)
	db "Grunt@"
	db 0 ; normal

	; party
	db 9, ZUBAT
	db 11, EKANS

	db $ff ; end

; ================

	; GRUNTF (2)
	db "Grunt@"
	db 0 ; normal

	; party
	db 26, ARBOK

	db $ff ; end

; ================

	; GRUNTF (3)
	db "Grunt@"
	db 0 ; normal

	; party
	db 25, GLOOM
	db 25, GLOOM

	db $ff ; end

; ================

	; GRUNTF (4)
	db "Grunt@"
	db 0 ; normal

	; party
	db 21, EKANS
	db 23, ODDISH
	db 21, EKANS
	db 24, GLOOM

	db $ff ; end

; ================

	; GRUNTF (5)
	db "Grunt@"
	db 1 ; moves

	; party

	db 18, EKANS
		db WRAP
		db LEER
		db POISON_STING
		db BITE

	db 18, GLOOM
		db ABSORB
		db GROWTH
		db STUN_SPORE
		db SLEEP_POWDER

	db $ff ; end

; ================
; ================================


ForeignGruntGroup:
; ================================
; ================

	; FOREIGNGRUNT (1)
	db "Grunt@"
	db 0 ; normal

	; party
	db 39, GOLBAT

	db $ff ; end

; ================
; ================================


PokefanMGroup:
; ================================
; ================

	; POKEFANM (1)
	db "William@"
	db 2 ; item

	; party
	db 16, RAICHU, BERRY

	db $ff ; end

; ================

	; POKEFANM (2)
	db "Derek@"
	db 2 ; item

	; party
	db 18, PIKACHU, BERRY

	db $ff ; end

; ================

	; POKEFANM (3)
	db "Robert@"
	db 2 ; item

	; party
	db 43, QUAGSIRE, GOLD_BERRY

	db $ff ; end

; ================

	; POKEFANM (4)
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

	; POKEFANM (5)
	db "Carter@"
	db 2 ; item

	; party
	db 38, BULBASAUR, GOLD_BERRY
	db 38, CHARMANDER, GOLD_BERRY
	db 38, SQUIRTLE, GOLD_BERRY

	db $ff ; end

; ================

	; POKEFANM (6)
	db "Trevor@"
	db 2 ; item

	; party
	db 42, PSYDUCK, GOLD_BERRY

	db $ff ; end

; ================

	; POKEFANM (7)
	db "Brandon@"
	db 2 ; item

	; party
	db 13, SNUBBULL, BERRY
	db 13, MAREEP, NO_ITEM

	db $ff ; end

; ================

	; POKEFANM (8)
	db "Jeremy@"
	db 2 ; item

	; party
	db 28, MEOWTH, GOLD_BERRY
	db 28, MEOWTH, GOLD_BERRY
	db 28, MEOWTH, GOLD_BERRY

	db $ff ; end

; ================

	; POKEFANM (9)
	db "Colin@"
	db 2 ; item

	; party
	db 40, GLACEON, GOLD_BERRY

	db $ff ; end

; ================

	; POKEFANM (10)
	db "Derek@"
	db 2 ; item

	; party
	db 19, PIKACHU, BERRY

	db $ff ; end

; ================

	; POKEFANM (11)
	db "Derek@"
	db 2 ; item

	; party
	db 36, PIKACHU, GOLD_BERRY

	db $ff ; end

; ================

	; POKEFANM (12)
	db "Alex@"
	db 2 ; item

	; party
	db 36, NIDOKING, KINGS_ROCK
	db 36, SLOWKING, KINGS_ROCK
	db 36, KINGLER, KINGS_ROCK

	db $ff ; end

; ================

	; POKEFANM (13)
	db "Rex@"
	db 2 ; item

	; party
	db 43, PHANPY, GOLD_BERRY

	db $ff ; end

; ================

	; POKEFANM (14)
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

	; POKEFANF (1)
	db "Beverly@"
	db 2 ; item

	; party
	db 16, SNUBBULL, BERRY

	db $ff ; end

; ================

	; POKEFANF (2)
	db "Ruth@"
	db 2 ; item

	; party
	db 17, PIKACHU, BERRY

	db $ff ; end

; ================

	; POKEFANF (3)
	db "Beverly@"
	db 2 ; item

	; party
	db 18, SNUBBULL, BERRY

	db $ff ; end

; ================

	; POKEFANF (4)
	db "Beverly@"
	db 2 ; item

	; party
	db 30, GRANBULL, GOLD_BERRY

	db $ff ; end

; ================

	; POKEFANF (5)
	db "Georgia@"
	db 2 ; item

	; party
	db 23, SENTRET, BERRY
	db 23, SENTRET, BERRY
	db 23, SENTRET, BERRY
	db 28, FURRET, GOLD_BERRY
	db 23, SENTRET, BERRY

	db $ff ; end

; ================

	; POKEFANF (6)
	db "Jaime@"
	db 2 ; item

	; party
	db 16, MEOWTH, BERRY

	db $ff ; end

; ================

	; POKEFANF (7)
	db "Boone@"
	db 2 ; item

	; party
	db 43, AIPOM, GOLD_BERRY
	db 41, WIGGLYTUFF, GOLD_BERRY

	db $ff ; end

; ================

	; POKEFANF (8)
	db "Eleanor@"
	db 2 ; item

	; party
	db 43, AIPOM, GOLD_BERRY
	db 41, CLEFABLE, GOLD_BERRY

	db $ff ; end

; ================
; ================================


OfficerGroup:
; ================================
; ================

	; OFFICER (1)
	db "Keith@"
	db 0 ; normal

	; party
	db 17, GROWLITHE

	db $ff ; end

; ================

	; OFFICER (2)
	db "Dirk@"
	db 0 ; normal

	; party
	db 14, GROWLITHE
	db 14, GROWLITHE

	db $ff ; end

; ================
; ================================


PokemaniacGroup:
; ================================
; ================

	; POKEMANIAC (1)
	db "Larry@"
	db 0 ; normal

	; party
	db 11, SLOWPOKE

	db $ff ; end

; ================

	; POKEMANIAC (2)
	db "Andrew@"
	db 0 ; normal

	; party
	db 24, MAROWAK
	db 24, MAROWAK

	db $ff ; end

; ================

	; POKEMANIAC (3)
	db "Calvin@"
	db 0 ; normal

	; party
	db 26, KANGASKHAN

	db $ff ; end

; ================

	; POKEMANIAC (4)
	db "Shane@"
	db 0 ; normal

	; party
	db 17, NIDORINA
	db 17, NIDORINO

	db $ff ; end

; ================

	; POKEMANIAC (5)
	db "Beckett@"
	db 0 ; normal

	; party
	db 20, SLOWBRO

	db $ff ; end

; ================

	; POKEMANIAC (6)
	db "Brent@"
	db 0 ; normal

	; party
	db 22, MAROWAK

	db $ff ; end

; ================

	; POKEMANIAC (7)
	db "Ron@"
	db 0 ; normal

	; party
	db 20, NIDOKING

	db $ff ; end

; ================

	; POKEMANIAC (8)
	db "Ethan@"
	db 0 ; normal

	; party
	db 31, RHYHORN
	db 31, RHYDON

	db $ff ; end

; ================

	; POKEMANIAC (9)
	db "Brent@"
	db 0 ; normal

	; party
	db 28, KANGASKHAN

	db $ff ; end

; ================

	; POKEMANIAC (10)
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

	; POKEMANIAC (11)
	db "Issac@"
	db 0 ; normal

	; party

	db 12, SLOWPOKE

	db $ff ; end

; ================

	; POKEMANIAC (12)
	db "Donald@"
	db 0 ; normal

	; party
	db 11, SLOWPOKE
	db 11, NIDORAN_M

	db $ff ; end

; ================

	; POKEMANIAC (13)
	db "Zach@"
	db 0 ; normal

	; party
	db 30, RHYHORN

	db $ff ; end

; ================

	; POKEMANIAC (14)
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

	; POKEMANIAC (15)
	db "Miller@"
	db 0 ; normal

	; party
	db 17, NIDOKING
	db 17, NIDOQUEEN

	db $ff ; end

; ================

	; POKEMANIAC (16)
	db "Moe@"
	db 0 ; normal

	; party
	db 43, GLOOM
	db 43, WEEPINBELL

	db $ff ; end

; ================

	; POKEMANIAC (17)
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

	; SUPER_NERD (1)
	db "Stan@"
	db 0 ; normal

	; party
	db 20, GRIMER

	db $ff ; end

; ================

	; SUPER_NERD (2)
	db "Eric@"
	db 0 ; normal

	; party
	db 11, GRIMER
	db 11, GRIMER

	db $ff ; end

; ================

	; SUPER_NERD (3)
	db "Gregg@"
	db 0 ; normal

	; party
	db 20, MAGNEMITE
	db 20, MAGNEMITE
	db 20, MAGNEMITE

	db $ff ; end

; ================

	; SUPER_NERD (4)
	db "Jay@"
	db 0 ; normal

	; party
	db 22, KOFFING
	db 22, KOFFING

	db $ff ; end

; ================

	; SUPER_NERD (5)
	db "Dave@"
	db 0 ; normal

	; party
	db 24, DITTO

	db $ff ; end

; ================

	; SUPER_NERD (6)
	db "Sam@"
	db 0 ; normal

	; party
	db 44, GRIMER
	db 44, MUK

	db $ff ; end

; ================

	; SUPER_NERD (7)
	db "Tyrone@"
	db 0 ; normal

	; party
	db 40, MAGNEMITE
	db 40, MAGNEMITE
	db 40, MAGNEMITE

	db $ff ; end

; ================

	; SUPER_NERD (8)
	db "Pat@"
	db 0 ; normal

	; party
	db 47, PORYGON

	db $ff ; end

; ================

	; SUPER_NERD (9)
	db "Shawn@"
	db 0 ; normal

	; party
	db 31, MAGNEMITE
	db 33, MUK
	db 31, MAGNEMITE

	db $ff ; end

; ================

	; SUPER_NERD (10)
	db "Teru@"
	db 0 ; normal

	; party
	db 7, MAGNEMITE
	db 11, VOLTORB
	db 7, MAGNEMITE
	db 9, MAGNEMITE

	db $ff ; end

; ================

	; SUPER_NERD (11)
	db "Russ@"
	db 0 ; normal

	; party
	db 27, MAGNEMITE
	db 27, MAGNEMITE
	db 27, MAGNEMITE

	db $ff ; end

; ================

	; SUPER_NERD (12)
	db "Norton@"
	db 1 ; moves

	; party

	db 30, PORYGON
		db CONVERSION
		db CONVERSION2
		db RECOVER
		db TRI_ATTACK

	db $ff ; end

; ================

	; SUPER_NERD (13)
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

	; SUPER_NERD (14)
	db "Markus@"
	db 1 ; moves

	; party

	db 19, SLOWPOKE
		db CURSE
		db WATER_GUN
		db GROWL
		db STRENGTH

	db $ff ; end

; ================

	; SUPER_NERD (15)
	db "Cary@"
	db 0 ; normal

	; party
	db 53, FLAREON

	db $ff ; end

; ================

	; SUPER_NERD (15)
	db "Waldo@"
	db 0 ; normal

	; party
	db 53, CHARIZARD

	db $ff ; end

; ================

	; SUPER_NERD (15)
	db "Merle@"
	db 0 ; normal

	; party
	db 53, MAGCARGO

	db $ff ; end

; ================

	; SUPER_NERD (16)
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

	; LASS (1)
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

	; LASS (2)
	db "Cathy@"
	db 0 ; normal

	; party
	db 15, JIGGLYPUFF
	db 15, JIGGLYPUFF
	db 15, JIGGLYPUFF

	db $ff ; end

; ================

	; LASS (3)
	db "Alice@"
	db 0 ; normal

	; party
	db 41, GLOOM
	db 45, ARBOK
	db 41, GLOOM

	db $ff ; end

; ================

	; LASS (4)
	db "Krise@"
	db 0 ; normal

	; party
	db 14, ODDISH
	db 17, CUBONE

	db $ff ; end

; ================

	; LASS (5)
	db "Connie@"
	db 0 ; normal

	; party
	db 21, MARILL

	db $ff ; end

; ================

	; LASS (6)
	db "Linda@"
	db 0 ; normal

	; party
	db 41, BULBASAUR
	db 43, IVYSAUR
	db 45, VENUSAUR

	db $ff ; end

; ================

	; LASS (7)
	db "Laura@"
	db 2 ; item

	; party
	db 38, GLOOM, GOLD_BERRY
	db 41, PIDGEOTTO, NO_ITEM
	db 41, BELLOSSOM, NO_ITEM

	db $ff ; end

; ================

	; LASS (8)
	db "Shannon@"
	db 0 ; normal

	; party
	db 38, PARAS
	db 38, PARAS
	db 42, PARASECT

	db $ff ; end

; ================

	; LASS (9)
	db "Michelle@"
	db 0 ; normal

	; party
	db 44, SKIPLOOM
	db 45, HOPPIP
	db 46, JUMPLUFF

	db $ff ; end

; ================

	; LASS (10)
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

	; LASS (11)
	db "Ellen@"
	db 0 ; normal

	; party
	db 40, WIGGLYTUFF
	db 44, GRANBULL

	db $ff ; end

; ================

	; LASS (12)
	db "Connie@"
	db 0 ; normal

	; party
	db 21, MARILL

	db $ff ; end

; ================

	; LASS (13)
	db "Connie@"
	db 0 ; normal

	; party
	db 21, MARILL

	db $ff ; end

; ================

	; LASS (14)
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

	; LASS (15)
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

	; LASS (16)
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

	; LASS (17)
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

	; BEAUTY (1)
	db "Victoria@"
	db 0 ; normal

	; party
	db 9, SENTRET
	db 13, SENTRET
	db 17, SENTRET

	db $ff ; end

; ================

	; BEAUTY (2)
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

	; BEAUTY (3)
	db "Julie@"
	db 0 ; normal

	; party
	db 15, SENTRET

	db $ff ; end

; ================

	; BEAUTY (4)
	db "Jaclyn@"
	db 0 ; normal

	; party
	db 15, SENTRET

	db $ff ; end

; ================

	; BEAUTY (5)
	db "Brenda@"
	db 0 ; normal

	; party
	db 16, FURRET

	db $ff ; end

; ================

	; BEAUTY (6)
	db "Cassie@"
	db 0 ; normal

	; party
	db 28, VILEPLUME
	db 34, BUTTERFREE

	db $ff ; end

; ================

	; BEAUTY (7)
	db "Caroline@"
	db 0 ; normal

	; party
	db 30, MARILL
	db 32, SEEL
	db 30, MARILL

	db $ff ; end

; ================

	; BEAUTY (8)
	db "Carlene@"
	db 0 ; normal

	; party
	db 15, SENTRET

	db $ff ; end

; ================

	; BEAUTY (9)
	db "Jessica@"
	db 0 ; normal

	; party
	db 15, SENTRET

	db $ff ; end

; ================

	; BEAUTY (10)
	db "Rachael@"
	db 0 ; normal

	; party
	db 15, SENTRET

	db $ff ; end

; ================

	; BEAUTY (11)
	db "Angelica@"
	db 0 ; normal

	; party
	db 15, SENTRET

	db $ff ; end

; ================

	; BEAUTY (12)
	db "Kendra@"
	db 0 ; normal

	; party
	db 15, SENTRET

	db $ff ; end

; ================

	; BEAUTY (13)
	db "Veronica@"
	db 0 ; normal

	; party
	db 15, SENTRET

	db $ff ; end

; ================

	; BEAUTY (14)
	db "Julia@"
	db 0 ; normal

	; party
	db 44, PARAS
	db 44, EXEGGCUTE
	db 47, PARASECT

	db $ff ; end

; ================

	; BEAUTY (15)
	db "Theresa@"
	db 0 ; normal

	; party
	db 15, SENTRET

	db $ff ; end

; ================

	; BEAUTY (16)
	db "Valencia@"
	db 1 ; moves

	; party

	db 18, HOPPIP
		db SYNTHESIS
		db TAIL_WHIP
		db TACKLE
		db POISONPOWDER

	db 18, SKIPLOOM
		db SYNTHESIS
		db TAIL_WHIP
		db TACKLE
		db STUN_SPORE

	db $ff ; end

; ================

	; BEAUTY (17)
	db "Olivia@"
	db 0 ; normal

	; party
	db 19, CORSOLA

	db $ff ; end

; ================

	; BEAUTY (18)
	db "Callie@"
	db 0 ; normal

	; party
	db 16, CLEFABLE
	db 16, WIGGLYTUFF

	db $ff ; end

; ================

	; BEAUTY (19)
	db "Cassandra@"
	db 0 ; normal

	; party
	db 16, CLEFABLE
	db 16, WIGGLYTUFF

	db $ff ; end

; ================

	; BEAUTY (20)
	db "Charlotte@"
	db 0 ; normal

	; party
	db 16, BELLOSSOM

	db $ff ; end

; ================
; ================================


FirebreatherGroup:
; ================================
; ================

	; FIREBREATHER (1)
	db "Otis@"
	db 0 ; normal

	; party
	db 43, MAGMAR
	db 40, WEEZING
	db 47, MAGMAR

	db $ff ; end

; ================

	; FIREBREATHER (2)
	db "Richard@"
	db 0 ; normal

	; party
	db 18, CHARMELEON

	db $ff ; end

; ================

	; FIREBREATHER (3)
	db "Ned@"
	db 0 ; normal

	; party
	db 16, KOFFING
	db 17, GROWLITHE
	db 16, KOFFING

	db $ff ; end

; ================

	; FIREBREATHER (4)
	db "Burt@"
	db 0 ; normal

	; party
	db 42, WEEZING
	db 45, MAGCARGO

	db $ff ; end

; ================

	; FIREBREATHER (5)
	db "Bill@"
	db 0 ; normal

	; party
	db 6, KOFFING
	db 6, KOFFING

	db $ff ; end

; ================

	; FIREBREATHER (6)
	db "Walt@"
	db 0 ; normal

	; party
	db 11, MAGMAR
	db 16, MAGMAR

	db $ff ; end

; ================

	; FIREBREATHER (7)
	db "Ray@"
	db 0 ; normal

	; party
	db 9, VULPIX

	db $ff ; end

; ================

	; FIREBREATHER (8)
	db "Lyle@"
	db 0 ; normal

	; party
	db 36, KOFFING
	db 39, FLAREON
	db 36, KOFFING

	db $ff ; end

; ================
; ================================


JugglerGroup:
; ================================
; ================

	; JUGGLER (1)
	db "Irwin@"
	db 0 ; normal

	; party
	db 2, VOLTORB
	db 6, VOLTORB
	db 10, VOLTORB
	db 14, VOLTORB

	db $ff ; end

; ================

	; JUGGLER (2)
	db "Fritz@"
	db 0 ; normal

	; party
	db 37, MR__MIME
	db 37, MAGMAR
	db 37, MACHOKE

	db $ff ; end

; ================

	; JUGGLER (3)
	db "Horton@"
	db 0 ; normal

	; party
	db 43, ELECTRODE
	db 43, ELECTRODE
	db 43, ELECTRODE

	db $ff ; end

; ================

	; JUGGLER (4)
	db "Irwin@"
	db 0 ; normal

	; party
	db 6, VOLTORB
	db 10, VOLTORB
	db 14, VOLTORB
	db 18, VOLTORB

	db $ff ; end

; ================

	; JUGGLER (5)
	db "Irwin@"
	db 0 ; normal

	; party
	db 18, VOLTORB
	db 22, VOLTORB
	db 26, VOLTORB
	db 30, ELECTRODE

	db $ff ; end

; ================

	; JUGGLER (6)
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

	; SCHOOLBOY (1)
	db "Jack@"
	db 0 ; normal

	; party
	db 12, ODDISH
	db 15, VOLTORB

	db $ff ; end

; ================

	; SCHOOLBOY (2)
	db "Kipp@"
	db 0 ; normal

	; party
	db 36, VOLTORB
	db 40, VOLTORB
	db 36, MAGNEMITE
	db 40, MAGNETON

	db $ff ; end

; ================

	; SCHOOLBOY (3)
	db "Alan@"
	db 0 ; normal

	; party
	db 17, TANGELA

	db $ff ; end

; ================

	; SCHOOLBOY (4)
	db "Johnny@"
	db 0 ; normal

	; party
	db 39, BELLSPROUT
	db 40, WEEPINBELL
	db 42, VICTREEBEL

	db $ff ; end

; ================

	; SCHOOLBOY (5)
	db "Danny@"
	db 0 ; normal

	; party
	db 43, JYNX
	db 43, ELECTABUZZ
	db 43, MAGMAR

	db $ff ; end

; ================

	; SCHOOLBOY (6)
	db "Tommy@"
	db 0 ; normal

	; party
	db 41, XATU
	db 43, ALAKAZAM

	db $ff ; end

; ================

	; SCHOOLBOY (7)
	db "Dudley@"
	db 2 ; item

	; party
	db 45, ODDISH, GOLD_BERRY

	db $ff ; end

; ================

	; SCHOOLBOY (8)
	db "Joe@"
	db 2 ; item

	; party
	db 44, TANGROWTH, GOLD_BERRY
	db 44, VAPOREON, NO_ITEM

	db $ff ; end

; ================

	; SCHOOLBOY (9)
	db "Billy@"
	db 0 ; normal

	; party
	db 37, PARAS
	db 39, PARASECT
	db 37, POLIWHIRL
	db 35, DITTO

	db $ff ; end

; ================

	; SCHOOLBOY (10)
	db "Chad@"
	db 0 ; normal

	; party
	db 20, MR__MIME

	db $ff ; end

; ================

	; SCHOOLBOY (11)
	db "Nate@"
	db 0 ; normal

	; party
	db 32, LEDIAN
	db 32, EXEGGUTOR

	db $ff ; end

; ================

	; SCHOOLBOY (12)
	db "Ricky@"
	db 0 ; normal

	; party
	db 32, AIPOM
	db 32, DITTO

	db $ff ; end

; ================

	; SCHOOLBOY (13)
	db "Jack@"
	db 0 ; normal

	; party
	db 14, ODDISH
	db 17, VOLTORB

	db $ff ; end

; ================

	; SCHOOLBOY (14)
	db "Jack@"
	db 0 ; normal

	; party
	db 28, GLOOM
	db 31, ELECTRODE

	db $ff ; end

; ================

	; SCHOOLBOY (15)
	db "Alan@"
	db 0 ; normal

	; party
	db 17, TANGELA
	db 17, YANMA

	db $ff ; end

; ================

	; SCHOOLBOY (16)
	db "Alan@"
	db 0 ; normal

	; party
	db 20, NATU
	db 22, TANGELA
	db 20, QUAGSIRE
	db 25, YANMA

	db $ff ; end

; ================

	; SCHOOLBOY (17)
	db "Chad@"
	db 0 ; normal

	; party
	db 19, MR__MIME
	db 19, MAGNEMITE

	db $ff ; end

; ================

	; SCHOOLBOY (18)
	db "Chad@"
	db 0 ; normal

	; party
	db 27, MR__MIME
	db 31, MAGNETON

	db $ff ; end

; ================

	; SCHOOLBOY (19)
	db "Jack@"
	db 0 ; normal

	; party
	db 30, GLOOM
	db 33, GROWLITHE
	db 33, ELECTRODE

	db $ff ; end

; ================

	; SCHOOLBOY (20)
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

	; SCHOOLBOY (21)
	db "Alan@"
	db 0 ; normal

	; party
	db 27, NATU
	db 27, TANGELA
	db 30, QUAGSIRE
	db 30, YANMA

	db $ff ; end

; ================

	; SCHOOLBOY (22)
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

	; SCHOOLBOY (23)
	db "Chad@"
	db 0 ; normal

	; party
	db 30, MR__MIME
	db 34, MAGNETON

	db $ff ; end

; ================

	; SCHOOLBOY (24)
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

	; SCHOOLBOY (25)
	db "Sherman@"
	db 0 ; normal

	; party
	db 43, FURRET
	db 43, PIDGEOT

	db $ff ; end

; ================
; ================================


PsychicGroup:
; ================================
; ================

	; PSYCHIC_T (1)
	db "Nathan@"
	db 0 ; normal

	; party
	db 26, GIRAFARIG

	db $ff ; end

; ================

	; PSYCHIC_T (2)
	db "Franklin@"
	db 0 ; normal

	; party
	db 44, KADABRA
	db 47, GIRAFARIG

	db $ff ; end

; ================

	; PSYCHIC_T (3)
	db "Herman@"
	db 0 ; normal

	; party
	db 39, EXEGGCUTE
	db 39, EXEGGCUTE
	db 39, EXEGGUTOR

	db $ff ; end

; ================

	; PSYCHIC_T (4)
	db "Fidel@"
	db 0 ; normal

	; party
	db 43, XATU

	db $ff ; end

; ================

	; PSYCHIC_T (5)
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

	; PSYCHIC_T (6)
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

	; PSYCHIC_T (7)
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

	; PSYCHIC_T (8)
	db "Phil@"
	db 1 ; moves

	; party

	db 27, NATU
		db LEER
		db NIGHT_SHADE
		db FUTURE_SIGHT
		db CONFUSE_RAY

	db 29, KADABRA
		db DISABLE
		db PSYBEAM
		db RECOVER
		db FUTURE_SIGHT

	db $ff ; end

; ================

	; PSYCHIC_T (9)
	db "Vernon@"
	db 0 ; normal

	; party
	db 36, ESPEON

	db $ff ; end

; ================

	; PSYCHIC_T (10)
	db "Gilbert@"
	db 0 ; normal

	; party
	db 30, STARMIE
	db 30, EXEGGCUTE
	db 34, GIRAFARIG

	db $ff ; end

; ================

	; PSYCHIC_T (11)
	db "Jared@"
	db 0 ; normal

	; party
	db 42, MR__MIME
	db 42, EXEGGCUTE
	db 45, EXEGGCUTE

	db $ff ; end

; ================

	; PSYCHIC_T (12)
	db "Rodney@"
	db 0 ; normal

	; party
	db 29, DROWZEE
	db 33, HYPNO

	db $ff ; end

; ================
; ================================


SageGroup:
; ================================
; ================

	; SAGE (1)
	db "Chow@"
	db 0 ; normal

	; party
	db 3, BELLSPROUT
	db 3, BELLSPROUT
	db 3, BELLSPROUT

	db $ff ; end

; ================

	; SAGE (2)
	db "Nico@"
	db 0 ; normal

	; party
	db 3, BELLSPROUT
	db 3, BELLSPROUT
	db 3, BELLSPROUT

	db $ff ; end

; ================

	; SAGE (3)
	db "Jin@"
	db 0 ; normal

	; party
	db 6, BELLSPROUT

	db $ff ; end

; ================

	; SAGE (4)
	db "Troy@"
	db 0 ; normal

	; party
	db 7, BELLSPROUT
	db 7, HOOTHOOT

	db $ff ; end

; ================

	; SAGE (5)
	db "Jeffrey@"
	db 0 ; normal

	; party
	db 22, HAUNTER

	db $ff ; end

; ================

	; SAGE (6)
	db "Ping@"
	db 0 ; normal

	; party
	db 16, GASTLY
	db 16, GASTLY
	db 16, GASTLY
	db 16, GASTLY
	db 16, GASTLY

	db $ff ; end

; ================

	; SAGE (7)
	db "Edmond@"
	db 0 ; normal

	; party
	db 3, BELLSPROUT
	db 3, BELLSPROUT
	db 3, BELLSPROUT

	db $ff ; end

; ================

	; SAGE (8)
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

	; MEDIUM (1)
	db "Martha@"
	db 0 ; normal

	; party
	db 18, GASTLY
	db 20, HAUNTER
	db 20, GASTLY

	db $ff ; end

; ================

	; MEDIUM (2)
	db "Grace@"
	db 0 ; normal

	; party
	db 20, HAUNTER
	db 20, HAUNTER

	db $ff ; end

; ================

	; MEDIUM (3)
	db "Bethany@"
	db 0 ; normal

	; party
	db 25, HAUNTER

	db $ff ; end

; ================

	; MEDIUM (4)
	db "Margret@"
	db 0 ; normal

	; party
	db 25, HAUNTER

	db $ff ; end

; ================

	; MEDIUM (5)
	db "Ethel@"
	db 0 ; normal

	; party
	db 25, HAUNTER

	db $ff ; end

; ================

	; MEDIUM (6)
	db "Rebecca@"
	db 0 ; normal

	; party
	db 45, DROWZEE
	db 45, HYPNO

	db $ff ; end

; ================

	; MEDIUM (7)
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

	; KIMONO_GIRL (1)
	db "Naoko@"
	db 0 ; normal

	; party
	db 17, FLAREON

	db $ff ; end

; ================

	; KIMONO_GIRL (2)
	db "Sayo@"
	db 0 ; normal

	; party
	db 17, ESPEON

	db $ff ; end

; ================

	; KIMONO_GIRL (3)
	db "Zuki@"
	db 0 ; normal

	; party
	db 17, UMBREON

	db $ff ; end

; ================

	; KIMONO_GIRL (4)
	db "Kuni@"
	db 0 ; normal

	; party
	db 17, VAPOREON

	db $ff ; end

; ================

	; KIMONO_GIRL (5)
	db "Miki@"
	db 0 ; normal

	; party
	db 17, JOLTEON

	db $ff ; end

; ================
; ================================


ElderGroup:
; ================================
; ================

	; ELDER (1)
	db "Li@"
	db 0 ; normal

	; party
	db 7, BELLSPROUT
	db 7, BELLSPROUT
	db 10, HOOTHOOT

	db $ff ; end

; ================

	; ELDER (2)
	db "Gaku@"
	db 0 ; normal

	; party
	db 36, NOCTOWL
	db 36, FLAREON
	db 36, WEEPINBELL

	db $ff ; end

; ================

	; ELDER (3)
	db "Masa@"
	db 0 ; normal

	; party
	db 36, NOCTOWL
	db 36, JOLTEON
	db 36, WARTORTLE

	db $ff ; end

; ================

	; ELDER (4)
	db "Koji@"
	db 0 ; normal

	; party
	db 36, NOCTOWL
	db 36, VAPOREON
	db 36, NINETALES

	db $ff ; end

; ================
; ================================


GentlemanGroup:
; ================================
; ================

	; GENTLEMAN (1)
	db "Preston@"
	db 0 ; normal

	; party
	db 18, GROWLITHE
	db 18, GROWLITHE

	db $ff ; end

; ================

	; GENTLEMAN (2)
	db "Edward@"
	db 0 ; normal

	; party
	db 33, PERSIAN

	db $ff ; end

; ================

	; GENTLEMAN (3)
	db "Gregory@"
	db 0 ; normal

	; party
	db 46, PIKACHU
	db 43, FLAAFFY
	db 43, CHINCHOU

	db $ff ; end

; ================

	; GENTLEMAN (4)
	db "Virgil@"
	db 0 ; normal

	; party
	db 20, PONYTA

	db $ff ; end

; ================

	; GENTLEMAN (5)
	db "Alfred@"
	db 0 ; normal

	; party
	db 22, NOCTOWL

	db $ff ; end

; ================

	; GENTLEMAN (6)
	db "Milton@"
	db 0 ; normal

	; party
	db 45, GROWLITHE

	db $ff ; end

; ================
; ================================


SailorGroup:
; ================================
; ================

	; SAILOR (1)
	db "Eugene@"
	db 0 ; normal

	; party
	db 17, POLIWHIRL
	db 17, RATICATE
	db 19, KRABBY

	db $ff ; end

; ================

	; SAILOR (2)
	db "Huey@"
	db 0 ; normal

	; party
	db 18, POLIWAG
	db 20, POLIWHIRL

	db $ff ; end

; ================

	; SAILOR (3)
	db "Terrell@"
	db 0 ; normal

	; party
	db 20, POLIWHIRL

	db $ff ; end

; ================

	; SAILOR (4)
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

	; SAILOR (5)
	db "Roberto@"
	db 0 ; normal

	; party
	db 18, MACHOP
	db 18, MACHOP
	db 18, POLIWHIRL

	db $ff ; end

; ================

	; SAILOR (6)
	db "Jeff@"
	db 0 ; normal

	; party
	db 40, RATICATE
	db 40, RATICATE

	db $ff ; end

; ================

	; SAILOR (7)
	db "Garrett@"
	db 0 ; normal

	; party
	db 34, KINGLER

	db $ff ; end

; ================

	; SAILOR (8)
	db "Kenneth@"
	db 0 ; normal

	; party
	db 28, MACHOP
	db 28, MACHOP
	db 28, POLIWRATH
	db 28, MACHOP

	db $ff ; end

; ================

	; SAILOR (9)
	db "Stanly@"
	db 0 ; normal

	; party
	db 39, MACHOP
	db 41, MACHOKE
	db 34, PSYDUCK

	db $ff ; end

; ================

	; SAILOR (10)
	db "Harry@"
	db 0 ; normal

	; party
	db 20, WOOPER

	db $ff ; end

; ================

	; SAILOR (11)
	db "Huey@"
	db 0 ; normal

	; party
	db 28, POLIWHIRL
	db 28, POLIWHIRL

	db $ff ; end

; ================

	; SAILOR (12)
	db "Huey@"
	db 0 ; normal

	; party
	db 34, POLIWHIRL
	db 34, POLIWRATH

	db $ff ; end

; ================

	; SAILOR (13)
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

	; SAILOR (14)
	db "Parker@"
	db 0 ; normal

	; party
	db 43, HORSEA
	db 45, SEADRA

	db $ff ; end

; ================

	; SAILOR (15)
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

	; SWIMMERM (1)
	db "Harold@"
	db 0 ; normal

	; party
	db 42, REMORAID
	db 40, SEADRA

	db $ff ; end

; ================

	; SWIMMERM (2)
	db "Simon@"
	db 0 ; normal

	; party
	db 20, TENTACOOL
	db 20, TENTACOOL

	db $ff ; end

; ================

	; SWIMMERM (3)
	db "Randall@"
	db 0 ; normal

	; party
	db 18, SHELLDER
	db 20, WARTORTLE
	db 18, SHELLDER

	db $ff ; end

; ================

	; SWIMMERM (4)
	db "Charlie@"
	db 0 ; normal

	; party
	db 21, SHELLDER
	db 19, TENTACOOL
	db 19, TENTACRUEL

	db $ff ; end

; ================

	; SWIMMERM (5)
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

	; SWIMMERM (6)
	db "Berke@"
	db 0 ; normal

	; party
	db 23, QWILFISH

	db $ff ; end

; ================

	; SWIMMERM (7)
	db "Kirk@"
	db 0 ; normal

	; party
	db 20, GYARADOS
	db 20, GYARADOS

	db $ff ; end

; ================

	; SWIMMERM (8)
	db "Matthew@"
	db 0 ; normal

	; party
	db 23, KRABBY

	db $ff ; end

; ================

	; SWIMMERM (9)
	db "Hal@"
	db 0 ; normal

	; party
	db 24, SEEL
	db 25, DEWGONG
	db 24, SEEL

	db $ff ; end

; ================

	; SWIMMERM (10)
	db "Paton@"
	db 0 ; normal

	; party
	db 26, PILOSWINE
	db 26, PILOSWINE

	db $ff ; end

; ================

	; SWIMMERM (11)
	db "Daryl@"
	db 0 ; normal

	; party
	db 24, SHELLDER
	db 25, CLOYSTER
	db 24, SHELLDER

	db $ff ; end

; ================

	; SWIMMERM (12)
	db "Walter@"
	db 0 ; normal

	; party
	db 15, HORSEA
	db 15, HORSEA
	db 20, SEADRA

	db $ff ; end

; ================

	; SWIMMERM (13)
	db "Tony@"
	db 0 ; normal

	; party
	db 13, STARYU
	db 18, STARMIE
	db 16, HORSEA

	db $ff ; end

; ================

	; SWIMMERM (14)
	db "Jerome@"
	db 0 ; normal

	; party
	db 36, SEADRA
	db 38, TENTACOOL
	db 40, TENTACRUEL
	db 38, GOLDUCK

	db $ff ; end

; ================

	; SWIMMERM (15)
	db "Tucker@"
	db 0 ; normal

	; party
	db 40, SHELLDER
	db 44, CLOYSTER

	db $ff ; end

; ================

	; SWIMMERM (16)
	db "Rick@"
	db 0 ; normal

	; party
	db 13, STARYU
	db 18, STARMIE
	db 16, HORSEA

	db $ff ; end

; ================

	; SWIMMERM (17)
	db "Frankie@"
	db 0 ; normal

	; party
	db 44, AZUMARILL

	db $ff ; end

; ================

	; SWIMMERM (18)
	db "Tyson@"
	db 0 ; normal

	; party
	db 42, QUAGSIRE
	db 42, OCTILLERY
	db 44, QUAGSIRE

	db $ff ; end

; ================

	; SWIMMERM (19)
	db "James@"
	db 0 ; normal

	; party
	db 13, STARYU
	db 18, STARMIE
	db 16, HORSEA

	db $ff ; end

; ================

	; SWIMMERM (20)
	db "Lewis@"
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

	; SWIMMERF (1)
	db "Elaine@"
	db 0 ; normal

	; party
	db 21, STARYU

	db $ff ; end

; ================

	; SWIMMERF (2)
	db "Paula@"
	db 0 ; normal

	; party
	db 19, STARYU
	db 19, SHELLDER

	db $ff ; end

; ================

	; SWIMMERF (3)
	db "Kaylee@"
	db 0 ; normal

	; party
	db 18, MARILL
	db 20, MARILL
	db 20, AZUMARILL

	db $ff ; end

; ================

	; SWIMMERF (4)
	db "Susie@"
	db 0 ; normal

	; party

	db 20, PSYDUCK
	db 22, SEEL

	db $ff ; end

; ================

	; SWIMMERF (5)
	db "Denise@"
	db 0 ; normal

	; party
	db 22, SEEL

	db $ff ; end

; ================

	; SWIMMERF (6)
	db "Kara@"
	db 0 ; normal

	; party
	db 20, STARYU
	db 20, STARMIE

	db $ff ; end

; ================

	; SWIMMERF (7)
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

	; SWIMMERF (8)
	db "Lisa@"
	db 0 ; normal

	; party
	db 28, JYNX

	db $ff ; end

; ================

	; SWIMMERF (9)
	db "Jill@"
	db 0 ; normal

	; party
	db 28, DEWGONG

	db $ff ; end

; ================

	; SWIMMERF (10)
	db "Mary@"
	db 0 ; normal

	; party
	db 20, GYARADOS

	db $ff ; end

; ================

	; SWIMMERF (11)
	db "Katie@"
	db 0 ; normal

	; party
	db 33, DEWGONG

	db $ff ; end

; ================

	; SWIMMERF (12)
	db "Debbie@"
	db 0 ; normal

	; party
	db 46, AZUMARILL

	db $ff ; end

; ================

	; SWIMMERF (13)
	db "Tara@"
	db 0 ; normal

	; party
	db 20, POLIWHIRL

	db $ff ; end

; ================

	; SWIMMERF (14)
	db "Nicole@"
	db 0 ; normal

	; party
	db 39, MARILL
	db 39, MARILL
	db 42, LAPRAS

	db $ff ; end

; ================

	; SWIMMERF (15)
	db "Lori@"
	db 0 ; normal

	; party
	db 42, STARMIE
	db 42, STARMIE
	db 42, STARMIE

	db $ff ; end

; ================

	; SWIMMERF (16)
	db "Jody@"
	db 0 ; normal

	; party
	db 20, GOLDUCK

	db $ff ; end

; ================

	; SWIMMERF (17)
	db "Nikki@"
	db 0 ; normal

	; party
	db 37, SEEL
	db 37, SEEL
	db 37, SEEL
	db 42, DEWGONG

	db $ff ; end

; ================

	; SWIMMERF (18)
	db "Diana@"
	db 0 ; normal

	; party
	db 48, GOLDUCK

	db $ff ; end

; ================

	; SWIMMERF (19)
	db "Briana@"
	db 0 ; normal

	; party
	db 46, GYARADOS
	db 46, LAPRAS

	db $ff ; end

; ================

	; SWIMMERF (20)
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

	; BURGLAR (1)
	db "Duncan@"
	db 0 ; normal

	; party
	db 23, KOFFING
	db 25, MAGMAR
	db 23, KOFFING

	db $ff ; end

; ================

	; BURGLAR (2)
	db "Eddie@"
	db 1 ; moves

	; party

	db 26, GROWLITHE
		db ROAR
		db EMBER
		db LEER
		db TAKE_DOWN

	db 24, KOFFING
		db TACKLE
		db ACID
		db SLUDGE
		db SMOKESCREEN

	db $ff ; end

; ================

	; BURGLAR (3)
	db "Corey@"
	db 0 ; normal

	; party
	db 25, KOFFING
	db 28, MAGMAR
	db 25, KOFFING
	db 30, KOFFING

	db $ff ; end

; ================

	; BURGLAR (4)
	db "Pete@"
	db 0 ; normal

	; party
	db 40, CHARMELEON
	db 42, MAGMAR

	db $ff ; end

; ================

	; BURGLAR (5)
	db "Louis@"
	db 0 ; normal

	; party
	db 42, ARCANINE
	db 42, RAPIDASH

	db $ff ; end

; ================
; ================================


ScientistGroup:
; ================================
; ================

	; SCIENTIST (1)
	db "Ross@"
	db 0 ; normal

	; party
	db 22, KOFFING
	db 22, KOFFING

	db $ff ; end

; ================

	; SCIENTIST (2)
	db "Mitch@"
	db 0 ; normal

	; party
	db 25, DITTO
	db 25, PORYGON

	db $ff ; end

; ================

	; SCIENTIST (3)
	db "Jed@"
	db 0 ; normal

	; party
	db 20, MAGNEMITE
	db 20, MAGNEMITE
	db 20, MAGNEMITE

	db $ff ; end

; ================

	; SCIENTIST (4)
	db "Garrett@"
	db 0 ; normal

	; party
	db 27, MAGNEMITE
	db 27, MAGNEMITE
	db 27, MAGNEMITE

	db $ff ; end

; ================

	; SCIENTIST (5)
	db "Trenton@"
	db 1 ; moves

	; party

	db 30, PORYGON_Z
		db CONVERSION
		db CONVERSION2
		db RECOVER
		db TRI_ATTACK

	db $ff ; end

; ================

	; SCIENTIST (6)
	db "Lowell@"
	db 0 ; normal

	; party
	db 50, ARCANINE

	db $ff ; end

; ================

	; SCIENTIST (7)
	db "Dennett@"
	db 0 ; normal

	; party
	db 50, NINETALES

	db $ff ; end

; ================

	; SCIENTIST (8)
	db "Linden@"
	db 0 ; normal

	; party
	db 50, MAGMAR

	db $ff ; end

; ================

	; SCIENTIST (9)
	db "Oskar@"
	db 0 ; normal

	; party
	db 48, PORYGON2
	db 45, NINETALES
	db 47, MAGNEZONE

	db $ff ; end

; ================

	; SCIENTIST (10)
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

	; BOARDER (1)
	db "Ronald@"
	db 0 ; normal

	; party
	db 25, SEEL
	db 26, DEWGONG
	db 25, SEEL

	db $ff ; end

; ================

	; BOARDER (2)
	db "Brad@"
	db 0 ; normal

	; party
	db 27, SWINUB
	db 27, SWINUB

	db $ff ; end

; ================

	; BOARDER (3)
	db "Douglas@"
	db 0 ; normal

	; party
	db 25, SHELLDER
	db 26, CLOYSTER
	db 25, SHELLDER

	db $ff ; end

; ================

	; BOARDER (4)
	db "Shaun@"
	db 0 ; normal

	; party
	db 55, CLOYSTER
	db 50, DEWGONG

	db $ff ; end

; ================

	; BOARDER (5)
	db "Bryce@"
	db 0 ; normal

	; party
	db 55, DEWGONG
	db 50, LAPRAS

	db $ff ; end

; ================
; ================================


SkierGroup:
; ================================
; ================

	; SKIER (1)
	db "Roxanne@"
	db 0 ; normal

	; party
	db 29, JYNX

	db $ff ; end

; ================

	; SKIER (2)
	db "Clarissa@"
	db 0 ; normal

	; party
	db 29, DEWGONG

	db $ff ; end

; ================

	; SKIER (3)
	db "Cady@"
	db 0 ; normal

	; party
	db 53, MAMOSWINE

	db $ff ; end

; ================
; ================================


BlackbeltGroup:
; ================================
; ================

	; BLACKBELT_T (1)
	db "Kenji@"
	db 0 ; normal

	; party
	db 27, ONIX
	db 30, HITMONLEE
	db 27, ONIX
	db 32, MACHOKE

	db $ff ; end

; ================

	; BLACKBELT_T (2)
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

	; BLACKBELT_T (3)
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

	; BLACKBELT_T (4)
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

	; BLACKBELT_T (5)
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

	; BLACKBELT_T (6)
	db "Kiyo@"
	db 1 ; moves

	; party

	db 34, HITMONLEE
		db MEDITATE
		db FOCUS_ENERGY
		db HI_JUMP_KICK
		db LOCK_ON

	db 34, HITMONCHAN
		db THUNDERPUNCH
		db ICE_PUNCH
		db FIRE_PUNCH
		db MACH_PUNCH

	db $ff ; end

; ================

	; BLACKBELT_T (7)
	db "Lung@"
	db 0 ; normal

	; party
	db 23, MANKEY
	db 23, MANKEY
	db 25, PRIMEAPE

	db $ff ; end

; ================

	; BLACKBELT_T (8)
	db "Kenji@"
	db 0 ; normal

	; party
	db 28, MACHOKE

	db $ff ; end

; ================

	; BLACKBELT_T (9)
	db "Wai@"
	db 0 ; normal

	; party
	db 30, MACHOKE
	db 32, MACHOKE
	db 34, MACHOKE

	db $ff ; end

; ================
; ================================


TeacherGroup:
; ================================
; ================

	; TEACHER (1)
	db "Colette@"
	db 0 ; normal

	; party
	db 46, CLEFAIRY

	db $ff ; end

; ================

	; TEACHER (2)
	db "Hillary@"
	db 0 ; normal

	; party
	db 37, AIPOM
	db 36, HOPPIP
	db 41, CUBONE

	db $ff ; end

; ================

	; TEACHER (3)
	db "Shirley@"
	db 0 ; normal

	; party
	db 35, JIGGLYPUFF

	db $ff ; end

; ================
; ================================



GuitaristGroup:
; ================================
; ================

	; GUITARIST (1)
	db "Clyde@"
	db 0 ; normal

	; party
	db 34, ELECTABUZZ

	db $ff ; end

; ================

	; GUITARIST (2)
	db "Vincent@"
	db 0 ; normal

	; party
	db 43, VOLTORB
	db 42, MAGNEMITE
	db 45, JOLTEON

	db $ff ; end

; ================
; ================================


BikerGroup:
; ================================
; ================

	; BIKER (1)
	db "Benny@"
	db 0 ; normal

	; party
	db 20, KOFFING
	db 20, KOFFING
	db 20, KOFFING

	db $ff ; end

; ================

	; BIKER (2)
	db "Kazu@"
	db 0 ; normal

	; party
	db 20, KOFFING
	db 20, KOFFING
	db 20, KOFFING

	db $ff ; end

; ================

	; BIKER (3)
	db "Dwayne@"
	db 0 ; normal

	; party
	db 38, KOFFING
	db 39, KOFFING
	db 40, KOFFING
	db 41, KOFFING

	db $ff ; end

; ================

	; BIKER (4)
	db "Harris@"
	db 0 ; normal

	; party
	db 45, FLAREON

	db $ff ; end

; ================

	; BIKER (5)
	db "Zeke@"
	db 0 ; normal

	; party
	db 43, KOFFING
	db 43, KOFFING

	db $ff ; end

; ================

	; BIKER (6)
	db "Charles@"
	db 0 ; normal

	; party
	db 41, KOFFING
	db 41, CHARMELEON
	db 42, WEEZING

	db $ff ; end

; ================

	; BIKER (7)
	db "Riley@"
	db 0 ; normal

	; party
	db 45, WEEZING

	db $ff ; end

; ================

	; BIKER (8)
	db "Joel@"
	db 0 ; normal

	; party
	db 43, MAGMAR
	db 43, MAGMAR

	db $ff ; end

; ================

	; BIKER (9)
	db "Glenn@"
	db 0 ; normal

	; party
	db 39, KOFFING
	db 41, MAGMAR
	db 43, WEEZING

	db $ff ; end

; ================
; ================================


CooltrainerMGroup:
; ================================
; ================

	; COOLTRAINERM (1)
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

	; COOLTRAINERM (2)
	db "Aaron@"
	db 0 ; normal

	; party
	db 24, IVYSAUR
	db 24, CHARMELEON
	db 24, WARTORTLE

	db $ff ; end

; ================

	; COOLTRAINERM (3)
	db "Paulo@"
	db 0 ; normal

	; party
	db 35, DRATINI
	db 35, DRATINI
	db 35, DRATINI

	db $ff ; end

; ================

	; COOLTRAINERM (4)
	db "Cody@"
	db 0 ; normal

	; party
	db 35, HORSEA
	db 37, SEADRA

	db $ff ; end

; ================

	; COOLTRAINERM (5)
	db "Mike@"
	db 0 ; normal

	; party
	db 38, DRAGONAIR

	db $ff ; end

; ================

	; COOLTRAINERM (6)
	db "Gaven@"
	db 1 ; moves

	; party

	db 35, VICTREEBEL
		db WRAP
		db TOXIC
		db ACID
		db RAZOR_LEAF

	db 35, KINGLER
		db BUBBLE_BEAM
		db STOMP
		db GUILLOTINE
		db PROTECT

	db 35, FLAREON
		db SAND_ATTACK
		db QUICK_ATTACK
		db BITE
		db FIRE_SPIN

	db $ff ; end

; ================

	; COOLTRAINERM (7)
	db "Gaven@"
	db 3 ; item + moves

	; party

	db 39, VICTREEBEL, NO_ITEM
		db GIGA_DRAIN
		db TOXIC
		db SLUDGE_BOMB
		db RAZOR_LEAF

	db 39, KINGLER, KINGS_ROCK
		db SURF
		db STOMP
		db GUILLOTINE
		db BLIZZARD

	db 39, FLAREON, NO_ITEM
		db FLAMETHROWER
		db QUICK_ATTACK
		db BITE
		db FIRE_SPIN

	db $ff ; end

; ================

	; COOLTRAINERM (8)
	db "Ryan@"
	db 1 ; moves

	; party

	db 25, PIDGEOT
		db SAND_ATTACK
		db QUICK_ATTACK
		db WHIRLWIND
		db WING_ATTACK

	db 27, ELECTABUZZ
		db THUNDERPUNCH
		db LIGHT_SCREEN
		db SWIFT
		db SCREECH

	db $ff ; end

; ================

	; COOLTRAINERM (9)
	db "Jake@"
	db 1 ; moves

	; party

	db 33, PARASECT
		db LEECH_LIFE
		db SPORE
		db SLASH
		db SWORDS_DANCE

	db 35, GOLDUCK
		db CONFUSION
		db SCREECH
		db CALM_MIND
		db FURY_SWIPES

	db 33, VAPOREON
		db SAND_ATTACK
		db SURF
		db ICY_WIND
		db BITE

	db $ff ; end

; ================

	; COOLTRAINERM (10)
	db "Gaven@"
	db 1 ; moves

	; party

	db 32, VICTREEBEL
		db WRAP
		db TOXIC
		db ACID
		db RAZOR_LEAF

	db 32, KINGLER
		db BUBBLE_BEAM
		db STOMP
		db GUILLOTINE
		db PROTECT

	db 32, FLAREON
		db SAND_ATTACK
		db QUICK_ATTACK
		db BITE
		db FIRE_SPIN

	db $ff ; end

; ================

	; COOLTRAINERM (11)
	db "Blake@"
	db 1 ; moves

	; party

	db 33, MAGNETON
		db THUNDERBOLT
		db SUPERSONIC
		db SWIFT
		db SCREECH

	db 31, QUAGSIRE
		db WATER_GUN
		db SLAM
		db CALM_MIND
		db EARTHQUAKE

	db 31, EXEGGCUTE
		db LEECH_SEED
		db CONFUSION
		db SLEEP_POWDER
		db SOLAR_BEAM

	db $ff ; end

; ================

	; COOLTRAINERM (12)
	db "Brian@"
	db 1 ; moves

	; party

	db 35, SANDSLASH
		db SAND_ATTACK
		db POISON_STING
		db SLASH
		db SWIFT

	db $ff ; end

; ================

	; COOLTRAINERM (13)
	db "Erick@"
	db 0 ; normal

	; party
	db 10, BULBASAUR
	db 10, CHARMANDER
	db 10, SQUIRTLE

	db $ff ; end

; ================

	; COOLTRAINERM (14)
	db "Andy@"
	db 0 ; normal

	; party
	db 10, BULBASAUR
	db 10, CHARMANDER
	db 10, SQUIRTLE

	db $ff ; end

; ================

	; COOLTRAINERM (15)
	db "Tyler@"
	db 0 ; normal

	; party
	db 10, BULBASAUR
	db 10, CHARMANDER
	db 10, SQUIRTLE

	db $ff ; end

; ================

	; COOLTRAINERM (16)
	db "Sean@"
	db 0 ; normal

	; party
	db 35, FLAREON
	db 35, TANGELA
	db 35, TAUROS

	db $ff ; end

; ================

	; COOLTRAINERM (17)
	db "Kevin@"
	db 0 ; normal

	; party
	db 48, RHYHORN
	db 46, CHARMELEON
	db 46, WARTORTLE

	db $ff ; end

; ================

	; COOLTRAINERM (18)
	db "Steve@"
	db 0 ; normal

	; party
	db 14, BULBASAUR
	db 14, CHARMANDER
	db 14, SQUIRTLE

	db $ff ; end

; ================

	; COOLTRAINERM (19)
	db "Allen@"
	db 1 ; moves

	; party

	db 29, CHARMELEON
		db EMBER
		db SMOKESCREEN
		db RAGE
		db SCARY_FACE

	db 29, MAGNEMITE
		db THUNDERSHOCK
		db SUPERSONIC
		db SONIC_BOOM
		db THUNDER_WAVE

	db $ff ; end

; ================

	; COOLTRAINERM (20)
	db "Darin@"
	db 1 ; moves

	; party

	db 37, DRAGONAIR
		db WRAP
		db SURF
		db DRAGON_RAGE
		db SLAM

	db $ff ; end

; ================

	; COOLTRAINERM (21)
	db "Abdul@"
	db 0 ; normal

	; party

	db 53, STANTLER
	db 52, TAUROS

	db $ff ; end

; ================

	; COOLTRAINERM (22)
	db "Elan@"
	db 0 ; normal

	; party

	db 55, PORYGON2

	db $ff ; end

; ================

	; COOLTRAINERM (23)
	db "French@"
	db 0 ; normal

	; party

	db 47, HOUNDOOM
	db 47, ALAKAZAM

	db $ff ; end

; ================

	; COOLTRAINERM (24)
	db "Thom@"
	db 0 ; normal

	; party

	db 25, MAGMAR
	db 25, ELECTABUZZ

	db $ff ; end

; ================
; ================================


CooltrainerFGroup:
; ================================
; ================

	; COOLTRAINERF (1)
	db "Gwen@"
	db 0 ; normal

	; party
	db 26, EEVEE
	db 22, FLAREON
	db 22, VAPOREON
	db 22, JOLTEON

	db $ff ; end

; ================

	; COOLTRAINERF (2)
	db "Lois@"
	db 1 ; moves

	; party

	db 25, SKIPLOOM
		db SYNTHESIS
		db POISONPOWDER
		db MEGA_DRAIN
		db LEECH_SEED

	db 25, NINETALES
		db EMBER
		db QUICK_ATTACK
		db CONFUSE_RAY
		db SAFEGUARD

	db $ff ; end

; ================

	; COOLTRAINERF (3)
	db "Fran@"
	db 0 ; normal

	; party
	db 38, SEADRA

	db $ff ; end

; ================

	; COOLTRAINERF (4)
	db "Lola@"
	db 0 ; normal

	; party
	db 35, DRATINI
	db 37, DRAGONAIR

	db $ff ; end

; ================

	; COOLTRAINERF (5)
	db "Kate@"
	db 0 ; normal

	; party
	db 26, SHELLDER
	db 28, CLOYSTER

	db $ff ; end

; ================

	; COOLTRAINERF (6)
	db "Irene@"
	db 0 ; normal

	; party
	db 22, PSYDUCK
	db 24, GOLDUCK

	db $ff ; end

; ================

	; COOLTRAINERF (7)
	db "Kelly@"
	db 0 ; normal

	; party
	db 27, MARILL
	db 24, WARTORTLE
	db 24, WARTORTLE

	db $ff ; end

; ================

	; COOLTRAINERF (8)
	db "Joyce@"
	db 1 ; moves

	; party

	db 36, PIKACHU
		db QUICK_ATTACK
		db DOUBLE_TEAM
		db THUNDERBOLT
		db THUNDER

	db 36, BLASTOISE
		db BITE
		db CURSE
		db SURF
		db RAIN_DANCE

	db $ff ; end

; ================

	; COOLTRAINERF (9)
	db "Beth@"
	db 1 ; moves

	; party

	db 36, RAPIDASH
		db STOMP
		db FIRE_SPIN
		db FURY_ATTACK
		db AGILITY

	db 36, FLAAFFY
		db SWIFT
		db THUNDERSHOCK
		db THUNDER_WAVE
		db LIGHT_SCREEN

	db $ff ; end

; ================

	; COOLTRAINERF (10)
	db "Reena@"
	db 0 ; normal

	; party
	db 33, GROWLITHE
	db 36, NIDOQUEEN
	db 33, STARMIE

	db $ff ; end

; ================

	; COOLTRAINERF (11)
	db "Megan@"
	db 1 ; moves

	; party

	db 32, BULBASAUR
		db GROWL
		db LEECH_SEED
		db POISONPOWDER
		db RAZOR_LEAF

	db 32, IVYSAUR
		db GROWL
		db LEECH_SEED
		db POISONPOWDER
		db RAZOR_LEAF

	db 32, VENUSAUR
		db BODY_SLAM
		db SLEEP_POWDER
		db RAZOR_LEAF
		db GROWTH

	db $ff ; end

; ================

	; COOLTRAINERF (12)
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

	; COOLTRAINERF (13)
	db "Carol@"
	db 0 ; normal

	; party
	db 35, ELECTRODE
	db 35, STARMIE
	db 35, NINETALES

	db $ff ; end

; ================

	; COOLTRAINERF (14)
	db "Quinn@"
	db 0 ; normal

	; party
	db 47, VENUSAUR
	db 47, STARMIE

	db $ff ; end

; ================

	; COOLTRAINERF (15)
	db "Emma@"
	db 0 ; normal

	; party
	db 28, POLIWHIRL

	db $ff ; end

; ================

	; COOLTRAINERF (16)
	db "Cybil@"
	db 1 ; moves

	; party

	db 29, BUTTERFREE
		db CONFUSION
		db SLEEP_POWDER
		db WHIRLWIND
		db GUST

	db 29, BELLOSSOM
		db ABSORB
		db STUN_SPORE
		db ACID
		db SOLAR_BEAM

	db $ff ; end

; ================

	; COOLTRAINERF (17)
	db "Jenn@"
	db 0 ; normal

	; party
	db 24, STARYU
	db 26, STARMIE

	db $ff ; end

; ================

	; COOLTRAINERF (18)
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

	; COOLTRAINERF (19)
	db "Reena@"
	db 0 ; normal

	; party
	db 36, GROWLITHE
	db 39, NIDOQUEEN
	db 36, STARMIE

	db $ff ; end

; ================

	; COOLTRAINERF (20)
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

	; COOLTRAINERF (21)
	db "Piper@"
	db 1 ; moves

	; party

	db 33, HORSEA
		db SMOKESCREEN
		db LEER
		db WHIRLPOOL
		db TWISTER

	db 33, HORSEA
		db SMOKESCREEN
		db LEER
		db WHIRLPOOL
		db TWISTER

	db 35, SEADRA
		db SWIFT
		db LEER
		db WATERFALL
		db TWISTER

	db $ff ; end

; ================

	; COOLTRAINERF (22)
	db "Salma@"
	db 0 ; normal

	; party

	db 50, SLOWKING
	db 53, KANGASKHAN

	db $ff ; end

; ================

	; COOLTRAINERF (23)
	db "Bonita@"
	db 0 ; normal

	; party

	db 50, GIRAFARIG
	db 52, SUDOWOODO

	db $ff ; end

; ================

	; COOLTRAINERF (24)
	db "Ida@"
	db 0 ; normal

	; party

	db 55, AZUMARILL

	db $ff ; end

; ================

	; COOLTRAINERF (25)
	db "Kae@"
	db 0 ; normal

	; party

	db 25, CLOYSTER
	db 25, ONIX

	db $ff ; end

; ================
; ================================


ExecutiveMGroup:
; ================================
; ================

	; EXECUTIVEM (1)
	; (HGSS Executive Archer)
	db "Executive@"
	db 1 ; moves

	; party

	db 35, HOUNDOUR
		db EMBER
		db ROAR
		db BITE
		db FEINT_ATTACK

	db 35, KOFFING
		db TACKLE
		db SLUDGE
		db SMOKESCREEN
		db HAZE

	db 38, HOUNDOOM
		db EMBER
		db SMOKESCREEN
		db BITE
		db FEINT_ATTACK

	db $ff ; end

; ================

	; EXECUTIVEM (2)
	; (HGSS Executive Proton)
	db "Executive@"
	db 1 ; moves

	; party

	db 30, GOLBAT
		db LEECH_LIFE
		db BITE
		db CONFUSE_RAY
		db WING_ATTACK

	db 32, WEEZING
		db FIRE_BLAST
		db SELFDESTRUCT
		db SLUDGE
		db SMOKESCREEN

	db $ff ; end

; ================

	; EXECUTIVEM (3)
	; (HGSS Executive Petrel)
	db "Executive@"
	db 1 ; moves

	; party

	db 30, KOFFING
		db TACKLE
		db SELFDESTRUCT
		db SLUDGE
		db SMOKESCREEN

	db 30, KOFFING
		db TACKLE
		db SELFDESTRUCT
		db SLUDGE
		db SMOKESCREEN

	db 30, KOFFING
		db TACKLE
		db SELFDESTRUCT
		db SLUDGE
		db SMOKESCREEN

	db 32, WEEZING
		db TACKLE
		db EXPLOSION
		db SLUDGE
		db SMOKESCREEN

	db 30, KOFFING
		db TACKLE
		db SELFDESTRUCT
		db SLUDGE
		db SMOKESCREEN

	db 30, KOFFING
		db TACKLE
		db SELFDESTRUCT
		db SLUDGE
		db SMOKESCREEN

	db $ff ; end

; ================

	; EXECUTIVEM (4)
	; (HGSS Executive Petrel)
	db "Executive@"
	db 0 ; normal

	; party
	db 22, ZUBAT
	db 24, RATICATE
	db 22, KOFFING

	db $ff ; end

; ================
; ================================


ExecutiveFGroup:
; ================================
; ================

	; EXECUTIVEF (1)
	; (HGSS Executive Ariana)
	db "Executive@"
	db 1 ; moves

	; party

	db 32, ARBOK
		db WRAP
		db POISON_STING
		db BITE
		db GLARE

	db 32, VILEPLUME
		db ABSORB
		db GROWTH
		db SLEEP_POWDER
		db ACID

	db 32, HONCHKROW
		db PECK
		db PURSUIT
		db HAZE
		db NIGHT_SHADE

	db $ff ; end

; ================

	; EXECUTIVEF (2)
	; (HGSS Executive Ariana)
	db "Executive@"
	db 1 ; moves

	; party

	db 23, ARBOK
		db WRAP
		db LEER
		db POISON_STING
		db BITE

	db 23, GLOOM
		db ABSORB
		db GROWTH
		db SLEEP_POWDER
		db ACID

	db 25, MURKROW
		db PECK
		db PURSUIT
		db HAZE
		db 0

	db $ff ; end

; ================
; ================================


PokemonProfGroup:
; ================================
; ================
; ================================


GameFreakGroup:
; ================================
; ================

	; GAME_FREAK (1)
	db "Morimoto@"
	db 0 ; normal

	; party
	db 57, HOUNDOOM
	db 57, JOLTEON
	db 57, FLAREON
	db 57, VAPOREON
	db 57, STEELIX
	db 57, RAICHU

	db $ff ; end

; ================

	; GAME_FREAK (2)
	db "Nishino@"
	db 0 ; normal

	; party
	db 57, CLEFABLE
	db 57, AZUMARILL
	db 57, WIGGLYTUFF
	db 57, BLISSEY
	db 57, SNORLAX
	db 57, GOLEM

	db $ff ; end

; ================

	; GAME_FREAK (3)
	db "Ishihara@"
	db 0 ; normal

	; party
	db 57, EXEGGUTOR
	db 57, PORYGON_Z
	db 57, FLAREON
	db 57, DUGTRIO
	db 57, LAPRAS
	db 57, RHYDON

	db $ff ; end

; ================
; ================================


MysticalmanGroup:
; ================================
; ================

	; MYSTICALMAN (1)
	db "Eusine@"
	db 1 ; moves

	; party

	db 25, DROWZEE
		db DREAM_EATER
		db HYPNOSIS
		db DISABLE
		db CONFUSION

	db 25, HAUNTER
		db LICK
		db HYPNOSIS
		db MEAN_LOOK
		db CURSE

	db 25, JUMPLUFF
		db SYNTHESIS
		db GIGA_DRAIN
		db SLEEP_POWDER
		db LEECH_SEED

	db 27, ELECTRODE
		db SCREECH
		db SONIC_BOOM
		db THUNDER
		db ROLLOUT

	db $ff ; end

; ================
; ================================


LoreleiGroup:
; ================================
; ================

	; LORELEI (1)
	db "Lorelei@"
	db 0 ; normal

	; party
	db 30, GLACEON
	db 33, DEWGONG
	db 32, CLOYSTER
	db 33, SLOWBRO
	db 36, JYNX
	db 35, LAPRAS

	db $ff ; end

; ================

	; LORELEI (2)
	db "Lorelei@"
	db 0 ; normal

	; party
	db 49, DEWGONG
	db 48, CLOYSTER
	db 49, SLOWBRO
	db 47, GLACEON
	db 51, JYNX
	db 50, LAPRAS

	db $ff ; end

; ================
; ================================


AgathaGroup:
; ================================
; ================

	; AGATHA (1)
	db "Agatha@"
	db 0 ; normal

	; party
	db 55, GENGAR
	db 55, CROBAT
	db 54, MISMAGIUS
	db 54, MUK
	db 56, ARBOK
	db 57, GENGAR

	db $ff ; end

; ================
; ================================


YellowGroup:
; ================================
; ================

	; YELLOW (1)
	db "Yellow@"
	db 1 ; moves

	; party

	db 26, RATTATA
		db TAIL_WHIP
		db QUICK_ATTACK
		db HYPER_FANG
		db FOCUS_ENERGY

	db 25, BUTTERFREE
		db CONFUSION
		db SLEEP_POWDER
		db POISONPOWDER
		db STUN_SPORE

	db 27, DODUO
		db PECK
		db TRI_ATTACK
		db RETURN
		db MUD_SLAP

	db 26, GRAVELER
		db ROLLOUT
		db DEFENSE_CURL
		db MAGNITUDE
		db ROCK_THROW

	db 25, OMANYTE
		db WATER_GUN
		db BITE
		db DEFENSE_CURL
		db ICY_WIND

	db 28, PIKACHU
		db SURF
		db FLY
		db THUNDERBOLT
		db QUICK_ATTACK

	db $ff ; end

; ================
; ================================


BillGroup:
; ================================
; ================

	; BILL (1)
	db "Bill@"
	db 0 ; normal

	; party
	db 55, VAPOREON
	db 55, JOLTEON
	db 55, FLAREON
	db 56, LEAFEON
	db 56, GLACEON
	db 57, PORYGON2

	db $ff ; end

; ================
; ================================


LawrenceGroup:
; ================================
; ================

	; LAWRENCE (1)
	db "Lawrence@"
	db 0 ; normal

	; party
	db 65, ARTICUNO
	db 62, CHARIZARD
	db 64, DRAGONITE
	db 63, TYRANITAR
	db 61, HONCHKROW
	db 65, ZAPDOS

	db $ff ; end

; ================
; ================================


GiovanniGroup:
; ================================
; ================

	; GIOVANNI (1)
	db "Giovanni@"
	db 0 ; normal

	; party
	db 32, RHYHORN
	db 34, HONCHKROW
	db 36, NIDOKING
	db 34, KANGASKHAN
	db 36, NIDOQUEEN
	db 38, RHYDON

	db $ff ; end

; ================
; ================================


TowerTycoonGroup:
; ================================
; ================
; ================
; ================================


ValerieGroup:
; ================================
; ================

	; VALERIE (1)
	db "Valerie@"
	db 0 ; normal

	; party
	db 33, CLEFABLE
	db 33, MR__MIME
	db 32, WIGGLYTUFF
	db 32, AZUMARILL
	db 34, TOGEKISS
	db 35, SYLVEON

	db $ff ; end

; ================
; ================================
