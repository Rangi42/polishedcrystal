CrystalIntro:
	ld hl, rIE
	set LCD_STAT, [hl]
	ldh a, [rSVBK]
	push af
	ld a, 5
	ldh [rSVBK], a
	ldh a, [hInMenu]
	push af
	ldh a, [hVBlank]
	push af
	call .InitRAMAddrs
.loop
	call JoyTextDelay
	ldh a, [hJoyLast]
	and BUTTONS
	jr nz, .ShutOffMusic
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .done
	call IntroSceneJumper
	farcall PlaySpriteAnimations
	call DelayFrame
	jr .loop

.ShutOffMusic:
	ld de, MUSIC_NONE
	call PlayMusic

.done
	call ClearBGPalettes
	call ClearSprites
	call ClearTileMap
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	ld a, $7
	ldh [hWX], a
	ld a, $90
	ldh [hWY], a
	pop af
	ldh [hVBlank], a
	pop af
	ldh [hInMenu], a
	pop af
	ldh [rSVBK], a
	ld hl, rIE
	res LCD_STAT, [hl]
	ret

.InitRAMAddrs:
	xor a
	ldh [hVBlank], a
	ld a, $1
	ldh [hInMenu], a
	xor a
	ldh [hMapAnims], a
	ld [wJumptableIndex], a
	ret

IntroSceneJumper:
	call StandardStackJumpTable

IntroScenes:
	dw IntroScene1
	dw IntroScene2
	dw IntroScene3
	dw IntroScene4
	dw IntroScene5
	dw IntroScene6
	dw IntroScene7
	dw IntroScene8
	dw IntroScene9
	dw IntroScene10
	dw IntroScene11
	dw IntroScene12
	dw IntroScene13
	dw IntroScene14
	dw IntroScene15
	dw IntroScene16
	dw IntroScene17
	dw IntroScene18
	dw IntroScene19
	dw IntroScene20
	dw IntroScene21
	dw IntroScene22
	dw IntroScene23
	dw IntroScene24
	dw IntroScene25
	dw IntroScene26
	dw IntroScene27
	dw IntroScene28

NextIntroScene:
	ld hl, wJumptableIndex
	inc [hl]
	ret

IntroScene1:
; Setup the next scene.
	call Intro_ClearBGPals
	call ClearSprites
	call ClearTileMap
	xor a
	ldh [hBGMapMode], a
	ld a, $1
	ldh [rVBK], a
	ld hl, IntroTilemap001
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles
	xor a
	ldh [rVBK], a
	ld hl, IntroUnownsGFX
	ld de, vTiles2 tile $00
	call Intro_DecompressRequest2bpp_128Tiles
	ld hl, IntroPulseGFX
	ld de, vTiles0 tile $00
	call Intro_DecompressRequest2bpp_128Tiles
	ld hl, IntroTilemap002
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld hl, Palette_365ad
	ld de, wBGPals1
	ld bc, 16 palettes
	rst CopyBytes
	ld hl, Palette_365ad
	ld de, wBGPals2
	ld bc, 16 palettes
	rst CopyBytes
	pop af
	ldh [rSVBK], a
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	ld a, $7
	ldh [hWX], a
	ld a, $90
	ldh [hWY], a
	call ClearSpriteAnims
	call Intro_SetCGBPalUpdate
	xor a
	ld [wIntroSceneFrameCounter], a
	ld [wIntroSceneTimer], a
	jr NextIntroScene

IntroScene2:
; First Unown (A) fades in, pulses, then fades out.
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	inc [hl]
	cp $80
	jr nc, NextIntroScene
	cp $60
	jr nz, .DontPlaySound
	push af
	depixel 11, 11
	call CrystalIntro_InitUnownAnim
	ld de, SFX_INTRO_UNOWN_1
	call PlaySFX
	pop af
.DontPlaySound:
	ld [wIntroSceneTimer], a
	xor a
	jmp CrystalIntro_UnownFade

IntroScene3:
; More setup. Transition to the outdoor scene.
	call Intro_ClearBGPals
	call ClearSprites
	call ClearTileMap
	xor a
	ldh [hBGMapMode], a
	ld a, $1
	ldh [rVBK], a
	ld hl, IntroTilemap003
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles
	xor a
	ldh [rVBK], a
	call Intro_SetupCommonScenery
	call Intro_ResetLYOverrides
	call Intro_SetCGBPalUpdate
	xor a
	ld [wIntroSceneFrameCounter], a
	jmp NextIntroScene

IntroScene4:
; Scroll the outdoor panorama for a bit.
	call Intro_PerspectiveScrollBG
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	cp $80
	jmp z, NextIntroScene
	inc [hl]
	ret

