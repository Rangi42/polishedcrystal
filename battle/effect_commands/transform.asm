BattleCommand_Transform: ; 371cd
; transform

	call ClearLastMove

	ld a, BATTLE_VARS_SUBSTATUS2_OPP
	call GetBattleVarAddr
	bit SUBSTATUS_TRANSFORMED, [hl]
	jp nz, BattleEffect_ButItFailed

	ld hl, BattleMonSpecies
	ld de, BattleMonItem
	ld a, [hBattleTurn]
	and a
	jr nz, .got_mon_item
	ld hl, EnemyMonSpecies
	ld de, EnemyMonItem
.got_mon_item
	ld a, [hl]
	cp MEWTWO
	jr nz, .not_armored_mewtwo
	ld a, [de]
	cp ARMOR_SUIT
	jp z, BattleEffect_ButItFailed
.not_armored_mewtwo

	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp INFILTRATOR
	jr z, .bypass_sub
	ld a, BATTLE_VARS_SUBSTATUS4_OPP
	call GetBattleVarAddr
	bit SUBSTATUS_SUBSTITUTE, [hl]
	jp nz, BattleEffect_ButItFailed
.bypass_sub
	call CheckHiddenOpponent
	jp nz, BattleEffect_ButItFailed

	xor a
	ld [wNumHits], a
	ld [FXAnimIDHi], a
	ld a, $1
	ld [wKickCounter], a
	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVarAddr
	bit SUBSTATUS_SUBSTITUTE, [hl]
	push af
	jr z, .mimic_substitute
	call CheckUserIsCharging
	jr nz, .mimic_substitute
	ld a, SUBSTITUTE
	call LoadAnim
.mimic_substitute
	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVarAddr
	set SUBSTATUS_TRANSFORMED, [hl]
	call ResetActorDisable
	ld hl, BattleMonSpecies
	ld de, EnemyMonSpecies
	ld a, [hBattleTurn]
	and a
	jr nz, .got_mon_species
	ld hl, EnemyMonSpecies
	ld de, BattleMonSpecies
	xor a
	ld [CurMoveNum], a
.got_mon_species
	push hl
	ld a, [hli]
	ld [de], a
	inc hl
	inc de
	inc de
	ld bc, NUM_MOVES
	call CopyBytes

	; copy DVs and personality
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
; move pointer to stats
	ld bc, BattleMonStats - BattleMonPP
	add hl, bc
	push hl
	ld h, d
	ld l, e
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld bc, BattleMonStructEnd - BattleMonStats
	call CopyBytes
; init the power points
	ld bc, BattleMonMoves - BattleMonStructEnd
	add hl, bc
	push de
	ld d, h
	ld e, l
	pop hl
	ld bc, BattleMonPP - BattleMonStructEnd
	add hl, bc
	ld b, NUM_MOVES
.pp_loop
	ld a, [de]
	inc de
	and a
	jr z, .done_move
	cp SKETCH
	ld a, 1
	jr z, .done_move
	ld a, 5
.done_move
	ld [hli], a
	dec b
	jr nz, .pp_loop
	pop hl
	ld a, [hl]
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	ld hl, EnemyStatLevels
	ld de, PlayerStatLevels
	ld bc, 8
	call BattleSideCopy
	call _CheckBattleEffects
	jr c, .mimic_anims
	ld a, [hBattleTurn]
	and a
	ld a, [wPlayerMinimized]
	jr z, .got_byte
	ld a, [wEnemyMinimized]
.got_byte
	and a
	jr nz, .mimic_anims
	; Animation is done "raw" to allow Imposter
	; to use the correct animation
	ld de, TRANSFORM
	call FarPlayBattleAnimation
	jr .after_anim

.mimic_anims
	call BattleCommand_MoveDelay
	call BattleCommand_RaiseSubNoAnim
.after_anim
	xor a
	ld [wNumHits], a
	ld [FXAnimIDHi], a
	ld a, $2
	ld [wKickCounter], a
	pop af
	ld a, SUBSTITUTE
	call nz, LoadAnim
	ld hl, TransformedText
	call StdBattleTextBox

	; Update revealed moves if player transformed: the AI knows what its own moves are...
	ld a, [hBattleTurn]
	and a
	jr nz, .move_reveal_done
	ld hl, BattleMonMoves
	ld de, PlayerUsedMoves
	ld bc, NUM_MOVES
	call CopyBytes

.move_reveal_done
	; Copy ability
	ld a, [hBattleTurn]
	and a
	jr nz, .copy_player_ability
	ld a, [EnemyAbility]
	ld [PlayerAbility], a
	jr .done_ability_copy
.copy_player_ability
	ld a, [PlayerAbility]
	ld [EnemyAbility], a
.done_ability_copy
	ld a, BATTLE_VARS_ABILITY_OPP
	call GetBattleVar
	cp IMPOSTER
	ret z ; avoid infinite loop
	farjp RunActivationAbilitiesInner

; 372c6
