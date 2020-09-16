; Battle animation command interpreter.

PlayBattleAnim:
	ld hl, rIE
	set LCD_STAT, [hl]

	ldh a, [rSVBK]
	push af

	ld a, 5
	ldh [rSVBK], a

	call _PlayBattleAnim

	pop af
	ldh [rSVBK], a

	ld hl, rIE
	res LCD_STAT, [hl]
	ret

_PlayBattleAnim:

	ld c, 6
	call DelayFrames

	call BattleAnimAssignPals
	call BattleAnimRequestPals
	call DelayFrame

	ld c, 1
	ldh a, [rKEY1]
	bit 7, a
	jr nz, .asm_cc0ff
	ld c, 3

.asm_cc0ff
	ld hl, hVBlank
	ld a, [hl]
	push af

	ld [hl], c
	call BattleAnimRunScript

	pop af
	ldh [hVBlank], a

	ld a, $1
	ldh [hBGMapMode], a

	ld c, 3
	call DelayFrames
	jp WaitSFX

BattleAnimRunScript:

	ld a, [wFXAnimIDHi]
	and a
	jr nz, .hi_byte

	farcall CheckBattleEffects
	jr c, .disabled

	call BattleAnimClearHud
	call RunBattleAnimScript

	call BattleAnimAssignPals
	call BattleAnimRequestPals

	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	call DelayFrame
	call BattleAnimRestoreHuds

.disabled
	ld a, [wNumHits]
	and a
	jr z, .done

	ld l, a
	ld h, 0
	ld de, ANIM_MISS
	add hl, de
	ld a, l
	ld [wFXAnimIDLo], a
	ld a, h
	ld [wFXAnimIDHi], a

.hi_byte
	call WaitSFX
	call PlayHitSound
	call RunBattleAnimScript

.done
	jp BattleAnim_RevertPals

RunBattleAnimScript:

	call ClearBattleAnims

.playframe
	call RunBattleAnimCommand
	call _ExecuteBGEffects
	call BattleAnim_UpdateOAM_All
	call PushLYOverrides
	call BattleAnimRequestPals

; Speed up Rollout's animation.
	ld a, [wFXAnimIDHi]
	or a
	jr nz, .not_rollout

	ld a, [wFXAnimIDLo]
	cp ROLLOUT
	jr nz, .not_rollout

	ld a, $2e
	ld b, 5
	ld de, 4
	ld hl, wActiveBGEffects
.find
	cp [hl]
	jr z, .done
	add hl, de
	dec b
	jr nz, .find

.not_rollout
	call DelayFrame

.done
	ld a, [wBattleAnimFlags]
	bit 0, a
	jr z, .playframe

	jp BattleAnim_ClearCGB_OAMFlags

BattleAnimClearHud:

	call DelayFrame
	call WaitTop
	call ClearActorHud
	ld a, $1
	ldh [hBGMapMode], a
	call Delay2
	jp WaitTop

BattleAnimRestoreHuds:

	call DelayFrame
	call WaitTop

	ldh a, [rSVBK]
	push af
	ld a, $1
	ldh [rSVBK], a

	call UpdateBattleHuds

	pop af
	ldh [rSVBK], a

	ld a, $1
	ldh [hBGMapMode], a
	call Delay2
	jp WaitTop

BattleAnimRequestPals:

	ldh a, [rBGP]
	ld b, a
	ld a, [wBGP]
	cp b
	call nz, BattleAnim_SetBGPals

	ldh a, [rOBP0]
	ld b, a
	ld a, [wOBP0]
	cp b
	call nz, BattleAnim_SetOBPals
	ret

ClearActorHud:

	ldh a, [hBattleTurn]
	and a
	jr z, ClearPlayerHUD

ClearEnemyHUD:
	hlcoord 0, 0
	lb bc, 3, 11
	jp ClearBox

ClearPlayerHUD:
	hlcoord 11, 7
	lb bc, 5, 9
	call ClearBox
	ld a, " "
	hlcoord 10, 7
	ld [hl], a
	hlcoord 10, 11
	ld [hl], a
	ret

