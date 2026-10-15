FarDecompressWRA6InB::
; Decompress LZ data from b:hl to 6:d000.
	call RunFunctionInWRA6
FarDecompressInB::
; Decompress LZ data from b:hl to d000.
	ld a, b
FarDecompress::
; Decompress LZ data from a:hl to d000.
	ld de, wDecompressScratch
	assert wDecompressScratch == STARTOF(WRAMX)
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

; Extended opcode bytes ($fc-$fe)
; These are in the LZ_LONG range and would otherwise decode as an invalid long command.
DEF LZ_EXT_MASK          EQU %11111100
DEF LZ_EXT_BASE          EQU $fc
DEF LZ_EXT_SUBTYPE_MASK  EQU %00000011

DEF LZ_EXT_PACKHI0       EQU 0 ; $fc
DEF LZ_EXT_PACK16_SHORT  EQU 1 ; $fd (len 1..256)
DEF LZ_EXT_PACKLO0       EQU 2 ; $fe (len 1..256)
DEF LZ_PACK16_NIBBLE_MASK EQU $0f

; In other words, the structure of the command becomes
; 111xxxyy yyyyyyyy
; x: the new control command
; y: the length

; For more information, refer to the code below and in extras/gfx.py.

	; Swap de and hl for speed
	call SwapHLDE

	push hl ; Put the output address on the stack for rewrite commands
	call .Main
	add sp, 2 ; Clear the output address from the stack

	jmp SwapHLDE

; === Main body of the decompressor starts below ===
; The entry point, `.Main`, is in the middle of it so that everything remains reachable via `jr`s.
; Do not attempt to start reading from the next line, **start at `.Main`**.

;; LZ_COPY_FLIPPED: Copy N previously-emitted bytes, swapping each's bits (bit 7 ↔ bit 0, bit 6 ↔ bit 1, etc.)

.lz_copy_flipped
	srl b
	rr c
	inc c
	jr nc, .flipped_copy_start_odd

.flipped_copy_loop
	ld a, [de]
	inc de
; https://github.com/pret/pokecrystal/wiki/Optimizing-assembly-code#reverse-the-bits-of-a
MACRO reverse_bits_of_a
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
ENDM
	reverse_bits_of_a
	ld [hli], a
.flipped_copy_start_odd
	ld a, [de]
	inc de
	reverse_bits_of_a
	ld [hli], a

	dec c
	jr nz, .flipped_copy_loop

	pop de
	inc de
	jr .Main

;; LZ_COPY_REVERSED: Copy N previously-emitted bytes, but in reverse order.
; (The start address nonetheless indicates the first byte to emit.)

.lz_copy_reverse
	srl b
	rr c
	inc c
	jr nc, .reverse_copy_start_odd

.reverse_copy_loop
	ld a, [de]
	ld [hli], a
	dec de
.reverse_copy_start_odd
	ld a, [de]
	ld [hli], a
	dec de

	dec c
	jr nz, .reverse_copy_loop
	pop de
	inc de
	jr .Main

;; LZ_ALTERNATE: Read two bytes from the input stream, and write alternating copies for N bytes.

.lz_alternate
; alternate is implemented as a repeat
; writes the pattern out, then chases its own tail
	ld a, [de]
	inc de
	push de
	push hl
	ld [hli], a
	ld a, [de]
	ld [hli], a
	pop de
	jr .lz_copy_repeat

;; LZ_COPY_*: Copy some bytes from the *output* stream, i.e. re-emit bytes previously decompressed.

.lz_copy
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

	; Read the output start address that was pushed before calling `.Main`.
	ld hl, sp + 6
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

	; grab command from b
	ld a, b
	and LZ_CMD
	cp LZ_COPY_FLIPPED
	jr z, .lz_copy_flipped
	jr nc, .lz_copy_reverse

;; LZ_COPY_NORMAL: Copy N bytes, plain and simply.

.lz_copy_repeat
	srl b
	rr c
	inc c
	jr nc, .lz_copy_repeat_skip

.lz_copy_repeat_loop
	ld a, [de]
	ld [hli], a
	inc de
.lz_copy_repeat_skip
	ld a, [de]
	ld [hli], a
	inc de

	dec c
	jr nz, .lz_copy_repeat_loop
	pop de
	inc de
	jr .Main

;; LZ_DATA: copies some bytes straight from the input stream.

.copy_9_bit_len ; Copies BC + 1 bytes (ignoring upper 7 bits of B) from DE to HL.
	srl b

; Since `LZ_DATA` always has a 5-bit length, we skip setting B and jump here instead.
.lz_data ; Jumped to with carry clear, so `rr c` will act as `srl c`.
	rr c ; Halve C so it counts in pairs (and stores a 9-bit length for basically free)
	inc c ; TODO: the compressor should be able to make this unnecessary
	jr nc, .copy_start_odd ; If the LSB was set, then we need to copy an odd number of bytes.

.copy_loop
	ld a, [de]
	ld [hli], a
	inc de
.copy_start_odd
	ld a, [de]
	ld [hli], a
	inc de

	dec c
	jr nz, .copy_loop
; fallthrough

; === ENTRY POINT ===

