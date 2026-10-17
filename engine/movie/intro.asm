SECTION "Intro movie", ROMX

CrystalIntro:
	ld a, BANK(wLYOverrides)
	assert BANK(wLYOverrides) == BANK(wBGPals1) ; ...and the other palette buffers.
	ldh [rWBK], a
	xor a
	ldh [hVBlank], a
	ldh [hMapAnims], a
	ld [wJumptableIndex], a
	assert NO_BG_MAP_TRANSFER == 0
	ldh [hBGMapMode], a ; Disable BG map transfers since this movie doesn't use them.
	inc a ; a := 1
	ldh [hInMenu], a

.loop
	call JoyTextDelay
	ldh a, [hJoyLast]
	and PAD_BUTTONS
	ld e, MUSIC_NONE
	jmp nz, PlayMusic ; If something was pressed, kill the music and exit.

	call .Dispatch
	farcall PlaySpriteAnimations
	call DelayFrame
	jr .loop

.Dispatch:
	call StandardStackJumpTable

.Jumptable:
	dw Scene_UnownA_Setup
	dw Scene_UnownA
	dw Scene_ScrollOutdoors_Setup
	dw Scene_ScrollOutdoors
	dw Scene_UnownHI_Setup
	dw Scene_UnownHI
	dw Scene_ScrollThenSuicuneZoomingBy_Setup
	dw Scene_ScrollThenSuicuneZoomingBy
	dw Scene_GrassRustleThenWooperAndPichu_Setup
	dw Scene_GrassRustleThenWooperAndPichu
	dw Scene_Unowns_Setup
	dw Scene_Unowns
	dw Scene_SuicuneRunsThenJumps_Setup
	dw Scene_SuicuneRunsThenJumps
	dw Scene_SuicuneAppears_Setup
	dw Scene_SuicuneAppears
	dw Scene_SuicuneCloseUp_Setup
	dw Scene_SuicuneCloseUp
	dw Scene_UnownsAroundSuicune_Setup
	dw Scene_UnownsAroundSuicune
	dw Scene_SuicuneFadesAway
	dw Scene_WaitAndDeinitSprites
	dw Scene_ResetFrameCounter
	dw Scene_FadeToWhite
	dw Scene_Wait
	dw Scene_SpellOut_Setup
	dw Scene_SpellOut
	dw Scene_FinalFadeOut
	dw Exit

Exit:
	pop af ; Do not return to the caller, exit `CrystalIntro`, do not receive 2000 Pokédollars...
	ret

NextIntroScene:
	ld hl, wJumptableIndex
	inc [hl]
	ret

Scene_UnownA_Setup:
; Setup the next scene.
	call CutToBlackAndPause
	ld hl, UnownsGFX
	ld de, vTiles2 tile $00
	call DecompressAndLoad128Tiles
	ld hl, PulseGFX
	ld de, vTiles0 tile $00
	call DecompressAndLoad128Tiles
	ld hl, IntroBGMaps.UnownA
	call DecompressAndLoadMap0
	call ResetScrollingAndFillBothPalBufsWithUnownPal
	call ClearSpriteAnims
	xor a
	ld [wIntroSceneFrameCounter], a
	ld [wIntroSceneTimer], a
	jr NextIntroScene

Scene_UnownA:
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

Scene_ScrollOutdoors_Setup:
; More setup. Transition to the outdoor scene.
	call CutToBlackAndPause
	; Load the outdoor map to BG map 1, where it will stay for the next few scenes.
	ld hl, IntroBGMaps.Outdoors
	ld de, vBGMap1
	call DecompressAndLoadMapTo
	; The above will also have decompressed its tiles; load them to somewhere they won't be overwritten by subsequent scenes.
	ld a, 1
	ldh [rVBK], a
	debgcoord 0, SCREEN_HEIGHT * 2, wDecompressScratch ; The tiles will be after both maps.
	ld hl, vTiles5 tile 77
	ld c, 39 + 3 * 4 ; The base picture, plus the four grass animations.
	call Request2bppInWRA6
	call SetupOutdoors
	xor a
	ld [wIntroSceneFrameCounter], a
	jr NextIntroScene

Scene_ScrollOutdoors:
; Scroll the outdoor panorama for a bit.
	call PerspectiveScrollBG
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	cp $80
	jr z, NextIntroScene
	inc [hl]
	ret

Scene_UnownHI_Setup:
; Go back to the Unown.
	call CutToBlackAndPause
	ld hl, rIE
	res B_IE_STAT, [hl]
	ldh [hLCDCPointer], a
	ld hl, IntroBGMaps.UnownHI
	call DecompressAndLoadMap0
	ld hl, PulseGFX
	ld de, vTiles0 tile $00
	call DecompressAndLoad128Tiles
	; Switch back to the 9800 tilemap.
	ld a, LCDC_DEFAULT
	ldh [rLCDC], a

	call ResetScrollingAndFillBothPalBufsWithUnownPal

	call ClearSpriteAnims
	xor a
	ld [wIntroSceneFrameCounter], a
	ld [wIntroSceneTimer], a
	jmp NextIntroScene

Scene_UnownHI:
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
	ld a, 1 palettes
	jmp CrystalIntro_UnownFade

Scene_ScrollThenSuicuneZoomingBy_Setup:
; Back to the outdoor scene.
	call CutToBlackAndPause

	xor a
	ldh [rVBK], a
	ld hl, SuicuneRunGFX
	ld de, vTiles0 tile $00
	call DecompressAndLoad255Tiles
	ld a, $1
	ldh [rVBK], a
	ld hl, PichuWooperGFX
	ld de, vTiles0 tile $00
	call DecompressAndLoad128Tiles

	call SetupOutdoors

	call ClearSpriteAnims
	depixel 13, 27, 4, 0
	ld a, SPRITE_ANIM_INDEX_INTRO_SUICUNE
	call InitSpriteAnimStruct
	ld a, $f0
	ld [wGlobalAnimXOffset], a
	xor a
	ld [wIntroSceneFrameCounter], a
	ld [wIntroSceneTimer], a
	jmp NextIntroScene

Scene_ScrollThenSuicuneZoomingBy:
; Scroll the scene, then show Suicune running across the screen.
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	inc [hl]
	cp $40
	jr z, .suicune_sound
	jr nc, .animate_suicune
	jmp PerspectiveScrollBG

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

Scene_GrassRustleThenWooperAndPichu_Setup:
; Set up the next scene (same bg).
	ld hl, rIE
	res B_IE_STAT, [hl]
	xor a
	ldh [hLCDCPointer], a
	ld [wIntroSceneFrameCounter], a
	ld a, $c
	ld [wGlobalAnimXOffset], a
	jmp NextIntroScene

Scene_GrassRustleThenWooperAndPichu:
; Wooper and Pichu enter.
	call RustleGrass
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
	call InitSpriteAnimStruct
	ld de, SFX_INTRO_PICHU
	jmp PlaySFX

Scene_Unowns_Setup:
; Back to Unown again.
	call CutToBlackAndPause
	call ClearSprites
	ld hl, rIE
	res B_IE_STAT, [hl]
	ldh [hLCDCPointer], a
	ld hl, IntroBGMaps.Unowns
	call DecompressAndLoadMap0
	; Switch back to the 9800 tilemap.
	ld a, LCDC_DEFAULT
	ldh [rLCDC], a

	call ResetScrollingAndFillBothPalBufsWithUnownPal

	call ClearSpriteAnims
	xor a
	ld [wIntroSceneFrameCounter], a
	ld [wIntroSceneTimer], a
	jmp NextIntroScene

Scene_Unowns:
; Even more Unown.
	call .PlayUnownSound
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	inc [hl]
	cp $c0
	jmp nc, NextIntroScene
	add a ; Double, and check if bit 7 is set.
	jr nc, .first_half ; Second half plays over the latter 4 palettes at double speed.
	adc a ; Double the speed, and set bit 0 (carry is set right now).
