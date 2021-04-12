SplashScreen:
; Play the copyright screen and GameFreak Presents sequence.
; Return carry if user cancels animation by pressing a button.

; Reinitialize everything
	ld de, MUSIC_NONE
	call PlayMusic
	call ClearBGPalettes
	call ClearTileMap
	ld a, HIGH(vBGMap0)
	ldh [hBGMapAddress + 1], a
	xor a ; LOW(vBGMap0)
	ldh [hBGMapAddress], a
	ldh [hJoyDown], a
	ldh [hSCX], a
	ldh [hSCY], a
	ld a, $90
	ldh [hWY], a
	ld a, CGB_GAMEFREAK_LOGO
	call GetCGBLayout

; Draw copyright screen, check for BSOD
	farcall Copyright
	farcall BSOD
	call ApplyTilemapInVBlank
	ld c, 15
	call FadePalettes
	ld c, 80
	call DelayFrames
	call SetBlackPals
	ld c, 15
	call FadePalettes
	call ClearTileMap
	ld a, CGB_GAMEFREAK_LOGO
	call GetCGBLayout
	call SetPalettes
	call GameFreakPresentsInit
.joy_loop
	call JoyTextDelay
	ldh a, [hJoyLast]
	and BUTTONS
	jr nz, .pressed_button
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .finish
	call PlaceGameFreakPresents
	farcall PlaySpriteAnimations
	call DelayFrame
	jr .joy_loop

.pressed_button
	call GameFreakPresentsEnd
	scf
	ret

.finish
	call GameFreakPresentsEnd
	and a
	ret

GameFreakPresentsInit:
	ld de, GameFreakLogoGFX
	ld hl, vTiles2
	lb bc, BANK(GameFreakLogoGFX), 28
	call Get1bpp

	ldh a, [rSVBK]
	push af
	ld a, BANK(wDecompressScratch)
	ldh [rSVBK], a

	ld hl, GameFreakDittoGFX
	ld de, wDecompressScratch
	ld a, BANK(GameFreakDittoGFX)
	call Decompress

	ld hl, vTiles0
	ld de, wDecompressScratch
	lb bc, 1, 8 tiles
	call Request2bpp

	ld hl, vTiles1
	ld de, wDecompressScratch + $80 tiles
	lb bc, 1, 8 tiles
	call Request2bpp

	pop af
	ldh [rSVBK], a

	call ClearSpriteAnims
	depixel 10, 11, 4, 0
	ld a, SPRITE_ANIM_INDEX_GAMEFREAK_LOGO
	call _InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], 160
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], 96
	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], 48
	xor a
	ld [wJumptableIndex], a
	ld [wIntroSceneFrameCounter], a
	ld [wIntroSceneTimer], a
	ldh [hSCX], a
	ldh [hSCY], a
	ld a, 1
	ldh [hBGMapMode], a
	ld a, 144
	ldh [hWY], a
	lb de, %11100100, %11100100
	jmp DmgToCgbObjPals

GameFreakPresentsEnd:
	call ClearSpriteAnims
	call ClearTileMap
	call ClearSprites
	ld c, 16
	jmp DelayFrames

PlaceGameFreakPresents:
	call StandardStackJumpTable

.Jumptable
	dw DoNothing
	dw GameFreakPresents_PlaceGameFreak
	dw GameFreakPresents_PlacePresents
	dw GameFreakPresents_WaitForTimer

GameFreakPresents_PlaceGameFreak:
	ld hl, wIntroSceneTimer
	ld a, [hl]
	cp $20
	jr nc, .PlaceGameFreak
	inc [hl]
	ret

.PlaceGameFreak:
	ld [hl], 0
	ld hl, Splash_GameFreakTiles
	decoord 5, 10
	ld bc, Splash_GameFreakTiles.end - Splash_GameFreakTiles
	rst CopyBytes
	call GameFreakPresents_NextScene
	ld de, SFX_GAME_FREAK_PRESENTS
	jmp PlaySFX

GameFreakPresents_PlacePresents:
	ld hl, wIntroSceneTimer
	ld a, [hl]
	cp 64
	jr nc, .place_presents
	inc [hl]
	ret

.place_presents
	ld [hl], 0
	ld hl, Splash_PresentsTiles
	decoord 7, 11
	ld bc, Splash_PresentsTiles.end - Splash_PresentsTiles
	rst CopyBytes
	; fallthrough

GameFreakPresents_NextScene:
	ld hl, wJumptableIndex
	inc [hl]
	ret

