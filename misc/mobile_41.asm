SECTION "bank41_2", ROMX, BANK[$41]

Mobile_HallOfFame2:: mobile ; 0x105ef6
	ld a, $5
	call GetSRAMBank
	ld hl, GameTimeHours
	ld de, $a001
	ld bc, 4
	call CopyBytes
	ld hl, $a010
	ld de, $a005
	ld bc, 4
	call CopyBytes
	ld hl, $a039
	ld de, $a009
	ld bc, 4
	call CopyBytes
	ld hl, $a01b
	ld de, $a00d
	ld bc, 3
	call CopyBytes
	call Function106162
	call CloseSRAM
	ret
; 105f33

MagikarpLength_Mobile: mobile ; 105f33
	ld a, $5
	call GetSRAMBank
	ld de, Buffer1
	ld hl, $a07b
	ld a, [de]
	cp [hl]
	jr z, .asm_105f47
	jr nc, .asm_105f4f
	jr .asm_105f55

.asm_105f47
	inc hl
	inc de
	ld a, [de]
	cp [hl]
	dec hl
	dec de
	jr c, .asm_105f55

.asm_105f4f
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	dec de
	ld [hl], a

.asm_105f55
	ld hl, $a07d
	ld a, [hli]
	or [hl]
	dec hl
	jr z, .asm_105f6d
	ld a, [de]
	cp [hl]
	jr z, .asm_105f65
	jr c, .asm_105f6d
	jr .asm_105f72

.asm_105f65
	inc hl
	inc de
	ld a, [de]
	cp [hl]
	jr nc, .asm_105f72
	dec hl
	dec de

.asm_105f6d
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	ld [hl], a

.asm_105f72
	call Function106162
	call CloseSRAM
	ret
; 105f79

MobileFn_105f79: mobile ; 105f79
	ld a, $5
	call GetSRAMBank
	ld a, [hProduct]
	ld hl, $a07f
	cp [hl]
	jr z, .asm_105f8b
	jr nc, .asm_105f92
	jr .asm_105f98

.asm_105f8b
	inc hl
	ld a, [hMultiplicand]
	cp [hl]
	jr c, .asm_105f98
	dec hl

.asm_105f92
	ld a, [hProduct]
	ld [hli], a
	ld a, [hMultiplicand]
	ld [hl], a

.asm_105f98
	call Function106162
	call CloseSRAM
	ret
; 105f9f

MobileFn_105f9f: mobile ; 105f9f
	ld a, $5
	call GetSRAMBank
	ld hl, $a070
	inc [hl]
	jr nz, .asm_105fae
	dec hl
	inc [hl]
	inc hl

.asm_105fae
	dec hl
	ld a, [$a071]
	cp [hl]
	jr z, .asm_105fb9
	jr c, .asm_105fc1
	jr .asm_105fc9

.asm_105fb9
	inc hl
	ld a, [$a072]
	cp [hl]
	jr nc, .asm_105fc9
	dec hl

.asm_105fc1
	ld a, [hli]
	ld [$a071], a
	ld a, [hl]
	ld [$a072], a

.asm_105fc9
	call Function106162
	call CloseSRAM
	ret
; 105fd0

MobileFn_105fd0: mobile ; 105fd0
	ld a, $5
	call GetSRAMBank
	ld hl, $a06f
	xor a
	ld [hli], a
	ld [hl], a
	call Function106162
	call CloseSRAM
	ret
; 105fe3

MobileFn_105fe3: mobile ; 105fe3
	ld a, $5
	call GetSRAMBank
	ld hl, $a076
	ld a, e
	add [hl]
	ld [hld], a
	ld a, d
	adc [hl]
	ld [hld], a
	jr nc, .asm_106001
	inc [hl]
	jr nz, .asm_106001
	dec hl
	inc [hl]
	jr nz, .asm_106001
	ld a, $ff
rept 3
	ld [hli], a
endr
	ld [hl], a

.asm_106001
	call Function106162
	call CloseSRAM
	ret
; 106008

MobileFn_10602e: mobile ; 10602e (41:602e)
	ld hl, $a010
	jp MobileFn_106117

MobileFn_106049: mobile ; 106049
	ld hl, $a018
	jp Function10611d

Mobile_HallOfFame:: mobile ; 0x106078
	ld hl, $a027
	jp Function10611d

MobileFn_10607f: mobile ; 10607f (41:607f)
	ld hl, $a02a
	jp Function10611d

MobileFn_10608d: mobile ; 10608d (41:608d)
	ld hl, $a030
	jp Function10611d

MobileFn_106094: mobile ; 106094
	ld hl, $a033
	jp Function10611d

MobileFn_10609b: mobile ; 10609b
	ld hl, $a036
	jp Function10611d

Mobile_HealParty: mobile ; 1060a2
	ld hl, $a039
	jp Function10611d

MobileFn_1060af: mobile ; 1060af
	ld hl, $a03f
	jr Function10611d

MobileFn_1060b5: mobile ; 1060b5
	ld hl, $a042
	jr Function10611d

