; *PartyAttr returns address to attribute in hl, content
; in a. Always returns nz (used to return z for wildmon).
UserPartyAttr::
	push af
	ld a, [hBattleTurn]
	and a
	jr nz, OTPartyAttrPre
BattlePartyAttrPre:
	pop af
BattlePartyAttr::
	ld hl, wPartyMons
	push bc
	ld c, a
	ld a, [wCurBattleMon]
DoBattlePartyAttr:
	ld b, 0
	add hl, bc
	call GetPartyLocation
	or 1
	ld a, [hl]
	pop bc
	ret

OpponentPartyAttr::
	push af
	ld a, [hBattleTurn]
	and a
	jr nz, BattlePartyAttrPre
OTPartyAttrPre:
	pop af
OTPartyAttr::
	ld hl, wOTPartyMons
	push bc
	ld c, a
	ld a, [wCurOTMon]
	jr DoBattlePartyAttr

ResetDamage::
	xor a
	ld [wCurDamage], a
	ld [wCurDamage + 1], a
	ret

BattleCommand_switchturn::
SwitchTurn::
	ld a, [hBattleTurn]
	push af
	xor 1
	ld [hBattleTurn], a
	pop af
	ret

SetPlayerTurn::
	ld a, 0
	ld [hBattleTurn], a
	ret

SetFastestTurn::
	call CheckSpeed
	jr z, SetPlayerTurn
SetEnemyTurn::
	ld a, 1
	ld [hBattleTurn], a
	ret

GetThirdMaxHP::
; Assumes HP<768
	call GetMaxHP
	xor a
	inc b
.loop
	dec b
	inc a
	dec bc
	dec bc
	dec bc
	inc b
	jr nz, .loop
	dec a
	ld c, a
	ret nz
	inc c
	ret

GetSixteenthMaxHP::
	call GetEighthMaxHP
	jr HalfHP

GetEighthMaxHP::
	call GetQuarterMaxHP
	jr HalfHP

GetSixthMaxHP::
	call GetThirdMaxHP
	jr HalfHP

GetQuarterMaxHP::
	call GetHalfMaxHP
	jr HalfHP

GetHalfMaxHP::
	call GetMaxHP
HalfHP::
	jp HalveBC

GetMaxHP::
; output: bc, wBuffer1-2

	ld hl, wBattleMonMaxHP
	ld a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wEnemyMonMaxHP
.ok
	ld a, [hli]
	ld [wBuffer2], a
	ld b, a

	ld a, [hl]
	ld [wBuffer1], a
	ld c, a
	ret

GetOpponentMonAttr::
	call CallOpponentTurn
GetUserMonAttr::
	ld a, [hBattleTurn]
	and a
	ret z
	push bc
	ld bc, wEnemyMonSpecies - wBattleMonSpecies
	add hl, bc
	pop bc
	ret

GetOpponentMonAttr_de::
	call CallOpponentTurn
GetUserMonAttr_de::
	push hl
	ld h, d
	ld l, e
	call GetUserMonAttr
	ld d, h
	ld e, l
	pop hl
	ret

UpdateOpponentInParty::
	call CallOpponentTurn
UpdateUserInParty::
	ld a, [hBattleTurn]
	and a
	jr nz, UpdateEnemyMonInParty
	; fallthrough
UpdateBattleMonInParty::
; Update level, status, current HP
	ld a, [wCurBattleMon]
	; fallthrough
UpdateBattleMon::
	ld hl, wPartyMon1Level
	call GetPartyLocation

	ld d, h
	ld e, l
	ld hl, wBattleMonLevel
	ld bc, wBattleMonMaxHP - wBattleMonLevel
	rst CopyBytes
	ret

UpdateEnemyMonInParty::
; No wildmons.
	ld a, [wCurOTMon]
	ld hl, wOTPartyMon1Level
	call GetPartyLocation

	ld d, h
	ld e, l
	ld hl, wEnemyMonLevel
	ld bc, wEnemyMonMaxHP - wEnemyMonLevel
	rst CopyBytes
	ret

RefreshBattleHuds:: ; 39c9
	call UpdateBattleHuds
	call Delay2
	jp ApplyTilemapInVBlank
; 39d4

UpdateBattleHuds:: ; 39d4
	farcall UpdatePlayerHUD
	farjp UpdateEnemyHUD

GetBackupItemAddr::
; Returns address of backup item for current mon in hl
	push bc
	ld a, [wCurBattleMon]
	ld c, a
	ld b, 0
	ld hl, wPartyBackupItems
	add hl, bc
	pop bc
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
; Restores items from wPartyBackupItems
	ld c, 1
	; fallthrough
ToggleBattleItems:
	ld b, 7
	ld hl, wPartyMon1Item
	ld de, wPartyBackupItems
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

OpponentCanLoseItem::
	call CallOpponentTurn
