; Pic animation arrangement.

POKEANIM: MACRO
for i, 1, _NARG + 1
	db (PokeAnim_\<i>_ - PokeAnim_SetupCommands) / 2
endr
	db (PokeAnim_Finish_ - PokeAnim_SetupCommands) / 2
ENDM

PokeAnims:
	dw .Slow
	dw .Normal
	dw .Menu
	dw .Trade
	dw .Evolve
	dw .Hatch
	dw .Menu ; unused
	dw .Egg1
	dw .Egg2

.Slow:   POKEANIM StereoCry, Setup2, Play
.Normal: POKEANIM StereoCry, Setup, Play
.Menu:   POKEANIM CryNoWait, Setup, Play, SetWait, Wait, Extra, Play
.Trade:  POKEANIM Extra, Play2, Extra, Play, SetWait, Wait, Cry, Setup, Play
.Evolve: POKEANIM Extra, Play, SetWait, Wait, CryNoWait, Setup, Play
.Hatch:  POKEANIM Extra, Play, CryNoWait, Setup, Play, SetWait, Wait, Extra, Play
.Egg1:   POKEANIM Setup, Play
.Egg2:   POKEANIM Extra, Play

AnimateFrontpic:
	call AnimateMon_CheckIfPokemon
	ret c
	call LoadMonAnimation
.loop
	call SetUpPokeAnim
	push af
	farcall HDMATransferTileMapToWRAMBank3
	pop af
	jr nc, .loop
	ret

LoadMonAnimation:
	push hl
	ld c, e
	ld b, 0
	ld hl, PokeAnims
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld b, [hl]
	ld c, a
	pop hl

	ldh a, [rSVBK]
	push af
	ld a, $2
	ldh [rSVBK], a

	push bc
	push de
	push hl
	ld hl, wPokeAnimSceneIndex
	ld bc, wPokeAnimStructEnd - wPokeAnimSceneIndex
	xor a
	rst ByteFill
	pop hl
	pop de
	pop bc

; bc contains anim pointer
	ld a, c
	ld [wPokeAnimPointer], a
	ld a, b
	ld [wPokeAnimPointer + 1], a
; hl contains TileMap coords
	ld a, l
	ld [wPokeAnimCoord], a
	ld a, h
	ld [wPokeAnimCoord + 1], a
; d = start tile
	ld a, d
	ld [wPokeAnimGraphicStartTile], a

	ld a, $1
	ld hl, wCurPartySpecies
	call GetFarWRAMByte
	ld [wPokeAnimSpecies], a

	ld a, $1
	ld hl, wCurForm
	call GetFarWRAMByte
	ld [wPokeAnimVariant], a

	call PokeAnim_GetFrontpicDims
	ld a, c
	ld [wPokeAnimFrontpicHeight], a

	pop af
	ldh [rSVBK], a
	ret

SetUpPokeAnim:
	ldh a, [rSVBK]
	push af
	ld a, $2
	ldh [rSVBK], a
	ld a, [wPokeAnimSceneIndex]
	ld c, a
	ld b, 0
	ld hl, wPokeAnimPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, bc
	ld a, [hl]
	ld hl, PokeAnim_SetupCommands
	call JumpTable
	ld a, [wPokeAnimSceneIndex]
	ld c, a
	pop af
	ldh [rSVBK], a
	ld a, c
	and $80
	ret z
	scf
	ret

PokeAnim_SetupCommands:
setup_command: MACRO
\1_: dw \1
ENDM
	setup_command PokeAnim_Finish
	setup_command PokeAnim_BasePic
	setup_command PokeAnim_SetWait
	setup_command PokeAnim_Wait
	setup_command PokeAnim_Setup
	setup_command PokeAnim_Setup2
	setup_command PokeAnim_Extra
	setup_command PokeAnim_Play
	setup_command PokeAnim_Play2
	setup_command PokeAnim_Cry
	setup_command PokeAnim_CryNoWait
	setup_command PokeAnim_StereoCry

PokeAnim_SetWait:
	ld a, 18
	ld [wPokeAnimWaitCounter], a
	ld a, [wPokeAnimSceneIndex]
	inc a
	ld [wPokeAnimSceneIndex], a

PokeAnim_Wait:
	ld hl, wPokeAnimWaitCounter
	dec [hl]
	ret nz
	ld a, [wPokeAnimSceneIndex]
	inc a
	ld [wPokeAnimSceneIndex], a
	ret

