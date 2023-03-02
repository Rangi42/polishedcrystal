FarDecompressWRA6::
; Decompress LZ data from a:hl to 6:d000.
	ld b, a
FarDecompressWRA6InB::
; Decompress LZ data from b:hl to 6:d000.
	call RunFunctionInWRA6
FarDecompressInB::
; Decompress LZ data from b:hl to d000.
	ld a, b
FarDecompress::
; Decompress LZ data from a:hl to d000.
	ld de, wDecompressScratch
	assert wDecompressScratch == WRAM1_Begin
FarDecompressToDE::
; Decompress LZ data from a:hl to de.
	call StackCallInBankA
Decompress::
; Decompress LZ data from hl to de.
	ldh a, [hVBlank]
	cp 4
	jr z, _Decompress
	push af
	ld a, 2 ; sound only XXX use constants for vblank modes
	ldh [hVBlank], a
	call _Decompress
	pop af
	ldh [hVBlank], a
	ret

_Decompress:
; Pokemon Crystal uses an lz variant for compression.
; This is mainly (but not necessarily) used for graphics.

; This function decompresses lz-compressed data from hl to de.

DEF LZ_END EQU $ff ; Compressed data is terminated with $ff.

; A typical control command consists of:

DEF LZ_CMD EQU %11100000 ; command id (bits 5-7)
DEF LZ_LEN EQU %00011111 ; length n   (bits 0-4)

; Additional parameters are read during command execution.

; Commands:

DEF LZ_DATA          EQU 0 << 5 ; Read literal data for n bytes.
DEF LZ_REPEAT        EQU 1 << 5 ; Write the same byte for n bytes.
DEF LZ_ALTERNATE     EQU 2 << 5 ; Alternate two bytes for n bytes.
DEF LZ_ZERO          EQU 3 << 5 ; Write 0 for n bytes.

; Another class of commands reuses data from the decompressed output.
DEF LZ_COPY          EQU 7 ; bit

; These commands take a signed offset to start copying from.
; Wraparound is simulated.
; Positive offsets (15-bit) are added to the start address.
; Negative offsets (7-bit) are subtracted from the current position.

DEF LZ_COPY_NORMAL   EQU 4 << 5 ; Repeat n bytes from the offset.
DEF LZ_COPY_FLIPPED  EQU 5 << 5 ; Repeat n bitflipped bytes.
DEF LZ_COPY_REVERSED EQU 6 << 5 ; Repeat n bytes in reverse.

; If the value in the count needs to be larger than 5 bits,
; LZ_LONG can be used to expand the count to 10 bits.
DEF LZ_LONG          EQU 7 << 5

; A new control command is read in bits 2-4.
; The top two bits of the length are bits 0-1.
; Another byte is read containing the bottom 8 bits.
DEF LZ_LONG_CMD      EQU %00011100
DEF LZ_LONG_HI       EQU %00000011

; In other words, the structure of the command becomes
; 111xxxyy yyyyyyyy
; x: the new control command
; y: the length

; For more information, refer to the code below and in extras/gfx.py.

	; Swap de and hl for speed
	call SwapHLDE

	; Save the output address
	; for rewrite commands.
	push hl
	call .Main
	; Clean the stack
	add sp, 2

	jmp SwapHLDE

.lz_copy_flip
	inc b
	ld a, b
:	push af

:	ld a, [de]
	inc de

; https://github.com/pret/pokecrystal/wiki/Optimizing-assembly-code#reverse-the-bits-of-a
	ld b, a
	rlca
	rlca
	xor b
	and $aa
	xor b
	ld b, a
	swap b
	xor b
	and $33
	xor b
	rrca

	ld [hli], a
	dec c
	jr nz, :-

	pop af
	dec a
	jr nz, :--

	pop de
	inc de
	jr .Main

.lz_copy_reverse
	inc b
	srl c
	jr nc, :+
	ld a, [de]
	ld [hli], a
	dec de

:	jr z, :++
:	ld a, [de]
	ld [hli], a
	dec de
	ld a, [de]
	ld [hli], a
	dec de

	dec c
	jr nz, :-

:	dec b
	ld c, $80
	jr nz, :--

	pop de
	inc de
	jr .Main

; alternate is implemented as a repeat
; writes the pattern out, then chases its own tail
.lz_alternate
	ld a, [de]
	inc de
	push de
	push hl
	ld [hli], a
	ld a, [de]
	ld [hli], a
	pop de

	; assume count >= 3, because < 3 is nonsense
	dec bc
	dec bc
	jr .lz_copy_repeat

.lz_copy
	; stash command
	ld [hl], a

	ld a, [de]
	bit 7, a
	jr nz, .relative

	; 15 bit absolute
	inc de
	push de
	push hl
	ld h, d
	ld l, e
	ld d, a
	ld e, [hl]

	; lzaddr from the stack
	ld hl, sp+6
	ld a, [hli]
	ld h, [hl]
	ld l, a

	jr .got_offset

.relative
	push de
	push hl
	cpl
	sub $80
	ld e, a
	ld d, $ff

.got_offset
	add hl, de
	ld d, h
	ld e, l
	pop hl

	; unstash command
	ld a, [hl]
	cp (LZ_COPY_FLIPPED << 1) & $ff
	jr z, .lz_copy_flip
	jr nc, .lz_copy_reverse

.lz_copy_repeat
	call CopyBytes_hl_de
	pop de
	inc de
	jr .Main

.lz_data_short
	ld c, a
	inc c
.lz_data_short_no_inc
	srl c
	jr nc, :+
	ld a, [de]
	ld [hli], a
	inc de

:	jr z, .Main
:	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hli], a
	inc de

	dec c
	jr nz, :-
; fallthrough

; Where the magic starts
.Main
	ld a, [de]
	inc de
	cp LZ_LEN + 1
	; For lzdata no more work is needed
	jr c, .lz_data_short
	ld b, a
	cp LZ_LONG
	jr nc, .long

	and LZ_LEN
	ld c, a
	inc c
	xor b
	ld b, 0

.cont
	; command in a
	; length in bc
	rla
	jr c, .lz_copy

	cp (LZ_ALTERNATE << 1) & $ff
	jr z, .lz_alternate
	jr nc, .lz_zero

.lz_iterate
	ld a, [de]
	inc de
	jr .fill

.lz_zero
	xor a
.fill
	inc b
	srl c
	jr nc, :+
	ld [hli], a

:	jr z, :++
:	ld [hli], a
	ld [hli], a
	dec c
	jr nz, :-

:	dec b
	jr z, .Main
	ld c, $80
	jr :--

.long
	inc a
	ret z ; LZ_END
	ld a, b

	and LZ_LONG_HI
	ld [hl], a
	ld a, [de]
	inc de
	ld c, a
	ld a, b
	and LZ_LONG_CMD
	ld b, [hl]
	inc bc
	add a
	add a
	add a
	jr nz, .cont

.lz_data
	; for short runs (<256) we can avoid a call
	; given that most graphics are <1k this will be practically
	; all of them
	or b
	jr z, .lz_data_short_no_inc
	call CopyBytes_hl_de
	jr .Main

; CopyBytes copies from hl to de
; For performance reasons, we need de to hl
CopyBytes_hl_de:
	inc b
	srl c

	jr nc, :+
	ld a, [de]
	ld [hli], a
	inc de

:	jr z, :++
:	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hli], a
	inc de

	dec c
	jr nz, :-

:	dec b
	ret z

	ld c, $80
	jr :--