.first_half
	ld c, a
	and $3e ; Ignore bit 0, it's actually part of the palette index.
	ld [wIntroSceneTimer], a
	xor c ; `ld a, c :: and $C1`, thus giving us the palette ID * 64 (wrapped around A).
	swap a ; Contains palette ID * 4...
	add a ; ...now * 8 = offset within wBGPals1.
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

Scene_SuicuneRunsThenJumps_Setup:
; Switch scenes again.
	call CutToBlackAndPause
	ld hl, SuicuneRunGFX
	ld de, vTiles0 tile $00
	call DecompressAndLoad255Tiles
	call SetupOutdoors.noScrollingReset
	call ClearSpriteAnims
	depixel 13, 11, 4, 0
	ld a, SPRITE_ANIM_INDEX_INTRO_SUICUNE
	call InitSpriteAnimStruct
	ld e, MUSIC_CRYSTAL_OPENING
	call PlayMusic
	xor a
	ld [wGlobalAnimXOffset], a
	xor a
	ld [wIntroSceneFrameCounter], a
	ld [wIntroSceneTimer], a
	jmp NextIntroScene

Scene_SuicuneRunsThenJumps:
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
	jr nc, .run_after_jump
	cp $40
	jr nc, .run
	ret

.jump
	ld de, SFX_INTRO_SUICUNE_4
	call PlaySFX

.run_after_jump
	ld a, $1
	ld [wIntroSceneTimer], a
	ld a, [wGlobalAnimXOffset]
	cp $88
	jr c, .disappear
	sub $8
	ld [wGlobalAnimXOffset], a
	ret

.disappear
	farjp DeinitializeAllSprites

.run
	ld a, [wGlobalAnimXOffset]
	sub $2
	ld [wGlobalAnimXOffset], a
	ret

Scene_SuicuneAppears_Setup:
; Transition to a new scene.
	call CutToBlackAndPause
	ld hl, SuicuneJumpGFX
	ld de, vTiles2 tile $00
	call DecompressAndLoad128Tiles
	ld hl, UnownBackGFX
	ld de, vTiles0 tile $00
	call DecompressAndLoad128Tiles
	ld de, Grass4GFX
	ld hl, vTiles1 tile $00
	lb bc, BANK(Grass4GFX), 1
	call Request2bpp
	ld hl, IntroBGMaps.SuicuneJump
	call DecompressAndLoadMap0
	; Switch back to the 9800 tilemap.
	ld a, LCDC_DEFAULT
	ldh [rLCDC], a

	ld hl, SuicunePalette
	ld a, 144
	call SetScrollingAndFillBothPalBufs

	call ClearSpriteAnims
	depixel 8, 5
	ld a, SPRITE_ANIM_INDEX_INTRO_UNOWN_F
	call InitSpriteAnimStruct
	depixel 12, 0
	ld a, SPRITE_ANIM_INDEX_INTRO_SUICUNE_AWAY
	call InitSpriteAnimStruct
	xor a
	ld [wIntroSceneFrameCounter], a
	ld [wIntroSceneTimer], a
	jmp NextIntroScene

Scene_SuicuneAppears:
; Suicune shows its face. An Unown appears in front.
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	inc [hl]
	cp $80
	jmp nc, NextIntroScene
	call Scene_SuicuneAppears_AnimateSuicune
	ldh a, [hSCY]
	and a
	ret z
	add 8
	ldh [hSCY], a
	ret

Scene_SuicuneCloseUp_Setup:
; ...
	call CutToBlackAndPause
	ld hl, SuicuneCloseGFX
	ld de, vTiles1 tile $00
	call DecompressAndLoad255Tiles
	ld hl, IntroBGMaps.SuicuneClose
	call DecompressAndLoadMap0
	ld hl, SuicuneClosePalette
	call ResetScrollingAndFillBothPalBufs
	call ClearSpriteAnims
	xor a
	ld [wIntroSceneFrameCounter], a
	ld [wIntroSceneTimer], a
	jmp NextIntroScene

Scene_SuicuneCloseUp:
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

