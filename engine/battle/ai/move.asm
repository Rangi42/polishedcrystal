AIChooseMove:
; Wrapper around AI move choosing. Let the AI switch out if its desired move
; differs from one it is locked into with Choice or Encore.
	; Linking is handled elsewhere
	ld a, [wLinkMode]
	and a
	ret nz

	ld a, [wEnemyEncoreCount]
	push af
	xor a
	ld [wEnemyEncoreCount], a

	; First, check if the AI has any usable moves. This prevents switches
	; caused by the AI running out of usable moves alltogether.
	call SetEnemyTurn
	farcall CheckUsableMoves
	jr z, .not_struggling

	; Just bypass the checks alltogether
	pop af
	ld [wEnemyEncoreCount], a
	ret

.not_struggling
	call _AIChooseMove
	pop af
	ld [wEnemyEncoreCount], a

	; Check if the chosen move is usable after restoring Choice/Encore
	ld a, [wCurEnemyMoveNum]
	farcall CheckUsableMove
	ret z

	; Move is unusable. Fix the move selection to a valid move, but prefer
	; to switch if we can, assuming we have usable moves at all.
	farcall CheckUsableMoves
	call z, _AIChooseMove

	; Strongly encourage switch-out by pretending we have Perish 1.
	ld a, [wEnemyPerishCount]
	push af
	ld a, 1
	ld [wEnemyPerishCount], a
	farcall AI_MaybeSwitch
	pop af
	ld [wEnemyPerishCount], a
	ret

_AIChooseMove:
; Score each move (lower is better) according to how much we want to use them.
	; At times, we call the battle engine directly to check stuff. So set turn.
	call SetEnemyTurn

	; Set a baseline score of 80 on all moves. Replace with 20 for usable moves.
	ld hl, wAIMoveScore
	ld a, 80
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a

	; Zerofill moves
	ld hl, wAIMoves + 3
	xor a
	ld [hld], a
	ld [hld], a
	ld [hld], a
	ld [hl], a

	; Copy our moves to a seperate AI moves struct, excluding unusable moves.
	; ld hl, wAIMoves (not needed, direct result of above)
	ld de, wEnemyMonMoves
	ld bc, wAIMoveScore - 1 - wAIMoves ; for setting baseline score to 20
	xor a

.loop_usable_moves
	push af
	farcall CheckUsableMove
	ld a, [de]
	inc de
	jr nz, .next_usable_move
	ld [hli], a
	push hl
	add hl, bc
	ld [hl], 20
	pop hl
.next_usable_move
	pop af
	inc a
	cp NUM_MOVES
	jr nz, .loop_usable_moves
	; Finished initializing AI move table

	; Wildmons choose moves at random
	ld a, [wBattleMode]
	dec a
	jmp z, .DecrementScores

; Apply AI scoring layers depending on the trainer class.
.ApplyLayers:
	ld hl, TrainerClassAttributes + TRNATTR_AI_MOVE_WEIGHTS

	; Battle Tower sets the AI flags differently.
	ld a, [wInBattleTowerBattle]
	and a
	jr z, .not_battle_tower

	; Battle Tower always use max AI strength.
	farcall BT_InRentalMode
	ld a, 16
	jr nz, .got_bt_level

	; Early Battle Factory runs are easier.
	farcall BT_GetCurStreakAddr
	ld a, [hli]
	and a
	ld a, 16
	jr nz, .got_bt_level
	ld a, [hl]
	add 7
	rra
.got_bt_level
	call .AddBattleTowerFlags
	jr .battle_tower_done

.not_battle_tower
	ld a, [wTrainerClass]
	dec a
	ld bc, NUM_TRAINER_ATTRIBUTES
	rst AddNTimes

	ld de, wAIFlags
	ld bc, 2
	ld a, BANK(TrainerClassAttributes)
	call FarCopyBytes

	; Add badge flags
	call .AddBadgeFlags

.battle_tower_done
	; Aggressive overrides type matchups
	ld hl, wAIFlags
	lb bc, CHECK_FLAG, AI_AGGRESSIVE_F
	predef FlagPredef
	jr z, .not_aggressive
	lb bc, RESET_FLAG, AI_TYPES_F
	predef FlagPredef

.not_aggressive
	lb bc, CHECK_FLAG, 0
	ld hl, wAIFlags
	push bc
	push hl

.CheckLayer:
	pop hl
	pop bc

	ld a, c
	cp 16 ; up to 16 scoring layers
if DEF(DEBUG)
	jr z, .DebugAndDecrement
