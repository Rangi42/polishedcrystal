SLOTS_NOMATCH EQU -1
SLOTS_SEVEN EQU $00
SLOTS_POKEBALL EQU $04
SLOTS_CHERRY EQU $08
SLOTS_PIKACHU EQU $0c
SLOTS_SQUIRTLE EQU $10
SLOTS_STARYU EQU $14
REEL_SIZE EQU 15

_SlotMachine:
	ld hl, wOptions1
	set NO_TEXT_SCROLL, [hl]
	call .InitGFX
	call DelayFrame
.loop
	call SlotsLoop
	jr nc, .loop
	call WaitSFX
	ld de, SFX_QUIT_SLOTS
	call PlaySFX
	call WaitSFX
	call ClearBGPalettes
	ld hl, wOptions1
	res NO_TEXT_SCROLL, [hl]
	ld hl, rLCDC
	res 2, [hl] ; 8x8 sprites
	ret

.InitGFX:
	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
;	ld de, MUSIC_NONE
;	call PlayMusic
	call DelayFrame
	call DisableLCD
	hlbgcoord 0, 0
	ld bc, vBGMap1 - vBGMap0
	ld a, " "
	rst ByteFill
	ld a, CGB_SLOT_MACHINE
	call GetCGBLayout
	call ClearSpriteAnims
	ld hl, wSlots
	ld bc, wSlotsDataEnd - wSlots
	xor a
	rst ByteFill

	ld hl, Slots2LZ
	ld de, vTiles0 tile $00
	call Decompress

	ld hl, Slots3LZ
	ld de, vTiles0 tile $40
	call Decompress

	ld hl, Slots1LZ
	ld de, vTiles2 tile $00
	call Decompress

	ld hl, Slots2LZ
	ld de, vTiles2 tile $25
	call Decompress

	ld hl, SlotsTilemap
	decoord 0, 0
	ld bc, SCREEN_WIDTH * 12
	rst CopyBytes

	ld hl, rLCDC
	set 2, [hl] ; 8x16 sprites
	call EnableLCD
	ld hl, wSlots
	ld bc, wSlotsEnd - wSlots
	xor a
	rst ByteFill
	call InitReelTiles
	call Slots_GetPals
	ld a, $7
	ld hl, wSpriteAnimDict
	ld [hli], a
	ld [hl], $40
	xor a
	ld [wJumptableIndex], a
	ld a, SLOTS_NOMATCH
	ld [wSlotBias], a

;	ld de, MUSIC_GAME_CORNER
;	ld a, [wMapGroup]
;	cp GROUP_GOLDENROD_GAME_CORNER
;	jr nz, .celadon_game_corner
;	ld a, [wMapNumber]
;	cp MAP_GOLDENROD_GAME_CORNER
;	jr nz, .celadon_game_corner
;	ld de, MUSIC_GAME_CORNER_DPPT
;.celadon_game_corner
;	call PlayMusic

	xor a
	ld [wKeepSevenBiasChance], a
	call Random
	and %00101010
	ret nz
	ld a, $1
	ld [wKeepSevenBiasChance], a
	ret

Slots_GetPals:
	ld a, %11100100
	call DmgToCgbBGPals
	lb de, %11100100, %11100100
	jmp DmgToCgbObjPals

SlotsLoop:
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .stop
	ld hl, .Jumptable
	call JumpTable

	call Slots_SpinReels
	xor a
	ld [wCurSpriteOAMAddr], a
	farcall DoNextFrameForFirst16Sprites

	hlcoord 4, 1
	ld de, wCoins
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	call PrintNum
	hlcoord 11, 1
	ld de, wPayout
	lb bc, PRINTNUM_LEADINGZEROS | 2, 4
	call PrintNum

	call DelayFrame
	and a
	ret

.stop
	scf
	ret

.Jumptable:
	dw Slots_Init        ; 00
	dw Slots_BetAndStart ; 01
	dw Slots_WaitStart     ; 02
	dw Slots_WaitReel1   ; 03
	dw Slots_WaitStopReel1     ; 04
	dw Slots_WaitReel2   ; 05
	dw Slots_WaitStopReel2     ; 06
	dw Slots_WaitReel3   ; 07
	dw Slots_WaitStopReel3     ; 08
	dw Slots_Next          ; 09
	dw Slots_Next          ; 0a
	dw Slots_Next          ; 0b
	dw Slots_FlashIfWin     ; 0c
	dw Slots_FlashScreen     ; 0d
	dw Slots_GiveEarnedCoins     ; 0e
	dw Slots_PayoutTextAndAnim     ; 0f
	dw Slots_PayoutAnim     ; 10
	dw Slots_RestartOrQuit     ; 11
	dw Slots_Quit        ; 12

Slots_Next:
	ld hl, wJumptableIndex
	inc [hl]
	ret

Slots_Init:
	call Slots_Next
	xor a
	ld [wFirstTwoReelsMatching], a
	ld [wFirstTwoReelsMatchingSevens], a
	ld a, -1
	ld [wSlotMatched], a
	ret

Slots_BetAndStart:
	call Slots_AskBet
	jr nc, .proceed
	ld a, 18
	ld [wJumptableIndex], a
	ret

.proceed
	call Slots_Next
	call Slots_IlluminateBetLights
	call Slots_InitBias
	ld a, 32
	ld [wSlotsDelay], a
	ld a, 4
	ld [wReel1ReelAction], a
	ld [wReel2ReelAction], a
	ld [wReel3ReelAction], a
	ld a, $4
	ld [wReel1Slot09], a
	ld [wReel2Slot09], a
	ld [wReel3Slot09], a
	call WaitSFX
	ld a, SFX_SLOT_MACHINE_START
	jmp Slots_PlaySFX

Slots_WaitStart:
	ld hl, wSlotsDelay
	ld a, [hl]
	and a
	jr z, .proceed
	dec [hl]
	ret

