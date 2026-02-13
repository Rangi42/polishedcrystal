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
	; If both items are empty, the move fails.
	; We store a in c, since or-ing with b clobbers a.
	; This is fine, since we intend to clobber a later anyway.
	ld c, a
	or b
	jr z, .failed

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
