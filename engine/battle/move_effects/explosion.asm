BattleCommand_selfdestruct:
	call GetOpponentAbilityAfterMoldBreaker
	cp DAMP
	ret z ; nullification ability checks handle messages
	ld hl, wWhichMonFaintedFirst
	ld a, [hl]
	and a
	jr nz, .faint_target_chosen
	ldh a, [hBattleTurn]
	inc a
	ld [hl], a
.faint_target_chosen
	ld a, BATTLEANIM_PLAYER_DAMAGE
	ld [wNumHits], a
	ld c, 3
	call DelayFrames
	ld a, BATTLE_VARS_STATUS
	call GetBattleVarAddr
	xor a
	ld [hli], a
	inc hl
	ld [hli], a
	ld [hl], a
	ld a, $1
	ld [wKickCounter], a
	call BattleCommand_lowersub
	call LoadMoveAnim
	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVarAddr
	res SUBSTATUS_LEECH_SEED, [hl]
	ld a, BATTLE_VARS_SUBSTATUS2_OPP
	call GetBattleVarAddr
	res SUBSTATUS_DESTINY_BOND, [hl]
	call _CheckBattleEffects
	ret nc
	farcall DrawPlayerHUD
	farcall DrawEnemyHUD
	call ApplyTilemapInVBlank
	jmp RefreshBattleHuds
