LoadMobileTradePalettes:
	ld hl, MobileTradeBorderPalettes
	ld de, wBGPals1
	ld bc, 8 palettes
	call FarCopyColorWRAM
	ld hl, MobileTradeLightsPalettes
	ld de, wOBPals1
	ld bc, 4 palettes
	call FarCopyColorWRAM
	farcall ApplyPals
	jmp SetDefaultBGPAndOBP

LoadMobileTradeScreenGFX:
	ld hl, MobileTradeScreenGFX
	ld de, vTiles2
	lb bc, BANK(MobileTradeScreenGFX), 41
	call DecompressRequest2bpp
	ld hl, MobileTradeLightsGFX
	ld de, vTiles0
	lb bc, BANK(MobileTradeLightsGFX), 4
	jmp DecompressRequest2bpp

DoNextStepForMobileTradeLights:
	ld a, [wMobileLightsTimer]
	and %1111111
	jr nz, .done
	ld a, $01
	ldh [hOAMUpdate], a
	call ClearSprites
	ld de, wShadowOAM
	call UpdateMobileTradeLights
	ld hl, wMobileLightsFlags
	bit MOBILE_LIGHTS_CYCLE_DOWN_F, [hl]
	jr nz, .cycle_down
	ld a, [wMobileLightsStep]
	inc a
	cp $2c
	ld [wMobileLightsStep], a
	jr z, .init_cycle_down

.done
	ld hl, wMobileLightsTimer
	dec [hl]
	xor a
	ldh [hOAMUpdate], a
	ret

.init_cycle_down
	ld hl, wMobileLightsFlags
	set MOBILE_LIGHTS_CYCLE_DOWN_F, [hl]
	jr .done

.cycle_down
	ld hl, wMobileLightsStep
	dec [hl]
	jr nz, .done
; fallthrough
.init_cycle_up
	ld hl, wMobileLightsFlags
	res MOBILE_LIGHTS_CYCLE_DOWN_F, [hl]
	jr .done

UpdateMobileTradeLights:
	ld a, [wMobileLightsStep]
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ld bc, MobileTradeLightSteps
	add hl, bc
	lb bc, $30, $08
.loop
	xor a
	add [hl]
	inc hl
	push hl

	add a
	add a

	add LOW(Unknown_10327a)
	ld l, a
	adc HIGH(Unknown_10327a)
	sub l
	ld h, a

	ld a, b
	add [hl]
	inc hl
	ld [de], a
	inc de
	ld a, $0a
	add [hl]
	inc hl
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	pop hl
	ld a, b
	add $08
	ld b, a
	dec c
	jr nz, .loop
	ret

MobileTradeLightSteps:
	db $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00
	db $01, $00, $00, $00, $00, $00, $00, $00
	db $02, $01, $00, $00, $00, $00, $00, $00
	db $03, $02, $01, $00, $00, $00, $00, $00
	db $04, $03, $02, $01, $00, $00, $00, $00
	db $04, $04, $03, $02, $01, $00, $00, $00
	db $04, $04, $04, $03, $02, $01, $00, $00
	db $04, $04, $04, $04, $03, $02, $01, $00
	db $04, $04, $04, $04, $04, $03, $02, $01
	db $04, $04, $04, $04, $04, $04, $03, $02
	db $04, $04, $04, $04, $04, $04, $04, $03
	db $04, $04, $04, $04, $04, $04, $04, $04
	db $04, $04, $04, $04, $04, $04, $04, $04
	db $04, $04, $04, $04, $04, $04, $04, $04
	db $04, $04, $04, $04, $04, $04, $04, $04
	db $04, $04, $04, $04, $04, $04, $04, $04
	db $04, $04, $04, $04, $04, $04, $04, $04
	db $04, $04, $04, $04, $04, $04, $04, $04
	db $04, $04, $04, $04, $04, $04, $04, $04
	db $03, $04, $04, $04, $04, $04, $04, $04
	db $02, $03, $04, $04, $04, $04, $04, $04
	db $01, $02, $03, $04, $04, $04, $04, $04
	db $00, $01, $02, $03, $04, $04, $04, $04
	db $00, $00, $01, $02, $03, $04, $04, $04
	db $00, $00, $00, $01, $02, $03, $04, $04
	db $00, $00, $00, $00, $01, $02, $03, $04
	db $00, $00, $00, $00, $00, $01, $02, $03
	db $00, $00, $00, $00, $00, $00, $01, $02
	db $00, $00, $00, $00, $00, $00, $00, $01
	db $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00, $00