BattleAnim_ClearCGB_OAMFlags:

	ld a, [wBattleAnimFlags]
	bit 3, a
	ret nz

	ld hl, wVirtualOAM
	ld c, wVirtualOAMEnd - wVirtualOAM
	xor a
.loop2
	ld [hli], a
	dec c
	jr nz, .loop2
	ret

RunBattleAnimCommand:
	call .CheckTimer
	ret nc
	jp .RunScript

.CheckTimer:
	ld a, [wBattleAnimDelay]
	and a
	jr z, .done

	dec a
	ld [wBattleAnimDelay], a
	and a
	ret

.done
	scf
	ret

.RunScript:
.loop
	call GetBattleAnimByte

	cp $ff
	jr nz, .not_done_with_anim

; Return from a subroutine.
	ld hl, wBattleAnimFlags
	bit 1, [hl]
	jr nz, .do_anim

	set 0, [hl]
	ret

.not_done_with_anim
	cp $cf
	jr nc, .do_anim

	ld [wBattleAnimDelay], a
	ret

.do_anim
	call .DoCommand

	jr .loop

.DoCommand:
; Execute battle animation command in [wBattleAnimByte].
	ld a, [wBattleAnimByte]
	sub $cf
	call StackJumpTable

BattleAnimCommands::
	dw BattleAnimCmd_StatLoop
	dw BattleAnimCmd_Obj
	dw BattleAnimCmd_1GFX
	dw BattleAnimCmd_2GFX
	dw BattleAnimCmd_3GFX
	dw BattleAnimCmd_4GFX
	dw BattleAnimCmd_5GFX
	dw BattleAnimCmd_IncObj
	dw BattleAnimCmd_SetObj
	dw BattleAnimCmd_IncBGEffect
	dw BattleAnimCmd_EnemyFeetObj
	dw BattleAnimCmd_PlayerHeadObj
	dw BattleAnimCmd_CheckPokeball
	dw BattleAnimCmd_Transform
	dw BattleAnimCmd_RaiseSub
	dw BattleAnimCmd_DropSub
	dw BattleAnimCmd_ResetObp0
	dw BattleAnimCmd_Sound
	dw BattleAnimCmd_Cry
	dw BattleAnimCmd_MinimizeOpp
	dw BattleAnimCmd_OAMOn
	dw BattleAnimCmd_OAMOff
	dw BattleAnimCmd_ClearObjs
	dw BattleAnimCmd_BeatUp
	dw BattleAnimCmd_E7 ; dummy
	dw BattleAnimCmd_UpdateActorPic
	dw BattleAnimCmd_Minimize
	dw BattleAnimCmd_EA ; dummy
	dw BattleAnimCmd_EB ; dummy
	dw BattleAnimCmd_EC ; dummy
	dw BattleAnimCmd_ED ; dummy
	dw BattleAnimCmd_IfParamAnd
	dw BattleAnimCmd_JumpUntil
	dw BattleAnimCmd_BGEffect
	dw BattleAnimCmd_BGP
	dw BattleAnimCmd_OBP0
	dw BattleAnimCmd_OBP1
	dw BattleAnimCmd_ClearSprites
	dw BattleAnimCmd_F5 ; dummy
	dw BattleAnimCmd_F6 ; dummy
	dw BattleAnimCmd_F7 ; dummy
	dw BattleAnimCmd_IfParamEqual
	dw BattleAnimCmd_SetVar
	dw BattleAnimCmd_IncVar
	dw BattleAnimCmd_IfVarEqual
	dw BattleAnimCmd_Jump
	dw BattleAnimCmd_Loop
	dw BattleAnimCmd_Call
	dw BattleAnimCmd_Ret

BattleAnimCmd_E7:
BattleAnimCmd_EA:
BattleAnimCmd_EB:
BattleAnimCmd_EC:
BattleAnimCmd_ED:
BattleAnimCmd_F5:
BattleAnimCmd_F6:
BattleAnimCmd_F7:
	ret ; no-optimize stub function

BattleAnimCmd_Ret:
	ld hl, wBattleAnimFlags
	res 1, [hl]
	ld hl, wBattleAnimParent
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, wBattleAnimAddress
	ld [hl], e
	inc hl
	ld [hl], d
	ret

