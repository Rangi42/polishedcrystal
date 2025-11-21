; Battle animation command interpreter.

PlayBattleAnim:
	farcall CheckBattleAnimSubstitution
	ldh a, [rWBK]
	push af

	ld a, 5
	ldh [rWBK], a

	call _PlayBattleAnim

	pop af
	ldh [rWBK], a
	ret

_PlayBattleAnim:
	ld c, 6
	call DelayFrames

	call BattleAnimAssignPals
	call BattleAnimRequestPals
	call DelayFrame

	ld c, 1
	ldh a, [rSPD]
	bit 7, a
	jr nz, .got_speed
	ld c, 3

.got_speed
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
	jmp WaitSFX

BattleAnimRunScript:
	; Check if we should play this animation unconditionally.
	; If not, the "battle effects" option can disable it.
	ld a, [wFXAnimIDHi]
	cp HIGH(FIRST_UNCONDITIONAL_ANIM)
	jr c, .conditional
	jr nz, .unconditional
	ld a, [wFXAnimIDLo]
	cp LOW(FIRST_UNCONDITIONAL_ANIM)
	jr nc, .unconditional

.conditional
	farcall CheckBattleEffects
	jr c, .disabled

	call BattleAnimClearHUD
	call RunBattleAnimScript

	call BattleAnimAssignPals
	call BattleAnimRequestPals

	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	call DelayFrame
	call BattleAnimRestoreHUDs

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

.unconditional
	call WaitSFX
	call PlayHitSound
	call RunBattleAnimScript

.done
	jmp BattleAnim_RevertPals

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
	bit 3, a
	ret nz

	; clear oam
	ld hl, wShadowOAM
	ld c, wShadowOAMEnd - wShadowOAM
	xor a
.loop2
	ld [hli], a
	dec c
	jr nz, .loop2
	ret

BattleAnimClearHUD:
	call DelayFrame
	call WaitTop
	call ClearActorHUD
	ld a, $1
	ldh [hBGMapMode], a
	call Delay2
	jmp WaitTop

BattleAnimRestoreHUDs:
	call DelayFrame
	call WaitTop

	ldh a, [rWBK]
	push af
	ld a, $1
	ldh [rWBK], a

	call UpdateBattleHuds

	pop af
	ldh [rWBK], a

	ld a, $1
	ldh [hBGMapMode], a
	call Delay2
	jmp WaitTop

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

ClearActorHUD:
	ldh a, [hBattleTurn]
	and a
	jr z, ClearPlayerHUD
	; fallthrough
ClearEnemyHUD:
	hlcoord 0, 0
	lb bc, 3, 11
	jmp ClearBox

BattleAnimCmd_ClearOpponentHUD:
	ldh a, [hBattleTurn]
	and a
	jr z, ClearEnemyHUD
	; fallthrough
ClearPlayerHUD:
	hlcoord 11, 7
	lb bc, 5, 9
	call ClearBox
	ld a, ' '
	hlcoord 10, 7
	ld [hl], a
	hlcoord 10, 11
	ld [hl], a
	ret

RunBattleAnimCommand:
	call .CheckTimer
	ret nc

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

.DoCommand:
; Execute battle animation command in [wBattleAnimByte].
	ld a, [wBattleAnimByte]
	sub $cf
	call StackJumpTable