.proceed
	call Slots_Next
	xor a
	ldh [hJoypadSum], a
	ret

Slots_WaitReel1:
	ld hl, hJoypadSum
	ld a, [hl]
	and A_BUTTON
	ret z
	call Slots_Next
	call Slots_StopReel1
	ld [wReel1ReelAction], a
Slots_WaitStopReel1:
	ld a, [wReel1ReelAction]
	and a
	ret nz
	ld a, SFX_STOP_SLOT
	call Slots_PlaySFX
	ld bc, wReel1
	ld de, wReel1Stopped
	call Slots_LoadReelState
	call Slots_Next
	xor a
	ldh [hJoypadSum], a
Slots_WaitReel2:
	ld hl, hJoypadSum
	ld a, [hl]
	and A_BUTTON
	ret z
	call Slots_Next
	call Slots_StopReel2
	ld [wReel2ReelAction], a
Slots_WaitStopReel2:
	ld a, [wReel2ReelAction]
	and a
	ret nz
	ld a, SFX_STOP_SLOT
	call Slots_PlaySFX
	ld bc, wReel2
	ld de, wReel2Stopped
	call Slots_LoadReelState
	call Slots_Next
	xor a
	ldh [hJoypadSum], a
Slots_WaitReel3:
	ld hl, hJoypadSum
	ld a, [hl]
	and A_BUTTON
	ret z
	call Slots_Next
	call Slots_StopReel3
	ld [wReel3ReelAction], a
Slots_WaitStopReel3:
	ld a, [wReel3ReelAction]
	and a
	ret nz
	ld a, SFX_STOP_SLOT
	call Slots_PlaySFX
	ld bc, wReel3
	ld de, wReel3Stopped
	call Slots_LoadReelState
	call Slots_Next
	xor a
	ldh [hJoypadSum], a
	ret

Slots_FlashIfWin:
	ld a, [wSlotMatched]
	cp -1
	jr nz, .GotIt
	call Slots_Next
	jmp Slots_Next

.GotIt:
	call Slots_Next
	ld a, 16
	ld [wSlotsDelay], a
Slots_FlashScreen:
	ld hl, wSlotsDelay
	ld a, [hl]
	and a
	jr z, .done
	dec [hl]
	srl a
	ret z

	ldh a, [rOBP0]
	cpl
	ld e, a
	ld d, a
	jmp DmgToCgbObjPals

.done
	call Slots_GetPals
	jmp Slots_Next

Slots_GiveEarnedCoins:
	xor a
	ld [wFirstTwoReelsMatching], a
	ld [wFirstTwoReelsMatchingSevens], a
	ld a, %11100100
	call DmgToCgbBGPals
	call SlotGetPayout
	xor a
	ld [wSlotsDelay], a
	jmp Slots_Next

Slots_PayoutTextAndAnim:
	call SlotPayoutText
	call Slots_Next
Slots_PayoutAnim:
	ld hl, wSlotsDelay
	ld a, [hl]
	inc [hl]
	and $1
	ret z
	ld hl, wPayout
	ld a, [hli]
	ld d, a
	or [hl]
	jmp z, Slots_Next
	ld e, [hl]
	dec de
	ld [hl], e
	dec hl
	ld [hl], d
	ld hl, wCoins
	ld d, [hl]
	inc hl
	ld e, [hl]
	call Slot_CheckCoinCaseFull
	jr c, .okay
	inc de
.okay
	ld [hl], e
	dec hl
	ld [hl], d
	ld a, [wSlotsDelay]
	and $7
	ret nz
	ld de, SFX_GET_COIN_FROM_SLOTS
	jmp PlaySFX

Slots_RestartOrQuit:
	call Slots_DeilluminateBetLights
	call WaitPressAorB_BlinkCursor
	call Slots_AskPlayAgain
	jr c, .exit_slots
	xor a
	ld [wJumptableIndex], a
	ret

.exit_slots
	ld a, 18
	ld [wJumptableIndex], a
	ret

Slots_Quit:
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

Slots_LoadReelState:
	push de
	call Slots_GetCurrentReelState
	pop de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ret

Slot_CheckCoinCaseFull:
	ld a, d
	cp HIGH(50000)
	jr c, .not_full
	ld a, e
	cp LOW(50000)
	jr c, .not_full
	scf
	ret

.not_full
	and a
	ret

Slots_GetCurrentReelState:
	ld hl, wReel1Position - wReel1
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .okay
	ld a, $f
.okay
	dec a
	and $f
	ld e, a
	ld d, $0
	ld hl, wReel1TilemapAddr - wReel1
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de
	ret

Slots_StopReel1:
	ld a, $7
	ret

Slots_StopReel2:
	ld a, [wSlotBet]
	cp $2
	jr c, .dont_jump
	ld a, [wSlotBias]
	and a
	jr z, .skip
	cp SLOTS_NOMATCH
	jr nz, .dont_jump
.skip
	call .CheckReel1ForASeven
	jr nz, .dont_jump
	call Random
	cp $50 ; 32%
	jr nc, .dont_jump
	ld a, $a
	ret

.dont_jump
	ld a, $8
	ret

.CheckReel1ForASeven:
	ld a, [wReel1Stopped]
	and a
	ret z
	ld a, [wReel1Stopped + 1]
	and a
	ret z
	ld a, [wReel1Stopped + 2]
	and a
	ret

Slots_StopReel3:
	ld a, [wFirstTwoReelsMatching]
	and a
	jr z, .stop
	ld a, [wFirstTwoReelsMatchingSevens]
	and a
	jr z, .stop
	ld a, [wSlotBias]
	and a
	jr nz, .biased
	call Random
	cp 180
	jr nc, .stop
	cp 120
	jr nc, .slow_advance
	cp 60
	jr nc, .golem
	ld a, $15
	ret

