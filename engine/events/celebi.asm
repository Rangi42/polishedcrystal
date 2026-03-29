GalarianArticunoEvent:
	call DelayFrame
	ld a, [wStateFlags]
	push af
	xor a
	ld [wStateFlags], a

	ld a, PAL_OW_PURPLE
	farcall CopySpritePalToOBPal7

	call ClearSpriteAnims
	ld hl, ArticunoGalarianIcon
	ld de, vTiles0 tile $84
	lb bc, BANK(ArticunoGalarianIcon), 4 * 2
	call DecompressRequest2bpp

	ld hl, ArticunoGalarianIcon
	ld de, vTiles0 tile $8c
	lb bc, BANK(ArticunoGalarianIcon), 4 * 2
	call DecompressRequest2bpp
	jr DoCelebiEvent

GalarianMoltresEvent:
	call DelayFrame
	ld a, [wStateFlags]
	push af
	xor a
	ld [wStateFlags], a

	ld a, PAL_OW_RED
	farcall CopySpritePalToOBPal7

	call ClearSpriteAnims
	ld hl, MoltresGalarianIcon
	ld de, vTiles0 tile $84
	lb bc, BANK(MoltresGalarianIcon), 4 * 2
	call DecompressRequest2bpp

	ld hl, MoltresGalarianIcon
	ld de, vTiles0 tile $8c
	lb bc, BANK(MoltresGalarianIcon), 4 * 2
	call DecompressRequest2bpp
	jr DoCelebiEvent

GalarianZapdosEvent:
	call DelayFrame
	ld a, [wStateFlags]
	push af
	xor a
	ld [wStateFlags], a

	ld a, PAL_OW_RED
	farcall CopySpritePalToOBPal7

	call ClearSpriteAnims
	ld hl, ZapdosGalarianIcon
	ld de, vTiles0 tile $84
	lb bc, BANK(ZapdosGalarianIcon), 4 * 2
	call DecompressRequest2bpp

	ld hl, ZapdosGalarianIcon
	ld de, vTiles0 tile $8c
	lb bc, BANK(ZapdosGalarianIcon), 4 * 2
	call DecompressRequest2bpp
	jr DoCelebiEvent

Special_CelebiShrineEvent:
	call DelayFrame
	ld a, [wStateFlags]
	push af
	xor a
	ld [wStateFlags], a

	ld a, PAL_OW_GREEN
	farcall CopySpritePalToOBPal7

	call ClearSpriteAnims
	ld hl, SpecialCelebiGFX
	ld de, vTiles0 tile $84
	lb bc, BANK(SpecialCelebiGFX), 4 * 4
	call DecompressRequest2bpp
; fallthrough
DoCelebiEvent:
	xor a
	ld [wJumptableIndex], a

	depixel 0, 10, 7, 0
	ld a, SPRITE_ANIM_INDEX_CELEBI
	call InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], $84
	ld hl, SPRITEANIMSTRUCT_ANIM_SEQ_ID
	add hl, bc
	ld [hl], SPRITE_ANIM_SEQ_CELEBI
	ld hl, SPRITEANIMSTRUCT_VAR4
	add hl, bc
	ld [hl], $80
	ld a, 160 ; frame count
	ld [wFrameCounter], a
	ld d, $0
.loop
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .done
	push bc
	call GetCelebiSpriteTile
	inc d
	push de

	ldh a, [hUsedOAMIndex]
	; a = (OAM_COUNT - 4) * OBJ_SIZE - a
	cpl
	add (OAM_COUNT - 4) * OBJ_SIZE + 1

	ld [wCurSpriteOAMAddr], a
	farcall DoNextFrameForAllSprites_OW
	call CelebiEvent_CountDown
	ld c, 2
	call DelayFrames
	pop de
	pop bc
	jr .loop

.done
	pop af
	ld [wStateFlags], a

	ld hl, wShadowOAM + 2
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
	ld hl, wShadowOAM + 4 * 4
	ld bc, 36 * 4
	xor a
	rst ByteFill

	ld a, BATTLETYPE_LEGENDARY
	ld [wBattleType], a

	ret

CelebiEvent_CountDown:
	ld hl, wFrameCounter
	ld a, [hl]
	and a
	jr z, .done
	dec [hl]
	ret

.done
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

SpecialCelebiGFX:
INCBIN "gfx/overworld/celebi.2bpp.lzp"

UpdateCelebiPosition:
	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld a, [hl]
	push af
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	cp 8 * 10 + 2
	jr nc, .FreezeCelebiPosition
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	inc [hl]
	ld hl, SPRITEANIMSTRUCT_VAR4
	add hl, bc
	ld a, [hl]
	ld d, a
	cp $3a + 1
	jr c, .skip
	sub $3
	ld [hl], a
.skip
	ld hl, SPRITEANIMSTRUCT_VAR3
	add hl, bc
	ld a, [hl]
	inc [hl]
	farcall Cosine
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
	dec [hl]
	dec [hl]
	jr .ReinitSpriteAnimFrame

.float_up
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	inc [hl]
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
	jmp ReinitSpriteAnimFrame

.left
	ld hl, SPRITEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld a, SPRITE_ANIM_FRAMESET_CELEBI_LEFT
	jmp ReinitSpriteAnimFrame

.FreezeCelebiPosition:
	pop af
	ld hl, SPRITEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld a, SPRITE_ANIM_FRAMESET_CELEBI_LEFT
	jmp ReinitSpriteAnimFrame

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
	ld d, $ff
	jr .done

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
.done
	pop bc
	pop hl
	ret
