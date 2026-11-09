GetPokeBallWobble:
; Returns whether a Poke Ball will wobble in the catch animation.
	ld a, BANK(wThrownBallWobbleCount)
	call StackCallInWRAMBankA
.Function:
; Wobble up to 3 times.
	; Check for critical capture flag
	ld a, [wThrownBallWobbleCount]
	and $10
	jr z, .no_critical

	; skip the first 3 checks
	ld a, 3
	ld c, 0
	jr .critical_shake

.no_critical
	ld hl, .WobbleProbabilities
	ld a, [wFinalCatchRate]

	; If a is 255, always capture
	inc a
	jr z, .ok
	dec a
	ld b, a
.loop
	ld a, [hli]
	cp b
	jr z, .checkwobble
	jr nc, .use_previous
	inc hl
	jr .loop

.use_previous
	dec hl
	dec hl

.checkwobble
	ld b, [hl]
	call Random
	cp b
	ld c, 2 ; escaped
	ret nc

.ok
	; Check how many wobbles we've done so far. If this would've been our 4th,
	; we've successfully caught the Pokémon.
	ld c, 0 ; shake
	ld a, [wThrownBallWobbleCount]
	inc a
.critical_shake
	ld [wThrownBallWobbleCount], a
	cp 4
	ret c

	inc c ; captured
	ret

.WobbleProbabilities:
; With a catch rate of a, each wobble is calculated
; as happening if a random number 0-255 <= b.
; b is 256/(255/a)^0.1875, so use a lookup table.
pusho Q16
def prev_y = 0
for x, 1, 255
	def y = DIV(256.0, POW(DIV(255.0, x * 1.0), 0.1875)) / 1.0
	if y > prev_y
		def prev_y = y
		db x, y
	endc
endr
	db 255, 255
popo