UserCanLoseItem::
; Returns z if user can't lose its held item. This happens if:
; - user doesn't have a held item
; - user is holding Armor Suit
; - user is holding Mail
; Does not check Sticky Hold (we just want to know if we can
; theoretically lose our item at any point)
	push hl
	push de
	push bc
	farcall GetUserItem
	ld a, [hl]
	and a
	jr z, .pop_and_ret_z
	ld d, a
	call ItemIsMail
	jr c, .pop_and_ret_z
	ld de, 2
	ld hl, .StuckItems
	call IsInArray
	jr nc, .pop_and_ret_nz
	inc hl
	ld a, [hBattleTurn]
	and a
	ld de, wBattleMonSpecies
	jr z, .got_species
	ld de, wEnemyMonSpecies
.got_species
	ld a, [de]
	cp [hl]
	jr nz, .pop_and_ret_z
.pop_and_ret_nz
	pop bc
	pop de
	pop hl
	or 1
	ret
.pop_and_ret_z
	pop bc
	pop de
	pop hl
	xor a
	ret

.StuckItems
	db ARMOR_SUIT, MEWTWO
	db -1

GetOpponentUsedItemAddr::
	call CallOpponentTurn
GetUsedItemAddr::
; Returns addr for user's POV's UsedItem
	ld a, [hBattleTurn]
	and a
	ld hl, wPartyUsedItems
	ld a, [wCurBattleMon]
	jr z, .got_target
	ld hl, wOTPartyUsedItems
	ld a, [wCurOTMon]
.got_target
	add l
	ld l, a
	ret nc
	inc h
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
	call _hl_
	or 1
.end
	pop bc
	ret

GetMoveAttr::
; Assuming hl = Moves + x, return attribute x of move a.
	push bc
	ld bc, MOVE_LENGTH
	rst AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	pop bc
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
; a = $xy: multiply multiplicands by x, then divide by y
; Used by things other than damage
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
; will suppress it. Preserves bc/de/hl.
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

LegendaryMons::
	db ARTICUNO
	db ZAPDOS
	db MOLTRES
	db RAIKOU
	db ENTEI
	db SUICUNE
UberMons::
; banned from Battle Tower
	db MEWTWO
	db MEW
	db LUGIA
	db HO_OH
	db CELEBI
	db -1

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
	db BUG_BITE
	db BULLET_PUNCH
	db CLOSE_COMBAT
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
	db DRAIN_PUNCH
	db DRILL_PECK
	db DYNAMICPUNCH
	db EXTREMESPEED
	db FALSE_SWIPE
	db FEINT_ATTACK
	db FIRE_PUNCH
	db FLAME_WHEEL
	db FLARE_BLITZ
	db FLY
	db FURY_STRIKES
	db GYRO_BALL
	db GIGA_IMPACT
	db HEADBUTT
	db HI_JUMP_KICK
	db HORN_ATTACK
	db HYPER_FANG
	db ICE_PUNCH
	db IRON_HEAD
	db IRON_TAIL
	db KARATE_CHOP
	db KNOCK_OFF
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
	db POWER_WHIP
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
	db SUPER_FANG
	db TACKLE
	db TAKE_DOWN
	db THIEF
	db THRASH
	db THUNDERPUNCH
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
	db DRAIN_PUNCH
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
	db TOXIC_SPIKES
	db -1

DynamicPowerMoves::
; used by Forewarn and for move power listing
	db COUNTER
	db DRAGON_RAGE
	db GYRO_BALL
;   db LOW_KICK
	db MAGNITUDE
	db MIRROR_COAT
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
	jr CheckIfTargetIsSomeType
CheckIfTargetIsGroundType::
	ld a, GROUND
	jr CheckIfTargetIsSomeType
CheckIfTargetIsGhostType::
	ld a, GHOST
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
	ld de, wEnemyMonType1
	ld a, c
	and a
	jr z, .ok
	ld de, wBattleMonType1
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
	call GetThirdMaxHP
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
	ld hl, wBattleMonHP
	ld a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld hl, wEnemyMonHP
.got_hp
	ld a, [hli]
	sub b
	jr nz, .ok
	ld a, [hl]
	sub c
.ok
	pop hl
	ret

CheckOpponentContactMove::
	call CallOpponentTurn
CheckContactMove::
; Check if user's move made contact. Returns nc if it is
	farcall GetUserItemAfterUnnerve
	ld a, b
	cp HELD_PROTECTIVE_PADS
	jr z, .protective_pads
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	cp STRUGGLE
	ret z
	ld hl, ContactMoves
	ld de, 1
	call IsInArray
.protective_pads
	ccf
	ret

HasUserFainted::
	ld a, [hBattleTurn]
	and a
	jr z, HasPlayerFainted
HasEnemyFainted::
	ld hl, wEnemyMonHP
	jr CheckIfHPIsZero

HasOpponentFainted::
	ld a, [hBattleTurn]
	and a
	jr z, HasEnemyFainted
HasPlayerFainted::
	ld hl, wBattleMonHP
CheckIfHPIsZero::
	ld a, [hli]
	or [hl]
	ret

GetWeatherAfterCloudNine::
; Returns 0 if a cloud nine user is on the field,
; [wWeather] otherwise.
	ld a, [wPlayerAbility]
	xor CLOUD_NINE
	ret z
	ld a, [wEnemyAbility]
	xor CLOUD_NINE
	ret z
	ld a, [wWeather]
	ret