IntroScene5:
; Go back to the Unown.
	call Intro_ClearBGPals
	call ClearSprites
	call ClearTileMap
	xor a
	ldh [hBGMapMode], a
	ldh [hLCDCPointer], a
	ld a, $1
	ldh [rVBK], a
	ld hl, IntroTilemap005
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles
	xor a
	ldh [rVBK], a
	ld hl, IntroUnownsGFX
	ld de, vTiles2 tile $00
	call Intro_DecompressRequest2bpp_128Tiles
	ld hl, IntroPulseGFX
	ld de, vTiles0 tile $00
	call Intro_DecompressRequest2bpp_128Tiles
	ld hl, IntroTilemap006
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld hl, Palette_365ad
	ld de, wBGPals1
	ld bc, 16 palettes
	rst CopyBytes
	ld hl, Palette_365ad
	ld de, wBGPals2
	ld bc, 16 palettes
	rst CopyBytes
	pop af
	ldh [rSVBK], a
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	ld a, $7
	ldh [hWX], a
	ld a, $90
	ldh [hWY], a
	call ClearSpriteAnims
	call Intro_SetCGBPalUpdate
	xor a
	ld [wIntroSceneFrameCounter], a
	ld [wIntroSceneTimer], a
	jmp NextIntroScene

IntroScene6:
; Two more Unown (I, H) fade in.
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	inc [hl]
	cp $80
	jmp nc, NextIntroScene
	cp $60
	jr z, .SecondUnown
	cp $40
	jr nc, .StopUnown
	cp $20
	jr nz, .NoUnown

.FirstUnown:
	push af
	depixel 7, 15
	call CrystalIntro_InitUnownAnim
	ld de, SFX_INTRO_UNOWN_2
	call PlaySFX
	pop af
.NoUnown:
	ld [wIntroSceneTimer], a
	xor a
	jmp CrystalIntro_UnownFade

.SecondUnown:
	push af
	depixel 14, 6
	call CrystalIntro_InitUnownAnim
	ld de, SFX_INTRO_UNOWN_1
	call PlaySFX
	pop af
.StopUnown:
	ld [wIntroSceneTimer], a
	ld a, $1
	jmp CrystalIntro_UnownFade

IntroScene7:
; Back to the outdoor scene.
	call Intro_ClearBGPals
	call ClearSprites
	call ClearTileMap
	xor a
	ldh [hBGMapMode], a

	ld a, $1
	ldh [rVBK], a
	ld hl, IntroTilemap003
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles

	ld hl, IntroPichuWooperGFX
	ld de, vTiles0 tile $00
	call Intro_DecompressRequest2bpp_128Tiles

	xor a
	ldh [rVBK], a
	ld hl, IntroSuicuneRunGFX
	ld de, vTiles0 tile $00
	call Intro_DecompressRequest2bpp_255Tiles

	call Intro_SetupCommonScenery

	call Intro_ResetLYOverrides
	call ClearSpriteAnims
	depixel 13, 27, 4, 0
	ld a, SPRITE_ANIM_INDEX_INTRO_SUICUNE
	call _InitSpriteAnimStruct
	ld a, $f0
	ld [wGlobalAnimXOffset], a
	call Intro_SetCGBPalUpdate
	xor a
	ld [wIntroSceneFrameCounter], a
	ld [wIntroSceneTimer], a
	jmp NextIntroScene

IntroScene8:
; Scroll the scene, then show Suicune running across the screen.
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	inc [hl]
	cp $40
	jr z, .suicune_sound
	jr nc, .animate_suicune
	jmp Intro_PerspectiveScrollBG

.suicune_sound
	ld de, SFX_INTRO_SUICUNE_3
	call PlaySFX
.animate_suicune
	ld a, [wGlobalAnimXOffset]
	and a
	jr z, .finish
	sub $8
	ld [wGlobalAnimXOffset], a
	ret

.finish
	ld de, SFX_INTRO_SUICUNE_2
	call PlaySFX
	farcall DeinitializeAllSprites
	jmp NextIntroScene

IntroScene9:
; Set up the next scene (same bg).
	xor a
	ldh [hLCDCPointer], a
	call ClearSprites
	hlcoord 0, 0, wAttrMap
	; first 12 rows have palette 1
	ld bc, 12 * SCREEN_WIDTH
	ld a, $1
	rst ByteFill
	; middle 3 rows have palette 2
	ld bc, 3 * SCREEN_WIDTH
	ld a, $2
	rst ByteFill
	; last three rows have palette 3
	ld bc, 3 * SCREEN_WIDTH
	ld a, $3
	rst ByteFill
	ld a, $2
	ldh [hBGMapMode], a
	call DelayFrame
	call DelayFrame
	call DelayFrame
	ld a, $c
	ldh [hBGMapAddress], a
	call DelayFrame
	call DelayFrame
	call DelayFrame
	xor a
	ldh [hBGMapMode], a
	ldh [hBGMapAddress], a
	ld [wGlobalAnimXOffset], a
	xor a
	ld [wIntroSceneFrameCounter], a
	jmp NextIntroScene

IntroScene10:
; Wooper and Pichu enter.
	call Intro_RustleGrass
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	inc [hl]
	cp $c0
	jmp z, NextIntroScene
	cp $20
	jr z, .wooper
	cp $40
	ret nz
; pichu
	depixel 21, 16, 1, 0
	ld a, SPRITE_ANIM_INDEX_INTRO_PICHU
	jr .got_anim

.wooper
	depixel 22, 6
	ld a, SPRITE_ANIM_INDEX_INTRO_WOOPER
.got_anim
	call _InitSpriteAnimStruct
	ld de, SFX_INTRO_PICHU
	jmp PlaySFX

