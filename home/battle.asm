GetPartyParamLocation::
; Get the location of parameter a from wCurPartyMon in hl
	push bc
	ld hl, wPartyMons
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [wCurPartyMon]
	call GetPartyLocation
	pop bc
	ld a, [hl]
	ret

GetPartyLocation::
; Add the length of a PartyMon struct to hl a times.
	push bc
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	pop bc
	ret

; *PartyAttr returns address to attribute in hl, content
; in a. Always returns nz (used to return z for wildmon).
TrueUserPartyAttr::
	push bc
	ld c, a
	ldh a, [hBattleTurn]
	and a
	ld hl, wPartyMons
	jr z, .got_partymons
	ld hl, wOTPartyMons
.got_partymons
	ld b, 0
	add hl, bc
	farcall GetFutureSightUser
	call GetPartyLocation
	or 1
	ld a, [hl]
	pop bc
	ret

UserPartyAttr::
	push af
	ldh a, [hBattleTurn]
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
	ldh a, [hBattleTurn]
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

CallOpponentTurn::
	ldh [hFarCallSavedA], a
	ld a, h
	ldh [hFarCallSavedH], a
	ld a, l
	ldh [hFarCallSavedL], a
	pop hl
	call SwitchTurn
	call RetrieveAHLAndCallFunction
	; fallthrough

BattleCommand_switchturn::
SwitchTurn::
; Preserves all registers.
	push af
	ldh a, [hBattleTurn]
	xor 1
	ldh [hBattleTurn], a
	pop af
	ret

SetPlayerTurn::
	ld a, 0
	ldh [hBattleTurn], a
	ret

SetFastestTurn::
	call CheckSpeed
	jr z, SetPlayerTurn
SetEnemyTurn::
	ld a, 1
	ldh [hBattleTurn], a
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
	jmp HalveBC

GetMaxHP::
; output: bc, wBuffer1-2
	farcall GetFutureSightUser
	jr z, .not_external
	ld a, MON_MAXHP
	call TrueUserPartyAttr
	jr .got_maxhp
.not_external
	ld hl, wBattleMonMaxHP
	call GetUserMonAttr
.got_maxhp
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
	ldh a, [hBattleTurn]
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
	ldh a, [hBattleTurn]
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
	ld a, [wCurOTMon]
	ld hl, wOTPartyMon1Level
	call GetPartyLocation

	ld d, h
	ld e, l
	ld hl, wEnemyMonLevel
	ld bc, wEnemyMonMaxHP - wEnemyMonLevel
	rst CopyBytes
	ret

RefreshBattleHuds::
	call UpdateBattleHuds
	call Delay2
	jmp ApplyTilemapInVBlank

UpdateBattleHuds::
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
	ldh a, [hBattleTurn]
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
	jr z, .cannot_lose
	cp ARMOR_SUIT
	jr z, .cannot_lose
	ld d, a
	call ItemIsMail
	jr c, .cannot_lose
	or 1
	jr .done

.cannot_lose
	xor a
.done
	jmp PopBCDEHL

GetOpponentUsedItemAddr::
	call CallOpponentTurn
GetUsedItemAddr::
; Returns addr for user's POV's UsedItem
	ldh a, [hBattleTurn]
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

GetCurMoveProperty::
	ld a, [wCurMove]
GetMoveProperty::
	dec a
GetMoveAttr::
; Assuming hl = Moves + x, return attribute x of move a.
	push bc
	ld bc, MOVE_LENGTH
	rst AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	pop bc
	ret

GetFixedMoveStruct::
; a = move + 1
; de = destination
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	rst AddNTimes
	ld a, BANK(Moves)
	push de
	call FarCopyBytes
	pop hl
	call GetFixedCategory
	ld bc, MOVE_CATEGORY
	add hl, bc
	ld [hl], a
	ret

GetCurMoveFixedCategory::
	ld a, [wCurMove]
GetMoveFixedCategory::
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	rst AddNTimes
GetFixedCategory::
; return category in a without modifying hl
; if category is STATUS, return it
	push hl
	ld bc, MOVE_CATEGORY
	add hl, bc
	ld a, BANK(Moves)
	call GetFarByte
	pop hl
	cp STATUS
	ret z