CheckSpeedWithQuickClaw::
	; Quick Claw has a chance to override speed
	ld a, [hBattleTurn]
	ld e, a
	ld d, 0
	push de
	call SetPlayerTurn
	call CheckSpeed
	call nz, SetEnemyTurn
	pop de
	call .do_it
	call SwitchTurn
	call .do_it
	ld a, e
	ld [hBattleTurn], a
	ld a, d ; +1: player, -1: enemy, 0: both/neither
	and a
	jr z, CheckSpeed
	dec a
	ret
.do_it
	push de
	farcall GetUserItemAfterUnnerve
	pop de
	ld a, b
	cp HELD_QUICK_CLAW
	jr z, .quick_claw
	cp HELD_CUSTAP_BERRY
	ret nz

	push de
	farcall QuarterPinchOrGluttony
	pop de
	ret nz
	call .activate_item
	push de
	farcall ConsumeUserItem
	pop de
	ret

.quick_claw
	ld a, 100
	call BattleRandomRange
	cp c
	ret nc
	push de
.activate_item
	farcall ItemRecoveryAnim
	farcall GetUserItemAfterUnnerve
	call GetCurItemName
	ld hl, BattleText_UserItemLetItMoveFirst
	call StdBattleTextBox
	pop de
	inc d
	ld a, [hBattleTurn]
	and a
	ret z
	dec d
	dec d
	ret

CheckSpeed::
; Compares speed stat, applying items (usually, see above) and
; stat changes. and see who ends up on top. Returns z if the player
; outspeeds, otherwise nz, randomly on tie (which also sets carry)
	farcall GetPlayerItem
	ld c, 0
	ld a, b
	cp HELD_LAGGING_TAIL
	jr nz, .no_player_lagging_tail
	dec c
.no_player_lagging_tail
	push bc
	farcall GetEnemyItem
	ld a, b
	pop bc
	cp HELD_LAGGING_TAIL
	jr nz, .no_enemy_lagging_tail
	inc c
.no_enemy_lagging_tail
	; c=0: both/none holds, 255: player holds, 1: enemy holds
	dec c
	ret z
	inc c
	ret nz

	ld a, [wTrickRoom]
	and a
	jr z, _CheckSpeed
	call _CheckSpeed
	ret c ; was random anyway, and we don't want to unset carry
	xor 1
	ret

_CheckSpeed::
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
	ld a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
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
; Preserves bc, de, hl.
	push hl
	call GetBattleVarAddr
	pop hl
	ret
; 39e7

GetBattleVarAddr:: ; 39e7
; Get variable from pair a, depending on whose turn it is.
; There are 22 variable pairs.
; Preserves bc, de.
	push bc

	ld hl, .battlevarpairs
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc

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
	add hl, bc
	add hl, bc

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
.curmoveopp     db ENEMY_CUR_MOVE,        PLAYER_CUR_MOVE
.lastcounter    db PLAYER_COUNTER_MOVE,   ENEMY_COUNTER_MOVE
.lastcounteropp db ENEMY_COUNTER_MOVE,    PLAYER_COUNTER_MOVE
.lastmove       db PLAYER_LAST_MOVE,      ENEMY_LAST_MOVE
.lastmoveopp    db ENEMY_LAST_MOVE,       PLAYER_LAST_MOVE

.vars
	dw wPlayerSubStatus1,             wEnemySubStatus1
	dw wPlayerSubStatus2,             wEnemySubStatus2
	dw wPlayerSubStatus3,             wEnemySubStatus3
	dw wPlayerSubStatus4,             wEnemySubStatus4
	dw wPlayerAbility,                wEnemyAbility
	dw wBattleMonStatus,              wEnemyMonStatus
	dw wPlayerMoveStructAnimation,   wEnemyMoveStructAnimation
	dw wPlayerMoveStructEffect,      wEnemyMoveStructEffect
	dw wPlayerMoveStructPower,       wEnemyMoveStructPower
	dw wPlayerMoveStructAccuracy,    wEnemyMoveStructAccuracy
	dw wPlayerMoveStructType,        wEnemyMoveStructType
	dw wPlayerMoveStructCategory,    wEnemyMoveStructCategory
	dw wCurPlayerMove,                wCurEnemyMove
	dw wLastEnemyCounterMove,         wLastPlayerCounterMove
	dw wLastPlayerMove,               wLastEnemyMove
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
	rst CopyBytes
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

GetBattleAnimPointer::
	anonbankpush BattleAnimations

.Function:
	ld a, [hli]
	ld [wBattleAnimAddress], a
	ld a, [hl]
	ld [wBattleAnimAddress + 1], a
	ret

GetBattleAnimByte:: ; 3af0
	anonbankpush BattleAnimations

.Function:
	push hl
	push de

	ld hl, wBattleAnimAddress
	ld e, [hl]
	inc hl
	ld d, [hl]

	ld a, [de]
	ld [wBattleAnimByte], a
	inc de

	ld a, d
	ld [hld], a
	ld [hl], e

	pop de
	pop hl

	ld a, [wBattleAnimByte]
	ret
; 3b0c
