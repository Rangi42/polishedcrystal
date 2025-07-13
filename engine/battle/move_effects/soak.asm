BattleCommand_soak:
	ld a, [wAttackMissed]
	and a
	jr nz, .failed

	; Move animates if it hits, even if it fails because the target is mono water already
	farcall AnimateCurrentMove

	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyMonType1
	jr z, .got_types
	ld hl, wBattleMonType1
.got_types
	ld a, [hli]
	cp a, WATER
	ld a, [hld]
	jr nz, .not_mono_water
	cp a, WATER
	jr z, .failed
	; Soak will also fail on pokemon with abilities like Multitype, but polished does not have these
.not_mono_water
	ld a, WATER
	; turn target into a pure water/water type
	ld [hli], a
	ld [hl], a

	ld hl, SoakedTargetText
	jmp StdBattleTextbox

.failed
	farjp ButItFailed