PokeAnim_Setup:
	lb bc, 0, FALSE
	call PokeAnim_InitAnim
	call PokeAnim_SetVBank1
	ld a, [wPokeAnimSceneIndex]
	inc a
	ld [wPokeAnimSceneIndex], a
	ret

PokeAnim_Setup2:
	lb bc, 4, FALSE
	call PokeAnim_InitAnim
	call PokeAnim_SetVBank1
	ld a, [wPokeAnimSceneIndex]
	inc a
	ld [wPokeAnimSceneIndex], a
	ret

PokeAnim_Extra:
	lb bc, 0, TRUE
	call PokeAnim_InitAnim
	call PokeAnim_SetVBank1
	ld a, [wPokeAnimSceneIndex]
	inc a
	ld [wPokeAnimSceneIndex], a
	ret

PokeAnim_Play:
	call PokeAnim_DoAnimScript
	ld a, [wPokeAnimJumptableIndex]
	bit 7, a
	ret z
	call PokeAnim_PlaceGraphic
	ld a, [wPokeAnimSceneIndex]
	inc a
	ld [wPokeAnimSceneIndex], a
	ret

PokeAnim_Play2:
	call PokeAnim_DoAnimScript
	ld a, [wPokeAnimJumptableIndex]
	bit 7, a
	ret z
	ld a, [wPokeAnimSceneIndex]
	inc a
	ld [wPokeAnimSceneIndex], a
	ret

PokeAnim_BasePic:
	call PokeAnim_DeinitFrames
	ld a, [wPokeAnimSceneIndex]
	inc a
	ld [wPokeAnimSceneIndex], a
	ret

PokeAnim_Finish:
	call PokeAnim_DeinitFrames
	ld hl, wPokeAnimSceneIndex
	set 7, [hl]
	ret

PokeAnim_Cry:
	ld a, [wPokeAnimSpecies]
	call _PlayCry
	ld a, [wPokeAnimSceneIndex]
	inc a
	ld [wPokeAnimSceneIndex], a
	ret

PokeAnim_CryNoWait:
	ld a, [wPokeAnimSpecies]
	call PlayCry2
	ld a, [wPokeAnimSceneIndex]
	inc a
	ld [wPokeAnimSceneIndex], a
	ret

PokeAnim_StereoCry:
	ld a, $f
	ld [wCryTracks], a
	ld a, [wPokeAnimSpecies]
	call PlayStereoCry2
	ld a, [wPokeAnimSceneIndex]
	inc a
	ld [wPokeAnimSceneIndex], a
	ret

PokeAnim_DeinitFrames:
	ldh a, [rSVBK]
	push af
	ld a, $2
	ldh [rSVBK], a
	call PokeAnim_PlaceGraphic
	farcall HDMATransferTileMapToWRAMBank3
	call PokeAnim_SetVBank0
	farcall HDMATransferAttrMapToWRAMBank3
	pop af
	ldh [rSVBK], a
	ret

AnimateMon_CheckIfPokemon:
	ld a, [wCurPartySpecies]
	call IsAPokemon
	jr c, .fail
	and a
	ret

.fail
	scf
	ret

PokeAnim_InitAnim:
	ldh a, [rSVBK]
	push af
	ld a, $2
	ldh [rSVBK], a
	push bc
	ld hl, wPokeAnimIdleFlag
	ld bc, wPokeAnimStructEnd - wPokeAnimIdleFlag
	xor a
	rst ByteFill
	pop bc
	ld a, b
	ld [wPokeAnimSpeed], a
	ld a, c
	ld [wPokeAnimIdleFlag], a
	call GetMonAnimPointer
	call GetMonFramesPointer
	call GetMonBitmaskPointer
	pop af
	ldh [rSVBK], a
	ret

PokeAnim_DoAnimScript:
	xor a
	ldh [hBGMapMode], a

.loop:
	ld a, [wPokeAnimJumptableIndex]
	and $7f
	call StackJumpTable

.Jumptable:
	dw .RunAnim
	dw .WaitAnim

.RunAnim:
	call PokeAnim_GetPointer
	ld a, [wPokeAnimCommand]
	inc a ; $ff endanim
	jr z, PokeAnim_End
	inc a ; $fe setrepeat
	jr z, .SetRepeat
	inc a ; $fd dorepeat
	jr z, .DoRepeat
	call PokeAnim_GetFrame
	ld a, [wPokeAnimParameter]
	call PokeAnim_GetDuration
	ld [wPokeAnimWaitCounter], a
	call PokeAnim_StartWaitAnim