Splash_GameFreakTiles:
	;  G  A  M  E   _  F  R  E  A  K
	db 0, 1, 2, 3, 13, 4, 5, 3, 1, 6
.end

Splash_PresentsTiles:
	db 7, 8, 9, 10, 11, 12
.end

GameFreakPresents_WaitForTimer:
	ld hl, wIntroSceneTimer
	ld a, [hl]
	cp 128
	jr nc, .finish
	inc [hl]
	ret

.finish
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

GameFreakLogoJumper:
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld a, [hl]
	call StackJumpTable

GameFreakLogoScenes:
	dw GameFreakLogo_Init
	dw GameFreakLogo_Bounce
	dw GameFreakLogo_Ditto
	dw GameFreakLogo_Transform
	dw DoNothing

GameFreakLogo_Init:
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	inc [hl]
	ret

GameFreakLogo_Bounce:
; Bounce with a height of 0C, 0C / 48 times.
; By default, this is twice, with a height of 96 pixels and 48 pixels.
; Sine offset starts at 48 (32+32/2, or pi+pi/2), so it starts at the maximum
; value of the sine wave (i.e. the top of the screen).
	ld hl, SPRITEANIMSTRUCT_VAR1 ; jump height
	add hl, bc
	ld a, [hl]
	and a
	jr z, .done

; Load the sine offset, make sure it doesn't reach the negative part of the wave
	ld d, a
	ld hl, SPRITEANIMSTRUCT_VAR2 ; sine offset
	add hl, bc
	ld a, [hl]
	and $3f ; full circle = 2*pi = 2*32
	cp 32
	jr nc, .no_negative
	add 32
.no_negative
	call Sine
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a

; Decrement the sine offset
	ld hl, SPRITEANIMSTRUCT_VAR2 ; sine offset
	add hl, bc
	ld a, [hl]
	dec [hl]
	and $1f ; a%32 == 0
	ret nz

; If the ditto's reached the ground, decrement the jump height and play the sfx
	ld hl, SPRITEANIMSTRUCT_VAR1 ; jump height
	add hl, bc
	ld a, [hl]
	sub 48
	ld [hl], a
	ld de, SFX_DITTO_BOUNCE
	jmp PlaySFX

.done
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	inc [hl]
	ld hl, SPRITEANIMSTRUCT_VAR2 ; sine offset
	add hl, bc
	ld [hl], 0
	ld de, SFX_DITTO_POP_UP
	jmp PlaySFX

GameFreakLogo_Ditto:
	ld hl, SPRITEANIMSTRUCT_VAR2 ; frame count
	add hl, bc
	ld a, [hl]
	cp 32
	jr nc, .start_transform
	inc [hl]
	ret

.start_transform
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	inc [hl]
	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], 0
	ld de, SFX_DITTO_TRANSFORM
	jmp PlaySFX

GameFreakLogo_Transform:
	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	cp 64
	jr z, .done
	inc [hl]

; Fade Ditto's palettes while it's transforming
	srl a
	srl a
	ld e, a
	ld d, 0
	ld hl, GameFreakLogoPalettes
	add hl, de
	add hl, de
	ldh a, [rSVBK]
	push af
	ld a, BANK(wOBPals2)
	ldh [rSVBK], a
	ld a, [hli]
	ld [wOBPals2 palette 1 + 4], a
	ld a, [hli]
	ld [wOBPals2 palette 1 + 5], a
	pop af
	ldh [rSVBK], a
	ld a, TRUE
	ldh [hCGBPalUpdate], a
	ret

.done
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	inc [hl]
	jmp GameFreakPresents_NextScene

GameFreakLogoPalettes:
; Ditto's color as it turns into the Game Freak logo.
; Fade from pink to orange.
; One color per step.
if !DEF(MONOCHROME)
	RGB 23, 12, 28
	RGB 23, 12, 27
	RGB 23, 13, 26
	RGB 23, 13, 24

	RGB 24, 14, 22
	RGB 24, 14, 20
	RGB 24, 15, 18
	RGB 24, 15, 16

	RGB 25, 16, 14
	RGB 25, 16, 12
	RGB 25, 17, 10
	RGB 25, 17, 08

	RGB 26, 18, 06
	RGB 26, 18, 04
	RGB 26, 19, 02
	RGB 26, 19, 00
else
rept 4
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_LIGHT
endr
endc

GameFreakLogoGFX:
INCBIN "gfx/splash/logo1.1bpp"
INCBIN "gfx/splash/logo2.1bpp"

GameFreakDittoGFX:
INCBIN "gfx/splash/ditto.2bpp.lz"