Scene_UnownsAroundSuicune_Setup:
; More setup.
	call CutToBlackAndPause
	ld hl, SuicuneBackGFX
	ld de, vTiles2 tile $00
	call DecompressAndLoad128Tiles
	ld hl, UnownsGFX
	ld de, vTiles1 tile $00
	call DecompressAndLoad128Tiles
	ld de, Grass4GFX
	ld hl, vTiles1 tile $7f
	lb bc, BANK(Grass4GFX), 1
	call Request2bpp
	ld hl, IntroBGMaps.SuicuneBack
	call DecompressAndLoadMap0
	ld hl, SuicunePalette
	ld a, $D8
	call SetScrollingAndFillBothPalBufs
	call ClearSpriteAnims
	ld hl, wSpriteAnimDict
	xor a
	ld [hli], a
	ld [hl], $7f
	depixel 12, 0
	ld a, SPRITE_ANIM_INDEX_INTRO_SUICUNE_AWAY
	call InitSpriteAnimStruct
	xor a
	ld [wIntroSceneFrameCounter], a
	ld [wIntroSceneTimer], a
	jmp NextIntroScene

Scene_UnownsAroundSuicune:
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
	or ~$3
	inc a
	ret nz
	ld a, c
	and $1c
	srl a
	srl a
	ld [wIntroSceneTimer], a
	jmp Scene_UnownsAroundSuicune_AppearUnown

Scene_SuicuneFadesAway:
; Suicune gets more distant and turns black.
	call ColoredSuicuneFrameSwap
	ld c, 3
	call DelayFrames
	ld [wIntroSceneFrameCounter], a
	ld [wIntroSceneTimer], a
	jmp NextIntroScene

Scene_WaitAndDeinitSprites:
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	inc [hl]
	cp $8
	ret c
	farcall DeinitializeAllSprites
	jmp NextIntroScene

Scene_ResetFrameCounter:
	xor a
	ld [wIntroSceneFrameCounter], a
	jmp NextIntroScene

Scene_FadeToWhite:
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
	add a
	jr Scene_FadeToWhite_ApplyPaletteFade

.done
	ld a, $40
	ld [wIntroSceneFrameCounter], a
	jmp NextIntroScene

Scene_Wait:
; Wait around a bit.
	ld a, [wIntroSceneFrameCounter]
	dec a
	jmp z, NextIntroScene
	ld [wIntroSceneFrameCounter], a
	ret

Scene_SpellOut_Setup:
; Load the final scene.
	call ClearPalettes
	ld hl, CrystalUnownsGFX
	ld de, vTiles2 tile $00
	call DecompressAndLoad128Tiles
	ld hl, IntroBGMaps.CrystalUnowns
	call DecompressAndLoadMap0
	ld hl, CrystalUnownsPalette
	call ResetScrollingAndFillBothPalBufs
	call ClearSpriteAnims
	xor a
	ld [wIntroSceneFrameCounter], a
	ld [wIntroSceneTimer], a
	jmp NextIntroScene

Scene_SpellOut:
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
	jmp FadeUnownWordPals

.done
	call NextIntroScene
	ld a, $ff
	ld [wIntroSceneFrameCounter], a
	ret

Scene_FinalFadeOut:
; Cut out when the music ends, and lead into the title screen.
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	and a
	jmp z, NextIntroScene
	dec [hl]
	cp $30
	jmp z, ClearBGPalettes
	cp $10
	ret nz
	ld de, SFX_TITLE_SCREEN_INTRO
	jmp PlaySFX

Scene_FadeToWhite_ApplyPaletteFade:
; load the (a)th palette from .FadePals to all wBGPals2
	ld hl, .FadePals
	ld e, a
	ld d, 0
	add hl, de

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
	jmp QueueCGBPalUpdate

.FadePals:
INCLUDE "gfx/intro/fade.pal"

