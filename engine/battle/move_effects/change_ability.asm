AbilityChanges:
	dwb SIMPLE_BEAM, SIMPLE
	dwb WORRY_SEED,  INSOMNIA
	dwb GASTRO_ACID, NO_ABILITY
	dw -1

BattleCommand_changeability:
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	call GetMoveIndexFromID
	ld b, h
	ld c, l
	ld hl, AbilityChanges
	ld de, 3
	call IsInWordArray
	jr nc, .failed
	inc hl
	inc hl
	ld b, [hl]
	ld a, b
	and a
	jr z, .suppress

	ld a, BATTLE_VARS_ABILITY_OPP
	call GetBattleVarAddr
	ld a, [hl]
	cp a, b
	jr z, .failed

	call AnimateCurrentMove

	ld [hl], b

	farcall BufferAbility
	ld hl, BattleText_AbilityAcquired
.print_change
	jmp StdBattleTextbox

	call SwitchTurn
	farcall RunEntryAbilitiesInner
	jmp SwitchTurn

.suppress
	ld a, BATTLE_VARS_SUBSTATUS1_OPP
	call GetBattleVarAddr
	set SUBSTATUS_ABILITY_SUPPRESSED, [hl]
	ld hl, BattleText_AbilitySuppressed
	jr .print_change

.failed
	call AnimateFailedMove
	jmp PrintButItFailed
