AIChooseMove: ; 440ce
; Score each move in EnemyMonMoves starting from Buffer1. Lower is better.
; Pick the move with the lowest score.

	; Linking is handled elsewhere
	ld a, [wLinkMode]
	and a
	ret nz

	; No use picking a move if there's no choice.
	farcall CheckEnemyLockedIn
	ret nz

	; Default score is 20, unusable moves are set to 80.
	call SetEnemyTurn
	ld hl, Buffer1 + 3
	ld a, 4
.unusable_loop
	dec a
	push af
	push hl
	farcall CheckUsableMove
	ld a, 20
	jr z, .unusable_next
	ld a, 80
.unusable_next
	pop hl
	ld [hl], a
	pop af
	dec hl
	and a
	jr nz, .unusable_loop

	; Wildmons choose moves at random
	ld a, [wBattleMode]
	dec a
	jr z, .DecrementScores

; Apply AI scoring layers depending on the trainer class.
.ApplyLayers:
	ld hl, TrainerClassAttributes + TRNATTR_AI_MOVE_WEIGHTS

	; If we have a battle in BattleTower just load the Attributes of the first TrainerClass (Falkner)
	; so we have always the same AI, regardless of the loaded class of trainer
	ld a, [InBattleTowerBattle]
	bit 0, a
	jr nz, .battle_tower_skip

	ld a, [TrainerClass]
	dec a
	ld bc, 7 ; Trainer2AI - Trainer1AI
	call AddNTimes

.battle_tower_skip
	lb bc, CHECK_FLAG, 0
	push bc
	push hl

.CheckLayer:
	pop hl
	pop bc

	ld a, c
	cp 16 ; up to 16 scoring layers
	jr z, .DecrementScores

	push bc
	ld d, BANK(TrainerClassAttributes)
	predef FlagPredef
	ld d, c
	pop bc

	inc c
	push bc
	push hl

	ld a, d
	and a
	jr z, .CheckLayer

	ld hl, AIScoringPointers
	dec c
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, BANK(AIScoring)
	call FarCall_hl

	jr .CheckLayer

; Decrement the scores of all moves one by one until one reaches 0.
.DecrementScores:
	ld hl, Buffer1
	ld de, EnemyMonMoves
	ld c, NUM_MOVES

.DecrementNextScore:
	; If the enemy has no moves, this will infinite.
	ld a, [de]
	inc de
	and a
	jr z, .DecrementScores

	; We are done whenever a score reaches 0
	dec [hl]
	jr z, .PickLowestScoreMoves

	; If we just decremented the fourth move's score, go back to the first move
	inc hl
	dec c
	jr z, .DecrementScores

	jr .DecrementNextScore

; In order to avoid bias towards the moves located first in memory, increment the scores
; that were decremented one more time than the rest (in case there was a tie).
; This means that the minimum score will be 1.
.PickLowestScoreMoves:
	ld a, c

.move_loop
	inc [hl]
	dec hl
	inc a
	cp NUM_MOVES + 1
	jr nz, .move_loop

	ld hl, Buffer1
	ld de, EnemyMonMoves
	ld c, NUM_MOVES

; Give a score of 0 to a blank move
.loop2
	ld a, [de]
	and a
	jr nz, .skip_load
	ld [hl], a

; Disregard the move if its score is not 1
.skip_load
	ld a, [hl]
	dec a
	jr z, .keep
	xor a
	ld [hli], a
	jr .after_toss

.keep
	ld a, [de]
	ld [hli], a
.after_toss
	inc de
	dec c
	jr nz, .loop2

; Randomly choose one of the moves with a score of 1
.ChooseMove:
	ld hl, Buffer1
	call Random
	and 3
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	and a
	jr z, .ChooseMove

	ld [CurEnemyMove], a
	ld a, c
	ld [CurEnemyMoveNum], a
	ret
; 441af


AIScoringPointers: ; 441af
	dw AI_Basic
	dw AI_Setup
	dw AI_Types
	dw AI_Offensive
	dw AI_Smart
	dw AI_Opportunist
	dw AI_Aggressive
	dw AI_Cautious
	dw AI_Status
	dw AI_Risky
	dw AI_None
	dw AI_None
	dw AI_None
	dw AI_None
	dw AI_None
	dw AI_None
; 441cf