.WaitAnim:
	ld a, [wPokeAnimWaitCounter]
	dec a
	ld [wPokeAnimWaitCounter], a
	ret nz
	jr PokeAnim_StopWaitAnim

.SetRepeat:
	ld a, [wPokeAnimParameter]
	ld [wPokeAnimRepeatTimer], a
	jr .loop

.DoRepeat:
	ld a, [wPokeAnimRepeatTimer]
	and a
	ret z
	dec a
	ld [wPokeAnimRepeatTimer], a
	ret z
	ld a, [wPokeAnimParameter]
	ld [wPokeAnimFrame], a
	jr .loop

PokeAnim_End:
	ld hl, wPokeAnimJumptableIndex
	set 7, [hl]
	ret

PokeAnim_GetDuration:
; a * (1 + [wPokeAnimSpeed] / 16)
	ld c, a
	ld b, $0
	ld hl, 0
	ld a, [wPokeAnimSpeed]
	rst AddNTimes
	ld a, h
	swap a
	and $f0
	ld h, a
	ld a, l
	swap a
	and $f
	or h
	add c
	ret

PokeAnim_GetFrame:
	call PokeAnim_PlaceGraphic
	ld a, [wPokeAnimCommand]
	and a
	ret z
	call PokeAnim_GetBitmaskIndex
	push hl
	call PokeAnim_CopyBitmaskToBuffer
	pop hl
	jmp PokeAnim_ConvertAndApplyBitmask

PokeAnim_StartWaitAnim:
	ld a, [wPokeAnimJumptableIndex]
	inc a
	ld [wPokeAnimJumptableIndex], a
	ret

PokeAnim_StopWaitAnim:
	ld a, [wPokeAnimJumptableIndex]
	dec a
	ld [wPokeAnimJumptableIndex], a
	ret

PokeAnim_GetPointer:
	push hl
	ld a, [wPokeAnimFrame]
	ld e, a
	ld d, $0
	ld hl, wPokeAnimPointerAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de
	add hl, de
	ld a, [wPokeAnimPointerBank]
	call GetFarWord
	ld a, l
	ld [wPokeAnimCommand], a
	ld a, h
	ld [wPokeAnimParameter], a
	ld hl, wPokeAnimFrame
	inc [hl]
	pop hl
	ret

PokeAnim_GetBitmaskIndex:
	ld a, [wPokeAnimCommand]
	dec a
	ld c, a
	ld b, $0
	ld hl, wPokeAnimFramesAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, bc
	add hl, bc
	ld a, [wPokeAnimFramesBank]
	call GetFarWord
	ld a, [wPokeAnimFramesBank]
	call GetFarByte
	ld [wPokeAnimCurBitmask], a
	inc hl
	ret

PokeAnim_CopyBitmaskToBuffer:
	call .GetSize
	push bc
	ld hl, wPokeAnimBitmaskAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wPokeAnimCurBitmask]
	rst AddNTimes
	pop bc
	ld de, wPokeAnimBitmaskBuffer
	ld a, [wPokeAnimBitmaskBank]
	jmp FarCopyBytes

.GetSize:
	push hl
	ld a, [wPokeAnimFrontpicHeight]
	sub 5 ; to get a number 0, 1, or 2
	ld c, a
	ld b, 0
	ld hl, .Sizes
	add hl, bc
	ld c, [hl]
	ld b, 0
	pop hl
	ret

.Sizes: db 4, 5, 7

PokeAnim_ConvertAndApplyBitmask:
	xor a
	ld [wPokeAnimBitmaskCurBit], a
	ld [wPokeAnimBitmaskCurRow], a
	ld [wPokeAnimBitmaskCurCol], a
.loop
	push hl
	call .IsCurBitSet
	pop hl
	ld a, b
	and a
	jr z, .next

	ld a, [wPokeAnimFramesBank]
	call GetFarByte
	inc hl
	push hl
	call .ApplyFrame
	pop hl

.next
	push hl
	call .NextBit
	pop hl
	jr nc, .loop
	ret

.IsCurBitSet:
; which byte
	ld a, [wPokeAnimBitmaskCurBit]
	and $f8
	rrca
	rrca
	rrca
	ld e, a
	ld d, 0
	ld hl, wPokeAnimBitmaskBuffer
	add hl, de
	ld b, [hl]
; which bit
	ld a, [wPokeAnimBitmaskCurBit]
	and $7
	jr z, .skip

	ld c, a
	ld a, b
