TradeAnimation:
	xor a
	ld [wcf66], a
	ld hl, wPlayerTrademonSenderName
	ld de, wOTTrademonSenderName
	call LinkTradeAnim_LoadTradePlayerNames
	ld hl, wLinkTradeSendmonData
	ld bc, wPlayerTrademonSpecies
	ld de, wPlayerTrademonPersonality
	call LinkTradeAnim_LoadTradeMonData
	ld hl, wLinkTradeGetmonData
	ld bc, wOTTrademonSpecies
	ld de, wOTTrademonPersonality
	call LinkTradeAnim_LoadTradeMonData
	ld de, .script
	jr RunTradeAnimSequence

.script
	tradeanim_setup_givemon_scroll
	tradeanim_show_givemon_data
	tradeanim_do_givemon_scroll
	tradeanim_wait_80
	tradeanim_wait_96
	tradeanim_poof
	tradeanim_rocking_ball
	tradeanim_enter_link_tube
	tradeanim_wait_anim
	tradeanim_bulge_through_tube
	tradeanim_wait_anim
	tradeanim_textbox_scroll
	tradeanim_give_trademon_sfx
	tradeanim_tube_to_ot
	tradeanim_sent_to_ot_text
	tradeanim_scroll_out_right

	tradeanim_ot_sends_text_1
	tradeanim_ot_bids_farewell
	tradeanim_wait_40
	tradeanim_scroll_out_right
	tradeanim_get_trademon_sfx
	tradeanim_tube_to_player
	tradeanim_enter_link_tube
	tradeanim_drop_ball
	tradeanim_exit_link_tube
	tradeanim_wait_anim
	tradeanim_show_getmon_data
	tradeanim_poof
	tradeanim_wait_anim
	tradeanim_frontpic_scroll
	tradeanim_animate_frontpic
	tradeanim_wait_80_if_ot_egg
	tradeanim_textbox_scroll
	tradeanim_take_care_of_text
	tradeanim_scroll_out_right
	tradeanim_end

TradeAnimationPlayer2:
	xor a
	ld [wcf66], a
	ld hl, wOTTrademonSenderName
	ld de, wPlayerTrademonSenderName
	call LinkTradeAnim_LoadTradePlayerNames
	ld hl, wLinkTradeGetmonData
	ld bc, wPlayerTrademonSpecies
	ld de, wPlayerTrademonPersonality
	call LinkTradeAnim_LoadTradeMonData
	ld hl, wLinkTradeSendmonData
	ld bc, wOTTrademonSpecies
	ld de, wOTTrademonPersonality
	call LinkTradeAnim_LoadTradeMonData
	ld de, .script
	jr RunTradeAnimSequence

.script
	tradeanim_ot_sends_text_2
	tradeanim_ot_bids_farewell
	tradeanim_wait_40
	tradeanim_scroll_out_right
	tradeanim_get_trademon_sfx
	tradeanim_tube_to_ot
	tradeanim_enter_link_tube
	tradeanim_drop_ball
	tradeanim_exit_link_tube
	tradeanim_wait_anim
	tradeanim_show_getmon_data
	tradeanim_poof
	tradeanim_wait_anim
	tradeanim_frontpic_scroll
	tradeanim_animate_frontpic
	tradeanim_wait_180_if_ot_egg
	tradeanim_textbox_scroll
	tradeanim_take_care_of_text
	tradeanim_scroll_out_right

	tradeanim_setup_givemon_scroll
	tradeanim_show_givemon_data
	tradeanim_do_givemon_scroll
	tradeanim_wait_40
	tradeanim_poof
	tradeanim_rocking_ball
	tradeanim_enter_link_tube
	tradeanim_wait_anim
	tradeanim_bulge_through_tube
	tradeanim_wait_anim
	tradeanim_textbox_scroll
	tradeanim_give_trademon_sfx
	tradeanim_tube_to_player
	tradeanim_sent_to_ot_text
	tradeanim_scroll_out_right
	tradeanim_end

RunTradeAnimSequence:
	ld hl, wTradeAnimPointer
	ld [hl], e
	inc hl
	ld [hl], d
	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hMapAnims], a
	ld hl, wVramState
	ld a, [hl]
	push af
	res 0, [hl] ; overworld sprite updating on
	ld hl, wOptions1
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	call .TradeAnimLayout
	ld a, [wcf66]
	and a
	jr nz, .anim_loop
	ld de, MUSIC_EVOLUTION
	call PlayMusic2
.anim_loop
	call DoTradeAnimation
	jr nc, .anim_loop
	pop af
	ld [wOptions1], a
	pop af
	ld [wVramState], a
	pop af
	ldh [hMapAnims], a
	ret