BattleAnimCommands::
; entries correspond to anim_* constants (see macros/scripts/battle_anims.asm)
	table_width 2
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
	dw BattleAnimCmd_BattlerGFX_1Row
	dw BattleAnimCmd_BattlerGFX_2Row
	dw BattleAnimCmd_CheckPokeball
	dw BattleAnimCmd_Transform
	dw BattleAnimCmd_RaiseSub
	dw BattleAnimCmd_DropSub
	dw BattleAnimCmd_ResetObp0
	dw BattleAnimCmd_Sound
	dw BattleAnimCmd_Cry
	dw BattleAnimCmd_CheckCriticalCapture
	dw BattleAnimCmd_OAMOn
	dw BattleAnimCmd_OAMOff
	dw BattleAnimCmd_ClearObjs
	dw BattleAnimCmd_BeatUp
	dw BattleAnimCmd_ClearOpponentHUD
	dw BattleAnimCmd_UpdateActorPic
	dw BattleAnimCmd_SetBgPal
	dw BattleAnimCmd_SetObjPal
	dw BattleAnimCmd_HiObj
	dw DoNothing
	dw DoNothing
	dw BattleAnimCmd_IfParamAnd
	dw BattleAnimCmd_JumpUntil
	dw BattleAnimCmd_BGEffect
	dw BattleAnimCmd_BGP
	dw BattleAnimCmd_OBP0
	dw BattleAnimCmd_OBP1
	dw BattleAnimCmd_ClearSprites
	dw DoNothing
	dw DoNothing
	dw DoNothing
	dw BattleAnimCmd_IfParamEqual
	dw BattleAnimCmd_SetVar
	dw BattleAnimCmd_IncVar
	dw BattleAnimCmd_IfVarEqual
	dw BattleAnimCmd_Jump
	dw BattleAnimCmd_Loop
	dw BattleAnimCmd_Call
	dw BattleAnimCmd_Ret
	assert_table_length $100 - FIRST_BATTLE_ANIM_CMD

BattleAnimCmd_Ret:
	ld hl, wBattleAnimFlags
	res 1, [hl]
	ld hl, wBattleAnimParent
	ld a, [hli]
	ld d, [hl]
	ld hl, wBattleAnimAddress
	ld [hli], a
	ld [hl], d
	ret

BattleAnimCmd_Call:
	call GetBattleAnimByte
	ld e, a
	call GetBattleAnimByte
	ld d, a
	push de
	ld hl, wBattleAnimAddress
	ld a, [hli]
	ld d, [hl]
	ld hl, wBattleAnimParent
	ld [hli], a
	ld [hl], d
	pop de
	ld hl, wBattleAnimAddress
	ld a, e
	ld [hli], a
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
	ld a, e
	ld [hli], a
	ld [hl], d
	ret

BattleAnimCmd_StatLoop:
	ld a, [wChangedStat]
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
	ld a, e
	ld [hli], a
	ld [hl], d
	ret

.return_from_loop
	ld hl, wBattleAnimFlags
	res 2, [hl]
	ld hl, wBattleAnimAddress
	ld a, [hli]
	ld d, [hl]
	ld e, a
	inc de
	inc de
	ld a, d
	ld [hld], a
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
	ld a, e
	ld [hli], a
	ld [hl], d
	ret

.dont_jump
	ld hl, wBattleAnimAddress
	ld a, [hli]
	ld d, [hl]
	ld e, a
	inc de
	inc de
	ld a, d
	ld [hld], a
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
	ld a, [hli]
	ld d, [hl]
	ld e, a
	inc de
	inc de
	ld a, d
	ld [hld], a
	ld [hl], e
	ret

.jump
	call GetBattleAnimByte
	ld e, a
	call GetBattleAnimByte
	ld d, a
	ld hl, wBattleAnimAddress
	ld a, e
	ld [hli], a
	ld [hl], d
	ret

BattleAnimCmd_IfParamEqual:
	call GetBattleAnimByte
	ld hl, wBattleAnimParam
	cp [hl]
	jr z, .jump

	ld hl, wBattleAnimAddress
	ld a, [hli]
	ld d, [hl]
	ld e, a
	inc de
	inc de
	ld a, d
	ld [hld], a
	ld [hl], e
	ret

.jump
	call GetBattleAnimByte
	ld e, a
	call GetBattleAnimByte
	ld d, a
	ld hl, wBattleAnimAddress
	ld a, e
	ld [hli], a
	ld [hl], d
	ret

BattleAnimCmd_IfParamAnd:
	call GetBattleAnimByte
	ld e, a
	ld a, [wBattleAnimParam]
	and e
	jr nz, .jump

	ld hl, wBattleAnimAddress
	ld a, [hli]
	ld d, [hl]
	ld e, a
	inc de
	inc de
	ld a, d
	ld [hld], a
	ld [hl], e
	ret

