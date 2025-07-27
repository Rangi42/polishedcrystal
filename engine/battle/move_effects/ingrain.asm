BattleCommand_ingrain:
	ld a, BATTLE_VARS_SUBSTATUS5
	call GetBattleVarAddr
	bit SUBSTATUS_INGRAIN, a
	jr nz, .failed

	set SUBSTATUS_INGRAIN, [hl]
	farcall AnimateCurrentMove
	ld hl, PlantedRootsText
	jmp StdBattleTextbox

.failed
	farjp ButItFailed