BattleAnimCmd_Call:
	call GetBattleAnimByte
	ld e, a
	call GetBattleAnimByte
	ld d, a
	push de
	ld hl, wBattleAnimAddress
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, wBattleAnimParent
	ld [hl], e
	inc hl
	ld [hl], d
	pop de
	ld hl, wBattleAnimAddress
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, wBattleAnimFlags
	set 1, [hl]
	ret

BattleAnimCmd_Jump:
	call GetBattleAnimByte
	ld e, a
	call GetBattleAnimByte
	ld d, a
	ld hl, wBattleAnimAddress
	ld [hl], e
	inc hl
	ld [hl], d
	ret

BattleAnimCmd_StatLoop:
	ld a, [wLoweredStat]
	swap a
	and $f
	inc a
	jr DoBattleAnimLoop
BattleAnimCmd_Loop:
	call GetBattleAnimByte
DoBattleAnimLoop:
	ld hl, wBattleAnimFlags
	bit 2, [hl]
	jr nz, .continue_loop
	and a
	jr z, .perpetual
	dec a
	set 2, [hl]
	ld [wBattleAnimLoops], a
.continue_loop
	ld hl, wBattleAnimLoops
	ld a, [hl]
	and a
	jr z, .return_from_loop
	dec [hl]
.perpetual
	call GetBattleAnimByte
	ld e, a
	call GetBattleAnimByte
	ld d, a
	ld hl, wBattleAnimAddress
	ld [hl], e
	inc hl
	ld [hl], d
	ret

.return_from_loop
	ld hl, wBattleAnimFlags
	res 2, [hl]
	ld hl, wBattleAnimAddress
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc de
	inc de
	ld [hl], d
	dec hl
	ld [hl], e
	ret

BattleAnimCmd_JumpUntil:
	ld hl, wBattleAnimParam
	ld a, [hl]
	and a
	jr z, .dont_jump

	dec [hl]
	call GetBattleAnimByte
	ld e, a
	call GetBattleAnimByte
	ld d, a
	ld hl, wBattleAnimAddress
	ld [hl], e
	inc hl
	ld [hl], d
	ret

.dont_jump
	ld hl, wBattleAnimAddress
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc de
	inc de
	ld [hl], d
	dec hl
	ld [hl], e
	ret

BattleAnimCmd_SetVar:
	call GetBattleAnimByte
	ld [wBattleAnimVar], a
	ret

BattleAnimCmd_IncVar:
	ld hl, wBattleAnimVar
	inc [hl]
	ret

BattleAnimCmd_IfVarEqual:
	call GetBattleAnimByte
	ld hl, wBattleAnimVar
	cp [hl]
	jr z, .jump

	ld hl, wBattleAnimAddress
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc de
	inc de
	ld [hl], d
	dec hl
	ld [hl], e
	ret

.jump
	call GetBattleAnimByte
	ld e, a
	call GetBattleAnimByte
	ld d, a
	ld hl, wBattleAnimAddress
	ld [hl], e
	inc hl
	ld [hl], d
	ret

BattleAnimCmd_IfParamEqual:
	call GetBattleAnimByte
	ld hl, wBattleAnimParam
	cp [hl]
	jr z, .jump

	ld hl, wBattleAnimAddress
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc de
	inc de
	ld [hl], d
	dec hl
	ld [hl], e
	ret

.jump
	call GetBattleAnimByte
	ld e, a
	call GetBattleAnimByte
	ld d, a
	ld hl, wBattleAnimAddress
	ld [hl], e
	inc hl
	ld [hl], d
	ret

BattleAnimCmd_IfParamAnd:
	call GetBattleAnimByte
	ld e, a
	ld a, [wBattleAnimParam]
	and e
	jr nz, .jump

	ld hl, wBattleAnimAddress
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc de
	inc de
	ld [hl], d
	dec hl
	ld [hl], e
	ret
.jump
	call GetBattleAnimByte
	ld e, a
	call GetBattleAnimByte
	ld d, a
	ld hl, wBattleAnimAddress
	ld [hl], e
	inc hl
	ld [hl], d
	ret