.Main
	ld a, [de]
	inc de
	ld c, a
	and LZ_CMD
	static_assert LZ_DATA == 0
	jr z, .lz_data ; C already contains the length and nothing else, so go!
	ld b, c
	cp LZ_LONG
	jr nc, .long

	; Extract the bitfields.
	; b = %cccl llll, a = %ccc0 0000 (from `and` above)
	xor b ; a = %000l llll
	ld c, a ; Thus, C = length.
	xor b ; a = %ccc0 0000
	ld b, a

.process_cmd
	; command in a
	; length in bc, upper 7 bits of b ignored
	rla
	jr c, .lz_copy

	; Dispatch between LZ_REPEAT, LZ_ALTERNATE, and LZ_ZERO.
	; Compare against the middle one: Z indicates we matched it, and otherwise, carry distinguishes the other two.
	cp LOW(LZ_ALTERNATE << 1)
	jr z, .lz_alternate
	jr nc, .lz_zero

;; LZ_REPEAT: Write N+1 instances of the next byte in the input stream.

.lz_repeat
	ld a, [de]
	ld [hli], a
	inc de
	jr .fill

;; LZ_ZERO: set N of the output bytes to zeros.

.lz_zero
	xor a
.fill
	srl b
	rr c
	inc c
	jr nc, .fill_start_odd

.fill_loop
	ld [hli], a
.fill_start_odd
	ld [hli], a
	dec c
	jr nz, .fill_loop
	jr .Main

;; LZ_LONG: normal commands, but with the length field made 4 bits longer.

.long_normal
	ld a, [de]
	inc de
	ld c, a
	; b =  111ccc0l
	ld a, %00111100
	and b
	rlca
	rlca
	rlca
	; a = ccc00001
	and b
	; a = ccc0000l
	ld b, a
	and LZ_CMD
	jr nz, .process_cmd
	jr .copy_9_bit_len

; This is where `LZ_LONG` handling actually begins; a nested `LZ_LONG` is nonsensical,
; so it's instead handled as special-purpose commands.
.long
	inc b
	ret z ; LZ_END
	ld b, c

	; Extended opcodes: $fc-$fe.
	; Detect by masking off the low two bits.
	ld a, b
	and LZ_EXT_MASK
	cp LZ_EXT_BASE
	jr nz, .long_normal
	ld a, b
	and LZ_EXT_SUBTYPE_MASK
	; subtype in a: LZ_EXT_PACKHI0/LZ_EXT_PACK16_SHORT/LZ_EXT_PACKLO0
	push af
	ld a, [de]
	inc de
	ld c, a
	ld b, 0
	inc c
	jr nz, .ext_have_len
	inc b
.ext_have_len
	pop af
	cp LZ_EXT_PACKHI0
	jr nz, .ext_pack16

;; LZ_EXT_PACKHI0: Read nibbles from the input stream, and output them right-padded (`$x0`).

.ext_packhi0
	; Decode packed literals where each output byte is (nibble << 4).
	; Payload is ceil(count/2) bytes.
.packhi0_loop
	ld a, b
	or c
	jr z, .Main
	ld a, [de]
	inc de
	push af
	and $f0
	ld [hli], a
	dec bc
	ld a, b
	or c
	jr z, .pack_done
	pop af
	and LZ_PACK16_NIBBLE_MASK
	swap a
	ld [hli], a
	dec bc
	jr .packhi0_loop

.pack_done
	pop af
	jr .Main

;; LZ_EXT_PACK16: Read nibbles from the input stream, and output one of 16 common bytes from that.

.ext_pack16
	cp LZ_EXT_PACKLO0
	jr z, .ext_packlo0
	; Decode packed literals. Payload is ceil(count/2) bytes.
	; Uses a small fixed table of 16 bytes.
.pack_loop
	ld a, b
	or c
	jr z, .Main
	ld a, [de]
	inc de
	push af
	swap a
	call .pack_lookup
	ld a, b
	or c
	jr z, .pack_done
	pop af
	call .pack_lookup
	jr .pack_loop

;; LZ_EXT_PACKLO0: Read nibbles from the input stream, and output them left-padded (`$0x`).

.ext_packlo0
	; Decode packed literals where each output byte has high nibble 0.
	; Payload is ceil(count/2) bytes.
.packlo0_loop
	ld a, b
	or c
	jmp z, .Main
	ld a, [de]
	inc de
	push af
	swap a
	and LZ_PACK16_NIBBLE_MASK
	ld [hli], a
	dec bc
	ld a, b
	or c
	jr z, .pack_done
	pop af
	and LZ_PACK16_NIBBLE_MASK
	ld [hli], a
	dec bc
	jr .packlo0_loop

; Output the `a & $0f`th element of the table, and decrement the count.
.pack_lookup
	and LZ_PACK16_NIBBLE_MASK
	push de
	add LOW(.pack16_table)
	ld e, a
	adc HIGH(.pack16_table)
	sub e
	ld d, a
	ld a, [de]
	pop de
	ld [hli], a
	dec bc
	ret

.pack16_table
	db $00, $ff, $01, $02, $03, $fe, $80, $07
	db $c0, $7f, $04, $0f, $1f, $3f, $08, $fc
