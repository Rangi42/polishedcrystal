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
	ld hl, wPlayerProtectCount
	jr z, .got_protect_count
	ld hl, wEnemyProtectCount
.got_protect_count
	call CheckOpponentWentFirst
	jr nz, .failed

	; Cumulative 1/3 chance of success per successive use capped at 1/729.
	ld a, [hl]
	inc [hl]
	and a
	ret z
	dec a
	cp 5
	jr nz, .no_overflow

	; This will do a 1/243 chack, followed by a 1/3 check.
	ld [hl], a
	call ProtectChance ; Will re-increment [hl] back to its correct value.
	ret nz
	xor a
.no_overflow
	ld de, .ProtectChanceTable
	add e
	ld e, a
	adc d
	sub e
	ld d, a
	ld a, [de]
	call BattleRandomRange
	and a
	ret z

.failed
	xor a
	ld [de], a
	call AnimateFailedMove
	call PrintButItFailed
	or 1
	ret

.ProtectChanceTable:
	db 3
	db 9
	db 27
	db 81
	db 243