BattleAnimCmd_Obj:
; index, x, y, param
	call GetBattleAnimByte
	ld [wBattleAnimTemp0], a
	call GetBattleAnimByte
	ld [wBattleAnimTemp1], a
	call GetBattleAnimByte
	ld [wBattleAnimTemp2], a
	call GetBattleAnimByte
	ld [wBattleAnimTemp3], a
	jp QueueBattleAnimation

BattleAnimCmd_BGEffect:
	call GetBattleAnimByte
	ld [wBattleAnimTemp0], a
	call GetBattleAnimByte
	ld [wBattleAnimTemp1], a
	call GetBattleAnimByte
	ld [wBattleAnimTemp2], a
	call GetBattleAnimByte
	ld [wBattleAnimTemp3], a
	jp _QueueBGEffect

BattleAnimCmd_BGP:
	call GetBattleAnimByte
	ld [wBGP], a
	ret

BattleAnimCmd_OBP0:
	call GetBattleAnimByte
	ld [wOBP0], a
	ret

BattleAnimCmd_OBP1:
	call GetBattleAnimByte
	ld [wOBP1], a
	ret

BattleAnimCmd_ResetObp0:
	ld a, $e0
	ld [wOBP0], a
	ret

BattleAnimCmd_ClearObjs:
	ld hl, wActiveAnimObjects
	ld a, NUM_ANIM_OBJECTS * BATTLEANIMSTRUCT_LENGTH
.loop
	ld [hl], $0
	inc hl
	dec a
	jr nz, .loop
	ret

BattleAnimCmd_1GFX:
BattleAnimCmd_2GFX:
BattleAnimCmd_3GFX:
BattleAnimCmd_4GFX:
BattleAnimCmd_5GFX:
	ld a, [wBattleAnimByte]
	and $f
	ld c, a
	ld hl, wBattleAnimTileDict
	xor a
	ld [wBattleAnimTemp0], a
.loop
	ld a, [wBattleAnimTemp0]
	cp (vTiles1 - vTiles0) / LEN_2BPP_TILE - BATTLEANIM_BASE_TILE
	ret nc
	call GetBattleAnimByte
	ld [hli], a
	ld a, [wBattleAnimTemp0]
	ld [hli], a
	push bc
	push hl
	ld l, a
	ld h, $0
rept 4 ; no-optimize hl|bc|de = a * 16 (rept) [size > speed]
	add hl, hl
endr
	ld de, vTiles0 tile BATTLEANIM_BASE_TILE
	add hl, de
	ld a, [wBattleAnimByte]
	call LoadBattleAnimObj
	ld a, [wBattleAnimTemp0]
	add c
	ld [wBattleAnimTemp0], a
	pop hl
	pop bc
	dec c
	jr nz, .loop
	ret

BattleAnimCmd_IncObj:
	call GetBattleAnimByte
	ld e, NUM_ANIM_OBJECTS
	ld bc, wActiveAnimObjects
.loop
	ld hl, BATTLEANIMSTRUCT_INDEX
	add hl, bc
	ld d, [hl]
	ld a, [wBattleAnimByte]
	cp d
	jr z, .found
	ld hl, BATTLEANIMSTRUCT_LENGTH
	add hl, bc
	ld c, l
	ld b, h
	dec e
	jr nz, .loop
	ret

.found
	ld hl, BATTLEANIMSTRUCT_ANON_JT_INDEX
	add hl, bc
	inc [hl]
	ret

BattleAnimCmd_IncBGEffect:
	call GetBattleAnimByte
	ld e, 5
	ld bc, wActiveBGEffects
.loop
	ld hl, $0
	add hl, bc
	ld d, [hl]
	ld a, [wBattleAnimByte]
	cp d
	jr z, .found
	ld hl, 4
	add hl, bc
	ld c, l
	ld b, h
	dec e
	jr nz, .loop
	ret

.found
	ld hl, BG_EFFECT_STRUCT_JT_INDEX
	add hl, bc
	inc [hl]
	ret

BattleAnimCmd_SetObj:
	call GetBattleAnimByte
	ld e, NUM_ANIM_OBJECTS
	ld bc, wActiveAnimObjects
.loop
	ld hl, BATTLEANIMSTRUCT_INDEX
	add hl, bc
	ld d, [hl]
	ld a, [wBattleAnimByte]
	cp d
	jr z, .found
	ld hl, BATTLEANIMSTRUCT_LENGTH
	add hl, bc
	ld c, l
	ld b, h
	dec e
	jr nz, .loop
	ret

