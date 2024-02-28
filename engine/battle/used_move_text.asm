if DEF(DEBUG)
MoveTable:
	; Current animation pending testing
	db DARK_PULSE

	; RBYGSC moves
	db KARATE_CHOP
	db DOUBLE_SLAP
	db PAY_DAY
	db FIRE_PUNCH
	db ICE_PUNCH
	db THUNDERPUNCH
	db SCRATCH
	db SWORDS_DANCE
	db CUT
	db GUST
	db WING_ATTACK
	db FLY
	db VINE_WHIP
	db STOMP
	db DOUBLE_KICK
	db HEADBUTT
	db HORN_ATTACK
	db TACKLE
	db BODY_SLAM
	db WRAP
	db TAKE_DOWN
	db THRASH
	db DOUBLE_EDGE
	db POISON_STING
	db PIN_MISSILE
	db LEER
	db BITE
	db GROWL
	db ROAR
	db SING
	db SUPERSONIC
	db SONIC_BOOM
	db DISABLE
	db ACID
	db EMBER
	db FLAMETHROWER
	db WATER_GUN
	db HYDRO_PUMP
	db SURF
	db ICE_BEAM
	db BLIZZARD
	db PSYBEAM
	db BUBBLE_BEAM
	db AURORA_BEAM
	db HYPER_BEAM
	db PECK
	db DRILL_PECK
	db LOW_KICK
	db COUNTER
	db SEISMIC_TOSS
	db STRENGTH
	db ABSORB
	db MEGA_DRAIN
	db LEECH_SEED
	db GROWTH
	db RAZOR_LEAF
	db SOLAR_BEAM
	db POISONPOWDER
	db STUN_SPORE
	db SLEEP_POWDER
	db PETAL_DANCE
	db STRING_SHOT
	db DRAGON_RAGE
	db FIRE_SPIN
	db THUNDERSHOCK
	db THUNDERBOLT
	db THUNDER_WAVE
	db THUNDER
	db ROCK_THROW
	db EARTHQUAKE
	db DIG
	db TOXIC
	db CONFUSION
	db PSYCHIC_M
	db HYPNOSIS
	db AGILITY
	db QUICK_ATTACK
	db RAGE
	db TELEPORT
	db NIGHT_SHADE
	db SCREECH
	db DOUBLE_TEAM
	db RECOVER
	db MINIMIZE
	db SMOKESCREEN
	db CONFUSE_RAY
	db DEFENSE_CURL
	db BARRIER
	db LIGHT_SCREEN
	db HAZE
	db REFLECT
	db FOCUS_ENERGY
	db METRONOME
	db LICK
	db FIRE_BLAST
	db WATERFALL
	db SWIFT
	db AMNESIA
	db FRESH_SNACK
	db HI_JUMP_KICK
	db GLARE
	db DREAM_EATER
	db LEECH_LIFE
	db TRANSFORM
	db DIZZY_PUNCH
	db SPORE
	db FLASH
	db SPLASH
	db CRABHAMMER
	db EXPLOSION
	db FURY_STRIKES
	db BONEMERANG
	db REST
	db ROCK_SLIDE
	db HYPER_FANG
	db CONVERSION
	db TRI_ATTACK
	db SUPER_FANG
	db SLASH
	db SUBSTITUTE
	db SKETCH
	db THIEF
	db CURSE
	db AEROBLAST
	db REVERSAL
	db PROTECT
	db MACH_PUNCH
	db SCARY_FACE
	db FEINT_ATTACK
	db SWEET_KISS
	db BELLY_DRUM
	db SLUDGE_BOMB
	db MUD_SLAP
	db OCTAZOOKA
	db SPIKES
	db ZAP_CANNON
	db FORESIGHT
	db DESTINY_BOND
	db PERISH_SONG
	db ICY_WIND
	db OUTRAGE
	db SANDSTORM
	db GIGA_DRAIN
	db ENDURE
	db CHARM
	db ROLLOUT
	db FALSE_SWIPE
	db SWAGGER
	db SPARK
	db STEEL_WING
	db MEAN_LOOK
	db ATTRACT
	db SLEEP_TALK
	db HEAL_BELL
	db RETURN
	db SAFEGUARD
	db PAIN_SPLIT
	db SACRED_FIRE
	db MAGNITUDE
	db DYNAMICPUNCH
	db MEGAHORN
	db DRAGONBREATH
	db BATON_PASS
	db ENCORE
	db PURSUIT
	db RAPID_SPIN
	db IRON_TAIL
	db METAL_CLAW
	db HEALINGLIGHT
	db HIDDEN_POWER
	db CROSS_CHOP
	db RAIN_DANCE
	db SUNNY_DAY
	db CRUNCH
	db MIRROR_COAT
	db EXTREMESPEED
	db ANCIENTPOWER
	db SHADOW_BALL
	db FUTURE_SIGHT
	db ROCK_SMASH
	db WHIRLPOOL