.biased
	call Random
	cp 160
	jr nc, .stop
	cp 80
	jr nc, .slow_advance
.golem
	ld a, $12
	ret

.slow_advance
	ld a, $10
	ret

.stop
	ld a, $9
	ret

InitReelTiles:
	ld bc, wReel1
	ld hl, wReel1OAMAddr - wReel1
	add hl, bc
	ld de, wVirtualOAM + 16 * 4
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, wReel1TilemapAddr - wReel1
	add hl, bc
	ld de, Reel1Tilemap
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, wReel1XCoord - wReel1
	add hl, bc
	ld [hl], 6 * 8
	call .OAM

	ld bc, wReel2
	ld hl, wReel1OAMAddr - wReel1
	add hl, bc
	ld de, wVirtualOAM + 24 * 4
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, wReel1TilemapAddr - wReel1
	add hl, bc
	ld de, Reel2Tilemap
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, wReel1XCoord - wReel1
	add hl, bc
	ld [hl], 10 * 8
	call .OAM

	ld bc, wReel3
	ld hl, wReel1OAMAddr - wReel1
	add hl, bc
	ld de, wVirtualOAM + 32 * 4
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, wReel1TilemapAddr - wReel1
	add hl, bc
	ld de, Reel3Tilemap
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, wReel1XCoord - wReel1
	add hl, bc
	ld [hl], 14 * 8
	; fallthrough

.OAM:
	ld hl, wReel1ReelAction - wReel1
	add hl, bc
	ld [hl], $0
	ld hl, wReel1Position - wReel1
	add hl, bc
	ld [hl], REEL_SIZE - 1
	ld hl, wReel1SpinDistance - wReel1
	add hl, bc
	ld [hl], $0
	jr UpdateReelPositionAndOAM

Slots_SpinReels:
	ld bc, wReel1
	call .SpinReel
	ld bc, wReel2
	call .SpinReel
	ld bc, wReel3
	; fallthrough

.SpinReel:
	ld hl, wReel1SpinDistance - wReel1
	add hl, bc
	ld a, [hl]
	and $f
	call z, ReelActionJumptable
	ld hl, wReel1SpinRate - wReel1
	add hl, bc
	ld a, [hl]
	and a
	ret z
	ld d, a
	ld hl, wReel1SpinDistance - wReel1
	add hl, bc
	add [hl]
	ld [hl], a
	and $f
	jr z, UpdateReelPositionAndOAM
	ld hl, wReel1OAMAddr - wReel1
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld e, $8
.loop
	ld a, [hl]
	add d
	ld [hli], a
	inc hl
	inc hl
	inc hl
	dec e
	jr nz, .loop
	ret

UpdateReelPositionAndOAM:
	ld hl, wReel1XCoord - wReel1
	add hl, bc
	ld a, [hl]
	ld [wCurReelXCoord], a
	ld a, 10 * 8
	ld [wCurReelYCoord], a
	ld hl, wReel1Position - wReel1
	add hl, bc
	ld e, [hl]
	ld d, 0
	ld hl, wReel1TilemapAddr - wReel1
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de
	ld e, l
	ld d, h
	call .LoadOAM
	ld hl, wReel1Position - wReel1
	add hl, bc
	ld a, [hl]
	inc a
	and $f
	cp REEL_SIZE
	jr nz, .load
	xor a
.load
	ld [hl], a
	ret

.LoadOAM:
	ld hl, wReel1OAMAddr - wReel1
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
.loop
	ld a, [wCurReelYCoord]
	ld [hli], a
	ld a, [wCurReelXCoord]
	ld [hli], a
	ld a, [de]
	ld [hli], a
	srl a
	srl a
	set 7, a
	ld [hli], a

	ld a, [wCurReelYCoord]
	ld [hli], a
	ld a, [wCurReelXCoord]
	add 1 * 8
	ld [hli], a
	ld a, [de]
	inc a
	inc a
	ld [hli], a
	srl a
	srl a
	set 7, a
	ld [hli], a
	inc de
	ld a, [wCurReelYCoord]
	sub 2 * 8
	ld [wCurReelYCoord], a
	cp 2 * 8
	jr nz, .loop
	ret

ReelActionJumptable:
	ld hl, wReel1ReelAction - wReel1
	add hl, bc
	ld a, [hl]
	call StackJumpTable

.Jumptable
	dw DoNothing                              ; 00
	dw Slots_StopReelIgnoreJoypad             ; 01
	dw ReelAction_QuadrupleRate               ; 02
	dw ReelAction_DoubleRate                  ; 03
	dw ReelAction_NormalRate                  ; 04
	dw ReelAction_HalfRate                    ; 05
	dw ReelAction_QuarterRate                 ; 06
	dw ReelAction_StopReel1                   ; 07
	dw ReelAction_StopReel2                   ; 08
	dw ReelAction_StopReel3                   ; 09
	dw ReelAction_SetUpReel2SkipTo7           ; 0a
	dw ReelAction_WaitReel2SkipTo7            ; 0b
	dw ReelAction_FastSpinReel2UntilLinedUp7s ; 0c
	dw ReelAction_BoringReelDrops             ; 0d
	dw ReelAction_CheckDropReel               ; 0e
	dw ReelAction_WaitDropReel                ; 0f
	dw ReelAction_StartSlowAdvanceReel3       ; 10
	dw ReelAction_WaitSlowAdvanceReel3        ; 11
	dw ReelAction_InitGolem                   ; 12
	dw ReelAction_WaitGolem                   ; 13
	dw ReelAction_EndGolem                    ; 14
	dw Slots_InitChansey                      ; 15
	dw ReelAction_WaitChansey                 ; 16
	dw ReelAction_WaitEgg                     ; 17
	dw ReelAction_DropReel                    ; 18

ReelAction_QuadrupleRate:
	ld hl, wReel1SpinRate - wReel1
	add hl, bc
	ld [hl], $10
	ret

