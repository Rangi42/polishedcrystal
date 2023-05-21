InitSpriteAnimStruct::
	farjp _InitSpriteAnimStruct

ReinitSpriteAnimFrame::
	farjp _ReinitSpriteAnimFrame

ClearSpriteAnims::
	xor a
	ld hl, wSpriteAnimDict
	ld bc, wSpriteAnimsEnd - wSpriteAnimDict
	rst ByteFill
	ret

ClearSpriteAnims2::
	push hl
	push de
	push bc
	push af
	call ClearSpriteAnims
	jmp PopAFBCDEHL