endc
	jr z, .DecrementScores

	push bc
	predef FlagPredef
	ld d, c
	pop bc

	inc c
	push bc
	push hl

	ld a, d
	and a
	jr z, .CheckLayer

.apply_layer
if DEF(DEBUG)
	call AIDebug
endc

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

.AddBadgeFlags:
	ld hl, wBadges
	ld b, wBadgesEnd - wBadges
	call CountSetBits
.AddBattleTowerFlags:
	ld hl, .BadgeAILayers
.badge_loop
	ld c, [hl]
	cp c
	ret c
	inc hl
	push hl
	push af
	ld c, [hl]
	ld hl, wAIFlags
	ld b, SET_FLAG
	predef FlagPredef
	pop af
	pop hl
	inc hl
	jr .badge_loop

.BadgeAILayers:
	db 0, AI_BASIC_F ; Avoid redundant actions; paralyzing a paralyzed foe/etc.
	db 2, AI_TYPES_F ; We've mastered type matchups. Hop would be proud.
	db 4, AI_STATUS_F ; Hypnosis vs Insomnia, etc.
	db 6, AI_SETUP_F ; Use stat change moves intelligently.
	db 8, AI_AGGRESSIVE_F ; Use most damaging move.
	db 8, AI_RISKY_F ; Use moves that KO the target.
	db 16, AI_SMART_F ; "Advanced" AI
	db -1

; Decrement the scores of all moves one by one until one reaches 0.
if DEF(DEBUG)
.DebugAndDecrement:
	call AIDebug
endc
.DecrementScores:
	ld hl, wAIMoveScore
	ld de, wAIMoves
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

	ld hl, wAIMoveScore
	ld de, wAIMoves
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
	ld hl, wAIMoveScore
	call Random
	and 3
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	and a
	jr z, .ChooseMove

	ld [wCurEnemyMove], a

	; Figure out which move number this is in the actual move struct
	ld c, -1
	ld b, a
	ld hl, wEnemyMonMoves
.loop_move_num
	inc c
	ld a, [hli]
	cp b
	jr nz, .loop_move_num
	ld a, c
	ld [wCurEnemyMoveNum], a
	ret

AIScoringPointers: ; these are all farcalled in BANK(AIScoring)
	dw AI_Basic ; far-ok
	dw AI_Setup ; far-ok
	dw AI_Types ; far-ok
	dw AI_Offensive ; far-ok
	dw AI_Smart ; far-ok
	dw AI_Opportunist ; far-ok
	dw AI_Aggressive ; far-ok
	dw AI_Cautious ; far-ok
	dw AI_Status ; far-ok
	dw AI_Risky ; far-ok
	dw DoNothing ; far-ok
	dw DoNothing ; far-ok
	dw DoNothing ; far-ok
	dw DoNothing ; far-ok
	dw DoNothing ; far-ok
	dw DoNothing ; far-ok

if DEF(DEBUG)
AIDebug:
; Prints out an AI score table and delays
	push hl
	push de
	push bc

	; Clear the text display
	hlcoord 1, 13
	push hl
	ld c, 4
	ld a, " "
.clear_loop
	ld b, 18
.clear_row
	ld [hli], a
	dec b
	jr nz, .clear_row
	inc hl
	inc hl
	dec c
	jr nz, .clear_loop

	; Print move names
	pop hl
	ld de, wAIMoves
	ld c, 4
.move_loop
	push de
	push bc
	ld [hl], "-"
	ld a, [de]
	inc de
	and a
	jr z, .get_score
	ld [wNamedObjectIndex], a
	push hl
	call GetMoveName
	pop hl
	push hl
	ld de, wStringBuffer1
	rst PlaceString
	pop hl
.get_score
	ld bc, MOVE_NAME_LENGTH
	add hl, bc
	pop bc
	push bc
	ld de, wAIMoveScore - 1
	ld a, 5
.score_target
	inc de
	dec a
	cp c
	jr nz, .score_target

	lb bc, 1, 3
	push hl
	call PrintNum
	pop hl
	ld bc, SCREEN_WIDTH - MOVE_NAME_LENGTH
	add hl, bc
	pop bc
	pop de
	inc de
	dec c
	jr nz, .move_loop

	pop bc
	push bc
	hlcoord 18, 13
	ld a, c
	cp 10
	jr c, .numeric
	add "A" - "0" - 10
.numeric
	add "0"
	ld [hl], a

	call ApplyTilemap
	ld c, 30
	call DelayFrames
	pop bc
	pop de
	pop hl
	ret
endc
