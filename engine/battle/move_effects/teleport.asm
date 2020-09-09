BattleCommand_teleport:
	ld a, [wBattleType]
	cp BATTLETYPE_TRAP ; or BATTLETYPE_FORCEITEM, BATTLETYPE_RED_GYARADOS, BATTLETYPE_LEGENDARY
	jr nc, .failed

; Switch, don't run, in trainer battles
	ld a, [wBattleMode]
	dec a
	jr nz, .trainer_battle

	call GetTrueUserAbility
	cp RUN_AWAY
	jr z, .run_away
	ld a, BATTLE_VARS_SUBSTATUS2_OPP
	call GetBattleVar
	bit SUBSTATUS_CANT_RUN, a
	jr nz, .failed
	call CheckIfTrappedByAbility
	jr z, .failed

.run_away
	call UpdateBattleMonInParty
	xor a
	ld [wNumHits], a
	inc a
	ld [wBattleEnded], a
	ld [wKickCounter], a
	call BattleCommand_lowersub
	call LoadMoveAnim
	ld c, 20
	call DelayFrames
	call SetBattleDraw

	ld hl, FledFromBattleText
	jp StdBattleTextbox

.trainer_battle
	call CheckAnyOtherAliveMons
	jr z, .failed
	call AnimateCurrentMove
	ld c, 20
	call DelayFrames
	ld a, 1 << SWITCH_DEFERRED
	jp SetDeferredSwitch

.failed
	call AnimateFailedMove
	jp PrintButItFailed
