HealMachineAnim:
	; If you have no Pokemon, don't change the buffer.  This can lead to some glitchy effects if you have no Pokemon.
	ld a, [wPartyCount]
	and a
	ret z
	; The location of the healing machine relative to the player is stored in hScriptVar.
	; 0: Up and left (Pokemon Center)
	; 1: Left (Elm's Lab)
	; 2: Up (Hall of Fame)
	ldh a, [hScriptVar]
	ld [wBuffer1], a
	ldh a, [rOBP1]
	ld [wBuffer2], a
	call .DoJumptableFunctions
	ld a, [wBuffer2]
	jmp DmgToCgbObjPal1

.DoJumptableFunctions:
	xor a
	ld [wBuffer3], a
.jumptable_loop
	ld a, [wBuffer1]
	ld e, a
	ld d, 0
	ld hl, .Pointers
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wBuffer3]
	ld e, a
	inc a
	ld [wBuffer3], a
	add hl, de
	ld a, [hl]
	cp 5
	ret z
	ld hl, .Jumptable
	call JumpTable
	jr .jumptable_loop

.Pointers:
	dw .Pokecenter
	dw .ElmLab
	dw .HallOfFame

.Pokecenter:
	db 0, 1, 3, 5
.ElmLab:
	db 0, 1, 3, 5
.HallOfFame:
	db 0, 2, 4, 5

.Jumptable:
	dw .LoadPalettes
	dw .PC_LoadBallsOntoMachine
	dw .HOF_LoadBallsOntoMachine
	dw .PlayHealMusic
	dw .HOF_PlaySFX

.PC_LoadBallsOntoMachine:
	ld hl, wVirtualOAM + $80
	ld de, .PC_ElmsLab_OAM
	call .PlaceHealingMachineTile
	call .PlaceHealingMachineTile
	jr .LoadBallsOntoMachine

.HOF_LoadBallsOntoMachine:
	ld hl, wVirtualOAM + $80
	ld de, .HOF_OAM

.LoadBallsOntoMachine:
	ld a, [wPartyCount]
	ld b, a
.party_loop
	call .PlaceHealingMachineTile
	push de
	ld de, SFX_SECOND_PART_OF_ITEMFINDER
	call PlaySFX
	pop de
	ld c, 30
	call DelayFrames
	dec b
	jr nz, .party_loop
	ret

.PlayHealMusic:
	ld de, MUSIC_HEAL
	call PlayMusic
	jr .FlashPalettes8Times

.HOF_PlaySFX:
	ld de, SFX_GAME_FREAK_LOGO_GS
	call PlaySFX
	call .FlashPalettes8Times
	call WaitSFX
	ld de, SFX_BOOT_PC
	jmp PlaySFX

.LoadPalettes:
	ld hl, .palettes
	ld de, wOBPals2 palette PAL_OW_TREE
	ld bc, 1 palettes
	call FarCopyColorWRAM
	ld a, $1
	ldh [hCGBPalUpdate], a
	ret

.FlashPalettes8Times:
	ld c, $8
.palette_loop
	push bc
	call .FlashPalettes
	ld c, 10
	call DelayFrames
	pop bc
	dec c
	jr nz, .palette_loop
	ret

.FlashPalettes:
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a

	ld hl, wOBPals2 palette PAL_OW_TREE
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	push de
	ld c, $3
.palette_loop_2
	ld a, [hli]
	ld e, a
	ld a, [hld]
	ld d, a
	dec hl
	ld a, d
	ld [hld], a
	ld a, e
	ld [hli], a
	inc hl
	inc hl
	inc hl
	dec c
	jr nz, .palette_loop_2
	pop de
	dec hl
	ld a, d
	ld [hld], a
	ld a, e
	ld [hl], a

	pop af
	ldh [rSVBK], a
	ld a, $1
	ldh [hCGBPalUpdate], a
	ret

.PlaceHealingMachineTile:
	push bc
	ld a, [wBuffer1]
	bcpixel 2, 4
	cp $1 ; ElmsLab
	jr z, .okay
	bcpixel 0, 0

.okay
	ld a, [de]
	add c
	inc de
	ld [hli], a
	ld a, [de]
	add b
	inc de
	ld [hli], a
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	inc de
	ld [hli], a
	pop bc
	ret

.PC_ElmsLab_OAM:
	dsprite   4, 0,   4, 2, $78, PAL_OW_TREE
	dsprite   4, 0,   4, 6, $78, PAL_OW_TREE
	dsprite   4, 6,   4, 0, $79, PAL_OW_TREE
	dsprite   4, 6,   5, 0, $79, PAL_OW_TREE | X_FLIP
	dsprite   5, 3,   4, 0, $79, PAL_OW_TREE
	dsprite   5, 3,   5, 0, $79, PAL_OW_TREE | X_FLIP
	dsprite   6, 0,   4, 0, $79, PAL_OW_TREE
	dsprite   6, 0,   5, 0, $79, PAL_OW_TREE | X_FLIP

.HOF_OAM:
	dsprite   7, 4,  10, 1, $79, PAL_OW_TREE
	dsprite   7, 4,  10, 6, $79, PAL_OW_TREE
	dsprite   7, 3,   9, 5, $79, PAL_OW_TREE
	dsprite   7, 3,  11, 2, $79, PAL_OW_TREE
	dsprite   7, 1,   9, 1, $79, PAL_OW_TREE
	dsprite   7, 1,  11, 5, $79, PAL_OW_TREE

.palettes
if !DEF(MONOCHROME)
	RGB 31, 31, 31
	RGB 31, 19, 10
	RGB 31, 07, 01
	RGB 00, 00, 00
else
	MONOCHROME_RGB_FOUR
endc