; if PSS_OPT is on, return the category
	ld b, a
	ld a, [wInitialOptions]
	bit PSS_OPT, a
	ld a, b
	ret nz
; return PHYSICAL or SPECIAL depending on the type
	push hl
	ld bc, MOVE_TYPE
	add hl, bc
	ld a, BANK(Moves)
	call GetFarByte
	pop hl
	cp SPECIAL_TYPES
	ld a, PHYSICAL
	ret c
	inc a ; SPECIAL
	ret

DisappearUser::
	farjp _DisappearUser

ApplyPhysicalDefenseDamageMod::
	push bc
	ld c, a
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_PSYSTRIKE
	ld a, c
	pop bc
	jr z, ApplySpecialAttackDamageMod
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
	jmp MultiplyAndDivide

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

GetOpponentAbility::
	ld a, BATTLE_VARS_ABILITY_OPP
	call GetBattleVar
	cp NEUTRALIZING_GAS
	ret z
	push bc
	ld b, a
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp NEUTRALIZING_GAS
	ld a, b
	pop bc
	ret nz
	xor a
	ret

GetTrueUserAbility::
; Get true user ability after Neutralizing Gas.
; A "true" user might be external, if Future Sight is active.
	farjp _GetTrueUserAbility

GetOpponentAbilityAfterMoldBreaker::
; Returns an opponent's ability unless Mold Breaker
; will suppress it. Preserves bc/de/hl.
	farjp _GetOpponentAbilityAfterMoldBreaker

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
	ldh a, [hBattleTurn]
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
	ldh a, [hBattleTurn]
	xor 1
CheckIfSomeoneIsSomeType:
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
	ret nc
	xor a
	ret

CompareHP::
; return c if HP<bc, z if HP=bc, nc+nz if HP>bc
	push hl
	farcall GetFutureSightUser
	jr z, .not_external
	ld a, MON_HP
	call TrueUserPartyAttr
	jr .got_hp
.not_external
	ld hl, wBattleMonHP
	call GetUserMonAttr
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
	farjp _CheckContactMove

HasUserFainted::
	ldh a, [hBattleTurn]
	and a
	jr z, HasPlayerFainted
HasEnemyFainted::
	ld hl, wEnemyMonHP
	jr CheckIfHPIsZero

HasOpponentFainted::
	ldh a, [hBattleTurn]
	and a
	jr z, HasEnemyFainted
HasPlayerFainted::
	ld hl, wBattleMonHP
CheckIfHPIsZero::
	ld a, [hli]
	or [hl]
	ret

GetWeatherAfterOpponentUmbrella::
	call CallOpponentTurn
GetWeatherAfterUserUmbrella::
	call GetWeatherAfterCloudNine
	cp WEATHER_HAIL
	ret z
	cp WEATHER_SANDSTORM
	ret z
	and a ; WEATHER_NONE?
	ret z
	push bc
	push hl
	predef GetUserItemAfterUnnerve
	ld a, b
	xor HELD_UTILITY_UMBRELLA
	pop hl
	pop bc
	ret z
GetWeatherAfterCloudNine::
; Returns 0 if a cloud nine user is on the field,
; [wBattleWeather] otherwise.
	call CheckNeutralizingGas
	jr z, .weather
	ld a, [wPlayerAbility]
	xor CLOUD_NINE
	ret z
	ld a, [wEnemyAbility]
	xor CLOUD_NINE
	ret z
.weather
	ld a, [wBattleWeather]
	ret

CheckNeutralizingGas::
	ld a, [wPlayerAbility]
	cp NEUTRALIZING_GAS
	ret z
	ld a, [wEnemyAbility]
	cp NEUTRALIZING_GAS
	ret

CheckMoveSpeed::
; Does speed checks, but includes Quick Claw and Lagging Tail, which are only
; taken into account for moves.
	; Quick Claw has a chance to override speed
	ldh a, [hBattleTurn]
	ld e, a
	ld d, 0
	push de
	call SetFastestTurn
	pop de
	call .do_it
	call SwitchTurn
	call .do_it
	ld a, e
	ldh [hBattleTurn], a
	ld a, d ; +1/+2: player, -1/-2: enemy, 0: both/neither
	and a
	jr z, CheckSpeed
	dec a
	ret z
	dec a
	ret

