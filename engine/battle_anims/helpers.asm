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
	call .GetPointer
	ld a, [hli]
	push af
	jr .okay

.next_frame
	ld hl, BATTLEANIMSTRUCT_FRAME
	add hl, bc
	inc [hl]
	call .GetPointer
	ld a, [hli]
	cp -2
	jr z, .restart
	cp -1
	jr z, .repeat_last
	push af
	ld a, [hl]
	push hl
	and $3f
	ld hl, BATTLEANIMSTRUCT_DURATION
	add hl, bc
	ld [hl], a
	pop hl

.okay
	ld a, [hl]
	and $c0
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

.GetPointer:
	ld hl, BATTLEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld e, [hl]
	ld d, 0
	ld hl, BattleAnimFrameData
	add hl, de
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, BATTLEANIMSTRUCT_FRAME
	add hl, bc
	ld l, [hl]
	ld h, $0
	add hl, hl
	add hl, de
	ret

GetBattleAnimOAMPointer:
	ld l, a
	ld h, 0
	ld de, BattleAnimOAMData
	add hl, hl
	add hl, hl
	add hl, de
	ret

LoadBattleAnimObj:
	push hl
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	ld de, AnimObjGFX
	add hl, de
	ld c, [hl]
	inc hl
.got_ball
	ld b, [hl]
	ld a, b
	and a ; bank 0 means it's a poke ball
	jr z, .ball
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop de
	push bc
	call DecompressRequest2bpp
	pop bc
	ret

.ball
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
	ld de, wOBPals1 palette PAL_BATTLE_OB_RED + 2 ; see GetBallAnimPal
	ld bc, 4
	ld a, BANK(CaughtBallPals)
	call FarCopyBytes
	ld b, 2
	call SafeCopyTilemapAtOnce
	pop de
	pop bc
	pop af
	ldh [rSVBK], a
	; get the gfx pointer
	ld hl, .ball_gfx
	add hl, de
	add hl, de
	add hl, de
	jr .got_ball

.ball_gfx:
	dba AnimObjParkBallGFX
	dba AnimObjPokeBallGFX
	dba AnimObjGreatBallGFX
	dba AnimObjUltraBallGFX
	dba AnimObjMasterBallGFX
	dba AnimObjSafariBallGFX
	dba AnimObjLevelBallGFX
	dba AnimObjLureBallGFX
	dba AnimObjMoonBallGFX
	dba AnimObjFriendBallGFX
	dba AnimObjFastBallGFX
	dba AnimObjHeavyBallGFX
	dba AnimObjLoveBallGFX
	dba AnimObjPokeBallGFX ; ABILITYPATCH
	dba AnimObjRepeatBallGFX
	dba AnimObjTimerBallGFX
	dba AnimObjNestBallGFX
	dba AnimObjNetBallGFX
	dba AnimObjDiveBallGFX
	dba AnimObjLuxuryBallGFX
	dba AnimObjHealBallGFX
	dba AnimObjQuickBallGFX
	dba AnimObjDuskBallGFX
	dba AnimObjDreamBallGFX
	dba AnimObjPremierBallGFX
	dba AnimObjCherishBallGFX
