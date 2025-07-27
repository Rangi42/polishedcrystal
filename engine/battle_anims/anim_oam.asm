
BattleAnimOAMUpdate:
	call InitBattleAnimBuffer
	farcall GetBattleAnimFrame
	ld a, h
	cp HIGH(battleoamwait_command)
	jmp z, .done
	cp HIGH(battleoamdelete_command)
	jmp z, .delete

	push hl
	ld hl, wBattleAnimTempOAMFlags
	ld a, [wBattleAnimTemp7]
	xor [hl]
	and $e0
	ld [hl], a
	call .SetDynamicTileData
	pop hl

	push bc
	call GetBattleAnimOAMPointer
	ld a, [wBattleAnimTempTileID]
	add [hl]
	ld [wBattleAnimTempTileID], a
	inc hl
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld h, [hl]
	ld l, b
	ld a, [wBattleAnimOAMPointerLo]
	ld e, a
	ld d, HIGH(wShadowOAM)
.loop
	ld a, [wBattleAnimTempYCoord]
	ld b, a
	ld a, [wBattleAnimTempYOffset]
	add b
	ld b, a
	push hl
	ld a, [hl]
	ld hl, wBattleAnimTempOAMFlags
	bit OAM_Y_FLIP, [hl]
	jr z, .no_yflip
	add $8
	cpl
	inc a

.no_yflip
	pop hl
	add b
	ld [de], a
	inc hl
	inc de
	ld a, [wBattleAnimTempXCoord]
	ld b, a
	ld a, [wBattleAnimTempXOffset]
	add b
	ld b, a
	push hl
	ld a, [hl]
	ld hl, wBattleAnimTempOAMFlags
	bit OAM_X_FLIP, [hl]
	jr z, .no_xflip
	add $8
	cpl
	inc a

.no_xflip
	pop hl
	add b
	ld [de], a
	inc hl
	inc de
	ld a, [wBattleAnimTempTileID]
	add BATTLEANIM_BASE_TILE
	add [hl]
	ld [de], a
	inc hl
	inc de
	ld a, [wBattleAnimTempOAMFlags]
	xor [hl]
	and $e0
	ld b, a
	ld a, [hli]
	and $10
	or b
	ld b, a
	ld a, [wBattleAnimTempPalette]
	and $f
	or b
	ld [de], a
	inc de
	ld a, e
	ld [wBattleAnimOAMPointerLo], a
	cp $a0
	jr nc, .exit_set_carry
	dec c
	jr nz, .loop
	pop bc
	jr .done

.delete
	farcall DeinitBattleAnimation

.done
	and a
	ret

.exit_set_carry
	pop bc
	scf
	ret

.SetDynamicTileData:
	; If frameset ID is dynamic, var3 may adjust XY flip.
	ld hl, BATTLEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	push bc
	ld a, [hli]
	ld b, [hl]
	ld c, a
	cpbc FIRST_DYNAMIC_FRAMESET
	pop bc
	ret c

	; Graphics are ordered in E S NE order.
	ld hl, BATTLEANIMSTRUCT_VAR3
	add hl, bc
	ld a, [hl]

	; Perhaps set priority
	bit 3, a
	push af
	and $7
	add a
	add LOW(.tile_data)
	ld l, a
	adc HIGH(.tile_data)
	sub l
	ld h, a
	pop af

	; First, set XY flip.
	ld a, [hli]
	jr z, .no_priority
	or PRIORITY
.no_priority
	push hl
	ld hl, wBattleAnimTempOAMFlags
	xor [hl]
	ld [hl], a
	pop hl
	ld a, [hl]

	; Then, adjust tile ID
	ld hl, wBattleAnimTempTileID
	add [hl]
	ld [hl], a
	ret

.tile_data
	db X_FLIP, $00 ; W
	db X_FLIP, $08 ; NW
	db Y_FLIP, $04 ; N
	db 0, $08 ; NE
	db Y_FLIP, $00 ; E
	db Y_FLIP, $08 ; SE
	db X_FLIP, $04 ; S
	db X_FLIP | Y_FLIP, $08 ; SW

InitBattleAnimBuffer:
	ld hl, BATTLEANIMSTRUCT_OAMFLAGS
	add hl, bc
	ld a, [hl]

	and PRIORITY
	ld [wBattleAnimTempOAMFlags], a
	xor a
	ld [wBattleAnimTemp7], a
	ld hl, BATTLEANIMSTRUCT_PALETTE
	add hl, bc
	ld a, [hl]
	ld [wBattleAnimTempPalette], a
	ld hl, BATTLEANIMSTRUCT_FIX_Y
	add hl, bc
	ld a, [hl]
	ld [wBattleAnimTemp1], a
	ld hl, BATTLEANIMSTRUCT_TILEID
	add hl, bc
	ld a, [hli]
	ld [wBattleAnimTempTileID], a
	ld a, [hli]
	ld [wBattleAnimTempXCoord], a
	ld a, [hli]
	ld [wBattleAnimTempYCoord], a
	ld a, [hli]
	ld [wBattleAnimTempXOffset], a
	ld a, [hli]
	ld [wBattleAnimTempYOffset], a

	ldh a, [hBattleTurn]
	and a
	ret z

	ld hl, BATTLEANIMSTRUCT_OAMFLAGS
	add hl, bc
	ld a, [hl]
	ld [wBattleAnimTempOAMFlags], a
	bit 0, [hl]
	ret z

	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hli]
	cpl
	add (-10 * TILE_WIDTH) + 4 + 1 ; a = (-10 * TILE_WIDTH) + 4 - a
	ld [wBattleAnimTempXCoord], a
	ld a, [hli]
	ld d, a
	ld a, [wBattleAnimTemp1]
	cp $ff
	jr nz, .vertical_flip
	ld a, 5 * TILE_WIDTH
	jr .done

.vertical_flip
	sub d
	push af
	push hl
	push bc
	ld hl, wFXAnimID
	ld a, [hli]
	ld c, a
	ld b, [hl]
	ld de, 2
	ld hl, .extra_offset_moves
	call IsInWordArray
	pop bc
	pop hl
	pop de
	sbc a
	and -(1 * TILE_WIDTH)
.done
	add d
	ld [wBattleAnimTempYCoord], a
	ld a, [hli]
	cpl
	inc a
	ld [wBattleAnimTempXOffset], a
	ret

.extra_offset_moves
	dw PSYSTRIKE
	dw FRESH_SNACK
	dw -1

GetBattleAnimOAMPointer:
	ld de, BattleAnimOAMData
	add hl, hl
	add hl, hl
	add hl, de
	ret