Unknown_10327a:
	db $00, $00, $00, $00
	db $00, $00, $01, $00
	db $00, $00, $02, $00
	db $00, $00, $03, $00
	db $00, $00, $01, $01
	db $00, $00, $00, $00
	db $00, $00, $01, $02
	db $00, $00, $02, $02
	db $00, $00, $03, $02
	db $00, $00, $01, $03

MobileTradeAnimation:
	xor a
	ld [wUnusedTradeAnimPlayEvolutionMusic], a
	ld hl, wPlayerTrademonSenderName
	ld de, wOTTrademonSenderName
	call MobileLinkTradeAnim_LoadTradePlayerNames
	ld hl, wLinkTradeSendmonData
	ld bc, wPlayerTrademonSpecies
	ld de, wPlayerTrademonPersonality
	call MobileLinkTradeAnim_LoadTradeMonData
	ld hl, wLinkTradeGetmonData
	ld bc, wOTTrademonSpecies
	ld de, wOTTrademonPersonality
	call MobileLinkTradeAnim_LoadTradeMonData
	ld de, .script
	jr RunMobileTradeAnimSequence

.script
	mobiletradeanim_showplayermontobesent
	mobiletradeanim_fadetoblack
	mobiletradeanim_02
	mobiletradeanim_givetrademon1
	mobiletradeanim_05
	mobiletradeanim_gettrademon1
	mobiletradeanim_showotmonfromtrade
	mobiletradeanim_end

RunMobileTradeAnimSequence:
	ld hl, wTradeAnimPointer
	ld a, e
	ld [hli], a
	ld [hl], d
	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hMapAnims], a
	ld hl, wStateFlags
	ld a, [hl]
	push af
	res SPRITE_UPDATES_DISABLED_F, [hl]
	ld hl, wOptions1
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	call .TradeAnimLayout
	ld a, [wUnusedTradeAnimPlayEvolutionMusic] ; TODO: figure out what can be removed if this is unused (presumably this and next 2 lines)
	and a
	jr nz, .anim_loop
	ld e, MUSIC_EVOLUTION
	call PlayMusic2
.anim_loop
	call DoMobileTradeAnimation
	jr nc, .anim_loop
	pop af
	ld [wOptions1], a
	pop af
	ld [wStateFlags], a
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
	ld bc, STARTOF(VRAM) + SIZEOF(VRAM) - vTiles0
	xor a
	rst ByteFill
	xor a
	ldh [rVBK], a
	hlbgcoord 0, 0
	ld bc, STARTOF(VRAM) + SIZEOF(VRAM) - vBGMap0
	ld a, " "
	rst ByteFill
	ld hl, MobileTradeGameBoyLZ
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
	call MobileLoadTradeBallAndCableGFX
	ld a, [wPlayerTrademonSpecies]
	ld hl, wPlayerTrademonForm
	ld de, vTiles0
	call MobileTradeAnim_GetFrontpic
	ld a, [wOTTrademonSpecies]
	ld hl, wOTTrademonForm
	ld de, vTiles0 tile $31
	call MobileTradeAnim_GetFrontpic
	ld a, [wPlayerTrademonForm]
	ld b, a
	ld a, [wPlayerTrademonSpecies] ; not loading into c since we're loading into wNamedObjectIndex anyway
	ld de, wPlayerTrademonSpeciesName
	call MobileTradeAnim_GetNickname
	ld a, [wOTTrademonForm]
	ld b, a
	ld a, [wOTTrademonSpecies]
	ld de, wOTTrademonSpeciesName
	call MobileTradeAnim_GetNickname
	jmp MobileTradeAnim_NormalPals

DoMobileTradeAnimation:
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .finished
	call .DoTradeAnimCommand
	farcall PlaySpriteAnimations
	ld hl, wFrameCounter2
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
	dw MobileTradeAnim_AdvanceScriptPointer  ; 00
	dw MobileTradeAnim_End                   ; 01
	dw MobileTradeAnim_02                    ; 02
	dw MobileTradeAnim_GiveTrademon1         ; 03
	dw MobileTradeAnim_05                    ; 04
	dw MobileTradeAnim_GetTradeMon1          ; 05
	dw MobileTradeAnim_ShowOTMonFromTrade    ; 06
	dw MobileTradeAnim_ShowPlayerMonToBeSent ; 07
	dw MobileTradeAnim_FadeToBlack           ; 08

