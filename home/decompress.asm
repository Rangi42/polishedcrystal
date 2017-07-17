FarDecompress::
; Decompress graphics data from a:hl to de.
	call FarCallInBankA

Decompress::
	ld a, [hVBlank]
	push af
	ld a, 2 ; sound only
	ld [hVBlank], a
	call _Decompress
	pop af
	ld [hVBlank], a
	ret

_Decompress:
; Pokemon Crystal uses an lz variant for compression.
; This is mainly (but not necessarily) used for graphics.

; This function decompresses lz-compressed data from hl to de.


LZ_END EQU $ff ; Compressed data is terminated with $ff.


; A typical control command consists of:

LZ_CMD EQU %11100000 ; command id (bits 5-7)
LZ_LEN EQU %00011111 ; length n   (bits 0-4)

; Additional parameters are read during command execution.


; Commands:

LZ_LITERAL   EQU 0 << 5 ; Read literal data for n bytes.
LZ_ITERATE   EQU 1 << 5 ; Write the same byte for n bytes.
LZ_ALTERNATE EQU 2 << 5 ; Alternate two bytes for n bytes.
LZ_ZERO      EQU 3 << 5 ; Write 0 for n bytes.


; Another class of commands reuses data from the decompressed output.
LZ_RW        EQU 2 + 5 ; bit

; These commands take a signed offset to start copying from.
; Wraparound is simulated.
; Positive offsets (15-bit) are added to the start address.
; Negative offsets (7-bit) are subtracted from the current position.

LZ_REPEAT    EQU 4 << 5 ; Repeat n bytes from the offset.
LZ_FLIP      EQU 5 << 5 ; Repeat n bitflipped bytes.
LZ_REVERSE   EQU 6 << 5 ; Repeat n bytes in reverse.


; If the value in the count needs to be larger than 5 bits,
; LZ_LONG can be used to expand the count to 10 bits.
LZ_LONG      EQU 7 << 5

; A new control command is read in bits 2-4.
; The top two bits of the length are bits 0-1.
; Another byte is read containing the bottom 8 bits.
LZ_LONG_HI   EQU %00000011

; In other words, the structure of the command becomes
; 111xxxyy yyyyyyyy
; x: the new control command
; y: the length


; For more information, refer to the code below and in extras/gfx.py.


	; Save the output address
	; for rewrite commands.
	ld a, e
	ld [hLZAddress], a
	ld a, d
	ld [hLZAddress + 1], a

.Main
	ld a, [hl]
	cp LZ_END
	ret z

	and LZ_CMD

	cp LZ_LONG
	jr nz, .short

.long
; The count is now 10 bits.

	; Read the next 3 bits.
	; %00011100 -> %11100000
	ld a, [hl]
	add a
	add a ; << 3
	add a

; This is our new control code.
	and LZ_CMD
	ld [hBuffer], a

	ld a, [hli]
	and LZ_LONG_HI
	ld b, a
	ld a, [hli]
	ld c, a

	; read at least 1 byte
	inc bc
	jr .command


.short
	ld [hBuffer], a

	ld a, [hli]
	and LZ_LEN
	ld c, a
	ld b, 0

	; read at least 1 byte
	inc c


.command
	; Modify loop counts to support 8 bit loop counters
	inc b
	inc c
	dec c
	jr nz, .cWillNotunderflow
	dec b
.cWillNotunderflow
	ld a, [hBuffer]

	bit LZ_RW, a
	jr nz, .rewrite

	cp LZ_ITERATE
	jr z, .Iter
	cp LZ_ALTERNATE
	jr z, .Alt
	cp LZ_ZERO
	jr z, .Zero

; Read literal data for bc bytes.
.lloop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .lloop
	dec b
	jr nz, .lloop
	jr .Main

.Iter
; Write the same byte for bc bytes.
	ld a, [hli]
; temporarily swap hl and de
.zeroEntryPoint
	push hl
	ld h, d
	ld l, e
	pop de
.iloop
	ld [hli], a
	dec c
	jr nz, .iloop
	dec b
	jr nz, .iloop
; swap hl and de back
	push hl
	ld h, d
	ld l, e
	pop de
	jr .Main

.Alt
; Alternate two bytes for bc bytes.

; save source
	push hl
; swap hl and de temporarily for speed
	push de
	ld a, [hli]
	ld d, a
	ld e, [hl]
	pop hl
; d = byte 1
; e = byte 2
; hl = destination
.aloop
	ld a, d
	ld [hli], a

	dec c
	jr nz, .anext
	dec b
	jr z, .adone
.anext
	ld a, e
	ld [hli], a

	dec c
	jr nz, .aloop
	dec b
	jr nz, .aloop
.adone
	ld d, h
	ld e, l ; restore destination to hl
	pop hl
; Skip past the bytes we were alternating.
	inc hl
	inc hl
	jr .Main


.Zero
; Write 0 for bc bytes.
	xor a
	jr .zeroEntryPoint

.rewrite
; Repeat decompressed data from output.
	push hl

	ld a, [hli]
	bit 7, a ; sign
	jr z, .positive

.negative
; hl = de - a
	; Since we can't subtract a from de,
	; Make it negative and add de.
	; equivalent to hl + $ff00 + !a
	and %01111111
	cpl
	add e
	ld l, a
	ld h, d
	jr c, .ok
	dec h
	jr .ok

.positive
; Positive offsets are two bytes.
	ld l, [hl]
	ld h, a
	; add to starting output address
	ld a, [hLZAddress]
	add l
	ld l, a
	ld a, [hLZAddress + 1]
	adc h
	ld h, a

.ok
	ld a, [hBuffer]

	cp LZ_REPEAT
	jr z, .Repeat
	cp LZ_FLIP
	jr z, .Flip
	cp LZ_REVERSE
	jr z, .Reverse

; Since LZ_LONG is command 7,
; only commands 0-6 are passed in.
; This leaves room for an extra command 7.
; However, lengths longer than 768
; would be interpreted as LZ_END.

; More practically, LZ_LONG is not recursive.
; For now, it defaults to LZ_REPEAT.


.Repeat
; Copy decompressed data for bc bytes.
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .Repeat
	dec b
	jr nz, .Repeat
	jr .donerw

.Flip
; Copy bitflipped decompressed data for bc bytes.
	ld a, [hli]
	push bc
	ld b, 0
rept 8
	rra
	rl b
endr
	ld a, b
	pop bc

	ld [de], a
	inc de

	dec c
	jr nz, .Flip
	dec b
	jr nz, .Flip
	jr .donerw

.Reverse
; Copy reversed decompressed data for bc bytes.
	ld a, [hld]
	ld [de], a
	inc de
	dec c
	jr nz, .Reverse
	dec b
	jr nz, .Reverse

.donerw
	pop hl

	bit 7, [hl]
	jr nz, .next
	inc hl ; positive offset is two bytes
.next
	inc hl
	jp .Main
