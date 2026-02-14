SECTION "Credits", ROMX

SetCreditsSpawn::
	ld a, b
	ld [wCreditsSpawn], a
	ret

Credits::
	xor a
	bit 6, b ; Hall Of Fame
	jr z, .okay
	ld a, $40
.okay
	ld [wJumptableIndex], a

	ldh a, [rWBK]
	push af
	ld a, BANK(wDecompressedCreditsGFX)
	ldh [rWBK], a

	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites

	ld hl, wCreditsBlankFrame2bpp
	ld c, (16 tiles) / 2
	lb de, %11111111, %00000000 ; solid light gray hue

.load_loop
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	dec c
	jr nz, .load_loop

	call DecompressCreditsGFX

	xor a
	ld [wCreditsBorderMon], a
	dec a ; $ff
	ld [wCreditsBorderFrame], a

	call Credits_LoadBorderGFX
	ld hl, vTiles2
	lb bc, BANK("Credits Graphics"), 4 * 4
	call Request2bpp

	call ConstructCreditsTilemap
	xor a
	ld [wCreditsLYOverride], a

	ldh a, [rWBK]
	push af
	ld a, BANK(wLYOverrides)
	ldh [rWBK], a
	ld hl, wLYOverrides
	ld bc, $100
	xor a
	rst ByteFill
	pop af
	ldh [rWBK], a

	ld hl, rIE
	set B_IE_STAT, [hl]
	ld a, LOW(rSCX)
	ldh [hLCDCPointer], a

	call GetCreditsPalette
	call SetDefaultBGPAndOBP
	ldh a, [hVBlank]
	push af
	ld a, $5
	ldh [hVBlank], a
	ld a, $1
	ldh [hInMenu], a
	xor a
	ldh [hBGMapMode], a
	ld [wCreditsPos], a
	ld [wCreditsPos+1], a
	ld [wCreditsTimer], a

.execution_loop
	call Credits_HandleBButton
	jr nz, .exit_credits
	call Credits_HandleAButton
	jr nz, .exit_credits

	call Credits_Jumptable
	call DelayFrame
	jr .execution_loop

.exit_credits
	call ClearBGPalettes
	ld hl, rIE
	res B_IE_STAT, [hl]
	xor a
	ldh [hLCDCPointer], a
	ldh [hBGMapAddress], a
	pop af
	ldh [hVBlank], a
	pop af
	ldh [rWBK], a
	ret

Credits_HandleAButton:
	ldh a, [hJoypadDown]
	and PAD_A
	ret z
	ld a, [wJumptableIndex]
	bit 7, a
	ret

Credits_HandleBButton:
	ldh a, [hJoypadDown]
	and PAD_B
	ret z
	ld a, [wJumptableIndex]
	bit 6, a
	ret z
	ld hl, wCreditsPos
	ld a, [hli]
	cp $d
	jr nc, .okay
	ld a, [hli]
	and a
	ret z
.okay
	ld hl, wCreditsTimer
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ret

Credits_Jumptable:
	ld a, [wJumptableIndex]
	and $f
	call StackJumpTable

.Jumptable:
	dw ParseCredits
	dw Credits_Next
	dw Credits_Next
	dw Credits_PrepBGMapUpdate
	dw Credits_UpdateGFXRequestPath
	dw Credits_RequestGFX
	dw Credits_LYOverride
	dw Credits_Next
	dw Credits_Next
	dw Credits_Next
	dw Credits_UpdateGFXRequestPath
	dw Credits_RequestGFX
	dw Credits_LoopBack

Credits_LoopBack:
	ld hl, wJumptableIndex
	ld a, [hl]
	and $f0
	ld [hl], a
	ret

Credits_PrepBGMapUpdate:
	xor a
	ldh [hBGMapMode], a
	; fallthrough

Credits_Next:
	ld hl, wJumptableIndex
	inc [hl]
	ret

Credits_UpdateGFXRequestPath:
	call Credits_LoadBorderGFX
	ld a, e
	ldh [hRequestedVTileSource], a
	ld a, d
	ldh [hRequestedVTileSource + 1], a
	xor a ; LOW(vTiles2)
	ldh [hRequestedVTileDest], a
	ld a, HIGH(vTiles2)
	ldh [hRequestedVTileDest + 1], a
	; fallthrough

Credits_RequestGFX:
	xor a
	ldh [hBGMapMode], a
	ld a, $8
	ldh [hRequested2bpp], a
	jr Credits_Next

Credits_LYOverride:
	ldh a, [rLY]
	cp $30
	jr c, Credits_LYOverride
	ldh a, [rWBK]
	push af
	ld a, BANK(wLYOverrides)
	ldh [rWBK], a
	ld a, [wCreditsLYOverride]
	dec a
	dec a
	ld [wCreditsLYOverride], a
	ld hl, wLYOverrides + $1f
	call .Fill
	ld hl, wLYOverrides + $87
	call .Fill
	pop af
	ldh [rWBK], a
	jr Credits_Next