MobileTradeAnim_AdvanceScriptPointer:
	ld hl, wTradeAnimPointer
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ld a, [de]
	ld [wJumptableIndex], a
	inc de
	ld a, d
	ld [hld], a
	ld [hl], e
	ret

MobileTradeAnim_End:
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

MobileTradeAnim_GetFrontpic:
	push de
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	ld a, [hl]
	ld [wCurForm], a
	call GetBaseData
	pop de
	predef_jump GetFrontpic

MobileTradeAnim_GetNickname:
	push de
	ld hl, wNamedObjectIndex
	ld [hli], a
	ld [hl], b
	call GetPokemonName
	ld hl, wStringBuffer1
	pop de
	ld bc, NAME_LENGTH
	rst CopyBytes
	ret

MobileTradeAnim_ShowGivemonFrontpic:
	ld de, vTiles0
	call DelayFrame
	ld hl, vTiles2
	lb bc, 10, $31
	call Request2bpp
	call WaitTop
	call MobileTradeAnim_BlankTileMap
	hlcoord 7, 2
	xor a
	ldh [hGraphicStartTile], a
	lb bc, 7, 7
	predef PlaceGraphic
	jmp ApplyTilemapInVBlank

MobileShowPlayerTrademonStats:
	ld de, wPlayerTrademonIsEgg
	ld a, [de]
	bit MON_IS_EGG_F, a
	ld de, wPlayerTrademonSpecies
	jr nz, MobileTrademonStats_Egg
	call MobileTrademonStats_MonTemplate
	ld de, wPlayerTrademonSpecies
	call MobileTrademonStats_PrintSpeciesNumber
	ld de, wPlayerTrademonSpeciesName
	call MobileTrademonStats_PrintSpeciesName
	ld a, [wPlayerTrademonCaughtData]
	ld de, wPlayerTrademonOTName
	call MobileTrademonStats_PrintOTName
	ld de, wPlayerTrademonID
	call MobileTrademonStats_PrintTrademonID
	jr MobileTrademonStats_WaitBGMap

MobileShowOTTrademonStats:
	ld de, wOTTrademonIsEgg
	ld a, [de]
	bit MON_IS_EGG_F, a
	ld de, wOTTrademonSpecies
	jr nz, MobileTrademonStats_Egg
	call MobileTrademonStats_MonTemplate
	ld de, wOTTrademonSpecies
	call MobileTrademonStats_PrintSpeciesNumber
	ld de, wOTTrademonSpeciesName
	call MobileTrademonStats_PrintSpeciesName
	ld a, [wOTTrademonCaughtData]
	ld de, wOTTrademonOTName
	call MobileTrademonStats_PrintOTName
	ld de, wOTTrademonID
	call MobileTrademonStats_PrintTrademonID
	jr MobileTrademonStats_WaitBGMap

MobileTrademonStats_MonTemplate:
	call WaitTop
	call MobileTradeAnim_BlankTileMap
	ld a, HIGH(vBGMap1)
	ldh [hBGMapAddress + 1], a
	hlcoord 3, 0
	lb bc, $6, $d
	call Textbox
	hlcoord 4, 0
	ld de, MobileTrademonStats_OTMonData
	rst PlaceString
	ret

MobileTrademonStats_Egg:
	call WaitTop
	call MobileTradeAnim_BlankTileMap
	ld a, HIGH(vBGMap1)
	ldh [hBGMapAddress + 1], a
	hlcoord 3, 0
	lb bc, $6, $d
	call Textbox
	hlcoord 4, 2
	ld de, MobileTrademonStats_EggData
	rst PlaceString
	; fallthrough

MobileTrademonStats_WaitBGMap:
	call ApplyTilemapInVBlank
	call WaitTop
	ld a, HIGH(vBGMap0)
	ldh [hBGMapAddress + 1], a
	ret

MobileTrademonStats_OTMonData:
	db   "─── №."
	next ""
	next "OT/"
	next "<ID>№.@"

MobileTrademonStats_EggData:
	db   "Egg"
	next "OT/?????"
	next "<ID>№.?????@"

