BattleCommand_checkgravity:
	ld a, [wFieldEffects]
	and FIELD_GRAVITY
	ret z

	farcall AnimateFailedMove
	farcall TryPrintButItFailed
	farjp EndMoveEffect

BattleCommand_gravity:
	ld hl, wFieldEffects
	ld a, FIELD_GRAVITY
	and [hl]
	jr nz, .failed
	ld a, 5
	or [hl]
	ld [hl], a

	ld hl, IntenseGravityText
	call StdBattleTextbox
	; Bring down target
	call SwitchTurn
	call BringUserDown
	; Bring down user (this makes no sense, do it anyway)
	call SwitchTurn
	jr BringUserDown

.failed
	farjp ButItFailed

BringUserDown:
	call GetUserSemiInvuln
	bit SEMI_INVULNERABLE_FLYING_F, a
	ret z
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	res SUBSTATUS_CHARGED, [hl]
	res SUBSTATUS_SEMI_INVULNERABLE, [hl]
	farjp AppearUserRaiseSub
