; Pic animation arrangement.

POKEANIM: MACRO
	rept _NARG

; Workaround for a bug where MACRO args can't come after the start of a symbol
if !def(\1_POKEANIM)
\1_POKEANIM equs "PokeAnim_\1_"
endc

	db (\1_POKEANIM - PokeAnim_SetupCommands) / 2
	shift
	endr

	db (PokeAnim_Finish_ - PokeAnim_SetupCommands) / 2
ENDM


PokeAnims: ; d0042
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


AnimateFrontpic: ; d008e
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
; d00a3

LoadMonAnimation: ; d00a3
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

	ld a, [rSVBK]
	push af
	ld a, $2
	ld [rSVBK], a

	push bc
	push de
	push hl
	ld hl, wPokeAnimSceneIndex
	ld bc, wPokeAnimStructEnd - wPokeAnimSceneIndex
	xor a
	call ByteFill
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

	push de
	call PokeAnim_GetSpeciesOrVariant
	ld [wPokeAnimSpeciesOrVariant], a
	pop de

	call PokeAnim_GetFrontpicDims
	ld a, c
	ld [wPokeAnimFrontpicHeight], a

	pop af
	ld [rSVBK], a
	ret
; d0228

SetUpPokeAnim: ; d00b4
	ld a, [rSVBK]
	push af
	ld a, $2
	ld [rSVBK], a
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
	rst JumpTable
	ld a, [wPokeAnimSceneIndex]
	ld c, a
	pop af
	ld [rSVBK], a
	ld a, c
	and $80
	ret z
	scf
	ret
; d00da

PokeAnim_SetupCommands: ; d00da
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
; d00f2

PokeAnim_SetWait: ; d00f2
	ld a, 18
	ld [wPokeAnimWaitCounter], a
	ld a, [wPokeAnimSceneIndex]
	inc a
	ld [wPokeAnimSceneIndex], a

PokeAnim_Wait: ; d00fe
	ld hl, wPokeAnimWaitCounter
	dec [hl]
	ret nz
	ld a, [wPokeAnimSceneIndex]
	inc a
	ld [wPokeAnimSceneIndex], a
	ret
; d010b

PokeAnim_Setup: ; d010b
	lb bc, 0, FALSE
	call PokeAnim_InitAnim
	call PokeAnim_SetVBank1
	ld a, [wPokeAnimSceneIndex]
	inc a
	ld [wPokeAnimSceneIndex], a
	ret
; d011d

PokeAnim_Setup2: ; d011d
	lb bc, 4, FALSE
	call PokeAnim_InitAnim
	call PokeAnim_SetVBank1
	ld a, [wPokeAnimSceneIndex]
	inc a
	ld [wPokeAnimSceneIndex], a
	ret
; d012f

PokeAnim_Extra: ; d012f
	lb bc, 0, TRUE
	call PokeAnim_InitAnim
	call PokeAnim_SetVBank1
	ld a, [wPokeAnimSceneIndex]
	inc a
	ld [wPokeAnimSceneIndex], a
	ret
; d0141

PokeAnim_Play: ; d0141
	call PokeAnim_DoAnimScript
	ld a, [wPokeAnimJumptableIndex]
	bit 7, a
	ret z
	call PokeAnim_PlaceGraphic
	ld a, [wPokeAnimSceneIndex]
	inc a
	ld [wPokeAnimSceneIndex], a
	ret
; d0155

PokeAnim_Play2: ; d0155
	call PokeAnim_DoAnimScript
	ld a, [wPokeAnimJumptableIndex]
	bit 7, a
	ret z
	ld a, [wPokeAnimSceneIndex]
	inc a
	ld [wPokeAnimSceneIndex], a
	ret
; d0166

PokeAnim_BasePic: ; d0166
	call PokeAnim_DeinitFrames
	ld a, [wPokeAnimSceneIndex]
	inc a
	ld [wPokeAnimSceneIndex], a
	ret
; d0171

PokeAnim_Finish: ; d0171
	call PokeAnim_DeinitFrames
	ld hl, wPokeAnimSceneIndex
	set 7, [hl]
	ret
; d017a

PokeAnim_Cry: ; d017a
	ld a, [wPokeAnimSpecies]
	call _PlayCry
	ld a, [wPokeAnimSceneIndex]
	inc a
	ld [wPokeAnimSceneIndex], a
	ret
; d0188

PokeAnim_CryNoWait: ; d0188
	ld a, [wPokeAnimSpecies]
	call PlayCry2
	ld a, [wPokeAnimSceneIndex]
	inc a
	ld [wPokeAnimSceneIndex], a
	ret
; d0196

PokeAnim_StereoCry: ; d0196
	ld a, $f
	ld [wCryTracks], a
	ld a, [wPokeAnimSpecies]
	call PlayStereoCry2
	ld a, [wPokeAnimSceneIndex]
	inc a
	ld [wPokeAnimSceneIndex], a
	ret