MobileTrademonStats_PrintSpeciesNumber:
	hlcoord 10, 0
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	ld [hl], " "
	ret

MobileTrademonStats_PrintSpeciesName:
	hlcoord 4, 2
	rst PlaceString
	ret

MobileTrademonStats_PrintOTName:
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

MobileTrademonStats_PrintTrademonID:
	hlcoord 7, 6
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	jmp PrintNum

MobileTradeAnim_BlankTileMap:
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, " "
	rst ByteFill
	ret

MobileTradeAnim_NormalPals:
	ld a, %11100100 ; 3,2,1,0
	call DmgToCgbObjPal0
	ld a, %11100100 ; 3,2,1,0
	jmp DmgToCgbBGPals

MobileLinkTradeAnim_LoadTradePlayerNames:
	push de
	ld de, wLinkPlayer1Name
	ld bc, NAME_LENGTH
	rst CopyBytes
	pop hl
	ld de, wLinkPlayer2Name
	ld bc, NAME_LENGTH
	rst CopyBytes
	ret

MobileLinkTradeAnim_LoadTradeMonData:
	; bc = species, de = shiny, de+1 = form
	ld a, [bc]
	ld [hli], a
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	and SPECIESFORM_MASK
	ld [hl], a
	ret

MobileLoadTradeBallAndCableGFX:
	call DelayFrame
	ld hl, MobileTradeBallPoofCableGFX
	ld de, vTiles0 tile $62
	lb bc, BANK(MobileTradeBallPoofCableGFX), 20
	call DecompressRequest2bpp
	xor a
	ld hl, wSpriteAnimDict
	ld [hli], a
	ld [hl], $62
	ret

MobileTradeAnim_ShowPlayerMonToBeSent:
	ld de, MUSIC_EVOLUTION
	call PlayMusic2
	ld a, $88
	ldh [hSCX], a
	xor a
	ldh [hSCY], a
	ld a, $8f
	ldh [hWX], a
	ld a, $50
	ldh [hWY], a
	call DelayFrame
	call MobileShowPlayerTrademonStats
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
	call MobileTradeAnim_ShowGivemonFrontpic
	ld a, [wPlayerTrademonSpecies]
	ld [wCurPartySpecies], a
.loop
	ldh a, [hWX]
	cp $7
	jr z, .okay
	sub $4
	ldh [hWX], a
	ldh a, [hSCX]
	sub $4
	ldh [hSCX], a
	call DelayFrame
	jr .loop

.okay
	ld a, $7
	ldh [hWX], a
	xor a
	ldh [hSCX], a
	ld a, [wPlayerTrademonSpecies]
	call GetCryIndex
	jr c, .skip_cry
	ld e, c
	ld d, b
	call PlayCry

.skip_cry
	ld c, 80
	call DelayFrames
	call MobilePrintTradeMonForPartnerMonText
	ld hl, MobileTradeBallPoofCableGFX
	ld de, vTiles0 tile 0
	lb bc, BANK(MobileTradeBallPoofCableGFX), 20
	call DecompressRequest2bpp
	depixel 10, 11, 4, 0
	ld a, SPRITE_ANIM_INDEX_MOBILE_TRADE_SENT_BALL
	call InitSpriteAnimStruct
	ld de, SFX_BALL_POOF
	call PlaySFX
	hlcoord 0, 0
	ld bc, 12 * SCREEN_WIDTH
	ld a, " "
	rst ByteFill
	ld c, 80
	call WaitMobileTradeSpriteAnims
	jmp MobileTradeAnim_AdvanceScriptPointer

MobileTradeAnim_FadeToBlack:
.loop
	ldh a, [rBGP]
	and a
	jr z, .blank
	add a
	add a
	call DmgToCgbBGPals
	call DmgToCgbObjPal0
	ld c, 4
	call DelayFrames
	jr .loop

.blank
	xor a
	call DmgToCgbBGPals
	call DmgToCgbObjPal0
	jmp MobileTradeAnim_AdvanceScriptPointer