.TradeAnimLayout:
	xor a
	ld [wJumptableIndex], a
	call ClearBGPalettes
	call ClearSprites
	call ClearTileMap
	call DisableLCD
	call LoadFontsBattleExtra
	call ClearSpriteAnims
	ld a, $1
	ldh [rVBK], a
	ld hl, vTiles0
	ld bc, sScratch - vTiles0
	xor a
	rst ByteFill
	xor a
	ldh [rVBK], a
	hlbgcoord 0, 0
	ld bc, sScratch - vBGMap0
	ld a, " "
	rst ByteFill
	ld hl, TradeGameBoyLZ
	ld de, vTiles2 tile $31
	call Decompress
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	ld a, $7
	ldh [hWX], a
	ld a, $90
	ldh [hWY], a
	farcall GetTrademonFrontpic
	call EnableLCD
	call LoadTradeBallAndCableGFX
	ld a, [wPlayerTrademonSpecies]
	ld hl, wPlayerTrademonForm
	ld de, vTiles0
	call TradeAnim_GetFrontpic
	ld a, [wOTTrademonSpecies]
	ld hl, wOTTrademonForm
	ld de, vTiles0 tile $31
	call TradeAnim_GetFrontpic
	ld a, [wPlayerTrademonSpecies]
	ld de, wPlayerTrademonSpeciesName
	call TradeAnim_GetNickname
	ld a, [wOTTrademonSpecies]
	ld de, wOTTrademonSpeciesName
	call TradeAnim_GetNickname
	jp TradeAnim_NormalPals

DoTradeAnimation:
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .finished
	call .DoTradeAnimCommand
	farcall PlaySpriteAnimations
	ld hl, wcf65
	inc [hl]
	call DelayFrame
	and a
	ret

.finished
	call LoadStandardFont
	scf
	ret

.DoTradeAnimCommand:
	call StandardStackJumpTable

.Jumptable:
	dw TradeAnim_AdvanceScriptPointer ; 00
	dw TradeAnim_ShowGivemonData      ; 01
	dw TradeAnim_ShowGetmonData       ; 02
	dw TradeAnim_EnterLinkTube1       ; 03
	dw TradeAnim_EnterLinkTube2       ; 04
	dw TradeAnim_ExitLinkTube         ; 05
	dw TradeAnim_TubeToOT1            ; 06
	dw TradeAnim_TubeToOT2            ; 07
	dw TradeAnim_TubeToOT3            ; 08
	dw TradeAnim_TubeToOT4            ; 09
	dw TradeAnim_TubeToOT5            ; 0a
	dw TradeAnim_TubeToOT6            ; 0b
	dw TradeAnim_TubeToOT7            ; 0c
	dw TradeAnim_TubeToOT8            ; 0d
	dw TradeAnim_TubeToPlayer1        ; 0e
	dw TradeAnim_TubeToPlayer2        ; 0f
	dw TradeAnim_TubeToPlayer3        ; 10
	dw TradeAnim_TubeToPlayer4        ; 11
	dw TradeAnim_TubeToPlayer5        ; 12
	dw TradeAnim_TubeToPlayer6        ; 13
	dw TradeAnim_TubeToPlayer7        ; 14
	dw TradeAnim_TubeToPlayer8        ; 15
	dw TradeAnim_SentToOTText         ; 16
	dw TradeAnim_OTBidsFarewell       ; 17
	dw TradeAnim_TakeCareOfText       ; 18
	dw TradeAnim_OTSendsText1         ; 19
	dw TradeAnim_OTSendsText2         ; 1a
	dw TradeAnim_SetupGivemonScroll   ; 1b
	dw TradeAnim_DoGivemonScroll      ; 1c
	dw TradeAnim_FrontpicScrollStart  ; 1d
	dw TradeAnim_TextboxScrollStart   ; 1e
	dw TradeAnim_ScrollOutRight       ; 1f
	dw TradeAnim_ScrollOutRight2      ; 20
	dw TraideAnim_Wait80              ; 21
	dw TraideAnim_Wait40              ; 22
	dw TradeAnim_RockingBall          ; 23
	dw TradeAnim_DropBall             ; 24
	dw TradeAnim_WaitAnim             ; 25
	dw TradeAnim_WaitAnim2            ; 26
	dw TradeAnim_Poof                 ; 27
	dw TradeAnim_BulgeThroughTube     ; 28
	dw TradeAnim_GiveTrademonSFX      ; 29
	dw TradeAnim_GetTrademonSFX       ; 2a
	dw TradeAnim_End                  ; 2b
	dw TradeAnim_AnimateFrontpic      ; 2c
	dw TraideAnim_Wait96              ; 2d
	dw TraideAnim_Wait80IfOTEgg       ; 2e
	dw TraideAnim_Wait180IfOTEgg      ; 2f