; d01a9

PokeAnim_DeinitFrames: ; d01a9
	ld a, [rSVBK]
	push af
	ld a, $2
	ld [rSVBK], a
	call PokeAnim_PlaceGraphic
	farcall HDMATransferTileMapToWRAMBank3
	call PokeAnim_SetVBank0
	farcall HDMATransferAttrMapToWRAMBank3
	pop af
	ld [rSVBK], a
	ret
; d01c6

AnimateMon_CheckIfPokemon: ; d01c6
	ld a, [wCurPartySpecies]
	call IsAPokemon
	jr c, .fail
	and a
	ret

.fail
	scf
	ret
; d01d6

PokeAnim_InitAnim: ; d0228
	ld a, [rSVBK]
	push af
	ld a, $2
	ld [rSVBK], a
	push bc
	ld hl, wPokeAnimExtraFlag
	ld bc, wPokeAnimStructEnd - wPokeAnimExtraFlag
	xor a
	call ByteFill
	pop bc
	ld a, b
	ld [wPokeAnimSpeed], a
	ld a, c
	ld [wPokeAnimExtraFlag], a
	call GetMonAnimPointer
	call GetMonFramesPointer
	call GetMonBitmaskPointer
	pop af
	ld [rSVBK], a
	ret
; d0250

PokeAnim_DoAnimScript: ; d0250
	xor a
	ld [hBGMapMode], a

.loop: ; d0253
	ld a, [wPokeAnimJumptableIndex]
	and $7f
	ld hl, .Jumptable
	rst JumpTable
	ret
; d025d

.Jumptable: ; d025d
	dw .RunAnim
	dw .WaitAnim
; d0261

.RunAnim: ; d0261
	call PokeAnim_GetPointer
	ld a, [wPokeAnimCommand]
	cp $ff ; endanim
	jr z, PokeAnim_End
	cp $fe ; setrepeat
	jr z, .SetRepeat
	cp $fd ; dorepeat
	jr z, .DoRepeat
	call PokeAnim_GetFrame
	ld a, [wPokeAnimParameter]
	call PokeAnim_GetDuration
	ld [wPokeAnimWaitCounter], a
	call PokeAnim_StartWaitAnim
.WaitAnim: ; d0282
	ld a, [wPokeAnimWaitCounter]
	dec a
	ld [wPokeAnimWaitCounter], a
	ret nz
	jp PokeAnim_StopWaitAnim
; d028e

.SetRepeat: ; d028e
	ld a, [wPokeAnimParameter]
	ld [wPokeAnimRepeatTimer], a
	jr .loop
; d0296

.DoRepeat: ; d0296
	ld a, [wPokeAnimRepeatTimer]
	and a
	ret z
	dec a
	ld [wPokeAnimRepeatTimer], a
	ret z
	ld a, [wPokeAnimParameter]
	ld [wPokeAnimFrame], a
	jr .loop
; d02a8

PokeAnim_End: ; d02a8
	ld hl, wPokeAnimJumptableIndex
	set 7, [hl]
	ret
; d02ae

PokeAnim_GetDuration: ; d02ae
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
; d02c8

PokeAnim_GetFrame: ; d02c8
	call PokeAnim_PlaceGraphic
	ld a, [wPokeAnimCommand]
	and a
	ret z
	call PokeAnim_GetBitmaskIndex
	push hl
	call PokeAnim_CopyBitmaskToBuffer
	pop hl
	jp PokeAnim_ConvertAndApplyBitmask
; d02dc

PokeAnim_StartWaitAnim: ; d02dc
	ld a, [wPokeAnimJumptableIndex]
	inc a
	ld [wPokeAnimJumptableIndex], a
	ret
; d02e4

PokeAnim_StopWaitAnim: ; d02e4
	ld a, [wPokeAnimJumptableIndex]
	dec a
	ld [wPokeAnimJumptableIndex], a
	ret
; d02ec

PokeAnim_GetPointer: ; d02f8
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
	call GetFarHalfword
	ld a, l
	ld [wPokeAnimCommand], a
	ld a, h
	ld [wPokeAnimParameter], a
	ld hl, wPokeAnimFrame
	inc [hl]
	pop hl
	ret
; d031b

PokeAnim_GetBitmaskIndex: ; d031b
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
	call GetFarHalfword
	ld a, [wPokeAnimFramesBank]
	call GetFarByte
	ld [wPokeAnimCurBitmask], a
	inc hl
	ret
; d033b

PokeAnim_CopyBitmaskToBuffer: ; d033b
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
	jp FarCopyBytes
; d0356

.GetSize: ; d0356
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
; d0368

.Sizes: db 4, 5, 7

PokeAnim_ConvertAndApplyBitmask: ; d036b
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
; d0392

.IsCurBitSet: ; d0392
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
; d03bd

