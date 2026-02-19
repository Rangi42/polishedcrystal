BattleCommand_trick:
	ld a, [wAttackMissed]
	and a
	jr nz, .failed

	call CheckSubstituteOpp
	jr nz, .failed

	call GetOpponentAbilityAfterMoldBreaker
	cp STICKY_HOLD
	jr z, .ability_failed

	; Forbid wildmons from using Trick
	ldh a, [hBattleTurn]
	and a
	jr z, .player
	ld a, [wBattleMode]
	dec a
	jr z, .failed

.player
	call .UserCanBeTricked
	jr z, .failed
	call .OpponentCanBeTricked
	jr z, .failed

	call AnimateCurrentMove

	call GetUserItem
	push hl
	call GetOpponentItem
	pop de

	ld a, [de]
	ld b, [hl]
	ld [hl], a
	or b ; z if none of the participants hold items. We do this check here since we don't want to clobber a until this point.
	jr z, .failed
	ld a, b
	ld [de], a

	ld [hl], c
	ld a, b
	ld [de], a

	ld hl, SwappedItemsText
	call StdBattleTextbox

	ld a, MON_ITEM
	call BattlePartyAttr
	ld a, [wBattleMonItem]
	ld [hl], a

	ld a, MON_ITEM
	call OTPartyAttr
	ret z
	ld a, [wEnemyMonItem]
	ld [hl], a

	; Overwrite your previous item permanently in a wild battle
	ld a, [wBattleMode]
	dec a
	ret nz

	; SetBackupItem doesn't work if existing backup isn't empty
	call GetBackupItemAddr
	ld a, [wBattleMonItem]
	ld [hl], a
	ret

.ability_failed
	farcall BeginAbility
	farcall ShowEnemyAbilityActivation
	call PrintDoesntAffect
	farjp EndAbility
.failed
	call AnimateFailedMove
	jmp PrintButItFailed

.OpponentCanBeTricked:
	call StackCallOpponentTurn
.UserCanBeTricked:
; Wrapper to UserCanLoseItem that also allows lack of held item.
	call GetUserItem
	ld a, [hl]
	and a
	jmp nz, UserCanLoseItem
	or 1
	ret