.do_it
	; Increases d if player is given priority, decreases if enemy is given it.
	; d can be +2 or -2 if one is holding Quick Claw and the other Lagging Tail.
	push de

	; Quick Draw works like Quick Claw except 30% of the time
	call GetTrueUserAbility
	cp QUICK_DRAW
	jr nz, .quick_draw_done
	ld b, a
	farcall BufferAbility
	ld a, 100
	call RandomRange
	cp 30
	jr nc, .quick_draw_done

	farcall DisableAnimations
	farcall ShowAbilityActivation
	ld hl, BattleText_UserItemLetItMoveFirst
	call StdBattleTextbox
	farcall EnableAnimations
	jr .set_priority

.quick_draw_done
	predef GetUserItemAfterUnnerve
	ld a, b
	cp HELD_QUICK_CLAW
	jr z, .quick_claw
	cp HELD_CUSTAP_BERRY
	jr z, .custap_berry
	cp HELD_LAGGING_TAIL
	pop de
	ret nz

	; Lagging tail gives the foe priority
	ldh a, [hBattleTurn]
	and a
	ret nz
	dec d
	dec d
	ret

.custap_berry
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
	pop de
	ret nc
.activate_item
	push de
	farcall ItemRecoveryAnim
	predef GetUserItemAfterUnnerve
	call GetCurItemName
	ld hl, BattleText_UserItemLetItMoveFirst
	call StdBattleTextbox
.set_priority
	pop de
	inc d
	ldh a, [hBattleTurn]
	and a
	ret z
	dec d
	dec d
	ret

CheckSpeed::
; Compares speed stat, applying items (usually, see above) and
; stat changes. and see who ends up on top. Returns z if the player
; outspeeds, otherwise nz, randomly on tie (which also sets carry)
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
	ldh a, [hBattleTurn]
	ld e, a
	call SetPlayerTurn
	farcall GetSpeed
	push bc
	call SetEnemyTurn
	farcall GetSpeed
	; restore turn
	ld a, e
	ldh [hBattleTurn], a
	pop de
	; bc is enemy speed, de player
	; The CheckSpeed wrapper assumes this returns 1 if nz, 0 for z to a.
	; Changing this will break Trick Room handling.
	ld a, b
	cp d
	jr c, .player_first
	jr nz, .enemy_first
	ld a, c
	cp e
	jr c, .player_first
	jr nz, .enemy_first
	; Speed is equal, so randomize. Account for linking.
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	ld b, 0
	jr z, .secondary_player
	inc b
.secondary_player
	call BattleRandom
	and $1
	xor b
	scf
	ret
.player_first
	xor a
	ret
.enemy_first
	or 1
	ret

INCLUDE "home/battle_vars.asm"

BattleCommand_cleartext::
EmptyBattleTextbox::
	ld hl, EmptyString
	jr BattleTextbox

StdBattleTextbox::
; Open a textbox and print battle text at 20:hl.
	anonbankpush BattleText

BattleTextbox::
; Open a textbox and print text at hl.
	push hl
	call SpeechTextbox
	call UpdateSprites
	call ApplyTilemap
	pop hl
	jmp PrintTextboxText

GetBattleAnimPointer::
	anonbankpush BattleAnimations

.Function:
	ld a, [hli]
	ld [wBattleAnimAddress], a
	ld a, [hl]
	ld [wBattleAnimAddress + 1], a
	ret

GetBattleAnimByte::
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

HalveBC::
	srl b
	rr c
FloorBC::
	ld a, c
	or b
	ret nz
	inc c
	ret

PushLYOverrides::
	ldh a, [hLCDCPointer]
	and a
	ret z

	ld a, LOW(wLYOverridesBackup)
	ldh [hRequestedVTileSource], a
	ld a, HIGH(wLYOverridesBackup)
	ldh [hRequestedVTileSource + 1], a

	ld a, LOW(wLYOverrides)
	ldh [hRequestedVTileDest], a
	ld a, HIGH(wLYOverrides)
	ldh [hRequestedVTileDest + 1], a

	ld a, (wLYOverridesEnd - wLYOverrides) / 16
	ldh [hLYOverrideStackCopyAmount], a
	ret
