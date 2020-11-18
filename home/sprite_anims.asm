_InitSpriteAnimStruct::
	farjp InitSpriteAnimStruct

ReinitSpriteAnimFrame::
	farjp _ReinitSpriteAnimFrame

ClearSpriteAnims::
	ld hl, wSpriteAnimDict
	ld bc, wSpriteAnimsEnd - wSpriteAnimDict
.loop
	ld [hl], $0
	inc hl
	dec bc
	ld a, c
	or b
	jr nz, .loop
	ret

ClearSpriteAnims2::
	push hl
	push de
	push bc
	push af
	call ClearSpriteAnims
	jp PopAFBCDEHL
