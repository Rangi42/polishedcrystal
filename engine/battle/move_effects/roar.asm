BattleCommand_roar:
	ld a, [wBattleType]
	cp BATTLETYPE_TRAP ; or BATTLETYPE_FORCEITEM, BATTLETYPE_RED_GYARADOS, BATTLETYPE_LEGENDARY
	jr nc, .but_it_failed
	call GetOpponentAbilityAfterMoldBreaker
	cp SUCTION_CUPS
	ld a, ATKFAIL_ABILITY
	jr z, .fail
	ld a, [wAttackMissed]
	and a
	jr nz, .fail
	ld a, [wBattleMode]
	dec a
	jr z, .wild
	call CheckAnyOtherAliveOpponentMons
	jr nz, .trainer_success

.but_it_failed
	ld a, ATKFAIL_GENERIC
.fail
	ld [wAttackMissed], a
	call AnimateFailedMove
	jmp FailText_CheckOpponentProtect

.wild
	ld a, [wEnemyMonLevel]
	ld b, a
	ld a, [wBattleMonLevel]
	ld c, a

	ldh a, [hBattleTurn]
	and a
	push af
	jr z, .wild_got_party_vars

	ld a, b
	ld b, c
	ld c, a

.wild_got_party_vars
	; b: opponent level, c: user level
	ld a, c
	cp b
	jr nc, .wild_succeed

	; Roamers can still use Roar successfully no matter the level.
	pop af
	jr z, .but_it_failed
	ld a, [wBattleType]
	cp BATTLETYPE_ROAMING
	jr nz, .but_it_failed
	push af

.wild_succeed
	pop af
	call UpdateBattleMonInParty
	xor a
	ld [wNumHits], a
	inc a
	ld [wBattleEnded], a
	call SetBattleDraw
	ld a, $1
	ld [wKickCounter], a
	call AnimateCurrentMove
	ld c, 20
	call DelayFrames
	ld hl, FledInFearText
	jmp StdBattleTextbox

.trainer_success
	call AnimateCurrentMove
	ld c, 20
	call DelayFrames
	ld a, 1 << SWITCH_DEFERRED | 1 << SWITCH_TARGET | 1 << SWITCH_FORCED
	jmp SetDeferredSwitch
