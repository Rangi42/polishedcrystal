BattleCommand_painsplit:
	call CheckHiddenOpponent
	jr nz, .failed

	call AnimateCurrentMove

	; Get HP
	ld hl, wEnemyMonHP + 1
	ld de, wBattleMonHP + 1
	ldh a, [hBattleTurn]
	and a
	call nz, SwapHLDE

	; Set bc to [de] - [hl] (user HP - target HP)
	ld a, [de]
	sub [hl]
	ld c, a
	dec de
	dec hl
	ld a, [de]
	sbc [hl]
	jr c, .target_has_more
	ld b, a
	or c
	jr z, .done ; do nothing, they're equal

	; User has more
.share
	; updates HP anim buffers
	push bc
	call GetMaxHP
	pop bc
	srl b
	rr c
	push bc
	jr nc, .even_share
	inc bc ; HP difference is odd, so round down result (HP decrease is done first)
.even_share
	predef SubtractHPFromUser
	call UpdateUserInParty
	call SwitchTurn
	call GetMaxHP
	pop bc
	farcall RestoreHP
	call UpdateUserInParty
	call SwitchTurn
.done
	ld hl, SharedPainText ; text is turn agnostic, so turn swap if target>user is OK
	jmp StdBattleTextbox

.target_has_more
	cpl
	ld b, a
	ld a, c
	cpl
	ld c, a
	inc bc
	call SwitchTurn
	call .share
	jmp SwitchTurn

.failed
	call AnimateFailedMove
	jmp PrintButItFailed