IntroScene11:
; Back to Unown again.
	call Intro_ClearBGPals
	call ClearSprites
	call ClearTileMap
	xor a
	ldh [hBGMapMode], a
	ldh [hLCDCPointer], a
	ld a, $1
	ldh [rVBK], a
	ld hl, IntroTilemap007
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles
	xor a
	ldh [rVBK], a
	ld hl, IntroUnownsGFX
	ld de, vTiles2 tile $00
	call Intro_DecompressRequest2bpp_128Tiles
	ld hl, IntroTilemap008
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld hl, Palette_365ad
	ld de, wBGPals1
	ld bc, 16 palettes
	rst CopyBytes
	ld hl, Palette_365ad
	ld de, wBGPals2
	ld bc, 16 palettes
	rst CopyBytes
	pop af
	ldh [rSVBK], a
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	ld a, $7
	ldh [hWX], a
	ld a, $90
	ldh [hWY], a
	call ClearSpriteAnims
	call Intro_SetCGBPalUpdate
	xor a
	ld [wIntroSceneFrameCounter], a
	ld [wIntroSceneTimer], a
	jmp NextIntroScene

IntroScene12:
; Even more Unown.
	call .PlayUnownSound
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	inc [hl]
	cp $c0
	jmp nc, NextIntroScene
	cp $80
	jr nc, .second_half
; first half
	ld c, a
	and $1f
	sla a
	ld [wIntroSceneTimer], a
	ld a, c
	and $e0
	srl a
	swap a
	jmp CrystalIntro_UnownFade

.second_half
; double speed
	ld c, a
	and $f
	sla a
	sla a
	ld [wIntroSceneTimer], a
	ld a, c
	and $70
	or $40
	swap a
	jmp CrystalIntro_UnownFade

.PlayUnownSound:
	ld a, [wIntroSceneFrameCounter]
	ld c, a
	ld hl, .UnownSounds
.loop
	ld a, [hli]
	cp -1
	ret z
	cp c
	jr z, .playsound
	inc hl
	inc hl
	jr .loop
.playsound
	ld a, [hli]
	ld d, [hl]
	ld e, a
	push de
	call SFXChannelsOff
	pop de
	jmp PlaySFX

.UnownSounds:
	dbw $00, SFX_INTRO_UNOWN_3
	dbw $20, SFX_INTRO_UNOWN_2
	dbw $40, SFX_INTRO_UNOWN_1
	dbw $60, SFX_INTRO_UNOWN_2
	dbw $80, SFX_INTRO_UNOWN_3
	dbw $90, SFX_INTRO_UNOWN_2
	dbw $a0, SFX_INTRO_UNOWN_1
	dbw $b0, SFX_INTRO_UNOWN_2
	db -1

IntroScene13:
; Switch scenes again.
	call Intro_ClearBGPals
	call ClearSprites
	call ClearTileMap
	xor a
	ldh [hBGMapMode], a
	ld a, $1
	ldh [rVBK], a
	ld hl, IntroTilemap003
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles
	xor a
	ldh [rVBK], a
	ld hl, IntroSuicuneRunGFX
	ld de, vTiles0 tile $00
	call Intro_DecompressRequest2bpp_255Tiles
	call Intro_SetupCommonScenery
	call ClearSpriteAnims
	depixel 13, 11, 4, 0
	ld a, SPRITE_ANIM_INDEX_INTRO_SUICUNE
	call _InitSpriteAnimStruct
	ld de, MUSIC_CRYSTAL_OPENING
	call PlayMusic
	xor a
	ld [wGlobalAnimXOffset], a
	call Intro_SetCGBPalUpdate
	xor a
	ld [wIntroSceneFrameCounter], a
	ld [wIntroSceneTimer], a
	jmp NextIntroScene

IntroScene14:
; Suicune runs then jumps.
	ldh a, [hSCX]
	sub 10
	ldh [hSCX], a
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	inc [hl]
	cp $80
	jmp z, NextIntroScene
	cp $60
	jr z, .jump
	jr nc, .asm_e4e1a
	cp $40
	jr nc, .asm_e4e33
	ret

.jump
	ld de, SFX_INTRO_SUICUNE_4
	call PlaySFX

.asm_e4e1a
	ld a, $1
	ld [wIntroSceneTimer], a
	ld a, [wGlobalAnimXOffset]
	cp $88
	jr c, .asm_e4e2c
	sub $8
	ld [wGlobalAnimXOffset], a
	ret

.asm_e4e2c
	farjp DeinitializeAllSprites

.asm_e4e33
	ld a, [wGlobalAnimXOffset]
	sub $2
	ld [wGlobalAnimXOffset], a
	ret