MobileTradeAnim_02:
	farcall DeinitializeAllSprites
	call ClearBGPalettes
	call ClearSprites
	call ClearTileMap
	xor a
	ldh [hBGMapMode], a
	call DisableLCD
	call MobileTradeAnim_ClearBGMap
	call LoadMobileTradeAttrmap
	call LoadMobileTradeTilemap
	call LoadMobileTradeGFX
	call EnableLCD
	ld a, $c
	ldh [hSCX], a
	ld a, $78
	ldh [hSCY], a
	ld a, $7
	ldh [hWX], a
	ld a, $90
	ldh [hWY], a
	ld hl, MobileTradeBGPalettes
	ld de, wBGPals1
	ld bc, 8 palettes
	call FarCopyColorWRAM
	call LoadMobileAdapterPalette
	call LoadMobileOBPalettes
	jmp MobileTradeAnim_AdvanceScriptPointer

MobileTradeAnim_GiveTrademon1:
	; todo: remove the wSpriteAnimDict stuff
	; if it's no longer needed. (after removing extra copied code from trade animations)
	xor a
	ld hl, wSpriteAnimDict
	ld [hli], a
	ld [hl], a

	ld de, SFX_GIVE_TRADEMON
	call PlaySFX
	ld c, 40
	ld hl, wBGPals2 palette 6
	call Function1082f0
	call LoadMobileOBPalettes
.loop
	ldh a, [hSCX]
	cp $e0
	jr z, .loop2
	dec a
	dec a
	ldh [hSCX], a
	cp $f8
	jr nz, .next
	depixel 10, 11, 4, 0
	ld a, SPRITE_ANIM_INDEX_MOBILE_TRADE_CABLE_BULGE
	call InitSpriteAnimStruct

.next
	ld c, 1
	call WaitMobileTradeSpriteAnims
	jr .loop

.loop2
	ldh a, [hSCY]
	cp $f8
	jr z, .done
	dec a
	dec a
	ldh [hSCY], a
	cp $40
	jr z, .init
	cp $30
	jr z, .delete
	cp $68
	jr z, .replace
	jr .next2

.init
	depixel 10, 11, 4, 0
	ld a, SPRITE_ANIM_INDEX_MOBILE_TRADE_CABLE_BULGE
	call InitSpriteAnimStruct
	xor a
	call MobileLoadCableGFX
	jr .next2

.delete
	call MobileTradeAnim_DeleteSprites
	jr .next2

.replace
	call MobileTradeAnim_DeleteSprites
	ld a, $1
	call MobileLoadCableGFX
.next2
	ld c, 1
	call WaitMobileTradeSpriteAnims
	jr .loop2

.done
; fallthrough
MobileTradeAnim_GiveTrademon2:
	ld c, 40
	ld hl, wBGPals2 + 1 palettes
	call Function1082f0
	call LoadMobileOBPalettes
	call Function108b5a
	depixel 9, 10, 2, 0
	ld a, SPRITE_ANIM_INDEX_MOBILE_TRADE_PING
	call InitSpriteAnimStruct
	ld de, SFX_FORESIGHT
	call PlaySFX
	ld c, 10
	call WaitMobileTradeSpriteAnims
	xor a
	ld [wcf64], a
	depixel 9, 10, 2, 0
	ld a, SPRITE_ANIM_INDEX_MOBILE_TRADE_SENT_PULSE
	call InitSpriteAnimStruct
.loop
	ldh a, [hSCY]
	cp $90
	jr z, .done
	sub $8
	ldh [hSCY], a
	ld c, 1
	call WaitMobileTradeSpriteAnims
	jr .loop

.done
	jmp MobileTradeAnim_AdvanceScriptPointer

MobileTradeAnim_05:
	ld c, 40
	call WaitMobileTradeSpriteAnims
	ld a, $1
	ld [wcf64], a
	ld de, SFX_SHARPEN
	call PlaySFX
	ld c, 60
	call WaitMobileTradeSpriteAnims
	depixel 30, 10, 2, 0
	ld a, SPRITE_ANIM_INDEX_MOBILE_TRADE_OT_PULSE
	call InitSpriteAnimStruct
	ld de, SFX_THROW_BALL
	call PlaySFX
	jmp MobileTradeAnim_AdvanceScriptPointer
	
MobileTradeAnim_GetTradeMon1:
	ld c, 40
	call WaitMobileTradeSpriteAnims
.loop
	ldh a, [hSCY]
	cp $f8
	jr z, .done
	add $8
	ldh [hSCY], a
	ld c, 1
	call WaitMobileTradeSpriteAnims
	jr .loop

