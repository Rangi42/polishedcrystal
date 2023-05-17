ReinitBattleAnimFrameset:
	ld hl, BATTLEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_DURATION
	add hl, bc
	ld [hl], 0
	ld hl, BATTLEANIMSTRUCT_FRAME
	add hl, bc
	ld [hl], -1
	ret

GetBattleAnimFrame:
.loop
	ld hl, BATTLEANIMSTRUCT_DURATION
	add hl, bc
	ld a, [hl]
	and a
	jr z, .next_frame
	dec [hl]
	call .GetPointerAndAdvance
	push af
	jr .okay

.next_frame
	ld hl, BATTLEANIMSTRUCT_FRAME
	add hl, bc
	inc [hl]
	call .GetPointerAndAdvance
	cp oamrestart_command
	jr z, .restart
	cp oamend_command
	jr z, .repeat_last
	push af
	ld a, [hl]
	push hl
	and ~(Y_FLIP << 1 | X_FLIP << 1)
	ld hl, BATTLEANIMSTRUCT_DURATION
	add hl, bc
	ld [hl], a
	pop hl

.okay
	ld a, [hl]
	and Y_FLIP << 1 | X_FLIP << 1 ; The << 1 is compensated in the "oamframe" macro
	srl a
	ld [wBattleAnimTemp7], a
	pop af
	ret

.repeat_last
	xor a
	ld hl, BATTLEANIMSTRUCT_DURATION
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_FRAME
	add hl, bc
	dec [hl]
	dec [hl]
	jr .loop

.restart
	xor a
	ld hl, BATTLEANIMSTRUCT_DURATION
	add hl, bc
	ld [hl], a
	dec a
	ld hl, BATTLEANIMSTRUCT_FRAME
	add hl, bc
	ld [hl], a
	jr .loop

.GetPointerAndAdvance:
	ld hl, BATTLEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld e, [hl]
	ld d, 0
	ld hl, BattleAnimFrameData
	add hl, de
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ld hl, BATTLEANIMSTRUCT_FRAME
	add hl, bc
	ld l, [hl]
	ld h, 0
	add hl, hl
	add hl, de
	ld a, [hli]
	ret

GetBattleAnimOAMPointer:
	ld l, a
	ld h, 0
	ld de, BattleAnimOAMData
	add hl, hl
	add hl, hl
	add hl, de
	ret

LoadBattleAnimGFX:
	push hl
	ld b, BANK("Battle Anim Graphics")
	ld hl, AnimObjGFX
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	add hl, de
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	or h ; NULL means it's a poke ball
	call z, .GetBall
	pop de
	push bc
	call DecompressRequest2bpp
	pop bc
	ret

.GetBall:
	ldh a, [rSVBK]
	push af

	; which ball?
	ld a, BANK(wCurItem)
	ldh [rSVBK], a
	ld a, [wCurItem]
	ld e, a
	ld d, 0

	; get the palette
	push bc
	push de
	ld a, BANK(wOBPals1)
	ldh [rSVBK], a
	ld hl, CaughtBallPals
rept 4
	add hl, de
endr
	; copy the palette
	ld de, wOBPals1 palette PAL_BATTLE_OB_RED + 2 ; see GetBallAnimPal
	ld bc, 4
	ld a, BANK(CaughtBallPals)
	call FarCopyBytes
	; copy the bg palette
	ld hl, wOBPals1 palette PAL_BATTLE_OB_GREEN + 2 ; see GetBallAnimBGPal
if !DEF(MONOCHROME)
	ld a, LOW(palred 31 + palgreen 31 + palblue 31)
	ld [hli], a
	ld [hl], HIGH(palred 31 + palgreen 31 + palblue 31)
else
	ld a, LOW(PAL_MONOCHROME_WHITE)
	ld [hli], a
	ld [hl], HIGH(PAL_MONOCHROME_WHITE)
endc
	ld b, 2
	call SafeCopyTilemapAtOnce
	pop de
	pop bc

	pop af
	ldh [rSVBK], a

	; get the gfx pointer
	ld b, BANK("Battle Ball Icons")
	ld hl, AnimBallObjGFX
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret
