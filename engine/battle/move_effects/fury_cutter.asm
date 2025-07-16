DEF FURY_CUTTER_MAX_POWER EQU 160

; Doubles power for each time fury cutter is used consecutively
; Will dynamically respond to base power
BattleCommand_furycutter:
	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerFuryCutterCount
	jr z, .got_count
	ld hl, wEnemyFuryCutterCount
.got_count
	inc [hl]
	jr nz, .incremented
	dec [hl] ; cap at 255
.incremented
	ld b, [hl]
	ld a, BATTLE_VARS_MOVE_POWER
	call GetBattleVarAddr
	ld a, [hl]
.loop
	dec b
	jr z, .done
	add a
	jr nc, .loop
	ld a, FURY_CUTTER_MAX_POWER
.done
	cp a, FURY_CUTTER_MAX_POWER + 1
	jr c, .got_power
	ld a, FURY_CUTTER_MAX_POWER
.got_power
	ld [hl], a
	ret