TradeAnim_IncrementJumptableIndex:
	ld hl, wJumptableIndex
	inc [hl]
	ret

TradeAnim_AdvanceScriptPointer:
	ld hl, wTradeAnimPointer
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld a, [de]
	ld [wJumptableIndex], a
	inc de
	ld [hl], d
	dec hl
	ld [hl], e
	ret

TradeAnim_End:
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

TradeAnim_TubeToOT1:
	ld a, $59 ; right arrow
	call TradeAnim_PlaceTrademonStatsOnTubeAnim
	ld a, [wLinkTradeSendmonSpecies]
	ld [wd265], a
	ld hl, wLinkTradeSendmonPersonality
	xor a
	depixel 5, 11, 4, 0
	ld b, $0
	jr TradeAnim_InitTubeAnim

TradeAnim_TubeToPlayer1:
	ld a, $5a ; left arrow
	call TradeAnim_PlaceTrademonStatsOnTubeAnim
	ld a, [wLinkTradeGetmonSpecies]
	ld [wd265], a
	ld hl, wLinkTradeGetmonPersonality
	ld a, $2
	depixel 9, 18, 4, 4
	ld b, $4
TradeAnim_InitTubeAnim:
	push bc
	push de
	push bc
	push de

	push hl ; wLinkTradeSendmonPersonality or wLinkTradeGetmonPersonality

	push af
	call DisableLCD
	call ClearSpriteAnims
	hlbgcoord 20, 3
	ld bc, 12
	ld a, $5d
	rst ByteFill
	pop af

	call TradeAnim_TubeAnimJumptable

	xor a
	ldh [hSCX], a
	ld a, $7
	ldh [hWX], a
	ld a, $70
	ldh [hWY], a
	call EnableLCD
	call DelayFrame

	pop hl ; wLinkTradeSendmonPersonality or wLinkTradeGetmonPersonality
	inc hl
	ld a, [hld]
	ld [wCurIconForm], a
	farcall LoadTradeAnimationMonIcon

	call LoadTradeBubbleGFX

	pop de
	ld a, SPRITE_ANIM_INDEX_TRADEMON_ICON
	call _InitSpriteAnimStruct

	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	pop bc
	ld [hl], b

	pop de
	ld a, SPRITE_ANIM_INDEX_TRADEMON_BUBBLE
	call _InitSpriteAnimStruct

	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	pop bc
	ld [hl], b

	call ApplyTilemapInVBlank
	ld a, CGB_TRADE_TUBE
	call GetCGBLayout
	ld a, %11100100 ; 3,2,1,0
	call DmgToCgbBGPals
	ld a, %11010000
	call DmgToCgbObjPal0

	call TradeAnim_IncrementJumptableIndex
	ld a, $5c
	ld [wcf64], a
	ret

TradeAnim_TubeToOT2:
	call TradeAnim_FlashBGPals
	ldh a, [hSCX]
	add $2
	ldh [hSCX], a
	cp $50
	ret nz
	ld a, $1
	call TradeAnim_TubeAnimJumptable
	jp TradeAnim_IncrementJumptableIndex

TradeAnim_TubeToOT3:
	call TradeAnim_FlashBGPals
	ldh a, [hSCX]
	add $2
	ldh [hSCX], a
	cp $a0
	ret nz
	ld a, $2
	call TradeAnim_TubeAnimJumptable
	jp TradeAnim_IncrementJumptableIndex

TradeAnim_TubeToOT4:
	call TradeAnim_FlashBGPals
	ldh a, [hSCX]
	add $2
	ldh [hSCX], a
	and a
	ret nz
	jp TradeAnim_IncrementJumptableIndex

TradeAnim_TubeToPlayer3:
	call TradeAnim_FlashBGPals
	ldh a, [hSCX]
	sub $2
	ldh [hSCX], a
	cp $b0
	ret nz
	ld a, $1
	call TradeAnim_TubeAnimJumptable
	jp TradeAnim_IncrementJumptableIndex

TradeAnim_TubeToPlayer4:
	call TradeAnim_FlashBGPals
	ldh a, [hSCX]
	sub $2
	ldh [hSCX], a
	cp $60
	ret nz
	xor a
	call TradeAnim_TubeAnimJumptable
	jp TradeAnim_IncrementJumptableIndex

