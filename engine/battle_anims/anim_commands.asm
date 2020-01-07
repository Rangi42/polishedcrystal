; Battle animation command interpreter.


PlayBattleAnim: ; cc0d6
	ld hl, rIE
	set LCD_STAT, [hl]

	ld a, [rSVBK]
	push af

	ld a, 5
	ld [rSVBK], a

	call _PlayBattleAnim

	pop af
	ld [rSVBK], a

	ld hl, rIE
	res LCD_STAT, [hl]
	ret
; cc0e4

_PlayBattleAnim: ; cc0e4

	ld c, 6
	call DelayFrames

	call BattleAnimAssignPals
	call BattleAnimRequestPals
	call DelayFrame

	ld c, 1
	ld a, [rKEY1]
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
	ld [hVBlank], a

	ld a, $1
	ld [hBGMapMode], a

	ld c, 3
	call DelayFrames
	jp WaitSFX
; cc11c

BattleAnimRunScript: ; cc11c

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
	ld [hSCX], a
	ld [hSCY], a
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
; cc163

RunBattleAnimScript: ; cc163

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
; cc1a1

BattleAnimClearHud: ; cc1a1

	call DelayFrame
	call WaitTop
	call ClearActorHud
	ld a, $1
	ld [hBGMapMode], a
	call Delay2
	jp WaitTop
; cc1bb

BattleAnimRestoreHuds: ; cc1bb

	call DelayFrame
	call WaitTop

	ld a, [rSVBK]
	push af
	ld a, $1
	ld [rSVBK], a

	call UpdateBattleHuds

	pop af
	ld [rSVBK], a

	ld a, $1
	ld [hBGMapMode], a
	call Delay2
	jp WaitTop
; cc1e2

BattleAnimRequestPals: ; cc1e2

	ld a, [rBGP]
	ld b, a
	ld a, [wBGP]
	cp b
	call nz, BattleAnim_SetBGPals

	ld a, [rOBP0]
	ld b, a
	ld a, [wOBP0]
	cp b
	call nz, BattleAnim_SetOBPals
	ret
; cc1fb

ClearActorHud: ; cc207

	ld a, [hBattleTurn]
	and a
	jr z, .player

	hlcoord 0, 0
	lb bc, 4, 11
	jp ClearBox

.player
	hlcoord 9, 7
	lb bc, 5, 11
	jp ClearBox
; cc220


BattleAnim_ClearCGB_OAMFlags: ; cc23d

	ld a, [wBattleAnimFlags]
	bit 3, a
	jr z, .delete

	ld hl, wSprites + 3
	ld c, (wSpritesEnd - wSprites) / 4
.loop
	ld a, [hl]
	and $f0
	ld [hli], a
	inc hl
	inc hl
	inc hl
	dec c
	jr nz, .loop
	ret

.delete
	ld hl, wSprites
	ld c, wSpritesEnd - wSprites
	xor a
.loop2
	ld [hli], a
	dec c
	jr nz, .loop2
	ret
; cc25f

RunBattleAnimCommand: ; cc25f
	call .CheckTimer
	ret nc
	jp .RunScript
; cc267

.CheckTimer: ; cc267
	ld a, [wBattleAnimDuration]
	and a
	jr z, .done

	dec a
	ld [wBattleAnimDuration], a
	and a
	ret

.done
	scf
	ret
; cc275

.RunScript: ; cc275
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

	ld [wBattleAnimDuration], a
	ret

.do_anim
	call .DoCommand

	jr .loop
; cc293

.DoCommand: ; cc293
; Execute battle animation command in [wBattleAnimByte].
	ld a, [wBattleAnimByte]
	sub $cf

	ld e, a
	ld d, 0
	ld hl, BattleAnimCommands
	add hl, de
	add hl, de

	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl
; cc2a4


BattleAnimCommands:: ; cc2a4 (33:42a4)
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
	ret

BattleAnimCmd_Ret: ; cc305 (33:4305)
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

BattleAnimCmd_Call: ; cc317 (33:4317)
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

BattleAnimCmd_Jump: ; cc339 (33:4339)
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
BattleAnimCmd_Loop: ; cc348 (33:4348)
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

BattleAnimCmd_JumpUntil: ; cc383 (33:4383)
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

BattleAnimCmd_SetVar: ; cc3a6 (33:43a6)
	call GetBattleAnimByte
	ld [wBattleAnimVar], a
	ret

BattleAnimCmd_IncVar: ; cc3ad (33:43ad)
	ld hl, wBattleAnimVar
	inc [hl]
	ret

BattleAnimCmd_IfVarEqual: ; cc3b2 (33:43b2)
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

BattleAnimCmd_IfParamEqual: ; cc3d6 (33:43d6)
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