IntroScene15:
; Transition to a new scene.
	call Intro_ClearBGPals
	call ClearSprites
	call ClearTileMap
	xor a
	ldh [hBGMapMode], a
	ld a, $1
	ldh [rVBK], a
	ld hl, IntroTilemap009
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles
	xor a
	ldh [rVBK], a
	ld hl, IntroSuicuneJumpGFX
	ld de, vTiles2 tile $00
	call Intro_DecompressRequest2bpp_128Tiles
	ld hl, IntroUnownBackGFX
	ld de, vTiles0 tile $00
	call Intro_DecompressRequest2bpp_128Tiles
	ld de, IntroGrass4GFX
	ld hl, vTiles1 tile $00
	lb bc, BANK(IntroGrass4GFX), 1
	call Request2bpp
	ld hl, IntroTilemap010
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles
	call Intro_LoadTilemap
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld hl, Palette_e77dd
	ld de, wBGPals1
	ld bc, 16 palettes
	rst CopyBytes
	ld hl, Palette_e77dd
	ld de, wBGPals2
	ld bc, 16 palettes
	rst CopyBytes
	pop af
	ldh [rSVBK], a
	xor a
	ldh [hSCX], a
	ld a, $90
	ldh [hSCY], a
	ld a, $7
	ldh [hWX], a
	ld a, $90
	ldh [hWY], a
	call ClearSpriteAnims
	call Intro_SetCGBPalUpdate
	depixel 8, 5
	ld a, SPRITE_ANIM_INDEX_INTRO_UNOWN_F
	call _InitSpriteAnimStruct
	depixel 12, 0
	ld a, SPRITE_ANIM_INDEX_INTRO_SUICUNE_AWAY
	call _InitSpriteAnimStruct
	xor a
	ld [wIntroSceneFrameCounter], a
	ld [wIntroSceneTimer], a
	jmp NextIntroScene

IntroScene16:
; Suicune shows its face. An Unown appears in front.
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	inc [hl]
	cp $80
	jmp nc, NextIntroScene
	call Intro_Scene16_AnimateSuicune
	ldh a, [hSCY]
	and a
	ret z
	add 8
	ldh [hSCY], a
	ret

IntroScene17:
; ...
	call Intro_ClearBGPals
	call ClearSprites
	call ClearTileMap
	xor a
	ldh [hBGMapMode], a
	ld a, $1
	ldh [rVBK], a
	ld hl, IntroTilemap011
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles
	xor a
	ldh [rVBK], a
	ld hl, IntroSuicuneCloseGFX
	ld de, vTiles1 tile $00
	call Intro_DecompressRequest2bpp_255Tiles
	ld hl, IntroTilemap012
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld hl, Palette_e6d6d
	ld de, wBGPals1
	ld bc, 16 palettes
	rst CopyBytes
	ld hl, Palette_e6d6d
	ld de, wBGPals2
	ld bc, 16 palettes
	rst CopyBytes
	pop af
	ldh [rSVBK], a
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	ld a, $7
	ldh [hWX], a
	ld a, $90
	ldh [hWY], a
	call ClearSpriteAnims
	call Intro_SetCGBPalUpdate
	xor a
	ld [wIntroSceneFrameCounter], a
	ld [wIntroSceneTimer], a
	jmp NextIntroScene

IntroScene18:
; Suicune close up.
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	inc [hl]
	cp $60
	jmp nc, NextIntroScene
	ldh a, [hSCX]
	cp $60
	ret z
	add 8
	ldh [hSCX], a
	ret

IntroScene19:
; More setup.
	call Intro_ClearBGPals
	call ClearSprites
	call ClearTileMap
	xor a
	ldh [hBGMapMode], a
	ld a, $1
	ldh [rVBK], a
	ld hl, IntroTilemap013
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles
	xor a
	ldh [rVBK], a
	ld hl, IntroSuicuneBackGFX
	ld de, vTiles2 tile $00
	call Intro_DecompressRequest2bpp_128Tiles
	ld hl, IntroUnownsGFX
	ld de, vTiles1 tile $00
	call Intro_DecompressRequest2bpp_128Tiles
	ld de, IntroGrass4GFX
	ld hl, vTiles1 tile $7f
	lb bc, BANK(IntroGrass4GFX), 1
	call Request2bpp
	ld hl, IntroTilemap014
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles
	call Intro_LoadTilemap
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld hl, Palette_e77dd
	ld de, wBGPals1
	ld bc, 16 palettes
	rst CopyBytes
	ld hl, Palette_e77dd
	ld de, wBGPals2
	ld bc, 16 palettes
	rst CopyBytes
	pop af
	ldh [rSVBK], a
	xor a
	ldh [hSCX], a
	ld a, $d8
	ldh [hSCY], a
	ld a, $7
	ldh [hWX], a
	ld a, $90
	ldh [hWY], a
	call ClearSpriteAnims
	ld hl, wSpriteAnimDict
	xor a
	ld [hli], a
	ld [hl], $7f
	call Intro_SetCGBPalUpdate
	depixel 12, 0
	ld a, SPRITE_ANIM_INDEX_INTRO_SUICUNE_AWAY
	call _InitSpriteAnimStruct
	xor a
	ld [wIntroSceneFrameCounter], a
	ld [wIntroSceneTimer], a
	jmp NextIntroScene

IntroScene20:
; Suicune running away. A bunch of Unown appear.
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	inc [hl]
	cp $98
	jmp nc, NextIntroScene
	cp $58
	ret nc
	cp $40
	jr nc, .AppearUnown
	cp $28
	ret nc
	ldh a, [hSCY]
	inc a
	ldh [hSCY], a
	ret

.AppearUnown:
	sub $18
	ld c, a
	and $3
	cp $3
	ret nz
	ld a, c
	and $1c
	srl a
	srl a
	ld [wIntroSceneTimer], a
	jmp Intro_Scene20_AppearUnown

IntroScene21:
; Suicune gets more distant and turns black.
	call Intro_ColoredSuicuneFrameSwap
	ld c, 3
	call DelayFrames
	xor a
	ldh [hBGMapMode], a
	ld [wIntroSceneFrameCounter], a
	ld [wIntroSceneTimer], a
	jmp NextIntroScene

