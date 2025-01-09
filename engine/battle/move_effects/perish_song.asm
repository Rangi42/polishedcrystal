BattleCommand_perishsong:
	; Track if we have afflicted anyone with Perish
	ld b, 1

	; Set hl to user perish, de to opponent perish
	ld hl, wPlayerPerishCount
	ld de, wEnemyPerishCount
	ldh a, [hBattleTurn]
	and a
	call nz, SwapHLDE

	; Handle user Perish
	ld a, [hl]
	and a
	jr nz, .user_done
	ld [hl], 4
	inc b

.user_done
	; Handle opponent Perish
	ld a, [de]
	and a
	jr nz, .opponent_done

	; Check if opponent has immunity to this move in some way.
	; This will, if applicable, print an immunity message, so
	; we shouldn't do that here too.
	push de
	push bc
	call BattleCommand_checkpriority
	pop bc
	pop de

	ld a, [wAttackMissed]
	and a
	jr nz, .immune

	ld a, 4
	ld [de], a
	inc b

.immune
	; Don't print a failure message if Soundproof suppressed the effect
	dec b
	ret z
	inc b

.opponent_done
	dec b
	jr z, .failed ; nobody was afflicted

	call AnimateCurrentMove
	ld hl, StartPerishSongText
	jmp StdBattleTextbox

.failed
	call AnimateFailedMove
	jmp PrintButItFailed
