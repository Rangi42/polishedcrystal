AnimateHPBar: ; c6e0
	call ApplyTilemapInVBlank
	call _AnimateHPBar
	jp ApplyTilemapInVBlank

_AnimateHPBar:
; Code in here treat the HP bar for update frequency as
; if it had 96 pixels. This makes the HP bar animate
; in 30fps (60fps makes it too fast), while numbers update
; at 60fps frequency.
	call .ComputePixels
.loop
	push bc
	push hl
	call HPBarAnim_UpdateVariables
	pop hl
	pop bc
	push af
	push bc
	push hl
	call HPBarAnim_UpdateTiles
	call HPBarAnim_BGMapUpdate
	pop hl
	pop bc
	pop af
	jr nc, .loop
	ret

.ComputePixels
	push hl
	ld hl, wCurHPAnimMaxHP
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	pop hl
	sla c
	rl b
	call ComputeHPBarPixels
	ld a, e
	ld [wCurHPBarPixels], a

	ld a, [wCurHPAnimNewHP]
	ld c, a
	ld a, [wCurHPAnimNewHP + 1]
	ld b, a
	ld a, [wCurHPAnimMaxHP]
	ld e, a
	ld a, [wCurHPAnimMaxHP + 1]
	ld d, a
	sla c
	rl b
	call ComputeHPBarPixels
	ld a, e
	ld [wNewHPBarPixels], a

	push hl
	ld hl, wCurHPAnimOldHP
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	pop hl
	ld a, e
	sub c
	ld e, a
	ld a, d
	sbc b
	ld d, a
	jr c, .Damage
	ld a, [wCurHPAnimOldHP]
	ld [wCurHPAnimLowHP], a
	ld a, [wCurHPAnimNewHP]
	ld [wCurHPAnimHighHP], a
	ld c, 1
	jr .Okay

.Damage
	ld a, [wCurHPAnimOldHP]
	ld [wCurHPAnimHighHP], a
	ld a, [wCurHPAnimNewHP]
	ld [wCurHPAnimLowHP], a
	ld a, e
	cpl
	inc a
	ld e, a
	ld a, d
	cpl
	ld d, a
	ld c, 0
.Okay
	ld a, d
	ld [wCurHPAnimDeltaHP], a
	ld a, e
	ld [wCurHPAnimDeltaHP + 1], a
	ret

HPBarAnim_UpdateVariables:
	ld hl, wCurHPBarPixels
	ld a, c
	and a
	jr nz, .inc
	ld a, [hli]
	dec a
	cp [hl]
	jr c, .animdone
	jr z, .animdone
	jr .incdecdone

.inc
	ld a, [hli]
	inc a
	cp [hl]
	jr nc, .animdone
.incdecdone
	dec hl
	ld [hl], a
; wCurHPAnimOldHP = a * wCurHPAnimMaxHP / (HP_BAR_LENGTH_PX * 2)
	ld [hMultiplier], a
	xor a
	ld [hMultiplicand], a
	ld a, [wCurHPAnimMaxHP + 1]
	ld [hMultiplicand + 1], a
	ld a, [wCurHPAnimMaxHP]
	ld [hMultiplicand + 2], a
	call Multiply
	ld a, HP_BAR_LENGTH_PX * 2
	ld [hDivisor], a
	ld b, 4
	call Divide
	ld a, [hQuotient + 1]
	ld [wCurHPAnimOldHP + 1], a
	ld a, [hQuotient + 2]
	ld [wCurHPAnimOldHP], a
	xor a ; clear carry flag
	ret

.animdone
	ld a, [hld]
	ld [hl], a
	ld hl, wCurHPAnimNewHP
	ld a, [hli]
	ld [wCurHPAnimOldHP], a
	ld a, [hl]
	ld [wCurHPAnimOldHP + 1], a
	scf
	ret

HPBarAnim_UpdateTiles:
	call HPBarAnim_UpdateHPRemaining
	ld a, [wCurHPBarPixels]
	srl a
	ld c, a
	ld e, a
	ld d, 6
	ld a, [wWhichHPBar]
	and 1
	ld b, a
	push de
	call HPBarAnim_RedrawHPBar
	pop de
	jp HPBarAnim_PaletteUpdate

HPBarAnim_RedrawHPBar:
	ld a, [wWhichHPBar]
	cp 2
	jr nz, .skip
	ld a, SCREEN_WIDTH * 2
	add l
	ld l, a
	jr nc, .skip
	inc h
.skip
	jp DrawBattleHPBar

HPBarAnim_UpdateHPRemaining:
	ld a, [wWhichHPBar]
	and a
	ret z
	dec a
	jr z, .battlemon
	ld de, SCREEN_WIDTH + 2
	jr .update_hp_number

.battlemon
	ld de, SCREEN_WIDTH + 1
.update_hp_number
	push hl
	add hl, de
	ld a, " "
	ld [hli], a
	ld [hli], a
	ld [hld], a
	dec hl
	ld a, [wCurHPAnimOldHP]
	ld [wStringBuffer2 + 1], a
	ld a, [wCurHPAnimOldHP + 1]
	ld [wStringBuffer2], a
	ld de, wStringBuffer2
	lb bc, 2, 3
	call PrintNum
	pop hl
	ret

HPBarAnim_PaletteUpdate:
	ld hl, wCurHPAnimPal
	call SetHPPal
	ld c, d
	farjp ApplyHPBarPals

HPBarAnim_BGMapUpdate:
	ld a, [wWhichHPBar]
	and a
	jr z, .enemy_hp_bar
	dec a
	jr z, .player_hp_bar
	xor a
	ld [hCGBPalUpdate], a
	inc a
	ld b, a
	ld [hBGMapMode], a

	ld a, [wCurPartyMon]
	ld c, a
	cp 4
	jr nc, .lowerHalf
	dec b
.lowerHalf
	ld a, b
	ld [hBGMapHalf], a
	ld a, c
	hlbgcoord 12, 2, VBGMap2
	ld bc, BG_MAP_WIDTH * 2
	rst AddNTimes
	ld a, [wCurHPAnimPal]
	inc a
	ld b, a
	di
	ld a, 1
	ld [rVBK], a
.waitnohb1
	ld a, [rSTAT]
	and 3
	jr z, .waitnohb1
.waithbl1
	ld a, [rSTAT]
	and 3
	jr nz, .waithbl1
	ld a, b
	rept 7
	ld [hli], a
	endr
	xor a
	ld [rVBK], a
	ei
	jp DelayFrame

.enemy_hp_bar
	lb bc, $94, 0
	ld hl, wBGPals + 2 palettes + 4
	jr .finish

.player_hp_bar
	lb bc, $9c, 1
	ld hl, wBGPals + 3 palettes + 4
.finish
	xor a
	ld [hCGBPalUpdate], a
	ld a, c
	ld [hBGMapHalf], a
	ld a, [rSVBK]
	push af
	ld a, BANK(wBGPals)
	ld [rSVBK], a
	di
.waitnohb3
	ld a, [rSTAT]
	and 3
	jr z, .waitnohb3
.waithb3
	ld a, [rSTAT]
	and 3
	jr nz, .waithb3
	ld a, b
	ld [rBGPI], a
	ld a, [hli]
	ld [rBGPD], a
	ld a, [hl]
	ld [rBGPD], a
	ei
	pop af
	ld [rSVBK], a
	jp DelayFrame