ReelAction_DoubleRate:
	ld hl, wReel1SpinRate - wReel1
	add hl, bc
	ld [hl], $8
	ret

ReelAction_NormalRate:
	ld hl, wReel1SpinRate - wReel1
	add hl, bc
	ld [hl], $4
	ret

ReelAction_HalfRate:
	ld hl, wReel1SpinRate - wReel1
	add hl, bc
	ld [hl], $2
	ret

ReelAction_QuarterRate:
	ld hl, wReel1SpinRate - wReel1
	add hl, bc
	ld [hl], $1
	ret

Slots_StopReel:
	ld hl, wReel1SpinRate - wReel1
	add hl, bc
	ld [hl], $0
	ld hl, wReel1ReelAction - wReel1
	add hl, bc
	ld [hl], $1
	ld hl, wReel1Slot0f - wReel1
	add hl, bc
	ld [hl], $3
Slots_StopReelIgnoreJoypad:
	ld hl, wReel1Slot0f - wReel1
	add hl, bc
	ld a, [hl]
	and a
	jr z, .EndReel
	dec [hl]
	ret

.EndReel:
	ld hl, wReel1ReelAction - wReel1
	add hl, bc
	xor a
	ld [hl], a
	ret

ReelAction_StopReel1:
	ld a, [wSlotBias]
	cp SLOTS_NOMATCH
	jr z, Slots_StopReel
	ld hl, wReel1Slot09 - wReel1
	add hl, bc
	ld a, [hl]
	and a
	jr z, Slots_StopReel
	dec [hl]
	call .CheckForBias
	ret nz
	jr Slots_StopReel

.CheckForBias:
	call Slots_GetCurrentReelState
	ld a, [wSlotBias]
	ld e, a
	ld a, [hli]
	cp e
	ret z
	ld a, [hli]
	cp e
	ret z
	ld a, [hl]
	cp e
	ret

ReelAction_StopReel2:
	call Slots_CheckMatchedFirstTwoReels
	jr nc, .nope
	ld a, [wSlotBuildingMatch]
	ld hl, wSlotBias
	cp [hl]
	jr z, Slots_StopReel
.nope
	ld a, [wSlotBias]
	cp SLOTS_NOMATCH
	jr z, Slots_StopReel
	ld hl, wReel1Slot09 - wReel1
	add hl, bc
	ld a, [hl]
	and a
	jr z, Slots_StopReel
	dec [hl]
	ret

ReelAction_StopReel3:
	call Slots_CheckMatchedAllThreeReels
	jr nc, .NoMatch
	ld hl, wSlotBias
	cp [hl]
	jr z, .NoBias
	ld hl, wReel1Slot09 - wReel1
	add hl, bc
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ret

.NoMatch:
	ld a, [wSlotBias]
	cp SLOTS_NOMATCH
	jr z, .NoBias
	ld hl, wReel1Slot09 - wReel1
	add hl, bc
	ld a, [hl]
	and a
	jr z, .NoBias
	dec [hl]
	ret

.NoBias:
	jmp Slots_StopReel

ReelAction_SetUpReel2SkipTo7:
	call Slots_CheckMatchedFirstTwoReels
	jr nc, .no_match
	ld a, [wFirstTwoReelsMatchingSevens]
	and a
	jmp nz, Slots_StopReel

.no_match
	ld a, SFX_STOP_SLOT
	call Slots_PlaySFX
	ld hl, wReel1ReelAction - wReel1
	add hl, bc
	inc [hl]
	ld hl, wReel1Slot0a - wReel1
	add hl, bc
	ld [hl], $20
	ld hl, wReel1SpinRate - wReel1
	add hl, bc
	ld [hl], $0
	ret

ReelAction_WaitReel2SkipTo7:
	ld hl, wReel1Slot0a - wReel1
	add hl, bc
	ld a, [hl]
	and a
	jr z, .ready
	dec [hl]
	ret

.ready
	ld a, SFX_THROW_BALL
	call Slots_PlaySFX
	ld hl, wReel1ReelAction - wReel1
	add hl, bc
	inc [hl]
	ld hl, wReel1SpinRate - wReel1
	add hl, bc
	ld [hl], $8
	ret

ReelAction_FastSpinReel2UntilLinedUp7s:
	call Slots_CheckMatchedFirstTwoReels
	ret nc
	ld a, [wFirstTwoReelsMatchingSevens]
	and a
	ret z
	jmp Slots_StopReel

ReelAction_InitGolem:
	call Slots_CheckMatchedAllThreeReels
	ret c
	ld a, SFX_STOP_SLOT
	call Slots_PlaySFX
	call Slots_WaitSFX
	ld hl, wReel1ReelAction - wReel1
	add hl, bc
	inc [hl]
	ld hl, wReel1SpinRate - wReel1
	add hl, bc
	ld [hl], $0
	call Slots_GetNumberOfGolems
	push bc
	push af
	depixel 12, 13
	ld a, SPRITE_ANIM_INDEX_SLOTS_GOLEM
	call _InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_VAR3
	add hl, bc
	pop af
	ld [hl], a
	pop bc
	xor a
	ld [wSlotsDelay], a
ReelAction_WaitGolem:
	ld a, [wSlotsDelay]
	cp 2
	jr z, .two
	cp 1
	jr z, .one
	ret

.two
	call Slots_CheckMatchedAllThreeReels
	jmp Slots_StopReel

.one
	ld hl, wReel1ReelAction - wReel1
	add hl, bc
	inc [hl]
	ld hl, wReel1SpinRate - wReel1
	add hl, bc
	ld [hl], $8
	ret

ReelAction_EndGolem:
	xor a
	ld [wSlotsDelay], a
	ld hl, wReel1ReelAction - wReel1
	add hl, bc
	dec [hl]
	ld hl, wReel1SpinRate - wReel1
	add hl, bc
	ld [hl], $0
	ret