.done
	farcall DeinitializeAllSprites
	depixel 9, 10, 2, 0
	ld a, SPRITE_ANIM_INDEX_MOBILE_TRADE_PING
	call InitSpriteAnimStruct
	ld de, SFX_GLASS_TING_2
	call PlaySFX
	call LoadMobileOBPalettes
; fallthrough
MobileTradeAnim_GetTrademon2:
	ld c, 20
	ld hl, wBGPals2 + 1 palettes
	call Function1082fa
	ld de, SFX_GIVE_TRADEMON
	call PlaySFX
	ld c, 20
	ld hl, wBGPals2 + 1 palettes
	call Function1082fa
	call LoadMobileOBPalettes
.loop
	ldh a, [hSCY]
	cp $78
	jr z, .loop2
	inc a
	inc a
	ldh [hSCY], a
	cp $30
	jr z, .init_cable_bulge
	cp $40
	jr z, .delete
	cp $68
	jr z, .init_cable_bulge_load_cable_gfx
	jr .wait

.init_cable_bulge
	depixel 10, 11, 4, 0
	ld a, SPRITE_ANIM_INDEX_MOBILE_TRADE_CABLE_BULGE
	call InitSpriteAnimStruct
	jr .wait

.init_cable_bulge_load_cable_gfx
	depixel 10, 11, 4, 0
	ld a, SPRITE_ANIM_INDEX_MOBILE_TRADE_CABLE_BULGE
	call InitSpriteAnimStruct
	xor a
	call MobileLoadCableGFX
	jr .wait

.delete
	call MobileTradeAnim_DeleteSprites
	ld a, $1
	call MobileLoadCableGFX
; fallthrough
.wait
	ld c, 1
	call WaitMobileTradeSpriteAnims
	jr .loop

.loop2
	ldh a, [hSCX]
	cp $c
	jr z, .done
	inc a
	inc a
	ldh [hSCX], a
	cp -8
	jr nz, .wait
	call MobileTradeAnim_DeleteSprites
	ld c, 1
	call WaitMobileTradeSpriteAnims
	jr .loop2

.done
; fallthrough
MobileTradeAnim_GetTradeMon3:
	ld c, 40
	ld hl, wBGPals2 palette 6
	call Function1082f0
	call LoadMobileOBPalettes
	jmp MobileTradeAnim_AdvanceScriptPointer

MobileTradeAnim_ShowOTMonFromTrade:
	call ClearBGPalettes
	call ClearSprites
	call ClearTileMap
	call DisableLCD
	call MobileTradeAnim_ClearBGMap
	farcall GetTrademonFrontpic
	ld hl, MobileTradeBallPoofCableGFX
	ld de, vTiles0 tile 0
	lb bc, BANK(MobileTradeBallPoofCableGFX), 20
	call DecompressRequest2bpp
	call EnableLCD
	farcall DeinitializeAllSprites
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	ld a, $7
	ldh [hWX], a
	ld a, $90
	ldh [hWY], a
	depixel 10, 11, 4, 0
	ld a, SPRITE_ANIM_INDEX_MOBILE_TRADE_OT_BALL
	call InitSpriteAnimStruct
	call Function108b45
	ld a, $1
	call Function108b98
	call LoadMobileOBPalettes
	ld c, 68
	call WaitMobileTradeSpriteAnims
	call ClearSprites
	ld de, SFX_BALL_POOF
	call PlaySFX
	call MobileShowOTTrademonStats
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	ld a, $7
	ldh [hWX], a
	ld a, $50
	ldh [hWY], a
	ld a, [wOTTrademonSpecies]
	farcall AnimateTrademonFrontpic
	call MobilePrintTakeGoodCareOfMonText
	jmp MobileTradeAnim_AdvanceScriptPointer

MobileLoadCableGFX:
	and a
	jr z, .cable1
	ld de, MobileCable2GFX
	jr .got_cable

.cable1
	ld de, MobileCable1GFX
.got_cable
	ld a, $1
	ldh [rVBK], a
	ld hl, vTiles2 tile $4a
	lb bc, BANK(MobileCable1GFX), 16 ; aka BANK(MobileCable2GFX)
	call Get2bpp
	call DelayFrame
	xor a
	ldh [rVBK], a
	ret

MobileTradeAnim_DeleteSprites:
	farcall DeinitializeAllSprites
	jmp ClearSprites

