; UpdateChannels writes each channel to the APU before processing the next
; one. Match the stock parser's per-note cost, including its banked operand
; reads, so writes and waveform phase stay at the same cycle within the frame.
MACRO siren_delay ; machine cycles, clobbers a and flags
	assert 5 <= \1 && \1 < 1025
	ld a, (\1 - 1) / 4
.wait\@ ; load + loop = 4 * iterations + 1
	dec a
	jr nz, .wait\@
	rept (\1 - 1) % 4
		nop
	endr
ENDM

; Called in the same bank as the packed channel. bc = channel struct.
; Return the stock duration in a. Frequency holds the previous *unmodified*
; note (the pitch offset is applied later to wCurTrackFrequency).
DecodeSirenNote:
	ld hl, wChannel1NoteFlags - wChannel1
	add hl, bc
	set NOTE_NOISE_SAMPLING, [hl]
	ld hl, wChannel1MusicAddress - wChannel1
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a ; hl = operands
	ld a, [wCurMusicByte]
	cp $20
	jr c, .literal
	cp $28
	jr c, .absolute
	jr z, .escaped

	; $50..$8f: envelope 8, signed byte delta
	; $90..$cf: literal intensity, signed nibble delta
	sub $50
	ld d, a
	and $30
	swap a
	call .get_duration
	push af ; duration
	ld a, d
	cp $40
	jr nc, .short_delta
	swap a
	and $f0
	or 8
	ld d, a ; intensity
	ld a, [hli]
	jr .delta
.short_delta
	and $f
	xor 8
	sub 8
	ld d, [hl]
	inc hl
	nop ; match wide delta
.delta
	push hl ; next tag
	ld hl, wChannel1Intensity - wChannel1
	add hl, bc
	ld [hl], d
	inc hl ; FrequencyLo
	ld e, a
	add [hl]
	ld [hli], a
	; Sign-extend e without disturbing carry.
	bit 7, e
	ld e, 0
	jr z, .add_high
	dec e
.add_high
	ld a, e
	adc [hl]
	ld [hl], a
	jr .finish

.absolute
	; $20..$27: duration index, envelope 8/1, 11-bit frequency, volume
	sub $20
	srl a
	ld e, a
	sbc a
	and 9
	xor 8 ; envelope 8 or 1
	ld d, a
	ld a, e
	call .get_duration
	push af
	ld e, [hl]
	inc hl
	ld a, [hli]
	push hl
	ld hl, wChannel1Intensity - wChannel1
	add hl, bc
	push af
	and $f0
	or d
	ld [hli], a
	ld [hl], e
	inc hl
	pop af
	and 7
	ld [hl], a
	siren_delay 8
	jr .finish

.literal
	push af
	siren_delay 48
	jr .raw
.escaped
	ld a, [hli] ; $28, full legacy duration
	push af
	siren_delay 43
.raw
	ld a, [hli] ; intensity
	ld d, a
	ld a, [hli] ; frequency lo
	ld e, a
	ld a, [wCurChannel]
	cp CHAN8
	jr z, .raw_noise
	ld a, [hli]
.raw_noise
	push hl
	ld hl, wChannel1Intensity - wChannel1
	add hl, bc
	ld [hl], d
	inc hl
	ld [hl], e
	inc hl
	jr nz, .raw_high
	nop ; balance the two optional high-byte accesses
	jr .finish
.raw_high
	ld [hl], a
.finish
	ld a, [wCurChannel]
	cp CHAN8
	jr nz, .tone
	dec hl
.last_byte
	ld a, [hl]
	ld [wCurMusicByte], a ; final operand, as with ParseSFXOrCry
	siren_delay 26
	pop de
	ld hl, wChannel1MusicAddress - wChannel1
	add hl, bc
	ld a, e
	ld [hli], a
	ld [hl], d
	pop af
	ret

.tone
	; A stock tonal note fetches one more frequency byte than noise.
	siren_delay 103
	jr .last_byte

.get_duration
	push hl
	ld hl, .durations
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	ld a, [hl]
	pop hl
	ret

.durations
	db 0, 2, 1, 5
