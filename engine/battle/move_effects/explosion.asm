BattleCommand_selfdestruct:
	call GetOpponentIgnorableAbility
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
	ld a, BATTLE_VARS_STATUS
	call GetBattleVarAddr
	xor a
	ld [hli], a
	inc hl
	ld [hli], a
	ld [hl], a
	call UpdateUserInParty

	; Resolve de-Unnerve immediately if applicable. We cannot replicate vanilla
	; UI order here, because vanilla does nonsensical things (it can make the
	; foe seemingly recover from 0 HP!)
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVarAddr
	ld a, [hl]
	cp UNNERVE
	jr nz, .not_unnerve
	ld [hl], NO_ABILITY

	farcall HandleLeppaBerry
	farcall HandleHealingItems

.not_unnerve
	ld a, BATTLEANIM_PLAYER_DAMAGE
	ld [wNumHits], a
	ld c, 3
	call DelayFrames
	ld a, $1
	ld [wBattleAnimParam], a
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