MobileTradeAnim_AnimateSentPulse:
	ld a, [wcf64]
	and a
	ret z
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	cp -1 * TILE_WIDTH - 6
	jr z, .delete
	sub 1 * TILE_WIDTH
	ld [hl], a
	ret

.delete
	farjp DeinitializeSprite

MobileTradeAnim_AnimateOTPulse:
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	cp 9 * TILE_WIDTH + 2
	ret z
	add 1 * TILE_WIDTH
	ld [hl], a
	ret

WaitMobileTradeSpriteAnims:
.loop
	push bc
	farcall PlaySpriteAnimations
	pop bc
	call DelayFrame
	dec c
	jr nz, .loop
	ret

Function108b5a:
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld de, palred 18 + palgreen 31 + palblue 15
	ld hl, wBGPals2 + 4 palettes
	ld c, $10
.loop
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	dec c
	jr nz, .loop
	pop af
	ldh [rSVBK], a
	ld a, TRUE
	ldh [hCGBPalUpdate], a
	ret

Function1082fa:
.loop
	call Function108b78
	push hl
	push bc
	farcall PlaySpriteAnimations
	pop bc
	pop hl
	call DelayFrame
	dec c
	jr nz, .loop
	ret

Function1082f0:
.loop
	call Function108b78
	call DelayFrame
	dec c
	jr nz, .loop
	ret

Function108b78:
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld a, c
	and $2
	jr z, .Orange
	ld de, PALRGB_WHITE
	jr .load_pal

.Orange:
	ld de, palred 31 + palgreen 15 + palblue 1
.load_pal
	ld a, e
	ld [hli], a
	ld a, d
	ld [hld], a
	pop af
	ldh [rSVBK], a
	ld a, TRUE
	ldh [hCGBPalUpdate], a
	ret

Palette_108b98:
; removed
; todo: fix this!!

Function108b98:
	ld d, a
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld a, [wcf65]
	and $1
	xor d
	jr z, .asm_108bad
	ld hl, Palette_108b98 + 1 palettes
	jr .asm_108bb0

.asm_108bad
	ld hl, Palette_108b98
.asm_108bb0
	ld de, wBGPals1 + 7 palettes
	ld bc, 8 palettes
	call CopyBytes
	pop af
	ldh [rSVBK], a
	ret

Function108b45:
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld de, PALRGB_WHITE
	ld hl, wBGPals1
	ld a, e
	ld [hli], a
	ld d, a
	ld [hli], a
	pop af
	ldh [rSVBK], a
	ret

MobileTradeAnim_ClearBGMap:
	ld a, $1
	ldh [rVBK], a
	hlbgcoord 0, 0
	ld bc, 2 * BG_MAP_HEIGHT * BG_MAP_WIDTH
	xor a
	call ByteFill
	xor a
	ldh [rVBK], a
	hlbgcoord 0, 0
	ld bc, 2 * BG_MAP_HEIGHT * BG_MAP_WIDTH
	ld a, $7f
	rst ByteFill
	ret

LoadMobileTradeAttrmap:
	ld a, $1
	ldh [rVBK], a
	ld hl, MobileTradeAttrmapLZ
	debgcoord 0, 0
	call Decompress
	ld hl, MobileTradeAttrmapLZ
	debgcoord 0, 0, vBGMap1
	call Decompress
	xor a
	ldh [rVBK], a
	ret

LoadMobileTradeTilemap:
	ld hl, MobileTradeTilemapLZ
	debgcoord 0, 0
	call Decompress
	ld hl, MobileTradeTilemapLZ
	debgcoord 0, 0, vBGMap1
	jmp Decompress

LoadMobileOBPalettes:
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld a, [wcf65]
	and $1
	jr z, .copy_MobileTradeOB1Palettes
	ld hl, MobileTradeOB2Palettes
	ld de, wOBPals1
	ld bc, 8 palettes
	call CopyBytes
	ld hl, MobileTradeOB2Palettes
	ld de, wOBPals2
	ld bc, 8 palettes
	call CopyBytes
	jr .done_copy

.copy_MobileTradeOB1Palettes
	ld hl, MobileTradeOB1Palettes
	ld de, wOBPals1
	ld bc, 8 palettes
	call CopyBytes
	ld hl, MobileTradeOB1Palettes
	ld de, wOBPals2
	ld bc, 8 palettes
	call CopyBytes

