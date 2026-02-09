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

	; Save the output address for rewrite commands
	push hl
	call .Main
	; Clean the stack (no need to restore the output address)
	add sp, 2

	jmp SwapHLDE

.lz_copy_flip
	srl b
	rr c
	inc c
	jr nc, .lz_copy_flip_skip

; https://github.com/pret/pokecrystal/wiki/Optimizing-assembly-code#reverse-the-bits-of-a
.lz_copy_flip_loop
	ld a, [de]
	inc de
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

.lz_copy_flip_skip
	ld a, [de]
	inc de
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
	jr nz, .lz_copy_flip_loop

	pop de
	inc de
	jr .Main

.lz_copy_reverse
	srl b
	rr c
	inc c
	jr nc, .lz_copy_reverse_skip

.lz_copy_reverse_loop
	ld a, [de]
	ld [hli], a
	dec de
.lz_copy_reverse_skip
	ld a, [de]
	ld [hli], a
	dec de

	dec c
	jr nz, .lz_copy_reverse_loop
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

	jr .lz_copy_repeat

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

	; lzaddr from the stack
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
	jr z, .lz_copy_flip
	jr nc, .lz_copy_reverse

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

.lz_data
	srl b
.lz_data_short
	rr c ; and LZ_CMD leaves the carry clear
	inc c
	jr nc, .lz_data_skip

.lz_data_loop
	ld a, [de]
	ld [hli], a
	inc de
.lz_data_skip
	ld a, [de]
	ld [hli], a
	inc de

	dec c
	jr nz, .lz_data_loop
; fallthrough

; Where the magic starts
.Main
	ld a, [de]
	inc de
	ld c, a
	and LZ_CMD
	; For lzdata no more work is needed
	jr z, .lz_data_short
	ld b, c
	cp LZ_LONG
	jr nc, .long

	xor b
	ld c, a
	xor b
	ld b, a

.cont
	; command in a
	; length in bc, upper 7 bits of b ignored
	rla
	jr c, .lz_copy

	cp (LZ_ALTERNATE << 1) & $ff
	jr z, .lz_alternate
	jr nc, .lz_zero

.lz_iterate
	ld a, [de]
	ld [hli], a
	inc de
	jr .fill

.lz_zero
	xor a
.fill
	srl b
	rr c
	inc c
	jr nc, .fill_skip

.fill_loop
	ld [hli], a
.fill_skip
	ld [hli], a
	dec c
	jr nz, .fill_loop
	jr .Main

.long
	inc b
	ret z ; LZ_END
	ld b, c

	; Extended opcodes: $fc-$fe.
	; Detect by masking off the low two bits.
	ld a, b
	and LZ_EXT_MASK
	cp LZ_EXT_BASE
	jmp nz, .long_normal
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
	jr z, .packhi0_done
	pop af
	and LZ_PACK16_NIBBLE_MASK
	swap a
	ld [hli], a
	dec bc
	jr .packhi0_loop
.packhi0_done
	pop af
	jr .Main

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
	and LZ_PACK16_NIBBLE_MASK
	call .pack_lookup
	ld [hli], a
	dec bc
	ld a, b
	or c
	jr z, .pack_done
	pop af
	and LZ_PACK16_NIBBLE_MASK
	call .pack_lookup
	ld [hli], a
	dec bc
	jr .pack_loop
.pack_done
	pop af
	jmp .Main

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
	jr z, .packlo0_done
	pop af
	and LZ_PACK16_NIBBLE_MASK
	ld [hli], a
	dec bc
	jr .packlo0_loop
.packlo0_done
	pop af
	jmp .Main

.pack_lookup
	; a = 0..15 -> a = pack16_table[a]
	push de
	add LOW(.pack16_table)
	ld e, a
	adc HIGH(.pack16_table)
	sub e
	ld d, a
	ld a, [de]
	pop de
	ret

.pack16_table
	db $00, $ff, $01, $02, $03, $fe, $80, $07
	db $c0, $7f, $04, $0f, $1f, $3f, $08, $fc

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
	jmp nz, .cont
	jmp .lz_data