IntroScene22:
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	inc [hl]
	cp $8
	ret c
	farcall DeinitializeAllSprites
	jmp NextIntroScene

IntroScene23:
	xor a
	ld [wIntroSceneFrameCounter], a
	jmp NextIntroScene

IntroScene24:
; Fade to white.
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	inc [hl]
	cp $20
	jr nc, .done

	ld c, a
	and $3
	ret nz

	ld a, c
	and $1c
	sla a
	jmp Intro_Scene24_ApplyPaletteFade

.done
	ld a, $40
	ld [wIntroSceneFrameCounter], a
	jmp NextIntroScene

IntroScene25:
; Wait around a bit.
	ld a, [wIntroSceneFrameCounter]
	dec a
	jmp z, NextIntroScene
	ld [wIntroSceneFrameCounter], a
	ret

IntroScene26:
; Load the final scene.
	call ClearBGPalettes
	call ClearSprites
	call ClearTileMap
	xor a
	ldh [hBGMapMode], a
	ld a, $1
	ldh [rVBK], a
	ld hl, IntroTilemap015
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles
	xor a
	ldh [rVBK], a
	ld hl, IntroCrystalUnownsGFX
	ld de, vTiles2 tile $00
	call Intro_DecompressRequest2bpp_128Tiles
	ld hl, IntroTilemap017
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld hl, Palette_e679d
	ld de, wBGPals1
	ld bc, 16 palettes
	rst CopyBytes
	ld hl, Palette_e679d
	ld de, wBGPals2
	ld bc, 16 palettes
	rst CopyBytes
	pop af
	ldh [rSVBK], a
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	ld a, $7
	ldh [hWX], a
	ld a, $90
	ldh [hWY], a
	call ClearSpriteAnims
	call Intro_SetCGBPalUpdate
	xor a
	ld [wIntroSceneFrameCounter], a
	ld [wIntroSceneTimer], a
	jmp NextIntroScene

IntroScene27:
; Spell out C R Y S T A L with Unown.
	ld hl, wIntroSceneTimer
	inc [hl]
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	inc [hl]
	cp $80
	jr nc, .done

	ld c, a
	and $f
	ld [wIntroSceneTimer], a
	ld a, c
	and $70
	swap a
	jmp Intro_FadeUnownWordPals

.done
	call NextIntroScene
	ld a, $ff
	ld [wIntroSceneFrameCounter], a
	ret

IntroScene28:
; Cut out when the music ends, and lead into the title screen.
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	and a
	jr z, .done
	dec [hl]
	cp $30
	jmp z, ClearBGPalettes
	cp $10
	ret nz
	ld de, SFX_TITLE_SCREEN_INTRO
	jmp PlaySFX

.done
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

Intro_Scene24_ApplyPaletteFade:
; load the (a)th palette from .FadePals to all wBGPals2
	ld hl, .FadePals
	ld e, a
	ld d, 0
	add hl, de

	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld de, wBGPals2
	ld b, 8 ; number of BG pals
.loop1
	push hl
	ld c, 8 ; number of bytes per pal
.loop2
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop2
	pop hl
	dec b
	jr nz, .loop1
	pop af
	ldh [rSVBK], a
	ld a, $1
	ldh [hCGBPalUpdate], a
	ret

.FadePals:
; Fade to white.
if !DEF(MONOCHROME)
	RGB 24, 12, 09
	RGB 31, 31, 31
	RGB 12, 00, 31
	RGB 00, 00, 00

	RGB 31, 19, 05
	RGB 31, 31, 31
	RGB 15, 05, 31
	RGB 07, 07, 07

	RGB 31, 21, 09
	RGB 31, 31, 31
	RGB 18, 09, 31
	RGB 11, 11, 11

	RGB 31, 23, 13
	RGB 31, 31, 31
	RGB 21, 13, 31
	RGB 15, 15, 15

	RGB 31, 25, 17
	RGB 31, 31, 31
	RGB 25, 17, 31
	RGB 19, 19, 19

	RGB 31, 27, 21
	RGB 31, 31, 31
	RGB 27, 21, 31
	RGB 23, 23, 23

	RGB 31, 29, 25
	RGB 31, 31, 31
	RGB 29, 26, 31
	RGB 27, 27, 27

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
else
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK

	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK

	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_DARK

	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_DARK

	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_LIGHT

	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_LIGHT

	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE

	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
endc

CrystalIntro_InitUnownAnim:
	push de
	ld a, SPRITE_ANIM_INDEX_INTRO_UNOWN
	call _InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $8
	ld a, SPRITE_ANIM_FRAMESET_INTRO_UNOWN_4
	call ReinitSpriteAnimFrame
	pop de

	push de
	ld a, SPRITE_ANIM_INDEX_INTRO_UNOWN
	call _InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $18
	ld a, SPRITE_ANIM_FRAMESET_INTRO_UNOWN_3
	call ReinitSpriteAnimFrame
	pop de

	push de
	ld a, SPRITE_ANIM_INDEX_INTRO_UNOWN
	call _InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $28
	ld a, SPRITE_ANIM_FRAMESET_INTRO_UNOWN_1
	call ReinitSpriteAnimFrame
	pop de

	ld a, SPRITE_ANIM_INDEX_INTRO_UNOWN
	call _InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $38
	ld a, SPRITE_ANIM_FRAMESET_INTRO_UNOWN_2
	jmp ReinitSpriteAnimFrame

