DeinitBattleAnimation:
	ld hl, BATTLEANIMSTRUCT_INDEX
	add hl, bc
	ld [hl], $0
	ret

QueueBattleAnimation:
	ld hl, wActiveAnimObjects
	ld e, NUM_ANIM_OBJECTS
.loop
	ld a, [hl]
	and a
	jr z, .done
	ld bc, BATTLEANIMSTRUCT_LENGTH
	add hl, bc
	dec e
	jr nz, .loop
	scf
	ret

.done
	ld c, l
	ld b, h
	ld hl, wLastAnimObjectIndex
	inc [hl]

	ld hl, wBattleAnimTemp0
	ld e, [hl]
	; d was set to 0 or 1 previously
	ld hl, BattleAnimObjects
rept 6
	add hl, de
endr
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_INDEX
	add hl, bc
	ld a, [wLastAnimObjectIndex]
	ld [hli], a ; Index
	ld a, [de]
	inc de
	ld [hli], a ; 01
	ld a, [de]
	inc de
	ld [hli], a ; 02
	ld a, [de]
	inc de
	ld [hli], a ; Frameset ID
	ld a, [de]
	inc de
	ld [hli], a ; Function
	ld a, [de]
	inc de
	ld [hli], a ; 05
	ld a, [de]
	call GetBattleAnimTileOffset
	ld [hli], a ; Tile ID
	ld a, [wBattleAnimTemp1]
	ld [hli], a ; X Coord
	ld a, [wBattleAnimTemp2]
	ld [hli], a ; Y Coord
	xor a
	ld [hli], a ; X Offset
	ld [hli], a ; Y Offset
	ld a, [wBattleAnimTemp3]
	ld [hli], a ; 0b
	xor a
	ld [hli], a ; 0c
	dec a
	ld [hli], a ; 0d
	xor a
	ld [hli], a ; 0e
	ld [hli], a ; 0f
	ld [hl], a  ; 10
	ret

BattleAnimOAMUpdate:
	call InitBattleAnimBuffer
	call GetBattleAnimFrame
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
	ld h, [hl]
	ld l, a
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
	ld b, a
	ld a, [hl]
	xor b
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
	call DeinitBattleAnimation

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
	ld a, [hl]
	cp FIRST_DYNAMIC_FRAMESET
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
	and %10000000
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
	add (-10 * 8) + 4 + 1 ; a = (-10 * 8) + 4 - a
	ld [wBattleAnimTempXCoord], a
	ld a, [hli]
	ld d, a
	ld a, [wBattleAnimTemp1]
	cp $ff
	jr nz, .check_psystrike_freshsnack
	ld a, 5 * 8
	add d
	jr .done

.check_psystrike_freshsnack
	sub d
	push af
	ld a, [wFXAnimIDHi]
	or a
	jr nz, .no_sub
	ld a, [wFXAnimIDLo]
	cp PSYSTRIKE
	jr z, .sub_8
	cp FRESH_SNACK
	jr nz, .no_sub
.sub_8
	pop af
	sub 1 * 8
	jr .done
.no_sub
	pop af
.done
	ld [wBattleAnimTempYCoord], a
	ld a, [hli]
	cpl
	inc a
	ld [wBattleAnimTempXOffset], a
	ret

GetBattleAnimTileOffset:
	push hl
	push bc
	ld hl, wBattleAnimTileDict
	ld b, a
	ld c, 10 / 2
.loop
	ld a, [hli]
	cp b
	jr z, .load
	inc hl
	dec c
	jr nz, .loop
	xor a
	jr .done

.load
	ld a, [hl]
.done
	pop bc
	pop hl
	ret

_ExecuteBGEffects:
	farjp ExecuteBGEffects

_QueueBGEffect:
	farjp QueueBGEffect