CrystalIntro_InitUnownAnim:
	push de
	ld a, SPRITE_ANIM_INDEX_INTRO_UNOWN
	call InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $8
	ld a, SPRITE_ANIM_FRAMESET_INTRO_UNOWN_4
	call ReinitSpriteAnimFrame
	pop de

	push de
	ld a, SPRITE_ANIM_INDEX_INTRO_UNOWN
	call InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $18
	ld a, SPRITE_ANIM_FRAMESET_INTRO_UNOWN_3
	call ReinitSpriteAnimFrame
	pop de

	push de
	ld a, SPRITE_ANIM_INDEX_INTRO_UNOWN
	call InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $28
	ld a, SPRITE_ANIM_FRAMESET_INTRO_UNOWN_1
	call ReinitSpriteAnimFrame
	pop de

	ld a, SPRITE_ANIM_INDEX_INTRO_UNOWN
	call InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $38
	ld a, SPRITE_ANIM_FRAMESET_INTRO_UNOWN_2
	jmp ReinitSpriteAnimFrame

CrystalIntro_UnownFade:
	add LOW(wBGPals2) + 2 ; We fade from the second colour of palettes (the first remains black).
	ld e, a
	assert HIGH(wBGPals2) == HIGH(wOBPals2 - 1) ; The entire buffer fits within a single page.
	ld d, HIGH(wBGPals2)

	; Clear all palettes, in case some animation didn't reach step #31.
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

	; Compute the hue.
	ld a, [wIntroSceneTimer]
	and $3f ; The fade wraps around every 64 steps.
	cp $1f + 1
	jr c, .gotHue ; ...but the second half is the first one reversed.
	cpl
	add $3f + 1 ; a = $3f - a
.gotHue

	; Write the faded colors.
	ld l, e
	ld h, d

if !DEF(MONOCHROME)
	; Primer on GBC color format: %_bbb bbgg | gggr rrrr. (`_` is ignored by the hardware.)
	; Red is unshifted, but blue needs to be shifted left twice,
	; and green rotated three times and distributed across both bytes.
	ld c, a ; Red (%000r rrrr).
	rlca
	rlca
	ld b, a ; OK, we got blue (%0bbb bb00).
	swap a
	rrca ; Believe it or not, this is green (%ggg0 00gg) just wrapped around within a byte.
	ld d, a
	; First color:  `RGB hue, hue, hue`   (between black and white).
	and $e0 ; %ggg0 0000
	or c    ; %gggr rrrr
	ld [hli], a
	ld a, d ; %ggg0 00gg
	and $03 ; %0000 00gg
	or b    ; %0bbb bbgg
	ld [hli], a
	; Second color: `RGB 0, hue / 2, hue` (between black and light blue).
	rrc d ; Halve green (%gggg 000g); bit 4 is out of place, but we can just ignore it.
	ld a, d ; %gggg 000g
	and $e0 ; %ggg0 0000 (red = 0)
	ld [hli], a
	xor a   ; %0000 0000
	rr d    ; %0ggg g000 | g into carry...
	adc b   ; %0bbb bb0g
	ld [hli], a
	; Third color:  `RGB 0, 0, hue`       (between black and blue).
	xor a
	ld [hli], a
	ld [hl], b
else
	; Monochrome instead has three gradients, quantized to 4 steps:
	; the first one does the full range,
	; the second one is capped at PAL_MONOCHROME_LIGHT, and
	; the third one is capped at PAL_MONOCHROME_DARK.
	and $30
	jr z, .all_black ; $00 jumps.
	ld de, PAL_MONOCHROME_DARK
	cp $20 ; We have $10, $20, or $30...
	jr c, .three_identical ; $10 jumps.

	ld bc, .first_color
	jr nz, .full_gradient ; $30 jumps.
	inc bc ; Skip the first colour,
	inc bc ; so that we write LIGHT twice.
.full_gradient
	ld a, [bc]
	ld [hli], a
	inc bc
	ld a, [bc]
	ld [hli], a
	; Second color is always light.
	ld a, LOW(PAL_MONOCHROME_LIGHT)
	ld [hli], a
	ld a, HIGH(PAL_MONOCHROME_LIGHT)
	ld [hli], a
	; The last color is always dark.
	ld a, e
.write_last_color
	ld [hli], a
	ld [hl], d
endc

	jmp QueueCGBPalUpdate

