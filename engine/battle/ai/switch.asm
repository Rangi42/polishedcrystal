GetSwitchScores:
; e: Score of current mon out
; wEnemyAISwitchScore: Score of optimal switch choice (7 is lowest valid, 0 = can't switch)
; wEnemySwitchMonParam: Index of best switch choice
; Currently uses type matchups only to figure out score, but is designed to be possible
; to change
	xor a
	ld [wEnemySwitchMonParam], a
	ld [wEnemyAISwitchScore], a

	; Store active mon's info so we can overwrite it to check stuff
	ld a, [wEnemyMonItem]
	push af
	ld a, [wEnemyAbility]
	push af

	ld hl, wOTPartyMon1
	ld a, [wOTPartyCount]
	ld b, a
	ld c, 0
	ld e, 0

.loop
	push bc
	push de
	push hl

	; Is this mon alive?
	ld bc, MON_HP
	add hl, bc
	ld a, [hli]
	or [hl]
	jr z, .next

	; Get item
	ld bc, MON_ITEM
	pop hl
	push hl
	add hl, bc
	ld a, [hl]
	ld [wEnemyMonItem], a

	; Get ability and types (via GetBaseData)
	ld bc, wPartyMon1 - wPartyMon1Item
	add hl, bc
	ld a, [hl]

	; This makes GetAbility "restore" to the current species when done
	ld [wCurSpecies], a
	ld bc, wPartyMon1Personality - wPartyMon1
	add hl, bc
	ld c, a
	call GetAbility
	ld a, b
	ld [wEnemyAbility], a

	; Give a type matchup score
	ld bc, MON_MOVES
	pop hl
	push hl
	add hl, bc
	ld bc, wBaseType
	call AICheckMatchupForEnemyMon

.next
	; Checks below are safe if we arrived due to 0HP -- score will be 0 which is never
	; better, and we can use this to check for lack of switch choice ("best score" = 0)
	pop hl
	pop de
	pop bc
	ld d, a ; score

	; Is this the mon that's currently out?
	ld a, [wCurOTMon]
	cp c
	jr nz, .not_active_mon
	ld e, d
	jr .next2

.not_active_mon
	ld a, [wEnemyAISwitchScore]
	cp d
	jr nc, .next2

	; Target mon is a better switch-in
	ld a, d
	ld [wEnemyAISwitchScore], a
	ld a, c
	ld [wEnemySwitchMonParam], a

.next2
	dec b
	jr z, .reset_vars_and_return
	inc c
	push bc
	ld bc, wPartyMon2 - wPartyMon1
	add hl, bc
	pop bc
	jr .loop
.reset_vars_and_return
	; Reset item and ability
	pop af
	ld [wEnemyAbility], a
	pop af
	ld [wEnemyMonItem], a
	ret

CheckPlayerMoveTypeMatchups:
	ld hl, wEnemyMonMoves
	ld bc, wEnemyMonType
	; fallthrough
AICheckMatchupForEnemyMon:
; Check type matchups. Returns a number between 7-13 to a, lower is worse for the enemy.
; Scoring is +1 for SE, -1 for NVE, -2 for ineffective for enemy vs player, and vice versa.
; Lack of offensive moves count as neutral.
; Input is hl (enemy mon moves), bc (enemy mon types). Assumes wEnemyAbility is set

	; Save whose turn it is
	ldh a, [hBattleTurn]
	push af

	; Save move data
	ld a, [wCurPlayerMove]
	ld d, a
	ld a, [wCurEnemyMove]
	ld e, a
	push de
	ld a, [wCurMoveNum]
	ld d, a
	ld a, [wCurEnemyMoveNum]
	ld e, a
	push de

	; Player moves vs enemy
	call SetPlayerTurn
	push hl ; Enemy mon moves
	push bc ; Enemy mon type, popped to hl for CheckTypeMatchup
	ld hl, wPlayerUsedMoves
	call .check_matchups
	ld a, d
	and a
	pop hl
	jr z, .unknown_moves_done
	push hl

	; Less than 4 known moves
	; Assume player has STAB and check those type matchups
	; Done by setting up an arbitrary generic move and manually
	; modifying its type
	res 2, e
	ld a, STRENGTH ; Arbitrary
	ld [wCurPlayerMove], a
	push de
	call UpdateMoveData
	pop de
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVarAddr
	ld a, [wBattleMonType1]
	ld [hl], a
	pop hl
	push hl
	call .set_matchup
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVarAddr
	ld a, [wBattleMonType2]
	ld [hl], a
	pop hl
	call .set_matchup

	; fallthrough
.unknown_moves_done
	pop hl
	call .score_result
	add BASE_AI_SWITCH_SCORE
	push af

	; Now do enemy moves vs player
	ld bc, wBattleMonType
	call SetEnemyTurn
	call .check_matchups
	call .score_result
	ld b, a
	pop af
	sub b
	ld b, a

	; Reset move data
	pop de
	ld a, d
	ld [wCurMoveNum], a
	ld a, e
	ld [wCurEnemyMoveNum], a
	pop de
	ld a, d
	ld [wCurPlayerMove], a
	ld a, e
	ld [wCurEnemyMove], a

	push bc
	call SetPlayerTurn
	call UpdateMoveData
	call SetEnemyTurn
	call UpdateMoveData
	pop bc

	; Reset whose turn it is
	pop af
	ldh [hBattleTurn], a

	ld a, b
	ret

.check_matchups
	; e is %0000ABCD, A = has 0.5x, B = no offensive moves, C = has 1x, D = has 2x
	lb de, NUM_MOVES, %00000100
.loop
	ld a, [hli]
	and a
	ret z
	push hl
	push bc
	ld b, a
	ld a, BATTLE_VARS_MOVE
	call GetBattleVarAddr
	ld [hl], b
	push de
	call UpdateMoveData
	pop de
	ld a, BATTLE_VARS_MOVE_POWER
	call GetBattleVar
	and a
	jr z, .next

	; We have an attacking move, so reset relevant bit
	res 2, e
	pop hl
	push hl
	call .set_matchup
.next
	pop bc
	pop hl
	dec d
	jr nz, .loop
	ret

.set_matchup
	call CheckTypeMatchup
	ld a, [wTypeMatchup]
	and a
	ret z ; no effect
	set 3, e
	cp EFFECTIVE
	ret c ; not very effective
	set 1, e
	ret z ; neutral
	set 0, e
	ret ; super effective

.score_result
	; 2x
	ld a, -1
	srl e
	ret c
	; 1x
	inc a
	srl e
	ret c
	; No attacking moves
	srl e
	ret c
	; 0.5x
	inc a
	srl e
	ret c
	; 0x
	inc a
	ret

AIWantsSwitchCheck:
	call GetSwitchScores
	ld a, [wEnemyAISwitchScore]
	and a
	ret z ; We can't switch

	ld a, [wEnemyPerishCount]
	cp 1
	ld a, [wEnemyAISwitchScore]
	jr nz, .no_perish

	; Perish count is 1
	cp 8
	ret c ; Bad or no choices, sacrifice active mon instead...
	ld b, $30
	jr .set_switch_score

.no_perish
	; Figure out the difference between active and best choice
	sub e
	add 7 ; Make the number easier to work with (changes worst from -6 to +1)
	cp 8
	ret c ; No reason to switch, no switch choice would be better than active mon
	; huge improvement
	ld b, $30
	cp 12
	jr nc, .set_switch_score
	; decent improvement
	ld b, $20
	cp 10
	jr nc, .set_switch_score
	; little improvement
	ld b, $10
	cp 9
	; No reason to switch
	ret c
.set_switch_score
	ld a, [wEnemySwitchMonParam]
	add b
	ld [wEnemySwitchMonParam], a
	ret
