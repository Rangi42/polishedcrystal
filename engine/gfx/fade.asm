MapConnOWFadePalettesInit::
	farcall GetOvercastIndex
	ld b, a
	ld a, [wPrevOvercastIndex]
	cp b
	ld a, b
	ld [wPrevOvercastIndex], a
	jmp z, UpdateTimePals
	; fallthrough
OWFadePalettesInit::
	ldh a, [rWBK]
	push af
	ld a, BANK(wBGPals2)
	ldh [rWBK], a
	ld a, 15
	ld [wPalFadeDelayFrames], a
	ld [wPalFadeTotalSteps], a
	ld [wPalFadeStepValue], a
	xor a
	ld [wPalFadeDelay], a
	pop af
	ldh [rWBK], a
	ret

CancelOWFadePalettes::
	ldh a, [rWBK]
	push af
	ld a, BANK(wBGPals2)
	ldh [rWBK], a
	xor a
	ld [wPalFadeDelayFrames], a
	ld [wPalFadeDelay], a
	ld [wPalFadeTotalSteps], a
	ld [wPalFadeStepValue], a
	ld [wPalWhiteState], a
	farcall ApplyPals
	ld hl, wPalFlags
	res NO_DYN_PAL_APPLY_UNTIL_RESET_F, [hl]
	pop af
	ldh [rWBK], a
	ret

OWFadePalettesStep::
	ldh a, [rWBK]
	push af
	ld a, BANK(wBGPals2)
	ldh [rWBK], a

	ld a, [wPalFadeDelayFrames]
	and a
	jr z, .end_early_and_reset_ob_dyn_pal

	push hl
	push de
	push bc

	ld a, [wPalFadeDelay]
	and a
	jr nz, .obj
	inc a
	ld [wPalFadeMode], a
	ld [wPalFadeDelay], a
	jr .fade
.obj
	inc a
	ld [wPalFadeMode], a
	xor a
	ld [wPalFadeDelay], a
.fade
	call FadePalettesStep

	ld a, [wPalFadeDelay]
	and a
	jr nz, .no_upload
	ld a, 1
	ldh [hCGBPalUpdate], a
	ld hl, wPalFadeDelayFrames
	dec [hl]
.no_upload

	pop bc
	pop de
	pop hl
.end_early
	pop af
	ldh [rWBK], a
	ret

.end_early_and_reset_ob_dyn_pal:
	ld a, [wPalFlags]
	res NO_DYN_PAL_APPLY_UNTIL_RESET_F, a
	ld [wPalFlags], a
	xor a
	ld [wPalWhiteState], a
	jr .end_early

_DoFadePalettes::
; w(BG|OB)Pals2: Current palettes
; w(BG|OB)Pals1: Palettes we're fading towards
; b: Controls partial fading gradient
; c: Fade duration
; wPalFadeMode can be 0 (fade everything), 1 (fade BG), 2 (fade OBJ)
	ldh a, [rWBK]
	push af
	push hl
	push de
.restart_dofade
	push bc
	ld a, BANK(wBGPals2)
	ldh [rWBK], a

	call FadePalettesInit
	jr c, .done

.outer_loop
	call FadePalettesStep
	call .FadeDelay
	ld hl, wPalFadeDelayFrames
	dec [hl]
	jr nz, .outer_loop
.done
	pop bc
	ld a, [wPalFadeMode]
	bit PALFADE_FLASH_F, a
	res PALFADE_FLASH_F, a
	ld [wPalFadeMode], a
	jr nz, .restart_dofade
	pop de
	pop hl
	pop af
	ldh [rWBK], a
	ret

.FadeDelay:
	ld a, [wPalFadeStepValue]
	ld c, a
	ld hl, wPalFadeDelay
	ld a, [hl]
	call SimpleDivide
	inc b
	dec b
	jr nz, .delay_ok
	inc b