TradeAnim_TubeToPlayer5:
	call TradeAnim_FlashBGPals
	ldh a, [hSCX]
	sub $2
	ldh [hSCX], a
	and a
	ret nz
	jp TradeAnim_IncrementJumptableIndex

TradeAnim_TubeToOT6:
TradeAnim_TubeToPlayer6:
	ld a, $80
	ld [wcf64], a
	jp TradeAnim_IncrementJumptableIndex

TradeAnim_TubeToOT8:
TradeAnim_TubeToPlayer8:
	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
	call DisableLCD
	call ClearSpriteAnims
	hlbgcoord 0, 0
	ld bc, sScratch - vBGMap0
	ld a, " "
	rst ByteFill
	xor a
	ldh [hSCX], a
	ld a, $90
	ldh [hWY], a
	call EnableLCD
	call LoadTradeBallAndCableGFX
	call ApplyTilemapInVBlank
	call TradeAnim_NormalPals
	jp TradeAnim_AdvanceScriptPointer

TradeAnim_TubeToOT5:
TradeAnim_TubeToOT7:
TradeAnim_TubeToPlayer2:
TradeAnim_TubeToPlayer7:
	call TradeAnim_FlashBGPals
	ld hl, wcf64
	ld a, [hl]
	and a
	jp z, TradeAnim_IncrementJumptableIndex
	dec [hl]
	ret

TradeAnim_GiveTrademonSFX:
	call TradeAnim_AdvanceScriptPointer
	ld de, SFX_GIVE_TRADEMON
	jp PlaySFX

TradeAnim_GetTrademonSFX:
	call TradeAnim_AdvanceScriptPointer
	ld de, SFX_GET_TRADEMON
	jp PlaySFX

TradeAnim_TubeAnimJumptable:
	and 3
	call StackJumpTable

.Jumptable:
	dw .Zero
	dw .One
	dw .Two
	dw .Three

.Zero:
.Three:
	call TradeAnim_BlankTileMap
	hlcoord 9, 3
	ld [hl], $5c
	inc hl
	ld bc, 10
	ld a, $5d
	rst ByteFill
	hlcoord 3, 2
	jr TradeAnim_CopyTradeGameBoyTilemap

.One:
	call TradeAnim_BlankTileMap
	hlcoord 0, 3
	ld bc, SCREEN_WIDTH
	ld a, $5d
	rst ByteFill
	ret

.Two:
	call TradeAnim_BlankTileMap
	hlcoord 0, 3
	ld bc, $11
	ld a, $5d
	rst ByteFill
	hlcoord 17, 3
	ld [hl], $58

	ld a, $5b
	ld de, SCREEN_WIDTH
	ld c, $3
.loop
	add hl, de
	ld [hl], a
	dec c
	jr nz, .loop

	add hl, de
	ld a, $5e
	ld [hld], a
	ld [hl], $5c
	hlcoord 10, 6
	; fallthrough

TradeAnim_CopyTradeGameBoyTilemap:
	ld de, TradeGameBoyTilemap
	lb bc, 8, 6
	jp TradeAnim_CopyBoxFromDEtoHL

TradeAnim_PlaceTrademonStatsOnTubeAnim:
	push af
	call ClearBGPalettes
	call WaitTop
	ld a, HIGH(vBGMap1)
	ldh [hBGMapAddress + 1], a
	call ClearTileMap
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH
	ld a, "─"
	rst ByteFill
	hlcoord 0, 1
	ld de, wLinkPlayer1Name
	rst PlaceString
	ld hl, wLinkPlayer2Name
	ld de, 0
.find_name_end_loop
	ld a, [hli]
	cp "@"
	jr z, .done
	dec de
	jr .find_name_end_loop

.done
	hlcoord 0, 4
	add hl, de
	ld de, wLinkPlayer2Name
	rst PlaceString
	hlcoord 7, 2
	ld bc, 6
	pop af
	rst ByteFill
	call ApplyTilemapInVBlank
	call WaitTop
	ld a, HIGH(vBGMap0)
	ldh [hBGMapAddress + 1], a
	jp ClearTileMap

TradeAnim_EnterLinkTube1:
	call ClearTileMap
	call WaitTop
	ld a, $a0
	ldh [hSCX], a
	call DelayFrame
	hlcoord 8, 2
	ld de, TradeLinkTubeTilemap
	lb bc, 3, 12
	call TradeAnim_CopyBoxFromDEtoHL
	call ApplyTilemapInVBlank
	ld a, CGB_TRADE_TUBE
	call GetCGBLayout
	ld a, %11100100 ; 3,2,1,0
	call DmgToCgbBGPals
	lb de, %11100100, %11100100 ; 3,2,1,0, 3,2,1,0
	call DmgToCgbObjPals
	ld de, SFX_POTION
	call PlaySFX
	jp TradeAnim_IncrementJumptableIndex