.jump
	call GetBattleAnimByte
	ld e, a
	call GetBattleAnimByte
	ld d, a
	ld hl, wBattleAnimAddress
	ld a, e
	ld [hli], a
	ld [hl], d
	ret

BattleAnimCmd_HiObj:
; index, x, y, param
	ld d, 1
	jr BattleAnimCmd_LowObj
BattleAnimCmd_Obj:
; index, x, y, param
	ld d, 0
	; fallthrough
BattleAnimCmd_LowObj:
	call GetBattleAnimByte
	ld [wBattleAnimTemp0], a
	call GetBattleAnimByte
	ld [wBattleAnimTemp1], a
	call GetBattleAnimByte
	ld [wBattleAnimTemp2], a
	call GetBattleAnimByte
	ld [wBattleAnimTemp3], a
	jmp QueueBattleAnimation

BattleAnimCmd_BGEffect:
	call GetBattleAnimByte
	ld [wBattleAnimTemp0], a
	call GetBattleAnimByte
	ld [wBattleAnimTemp1], a
	call GetBattleAnimByte
	ld [wBattleAnimTemp2], a
	call GetBattleAnimByte
	ld [wBattleAnimTemp3], a
	jmp _QueueBGEffect

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
	ld e, NUM_ANIM_OBJECTS * BATTLEANIMSTRUCT_LENGTH
	xor a
.loop
	ld [hli], a
	dec e
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
	cp (vTiles1 - vTiles0) / TILE_SIZE - BATTLEANIM_BASE_TILE
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
	call LoadBattleAnimGFX
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
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
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
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], a
	ret

BattleAnimCmd_BattlerGFX_1Row:
	ld hl, wBattleAnimTileDict
.loop
	ld a, [hl]
	and a
	jr z, .okay
	inc hl
	inc hl
	jr .loop

.okay
	ld a, ANIM_GFX_PLAYERHEAD
	ld [hli], a
	ld a, $42
	ld [hli], a
	ld a, ANIM_GFX_ENEMYFEET
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
	lb bc, BANK(BattleAnimCmd_BattlerGFX_1Row), 1
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

BattleAnimCmd_BattlerGFX_2Row:
	ld hl, wBattleAnimTileDict
.loop
	ld a, [hl]
	and a
	jr z, .okay
	inc hl
	inc hl
	jr .loop

.okay
	ld a, ANIM_GFX_PLAYERHEAD
	ld [hli], a
	ld a, $35
	ld [hli], a
	ld a, ANIM_GFX_ENEMYFEET
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
	lb bc, BANK(BattleAnimCmd_BattlerGFX_2Row), 2
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

BattleAnimCmd_CheckCriticalCapture:
	ld hl, wBuffer2
	ld a, BANK(wBuffer2)
	call GetFarWRAMByte
	and $10
	ld [wBattleAnimVar], a
	ret

BattleAnimCmd_Transform:
	ldh a, [rWBK]
	push af
	ld a, 1
	ldh [rWBK], a
	ld a, [wCurPartySpecies]
	push af

	ldh a, [hBattleTurn]
	and a
	jr z, .player

	ld a, [wTempBattleMonSpecies]
	ld [wCurPartySpecies], a
	ld a, [wBattleMonForm]
	ld [wCurForm], a
	ld de, vTiles0 tile $00
	predef GetFrontpic
	jr .done

.player
	ld a, [wTempEnemyMonSpecies]
	ld [wCurPartySpecies], a
	ld a, [wEnemyMonForm]
	ld [wCurForm], a
	ld de, vTiles0 tile $00
	predef GetBackpic

.done
	pop af
	ld [wCurPartySpecies], a
	pop af
	ldh [rWBK], a
	ret

