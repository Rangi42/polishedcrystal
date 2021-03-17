PlaySpriteAnimationsAndDelayFrame:
	call PlaySpriteAnimations
	jp DelayFrame

PlaySpriteAnimations:
	push hl
	push de
	push bc
	push af

	ld a, LOW(wVirtualOAM)
	ld [wCurSpriteOAMAddr], a
	call DoNextFrameForAllSprites

	jp PopAFBCDEHL

DoNextFrameForAllSprites:
	ld hl, wSpriteAnimationStructs
	ld e, 10 ; There are 10 structs here.

.loop
	ld a, [hl]
	and a
	jr z, .next ; This struct is deinitialized.
	ld c, l
	ld b, h
	push hl
	push de
	call DoAnimFrame ; Uses a massive dw
	call UpdateAnimFrame
	pop de
	pop hl
	ret c

.next
	ld bc, $10
	add hl, bc
	dec e
	jr nz, .loop

	ld a, [wCurSpriteOAMAddr]
	ld l, a
	ld h, HIGH(wVirtualOAM)

.loop2 ; Clear (wVirtualOAM + [wCurSpriteOAMAddr] --> wVirtualOAMEnd)
	ld a, l
	cp LOW(wVirtualOAMEnd)
	ret nc
	xor a
	ld [hli], a
	jr .loop2

DoNextFrameForFirst16Sprites:
	ld hl, wSpriteAnimationStructs
	ld e, 10

.loop
	ld a, [hl]
	and a
	jr z, .next
	ld c, l
	ld b, h
	push hl
	push de
	call DoAnimFrame ; Uses a massive dw
	call UpdateAnimFrame
	pop de
	pop hl
	ret c

.next
	ld bc, $10
	add hl, bc
	dec e
	jr nz, .loop

	ld a, [wCurSpriteOAMAddr]
	ld l, a
	ld h, HIGH(wVirtualOAM + 16 * 4)

.loop2 ; Clear (wVirtualOAM + [wCurSpriteOAMAddr] --> wVirtualOAM + 16 * 4)
	ld a, l
	cp LOW(wVirtualOAM + 16 * 4)
	ret nc
	xor a
	ld [hli], a
	jr .loop2

InitSpriteAnimStruct::
; Initialize animation a at pixel x=e, y=d
; Find if there's any room in the wSpriteAnimationStructs array, which is 10x16
	push de
	push af
	ld hl, wSpriteAnimationStructs
	ld bc, $10
	ld e, 10
.loop
	ld a, [hl]
	and a
	jr z, .found
	add hl, bc
	dec e
	jr nz, .loop
; We've reached the end.  There is no more room here.
; Return carry.
	pop af
	pop de
	scf
	ret

.found
; Back up the structure address to bc.
	ld c, l
	ld b, h
; Value [wSpriteAnimCount] is initially set to -1. Set it to
; the number of objects loaded into this array.
	ld hl, wSpriteAnimCount
	inc [hl]
	ld a, [hl]
	and a
	jr nz, .initialized
	inc [hl]

.initialized
; Get row a of SpriteAnimSeqData, copy the pointer into de
	pop af
	ld e, a
	ld d, 0
	ld hl, SpriteAnimSeqData
	add hl, de
	add hl, de
	add hl, de
	ld e, l
	ld d, h
; Set hl to the first field (field 0) in the current structure.
	ld hl, SPRITEANIMSTRUCT_INDEX
	add hl, bc
; Load the index.
	ld a, [wSpriteAnimCount]
	ld [hli], a
; Copy the table entry to the next two fields.
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hli], a
	inc de
; Look up the third field from the table in the wSpriteAnimDict array (10x2).
; Take the value and load it in
	ld a, [de]
	call GetSpriteAnimVTile
	ld [hli], a
	pop de
;	ld hl, SPRITEANIMSTRUCT_XCOORD
;	add hl, bc
; Load the original value of de into here.
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
; load 0 into the next four fields
	xor a
	ld [hli], a
	ld [hli], a
	xor a
	ld [hli], a
	ld [hli], a
; load -1 into the next field
	dec a
	ld [hli], a
; load 0 into the last five fields
	xor a
rept 4
	ld [hli], a
endr
	ld [hl], a
; back up the address of the first field to wSpriteAnimAddrBackup
	ld a, c
	ld [wSpriteAnimAddrBackup], a
	ld a, b
	ld [wSpriteAnimAddrBackup + 1], a
	ret