TradeAnim_EnterLinkTube2:
	ldh a, [hSCX]
	and a
	jr z, .done
	add $4
	ldh [hSCX], a
	ret

.done
	ld c, 80
	call DelayFrames
	jp TradeAnim_AdvanceScriptPointer

TradeAnim_ExitLinkTube:
	ldh a, [hSCX]
	cp $a0
	jr z, .done
	sub $4
	ldh [hSCX], a
	ret

.done
	call ClearTileMap
	xor a
	ldh [hSCX], a
	jp TradeAnim_AdvanceScriptPointer

TradeAnim_SetupGivemonScroll:
	ld a, $8f
	ldh [hWX], a
	ld a, $88
	ldh [hSCX], a
	ld a, $50
	ldh [hWY], a
	jp TradeAnim_AdvanceScriptPointer

TradeAnim_DoGivemonScroll:
	ldh a, [hWX]
	cp $7
	jr z, .done
	sub $4
	ldh [hWX], a
	ldh a, [hSCX]
	sub $4
	ldh [hSCX], a
	ret

.done
	ld a, $7
	ldh [hWX], a
	xor a
	ldh [hSCX], a
	jp TradeAnim_AdvanceScriptPointer

TradeAnim_FrontpicScrollStart:
	ld a, $7
	ldh [hWX], a
	ld a, $50
	ldh [hWY], a
	jp TradeAnim_AdvanceScriptPointer

TradeAnim_TextboxScrollStart:
	ld a, $7
	ldh [hWX], a
	ld a, $90
	ldh [hWY], a
	jp TradeAnim_AdvanceScriptPointer

TradeAnim_ScrollOutRight:
	call WaitTop
	ld a, HIGH(vBGMap1)
	ldh [hBGMapAddress + 1], a
	call ApplyTilemapInVBlank
	ld a, $7
	ldh [hWX], a
	xor a
	ldh [hWY], a
	call DelayFrame
	call WaitTop
	ld a, HIGH(vBGMap0)
	ldh [hBGMapAddress + 1], a
	call ClearTileMap
	jp TradeAnim_IncrementJumptableIndex

TradeAnim_ScrollOutRight2:
	ldh a, [hWX]
	cp $a1
	jr nc, .done
	add $4
	ldh [hWX], a
	ret

.done
	ld a, HIGH(vBGMap1)
	ldh [hBGMapAddress + 1], a
	call ApplyTilemapInVBlank
	ld a, $7
	ldh [hWX], a
	ld a, $90
	ldh [hWY], a
	ld a, HIGH(vBGMap0)
	ldh [hBGMapAddress + 1], a
	jp TradeAnim_AdvanceScriptPointer

TradeAnim_ShowGivemonData:
	call ShowPlayerTrademonStats
	ld a, [wPlayerTrademonSpecies]
	ld [wCurPartySpecies], a
	ld a, [wPlayerTrademonPersonality]
	ld [wTempMonPersonality], a
	ld a, [wPlayerTrademonPersonality + 1]
	ld [wTempMonPersonality + 1], a
	ld a, CGB_PLAYER_OR_MON_FRONTPIC_PALS
	call GetCGBLayout
	ld a, %11100100 ; 3,2,1,0
	call DmgToCgbBGPals
	call TradeAnim_ShowGivemonFrontpic

	ld a, [wPlayerTrademonSpecies]
	call GetCryIndex
	jr c, .skip_cry
	ld e, c
	ld d, b
	call PlayCryHeader
.skip_cry

	jp TradeAnim_AdvanceScriptPointer

TradeAnim_ShowGetmonData:
	call ShowOTTrademonStats
	ld a, [wOTTrademonSpecies]
	ld [wCurPartySpecies], a
	ld a, [wOTTrademonPersonality]
	ld [wTempMonPersonality], a
	ld a, [wOTTrademonPersonality + 1]
	ld [wTempMonPersonality + 1], a
	ld a, CGB_PLAYER_OR_MON_FRONTPIC_PALS
	call GetCGBLayout
	ld a, %11100100 ; 3,2,1,0
	call DmgToCgbBGPals
	call TradeAnim_ShowGetmonFrontpic
	jp TradeAnim_AdvanceScriptPointer

TradeAnim_AnimateFrontpic:
	farcall AnimateTrademonFrontpic
	jp TradeAnim_AdvanceScriptPointer

TradeAnim_GetFrontpic:
	push de
	push af
	predef GetVariant
	pop af
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	call GetBaseData
	pop de
	predef_jump GetFrontpic

