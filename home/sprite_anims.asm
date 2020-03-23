_InitSpriteAnimStruct::
	ld [wSpriteAnimIDBuffer], a
	ldh a, [hROMBank]
	push af

	ld a, BANK(InitSpriteAnimStruct)
	rst Bankswitch
	ld a, [wSpriteAnimIDBuffer]

	call InitSpriteAnimStruct

	pop af
	rst Bankswitch
	ret

ReinitSpriteAnimFrame::
	ld [wSpriteAnimIDBuffer], a
	ldh a, [hROMBank]
	push af

	ld a, BANK(_ReinitSpriteAnimFrame)
	rst Bankswitch
	ld a, [wSpriteAnimIDBuffer]

	call _ReinitSpriteAnimFrame

	pop af
	rst Bankswitch
	ret

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