DeinitializeSprite:
; Clear the index field of the struct in bc.
	ld hl, SPRITEANIMSTRUCT_INDEX
	add hl, bc
	ld [hl], $0
	ret

DeinitializeAllSprites:
; Clear the index field of every struct in the wSpriteAnimationStructs array.
	ld hl, wSpriteAnimationStructs
	ld bc, $10
	ld e, 10
	xor a
.loop
	ld [hl], a
	add hl, bc
	dec e
	jr nz, .loop
	ret

UpdateAnimFrame:
	call InitSpriteAnimBuffer ; init WRAM
	call GetSpriteAnimFrame ; read from a memory array
	cp -3
	jr z, .done
	cp -4
	jr z, .delete
	call GetFrameOAMPointer
	; add byte to [wCurAnimVTile]
	ld a, [wCurAnimVTile]
	add [hl]
	ld [wCurAnimVTile], a
	inc hl
	; load pointer into hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	push bc
	ld a, [wCurSpriteOAMAddr]
	ld e, a
	ld d, HIGH(wVirtualOAM)
	ld a, [hli]
	ld c, a ; number of objects
.loop
	; first byte: y (px)
	; [de] = [wCurAnimYCoord] + [wCurAnimYOffset] + [wGlobalAnimYOffset] + AddOrSubtractY([hl])
	ld a, [wCurAnimYCoord]
	ld b, a
	ld a, [wCurAnimYOffset]
	add b
	ld b, a
	ld a, [wGlobalAnimYOffset]
	add b
	ld b, a
	call AddOrSubtractY
	add b
	ld [de], a
	inc hl
	inc de
	; second byte: x (px)
	; [de] = [wCurAnimXCoord] + [wCurAnimXOffset] + [wGlobalAnimXOffset] + AddOrSubtractX([hl])
	ld a, [wCurAnimXCoord]
	ld b, a
	ld a, [wCurAnimXOffset]
	add b
	ld b, a
	ld a, [wGlobalAnimXOffset]
	add b
	ld b, a
	call AddOrSubtractX
	add b
	ld [de], a
	inc hl
	inc de
	; third byte: vtile
	; [de] = [wCurAnimVTile] + [hl]
	ld a, [wCurAnimVTile]
	add [hl]
	ld [de], a
	inc hl
	inc de
	; fourth byte: attributes
	; [de] = GetSpriteOAMAttr([hl])
	ld a, [hl]
	cp -1 ; this lets the party menu icons keep their dynamic color attribute
	jr z, .skipOAMAttributes
	call GetSpriteOAMAttr
	ld [de], a
.skipOAMAttributes
	inc hl
	inc de
	ld a, e
	ld [wCurSpriteOAMAddr], a
	cp LOW(wVirtualOAMEnd)
	jr nc, .reached_the_end
	dec c
	jr nz, .loop
	pop bc
	jr .done

.delete
	call DeinitializeSprite
.done
	and a
	ret

.reached_the_end
	pop bc
	scf
	ret

AddOrSubtractY:
	push hl
	ld a, [hl]
	ld hl, wCurSpriteAddSubFlags
	bit 6, [hl]
	jr _AddOrSubtract

AddOrSubtractX:
	push hl
	ld a, [hl]
	ld hl, wCurSpriteAddSubFlags
	bit 5, [hl]
_AddOrSubtract:
	jr z, .ok
	; a = -8 - a
	cpl
	add -8 + 1

.ok
	pop hl
	ret

GetSpriteOAMAttr:
	ld a, [wCurSpriteAddSubFlags]
	ld b, a
	ld a, [hl]
	xor b
	and $e0
	ld b, a
	ld a, [hl]
	and $1f
	or b
	ret

InitSpriteAnimBuffer:
	xor a
	ld [wCurSpriteAddSubFlags], a
	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld a, [hli]
	ld [wCurAnimVTile], a
	ld a, [hli]
	ld [wCurAnimXCoord], a
	ld a, [hli]
	ld [wCurAnimYCoord], a
	ld a, [hli]
	ld [wCurAnimXOffset], a
	ld a, [hli]
	ld [wCurAnimYOffset], a
	ret

GetSpriteAnimVTile:
; a = wSpriteAnimDict[a] if a in wSpriteAnimDict else 0
; vTiles offset
	push hl
	push bc
	ld hl, wSpriteAnimDict
	ld b, a
	ld c, 10
