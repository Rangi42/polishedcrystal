BattleCommand_psychoshift:
	ld a, BATTLE_VARS_STATUS
	call GetBattleVarAddr
	and a
	ld b, a
	push bc
	ld b, 0 ; CanStatusTarget flag
	jr z, .failed
	bit PSN, a
	jr nz, .psn
	bit BRN, a
	jr nz, .brn
	bit PAR, a
	jr nz, .par
	bit FRZ, a
	jr nz, .frz
	; otherwise, sleep
.slp
	farcall CanSleepTarget
	jr .check
.frz
	farcall CanFreezeTarget
	jr .check
.par
	farcall CanParalyzeTarget
	jr .check
.brn
	farcall CanBurnTarget
	jr .check
.psn
	farcall CanPoisonTarget
	; fallthrough
.check
	pop bc
	jr z, .status
	; otherwise immune
.immune
.failed
	farjp ButItFailed
.status
	farcall AnimateCurrentMove
	farcall StatusTarget
	ld a, BATTLE_VARS_STATUS
	call GetBattleVarAddr
	xor a
	ld [hl], a

	ld hl, CuredUserText
	call StdBattleTextbox
	jmp RefreshBattleHuds
    