BattleAnimCmd_UpdateActorPic:

	ld de, vTiles0 tile $00
	ldh a, [hBattleTurn]
	and a
	jr z, .player

	ld hl, vTiles2 tile $00
	lb bc, 0, $31
	jmp Request2bpp

.player
	ld hl, vTiles2 tile $31
	lb bc, 0, $24
	jmp Request2bpp

BattleAnimCmd_SetBgPal:
	xor a
	jr SetBattleAnimPal
BattleAnimCmd_SetObjPal:
	ld a, 1
SetBattleAnimPal:
	; This denotes whether to reference bg pals or obj pals.
	ld b, a

	call GetBattleAnimByte
	ld d, a
	call GetBattleAnimByte
	ld e, a
	ld a, d
	cp PAL_BATTLE_BG_USER
	assert PAL_BATTLE_BG_USER + 1 == PAL_BATTLE_BG_TARGET
	ld a, b

	; User/Target pal handling should always index based on bg pal.
	ld b, 0
	jr z, .UserPal
	jr nc, .TargetPal
	ld b, a
.finish
	call .SetPaletteData
	jmp SetDefaultBGPAndOBP

.UserPal:
	ldh a, [hBattleTurn]
	and a
	jr nz, .EnemyPal
.PlayerPal:
	; Backpic.
	ld d, PAL_BATTLE_BG_PLAYER
	call .SetPaletteData

	; This is needed because part of the user pic reuses move info pals.
	ld d, PAL_BATTLE_BG_TYPE_CAT
	call .SetPaletteData

	; Head. + 8 to reference object palettes.
	ld d, PAL_BATTLE_OB_PLAYER + 8
	jr .finish

.TargetPal:
	ldh a, [hBattleTurn]
	and a
	jr nz, .PlayerPal
.EnemyPal:
	; Frontpic.
	ld d, PAL_BATTLE_BG_ENEMY
	call .SetPaletteData

	; Feet.
	ld d, PAL_BATTLE_OB_ENEMY + 8
	jr .finish

.SetPaletteData:
	push de
	push bc

	; Check if we should reference BG or OBJ pals.
	dec b
	jr nz, .got_pal_target
	ld a, d
	add 8 ; wBGPals + 8 palettes == wOBPals1
	ld d, a

.got_pal_target
	; Get palette to change.
	ld hl, wBGPals1
	ld bc, 1 palettes
	ld a, d
	rst AddNTimes

	; Get palette to set.
	call SwapHLDE
	ld a, l
	inc l
	jr z, .SetDefaultPal
	ld hl, CustomBattlePalettes
	rst AddNTimes

	; Write the palette.
	call FarCopyColorWRAM
.done_setpal
	pop bc
	pop de
	ret

.SetDefaultPal:
	farcall GetDefaultBattlePalette
	jr .done_setpal

CustomBattlePalettes:
	table_width 1 palettes
INCLUDE "gfx/battle_anims/custom.pal"
	assert_table_length NUM_CUSTOM_BATTLE_PALETTES

BattleAnimCmd_RaiseSub:
	ldh a, [rWBK]
	push af
	ld a, 6
	ldh [rWBK], a
	xor a
	call GetSRAMBank

	ld hl, SubstituteBackpic
	lb bc, BANK(SubstituteBackpic), 6 * 6
	ld de, vTiles2 tile $31

	ldh a, [hBattleTurn]
	and a
	jr z, .done

	ld hl, SubstituteFrontpic
	lb bc, BANK(SubstituteFrontpic), 7 * 7
	ld de, vTiles2 tile $00

.done
	call DecompressRequest2bpp
	call CloseSRAM
	pop af
	ldh [rWBK], a
	ret

BattleAnimCmd_DropSub:
	ldh a, [rWBK]
	push af
	ld a, $1
	ldh [rWBK], a

	ld a, [wCurPartySpecies]
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
	ld [wCurPartySpecies], a
	pop af
	ldh [rWBK], a
	ret