MobileFn_1060bb: mobile ; 1060bb
	ld hl, $a045
	jr Function10611d

MobileFn_1060c1: mobile ; 1060c1
	ld hl, $a048
	jr Function10611d

MobileFn_1060cd: mobile ; 1060cd
	ld hl, $a04e
	jr Function106123

MobileFn_1060d3: mobile ; 1060d3
	ld hl, $a051
	jr Function10611d

MobileFn_1060e5: mobile ; 1060e5
	ld a, [hBattleTurn]
	and a
	ret nz
	ld hl, $a05a
	jr Function10611d

MobileFn_1060ef: mobile ; 1060ef
	ld hl, $a05d
	jr Function10611d

MobileFn_SaveBattleResult_Win: mobile ; win
	ld hl, $a063
	jr Function10611d

MobileFn_SaveBattleResult_Lose: mobile ; lose
	ld hl, $a066
	jr Function10611d
; 106107

MobileFn_SaveBattleResult_Draw: mobile ; draw
	ld hl, $a069
	jr Function10611d
; 10610d

MobileFn_10610d: mobile ; 10610d
	ld a, [hBattleTurn]
	and a
	ret nz
	ld hl, $a06c
	jr Function10611d
; 106117

MobileFn_106117: ; 106117
	push bc
	ld bc, 3
	jr Function10612d
; 10611d

Function10611d: ; 10611d
	push bc
	ld bc, 2
	jr Function10612d
; 106123

Function106123: ; 106123
	push bc
	ld bc, 1
	jr Function10612d
; 106129

Function10612d: ; 10612d
	ld a, $5
	call GetSRAMBank
	push hl
	push de
	ld e, c
	inc e
.asm_106136
	ld a, [hli]
	inc a
	jr nz, .asm_10613d
	dec e
	jr nz, .asm_106136

.asm_10613d
	pop de
	pop hl
	jr z, .asm_10614d
	add hl, bc
.asm_106142
	inc [hl]
	jr nz, .asm_10614d
	ld a, c
	and a
	jr z, .asm_10614d
	dec hl
	dec c
	jr .asm_106142

.asm_10614d
	call Function106162
	call CloseSRAM
	pop bc
	ret
; 106155

MobileFn_106155: mobile ; 106155
	ld a, $5
	call GetSRAMBank
	call Function106162
	call CloseSRAM
	ret
; 106162

Function106162: ; 106162
	push de
	call Function10616e
	ld hl, $a081 ; s5_a081
	ld [hl], d
	inc hl
	ld [hl], e
	pop de
	ret
; 10616e

Function10616e: ; 10616e
	push bc
	ld hl, $a001 ; s5_a001
	ld bc, $80
	xor a
	ld de, 0
.asm_106179
	ld a, e
	add [hl]
	ld e, a
	jr nc, .asm_10617f
	inc d

.asm_10617f
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, .asm_106179
	pop bc
	ret
; 106187


BackupMobileEventIndex: ; 106187
	ld a, BANK(sMobileEventIndex)
	call GetSRAMBank
	ld a, [sMobileEventIndex]
	push af
	ld a, BANK(sMobileEventIndexBackup)
	call GetSRAMBank
	pop af
	ld [sMobileEventIndexBackup], a
	call CloseSRAM
	ret
; 10619d


RestoreMobileEventIndex: ; 10619d (41:619d)
	ld a, BANK(sMobileEventIndexBackup)
	call GetSRAMBank
	ld a, [sMobileEventIndexBackup]
	push af
	ld a, BANK(sMobileEventIndex)
	call GetSRAMBank
	pop af
	ld [sMobileEventIndex], a
	call CloseSRAM
	ret
; 1061b3 (41:61b3)

DeleteMobileEventIndex: ; 1061c0 (41:61c0)
	ld a, BANK(sMobileEventIndex)
	call GetSRAMBank
	xor a
	ld [sMobileEventIndex], a
	call CloseSRAM
	ret
; 1061cd (41:61cd)

_MobilePrintNum:: ; 1061ef
; Supports signed 31-bit integers (up to 10 digits)
; b: Bits 0-4 = # bytes
;    Bit 7 = set if negative
; c: Number of digits
; de: highest byte of number to convert
; hl: where to print the converted string
	push bc
	xor a
	ld [hPrintNum1], a
	ld [hPrintNum2], a
	ld [hPrintNum3], a
	ld a, b
	and $f
	cp $1
	jr z, .one_byte
	cp $2
	jr z, .two_bytes
	cp $3
	jr z, .three_bytes
; four bytes
	ld a, [de]
	ld [hPrintNum1], a
	inc de

.three_bytes
	ld a, [de]
	ld [hPrintNum2], a
	inc de

.two_bytes
	ld a, [de]
	ld [hPrintNum3], a
	inc de