.Fill:
	ld c, $8
.loop
	ld [hli], a
	dec c
	jr nz, .loop
	ret

ParseCredits:
	ld hl, wJumptableIndex
	bit 7, [hl]
	jmp nz, .done

; Wait until the timer has run out to parse the next command.
	ld hl, wCreditsTimer
	ld a, [hl]
	and a
	jr z, .parse

; One tick has passed.
	dec [hl]
	jmp .done

.parse
; First, let's clear the current text display,
; starting from line 5.
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 5
	ld bc, 20 * 12
	ld a, ' '
	rst ByteFill

; Then read the script.

.loop
	call .get

; Commands:
	cp CREDITS_END
	jmp z, .end
	cp CREDITS_WAIT
	jmp z, .wait
	cp CREDITS_SCENE
	jr z, .scene
	cp CREDITS_CLEAR
	jr z, .clear
	cp CREDITS_MUSIC
	jr z, .music
	cp CREDITS_WAIT2
	jr z, .wait2
	cp CREDITS_THEEND
	jr z, .theend

; If it's not a command, it's a string identifier.

	push af
	ld e, a
	ld d, 0
	ld hl, CreditsStringsPointers
	add hl, de
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop af

; Strings spanning multiple lines have special cases.

	cp COPYRIGHT
	jr z, .copyright

	cp STAFF
	jr c, .staff

; The rest start from line 6.

	hlcoord 0, 6
	jr .print

.copyright
	hlcoord 2, 6
	jr .print

.staff
	hlcoord 0, 6

.print
; Print strings spaced every two lines.
	call .get
	ld bc, 20 * 2
	rst AddNTimes
	rst PlaceString
	jr .loop

.theend
; Display "The End" graphic.
	call Credits_TheEnd
	jr .loop

.scene
; Update the scene number and corresponding palette.

	ld a, [wCreditsSpawn]
	cp SPAWN_LEAF
	jr z, .leaf_scene
	call .get
	jr .got_scene
.leaf_scene
	call .get
	add 4
.got_scene
	ld [wCreditsBorderMon], a ; scene
	xor a
	ld [wCreditsBorderFrame], a ; frame
	call GetCreditsPalette
	call SetDefaultBGPAndOBP ; update hw pal registers
	jr .loop

.clear
; Clear the banner.
	ld a, $ff
	ld [wCreditsBorderFrame], a ; frame
	jr .loop

.music
; Play the credits music.
	ld e, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	ld e, MUSIC_CREDITS
	call PlayMusic
	jmp .loop

.wait2
; Wait for some amount of ticks.
	call .get
	ld [wCreditsTimer], a
	jr .done

.wait
; Wait for some amount of ticks, and do something else.
	call .get
	ld [wCreditsTimer], a

	xor a
	ldh [hBGMapHalf], a
	ld a, 1
	ldh [hBGMapMode], a

.done
	jmp Credits_Next

.end
; Stop execution.
	ld hl, wJumptableIndex
	set 7, [hl]
	ld a, 32
	ld [wMusicFade], a
	ld a, LOW(MUSIC_POST_CREDITS)
	ld [wMusicFadeID], a
	xor a ; HIGH(MUSIC_POST_CREDITS)
	ld [wMusicFadeIDHi], a
	ret

.get
; Get byte wCreditsPos from CreditsScript
	push hl
	push de
	ld a, [wCreditsPos]
	ld e, a
	ld a, [wCreditsPos+1]
	ld d, a
	ld hl, CreditsScript
	add hl, de

	inc de
	ld a, e
	ld [wCreditsPos], a
	ld a, d
	ld [wCreditsPos+1], a
	ld a, [hl]
	pop de
	pop hl
	ret

ConstructCreditsTilemap:
	xor a
	ldh [hBGMapMode], a
	ld a, $c
	ldh [hBGMapAddress], a

	ld a, $28
	hlcoord 0, 0
	ld bc, SCREEN_AREA
	rst ByteFill

	ld a, $7f
	hlcoord 0, 4
	ld bc, (SCREEN_HEIGHT - 4) * SCREEN_WIDTH
	rst ByteFill

	hlcoord 0, 4
	ld a, $24
	call DrawCreditsBorder

	hlcoord 0, 17
	ld a, $20
	call DrawCreditsBorder

	hlcoord 0, 0, wAttrmap
	ld bc, 4 * SCREEN_WIDTH
	xor a
	rst ByteFill

	hlcoord 0, 4, wAttrmap
	ld bc, SCREEN_WIDTH
	ld a, $1
	rst ByteFill

	hlcoord 0, 5, wAttrmap
	ld bc, 12 * SCREEN_WIDTH
	ld a, $2
	rst ByteFill

	hlcoord 0, 17, wAttrmap
	ld bc, SCREEN_WIDTH
	ld a, $1
	rst ByteFill

	call ApplyAttrAndTilemapInVBlank
	xor a
	ldh [hBGMapMode], a
	ldh [hBGMapAddress], a
	hlcoord 0, 0
	call .InitTopPortion
	jmp ApplyAttrAndTilemapInVBlank

