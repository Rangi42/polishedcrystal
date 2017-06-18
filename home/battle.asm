UserPartyAttr:: ; 3945
	push af
	ld a, [hBattleTurn]
	and a
	jr nz, .ot
	pop af
	jr BattlePartyAttr
.ot
	pop af
	jr OTPartyAttr
; 3951


;OpponentPartyAttr:: ; 3951
;	push af
;	ld a, [hBattleTurn]
;	and a
;	jr z, .ot
;	pop af
;	jr BattlePartyAttr
;.ot
;	pop af
;	jr OTPartyAttr
;; 395d


BattlePartyAttr:: ; 395d
; Get attribute a from the active BattleMon's party struct.
	push bc
	ld c, a
	ld b, 0
	ld hl, PartyMons
	add hl, bc
	ld a, [CurBattleMon]
	call GetPartyLocation
	pop bc
	ret
; 396d


OTPartyAttr:: ; 396d
; Get attribute a from the active EnemyMon's party struct.
	push bc
	ld c, a
	ld b, 0
	ld hl, OTPartyMon1Species
	add hl, bc
	ld a, [CurOTMon]
	call GetPartyLocation
	pop bc
	ret
; 397d


ResetDamage:: ; 397d
	xor a
	ld [CurDamage], a
	ld [CurDamage + 1], a
	ret
; 3985

SetPlayerTurn:: ; 3985
	xor a
	ld [hBattleTurn], a
	ret
; 3989

SetEnemyTurn:: ; 3989
	ld a, 1
	ld [hBattleTurn], a
	ret
; 398e

SwitchTurn::
	ld a, [hBattleTurn]
	xor 1
	ld [hBattleTurn], a
	ret

UpdateOpponentInParty:: ; 398e
	ld a, [hBattleTurn]
	and a
	jr z, UpdateEnemyMonInParty
	jr UpdateBattleMonInParty
; 3995

UpdateUserInParty:: ; 3995
	ld a, [hBattleTurn]
	and a
	jr z, UpdateBattleMonInParty
	jr UpdateEnemyMonInParty
; 399c

UpdateBattleMonInParty:: ; 399c
; Update level, status, current HP

	ld a, [CurBattleMon]

UpdateBattleMon:: ; 399f
	ld hl, PartyMon1Level
	call GetPartyLocation

	ld d, h
	ld e, l
	ld hl, BattleMonLevel
	ld bc, BattleMonMaxHP - BattleMonLevel
	jp CopyBytes
; 39b0

UpdateEnemyMonInParty:: ; 39b0
; Update level, status, current HP

; No wildmons.
	ld a, [wBattleMode]
	dec a
	ret z

	ld a, [CurOTMon]
	ld hl, OTPartyMon1Level
	call GetPartyLocation

	ld d, h
	ld e, l
	ld hl, EnemyMonLevel
	ld bc, EnemyMonMaxHP - EnemyMonLevel
	jp CopyBytes
; 39c9


RefreshBattleHuds:: ; 39c9
	call UpdateBattleHuds
	ld c, 3
	call DelayFrames
	jp WaitBGMap
; 39d4

UpdateBattleHuds:: ; 39d4
	farcall UpdatePlayerHUD
	farcall UpdateEnemyHUD
	ret

GetBackupItemAddr::
; Returns address of backup item for current mon in hl
	ld a, [CurBattleMon]
	ld hl, PartyBackupItems
	add l
	ld l, a
	ret nc
	inc h
	ret

SetBackupItem::
	; If backup is empty, replace with b if our turn (even in trainer battles)
	ld a, [hBattleTurn]
	and a
	ret nz

	call GetBackupItemAddr
	ld a, [hl]
	and a
	ret nz
	ld [hl], b
	ret

BackupBattleItems::
; Copies items from party to a backup of items. Doesn't care if player has less than 6 mons
; since messing with these item bytes in-battle is safe
	ld c, 0
	jr ToggleBattleItems
RestoreBattleItems::
; Restores items from PartyBackupItems
	ld c, 1
	; fallthrough
ToggleBattleItems:
	ld b, 7
	ld hl, PartyMon1Item
	ld de, PartyBackupItems
.loop
	dec b
	ret z
	ld a, c
	and a
	jr nz, .restore

	; Backup
	ld a, [hl]
	ld [de], a
	jr .next