Slots_InitChansey:
	call Slots_CheckMatchedAllThreeReels
	ret c
	ld a, SFX_STOP_SLOT
	call Slots_PlaySFX
	call Slots_WaitSFX
	ld hl, wReel1ReelAction - wReel1
	add hl, bc
	inc [hl]
	ld hl, wReel1SpinRate - wReel1
	add hl, bc
	ld [hl], $0
	push bc
	depixel 12, 0
	ld a, SPRITE_ANIM_INDEX_SLOTS_CHANSEY
	call _InitSpriteAnimStruct
	pop bc
	xor a
	ld [wSlotsDelay], a
	ret

ReelAction_WaitChansey:
	ld a, [wSlotsDelay]
	and a
	ret z
	ld hl, wReel1ReelAction - wReel1
	add hl, bc
	inc [hl]
	ld a, $2
	ld [wSlotsDelay], a
ReelAction_WaitEgg:
	ld a, [wSlotsDelay]
	cp $4
	ret c
	ld hl, wReel1ReelAction - wReel1
	add hl, bc
	inc [hl]
	ld hl, wReel1SpinRate - wReel1
	add hl, bc
	ld [hl], $10
	ld hl, wReel1Slot0a - wReel1
	add hl, bc
	ld [hl], $11
ReelAction_DropReel:
	ld hl, wReel1Slot0a - wReel1
	add hl, bc
	ld a, [hl]
	and a
	jr z, .check_match
	dec [hl]
	ret

.check_match
	call Slots_CheckMatchedAllThreeReels
	jr nc, .EggAgain
	and a
	jr nz, .EggAgain
	ld a, $5
	ld [wSlotsDelay], a
	jmp Slots_StopReel

.EggAgain:
	ld hl, wReel1SpinRate - wReel1
	add hl, bc
	ld [hl], $0
	ld hl, wReel1ReelAction - wReel1
	add hl, bc
	dec [hl]
	dec [hl]
	ld a, $1
	ld [wSlotsDelay], a
	ret

ReelAction_BoringReelDrops:
	call Slots_CheckMatchedAllThreeReels
	ret c
	ld a, SFX_STOP_SLOT
	call Slots_PlaySFX
	call Slots_WaitSFX
	ld hl, wReel1ReelAction - wReel1
	add hl, bc
	inc [hl]
	call Slots_GetNumberOfGolems
	ld hl, wReel1Slot0a - wReel1
	add hl, bc
	ld [hl], a
ReelAction_CheckDropReel:
	ld hl, wReel1Slot0a - wReel1
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .spin
	call Slots_CheckMatchedAllThreeReels
	jmp Slots_StopReel

.spin
	dec [hl]
	ld hl, wReel1ReelAction - wReel1
	add hl, bc
	inc [hl]
	ld hl, wReel1Slot0b - wReel1
	add hl, bc
	ld [hl], $20
	ld hl, wReel1SpinRate - wReel1
	add hl, bc
	ld [hl], $0
ReelAction_WaitDropReel:
	ld hl, wReel1Slot0b - wReel1
	add hl, bc
	ld a, [hl]
	and a
	jr z, .DropReel
	dec [hl]
	ret

.DropReel:
	ld hl, wReel1ReelAction - wReel1
	add hl, bc
	dec [hl]
	ld hl, wReel1SpinRate - wReel1
	add hl, bc
	ld [hl], $8 ; 2x
	ret

ReelAction_StartSlowAdvanceReel3:
	call Slots_CheckMatchedAllThreeReels
	ret c
	ld a, SFX_STOP_SLOT
	call Slots_PlaySFX
	call Slots_WaitSFX
	ld hl, wReel1SpinRate - wReel1
	add hl, bc
	ld [hl], $1
	ld hl, wReel1ReelAction - wReel1
	add hl, bc
	inc [hl]
	ld hl, wReel1Slot0a - wReel1
	add hl, bc
	ld [hl], $10
ReelAction_WaitSlowAdvanceReel3:
	ld hl, wReel1Slot0a - wReel1
	add hl, bc
	ld a, [hl]
	and a
	jr z, .check1
	dec [hl]
.play_sfx
	ld a, SFX_GOT_SAFARI_BALLS
	jmp Slots_PlaySFX

.check1
	ld a, [wSlotBias]
	and a
	jr nz, .check2
	call Slots_CheckMatchedAllThreeReels
	jr nc, .play_sfx
	and a
	jr nz, .play_sfx
	call Slots_StopReel
	jmp WaitSFX

.check2
	call Slots_CheckMatchedAllThreeReels
	jr c, .play_sfx
	call Slots_StopReel
	jmp WaitSFX

Slots_CheckMatchedFirstTwoReels:
	xor a
	ld [wFirstTwoReelsMatching], a
	ld [wFirstTwoReelsMatchingSevens], a
	call Slots_GetCurrentReelState
	call Slots_CopyReelState
	ld a, [wSlotBet]
	and 3
	ld e, a
	ld d, 0
	ld hl, .Jumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call _hl_
	ld a, [wFirstTwoReelsMatching]
	and a
	ret z
	scf
	ret

.Jumptable:
	dw DoNothing
	dw .one
	dw .two
	dw .three

.three
	call .CheckUpwardsDiag
	call .CheckDownwardsDiag
.two
	call .CheckBottomRow
	call .CheckTopRow
.one ; no-optimize stub jump
	jr .CheckMiddleRow

.CheckBottomRow:
	ld hl, wCurReelStopped
	ld a, [wReel1Stopped]
	cp [hl]
	call z, .StoreResult
	ret

.CheckUpwardsDiag:
	ld hl, wCurReelStopped + 1
	ld a, [wReel1Stopped]
	cp [hl]
	call z, .StoreResult
	ret