.done_copy
	pop af
	ldh [rSVBK], a
	ld a, %11100100 ; 3,2,1,0
	call DmgToCgbObjPal0
	ld a, %11100100 ; 3,2,1,0
	call DmgToCgbBGPals
	jmp DelayFrame

LoadMobileAdapterPalette:
	ld a, [wMobileAdapaterDevice]
	and $7f
	cp $8 ; CONST: Amount of mobile adapters
	jr c, .got_adapter
	ld a, $7

.got_adapter
	ld bc, 1 palettes
	ld hl, MobileAdapterPalettes
	call AddNTimes
	ld a, BANK(wBGPals1)
	ld de, wBGPals1 + 4 palettes
	ld bc, 1 palettes
	jmp FarCopyColorWRAM

LoadMobileTradeGFX:
	ld a, $1
	ldh [rVBK], a
	ld hl, MobileTradeGFX
	ld de, vTiles2
	call Decompress
	xor a
	ldh [rVBK], a
	ld hl, MobileTradeSpritesGFX
	ld de, vTiles0 tile $20
	jmp Decompress

MobilePrintTakeGoodCareOfMonText:
	ld a, $90
	ldh [hWY], a
	ld hl, .MobileTakeGoodCareOfMonText
	call PrintText
	ld c, 80
	jmp DelayFrames

.MobileTakeGoodCareOfMonText:
	text_far _MobileTakeGoodCareOfMonText
	text_end

MobilePrintTradeMonForPartnerMonText:
	ld a, $90
	ldh [hWY], a
	ld hl, .MobilePlayerWillTradeMonText
	call PrintText
	ld c, 80
	call DelayFrames
	ld hl, .MobileForPartnersMonText
	call PrintText
	ld c, 80
	jmp DelayFrames

.MobilePlayerWillTradeMonText:
	text_far _MobilePlayerWillTradeMonText
	text_end

.MobileForPartnersMonText:
	text_far _MobileForPartnersMonText
	text_end

AnimatePlayerTrademonFrontpic:
	ld a, [wPlayerTrademonSpecies]
	call IsAPokemon
	ret c
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
	farcall TradeAnim_ShowGetmonFrontpic
	ld a, [wPlayerTrademonSpecies]
	ld [wCurPartySpecies], a
	hlcoord 7, 2
	lb de, $0, ANIM_MON_TRADE
	predef_jump AnimateFrontpic

GetPlayerTrademonFrontpic:
	ld a, [wPlayerTrademonSpecies]
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	ld a, [wPlayerTrademonForm]
	ld [wCurForm], a
	call GetBaseData
	ld de, vTiles2
	predef_jump FrontpicPredef

MobileTradeSpritesGFX: INCBIN "gfx/mobile/mobile_trade_sprites.2bpp.lz"
MobileTradeGFX: INCBIN "gfx/mobile/mobile_trade.2bpp.lz"
MobileCable1GFX: INCBIN "gfx/mobile/mobile_cable_1.2bpp"
MobileCable2GFX: INCBIN "gfx/mobile/mobile_cable_2.2bpp"
MobileTradeScreenGFX:: INCBIN "gfx/mobile/mobile_trade_screen.2bpp.lz"
MobileTradeLightsGFX:: INCBIN "gfx/mobile/mobile_trade_lights.2bpp.lz"
MobileTradeBallPoofCableGFX:  INCBIN "gfx/trade/ball_poof_cable.2bpp.lz"
MobileTradeGameBoyLZ: INCBIN "gfx/trade/game_boy_cable.2bpp.lz"

MobileTradeTilemapLZ: INCBIN "gfx/mobile/mobile_trade.tilemap.lz"

MobileTradeAttrmapLZ: INCBIN "gfx/mobile/mobile_trade.attrmap.lz"

MobileTradeOB1Palettes: INCLUDE "gfx/mobile/mobile_trade_ob1.pal"
MobileTradeOB2Palettes: INCLUDE "gfx/mobile/mobile_trade_ob2.pal"
MobileAdapterPalettes: INCLUDE "gfx/mobile/mobile_adapters.pal"
MobileTradeBGPalettes: INCLUDE "gfx/mobile/mobile_trade_bg.pal"
MobileTradeLightsPalettes:: INCLUDE "gfx/mobile/mobile_trade_lights.pal"
MobileTradeBorderPalettes:: INCLUDE "gfx/mobile/mobile_border.pal"