TradeAnim_GetNickname:
	push de
	ld [wd265], a
	call GetPokemonName
	ld hl, wStringBuffer1
	pop de
	ld bc, NAME_LENGTH
	rst CopyBytes
	ret

TradeAnim_ShowGivemonFrontpic:
	ld de, vTiles0
	jr TradeAnim_ShowFrontpic

TradeAnim_ShowGetmonFrontpic:
	ld de, vTiles0 tile $31
TradeAnim_ShowFrontpic:
	call DelayFrame
	ld hl, vTiles2
	lb bc, 10, $31
	call Request2bpp
	call WaitTop
	call TradeAnim_BlankTileMap
	hlcoord 7, 2
	xor a
	ldh [hGraphicStartTile], a
	lb bc, 7, 7
	predef PlaceGraphic
	jp ApplyTilemapInVBlank

TraideAnim_Wait80:
	ld c, 80
	call DelayFrames
	jp TradeAnim_AdvanceScriptPointer

TraideAnim_Wait40:
	ld c, 40
	call DelayFrames
	jp TradeAnim_AdvanceScriptPointer

TraideAnim_Wait96:
	ld c, 96
	call DelayFrames
	jp TradeAnim_AdvanceScriptPointer

TraideAnim_Wait80IfOTEgg:
	call IsOTTrademonEgg
	ret z
	ld c, 80
	jp DelayFrames

TraideAnim_Wait180IfOTEgg:
	call IsOTTrademonEgg
	ret z
	ld c, 180
	jp DelayFrames

IsOTTrademonEgg:
	call TradeAnim_AdvanceScriptPointer
	ld a, [wOTTrademonIsEgg]
	bit MON_IS_EGG_F, a
	ret
ShowPlayerTrademonStats:
	ld de, wPlayerTrademonIsEgg
	ld a, [de]
	bit MON_IS_EGG_F, a
	ld de, wPlayerTrademonSpecies
	jr nz, TrademonStats_Egg
	call TrademonStats_MonTemplate
	ld de, wPlayerTrademonSpecies
	call TrademonStats_PrintSpeciesNumber
	ld de, wPlayerTrademonSpeciesName
	call TrademonStats_PrintSpeciesName
	ld a, [wPlayerTrademonCaughtData]
	ld de, wPlayerTrademonOTName
	call TrademonStats_PrintOTName
	ld de, wPlayerTrademonID
	call TrademonStats_PrintTrademonID
	jp TrademonStats_WaitBGMap

ShowOTTrademonStats:
	ld de, wOTTrademonIsEgg
	ld a, [de]
	bit MON_IS_EGG_F, a
	ld de, wOTTrademonSpecies
	jr nz, TrademonStats_Egg
	call TrademonStats_MonTemplate
	ld de, wOTTrademonSpecies
	call TrademonStats_PrintSpeciesNumber
	ld de, wOTTrademonSpeciesName
	call TrademonStats_PrintSpeciesName
	ld a, [wOTTrademonCaughtData]
	ld de, wOTTrademonOTName
	call TrademonStats_PrintOTName
	ld de, wOTTrademonID
	call TrademonStats_PrintTrademonID
	jp TrademonStats_WaitBGMap

TrademonStats_MonTemplate:
	call WaitTop
	call TradeAnim_BlankTileMap
	ld a, HIGH(vBGMap1)
	ldh [hBGMapAddress + 1], a
	hlcoord 3, 0
	lb bc, $6, $d
	call Textbox
	hlcoord 4, 0
	ld de, .OTMonData
	rst PlaceString
	ret

.OTMonData:
	db   "─── №."
	next ""
	next "OT/"
	next "<ID>№.@"

TrademonStats_Egg:
	call WaitTop
	call TradeAnim_BlankTileMap
	ld a, HIGH(vBGMap1)
	ldh [hBGMapAddress + 1], a
	hlcoord 3, 0
	lb bc, $6, $d
	call Textbox
	hlcoord 4, 2
	ld de, .EggData
	rst PlaceString
	jp TrademonStats_WaitBGMap

.EggData:
	db   "Egg"
	next "OT/?????"
	next "<ID>№.?????@"

TrademonStats_WaitBGMap:
	call ApplyTilemapInVBlank
	call WaitTop
	ld a, HIGH(vBGMap0)
	ldh [hBGMapAddress + 1], a
	ret

TrademonStats_PrintSpeciesNumber:
	hlcoord 10, 0
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	ld [hl], " "
	ret

TrademonStats_PrintSpeciesName:
	hlcoord 4, 2
	rst PlaceString
	ret