.ApplyFrame: ; d03bd
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
; d03cd

.GetCoord: ; d03cd
	call .GetStartCoord
	ld a, [wPokeAnimBitmaskCurRow]
	ld bc, SCREEN_WIDTH
	rst AddNTimes
	ld a, [wBoxAlignment]
	and a
	jr nz, .go
	ld a, [wPokeAnimBitmaskCurCol]
	ld e, a
	ld d, 0
	add hl, de
	ret

.go
	ld a, [wPokeAnimBitmaskCurCol]
	ld e, a
	ld a, l
	sub e
	ld l, a
	ld a, h
	sbc 0
	ld h, a
	ret
; d03f4

.GetTilemap: ; d03f7
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
; d042f

poke_anim_box: MACRO
y = 7
rept \1
x = 7 +- \1
rept \1
	db x + y
x = x + 1
endr
y = y + 7
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


.GetStartCoord: ; d046c
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
; d0499

.NextBit: ; d0499
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
; d04bd

PokeAnim_PlaceGraphic: ; d04bd
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
; d04f6

.ClearBox: ; d04f6
	ld hl, wPokeAnimCoord
	ld a, [hli]
	ld h, [hl]
	ld l, a
	lb bc, 7, 7
	jp ClearBox
; d0504

PokeAnim_SetVBank1: ; d0504
	ld a, [rSVBK]
	push af
	ld a, $2
	ld [rSVBK], a
	xor a
	ld [hBGMapMode], a
	call .SetFlag
	farcall HDMATransferAttrMapToWRAMBank3
	pop af
	ld [rSVBK], a
	ret
; d051b

.SetFlag: ; d051b
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
; d0536

PokeAnim_SetVBank0: ; d0536
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
; d0551

PokeAnim_GetAttrMapCoord: ; d0551
	ld hl, wPokeAnimCoord
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wAttrMap - wTileMap
	add hl, de
	ret
; d055c

GetMonAnimPointer: ; d055c
	ld a, [wPokeAnimSpecies]
	ld hl, VariantAnimPointerTable
	ld de, 6
	call IsInArray
	inc hl
	ld a, [hli]
	ld c, a

	ld a, [wPokeAnimExtraFlag]
	and a
	jr z, .extras
	inc hl
	inc hl
.extras

	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld a, [wPokeAnimSpeciesOrVariant]
	dec a
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, c
	ld [wPokeAnimPointerBank], a
	call GetFarHalfword
	ld a, l
	ld [wPokeAnimPointerAddr], a
	ld a, h
	ld [wPokeAnimPointerAddr + 1], a
	ret
; d05b4

PokeAnim_GetFrontpicDims: ; d05b4
	ld a, [rSVBK]
	push af
	ld a, $1
	ld [rSVBK], a
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	call GetBaseData
	ld a, [wBasePicSize]
	and $f
	ld c, a
	pop af
	ld [rSVBK], a
	ret
; d05ce

GetMonFramesPointer: ; d05ce
	ld a, [wPokeAnimSpecies]
	ld hl, VariantFramesPointerTable
	ld de, 5
	call IsInArray
	inc hl
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jr c, .got_frames
	ld a, [wPokeAnimSpecies]
	cp CHIKORITA
	jr c, .got_frames
	ld c, BANK(JohtoFrames)
.got_frames
	ld a, c
	ld [wPokeAnimFramesBank], a

	ld a, [wPokeAnimSpeciesOrVariant]
	dec a
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, b
	call GetFarHalfword
	ld a, l
	ld [wPokeAnimFramesAddr], a
	ld a, h
	ld [wPokeAnimFramesAddr + 1], a
	ret
; d061b

GetMonBitmaskPointer: ; d061b
	ld a, [wPokeAnimSpecies]
	ld hl, VariantBitmasksPointerTable
	ld de, 4
	call IsInArray
	inc hl
	ld a, [hli]
	ld [wPokeAnimBitmaskBank], a
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld a, [wPokeAnimSpeciesOrVariant]
	dec a
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [wPokeAnimBitmaskBank]
	call GetFarHalfword
	ld a, l
	ld [wPokeAnimBitmaskAddr], a
	ld a, h
	ld [wPokeAnimBitmaskAddr + 1], a
	ret
; d065c

PokeAnim_GetSpeciesOrVariant: ; d065c
	ld a, [wPokeAnimSpecies]
	ld hl, VariantSpeciesTable
	ld de, 1
	call IsInArray
	ld a, [wPokeAnimSpecies]
	ret nc
	ld a, [wPokeAnimVariant]
	ret
; d0669

HOF_AnimateFrontpic: ; d066e
	call AnimateMon_CheckIfPokemon
	jr c, .fail
	ld h, d
	ld l, e
	push bc
	push hl
	ld de, VTiles2
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
; d0695

INCLUDE "gfx/pokemon/variant_anim_data_tables.asm"
