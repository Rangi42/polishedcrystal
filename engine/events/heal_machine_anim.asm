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
	call .DisableHealLCDInterrupt
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
	ld hl, wShadowOAM
	ld de, .PC_ElmsLab_OAM
	call .PlaceHealingMachineTile
	call .PlaceHealingMachineTile
	jr .LoadBallsOntoMachine

.HOF_LoadBallsOntoMachine:
	ld hl, wShadowOAM
	ld de, .HOF_OAM

.LoadBallsOntoMachine:
	ld a, [wPartyCount]
	ld b, a
	xor a
	ld [wBuffer4], a ; party index for palette assignment
.party_loop
	call .PlaceHealingMachineTile
	; Patch the OAM attribute byte to use per-ball palette (0-5)
	push hl
	dec hl ; point to attribute byte just written
	ld a, [hl]
	and ~OAM_PALETTE ; clear palette bits
	push bc
	ld c, a ; save non-palette attribute bits
	ld a, [wBuffer4]
	and OAM_PALETTE ; palette index 0-5
	or c ; combine with other flags
	ld [hl], a
	ld a, [wBuffer4]
	inc a
	ld [wBuffer4], a
	pop bc
	pop hl
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
	ld e, MUSIC_HEAL
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
	; Load the heal machine palette into OBJ palette slot 7
	ld hl, .palettes
	ld de, wOBPals2 palette 7
	ld bc, 1 palettes
	call FarCopyColorWRAM
	ld a, $1
	ldh [hCGBPalUpdate], a
	; Prepare per-ball palettes and set up HBlank palette swapping
	call .PrepareBallPalettes
	call .BackupOriginalPalettes
	call .EnableHealLCDInterrupt
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
	ldh a, [rWBK]
	push af
	ld a, $5
	ldh [rWBK], a

	ld hl, wOBPals2 palette 7
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
	ldh [rWBK], a
	ld a, $1
	ldh [hCGBPalUpdate], a
	ret

.PlaceHealingMachineTile:
	push bc
	ld a, [wBuffer1]
	bcpixel 2, 4
	dec a ; ElmsLab = 1
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
	dsprite   4, 0,   4, 2, $78, 7
	dsprite   4, 0,   4, 6, $78, 7
	dsprite   4, 6,   4, 0, $79, 7
	dsprite   4, 6,   5, 0, $79, 7 | OAM_XFLIP
	dsprite   5, 3,   4, 0, $79, 7
	dsprite   5, 3,   5, 0, $79, 7 | OAM_XFLIP
	dsprite   6, 0,   4, 0, $79, 7
	dsprite   6, 0,   5, 0, $79, 7 | OAM_XFLIP

.HOF_OAM:
	dsprite   7, 4,  10, 1, $79, 7
	dsprite   7, 4,  10, 6, $79, 7
	dsprite   7, 3,   9, 5, $79, 7
	dsprite   7, 3,  11, 2, $79, 7
	dsprite   7, 1,   9, 1, $79, 7
	dsprite   7, 1,  11, 5, $79, 7

.palettes
INCLUDE "gfx/overworld/heal_machine.pal"

; ---------------------------------------------------------------------------
; Ball palette preparation: reads each party mon's caught ball type,
; looks up its 2 colors from CaughtBallPals, and constructs a full
; 4-color OBJ palette (white, color1, color2, black) in wHealBallPalBuffer.
; Uses GetFarByte without stack accumulation to avoid overflow.
; ---------------------------------------------------------------------------
.PrepareBallPalettes:
	ld a, [wPartyCount]
	and a
	ret z
	ld b, a
	xor a
	ld [wBuffer4], a ; party index