.found
	call GetBattleAnimByte
	ld hl, BATTLEANIMSTRUCT_ANON_JT_INDEX
	add hl, bc
	ld [hl], a
	ret

BattleAnimCmd_EnemyFeetObj:
	ld hl, wBattleAnimTileDict
.loop
	ld a, [hl]
	and a
	jr z, .okay
	inc hl
	inc hl
	jr .loop

.okay
	ld a, $28
	ld [hli], a
	ld a, $42
	ld [hli], a
	ld a, $29
	ld [hli], a
	ld [hl], $49

	ld hl, vTiles0 tile $73
	ld de, vTiles2 tile $06
	ld a, $70
	ld [wBattleAnimTemp0], a
	ld a, $7
	call .LoadFootprint
	ld de, vTiles2 tile $31
	ld a, $60
	ld [wBattleAnimTemp0], a
	ld a, $6
	; fallthrough

.LoadFootprint:
	push af
	push hl
	push de
	lb bc, BANK(BattleAnimCmd_EnemyFeetObj), 1
	call Request2bpp
	pop de
	ld a, [wBattleAnimTemp0]
	ld l, a
	ld h, 0
	add hl, de
	ld e, l
	ld d, h
	pop hl
	ld bc, 1 tiles
	add hl, bc
	pop af
	dec a
	jr nz, .LoadFootprint
	ret

BattleAnimCmd_PlayerHeadObj:
	ld hl, wBattleAnimTileDict
.loop
	ld a, [hl]
	and a
	jr z, .okay
	inc hl
	inc hl
	jr .loop

.okay
	ld a, $28
	ld [hli], a
	ld a, $35
	ld [hli], a
	ld a, $29
	ld [hli], a
	ld [hl], $43

	ld hl, vTiles0 tile $66
	ld de, vTiles2 tile $05
	ld a, $70
	ld [wBattleAnimTemp0], a
	ld a, $7
	call .LoadHead
	ld de, vTiles2 tile $31
	ld a, $60
	ld [wBattleAnimTemp0], a
	ld a, $6
	; fallthrough

.LoadHead:
	push af
	push hl
	push de
	lb bc, BANK(BattleAnimCmd_EnemyFeetObj), 2
	call Request2bpp
	pop de
	ld a, [wBattleAnimTemp0]
	ld l, a
	ld h, 0
	add hl, de
	ld e, l
	ld d, h
	pop hl
	ld bc, 2 tiles
	add hl, bc
	pop af
	dec a
	jr nz, .LoadHead
	ret

BattleAnimCmd_CheckPokeball:
	farcall GetPokeBallWobble
	ld a, c
	ld [wBattleAnimVar], a
	ret

BattleAnimCmd_Transform:
	ldh a, [rSVBK]
	push af
	ld a, 1
	ldh [rSVBK], a
	ld a, [wCurPartySpecies] ; CurPartySpecies
	push af

	ldh a, [hBattleTurn]
	and a
	jr z, .player

	ld a, [wTempBattleMonSpecies] ; TempBattleMonSpecies
	ld [wCurPartySpecies], a ; CurPartySpecies
	farcall GetBattleMonVariant
	ld de, vTiles0 tile $00
	predef GetFrontpic
	jr .done

.player
	ld a, [wTempEnemyMonSpecies] ; TempEnemyMonSpecies
	ld [wCurPartySpecies], a ; CurPartySpecies
	farcall GetEnemyMonVariant
	ld de, vTiles0 tile $00
	predef GetBackpic

.done
	pop af
	ld [wCurPartySpecies], a ; CurPartySpecies
	pop af
	ldh [rSVBK], a
	ret

BattleAnimCmd_UpdateActorPic:

	ld de, vTiles0 tile $00
	ldh a, [hBattleTurn]
	and a
	jr z, .player

	ld hl, vTiles2 tile $00
	lb bc, 0, $31
	jp Request2bpp

.player
	ld hl, vTiles2 tile $31
	lb bc, 0, $24
	jp Request2bpp

