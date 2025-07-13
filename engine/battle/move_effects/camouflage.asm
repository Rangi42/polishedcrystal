BattleCommand_camouflage:
	ld a, [wAttackMissed]
	and a
	jr nz, .failed

	farcall AnimateCurrentMove

	ldh a, [hBattleTurn]
	and a
	ld hl, wBattleMonType1
	jr z, .got_types
	ld hl, wEnemyMonType1
.got_types
	push hl
	farcall GetEnvironmentCamouflage
	pop hl
	ld [hli], a
	ld [hl], a
	ld [wNamedObjectIndex], a
	farcall GetTypeName
	ld hl, TransformedTypeText
	jmp StdBattleTextbox

.failed
	farjp ButItFailed