.CheckMiddleRow:
	ld hl, wCurReelStopped + 1
	ld a, [wReel1Stopped + 1]
	cp [hl]
	call z, .StoreResult
	ret

.CheckDownwardsDiag:
	ld hl, wCurReelStopped + 1
	ld a, [wReel1Stopped + 2]
	cp [hl]
	call z, .StoreResult
	ret

.CheckTopRow:
	ld hl, wCurReelStopped + 2
	ld a, [wReel1Stopped + 2]
	cp [hl]
	call z, .StoreResult
	ret

.StoreResult:
	ld [wSlotBuildingMatch], a
	and a
	jr nz, .matching_sevens
	ld a, $1
	ld [wFirstTwoReelsMatchingSevens], a

.matching_sevens
	ld a, $1
	ld [wFirstTwoReelsMatching], a
	ret

Slots_CheckMatchedAllThreeReels:
	ld a, $ff
	ld [wSlotMatched], a
	call Slots_GetCurrentReelState
	call Slots_CopyReelState
	ld a, [wSlotBet]
	and 3
	ld e, a
	ld d, 0
	ld hl, .Jumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call _hl_
	ld a, [wSlotMatched]
	cp $ff
	jr nz, .matched_nontrivial
	and a
	ret

.matched_nontrivial
	scf
	ret

.Jumptable:
	dw DoNothing
	dw .one
	dw .two
	dw .three

.three
	call .CheckUpwardsDiag
	call .CheckDownwardsDiag
.two
	call .CheckBottomRow
	call .CheckTopRow
.one ; no-optimize stub jump
	jr .CheckMiddleRow

.CheckBottomRow:
	ld hl, wCurReelStopped
	ld a, [wReel1Stopped]
	cp [hl]
	ret nz
	ld hl, wReel2Stopped
	cp [hl]
	call z, .StoreResult
	ret

.CheckUpwardsDiag:
	ld hl, wCurReelStopped + 2
	ld a, [wReel1Stopped]
	cp [hl]
	ret nz
	ld hl, wReel2Stopped + 1
	cp [hl]
	call z, .StoreResult
	ret

.CheckMiddleRow:
	ld hl, wCurReelStopped + 1
	ld a, [wReel1Stopped + 1]
	cp [hl]
	ret nz
	ld hl, wReel2Stopped + 1
	cp [hl]
	call z, .StoreResult
	ret

.CheckDownwardsDiag:
	ld hl, wCurReelStopped
	ld a, [wReel1Stopped + 2]
	cp [hl]
	ret nz
	ld hl, wReel2Stopped + 1
	cp [hl]
	call z, .StoreResult
	ret

.CheckTopRow:
	ld hl, wCurReelStopped + 2
	ld a, [wReel1Stopped + 2]
	cp [hl]
	ret nz
	ld hl, wReel2Stopped + 2
	cp [hl]
	call z, .StoreResult
	ret

.StoreResult:
	ld [wSlotMatched], a
	ret

Slots_CopyReelState:
	ld de, wCurReelStopped
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	ret

Slots_GetNumberOfGolems:
	ld hl, wReel1Position - wReel1
	add hl, bc
	ld a, [hl]
	push af
	push hl
	call .Check7Bias
	pop hl
	pop af
	ld [hl], a
	ld a, e
	ret

.Check7Bias:
	ld a, [wSlotBias]
	and a
	jr nz, .not_biased_to_seven
	ld e, a
.loop1
	ld hl, wReel1Position - wReel1
	add hl, bc
	inc [hl]
	inc e
	push de
	call Slots_CheckMatchedAllThreeReels
	pop de
	jr nc, .loop1
	and a
	jr nz, .loop1
	ret

.not_biased_to_seven
	call Random
	and $7
	cp $4 ; ((50 percent) & 7) + 1
	jr c, .not_biased_to_seven
	ld e, a
.loop2
	ld a, e
	inc e
	ld hl, wReel1Position - wReel1
	add hl, bc
	add [hl]
	ld [hl], a
	push de
	call Slots_CheckMatchedAllThreeReels
	pop de
	jr c, .loop2
	ret

Slots_InitBias:
	ld a, [wSlotBias]
	and a
	ret z
	ld hl, .Normal
	ldh a, [hScriptVar]
	and a
	jr z, .okay
	ld hl, .Lucky
.okay
	call Random
	ld c, a
.loop
	ld a, [hli]
	cp c
	jr nc, .done
	inc hl
	jr .loop

.done
	ld a, [hl]
	ld [wSlotBias], a
	ret

.Normal:
	db $01, SLOTS_SEVEN    ; 1/256
	db $03, SLOTS_POKEBALL ; 1/128
	db $0a, SLOTS_STARYU   ; 7/256
	db $14, SLOTS_SQUIRTLE ; 5/128
	db $28, SLOTS_PIKACHU  ; 5/64
	db $30, SLOTS_CHERRY   ; 1/32
	db $ff, SLOTS_NOMATCH  ; everything else

.Lucky:
	db $02, SLOTS_SEVEN    ;  1/128
	db $03, SLOTS_POKEBALL ;  1/256
	db $08, SLOTS_STARYU   ;  5/256
	db $10, SLOTS_SQUIRTLE ;  1/32
	db $1e, SLOTS_PIKACHU  ;  7/128
	db $50, SLOTS_CHERRY   ; 25/128
	db $ff, SLOTS_NOMATCH  ; everything else

Slots_IlluminateBetLights:
	ld b, $14 ; turned on
	ld a, [wSlotBet]
	dec a
	jr z, Slots_Lights1OnOff
	dec a
	jr z, Slots_Lights2OnOff
	jr Slots_Lights3OnOff

Slots_DeilluminateBetLights:
	ld b, $23 ; turned off
Slots_Lights3OnOff:
	hlcoord 3, 2
	call Slots_TurnLightsOnOrOff
	hlcoord 3, 10
	call Slots_TurnLightsOnOrOff