.loop2
	rrca
	dec c
	jr nz, .loop2
	ld b, a

.skip
	xor a
	bit 0, b
	jr z, .finish
	ld a, 1

.finish
	ld b, a
	ld hl, wPokeAnimBitmaskCurBit
	inc [hl]
	ret

.ApplyFrame:
	push af
	call .GetCoord
	pop af
	push hl
	call .GetTilemap
	ld hl, wPokeAnimGraphicStartTile
	add [hl]
	pop hl
	ld [hl], a
	ret

.GetCoord:
	call .GetStartCoord
	ld a, [wPokeAnimBitmaskCurRow]
	ld bc, SCREEN_WIDTH
	rst AddNTimes
	ld a, [wBoxAlignment]
	and a
	ld a, [wPokeAnimBitmaskCurCol]
	ld e, a
	jr nz, .subtract
	; hl += [wPokeAnimBitmaskCurCol]
	ld d, 0
	add hl, de
	ret

.subtract
	; hl -= [wPokeAnimBitmaskCurCol]
	ld a, l
	sub e
	ld l, a
	ret nc
	dec h
	ret

.GetTilemap:
	push af
	ld a, [wPokeAnimFrontpicHeight]
	cp 5
	jr z, .check_add_24
	cp 6
	jr z, .check_add_13
	pop af
	ret

.check_add_24
	pop af
	cp 5 * 5
	jr nc, .add_24
	push hl
	push de
	ld hl, ._5by5
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hl]
	pop de
	pop hl
	ret

.add_24
	add 24
	ret

.check_add_13
	pop af
	cp 6 * 6
	jr nc, .add_13
	push hl
	push de
	ld hl, ._6by6
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hl]
	pop de
	pop hl
	ret

.add_13
	add 13
	ret

poke_anim_box: MACRO
for y, 7, 7 * (\1 + 1), 7
for x, 7 - \1, 7
	db x + y
endr
endr
ENDM

._5by5:
	poke_anim_box 5
	; db  9, 10, 11, 12, 13
	; db 16, 17, 18, 19, 20
	; db 23, 24, 25, 26, 27
	; db 30, 31, 32, 33, 34
	; db 37, 38, 39, 40, 41

._6by6:
	poke_anim_box 6
	; db  8,  9, 10, 11, 12, 13
	; db 15, 16, 17, 18, 19, 20
	; db 22, 23, 24, 25, 26, 27
	; db 29, 30, 31, 32, 33, 34
	; db 36, 37, 38, 39, 40, 41
	; db 43, 44, 45, 46, 47, 48

.GetStartCoord:
	ld hl, wPokeAnimCoord
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld a, [wPokeAnimFrontpicHeight]
	ld de, 0
	ld bc, 6
	cp 7
	jr z, .okay
	ld de, SCREEN_WIDTH + 1
	ld bc, SCREEN_WIDTH + 5
	cp 6
	jr z, .okay
	ld de, 2 * SCREEN_WIDTH + 1
	ld bc, 2 * SCREEN_WIDTH + 5
.okay

	ld a, [wBoxAlignment]
	and a
	jr nz, .add_bc
	add hl, de
	ret

.add_bc
	add hl, bc
	ret

.NextBit:
	ld a, [wPokeAnimBitmaskCurRow]
	inc a
	ld [wPokeAnimBitmaskCurRow], a
	ld c, a
	ld a, [wPokeAnimFrontpicHeight]
	cp c
	jr nz, .no_carry
	xor a
	ld [wPokeAnimBitmaskCurRow], a
	ld a, [wPokeAnimBitmaskCurCol]
	inc a
	ld [wPokeAnimBitmaskCurCol], a
	ld c, a
	ld a, [wPokeAnimFrontpicHeight]
	cp c
	jr nz, .no_carry
	scf
	ret

.no_carry
	xor a
	ret

PokeAnim_PlaceGraphic:
	call .ClearBox
	ld a, [wBoxAlignment]
	and a
	jr nz, .flipped
	ld de, 1
	ld bc, 0
	jr .okay

.flipped
	ld de, -1
	ld bc, 6

.okay
	ld hl, wPokeAnimCoord
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, bc
	lb bc, 7, 7
	ld a, [wPokeAnimGraphicStartTile]
.loop
	push bc
	push hl
	push de
	ld de, SCREEN_WIDTH
