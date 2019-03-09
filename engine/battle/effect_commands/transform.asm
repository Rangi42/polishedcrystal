BattleCommand_transform:
	call ClearLastMove

	ld a, BATTLE_VARS_SUBSTATUS2_OPP
	call GetBattleVarAddr
	bit SUBSTATUS_TRANSFORMED, [hl]
	jp nz, BattleEffect_ButItFailed

	ld a, [hBattleTurn]
	and a
	ld hl, wEnemyMonSpecies
	ld de, wEnemyMonItem
	jr z, .got_mon_item
	ld hl, wBattleMonSpecies
	ld de, wBattleMonItem
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
	ld [wFXAnimIDHi], a
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
	ld hl, wBattleMonSpecies
	ld de, wEnemyMonSpecies
	ld a, [hBattleTurn]
	and a
	jr nz, .got_mon_species
	ld hl, wEnemyMonSpecies
	ld de, wBattleMonSpecies
	xor a
	ld [wCurMoveNum], a
.got_mon_species
	push hl
	ld a, [hli]
	ld [de], a
	inc hl
	inc de
	inc de
	ld bc, NUM_MOVES
	rst CopyBytes

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
	ld bc, wBattleMonStats - wBattleMonPP
	add hl, bc
	push hl
	ld h, d
	ld l, e
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld bc, wBattleMonStructEnd - wBattleMonStats
	rst CopyBytes
; init the power points
	ld bc, wBattleMonMoves - wBattleMonStructEnd
	add hl, bc
	push de
	ld d, h
	ld e, l
	pop hl
	ld bc, wBattleMonPP - wBattleMonStructEnd
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
	ld hl, wEnemyStatLevels
	ld de, wPlayerStatLevels
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
	call BattleCommand_movedelay
	call BattleCommand_raisesubnoanim
.after_anim
	xor a
	ld [wNumHits], a
	ld [wFXAnimIDHi], a
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
	ld hl, wBattleMonMoves
	ld de, wPlayerUsedMoves
	ld bc, NUM_MOVES
	rst CopyBytes

.move_reveal_done
	; Copy ability
	ld a, [hBattleTurn]
	and a
	jr nz, .copy_player_ability
	ld a, [wEnemyAbility]
	ld [wPlayerAbility], a
	jr .done_ability_copy
.copy_player_ability
	ld a, [wPlayerAbility]
	ld [wEnemyAbility], a
.done_ability_copy
	ld a, BATTLE_VARS_ABILITY_OPP
	call GetBattleVar
	cp IMPOSTER
	ret z ; avoid infinite loop
	farjp RunActivationAbilitiesInner