.prep_ball_loop:
	push bc
	; --- Step 1: Read caught ball type (WRAMX bank 1, the default) ---
	ld a, [wBuffer4]
	ld hl, wPartyMon1CaughtBall
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld a, [hl]
	and CAUGHT_BALL_MASK
	; a = ball type
	; --- Step 2: Calculate ROM source pointer ---
	add a
	add a ; a = ball_type * 4
	ld c, a
	ld b, 0
	ld hl, CaughtBallPals
	add hl, bc ; hl = &CaughtBallPals[ball_type]
	; --- Step 3: Read 4 color bytes via GetFarByte ---
	; GetFarByte preserves hl, bc, de; returns byte in a.
	; Store results in registers immediately — no push af accumulation.
	ld a, BANK(CaughtBallPals)
	call GetFarByte ; a = color1 lo
	ld b, a
	inc hl
	ld a, BANK(CaughtBallPals)
	call GetFarByte ; a = color1 hi
	ld c, a
	inc hl
	ld a, BANK(CaughtBallPals)
	call GetFarByte ; a = color2 lo
	ld d, a
	inc hl
	ld a, BANK(CaughtBallPals)
	call GetFarByte ; a = color2 hi
	ld e, a
	; b=c1lo, c=c1hi, d=c2lo, e=c2hi
	; --- Step 4: Read party index before switching WRAM bank ---
	ld a, [wBuffer4]
	ld h, a ; h = party index (saved in register)
	; --- Step 5: Switch WRAM bank to 5 and write palette ---
	ldh a, [rWBK]
	push af ; save original WRAM bank
	ld a, BANK(wHealBallPalBuffer)
	ldh [rWBK], a
	; Calculate dest: wHealBallPalBuffer + party_index * 8
	ld a, h ; party index
	add a
	add a
	add a ; a = party_index * 8
	ld hl, wHealBallPalBuffer
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	; Color 0: white
	ld a, LOW($7FFF)
	ld [hli], a
	ld a, HIGH($7FFF)
	ld [hli], a
	; Color 1: ball main color
	ld a, b
	ld [hli], a
	ld a, c
	ld [hli], a
	; Color 2: ball accent color
	ld a, d
	ld [hli], a
	ld a, e
	ld [hli], a
	; Color 3: black
	xor a
	ld [hli], a
	ld [hli], a
	; --- Step 6: Restore WRAM bank and loop ---
	pop af
	ldh [rWBK], a
	ld hl, wBuffer4
	inc [hl]
	pop bc
	dec b
	jr nz, .prep_ball_loop
	ret

; Back up OBJ palettes 0-5 from wOBPals2 to wHealOrigPalBuffer
.BackupOriginalPalettes:
	ldh a, [rWBK]
	push af
	ld a, BANK("GBC Video")
	ldh [rWBK], a
	ld hl, wOBPals2
	ld de, wHealOrigPalBuffer
	ld bc, 6 palettes
	rst CopyBytes
	pop af
	ldh [rWBK], a
	ret

; Enable the LYC-based LCD interrupt for heal machine palette swapping
.EnableHealLCDInterrupt:
	; Wait for VBlank to safely configure LCD interrupt
	call DelayFrame
	di
	; Set initial LYC to the swap line
	ld a, HEAL_BALL_PAL_SWAP_LINE
	ldh [rLYC], a
	; Point LCD handler to the swap routine
	ld a, LOW(LCDHealMachineSwapPals)
	ldh [hFunctionTargetLo], a
	ld a, HIGH(LCDHealMachineSwapPals)
	ldh [hFunctionTargetHi], a
	; Enable LYC match in STAT register
	ldh a, [rSTAT]
	or STAT_LYC
	ldh [rSTAT], a
	; Enable STAT interrupt in IE
	ldh a, [rIE]
	set B_IE_STAT, a
	ldh [rIE], a
	ei
	ret

; Disable the LCD interrupt and restore the default handler
.DisableHealLCDInterrupt:
	di
	; Disable LYC match in STAT register
	ldh a, [rSTAT]
	and ~STAT_LYC
	ldh [rSTAT], a
	; Restore LCD handler to LCDGeneric
	ld a, LOW(LCDGeneric)
	ldh [hFunctionTargetLo], a
	ld a, HIGH(LCDGeneric)
	ldh [hFunctionTargetHi], a
	ei
	; Restore original OBJ palettes 0-5 to wOBPals2
	ldh a, [rWBK]
	push af
	ld a, BANK("GBC Video")
	ldh [rWBK], a
	ld hl, wHealOrigPalBuffer
	ld de, wOBPals2
	ld bc, 6 palettes
	rst CopyBytes
	pop af
	ldh [rWBK], a
	ld a, $1
	ldh [hCGBPalUpdate], a
	ret