.delay_ok
	ld a, [hl]
	sub b
	ld [hld], a
	ld a, 1
	jr nz, .delay_finished
	ld [hl], a
.delay_finished
	ld c, b
	ldh [hCGBPalUpdate], a
	jmp DelayFrames

FadePalettesInit:
	; No matter what, we always take up to 31 color fade steps.
	; Evenly divide DelayFrames in case the fade duration is more.
	ld a, c
	cp 32
	ld [wPalFadeDelayFrames], a
	ld [wPalFadeDelay], a
	jr c, .got_delay
	ld a, 31
	ld [wPalFadeDelayFrames], a

.got_delay
	ld [wPalFadeTotalSteps], a
	ld [wPalFadeStepValue], a
	and a
	jr nz, .has_delay
	call SetDefaultBGPAndOBP
	scf
	ret

.has_delay
	ld a, [wPalFadeMode]
	bit PALFADE_PARTIAL_F, a
	jr z, .not_partial
	ld a, b
	ld [wPalFadeDelay], a

.not_partial
	and a
	ret

FadePalettesStep:
	ld a, [wPalFadeDelayFrames]
	ld [wPalFadeStepValue], a
	ld a, [wPalFadeMode]
	and PALFADE_WHICH
	ld hl, wBGPals2
	ld d, PAL_COLORS * 16 ; bg + ob pals
	jr z, .got_count
	dec a
	ld d, PAL_COLORS * 8 ; ; ob pals only
	jr z, .got_count
	ld hl, wOBPals2
.got_count
	ld a, [wPalFadeMode]

	and PALFADE_SKIP_FIRST
	jr z, .inner_loop
	ld bc, 1 palettes
	add hl, bc
	ld a, d
	sub PAL_COLORS
	ld d, a

.inner_loop
	push de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld a, [wPalFadeMode]
	bit PALFADE_FLASH_F, a
	jr z, .no_flash
	ld bc, 0
	dec hl
	jr .got_destination

.no_flash
	ld bc, wBGPals1 - wBGPals2
	add hl, bc
	ld a, [hld]
	ld b, a
	ld c, [hl]
	push bc
	ld bc, wBGPals2 - wBGPals1
	add hl, bc
	pop bc

.got_destination
	; de: active pals, bc: pals we're fading towards (high endian)
	push hl

	; Red
	ld a, c
	and COLOR_RED
	ld l, a
	ld a, e
	and COLOR_RED
	call FadeColorStep
	ld a, e
	and ~COLOR_RED
	or l
	ld e, a

	; Green
	push bc
	call FadeColorGetGreen
	ld l, a
	ld b, d
	ld c, e
	call FadeColorGetGreen
	pop bc
	call FadeColorStep
	sla l
	swap l
	ld a, l
	xor e
	and COLOR_GREEN_LOW
	xor e
	ld e, a
	ld a, l
	xor d
	and COLOR_GREEN_HIGH
	xor d
	ld d, a
	; Blue
	ld a, b
	call FadeColorGetBlue
	ld l, a
	ld a, d
	call FadeColorGetBlue
	call FadeColorStep
	sla l
	sla l
	ld a, d
	and COLOR_GREEN_HIGH ; essentially ~COLOR_BLUE
	or l
	ld d, a

	; Store changed color
	pop hl
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	pop de
	dec d
	jr nz, .inner_loop
	ret

FadeColorGetGreen:
	srl b
	rr c
	srl b
	rr c
	ld a, c
	rrca
; fallthrough
FadeColorGetBlue:
	and COLOR_BLUE
	rrca
	rrca
	ret

FadeColorStep:
; Perform a single color fading step
; a: active color, l: color we're fading towards
	cp l
	ret z
	ld h, a
	push bc
	ld b, 0
	jr nc, .dec
	ld h, l
	ld l, a
	inc b