BattleAnimCmd_IfParamAnd: ; cc3fa (33:43fa)
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

BattleAnimCmd_Obj: ; cc41f (33:441f)
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

BattleAnimCmd_BGEffect: ; cc43b (33:443b)
	call GetBattleAnimByte
	ld [wBattleAnimTemp0], a
	call GetBattleAnimByte
	ld [wBattleAnimTemp1], a
	call GetBattleAnimByte
	ld [wBattleAnimTemp2], a
	call GetBattleAnimByte
	ld [wBattleAnimTemp3], a
	jp _QueueBGEffect

BattleAnimCmd_BGP: ; cc457 (33:4457)
	call GetBattleAnimByte
	ld [wBGP], a
	ret

BattleAnimCmd_OBP0: ; cc45e (33:445e)
	call GetBattleAnimByte
	ld [wOBP0], a
	ret

BattleAnimCmd_OBP1: ; cc465 (33:4465)
	call GetBattleAnimByte
	ld [wOBP1], a
	ret

BattleAnimCmd_ResetObp0: ; cc46c (33:446c)
	ld a, $e0
	ld [wOBP0], a
	ret

BattleAnimCmd_ClearObjs: ; cc479 (33:4479)
	ld hl, wActiveAnimObjects
	ld a, $a0
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
BattleAnimCmd_5GFX: ; cc485 (33:4485)
	ld a, [wBattleAnimByte]
	and $f
	ld c, a
	ld hl, wBattleAnimTileDict
	xor a
	ld [wBattleAnimTemp0], a
.loop
	ld a, [wBattleAnimTemp0]
	cp (VTiles1 - VTiles0) / $10 - $31
	ret nc
	call GetBattleAnimByte
	ld [hli], a
	ld a, [wBattleAnimTemp0]
	ld [hli], a
	push bc
	push hl
	ld l, a
	ld h, $0
rept 4
	add hl, hl
endr
	ld de, VTiles0 tile $31
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

BattleAnimCmd_IncObj: ; cc4c0 (33:44c0)
	call GetBattleAnimByte
	ld e, 10
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

BattleAnimCmd_IncBGEffect: ; cc4e3 (33:44e3)
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

BattleAnimCmd_SetObj: ; cc506 (33:4506)
	call GetBattleAnimByte
	ld e, 10
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

BattleAnimCmd_EnemyFeetObj: ; cc52c (33:452c)
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
	ld a, $49
	ld [hl], a

	ld hl, VTiles0 tile $73
	ld de, VTiles2 tile $06
	ld a, $70
	ld [wBattleAnimTemp0], a
	ld a, $7
	call .LoadFootprint
	ld de, VTiles2 tile $31
	ld a, $60
	ld [wBattleAnimTemp0], a
	ld a, $6
	; fallthrough

.LoadFootprint: ; cc561 (33:4561)
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

BattleAnimCmd_PlayerHeadObj: ; cc57e (33:457e)
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
	ld a, $43
	ld [hl], a

	ld hl, VTiles0 tile $66
	ld de, VTiles2 tile $05
	ld a, $70
	ld [wBattleAnimTemp0], a
	ld a, $7
	call .LoadHead
	ld de, VTiles2 tile $31
	ld a, $60
	ld [wBattleAnimTemp0], a
	ld a, $6
	; fallthrough

.LoadHead: ; cc5b3 (33:45b3)
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

BattleAnimCmd_CheckPokeball: ; cc5d0 (33:45d0)
	farcall GetPokeBallWobble
	ld a, c
	ld [wBattleAnimVar], a
	ret

BattleAnimCmd_Transform: ; cc5dc (33:45dc)
	ld a, [rSVBK]
	push af
	ld a, 1
	ld [rSVBK], a
	ld a, [wCurPartySpecies] ; CurPartySpecies
	push af

	ld a, [hBattleTurn]
	and a
	jr z, .player

	ld a, [wTempBattleMonSpecies] ; TempBattleMonSpecies
	ld [wCurPartySpecies], a ; CurPartySpecies
	farcall GetBattleMonVariant
	ld de, VTiles0 tile $00
	predef GetFrontpic
	jr .done

.player
	ld a, [wTempEnemyMonSpecies] ; TempEnemyMonSpecies
	ld [wCurPartySpecies], a ; CurPartySpecies
	farcall GetEnemyMonVariant
	ld de, VTiles0 tile $00
	predef GetBackpic

.done
	pop af
	ld [wCurPartySpecies], a ; CurPartySpecies
	pop af
	ld [rSVBK], a
	ret