if def(MONOCHROME) ; Little outlined helpers from above!
.first_color:
	dw PAL_MONOCHROME_WHITE, PAL_MONOCHROME_LIGHT

.all_black
	ld de, PAL_MONOCHROME_BLACK
.three_identical
	ld a, e
REPT 2
	ld [hli], a
	ld [hl], d
	assert HIGH(wBGPals2) == HIGH(wOBPals2 - 1) ; The entire buffer fits within a single page.
	inc l
ENDR
	jr .write_last_color
endc

Scene_UnownsAroundSuicune_AppearUnown:
; Spawn the palette for the nth Unown
	ld a, [wIntroSceneTimer]
	and $7
	add a
	add a
	add a
	ld c, a
	ld b, 0

	push bc
	ld hl, wBGPals2
	call .copypal
	pop bc

	ld hl, wBGPals1
	call .copypal

	jmp QueueCGBPalUpdate

.copypal:
	add hl, bc
	ld d, h
	ld e, l
	ld hl, .pal
	ld c, 8 ; b is already 0
	rst CopyBytes
	ret

.pal
INCLUDE "gfx/intro/unown.pal"

FadeUnownWordPals:
	add a
	add a
	add a
	ld e, a
	ld d, 0
	ld hl, wBGPals2 + 4
	add hl, de
	ld a, [wIntroSceneTimer]
	add a
	ld c, a
	ld b, $0


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

	jmp QueueCGBPalUpdate

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

Scene_SuicuneAppears_AnimateSuicune:
	ld a, [wIntroSceneFrameCounter]
	and 3 ; Animate every 4 frames.
	ret nz

; Iterate throughout the tilemap, and swap the two frames of Suicune.
ColoredSuicuneFrameSwap:
	hlbgcoord 0, 0
.loop
	ldh a, [rSTAT]
	and STAT_BUSY
	jr nz, .loop
	ld a, [hl]
	and a
	jr z, .skip
	cp $80
	jr nc, .skip
	xor $8
.skip
	ld [hli], a
	ld a, h
	cp $9A ; Stop when we have scanned all of the screen area, except the last two rows.
	jr nz, .loop
	ret

; Overwrite the grass tiles with the appropriate rustling cel.
; (This is done on every frame that this scene is active.)
RustleGrass:
	ld a, [wIntroSceneFrameCounter]
	cp 4 * 9 ; Animate the grass 8 times, but return *before* the beginning of the 9th loop.
	ret nc

	; Compute the cel's ID. We want to sway the grass left, middle, right, then middle again.
	add 4
	and $c ; Move to the next cel every 4 frames, looping around after the 4th.
	jr nz, .gotIndex ; `add 4` above turns [0, 4, 8, C] into [4, 8, C, 0]...
	ld a, 8 ; ...and we correct that last one to the same as the middle.
.gotIndex
	; The grass tiles are loaded in chunks of 4, starting at tile ID $74 ($9740).
	; Conveniently (wink wink), this means we only need to change the low byte of the source address
	; which we obtain by multiplying A by 16.
	swap a
	ldh [hRequestedVTileSource], a
	ld a, $97 ; Note that this assumes where the outdoors tiles are loaded.
	ldh [hRequestedVTileSource + 1], a
	ld a, LOW(vTiles5 tile (77 + 31))
	ldh [hRequestedVTileDest], a
	ld a, HIGH(vTiles5 tile (77 + 31))
	ldh [hRequestedVTileDest + 1], a
	ld a, 4
	ldh [hRequested2bpp], a
	ret

CutToBlackAndPause:

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

	call QueueCGBPalUpdate
	ld c, 64
	jmp DelayFrames

DecompressAndLoad128Tiles:
	lb bc, BANK(@), 128
	jmp DecompressRequest2bpp

DecompressAndLoad255Tiles:
	lb bc, BANK(@), 255
	jmp DecompressRequest2bpp

PerspectiveScrollBG:
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
	ret

SuicuneRunGFX:
INCBIN "gfx/intro/suicune_run.2bpp.lzp"

PichuWooperGFX:
INCBIN "gfx/intro/pichu_wooper.2bpp.lzp"