CrystalIntro_UnownFade:
	add a
	add a
	add a
	ld e, a
	ld d, $0
	ld hl, wBGPals2
	add hl, de
	inc hl
	inc hl
	ld a, [wIntroSceneTimer]
	and $3f
	cp $1f + 1
	jr c, .okay
	cpl
	add $3f + 1 ; a = $3f - a
.okay
	ld c, a
	ld b, $0
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a

	push hl
	push bc
	ld hl, wBGPals2
if !DEF(MONOCHROME)
	ld bc, 8 palettes
	xor a ; RGB 00,00,00
	rst ByteFill
else
	ld b, (8 palettes) / 2
.mono_loop
	ld a, LOW(PAL_MONOCHROME_BLACK)
	ld [hli], a
	ld a, HIGH(PAL_MONOCHROME_BLACK)
	ld [hli], a
	dec b
	jr nz, .mono_loop
endc
	pop bc
	pop hl

	push hl
	ld hl, .BWFade
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a

	push hl
	ld hl, .BlackLBlueFade
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a

	push hl
	ld hl, .BlackBlueFade
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a

	pop af
	ldh [rSVBK], a
	ld a, $1
	ldh [hCGBPalUpdate], a
	ret

.BWFade:
; Fade between black and white.
if !DEF(MONOCHROME)
for hue, 32
	RGB hue, hue, hue
endr
else
rept 8
	RGB_MONOCHROME_BLACK
endr
rept 8
	RGB_MONOCHROME_DARK
endr
rept 8
	RGB_MONOCHROME_LIGHT
endr
rept 8
	RGB_MONOCHROME_WHITE
endr
endc

.BlackLBlueFade:
; Fade between black and light blue.
if !DEF(MONOCHROME)
for hue, 32
	RGB 0, hue / 2, hue
endr
else
rept 8
	RGB_MONOCHROME_BLACK
endr
rept 8
	RGB_MONOCHROME_DARK
endr
rept 8
	RGB_MONOCHROME_LIGHT
endr
rept 8
	RGB_MONOCHROME_LIGHT
endr
endc

.BlackBlueFade:
; Fade between black and blue.
if !DEF(MONOCHROME)
for hue, 32
	RGB 0, 0, hue
endr
else
rept 8
	RGB_MONOCHROME_BLACK
endr
rept 8
	RGB_MONOCHROME_DARK
endr
rept 8
	RGB_MONOCHROME_DARK
endr
rept 8
	RGB_MONOCHROME_DARK
endr
endc

Intro_Scene20_AppearUnown:
; Spawn the palette for the nth Unown
	ld a, [wIntroSceneTimer]
	and $7
	add a
	add a
	add a
	ld c, a
	ld b, 0

	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a

	push bc
	ld hl, wBGPals2
	call .copypal
	pop bc

	ld hl, wBGPals1
	call .copypal

	pop af
	ldh [rSVBK], a

	ld a, $1
	ldh [hCGBPalUpdate], a
	ret

.copypal:
	add hl, bc
	ld d, h
	ld e, l
	ld hl, .pal
	ld c, 8 ; b is already 0
	rst CopyBytes
	ret

.pal
if !DEF(MONOCHROME)
	RGB 24, 12, 09
	RGB 31, 31, 31
	RGB 12, 00, 31
	RGB 00, 00, 00
else
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc

Intro_FadeUnownWordPals:
	add a
	add a
	add a
	ld e, a
	ld d, $0
	ld hl, wBGPals2
	add hl, de
rept 4
	inc hl
endr
	ld a, [wIntroSceneTimer]
	add a
	ld c, a
	ld b, $0

	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a

	push hl
	ld hl, .FastFadePalettes
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a

	push hl
	ld hl, .SlowFadePalettes
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a

	pop af
	ldh [rSVBK], a
	ld a, $1
	ldh [hCGBPalUpdate], a
	ret

.FastFadePalettes:
if !DEF(MONOCHROME)
for hue, 31, 9, -3
	RGB hue, hue, hue
	RGB hue - 1, hue - 1, hue - 1
endr
else
rept 4
	RGB_MONOCHROME_WHITE
endr
rept 4
	RGB_MONOCHROME_LIGHT
endr
rept 4
	RGB_MONOCHROME_DARK
endr
rept 4
	RGB_MONOCHROME_BLACK
endr
endc

.SlowFadePalettes:
if !DEF(MONOCHROME)
for hue, 31, 15, -1
	RGB hue, hue, hue
endr
else
rept 8
	RGB_MONOCHROME_WHITE
endr
rept 8
	RGB_MONOCHROME_DARK
endr
endc

Intro_LoadTilemap:
	ldh a, [rSVBK]
	push af
	ld a, $6
	ldh [rSVBK], a

	ld hl, wScratchTileMap
	decoord 0, 0
	ld b, SCREEN_HEIGHT
.row
	ld c, SCREEN_WIDTH
.col
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .col
; "add hl, BG_MAP_WIDTH - SCREEN_WIDTH"
; 6 bytes, 12 cycles
	push de
	ld de, BG_MAP_WIDTH - SCREEN_WIDTH
	add hl, de
	pop de