BattleAnimCmd_RaiseSub:
	ldh a, [rSVBK]
	push af
	ld a, 6
	ldh [rSVBK], a
	xor a
	call GetSRAMBank

GetSubstitutePic:
	ld hl, sScratch
	ld bc, 7 * 7 tiles
.loop
	xor a
	ld [hli], a
	dec bc
	ld a, c
	or b
	jr nz, .loop

	ldh a, [hBattleTurn]
	and a
	jr z, .player

	ld hl, SubstituteFrontpic
	ld a, BANK(SubstituteFrontpic)
	ld de, wTempTileMap
	call FarDecompress
	call .CopyPic
	ld hl, vTiles2 tile $00
	ld de, sScratch
	lb bc, BANK(GetSubstitutePic), 7 * 7
	call Request2bpp
	jr .done

.player
	ld hl, SubstituteBackpic
	ld a, BANK(SubstituteBackpic)
	ld de, wTempTileMap
	call FarDecompress
	call .CopyPic
	ld hl, vTiles2 tile $31
	ld de, sScratch
	lb bc, BANK(GetSubstitutePic), 6 * 6
	call Request2bpp

.done
	call CloseSRAM
	pop af
	ldh [rSVBK], a
	ret

.CopyPic
	ld b, 4
.loop1
	push bc
	ld c, 4
.loop2
	push bc
	call .GetTile
	call .CopyTile
	pop bc
	dec c
	jr nz, .loop2
	pop bc
	dec b
	jr nz, .loop1
	ret

.GetTile:
	; hl = wTempTileMap + (4 - b) * 4 tiles + (4 - c) tiles
	; de = sScratch + (1 + 4 - c) * 7 tiles + (2 + 4 - b) tiles if enemy
	; de = sScratch + (1 + 4 - c) * 6 tiles + (1 + 4-b) tiles if player
	ld a, 4
	sub b
	ld b, a
	ld a, 4
	sub c
	ld c, a
	push bc
	push bc
	inc c
	ldh a, [hBattleTurn]
	and a
	ld a, c
	ld bc, 6 tiles
	ld hl, sScratch
	jr z, .okay1
	ld bc, 7 tiles
	ld hl, sScratch + 1 tiles
.okay1
	rst AddNTimes
	pop bc
	inc b
	ldh a, [hBattleTurn]
	and a
	jr nz, .okay2
	inc b
.okay2
	ld a, b
	ld bc, 1 tiles
	rst AddNTimes
	ld d, h
	ld e, l
	pop bc
	push bc
	ld a, b
	ld hl, wTempTileMap
	ld bc, 4 tiles
	rst AddNTimes
	pop bc
	swap c
	ld b, 0
	add hl, bc
	ret

.CopyTile
	ld bc, 1 tiles
	ld a, BANK(GetSubstitutePic)
	jp FarCopyBytes

BattleAnimCmd_MinimizeOpp:
	ldh a, [rSVBK]
	push af
	ld a, $1
	ldh [rSVBK], a
	xor a
	call GetSRAMBank
	call GetMinimizePic
	call Request2bpp
	call CloseSRAM
	pop af
	ldh [rSVBK], a
	ret

GetMinimizePic:
	ld hl, sScratch
	ld bc, 7 * 7 tiles
.loop
	xor a
	ld [hli], a
	dec bc
	ld a, c
	or b
	jr nz, .loop

	ldh a, [hBattleTurn]
	and a
	jr z, .player

	ld de, sScratch + $1a tiles
	call CopyMinimizePic
	ld hl, vTiles2 tile $00
	ld de, sScratch
	lb bc, BANK(GetMinimizePic), 7 * 7
	ret

.player
	ld de, sScratch + $16 tiles
	call CopyMinimizePic
	ld hl, vTiles2 tile $31
	ld de, sScratch
	lb bc, BANK(GetMinimizePic), 6 * 6
	ret

CopyMinimizePic:
	ld hl, MinimizePic
	ld bc, 1 tiles
	ld a, BANK(MinimizePic)
	jp FarCopyBytes

MinimizePic:
INCBIN "gfx/battle/minimize.2bpp"