.InitTopPortion:
	ld b, 5
.outer_loop
	push hl
	ld de, SCREEN_WIDTH - 3
	ld c, 4
	xor a
.inner_loop
rept 3
	ld [hli], a
	inc a
endr
	ld [hl], a
	inc a
	add hl, de
	dec c
	jr nz, .inner_loop
	pop hl
rept 4
	inc hl
endr
	dec b
	jr nz, .outer_loop
	ret

DrawCreditsBorder:
	ld c, SCREEN_WIDTH / 4
.loop
	push af
rept 3
	ld [hli], a
	inc a
endr
	ld [hli], a
	pop af
	dec c
	jr nz, .loop
	ret

GetCreditsPalette:
	call .GetPalAddress

	push hl
	ldh a, [rWBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rWBK], a
	xor a
	call .UpdatePals
	pop af
	ldh [rWBK], a
	pop hl
	ret

.GetPalAddress:
; Each set of palette data is 24 bytes long.
	ld a, [wCreditsBorderMon] ; scene
	and 7
	add a
	add a
	add a
	ld e, a
	ld d, 0
	ld hl, CreditsPalettes
	add hl, de
	add hl, de
	add hl, de
	ret

.UpdatePals:
; Update the first three colors in both palette buffers.

	push af
	push hl
	add LOW(wBGPals1)
	ld e, a
	adc HIGH(wBGPals1)
	sub e
	ld d, a
	ld bc, 24
	rst CopyBytes

	pop hl
	pop af
	add LOW(wBGPals2)
	ld e, a
	adc HIGH(wBGPals2)
	sub e
	ld d, a
	ld bc, 24
	rst CopyBytes
	ret

CreditsPalettes:
INCLUDE "gfx/credits/credits.pal"

Credits_LoadBorderGFX:
	ld hl, wCreditsBorderFrame
	ld a, [hl]
	cp $ff
	jr z, .init

	and 7
	ld e, a
	inc a
	and 7
	ld [hl], a
	ld a, [wCreditsBorderMon]
	and 7
	add a
	add a
	add a
	add e
	add LOW(.Frames)
	ld l, a
	adc HIGH(.Frames)
	sub l
	ld h, a
	ld a, [hl]
	add HIGH(wDecompressedCreditsGFX)
	ld d, a
	ld e, 0
	ret

.init
	ld de, wCreditsBlankFrame2bpp
	ret

.Frames:
	db  0,  1,  2,  1,  0,  1,  2,  1 ; Pichu
	db  3,  3,  4,  4,  5,  5,  6,  6 ; Sentret
	db  7,  7,  8,  8,  7,  7,  9,  9 ; Munchlax
	db 10, 10, 11, 11, 10, 10, 12, 12 ; Togepi
	db  0,  1,  0,  2,  0,  1,  0,  2 ; Smoochum
	db  3,  4,  5,  6,  3,  4,  5,  6 ; Ditto
	db  7,  7,  8,  8,  7,  7,  9,  9 ; Elekid
	db 10, 10, 11, 11, 12, 12, 11, 11 ; Bellossom

Credits_TheEnd:
	ld a, $40
	hlcoord 6, 9
	call .Load
	hlcoord 6, 10
.Load:
	ld c, 8
.loop
	ld [hli], a
	inc a
	dec c
	jr nz, .loop
	ret

DecompressCreditsGFX:
	ld hl, CreditsBorderGFX
	ld de, vTiles2 tile $20
	lb bc, BANK(CreditsBorderGFX), $09
	call DecompressRequest2bpp

	ld hl, TheEndGFX
	ld de, vTiles2 tile $40
	lb bc, BANK(TheEndGFX), $10
	call DecompressRequest2bpp

	ld hl, CopyrightGFX
	ld de, vTiles2 tile $60
	lb bc, BANK(CopyrightGFX), $1d
	call DecompressRequest2bpp

	ld a, [wCreditsSpawn]
	cp SPAWN_LEAF
	ld hl, CreditsSequence2GFX
	jr z, .ok
	ld hl, CreditsSequence1GFX
.ok
	ld b, BANK("Credits Graphics")
	assert wDecompressedCreditsGFX == STARTOF(WRAMX)
	jmp FarDecompressInB

INCLUDE "data/credits_script.asm"
INCLUDE "data/credits_strings.asm"