;; 8 bytes, 8 cycles
;	ld a, BG_MAP_WIDTH - SCREEN_WIDTH
;	add l
;	ld l, a
;	ld a, 0
;	adc h
;	ld h, a
	dec b
	jr nz, .row

	pop af
	ldh [rSVBK], a
	ret

Intro_Scene16_AnimateSuicune:
	ld a, [wIntroSceneFrameCounter]
	and $3
	jr z, Intro_ColoredSuicuneFrameSwap
	cp $3
	ret nz
	xor a
	ldh [hBGMapMode], a
	ret

Intro_ColoredSuicuneFrameSwap:
	hlcoord 0, 0
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
.loop
	ld a, [hl]
	and a
	jr z, .skip
	cp $80
	jr nc, .skip
	xor $8
	ld [hl], a
.skip
	inc hl
	dec bc
	ld a, c
	or b
	jr nz, .loop
	ld a, $1
	ldh [hBGMapMode], a
	ret

Intro_RustleGrass:
	ld a, [wIntroSceneFrameCounter]
	cp 36
	ret nc
	and $c
	srl a
	ld e, a
	ld d, $0
	ld hl, .RustlingGrassPointers
	add hl, de
	ld a, [hli]
	ldh [hRequestedVTileSource], a
	ld a, [hli]
	ldh [hRequestedVTileSource + 1], a
	ld a, LOW(vTiles2 tile $09)
	ldh [hRequestedVTileDest], a
	ld a, HIGH(vTiles2 tile $09)
	ldh [hRequestedVTileDest + 1], a
	ld a, 4
	ldh [hRequested2bpp], a
	ret

.RustlingGrassPointers:
	dw IntroGrass1GFX
	dw IntroGrass2GFX
	dw IntroGrass3GFX
	dw IntroGrass2GFX

Intro_SetCGBPalUpdate:
	ld a, $1
	ldh [hCGBPalUpdate], a
	ret

Intro_ClearBGPals:
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a

; Fill wBGPals2 and wOBPals2 with $0000 (black)
	ld hl, wBGPals2
if !DEF(MONOCHROME)
	ld bc, 16 palettes
	xor a ; RGB 00,00,00
	rst ByteFill
else
	ld b, (16 palettes) / 2
.mono_loop
	ld a, LOW(PAL_MONOCHROME_BLACK)
	ld [hli], a
	ld a, HIGH(PAL_MONOCHROME_BLACK)
	ld [hli], a
	dec b
	jr nz, .mono_loop
endc

	pop af
	ldh [rSVBK], a
	ld a, $1
	ldh [hCGBPalUpdate], a
	ld c, 64
	jmp DelayFrames

Intro_DecompressRequest2bpp_64Tiles:
	lb bc, 1, 64
	jr Intro_DecompressRequest2bpp

Intro_DecompressRequest2bpp_128Tiles:
	lb bc, 1, 128
	jr Intro_DecompressRequest2bpp

Intro_DecompressRequest2bpp_255Tiles:
	lb bc, 1, 255
Intro_DecompressRequest2bpp:
	ldh a, [rSVBK]
	push af
	ld a, $6
	ldh [rSVBK], a

	push bc
	push de
	ld de, wDecompressScratch
	call Decompress
	pop hl
	pop bc

	ld de, wDecompressScratch
	call Request2bpp

	pop af
	ldh [rSVBK], a
	ret

Intro_ResetLYOverrides:
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a

	ld hl, wLYOverrides
	ld bc, wLYOverridesEnd - wLYOverrides
	xor a
	rst ByteFill

	pop af
	ldh [rSVBK], a
	ld a, LOW(rSCX)
	ldh [hLCDCPointer], a
	ret

Intro_PerspectiveScrollBG:
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	; Scroll the grass every frame.
	; Scroll the trees every other frame and at half speed.
	; This creates an illusion of perspective.
	ld a, [wIntroSceneFrameCounter]
	and $1
	jr z, .skip
	; trees in the back
	ld hl, wLYOverrides
	ld a, [hl]
	inc a
	ld bc, $5f
	rst ByteFill
.skip
	; grass in the front
	ld hl, wLYOverrides + $5f
	ld a, [hl]
	inc a
	inc a
	ld bc, $31
	rst ByteFill
	ld a, [wLYOverrides + 0]
	ldh [hSCX], a
	pop af
	ldh [rSVBK], a
	ret

IntroSuicuneRunGFX:
INCBIN "gfx/intro/suicune_run.2bpp.lz"

IntroPichuWooperGFX:
INCBIN "gfx/intro/pichu_wooper.2bpp.lz"

IntroTilemap003:
INCBIN "gfx/intro/003.tilemap.lz"

Intro_SetupCommonScenery:
	ld hl, IntroBackgroundGFX
	ld de, vTiles2 tile $00
	call Intro_DecompressRequest2bpp_128Tiles

	ld hl, IntroTilemap004
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles

	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a

	ld hl, Palette_e5edd
	ld de, wBGPals1
	ld bc, 16 palettes
	rst CopyBytes

	ld hl, Palette_e5edd
	ld de, wBGPals2
	ld bc, 16 palettes
	rst CopyBytes

	pop af
	ldh [rSVBK], a

	xor a
	ldh [hSCX], a
	ldh [hSCY], a

	ld a, $7
	ldh [hWX], a

	ld a, $90
	ldh [hWY], a
	ret

