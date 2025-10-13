BattleCommand_protect:
	call ProtectChance
	ret nz

	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVarAddr
	set SUBSTATUS_PROTECT, [hl]

	call AnimateCurrentMove

	ld hl, ProtectedItselfText
	jmp StdBattleTextbox

ProtectChance:
; Returns nz upon failure.
	ldh a, [hBattleTurn]
	and a
	ld de, wPlayerProtectCount
	jr z, .got_protect_count
	ld de, wEnemyProtectCount
.got_protect_count
	call CheckOpponentWentFirst
	jr nz, .failed

	; Cumulative 1/3 chance of success per successive use.
	ld a, [de]
	inc a
	cp 7
	jr z, .no_overflow
	ld [de], a
.no_overflow
	ld c, a
.loop
	dec c
	ret z
	ld a, 3
	call BattleRandomRange
	and a
	jr z, .loop

.failed
	xor a
	ld [de], a
	call AnimateFailedMove
	call PrintButItFailed
	or 1
	ret