.restore
	ld a, [de]
	ld [hl], a

.next
	inc de
	push bc
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	pop bc
	jr .loop

GetUsedItemAddr::
; Returns addr for user's POV's UsedItem
	ld a, [hBattleTurn]
	and a
	ld hl, PartyUsedItems
	ld a, [CurBattleMon]
	jr z, .got_target
	ld hl, OTPartyUsedItems

	; Wildmons use the 1st index
	ld a, [wBattleMode]
	dec a
	ret z
	ld a, [CurOTMon]
.got_target
	add l
	ld l, a
	ret nc
	inc h
	ret

ConsumeEnemyItem::
	call SwitchTurn
	call ConsumeUserItem
	jp SwitchTurn

ConsumeUserItem::
	ld a, [hBattleTurn]
	and a
	ld a, [CurBattleMon]
	ld de, BattleMonItem
	ld hl, PartyMon1Item
	jr z, .got_item_pointers
	ld a, [CurOTMon]
	ld de, EnemyMonItem
	ld hl, OTPartyMon1Item
.got_item_pointers
	push bc
	call GetPartyLocation
	pop bc

	; Air Balloons are consumed permanently, so don't write it to UsedItems
	ld a, [de]
	cp AIR_BALLOON
	jr z, .consume_item
	push hl
	push af
	call GetUsedItemAddr
	pop af
	ld [hl], a
	pop hl

.consume_item
	xor a
	ld [de], a

	; Wildmons has no OTPartyMon1Item, but we want to consume our own items still
	ld a, [hBattleTurn]
	and a
	jr z, .has_party_struct

	ld a, [wBattleMode]
	dec a
	jr z, .apply_unburden

.has_party_struct
	ld a, [hl]
	ld d, a
	xor a
	ld [hl], a
	ld a, [hBattleTurn]
	and a
	jr nz, .apply_unburden

	; For players, maybe remove the backup item too if we're dealing with a berry
	ld a, d
	ld [CurItem], a
	push de
	push bc
	farcall CheckItemPocket
	pop bc
	pop de
	ld a, [wItemAttributeParamBuffer]
	cp BERRIES
	jr nz, .apply_unburden
	call GetBackupItemAddr

	; If the backup is different, don't touch it. This prevents consuming i.e. Focus Sash
	; under the following scenario: Sash procs, steal an Oran Berry, use the Oran Berry
	ld a, [hl]
	cp d
	jr nz, .apply_unburden
	xor a
	ld [hl], a
	
.apply_unburden
	; Unburden doubles Speed when an item is consumed
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp UNBURDEN
	ret nz

	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVarAddr
	set SUBSTATUS_UNBURDEN, [hl]
	ret

BattleJumptable::
; hl = jumptable, a = target. Returns z if no jump was made, nz otherwise
	; Maybe make this a common function? Maybe one exist?
	push bc
	ld b, a
.loop
	ld a, [hli]
	cp -1
	jr z, .end
	cp b
	jr z, .got_target
	inc hl
	inc hl
	jr .loop
.got_target
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call .jp_hl
	or 1
.end
	pop bc
	ret
.jp_hl
	jp hl

GetMoveAttr::
; Assuming hl = Moves + x, return attribute x of move a.
	push bc
	ld bc, MOVE_LENGTH
	call AddNTimes
	call GetMoveByte
	pop bc
	ret

GetMoveData::
; Copy move struct a to de.
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, Bank(Moves)
	jp FarCopyBytes

GetMoveByte::
	ld a, BANK(Moves)
	jp GetFarByte

DisappearUser::
	farcall _DisappearUser
	ret

; Damage modifiers. a contains $xy where damage is multiplied by x, then divided by y
ApplyPhysicalAttackDamageMod::
	push bc
	ld b, PHYSICAL
	jr ApplyAttackDamageMod
ApplySpecialAttackDamageMod::
	push bc
	ld b, SPECIAL
ApplyAttackDamageMod::
	ld c, a
	ld a, BATTLE_VARS_MOVE_CATEGORY
	call GetBattleVar
	cp b
	ld a, c
	pop bc
	ret nz
	jr ApplyDamageMod

ApplyPhysicalDefenseDamageMod::
	push bc
	ld c, a
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_PSYSTRIKE
	ld a, c
	pop bc
	jr z, ApplySpecialAttackDamageMod
	jr ApplyPhysicalAttackDamageMod

