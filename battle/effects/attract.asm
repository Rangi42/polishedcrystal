BattleCommand_Attract: ; 377ce
; attract
	ld a, [AttackMissed]
	and a
	jr nz, .failed
	call CheckOppositeGender
	jr c, .failed
	jr z, .failed
	call CheckHiddenOpponent
	jr nz, .failed
	ld a, BATTLE_VARS_SUBSTATUS1_OPP
	call GetBattleVarAddr
	bit SUBSTATUS_IN_LOVE, [hl]
	call GetOpponentAbilityAfterMoldBreaker
	cp OBLIVIOUS
	jr nz, .no_ability_protection
	farcall ShowEnemyAbilityActivation
	ld hl, DoesntAffectText
	jp StdBattleTextBox

.failed
	jp FailAttract

.no_ability_protection
	; maybe this was called by cute charm
	call ShowPotentialAbilityActivation
	set SUBSTATUS_IN_LOVE, [hl]
	call AnimateCurrentMove

	ld hl, FellInLoveText
	call StdBattleTextBox

	; Check Destiny Knot
	call GetOpponentItemAfterUnnerve
	ld a, b
	cp HELD_DESTINY_KNOT
	jr nz, .destiny_knot_done

	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp OBLIVIOUS
	jr nz, .no_user_ability_protection

	ld b, a
	push bc
	; put ability in buffer 1, item in buffer 2
	ld a, [hl]
	ld [wNamedObjectIndexBuffer], a
	call GetItemName

	ld hl, StringBuffer1
	ld de, StringBuffer2
	ld bc, ITEM_NAME_LENGTH
	call CopyBytes
	pop bc
	farcall BufferAbility
	ld hl, ObliviousPreventedDestinyKnot
	call StdBattleTextBox
	jr .destiny_knot_done

.no_user_ability_protection
	ld a, [hl]
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
	ld hl, DestinyKnotInfatuatedUser
	call StdBattleTextBox
	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVarAddr
	bit SUBSTATUS_IN_LOVE, [hl]

.destiny_knot_done
	; Speed check to see whose side is cured first, in case both
	; got infatuated
	ld a, [hBattleTurn]
	push af
	call SetPlayerTurn
	call CheckSpeed
	call nz, SetEnemyTurn
	call .do_it
	call SwitchTurn
	call .do_it
	pop af
	ld [hBattleTurn], a
	ret

.do_it
	call CheckMentalHerb
	farjp RunStatusHealAbilities

CheckEnemyMentalHerb:
	call SwitchTurn
	call CheckMentalHerb
	jp SwitchTurn

CheckMentalHerb:
	; Check if we hold it
	call GetUserItemAfterUnnerve
	ld a, b
	cp HELD_MENTAL_HERB
	ret nz

	; Keep track of if we're healing stuff in b
	ld b, 0

	; Check infatuation
	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVarAddr
	bit SUBSTATUS_IN_LOVE, [hl]
	jr z, .infatuation_done
	res SUBSTATUS_IN_LOVE, [hl]
	set 0, b

.infatuation_done
	; Check Encore
	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVarAddr
	bit SUBSTATUS_ENCORED, [hl]
	jr z, .encore_done
	res SUBSTATUS_ENCORED, [hl]
	set 1, b

	; Also remove other encore vars
	ld a, [hBattleTurn]
	and a
	ld hl, PlayerEncoreCount
	jr z, .got_encorecount
	ld hl, EnemyEncoreCount
.got_encorecount
	xor a
	ld [hl], a

.encore_done
	; Check Disable
	ld a, [hBattleTurn]
	and a
	ld de, PlayerDisableCount
	ld hl, DisabledMove
	jr z, .got_disable_vars
	ld de, EnemyDisableCount
	ld hl, EnemyDisabledMove
.got_disable_vars
	ld a, [de]
	and a
	jr z, .disable_done
	xor a
	ld [de], a
	ld [hl], a
	set 2, b

.disable_done
	ld a, b
	and a
	ret z

	; We healed something, so consume the item
	push bc
	farcall ItemRecoveryAnim
	call GetUserItem
	ld a, [hl]
	ld [wNamedObjectIndexBuffer], a
	call GetItemName

	pop bc
	bit 0, b
	ld hl, CuredInfatuationWithItem
	call nz, .print
	bit 1, b
	ld hl, CuredEncoreWithItem
	call nz, .print
	bit 2, b
	ld hl, CuredDisableWithItem
	call nz, .print

	farjp ConsumeUserItem

.print
	push bc
	call StdBattleTextBox
	pop bc
	ret

CheckOppositeGender: ; 377f5
; Returns c (either mon is genderless), nc|z (same gender), nc|nz (opposite gender).
; Don't remove the possibility to check for same gender, Rivalry needs this.
	ld a, MON_SPECIES
	call BattlePartyAttr
	ld a, [hl]
	ld [CurPartySpecies], a

	ld a, [CurBattleMon]
	ld [CurPartyMon], a
	xor a
	ld [MonType], a

	farcall GetGender
	ret c ; Player mon is genderless

	ld b, 1
	jr nz, .got_gender
	dec b

.got_gender
	push bc
	ld a, [TempEnemyMonSpecies]
	ld [CurPartySpecies], a
	ld hl, EnemyMonGender
	ld a, [EnemySubStatus2]
	bit SUBSTATUS_TRANSFORMED, a
	jr z, .not_transformed
	ld hl, wEnemyBackupGender
.not_transformed
	ld a, [hl]
	ld [TempMonGender], a
	ld a, 3
	ld [MonType], a
	farcall GetGender
	pop bc
	ret c ; Enemy mon is genderless

	ld a, 1
	jr nz, .got_enemy_gender
	dec a

.got_enemy_gender
	xor b
	ret