.one_byte
	ld a, [de]
	ld [hPrintNum4], a
	inc de

	push de
	xor a
	ld [hPrintNum9], a
	ld a, b
	ld [hPrintNum10], a
	ld a, c
	cp 2
	jr z, .two_digits
	ld de, ._2
	cp 3
	jr z, .three_to_nine_digits
	ld de, ._3
	cp 4
	jr z, .three_to_nine_digits
	ld de, ._4
	cp 5
	jr z, .three_to_nine_digits
	ld de, ._5
	cp 6
	jr z, .three_to_nine_digits
	ld de, ._6
	cp 7
	jr z, .three_to_nine_digits
	ld de, ._7
	cp 8
	jr z, .three_to_nine_digits
	ld de, ._8
	cp 9
	jr z, .three_to_nine_digits
	ld de, ._9

.three_to_nine_digits
rept 3
	inc de
endr
rept 2
	dec a
endr

.digit_loop
	push af
	call .Function1062b2
	call .Function1062ff
rept 4
	inc de
endr
	pop af
	dec a
	jr nz, .digit_loop

.two_digits
	ld c, 0
	ld a, [hPrintNum4]
.mod_ten_loop
	cp 10
	jr c, .simple_divide_done
	sub 10
	inc c
	jr .mod_ten_loop

.simple_divide_done
	ld b, a
	ld a, [hPrintNum9]
	or c
	ld [hPrintNum9], a
	jr nz, .create_digit
	call .LoadMinusTenIfNegative
	jr .done

.create_digit
	ld a, "0"
	add c
	ld [hl], a

.done
	call .Function1062ff
	ld a, "0"
	add b
	ld [hli], a
	pop de
	pop bc
	ret
; 106292

._9	dd 1000000000
._8	dd 100000000
._7	dd 10000000
._6	dd 1000000
._5	dd 100000
._4	dd 10000
._3	dd 1000
._2	dd 100
; 1062b2

.Function1062b2: ; 1062b2
	ld c, $0
.asm_1062b4
	ld a, [de]
	dec de
	ld b, a
	ld a, [hPrintNum4]
	sub b
	ld [hPrintNum8], a
	ld a, [de]
	dec de
	ld b, a
	ld a, [hPrintNum3]
	sbc b
	ld [hPrintNum7], a
	ld a, [de]
	dec de
	ld b, a
	ld a, [hPrintNum2]
	sbc b
	ld [hPrintNum6], a
	ld a, [de]
rept 3
	inc de
endr
	ld b, a
	ld a, [hPrintNum1]
	sbc b
	ld [hPrintNum5], a
	jr c, .asm_1062eb
	ld a, [hPrintNum5]
	ld [hPrintNum1], a
	ld a, [hPrintNum6]
	ld [hPrintNum2], a
	ld a, [hPrintNum7]
	ld [hPrintNum3], a
	ld a, [hPrintNum8]
	ld [hPrintNum4], a
	inc c
	jr .asm_1062b4

.asm_1062eb
	ld a, [hPrintNum9]
	or c
	jr z, .LoadMinusTenIfNegative
	ld a, -10
	add c
	ld [hl], a
	ld [hPrintNum9], a
	ret

.LoadMinusTenIfNegative:
	ld a, [hPrintNum10]
	bit 7, a
	ret z

	ld [hl], -10
	ret
; 1062ff

.Function1062ff: ; 1062ff
	ld a, [hPrintNum10]
	bit 7, a
	jr nz, .asm_10630d
	bit 6, a
	jr z, .asm_10630d
	ld a, [hPrintNum9]
	and a
	ret z

.asm_10630d
	inc hl
	ret
; 10630f

; functions related to the cable club and various NPC scripts referencing mobile communications

MobileFn_106314: mobile ; 106314
	ld a, $4
	call GetSRAMBank
	ld a, c
	cpl
	ld [$b000], a
	call CloseSRAM
	ld a, $7
	call GetSRAMBank
	ld a, c
	ld [$a800], a
	call CloseSRAM
	ret
; 10632f

Mobile_AlwaysReturnNotCarry: ; 10632f
	or a
	ret

MobileFunc_106462: mobile
	ret
; 106464

Function106464:: ; 106464
	ld de, MobilePhoneTilesGFX
	ld hl, VTiles2 tile $60
	lb bc, BANK(MobilePhoneTilesGFX), 1
	call Get2bpp
	ld de, GFX_f9424
	ld hl, VTiles2 tile $61
	lb bc, BANK(GFX_f9424), 1
	call Get2bpp
	ld de, GFX_106514
	ld hl, VTiles2 tile $62
	ld c, 9
	ld b, BANK(GFX_106514)
	call Get2bpp
	ld de, $40b0
	ld hl, VTiles2 tile $6b
	ld b, $f ; XXX no graphics at 0f:40b0
	call Get2bpp
	callba LoadFrame
	ret
; 10649b

GFX_106514:
INCBIN "gfx/unknown/106514.2bpp"


LoadOverworldFont:: ; 106594
	ld de, .bgfont
	ld hl, VTiles1
	lb bc, BANK(.bgfont), $80
	call Get2bpp
	ld de, .bgfont + $80 tiles
	ld hl, VTiles2 tile $7f
	lb bc, BANK(.bgfont), 1
	call Get2bpp
	ret
; 1065ad

.bgfont
INCBIN "gfx/unknown/1065ad.2bpp"