Slots_Lights2OnOff:
	hlcoord 3, 4
	call Slots_TurnLightsOnOrOff
	hlcoord 3, 8
	call Slots_TurnLightsOnOrOff
Slots_Lights1OnOff:
	hlcoord 3, 6

Slots_TurnLightsOnOrOff:
	ld a, b
	ld [hl], a
	ld de, SCREEN_WIDTH / 2 + 3
	add hl, de
	ld [hl], a
	ld de, SCREEN_WIDTH / 2 - 3
	add hl, de
	inc a
	ld [hl], a
	ld de, SCREEN_WIDTH / 2 + 3
	add hl, de
	ld [hl], a
	ret

Slots_AskBet:
.loop
	ld hl, .Text_BetHowManyCoins
	call PrintText
	ld hl, .MenuDataHeader
	call LoadMenuHeader
	call VerticalMenu
	call CloseWindow
	ret c
	ld a, [wMenuCursorY]
	cpl
	add 4 + 1 ; a = 4 - a
	ld [wSlotBet], a
	ld hl, wCoins
	ld c, a
	ld a, [hli]
	and a
	jr nz, .Start
	ld a, [hl]
	cp c
	jr nc, .Start
	ld hl, .Text_NotEnoughCoins
	call PrintText
	jr .loop

.Start:
	ld hl, wCoins + 1
	ld a, [hl]
	sub c
	ld [hld], a
	jr nc, .ok
	dec [hl]
.ok
	call WaitSFX
	ld de, SFX_PAY_DAY
	call PlaySFX
	ld hl, .Text_Start
	call PrintText
	and a
	ret

.Text_BetHowManyCoins:
	; Bet how many coins?
	text_far _SlotsBetHowManyCoinsText
	text_end

.Text_Start:
	; Start!
	text_far _SlotsStartText
	text_end

.Text_NotEnoughCoins:
	; Not enough coins.
	text_far _SlotsNotEnoughCoinsText
	text_end

.MenuDataHeader:
	db $40 ; flags
	db 10, 14 ; start coords
	db 17, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 3 ; items
	db " 3@"
	db " 2@"
	db " 1@"

Slots_AskPlayAgain:
	ld hl, wCoins
	ld a, [hli]
	or [hl]
	jr nz, .you_have_coins
	ld hl, .Text_OutOfCoins
	call PrintText
	ld c, 60
	call DelayFrames
	jr .exit_slots

.you_have_coins
	ld hl, .Text_PlayAgain
	call PrintText
	call LoadMenuTextbox
	lb bc, 14, 12
	call PlaceYesNoBox
	ld a, [wMenuCursorY]
	dec a
	call CloseWindow
	and a
	jr nz, .exit_slots
	and a
	ret

.exit_slots
	scf
	ret

.Text_OutOfCoins:
	text_far _SlotsRanOutOfCoinsText
	text_end

.Text_PlayAgain:
	text_far _SlotsPlayAgainText
	text_end

SlotGetPayout:
	ld a, [wSlotMatched]
	cp -1
	jr z, .no_win
	srl a
	ld e, a
	ld d, 0
	ld hl, .PayoutTable
	add hl, de
	ld a, [hli]
	ld [wPayout + 1], a
	ld e, a
	ld a, [hl]
	ld [wPayout], a
	ld d, a
	ret

.PayoutTable:
	dw 300
	dw  50
	dw   6
	dw   8
	dw  10
	dw  15

.no_win
	ld hl, wPayout
	xor a
	ld [hli], a
	ld [hl], a
	ret

SlotPayoutText:
	ld a, [wSlotMatched]
	cp -1
	jr nz, .MatchedSomething
	ld hl, .Text_Darn
	jmp PrintText

.MatchedSomething:
	srl a
	ld e, a
	ld d, 0
	ld hl, .PayoutStrings
	add hl, de
	add hl, de
	add hl, de
	ld de, wStringBuffer2
	ld bc, 4
	rst CopyBytes
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call _hl_
	ld hl, .Text_PrintPayout
	jmp PrintText

.PayoutStrings:
	dbw "300@", .LinedUpSevens
	dbw "50@@", .LinedUpPokeballs
	dbw "6@@@", .LinedUpMonOrCherry
	dbw "8@@@", .LinedUpMonOrCherry
	dbw "10@@", .LinedUpMonOrCherry
	dbw "15@@", .LinedUpMonOrCherry

.Text_PrintPayout:
	text_asm
	ld a, [wSlotMatched]
	add $25
	ldcoord_a 2, 13
	inc a
	ldcoord_a 2, 14
	inc a
	ldcoord_a 3, 13
	inc a
	ldcoord_a 3, 14
	hlcoord 18, 17
	ld [hl], "▼"
	ld hl, .Text_LinedUpWonCoins
rept 4
	inc bc
endr
	ret

.Text_LinedUpWonCoins:
	; lined up! Won @  coins!
	text_far _SlotsLinedUpText
	text_end

.Text_Darn:
	; Darn!
	text_far _SlotsDarnText
	text_end

; Oddly, the rarest mode (wKeepSevenBiasChance = 1) is the one with
; the worse odds to favor seven symbol streaks (12.5% vs 25%).
; it's possible that either the wKeepSevenBiasChance initialization
; or this code was intended to lead to flipped percentages.
.LinedUpSevens:
	ld a, SFX_2ND_PLACE
	call Slots_PlaySFX
	call WaitSFX
	ld a, [wKeepSevenBiasChance]
	and a
	jr nz, .lower_seven_streak_odds
	call Random
	and $14
	ret z
	ld a, $ff
	ld [wSlotBias], a
	ret

.lower_seven_streak_odds
	call Random
	and $1c
	ret z
	ld a, $ff
	ld [wSlotBias], a
	ret