TrademonStats_PrintOTName:
	cp 3
	jr c, .caught_gender_okay
	xor a
.caught_gender_okay
	push af
	hlcoord 7, 4
	rst PlaceString
	inc bc
	pop af
	ld hl, .Gender
	ld d, 0
	ld e, a
	add hl, de
	ld a, [hl]
	ld [bc], a
	ret

.Gender:
	db " ", "♂", "♀"

TrademonStats_PrintTrademonID:
	hlcoord 7, 6
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	jp PrintNum

TradeAnim_RockingBall:
	depixel 10, 11, 4, 0
	ld a, SPRITE_ANIM_INDEX_TRADE_POKE_BALL
	call _InitSpriteAnimStruct
	call TradeAnim_AdvanceScriptPointer
	ld a, $20
	ld [wcf64], a
	ret

TradeAnim_DropBall:
	depixel 10, 11, 4, 0
	ld a, SPRITE_ANIM_INDEX_TRADE_POKE_BALL
	call _InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], $1
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], $dc
	call TradeAnim_AdvanceScriptPointer
	ld a, $38
	ld [wcf64], a
	ret

TradeAnim_Poof:
	depixel 10, 11, 4, 0
	ld a, SPRITE_ANIM_INDEX_TRADE_POOF
	call _InitSpriteAnimStruct
	call TradeAnim_AdvanceScriptPointer
	ld a, $10
	ld [wcf64], a
	ld de, SFX_BALL_POOF
	jp PlaySFX

TradeAnim_BulgeThroughTube:
	ld a, %11100100 ; 3,2,1,0
	call DmgToCgbObjPal0
	depixel 5, 11
	ld a, SPRITE_ANIM_INDEX_TRADE_TUBE_BULGE
	call _InitSpriteAnimStruct
	call TradeAnim_AdvanceScriptPointer
	ld a, $40
	ld [wcf64], a
	ret

TradeAnim_AnimateTrademonInTube:
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld a, [hl]
	call StackJumpTable

.Jumptable:
	dw .InitTimer
	dw .WaitTimer1
	dw .MoveRight
	dw .MoveDown
	dw .MoveUp
	dw .MoveLeft
	dw .WaitTimer2

.JumptableNext:
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	inc [hl]
	ret

.InitTimer:
	call .JumptableNext
	ld hl, SPRITEANIMSTRUCT_0C
	add hl, bc
	ld [hl], $80
	ret

.WaitTimer1:
	ld hl, SPRITEANIMSTRUCT_0C
	add hl, bc
	ld a, [hl]
	dec [hl]
	and a
	ret nz
	call .JumptableNext

.MoveRight:
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $94
	jr nc, .done_move_right
	inc [hl]
	ret
.done_move_right
	call .JumptableNext

.MoveDown:
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	cp $4c
	jr nc, .done_move_down
	inc [hl]
	ret
.done_move_down
	ld hl, SPRITEANIMSTRUCT_INDEX
	add hl, bc
	ld [hl], $0
	ret

.MoveUp:
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	cp $2c
	jr z, .done_move_up
	dec [hl]
	ret
.done_move_up
	call .JumptableNext

.MoveLeft:
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $58
	jr z, .done_move_left
	dec [hl]
	ret
.done_move_left
	call .JumptableNext
	ld hl, SPRITEANIMSTRUCT_0C
	add hl, bc
	ld [hl], $80
	ret

.WaitTimer2:
	ld hl, SPRITEANIMSTRUCT_0C
	add hl, bc
	ld a, [hl]
	dec [hl]
	and a
	ret nz
	ld hl, SPRITEANIMSTRUCT_INDEX
	add hl, bc
	ld [hl], $0
	ret

TradeAnim_SentToOTText:
	ld hl, .Text_MonName
	call PrintText
	ld c, 189
	call DelayFrames
	ld hl, .Text_WasSentTo
	call PrintText
	call TradeAnim_Wait80Frames
	ld c, 128
	call DelayFrames
	jp TradeAnim_AdvanceScriptPointer

.Text_WasSentTo:
	; was sent to @ .
	text_jump UnknownText_0x1bc6e9
	text_end

.Text_MonName:
	;
	text_jump ClearText
	text_end

TradeAnim_OTBidsFarewell:
	ld hl, .Text_BidsFarewellToMon
	call PrintText
	call TradeAnim_Wait80Frames
	ld hl, .Text_MonName
	call PrintText
	call TradeAnim_Wait80Frames
	jp TradeAnim_AdvanceScriptPointer

.Text_BidsFarewellToMon:
	; bids farewell to
	text_jump UnknownText_0x1bc703
	text_end