ApplySpecialDefenseDamageMod::
	push bc
	ld c, a
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_PSYSTRIKE
	ld a, c
	pop bc
	ret z
	jr ApplySpecialAttackDamageMod

ApplyDamageMod::
	push bc
	push hl
	ld b, a
	swap a
	and $f
	ld hl, hMultiplier
	ld [hl], a
	push bc
	call Multiply
	pop bc
	ld a, b
	and $f
	ld [hl], a
	ld b, 4
	call Divide
	pop hl
	pop bc
	ret


GetOpponentAbilityAfterMoldBreaker:: ; 39e1
; Returns an opponent's ability unless Mold Breaker
; will suppress it.
	push de
	push bc
	ld a, BATTLE_VARS_ABILITY_OPP
	call GetBattleVar
	ld b, a
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	and a
	cp MOLD_BREAKER
	jr z, .cont_check
	ld a, b
	jr .end
.cont_check
	ld a, b
	ld de, 1
	push hl
	push bc
	ld hl, MoldBreakerSuppressedAbilities
	call IsInArray
	pop bc
	pop hl
	jr c, .suppressed
	ld a, b
	jr .end
.suppressed:
	ld a, NO_ABILITY
.end
	pop bc
	pop de
	ret

MoldBreakerSuppressedAbilities:
	db BATTLE_ARMOR
	db BIG_PECKS
	db DAMP
	db DRY_SKIN
	db FILTER
	db FLASH_FIRE
	db HYPER_CUTTER
	db IMMUNITY
	db INNER_FOCUS
	db INSOMNIA
	db KEEN_EYE
	db LEAF_GUARD
	db LEVITATE
	db LIGHTNING_ROD
	db LIMBER
	db MAGIC_BOUNCE
	db MAGMA_ARMOR
	db MARVEL_SCALE
	db MOTOR_DRIVE
	db MULTISCALE
	db OBLIVIOUS
	db OVERCOAT
	db OWN_TEMPO
	db SAND_VEIL
	db SAP_SIPPER
	db SHELL_ARMOR
	db SHIELD_DUST
	db SNOW_CLOAK
	db SOLID_ROCK
	db SOUNDPROOF
	db STICKY_HOLD
	db STURDY
	db SUCTION_CUPS
	db THICK_FAT
	db UNAWARE
	db VITAL_SPIRIT
	db VOLT_ABSORB
	db WATER_ABSORB
	db WATER_VEIL
	db WONDER_SKIN
	db -1

ContactMoves::
	db AERIAL_ACE
	db AQUA_TAIL
	db ASTONISH
	db BITE
	db BODY_SLAM
	db BULLET_PUNCH
	db COUNTER
	db CRABHAMMER
	db CROSS_CHOP
	db CRUNCH
	db CUT
	db DIG
	db DIZZY_PUNCH
	db DOUBLE_KICK
	db DOUBLE_EDGE
	db DRAGON_CLAW
	db DRAIN_KISS
	db DRILL_PECK
	db DYNAMICPUNCH
	db EXTREMESPEED
	db FALSE_SWIPE
	db FEINT_ATTACK
	db FIRE_PUNCH
	db FLAIL
	db FLAME_WHEEL
	db FLARE_BLITZ
	db FLY
	db FURY_ATTACK
	db FURY_CUTTER
	db FURY_SWIPES
	db GIGA_IMPACT
	db HEADBUTT
	db HI_JUMP_KICK
	db HORN_ATTACK
	db HYPER_FANG
	db ICE_PUNCH
	db IRON_HEAD
	db IRON_TAIL
	db KARATE_CHOP
	db LEECH_LIFE
	db LICK
	db LOW_KICK
	db MACH_PUNCH
	db MEGAHORN
	db METAL_CLAW
	db NIGHT_SLASH
	db OUTRAGE
	db PECK
	db PETAL_DANCE
	db PLAY_ROUGH
	db POISON_JAB
	db PURSUIT
	db QUICK_ATTACK
	db RAGE
	db RAPID_SPIN
	db RETURN
	db REVERSAL
	db ROCK_SMASH
	db ROLLOUT
	db SCRATCH
	db SEISMIC_TOSS
	db SHADOW_CLAW
	db SLASH
	db SPARK
	db STEEL_WING
	db STOMP
	db STRENGTH
	db SUBMISSION
	db SUPER_FANG
	db TACKLE
	db TAKE_DOWN
	db THIEF
	db THRASH
	db THUNDERPUNCH
	db TRIPLE_KICK
	db U_TURN
	db VINE_WHIP
	db WATERFALL
	db WILD_CHARGE
	db WING_ATTACK
	db WRAP
	db X_SCISSOR
	db ZEN_HEADBUTT
	db -1