.dec
	; Check color difference
	ld a, h
	sub l
	ld c, a

	ld a, [wPalFadeStepValue]
	cp c
	jr c, .dist_is_big

	; Approximates linear fading
	; TODO: actual linear fading
	push bc
	call SimpleDivide
	and a
	ld a, b
	pop bc
	jr z, .no_remainder
	dec a
	jr z, .change_ok

.no_remainder
	cp c
	jr z, .change_ok
	jr nc, .no_change
.change_ok
	ld a, 1
	jr .got_change
.no_change
	xor a
	jr .got_change

.dist_is_big
	push bc
	ld b, c
	ld a, [wPalFadeStepValue]
	ld c, a
	ld a, b
	call SimpleDivide
	ld a, b
	pop bc
.got_change
	ld c, a
	ld a, h
	sub c
	ld h, a
	ld a, l
	add c
	ld l, a
	dec b
	pop bc
	ret z
	ld l, h
	ret

CatchUpObjPaletteFade::
; Input: a = OBJ palette index (0-7)
; Ensures a newly loaded palette matches the current fade progress.
	ld b, a
	ldh a, [rWBK]
	push af
	ld a, BANK(wPalFadeDelayFrames)
	ldh [rWBK], a
	ld a, [wPalFadeDelayFrames]
	ld c, a ; steps remaining
	and a
	jr z, .restore_bank
	ld a, [wPalFadeTotalSteps]
	ld d, a ; total steps
	and a
	jr z, .restore_bank
	cp c
	jr z, .restore_bank ; fade just started, nothing to catch up
	jr c, .restore_bank
	ld e, c ; preserve remaining steps
	ld a, [wPalFadeMode]
	and PALFADE_SKIP_FIRST
	jr z, .catch_loop
	ld a, b
	and a
	jr z, .restore_bank

.catch_loop
	ld a, d
	cp e
	jr z, .done
	push bc
	push de
	push hl
	ld hl, wOBPals2
	ld a, b
	ld bc, 1 palettes
	rst AddNTimes
	ld a, d
	ld [wPalFadeStepValue], a
	call FadeSinglePaletteStep
	pop hl
	pop de
	pop bc
	dec d
	jr .catch_loop

.done
	ld a, e
	ld [wPalFadeStepValue], a
	ld a, 1
	ldh [hCGBPalUpdate], a

.restore_bank
	pop af
	ldh [rWBK], a
	ret

FadeSinglePaletteStep:
	ld de, 0
	ld d, PAL_COLORS

.single_loop
	push de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld a, [wPalFadeMode]
	bit PALFADE_FLASH_F, a
	jr z, .single_no_flash
	ld bc, 0
	dec hl
	jr .single_got_destination

.single_no_flash
	ld bc, wBGPals1 - wBGPals2
	add hl, bc
	ld a, [hld]
	ld b, a
	ld c, [hl]
	push bc
	ld bc, wBGPals2 - wBGPals1
	add hl, bc
	pop bc

.single_got_destination
	push hl
	ld a, c
	and COLOR_RED
	ld l, a
	ld a, e
	and COLOR_RED
	call FadeColorStep
	ld a, e
	and ~COLOR_RED
	or l
	ld e, a
	push bc
	call FadeColorGetGreen
	ld l, a
	ld b, d
	ld c, e
	call FadeColorGetGreen
	pop bc
	call FadeColorStep
	sla l
	swap l
	ld a, l
	xor e
	and COLOR_GREEN_LOW
	xor e
	ld e, a
	ld a, l
	xor d
	and COLOR_GREEN_HIGH
	xor d
	ld d, a
	ld a, b
	call FadeColorGetBlue
	ld l, a
	ld a, d
	call FadeColorGetBlue
	call FadeColorStep
	sla l
	sla l
	ld a, d
	and COLOR_GREEN_HIGH ; essentially ~COLOR_BLUE
	or l
	ld d, a
	pop hl
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
	pop de
	dec d
	jr nz, .single_loop
	ret