BattleAnimCmd_BeatUp:
	ldh a, [rWBK]
	push af
	ld a, $1
	ldh [rWBK], a
	ld a, [wCurPartySpecies]
	push af

	ld a, [wBattleAnimParam]
	ld [wCurPartySpecies], a

	ldh a, [hBattleTurn]
	and a
	jr z, .player

	ld a, [wBattleMonForm]
	ld [wCurForm], a
	ld de, vTiles2 tile $00
	predef GetFrontpic
	jr .done

.player
	ld a, [wEnemyMonForm]
	ld [wCurForm], a
	ld de, vTiles2 tile $31
	predef GetBackpic

.done
	pop af
	ld [wCurPartySpecies], a
	ld a, CGB_BATTLE_COLORS
	call GetCGBLayout
	pop af
	ldh [rWBK], a
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
	ld [wCryTracks], a

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

	ldh a, [rWBK]
	push af
	ld a, 1
	ldh [rWBK], a

	ldh a, [hBattleTurn]
	and a
	jr nz, .enemy

	ld a, $f0
	ld [wCryTracks], a
	ld a, [wBattleMonSpecies]
	ld c, a
	ld a, [wBattleMonForm]
	ld b, a
	jr .done_cry_tracks

.enemy
	ld a, $f
	ld [wCryTracks], a
	ld a, [wEnemyMonSpecies]
	ld c, a
	ld a, [wEnemyMonForm]
	ld b, a

.done_cry_tracks
	push hl
	call LoadCry
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
	ld hl, wCryLength
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, bc

	ld a, l
	ld [wCryLength], a
	ld a, h
	ld [wCryLength + 1], a
	ld a, 1
	ld [wStereoPanningMask], a

	farcall _PlayCry

.done
	pop af
	ldh [rWBK], a
	ret

.CryData:
; +pitch, +length
	dw $0000, $00c0
	dw $0000, $0040
	dw $0000, $0000
	dw $0000, $0000

PlayHitSound:
	ld a, [wNumHits]
	dec a ; BATTLEANIM_ENEMY_DAMAGE
	jr z, .ok
	dec a ; BATTLEANIM_PLAYER_DAMAGE
	ret nz

.ok
	ld a, [wTypeModifier]
	and a
	ret z

	cp EFFECTIVE
	ld de, SFX_DAMAGE
	jr z, .play

	ld de, SFX_SUPER_EFFECTIVE
	jr nc, .play

	ld de, SFX_NOT_VERY_EFFECTIVE

.play
	jmp PlaySFX

BattleAnimAssignPals:
	ld a, %11100100
	ld [wBGP], a
	ld [wOBP0], a
	ld [wOBP1], a
	call DmgToCgbBGPals
	lb de, %11100100, %11100100
	jmp DmgToCgbObjPals

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
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ld hl, BattleAnimations
	add hl, de
	add hl, de
	call GetBattleAnimPointer
	call BattleAnimAssignPals
	jmp DelayFrame

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
	ldh a, [rWBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rWBK], a
	ld hl, wBGPals2
	ld de, wBGPals1
	ldh a, [rBGP]
	ld b, a
	ld c, 7
	call CopyPals
	ld hl, wOBPals2
	ld de, wOBPals1
	ldh a, [rBGP]
	ld b, a
	ld c, 2
	call CopyPals
	pop af
	ldh [rWBK], a
	ld a, TRUE
	ldh [hCGBPalUpdate], a
	ret

BattleAnim_SetOBPals:
	ldh [rOBP0], a
	ldh a, [rWBK]
	push af
	ld a, $5
	ldh [rWBK], a
	ld hl, wOBPals2 palette PAL_BATTLE_OB_GRAY
	ld de, wOBPals1 palette PAL_BATTLE_OB_GRAY
	ldh a, [rOBP0]
	ld b, a
	ld c, $2
	call CopyPals
	pop af
	ldh [rWBK], a
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
	farcall DoBattleAnimFrame
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
	ld h, HIGH(wShadowOAM)
.loop2
	ld a, l
	cp LOW(wShadowOAMEnd)
	ret nc
	xor a
	ld [hli], a
	jr .loop2