PowderMoves::
	db POISONPOWDER
	db SLEEP_POWDER
	db SPORE
	db STUN_SPORE
	db -1

PunchingMoves::
	db BULLET_PUNCH
	db DIZZY_PUNCH
	db DYNAMICPUNCH
	db FIRE_PUNCH
	db MACH_PUNCH
	db THUNDERPUNCH
	db -1

SoundMoves::
	db BUG_BUZZ
	db DISARM_VOICE
	db GROWL
	db HYPER_VOICE
	db METAL_SOUND
	db PERISH_SONG
	db ROAR
	db SCREECH
	db SING
	db SUPERSONIC
	db -1

SubstituteBypassMoves::
; used by Magic Bounce so it can check Substitute unconditionally as long as it isn't here
; (Sound moves aren't included)
	db ATTRACT
	db DISABLE
	db ENCORE
	db FORESIGHT
	db SPIKES
	db -1

DynamicPowerMoves::
; used by Forewarn and for move power listing
	db COUNTER
	db MIRROR_COAT
	db DRAGON_RAGE
	db FLAIL
;   db LOW_KICK
	db MAGNITUDE
	db NIGHT_SHADE
	db RETURN
	db REVERSAL
	db SEISMIC_TOSS
	db SONIC_BOOM
	db SUPER_FANG
	db -1

; These routines return z if the user is of the given type
CheckIfTargetIsGrassType::
	ld a, GRASS
	jr CheckIfTargetIsSomeType
CheckIfTargetIsPoisonType::
	ld a, POISON
	jr CheckIfTargetIsSomeType
CheckIfTargetIsElectricType::
	ld a, ELECTRIC
	jr CheckIfTargetIsSomeType
CheckIfTargetIsSteelType::
	ld a, STEEL
	jr CheckIfTargetIsSomeType
CheckIfTargetIsFireType::
	ld a, FIRE
	jr CheckIfTargetIsSomeType
CheckIfTargetIsIceType::
	ld a, ICE
	jr CheckIfTargetIsSomeType
CheckIfTargetIsDarkType::
	ld a, DARK
	jr CheckIfTargetIsSomeType
CheckIfTargetIsRockType::
	ld a, ROCK
;	jr CheckIfTargetIsSomeType
;CheckIfTargetIsGroundType::
;	ld a, GROUND
CheckIfTargetIsSomeType::
	ld b, a
	ld a, [hBattleTurn]
	jr CheckIfSomeoneIsSomeType
CheckIfUserIsFlyingType::
	ld a, FLYING
	jr CheckIfUserIsSomeType
CheckIfUserIsPoisonType::
	ld a, POISON
	jr CheckIfUserIsSomeType
CheckIfUserIsGhostType::
	ld a, GHOST
	jr CheckIfUserIsSomeType
CheckIfUserIsGroundType::
	ld a, GROUND
	jr CheckIfUserIsSomeType
CheckIfUserIsRockType::
	ld a, ROCK
	jr CheckIfUserIsSomeType
CheckIfUserIsSteelType::
	ld a, STEEL
	jr CheckIfUserIsSomeType
CheckIfUserIsIceType::
	ld a, ICE
CheckIfUserIsSomeType::
	ld b, a
	ld a, [hBattleTurn]
	xor 1
CheckIfSomeoneIsSomeType
	ld c, a
	ld de, EnemyMonType1
	ld a, c
	and a
	jr z, .ok
	ld de, BattleMonType1
.ok
	ld a, [de]
	inc de
	cp b
	ret z
	ld a, [de]
	cp b
	ret

CheckPinch::
; return z if we are in a pinch (HP<=1/3)
	push hl
	farcall GetThirdMaxHP
	call CompareHP
	pop hl
	jr c, .ok
	ret
.ok
	xor a
	ret

CompareHP::
; return c if HP<bc, z if HP=bc, nc+nz if HP>bc
	push hl
	ld hl, BattleMonHP
	ld a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld hl, EnemyMonHP
.got_hp
	ld a, [hli]
	sub b
	jr nz, .ok
	ld a, [hl]
	sub c
.ok
	pop hl
	ret

GetWeatherAfterCloudNine::
; Returns 0 if a cloud nine user is on the field,
; [Weather] otherwise.
	ld a, [PlayerAbility]
	cp CLOUD_NINE
	jr z, .suppress
	ld a, [EnemyAbility]
	cp CLOUD_NINE
	jr z, .suppress
	ld a, [Weather]
	ret
.suppress
	xor a
	ret

CheckSpeed::
; Quick Claw only applies for moves
	ld d, 0
	jr CheckSpeedInner
CheckSpeedWithQuickClaw::
	ld d, 1
CheckSpeedInner:
; Compares speed stat, applying items (usually, see above) and
; stat changes. and see who ends up on top. Returns z if the player
; outspeeds, otherwise nz, randomly on tie (which also sets carry)
	; save battle turn so this can be used without screwing it up
	; (needed for AI)
	ld a, [hBattleTurn]
	ld e, a
	call SetPlayerTurn
	farcall GetSpeed
	push bc
	call SetEnemyTurn
	farcall GetSpeed
	; restore turn
	ld a, e
	ld [hBattleTurn], a
	pop de
	; bc is enemy speed, de player
	ld a, b
	cp d
	jr c, .player_first
	jr nz, .enemy_first
	ld a, c
	cp e
	jr c, .player_first
	jr nz, .enemy_first
	; Speed is equal, so randomize. Account for linking.
	ld a, [hLinkPlayerNumber]
	cp 2
	ld b, 0
	jr z, .secondary_player
	ld b, 1
.secondary_player
	call BattleRandom
	and $1
	xor b
	and a
	scf
	ret
.player_first
	xor a
	ret
.enemy_first
	or 1
	ret

GetBattleVar:: ; 39e1
; Preserves hl.
	push hl
	call GetBattleVarAddr
	pop hl
	ret
; 39e7

GetBattleVarAddr:: ; 39e7
; Get variable from pair a, depending on whose turn it is.
; There are 22 variable pairs.

	push bc

	ld hl, .battlevarpairs
	ld c, a
	ld b, 0
rept 2
	add hl, bc
endr

	ld a, [hli]
	ld h, [hl]
	ld l, a

; Enemy turn uses the second byte instead.
; This lets battle variable calls be side-neutral.
	ld a, [hBattleTurn]
	and a
	jr z, .getvar
	inc hl

.getvar
; var id
	ld a, [hl]
	ld c, a
	ld b, 0

	ld hl, .vars
rept 2
	add hl, bc
endr

	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld a, [hl]

	pop bc
	ret

.battlevarpairs
	dw .substatus1, .substatus2, .substatus3, .substatus4
	dw .substatus1opp, .substatus2opp, .substatus3opp, .substatus4opp
	dw .ability, .abilityopp, .status, .statusopp, .animation, .effect
	dw .power, .accuracy, .type, .category, .curmove, .lastcounter
	dw .lastcounteropp, .lastmove, .lastmoveopp

;                       player                     enemy
.substatus1     db PLAYER_SUBSTATUS_1,    ENEMY_SUBSTATUS_1
.substatus1opp  db ENEMY_SUBSTATUS_1,     PLAYER_SUBSTATUS_1
.substatus2     db PLAYER_SUBSTATUS_2,    ENEMY_SUBSTATUS_2
.substatus2opp  db ENEMY_SUBSTATUS_2,     PLAYER_SUBSTATUS_2
.substatus3     db PLAYER_SUBSTATUS_3,    ENEMY_SUBSTATUS_3
.substatus3opp  db ENEMY_SUBSTATUS_3,     PLAYER_SUBSTATUS_3
.substatus4     db PLAYER_SUBSTATUS_4,    ENEMY_SUBSTATUS_4
.substatus4opp  db ENEMY_SUBSTATUS_4,     PLAYER_SUBSTATUS_4
.ability        db PLAYER_ABILITY,        ENEMY_ABILITY
.abilityopp     db ENEMY_ABILITY,         PLAYER_ABILITY
.status         db PLAYER_STATUS,         ENEMY_STATUS
.statusopp      db ENEMY_STATUS,          PLAYER_STATUS
.animation      db PLAYER_MOVE_ANIMATION, ENEMY_MOVE_ANIMATION
.effect         db PLAYER_MOVE_EFFECT,    ENEMY_MOVE_EFFECT
.power          db PLAYER_MOVE_POWER,     ENEMY_MOVE_POWER
.accuracy       db PLAYER_MOVE_ACCURACY,  ENEMY_MOVE_ACCURACY
.type           db PLAYER_MOVE_TYPE,      ENEMY_MOVE_TYPE
.category       db PLAYER_MOVE_CATEGORY,  ENEMY_MOVE_CATEGORY
.curmove        db PLAYER_CUR_MOVE,       ENEMY_CUR_MOVE
.lastcounter    db PLAYER_COUNTER_MOVE,   ENEMY_COUNTER_MOVE
.lastcounteropp db ENEMY_COUNTER_MOVE,    PLAYER_COUNTER_MOVE
.lastmove       db PLAYER_LAST_MOVE,      ENEMY_LAST_MOVE
.lastmoveopp    db ENEMY_LAST_MOVE,       PLAYER_LAST_MOVE

.vars
	dw PlayerSubStatus1,             EnemySubStatus1
	dw PlayerSubStatus2,             EnemySubStatus2
	dw PlayerSubStatus3,             EnemySubStatus3
	dw PlayerSubStatus4,             EnemySubStatus4
	dw PlayerAbility,                EnemyAbility
	dw BattleMonStatus,              EnemyMonStatus
	dw wPlayerMoveStructAnimation,   wEnemyMoveStructAnimation
	dw wPlayerMoveStructEffect,      wEnemyMoveStructEffect
	dw wPlayerMoveStructPower,       wEnemyMoveStructPower
	dw wPlayerMoveStructAccuracy,    wEnemyMoveStructAccuracy
	dw wPlayerMoveStructType,        wEnemyMoveStructType
	dw wPlayerMoveStructCategory,    wEnemyMoveStructCategory
	dw CurPlayerMove,                CurEnemyMove
	dw LastEnemyCounterMove,         LastPlayerCounterMove
	dw LastPlayerMove,               LastEnemyMove
; 3a90


FarCopyRadioText:: ; 3a90
	inc hl
	ld a, [hROMBank]
	push af
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld [hROMBank], a
	ld [MBC3RomBank], a
	ld a, e
	ld l, a
	ld a, d
	ld h, a
	ld de, wRadioText
	ld bc, 2 * SCREEN_WIDTH
	call CopyBytes
	pop af
	ld [hROMBank], a
	ld [MBC3RomBank], a
	ret
; 3ab2


BattleTextBox:: ; 3ac3
; Open a textbox and print text at hl.
	push hl
	call SpeechTextBox
	call UpdateSprites
	call ApplyTilemap
	pop hl
	jp PrintTextBoxText
; 3ad5


StdBattleTextBox:: ; 3ad5
; Open a textbox and print battle text at 20:hl.

GLOBAL BattleText

	ld a, [hROMBank]
	push af

	ld a, BANK(BattleText)
	rst Bankswitch

	call BattleTextBox

	pop af
	rst Bankswitch
	ret
; 3ae1

GetBattleAnimPointer:: ; 3ae1

GLOBAL BattleAnimations
GLOBAL BattleAnimCommands

	ld a, BANK(BattleAnimations)
	rst Bankswitch

	ld a, [hli]
	ld [BattleAnimAddress], a
	ld a, [hl]
	ld [BattleAnimAddress + 1], a

	ld a, BANK(BattleAnimCommands)
	rst Bankswitch

	ret
; 3af0

GetBattleAnimByte:: ; 3af0

	push hl
	push de

	ld hl, BattleAnimAddress
	ld e, [hl]
	inc hl
	ld d, [hl]

	ld a, BANK(BattleAnimations)
	rst Bankswitch

	ld a, [de]
	ld [BattleAnimByte], a
	inc de

	ld a, BANK(BattleAnimCommands)
	rst Bankswitch

	ld [hl], d
	dec hl
	ld [hl], e

	pop de
	pop hl

	ld a, [BattleAnimByte]
	ret
; 3b0c
