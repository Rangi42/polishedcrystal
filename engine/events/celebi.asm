Special_CelebiShrineEvent:
	call DelayFrame
	ld a, [wVramState]
	push af
	xor a
	ld [wVramState], a

	farcall ClearSpriteAnims
	ld de, SpecialCelebiLeafGFX
	ld hl, vTiles1
	lb bc, BANK(SpecialCelebiLeafGFX), 4
	call Request2bpp
	ld de, SpecialCelebiGFX
	ld hl, vTiles0 tile $84
	lb bc, BANK(SpecialCelebiGFX), $10
	call Request2bpp
	xor a
	ld [wJumptableIndex], a

	depixel 0, 10, 7, 0
	ld a, SPRITE_ANIM_INDEX_CELEBI
	call _InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], $84
	ld hl, SPRITEANIMSTRUCT_ANIM_SEQ_ID
	add hl, bc
	ld [hl], SPRITE_ANIM_SEQ_CELEBI
	ld hl, SPRITEANIMSTRUCT_0F
	add hl, bc
	ld [hl], $80
	ld a, 160 ; frame count
	ld [wcf64], a
	ld d, $0
.loop
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .done
	push bc
	call GetCelebiSpriteTile
	inc d
	push de
	ld a, $90
	ld [wCurrSpriteOAMAddr], a
	farcall DoNextFrameForAllSprites
	call CelebiEvent_CountDown
	ld c, 2
	call DelayFrames
	pop de
	pop bc
	jr .loop

.done
	pop af
	ld [wVramState], a

	ld hl, wVirtualOAM + 2
	xor a
	ld c, $4
.OAMloop:
	ld [hli], a
	inc hl
	inc hl
	inc hl
	inc a
	dec c
	jr nz, .OAMloop
	ld hl, wVirtualOAM + 4 * 4
	ld bc, 36 * 4
	xor a
	call ByteFill

	ld a, BATTLETYPE_LEGENDARY
	ld [wBattleType], a

	ret

CelebiEvent_CountDown:
	ld hl, wcf64
	ld a, [hl]
	and a
	jr z, .done
	dec [hl]
	ret

.done
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

SpecialCelebiLeafGFX:
INCBIN "gfx/overworld/celebi/leaf.2bpp"

SpecialCelebiGFX:
INCBIN "gfx/overworld/celebi/1.2bpp"
INCBIN "gfx/overworld/celebi/2.2bpp"
INCBIN "gfx/overworld/celebi/3.2bpp"
INCBIN "gfx/overworld/celebi/4.2bpp"

UpdateCelebiPosition:
	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld a, [hl]
	push af
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	cp 8 * 10 + 2
	jp nc, .FreezeCelebiPosition
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	inc [hl]
	ld hl, SPRITEANIMSTRUCT_0F
	add hl, bc
	ld a, [hl]
	ld d, a
	cp $3a
	jr c, .skip
	jr z, .skip
	sub $3
	ld [hl], a
.skip
	ld hl, SPRITEANIMSTRUCT_0E
	add hl, bc
	ld a, [hl]
	inc [hl]
	call Cosine
	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld d, a
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	add [hl]
	cp 8 * 11 + 4
	jr nc, .ShiftY
	cp 8 *  8 + 4
	jr nc, .ReinitSpriteAnimFrame
.ShiftY:
	pop af
	push af
	cp d
	jr nc, .moving_left
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	add [hl]
	cp 8 * 10
	jr c, .float_up
	jr .float_down

.moving_left
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	add [hl]
	cp 8 * 10
	jr nc, .float_up
.float_down
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	sub $2
	ld [hl], a
	jr .ReinitSpriteAnimFrame

.float_up
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	add $1
	ld [hl], a
.ReinitSpriteAnimFrame:
	pop af
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	add [hl]
	cp 8 * 10
	jr c, .left
	cp -(8 * 3 + 2)
	jr nc, .left
	ld hl, SPRITEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld a, SPRITE_ANIM_FRAMESET_CELEBI_RIGHT
	jp ReinitSpriteAnimFrame

.left
	ld hl, SPRITEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld a, SPRITE_ANIM_FRAMESET_CELEBI_LEFT
	jp ReinitSpriteAnimFrame

.FreezeCelebiPosition:
	pop af
	ld hl, SPRITEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld a, SPRITE_ANIM_FRAMESET_CELEBI_LEFT
	jp ReinitSpriteAnimFrame

GetCelebiSpriteTile:
	push hl
	push bc
	ld a, d
	and a
	jr z, .Frame1
	cp 3
	jr z, .Frame2
	cp 6
	jr z, .Frame3
	cp 9
	jr z, .Frame4
	cp 12
	jr c, .done
	jr .restart

.Frame1:
	ld a, $84
	jr .load_tile

.Frame2:
	ld a, $88
	jr .load_tile

.Frame3:
	ld a, $8c
	jr .load_tile

.Frame4:
	ld a, $90

.load_tile
	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], a
	jr .done

.restart
	ld d, $ff

.done
	pop de
	pop bc
	pop hl
	ret

CheckCaughtCelebi:
	ld a, [wBattleResult]
	bit 6, a
	jr z, .false
	ld a, $1
	ldh [hScriptVar], a
	ret

.false
	xor a
	ldh [hScriptVar], a
	ret