.LinedUpPokeballs:
	ld a, SFX_3RD_PLACE
	call Slots_PlaySFX
	jmp WaitSFX

.LinedUpMonOrCherry:
	ld a, SFX_PRESENT
	call Slots_PlaySFX
	jmp WaitSFX

SlotMachine_AnimateGolem:
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld a, [hl]
	call StackJumpTable

.Jumptable:
	dw .init
	dw .fall
	dw .roll

.init
	ld hl, SPRITEANIMSTRUCT_VAR3
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .retain
	ld a, $2
	ld [wSlotsDelay], a
	ld hl, SPRITEANIMSTRUCT_INDEX
	add hl, bc
	ld [hl], $0
	ret

.retain
	dec [hl]
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	inc [hl]
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $30
	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], $0

.fall
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cp $20
	jr c, .play_sound
	dec [hl]
	ld d, 14 * 8
	call Sine
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ret

.play_sound
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	inc [hl]
	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], $2
	ld a, $1
	ld [wSlotsDelay], a
	ld a, SFX_PLACE_PUZZLE_PIECE_DOWN
	jmp Slots_PlaySFX

.roll
	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld a, [hl]
	inc [hl]
	inc [hl]
	cp 9 * 8
	jr nc, .restart
	and $3
	ret nz
	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	cpl
	inc a
	ld [hl], a
	ldh [hSCY], a
	ret

.restart
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	xor a
	ld [hl], a
	ldh [hSCY], a
	ret

Slots_AnimateChansey:
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld a, [hl]
	call StackJumpTable

.Jumptable:
	dw .walk
	dw .one
	dw .two

.walk
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	inc [hl]
	cp 13 * 8
	jr z, .limit
	and $f
	ret nz
	ld de, SFX_JUMP_OVER_LEDGE
	jmp PlaySFX

.limit
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	inc [hl]
	ld a, $1
	ld [wSlotsDelay], a

.one
	ld a, [wSlotsDelay]
	cp $2
	jr z, .retain
	cp $5
	ret nz
	ld hl, SPRITEANIMSTRUCT_INDEX
	add hl, bc
	ld [hl], $0
	ret

.retain
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	inc [hl]
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $8
.two
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	and a
	jr z, .spawn_egg
	dec [hl]
	ret

.spawn_egg
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	dec [hl]
	push bc
	depixel 12, 13, 0, 4
	ld a, SPRITE_ANIM_INDEX_SLOTS_EGG
	call _InitSpriteAnimStruct
	pop bc
	ret

Slots_WaitSFX:
	push bc
	ld c, 16
	call DelayFrames
	pop bc
	ret

Slots_PlaySFX:
	push de
	ld e, a
	ld d, 0
	call PlaySFX
	pop de
	ret

; The first three positions are repeated to
; avoid needing to check indices when copying.
Reel1Tilemap:
	db SLOTS_SEVEN    ;  0
	db SLOTS_CHERRY   ;  1
	db SLOTS_STARYU   ;  2
	db SLOTS_PIKACHU  ;  3
	db SLOTS_SQUIRTLE ;  4
	db SLOTS_SEVEN    ;  5
	db SLOTS_CHERRY   ;  6
	db SLOTS_STARYU   ;  7
	db SLOTS_PIKACHU  ;  8
	db SLOTS_SQUIRTLE ;  9
	db SLOTS_POKEBALL ; 10
	db SLOTS_CHERRY   ; 11
	db SLOTS_STARYU   ; 12
	db SLOTS_PIKACHU  ; 13
	db SLOTS_SQUIRTLE ; 14
	db SLOTS_SEVEN    ;  0
	db SLOTS_CHERRY   ;  1
	db SLOTS_STARYU   ;  2

Reel2Tilemap:
	db SLOTS_SEVEN    ;  0
	db SLOTS_PIKACHU  ;  1
	db SLOTS_CHERRY   ;  2
	db SLOTS_SQUIRTLE ;  3
	db SLOTS_STARYU   ;  4
	db SLOTS_POKEBALL ;  5
	db SLOTS_PIKACHU  ;  6
	db SLOTS_CHERRY   ;  7
	db SLOTS_SQUIRTLE ;  8
	db SLOTS_STARYU   ;  9
	db SLOTS_POKEBALL ; 10
	db SLOTS_PIKACHU  ; 11
	db SLOTS_CHERRY   ; 12
	db SLOTS_SQUIRTLE ; 13
	db SLOTS_STARYU   ; 14
	db SLOTS_SEVEN    ;  0
	db SLOTS_PIKACHU  ;  1
	db SLOTS_CHERRY   ;  2

Reel3Tilemap:
	db SLOTS_SEVEN    ;  0
	db SLOTS_PIKACHU  ;  1
	db SLOTS_CHERRY   ;  2
	db SLOTS_SQUIRTLE ;  3
	db SLOTS_STARYU   ;  4
	db SLOTS_PIKACHU  ;  5
	db SLOTS_CHERRY   ;  6
	db SLOTS_SQUIRTLE ;  7
	db SLOTS_STARYU   ;  8
	db SLOTS_PIKACHU  ;  9
	db SLOTS_POKEBALL ; 10
	db SLOTS_CHERRY   ; 11
	db SLOTS_SQUIRTLE ; 12
	db SLOTS_STARYU   ; 13
	db SLOTS_PIKACHU  ; 14
	db SLOTS_SEVEN    ;  0
	db SLOTS_PIKACHU  ;  1
	db SLOTS_CHERRY   ;  2

SlotsTilemap:
INCBIN "gfx/slots/slots.tilemap"

Slots1LZ:
INCBIN "gfx/slots/slots_1.2bpp.lz"

Slots2LZ:
INCBIN "gfx/slots/slots_2.2bpp.lz"

Slots3LZ:
INCBIN "gfx/slots/slots_3.2bpp.lz"