ResetScrollingAndFillBothPalBufsWithUnownPal:
	ld hl, UnownsPalette
ResetScrollingAndFillBothPalBufs:
	xor a
SetScrollingAndFillBothPalBufs:
	ldh [hSCY], a
	xor a
	ldh [hSCX], a

FillBothPalBufs:
	ld de, wBGPals1
	push hl
	call .fillBuf
	pop hl ; Copy the same source again, but this time...
	assert wBGPals1 + 16 palettes == wBGPals2
.fillBuf
	ld bc, 16 palettes ; 8 for BG, 8 for OBJ.
	rst CopyBytes
	jmp QueueCGBPalUpdate

SetupOutdoors:
	farcall StartUniformSCXOverrides
.noScrollingReset:
	ld a, LCDC_DEFAULT | LCDC_BG_9C00
	ldh [rLCDC], a

	ld hl, .palette
	jr ResetScrollingAndFillBothPalBufs
.palette: INCLUDE "gfx/intro/outdoors.pal"

UnownsGFX:
INCBIN "gfx/intro/unowns.2bpp.lzp"

PulseGFX:
INCBIN "gfx/intro/pulse.2bpp.lzp"

UnownsPalette:
INCLUDE "gfx/intro/unowns.pal"

CrystalUnownsGFX:
INCBIN "gfx/intro/crystal_unowns.2bpp.lzp"

CrystalUnownsPalette:
INCLUDE "gfx/intro/crystal_unowns.pal"

SuicuneCloseGFX:
INCBIN "gfx/intro/suicune_close.2bpp.lzp"

SuicuneClosePalette:
INCLUDE "gfx/intro/suicune_close.pal"

SuicuneJumpGFX:
INCBIN "gfx/intro/suicune_jump.2bpp.lzp"

SuicuneBackGFX:
INCBIN "gfx/intro/suicune_back.2bpp.lzp"

SuicunePalette:
INCLUDE "gfx/intro/suicune.pal"

UnownBackGFX:
INCBIN "gfx/intro/unown_back.2bpp.lzp"

Grass4GFX:
INCBIN "gfx/intro/grass4.2bpp"

; Load the compressed attrmap+tilemap at `hl` to vBGMap0.
DecompressAndLoadMap0:
	ld de, vBGMap0
; Load the compressed attrmap+tilemap at `hl` to the VRAM address `de`.
DecompressAndLoadMapTo:
	push de ; Will be reused for the tilemap.
	ld a, 1 ; Load the attrmap.
	ldh [rVBK], a
	lb bc, BANK("Intro BG maps"), TILEMAP_WIDTH * SCREEN_HEIGHT / TILE_SIZE
	call DecompressRequest2bpp

	xor a ; Load the tilemap.
	ldh [rVBK], a
	pop hl ; Different calling convention than `DecompressRequest2bpp`!
	debgcoord 0, SCREEN_HEIGHT, wDecompressScratch
	ld c, TILEMAP_WIDTH * SCREEN_HEIGHT / TILE_SIZE ; This function ignores B.
	jmp Request2bppInWRA6

PUSHS "Intro BG maps", ROMX

IntroBGMaps: ; Each of those contains the attrmap followed by the tilemap.
.UnownA:        INCBIN "gfx/intro/unown_a.bgmaps.lzp"
; This one also has its tiles bundled, including the grass rustling animation.
.Outdoors:      INCBIN "gfx/intro/outdoors.bgmaps_tiles_anim.lzp"
.UnownHI:       INCBIN "gfx/intro/unown_hi.bgmaps.lzp"
.Unowns:        INCBIN "gfx/intro/unowns.bgmaps.lzp"
.SuicuneJump:   INCBIN "gfx/intro/suicune_jump.bgmaps.lzp"
.SuicuneClose:  INCBIN "gfx/intro/suicune_close.bgmaps.lzp"
.SuicuneBack:   INCBIN "gfx/intro/suicune_back.bgmaps.lzp"
.CrystalUnowns: INCBIN "gfx/intro/crystal_unowns.bgmaps.lzp"

POPS