BattleAnimCmd_Minimize:
	ldh a, [rSVBK]
	push af
	ld a, $1
	ldh [rSVBK], a
	xor a
	call GetSRAMBank
	call GetMinimizePic
	ld hl, vTiles0 tile $00
	call Request2bpp
	call CloseSRAM
	pop af
	ldh [rSVBK], a
	ret

BattleAnimCmd_DropSub:
	ldh a, [rSVBK]
	push af
	ld a, $1
	ldh [rSVBK], a

	ld a, [wCurPartySpecies] ; CurPartySpecies
	push af
	ldh a, [hBattleTurn]
	and a
	jr z, .player

	farcall DropEnemySub
	jr .done

.player
	farcall DropPlayerSub

.done
	pop af
	ld [wCurPartySpecies], a ; CurPartySpecies
	pop af
	ldh [rSVBK], a
	ret

BattleAnimCmd_BeatUp:
	ldh a, [rSVBK]
	push af
	ld a, $1
	ldh [rSVBK], a
	ld a, [wCurPartySpecies] ; CurPartySpecies
	push af

	ld a, [wBattleAnimParam]
	ld [wCurPartySpecies], a ; CurPartySpecies

	ldh a, [hBattleTurn]
	and a
	jr z, .player

	farcall GetBattleMonVariant
	ld de, vTiles2 tile $00
	predef GetFrontpic
	jr .done

.player
	farcall GetEnemyMonVariant
	ld de, vTiles2 tile $31
	predef GetBackpic

.done
	pop af
	ld [wCurPartySpecies], a ; CurPartySpecies
	ld a, CGB_BATTLE_COLORS
	call GetCGBLayout
	pop af
	ldh [rSVBK], a
	ret

BattleAnimCmd_OAMOn:
	xor a
	ldh [hOAMUpdate], a
	ret

BattleAnimCmd_OAMOff:
	ld a, $1
	ldh [hOAMUpdate], a
	ret

BattleAnimCmd_ClearSprites:
	ld hl, wBattleAnimFlags
	set 3, [hl]
	ret

BattleAnimCmd_Sound:
	call GetBattleAnimByte
	ld e, a
	srl a
	srl a
	ld [wSFXDuration], a
	call .GetCryTrack
	and 3
	ld [wCryTracks], a ; CryTracks

	ld e, a
	ld d, 0
	ld hl, .GetPanning
	add hl, de
	ld a, [hl]
	ld [wStereoPanningMask], a

	call GetBattleAnimByte
	ld e, a
	ld d, 0
	farjp PlayStereoSFX

.GetPanning:
	db $f0, $0f, $f0, $0f

.GetCryTrack:
	ldh a, [hBattleTurn]
	and a
	jr nz, .enemy

	ld a, e
	ret

.enemy
	ld a, e
	xor 1
	ret

BattleAnimCmd_Cry:
	call GetBattleAnimByte
	and 3
	ld e, a
	ld d, 0
	ld hl, .CryData
rept 4
	add hl, de
endr

	ldh a, [rSVBK]
	push af
	ld a, 1
	ldh [rSVBK], a

	ldh a, [hBattleTurn]
	and a
	jr nz, .enemy

	ld a, $f0
	ld [wCryTracks], a ; CryTracks
	ld a, [wBattleMonSpecies] ; BattleMonSpecies
	jr .done_cry_tracks

.enemy
	ld a, $f
	ld [wCryTracks], a ; CryTracks
	ld a, [wEnemyMonSpecies] ; wEnemyMon

.done_cry_tracks
	push hl
	call LoadCryHeader
	pop hl
	jr c, .done

	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a

	push hl
	ld hl, wCryPitch
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, bc
	ld a, l
	ld [wCryPitch], a
	ld a, h
	ld [wCryPitch + 1], a
	pop hl

	ld a, [hli]
	ld c, a
	ld b, [hl]
	ld hl, wCryLength ; CryLength
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, bc

	ld a, l
	ld [wCryLength], a ; CryLength
	ld a, h
	ld [wCryLength + 1], a
	ld a, 1
	ld [wStereoPanningMask], a

	farcall _PlayCryHeader

.done
	pop af
	ldh [rSVBK], a
	ret

.CryData:
; +pitch, +length
	dw $0000, $00c0
	dw $0000, $0040
	dw $0000, $0000
	dw $0000, $0000