.Text_MonName:
	; .
	text_jump UnknownText_0x1bc719
	text_end

TradeAnim_TakeCareOfText:
	call WaitTop
	hlcoord 0, 10
	ld bc, 8 * SCREEN_WIDTH
	ld a, " "
	rst ByteFill
	call ApplyTilemapInVBlank
	ld hl, .Text_TakeGoodCareOfMon
	call PrintText
	call TradeAnim_Wait80Frames
	jp TradeAnim_AdvanceScriptPointer

.Text_TakeGoodCareOfMon:
	; Take good care of @ .
	text_jump UnknownText_0x1bc71f
	text_end

TradeAnim_OTSendsText1:
	ld hl, .Text_ForYourMon
	call PrintText
	call TradeAnim_Wait80Frames
	ld hl, .Text_OTSends
	call PrintText
	call TradeAnim_Wait80Frames
	ld c, 14
	call DelayFrames
	jp TradeAnim_AdvanceScriptPointer

.Text_ForYourMon:
	; For @ 's @ ,
	text_jump UnknownText_0x1bc739
	text_end

.Text_OTSends:
	; sends @ .
	text_jump UnknownText_0x1bc74c
	text_end

TradeAnim_OTSendsText2:
	ld hl, .Text_WillTrade
	call PrintText
	call TradeAnim_Wait80Frames
	ld hl, .Text_ForYourMon
	call PrintText
	call TradeAnim_Wait80Frames
	ld c, 14
	call DelayFrames
	jp TradeAnim_AdvanceScriptPointer

.Text_WillTrade:
	; will trade @ @
	text_jump UnknownText_0x1bc75e
	text_end

.Text_ForYourMon:
	; for @ 's @ .
	text_jump UnknownText_0x1bc774
	text_end

TradeAnim_Wait80Frames:
	ld c, 80
	jp DelayFrames

TradeAnim_BlankTileMap:
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, " "
	rst ByteFill
	ret

TradeAnim_CopyBoxFromDEtoHL:
.row
	push bc
	push hl
.col
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .col
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .row
	ret

TradeAnim_NormalPals:
	ld a, %11100100 ; 3,2,1,0
	call DmgToCgbObjPal0
	ld a, %11100100 ; 3,2,1,0
	jp DmgToCgbBGPals

LinkTradeAnim_LoadTradePlayerNames:
	push de
	ld de, wLinkPlayer1Name
	ld bc, NAME_LENGTH
	rst CopyBytes
	pop hl
	ld de, wLinkPlayer2Name
	ld bc, NAME_LENGTH
	rst CopyBytes
	ret

LinkTradeAnim_LoadTradeMonData:
	; bc = species, de = shiny, de+1 = form
	ld a, [bc]
	ld [hli], a
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	and FORM_MASK
	ld [hl], a
	ret

TradeAnim_FlashBGPals:
	ld a, [wcf65]
	and $7
	ret nz
	ldh a, [rBGP]
	xor %00111100
	jp DmgToCgbBGPals

LoadTradeBallAndCableGFX:
	call DelayFrame
	ld hl, TradeBallPoofCableGFX
	ld de, vTiles0 tile $62
	lb bc, BANK(TradeBallPoofCableGFX), 20
	call DecompressRequest2bpp
	xor a
	ld hl, wSpriteAnimDict
	ld [hli], a
	ld [hl], $62
	ret

LoadTradeBubbleGFX:
	ld de, TradeBubbleGFX
	ld hl, vTiles0 tile $72
	lb bc, BANK(TradeBubbleGFX), $4
	call Request2bpp
	xor a
	ld hl, wSpriteAnimDict
	ld [hli], a
	ld [hl], $62
	ret

TradeAnim_WaitAnim:
	ld hl, wcf64
	ld a, [hl]
	and a
	jp z, TradeAnim_AdvanceScriptPointer
	dec [hl]
	ret

TradeAnim_WaitAnim2:
	ld hl, wcf64
	ld a, [hl]
	and a
	jp z, TradeAnim_AdvanceScriptPointer
	dec [hl]
	ret

TradeGameBoyTilemap: ; 6x8
INCBIN "gfx/trade/game_boy.tilemap"

TradeLinkTubeTilemap: ; 12x3
INCBIN "gfx/trade/link_cable.tilemap"

TradeBallPoofCableGFX:  INCBIN "gfx/trade/ball_poof_cable.2bpp.lz"
TradeBubbleGFX: INCBIN "gfx/trade/bubble.2bpp"
TradeGameBoyLZ: INCBIN "gfx/trade/game_boy_cable.2bpp.lz"