.loop
	ld a, [hli]
	cp b
	jr z, .ok
	inc hl
	dec c
	jr nz, .loop
	xor a
	jr .done

.ok
	ld a, [hl]

.done
	pop bc
	pop hl
	ret

_ReinitSpriteAnimFrame::
	ld hl, SPRITEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld [hl], a
	ld hl, SPRITEANIMSTRUCT_DURATION
	add hl, bc
	ld [hl], 0
	ld hl, SPRITEANIMSTRUCT_FRAME
	add hl, bc
	ld [hl], -1
	ret

GetSpriteAnimFrame:
.loop
	ld hl, SPRITEANIMSTRUCT_DURATION
	add hl, bc
	ld a, [hl]
	and a
	jr z, .next_frame ; finished the current sequence
	dec [hl]
	call .GetPointer ; load pointer from SpriteAnimFrameData
	ld a, [hli]
	push af
	jr .okay

.next_frame
	ld hl, SPRITEANIMSTRUCT_FRAME
	add hl, bc
	inc [hl]
	call .GetPointer ; load pointer from SpriteAnimFrameData
	ld a, [hli]
	cp -2
	jr z, .restart
	cp -1
	jr z, .repeat_last

	push af
	ld a, [hl]
	push hl
	and $3f
	ld hl, SPRITEANIMSTRUCT_DURATIONOFFSET
	add hl, bc
	add [hl]
	ld hl, SPRITEANIMSTRUCT_DURATION
	add hl, bc
	ld [hl], a
	pop hl
.okay
	ld a, [hl]
	and $c0
	srl a
	ld [wCurSpriteAddSubFlags], a
	pop af
	ret

.repeat_last
	xor a
	ld hl, SPRITEANIMSTRUCT_DURATION
	add hl, bc
	ld [hl], a

	ld hl, SPRITEANIMSTRUCT_FRAME
	add hl, bc
	dec [hl]
	dec [hl]
	jr .loop

.restart
	xor a
	ld hl, SPRITEANIMSTRUCT_DURATION
	add hl, bc
	ld [hl], a

	dec a
	ld hl, SPRITEANIMSTRUCT_FRAME
	add hl, bc
	ld [hl], a
	jr .loop

.GetPointer:
	; Get the data for the current frame for the current animation sequence

	; SpriteAnimFrameData[SpriteAnim[SPRITEANIMSTRUCT_FRAMESET_ID]][SpriteAnim[SPRITEANIMSTRUCT_FRAME]]
	ld hl, SPRITEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld e, [hl]
	ld d, 0
	ld hl, SpriteAnimFrameData
	add hl, de
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, SPRITEANIMSTRUCT_FRAME
	add hl, bc
	ld l, [hl]
	ld h, 0
	add hl, hl
	add hl, de
	ret

GetFrameOAMPointer:
; Load OAM data pointer
	ld e, a
	ld d, 0
	ld hl, SpriteAnimOAMData
	add hl, de
	add hl, de
	add hl, de
	ret

INCLUDE "data/sprite_anims/sequences.asm"

INCLUDE "engine/gfx/sprite_anims.asm"

INCLUDE "data/sprite_anims/framesets.asm"
INCLUDE "data/sprite_anims/oam.asm"

AnimateEndOfExpBar:
	ld de, EndOfExpBarGFX
	ld hl, vTiles0 tile $00
	lb bc, BANK(EndOfExpBarGFX), 1
	call Request2bpp
	ld c, 8
	ld d, 0
.loop
	push bc
	call .AnimateFrame
	call DelayFrame
	pop bc
	inc d
	inc d
	dec c
	jr nz, .loop
	jp ClearSprites

.AnimateFrame:
	ld hl, wVirtualOAM
	ld c, $8
.anim_loop
	ld a, c
	and a
	ret z
	dec c
	ld a, c
; multiply by 8
	sla a
	sla a
	sla a
	push af

	push de
	push hl
	call Sine
	pop hl
	pop de
	add 13 * 8
	ld [hli], a

	pop af
	push de
	push hl
	call Cosine
	pop hl
	pop de
	add 19 * 8 + 4
	ld [hli], a

	xor a
	ld [hli], a
	ld a, $6 ; OBJ 6
	ld [hli], a
	jr .anim_loop

EndOfExpBarGFX:
INCBIN "gfx/battle/expbarend.2bpp"