PlayHitSound:
	ld a, [wNumHits]
	cp $1
	jr z, .okay
	cp $4
	ret nz

.okay
	ld a, [wTypeModifier]
	and a
	ret z

	cp $10
	ld de, SFX_DAMAGE
	jr z, .play

	ld de, SFX_SUPER_EFFECTIVE
	jr nc, .play

	ld de, SFX_NOT_VERY_EFFECTIVE

.play
	jp PlaySFX

BattleAnimAssignPals:
	ld a, %11100100
	ld [wBGP], a
	ld [wOBP0], a
	ld [wOBP1], a
	call DmgToCgbBGPals
	lb de, %11100100, %11100100
	jp DmgToCgbObjPals

ClearBattleAnims:
; Clear animation block
	ld hl, wBattleAnims
	ld bc, wBattleAnimsEnd - wBattleAnims
	xor a
	rst ByteFill
	ld hl, wLYOverrides
	ld bc, wLYOverridesBackupEnd - wLYOverrides
	xor a
	rst ByteFill

	ld hl, wFXAnimIDLo
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, BattleAnimations
	add hl, de
	add hl, de
	call GetBattleAnimPointer
	call BattleAnimAssignPals
	jp DelayFrame

BattleAnim_RevertPals:
	call WaitTop
	ld a, %11100100
	ld [wBGP], a
	ld [wOBP0], a
	ld [wOBP1], a
	call DmgToCgbBGPals
	lb de, %11100100, %11100100
	call DmgToCgbObjPals
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	call DelayFrame
	ld a, $1
	ldh [hBGMapMode], a
	ret

BattleAnim_SetBGPals:
	ldh [rBGP], a
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
if !DEF(MONOCHROME)
	ld a, b
	cp $1b
	ldh a, [rBGP]
	jr z, .is_1b
	cp $1b
	jr nz, .not_1b
.is_1b
	ld c, 7 palettes
	ld hl, wBGPals1
.loop_UnknBGPals
	ld a, [hl]
	cpl
	ld [hli], a
	dec c
	jr nz, .loop_UnknBGPals
	ld c, 2 palettes
	ld hl, wOBPals1
.loop_UnknOBPals
	ld a, [hl]
	cpl
	ld [hli], a
	dec c
	jr nz, .loop_UnknOBPals
	ld a, $e4
.not_1b
	push af
else
	ldh a, [rBGP]
endc
	ld hl, wBGPals2
	ld de, wBGPals1
	ld b, a
	ld c, 7
	call CopyPals
	ld hl, wOBPals2
	ld de, wOBPals1
if !DEF(MONOCHROME)
	pop af
else
	ldh a, [rBGP]
endc
	ld b, a
	ld c, 2
	call CopyPals
	pop af
	ldh [rSVBK], a
	ld a, $1
	ldh [hCGBPalUpdate], a
	ret

BattleAnim_SetOBPals:
	ldh [rOBP0], a
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld hl, wOBPals2 palette PAL_BATTLE_OB_GRAY
	ld de, wOBPals1 palette PAL_BATTLE_OB_GRAY
	ldh a, [rOBP0]
	ld b, a
	ld c, $2
	call CopyPals
	pop af
	ldh [rSVBK], a
	ld a, $1
	ldh [hCGBPalUpdate], a
	ret

BattleAnim_UpdateOAM_All:
	xor a
	ld [wBattleAnimOAMPointerLo], a
	ld hl, wActiveAnimObjects
	ld e, NUM_ANIM_OBJECTS
.loop
	ld a, [hl]
	and a
	jr z, .next
	ld c, l
	ld b, h
	push hl
	push de
	call DoBattleAnimFrame
	call BattleAnimOAMUpdate
	pop de
	pop hl
	ret c

.next
	ld bc, BATTLEANIMSTRUCT_LENGTH
	add hl, bc
	dec e
	jr nz, .loop
	ld a, [wBattleAnimOAMPointerLo]
	ld l, a
	ld h, HIGH(wVirtualOAM)
.loop2
	ld a, l
	cp LOW(wVirtualOAMEnd)
	ret nc
	xor a
	ld [hli], a
	jr .loop2