;- gen3 moves
	db HAIL
	db WILL_O_WISP
	db FACADE
	db TRICK
	db KNOCK_OFF
	db SKILL_SWAP
	db HYPER_VOICE
	db ASTONISH
	db EXTRASENSORY
	db AERIAL_ACE
	db ICICLE_SPEAR
	db DRAGON_CLAW
	db BULK_UP
	db CALM_MIND
	db DRAGON_DANCE
	db ROCK_BLAST
	db WATER_PULSE

;- gen4 moves
	db ROOST
	db GYRO_BALL
	db U_TURN
	db CLOSE_COMBAT
	db SUCKER_PUNCH
	db TOXIC_SPIKES
	db FLARE_BLITZ
	db AURA_SPHERE
	db POISON_JAB
	db DARK_PULSE
	db NIGHT_SLASH
	db AQUA_TAIL
	db SEED_BOMB
	db AIR_SLASH
	db X_SCISSOR
	db BUG_BUZZ
	db DRAGON_PULSE
	db POWER_GEM
	db DRAIN_PUNCH
	db FOCUS_BLAST
	db ENERGY_BALL
	db BRAVE_BIRD
	db EARTH_POWER
	db GIGA_IMPACT
	db NASTY_PLOT
	db BULLET_PUNCH
	db AVALANCHE
	db ICE_SHARD
	db SHADOW_CLAW
	db ZEN_HEADBUTT
	db FLASH_CANNON
	db TRICK_ROOM
	db POWER_WHIP
	db GUNK_SHOT
	db IRON_HEAD
	db STONE_EDGE
	db BUG_BITE
	db AQUA_JET

;- gen5 moves
	db HONE_CLAWS
	db VENOSHOCK
	db FLAME_CHARGE
	db SCALD
	db SHELL_SMASH
	db HEX
	db ACROBATICS
	db VOLT_SWITCH
	db BULLDOZE
	db WILD_CHARGE
	db PSYSTRIKE
	db HURRICANE
	db ICICLE_CRASH

;- gen6 moves
	db DISARM_VOICE
	db DRAINING_KISS
	db PLAY_ROUGH
	db MOONBLAST
	db DAZZLINGLEAM
	db 0

DisplayUsedMoveText:
	jr .do_it ; comment this out for testing all move animations
	ld a, BATTLE_VARS_MOVE
	call GetBattleVarAddr
	ld de, MoveTable
.loop
	ld a, [de]
	inc de
	and a
	ret z
	ld [hl], a
	push hl
	push de
	farcall UpdateMoveData
	call .do_it
	farcall AnimateCurrentMove
	pop de
	pop hl
	jr .loop

.do_it
else
DisplayUsedMoveText:
endc
	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVar
	bit SUBSTATUS_IN_ABILITY, a
	ret nz

	ldh a, [hBattleTurn]
	and a
	jr nz, .start

	ld a, [wPlayerMoveStruct + MOVE_ANIM]
	call UpdateUsedMoves

.start
	ld a, BATTLE_VARS_LAST_MOVE
	call GetBattleVarAddr

	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	ld [wMoveGrammar], a

	; Skip last move update if move was called (1=called, 2=Power Herb)
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerCharging]
	jr z, .got_charging
	ld a, [wEnemyCharging]
.got_charging
	cp 1
	jr z, .charging

	; update last move
	push hl
	ld a, BATTLE_VARS_LAST_COUNTER_MOVE
	call GetBattleVarAddr
	ld a, [wMoveGrammar]
	ld [hl], a
	pop hl
	ld [hl], a

.charging
	; check obedience
	ld hl, UsedMoveText
	ld a, [wAlreadyDisobeyed]
	and a
	jr z, .ok
	ld hl, UsedMoveInsteadText
.ok
	call StdBattleTextbox
	jmp ApplyTilemapInVBlank

UpdateUsedMoves:
; append move a to wPlayerUsedMoves unless it has already been used

	push bc
; start of list
	ld hl, wPlayerUsedMoves
; get move id
	ld b, a
; next count
	ld c, NUM_MOVES

.loop
; get move from the list
	ld a, [hli]
; not used yet?
	and a
	jr z, .add
; already used?
	cp b
	jr z, .quit
; next byte
	dec c
	jr nz, .loop

; if the list is full and the move hasn't already been used
; shift the list back one byte, deleting the first move used
; this can occur with struggle or a new learned move
	ld hl, wPlayerUsedMoves + 1
; 1 = 2
	ld a, [hld]
	ld [hli], a
; 2 = 3
	inc hl
	ld a, [hld]
	ld [hli], a
; 3 = 4
	inc hl
	ld a, [hld]
	ld [hl], a
; 4 = new move
	ld a, b
	ld [wPlayerUsedMoves + 3], a
	jr .quit

.add
; go back to the byte we just inced from
	dec hl
; add the new move
	ld [hl], b

.quit
; list updated
	pop bc
	ret