IntroBackgroundGFX:
INCBIN "gfx/intro/background.2bpp.lz"

IntroTilemap004:
INCBIN "gfx/intro/004.tilemap.lz"

Palette_e5edd:
if !DEF(MONOCHROME)
	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB  0,  4,  5
	RGB  1,  8,  5
	RGB  4, 12,  9
	RGB 24, 12,  9

	RGB  0,  4,  5
	RGB  9,  6,  8
	RGB  8, 16,  5
	RGB  5, 10,  4

	RGB 31, 31, 31
	RGB  9,  6,  8
	RGB 18,  9,  9
	RGB 13,  8,  9

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB  2,  5, 22
	RGB  1,  5, 12

	RGB 31, 31, 31
	RGB 31, 10, 25
	RGB 31, 21,  0
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 21, 31
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0
else
	MONOCHROME_RGB_FOUR
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_BLACK
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
endc

IntroUnownsGFX:
INCBIN "gfx/intro/unowns.2bpp.lz"

IntroPulseGFX:
INCBIN "gfx/intro/pulse.2bpp.lz"

IntroTilemap002:
INCBIN "gfx/intro/002.tilemap.lz"

IntroTilemap001:
INCBIN "gfx/intro/001.tilemap.lz"

IntroTilemap006:
INCBIN "gfx/intro/006.tilemap.lz"

IntroTilemap005:
INCBIN "gfx/intro/005.tilemap.lz"

IntroTilemap008:
INCBIN "gfx/intro/008.tilemap.lz"

IntroTilemap007:
INCBIN "gfx/intro/007.tilemap.lz"

Palette_365ad:
if !DEF(MONOCHROME)
	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0

	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0

	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0

	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0

	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0

	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0

	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0

	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 10,  0, 10
	RGB 19,  0, 19
	RGB 31,  0, 31

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0
else
rept 8
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_BLACK
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_LIGHT
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
endc

IntroCrystalUnownsGFX:
INCBIN "gfx/intro/crystal_unowns.2bpp.lz"

IntroTilemap017:
INCBIN "gfx/intro/017.tilemap.lz"

IntroTilemap015:
INCBIN "gfx/intro/015.tilemap.lz"

Palette_e679d:
if !DEF(MONOCHROME)
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0
else
rept 8
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
endr
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
endc

IntroSuicuneCloseGFX:
INCBIN "gfx/intro/suicune_close.2bpp.lz"

IntroTilemap012:
INCBIN "gfx/intro/012.tilemap.lz"

IntroTilemap011:
INCBIN "gfx/intro/011.tilemap.lz"

Palette_e6d6d:
if !DEF(MONOCHROME)
	RGB 24, 12,  9
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 24, 12,  9
	RGB 31, 31, 31
	RGB  8,  9, 31
	RGB  0,  0,  0

	RGB 24, 12,  9
	RGB 12, 20, 31
	RGB 19,  8, 31
	RGB  0,  0,  0

	RGB 12, 20, 31
	RGB  8,  9, 31
	RGB 19,  8, 31
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 12, 20, 31
	RGB  8,  9, 31
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0
else
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
endc

IntroSuicuneJumpGFX:
INCBIN "gfx/intro/suicune_jump.2bpp.lz"

IntroSuicuneBackGFX:
INCBIN "gfx/intro/suicune_back.2bpp.lz"

IntroTilemap010:
INCBIN "gfx/intro/010.tilemap.lz"

IntroTilemap009:
INCBIN "gfx/intro/009.tilemap.lz"

IntroTilemap014:
INCBIN "gfx/intro/014.tilemap.lz"

IntroTilemap013:
INCBIN "gfx/intro/013.tilemap.lz"

Palette_e77dd:
if !DEF(MONOCHROME)
	RGB 24, 12,  9
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 24, 12,  9
	RGB 31, 31, 31
	RGB  8,  9, 31
	RGB  0,  0,  0

	RGB 24, 12,  9
	RGB 24, 12,  9
	RGB 24, 12,  9
	RGB 24, 12,  9

	RGB 24, 12,  9
	RGB 24, 12,  9
	RGB 24, 12,  9
	RGB 24, 12,  9

	RGB 24, 12,  9
	RGB 24, 12,  9
	RGB 24, 12,  9
	RGB 24, 12,  9

	RGB 24, 12,  9
	RGB 24, 12,  9
	RGB 24, 12,  9
	RGB 24, 12,  9

	RGB 24, 12,  9
	RGB 24, 12,  9
	RGB 24, 12,  9
	RGB 24, 12,  9

	RGB 24, 12,  9
	RGB 24, 12,  9
	RGB 24, 12,  9
	RGB 24, 12,  9

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 12,  0, 31
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 21,  9,  0
	RGB 21,  9,  0
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0
else
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 6
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_LIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
endc

IntroUnownBackGFX:
INCBIN "gfx/intro/unown_back.2bpp.lz"

IntroGrass1GFX:
INCBIN "gfx/intro/grass1.2bpp"
IntroGrass2GFX:
INCBIN "gfx/intro/grass2.2bpp"
IntroGrass3GFX:
INCBIN "gfx/intro/grass3.2bpp"
IntroGrass4GFX:
INCBIN "gfx/intro/grass4.2bpp"