BattleAnimCmd_UpdateActorPic: ; cc622 (33:4622)

	ld de, VTiles0 tile $00
	ld a, [hBattleTurn]
	and a
	jr z, .player

	ld hl, VTiles2 tile $00
	lb bc, 0, $31
	jp Request2bpp

.player
	ld hl, VTiles2 tile $31
	lb bc, 0, $24
	jp Request2bpp

BattleAnimCmd_RaiseSub: ; cc640 (33:4640)
	ld a, [rSVBK]
	push af
	ld a, 6
	ld [rSVBK], a
	xor a
	call GetSRAMBank

GetSubstitutePic: ; cc64c
	ld hl, sScratch
	ld bc, 7 * 7 tiles
.loop
	xor a
	ld [hli], a
	dec bc
	ld a, c
	or b
	jr nz, .loop

	ld a, [hBattleTurn]
	and a
	jr z, .player

	ld hl, SubstituteFrontpic
	ld a, BANK(SubstituteFrontpic)
	ld de, wTempTileMap
	call FarDecompress
	call .CopyPic
	ld hl, VTiles2 tile $00
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
	ld hl, VTiles2 tile $31
	ld de, sScratch
	lb bc, BANK(GetSubstitutePic), 6 * 6
	call Request2bpp

.done
	call CloseSRAM
	pop af
	ld [rSVBK], a
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
	ld a, [hBattleTurn]
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
	ld a, [hBattleTurn]
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

.CopyTile ; cc6c6 (33:46c6)
	ld bc, 1 tiles
	ld a, BANK(GetSubstitutePic)
	jp FarCopyBytes

BattleAnimCmd_MinimizeOpp: ; cc6cf (33:46cf)
	ld a, [rSVBK]
	push af
	ld a, $1
	ld [rSVBK], a
	xor a
	call GetSRAMBank
	call GetMinimizePic
	call Request2bpp
	call CloseSRAM
	pop af
	ld [rSVBK], a
	ret

GetMinimizePic: ; cc6e7 (33:46e7)
	ld hl, sScratch
	ld bc, 7 * 7 tiles
.loop
	xor a
	ld [hli], a
	dec bc
	ld a, c
	or b
	jr nz, .loop

	ld a, [hBattleTurn]
	and a
	jr z, .player

	ld de, sScratch + $1a tiles
	call CopyMinimizePic
	ld hl, VTiles2 tile $00
	ld de, sScratch
	lb bc, BANK(GetMinimizePic), 7 * 7
	ret

.player
	ld de, sScratch + $16 tiles
	call CopyMinimizePic
	ld hl, VTiles2 tile $31
	ld de, sScratch
	lb bc, BANK(GetMinimizePic), 6 * 6
	ret

CopyMinimizePic: ; cc719 (33:4719)
	ld hl, MinimizePic
	ld bc, 1 tiles
	ld a, BANK(MinimizePic)
	jp FarCopyBytes
; cc725 (33:4725)

MinimizePic: ; cc725
INCBIN "gfx/battle/minimize.2bpp"
; cc735

BattleAnimCmd_Minimize: ; cc735 (33:4735)
	ld a, [rSVBK]
	push af
	ld a, $1
	ld [rSVBK], a
	xor a
	call GetSRAMBank
	call GetMinimizePic
	ld hl, VTiles0 tile $00
	call Request2bpp
	call CloseSRAM
	pop af
	ld [rSVBK], a
	ret

BattleAnimCmd_DropSub: ; cc750 (33:4750)
	ld a, [rSVBK]
	push af
	ld a, $1
	ld [rSVBK], a

	ld a, [wCurPartySpecies] ; CurPartySpecies
	push af
	ld a, [hBattleTurn]
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
	ld [rSVBK], a
	ret

BattleAnimCmd_BeatUp: ; cc776 (33:4776)
	ld a, [rSVBK]
	push af
	ld a, $1
	ld [rSVBK], a
	ld a, [wCurPartySpecies] ; CurPartySpecies
	push af

	ld a, [wBattleAnimParam]
	ld [wCurPartySpecies], a ; CurPartySpecies

	ld a, [hBattleTurn]
	and a
	jr z, .player

	farcall GetBattleMonVariant
	ld de, VTiles2 tile $00
	predef GetFrontpic
	jr .done

.player
	farcall GetEnemyMonVariant
	ld de, VTiles2 tile $31
	predef GetBackpic

.done
	pop af
	ld [wCurPartySpecies], a ; CurPartySpecies
	ld b, CGB_BATTLE_COLORS
	call GetCGBLayout
	pop af
	ld [rSVBK], a
	ret

BattleAnimCmd_OAMOn: ; cc7bb (33:47bb)
	xor a
	ld [hOAMUpdate], a
	ret