.loop2
	ld [hl], a
	inc a
	add hl, de
	dec b
	jr nz, .loop2
	pop de
	pop hl
	add hl, de
	pop bc
	dec c
	jr nz, .loop
	ret

.ClearBox:
	ld hl, wPokeAnimCoord
	ld a, [hli]
	ld h, [hl]
	ld l, a
	lb bc, 7, 7
	jmp ClearBox

PokeAnim_SetVBank1:
	ldh a, [rSVBK]
	push af
	ld a, $2
	ldh [rSVBK], a
	xor a
	ldh [hBGMapMode], a
	call .SetFlag
	farcall HDMATransferAttrMapToWRAMBank3
	pop af
	ldh [rSVBK], a
	ret

.SetFlag:
	call PokeAnim_GetAttrMapCoord
	lb bc, 7, 7
	ld de, SCREEN_WIDTH
.row
	push bc
	push hl
.col
	ld a, [hl]
	or 8
	ld [hl], a
	add hl, de
	dec c
	jr nz, .col
	pop hl
	inc hl
	pop bc
	dec b
	jr nz, .row
	ret

PokeAnim_SetVBank0:
	call PokeAnim_GetAttrMapCoord
	lb bc, 7, 7
	ld de, SCREEN_WIDTH
.row
	push bc
	push hl
.col
	ld a, [hl]
	and $f7
	ld [hl], a
	add hl, de
	dec c
	jr nz, .col
	pop hl
	inc hl
	pop bc
	dec b
	jr nz, .row
	ret

PokeAnim_GetAttrMapCoord:
	ld hl, wPokeAnimCoord
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wAttrMap - wTileMap
	add hl, de
	ret

PokeAnim_GetFrontpicDims:
	ldh a, [rSVBK]
	push af
	ld a, $1
	ldh [rSVBK], a
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	call GetBaseData ; [wCurForm] is already set
	ld a, [wBasePicSize]
	and $f
	ld c, a
	pop af
	ldh [rSVBK], a
	ret

GetMonAnimDataIndex:
	; c = species
	ld a, [wPokeAnimSpecies]
	ld c, a
	; b = form
	ld a, [wPokeAnimVariant]
	ld b, a
	; bc = index
	jmp GetCosmeticSpeciesAndFormIndex

GetMonAnimPointer:
	call GetMonAnimDataIndex
	ld a, [wPokeAnimIdleFlag]
	and a
	ld hl, AnimationPointers
	ld a, BANK(AnimationPointers)
	jr z, .extras
	ld hl, AnimationExtraPointers
	ld a, BANK(AnimationExtraPointers)
.extras
	dec bc
	add hl, bc
	add hl, bc
	ld [wPokeAnimPointerBank], a
	call GetFarWord
	ld a, l
	ld [wPokeAnimPointerAddr], a
	ld a, h
	ld [wPokeAnimPointerAddr + 1], a
	ret

GetMonFramesPointer:
	call GetMonAnimDataIndex
	dec bc
	ld hl, FramesPointers
	add hl, bc
	add hl, bc
	ld a, BANK(FramesPointers)
	call GetFarWord
	ld a, l
	ld [wPokeAnimFramesAddr], a
	ld a, h
	ld [wPokeAnimFramesAddr + 1], a
	ld a, [wPokeAnimSpecies]
	cp CHIKORITA
	; a = carry ? BANK(KantoFrames) : BANK(JohtoFrames)
	assert BANK(KantoFrames) + 1 == BANK(JohtoFrames)
	sbc a
	add BANK(JohtoFrames)
	ld [wPokeAnimFramesBank], a
	ret

GetMonBitmaskPointer:
	call GetMonAnimDataIndex
	dec bc
	ld hl, BitmasksPointers
	add hl, bc
	add hl, bc
	ld a, BANK(BitmasksPointers)
	ld [wPokeAnimBitmaskBank], a
	call GetFarWord
	ld a, l
	ld [wPokeAnimBitmaskAddr], a
	ld a, h
	ld [wPokeAnimBitmaskAddr + 1], a
	ret

HOF_AnimateFrontpic:
	call AnimateMon_CheckIfPokemon
	jr c, .fail
	ld h, d
	ld l, e
	push bc
	push hl
	ld de, vTiles2
	predef FrontpicPredef
	pop hl
	pop bc
	ld d, 0
	ld e, c
	call AnimateFrontpic
	xor a
	ld [wBoxAlignment], a
	ret

.fail
	xor a
	ld [wBoxAlignment], a
	inc a
	ld [wCurPartySpecies], a
	ret
