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

	; Check if opponent Soundproof immunity applies
	call GetOpponentAbilityAfterMoldBreaker
	cp SOUNDPROOF
	jr z, .soundproof
	ld a, 4
	ld [de], a
	inc b
	jr .opponent_done

.soundproof
	; Otherwise, notify about soundproof immunity
	push bc
	farcall DisableAnimations
	farcall ShowEnemyAbilityActivation
	ld hl, DoesntAffectText
	call StdBattleTextbox
	farcall EnableAnimations
	pop bc

	; Don't print a failure message if Soundproof suppressed the effect
	dec b
	ret z
	inc b

.opponent_done
	dec b
	jr z, .failed ; nobody was afflicted

	call AnimateCurrentMove
	ld hl, StartPerishText
	jmp StdBattleTextbox

.failed
	call AnimateFailedMove
	jmp PrintButItFailed