BattleAnimCmd_OAMOff: ; cc7bf (33:47bf)
	ld a, $1
	ld [hOAMUpdate], a
	ret

BattleAnimCmd_ClearSprites: ; cc7c4 (33:47c4)
	ld hl, wBattleAnimFlags
	set 3, [hl]
	ret

BattleAnimCmd_Sound: ; cc7cd (33:47cd)
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
; cc7f8 (33:47f8)

.GetPanning: ; cc7f8
	db $f0, $0f, $f0, $0f
; cc7fc

.GetCryTrack: ; cc7fc (33:47fc)
	ld a, [hBattleTurn]
	and a
	jr nz, .enemy

	ld a, e
	ret

.enemy
	ld a, e
	xor 1
	ret

BattleAnimCmd_Cry: ; cc807 (33:4807)
	call GetBattleAnimByte
	and 3
	ld e, a
	ld d, 0
	ld hl, .CryData
rept 4
	add hl, de
endr

	ld a, [rSVBK]
	push af
	ld a, 1
	ld [rSVBK], a

	ld a, [hBattleTurn]
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
	ld [rSVBK], a
	ret
; cc871 (33:4871)

.CryData: ; cc871
; +pitch, +length
	dw $0000, $00c0
	dw $0000, $0040
	dw $0000, $0000
	dw $0000, $0000
; cc881


PlayHitSound: ; cc881
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
; cc8a4

BattleAnimAssignPals: ; cc8a4
	ld a, %11100100
	ld [wBGP], a
	ld [wOBP0], a
	ld [wOBP1], a
	call DmgToCgbBGPals
	lb de, %11100100, %11100100
	jp DmgToCgbObjPals
; cc8d3

ClearBattleAnims: ; cc8d3
; Clear animation block
	ld hl, wLYOverrides
	ld bc, wBattleAnimEnd - wLYOverrides
	xor a
	call ByteFill

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

BattleAnim_RevertPals: ; cc8f6
	call WaitTop
	ld a, %11100100
	ld [wBGP], a
	ld [wOBP0], a
	ld [wOBP1], a
	call DmgToCgbBGPals
	lb de, %11100100, %11100100
	call DmgToCgbObjPals
	xor a
	ld [hSCX], a
	ld [hSCY], a
	call DelayFrame
	ld a, $1
	ld [hBGMapMode], a
	ret
; cc91a

BattleAnim_SetBGPals: ; cc91a
	ld [rBGP], a
	ld a, [rSVBK]
	push af
	ld a, $5
	ld [rSVBK], a
if !DEF(MONOCHROME)
	ld a, b
	cp $1b
	ld a, [rBGP]
	jr z, .is_1b
	cp $1b
	jr nz, .not_1b
.is_1b
	ld c, 7 palettes
	ld hl, wUnknBGPals
.loop_UnknBGPals
	ld a, [hl]
	ld b, a
	ld a, $ff
	sub b
	ld [hli], a
	dec c
	jr nz, .loop_UnknBGPals
	ld c, 2 palettes
	ld hl, wUnknOBPals
.loop_UnknOBPals
	ld a, [hl]
	ld b, a
	ld a, $ff
	sub b
	ld [hli], a
	dec c
	jr nz, .loop_UnknOBPals
	ld a, $e4
.not_1b
	push af
else
	ld a, [rBGP]
endc
	ld hl, wBGPals
	ld de, wUnknBGPals
	ld b, a
	ld c, 7
	call CopyPals
	ld hl, wOBPals
	ld de, wUnknOBPals
if !DEF(MONOCHROME)
	pop af
else
	ld a, [rBGP]
endc
	ld b, a
	ld c, 2
	call CopyPals
	pop af
	ld [rSVBK], a
	ld a, $1
	ld [hCGBPalUpdate], a
	ret
; cc94b

BattleAnim_SetOBPals: ; cc94b
	ld [rOBP0], a
	ld a, [rSVBK]
	push af
	ld a, $5
	ld [rSVBK], a
	ld hl, wOBPals palette PAL_BATTLE_OB_GRAY
	ld de, wUnknOBPals palette PAL_BATTLE_OB_GRAY
	ld a, [rOBP0]
	ld b, a
	ld c, $2
	call CopyPals
	pop af
	ld [rSVBK], a
	ld a, $1
	ld [hCGBPalUpdate], a
	ret
; cc96e

BattleAnim_UpdateOAM_All: ; cc96e
	xor a
	ld [wBattleAnimOAMPointerLo], a
	ld hl, wActiveAnimObjects
	ld e, 10
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
	ld h, wSprites / $100
.loop2
	ld a, l
	cp wSpritesEnd % $100
	ret nc
	xor a
	ld [hli], a
	jr .loop2
; cc9a1
