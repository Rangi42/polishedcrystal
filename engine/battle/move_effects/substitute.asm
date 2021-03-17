BattleCommand_substitute:
	call BattleCommand_movedelay

	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVar
	bit SUBSTATUS_SUBSTITUTE, a
	jr nz, .already_has_sub
	call GetQuarterMaxHP
	push bc
	call CompareHP
	pop bc
	jr c, .too_weak_to_sub
	jr z, .too_weak_to_sub

	ld hl, wPlayerSubstituteHP
	ldh a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld hl, wEnemySubstituteHP
.got_hp
	ld a, b
	ld [hli], a
	ld [hl], c
	predef SubtractHPFromUser
	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVarAddr
	set SUBSTATUS_SUBSTITUTE, [hl]

	ld hl, wPlayerWrapCount
	ld de, wPlayerTrappingMove
	ldh a, [hBattleTurn]
	and a
	jr z, .player
	ld hl, wEnemyWrapCount
	ld de, wEnemyTrappingMove
.player
	xor a
	ld [hl], a
	ld [de], a
	call _CheckBattleEffects
	jr c, .no_anim

	xor a
	ld [wNumHits], a
	ld [wFXAnimIDHi], a
	ld [wKickCounter], a
	ld a, SUBSTITUTE
	call LoadAnim
	jr .finish

.no_anim
	call BattleCommand_raisesubnoanim
.finish
	ld hl, MadeSubstituteText
	call StdBattleTextbox
	jp RefreshBattleHuds

.already_has_sub
	call CheckUserIsCharging
	call nz, BattleCommand_raisesub
	ld hl, HasSubstituteText
	jr .jp_stdbattletextbox

.too_weak_to_sub
	call CheckUserIsCharging
	call nz, BattleCommand_raisesub
	ld hl, TooWeakSubText
.jp_stdbattletextbox
	jp StdBattleTextbox
