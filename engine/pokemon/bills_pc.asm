CheckCurPartyMonFainted:
	ld hl, wPartyMon1HP
	ld de, PARTYMON_STRUCT_LENGTH
	ld b, $0
.loop
	ld a, [wCurPartyMon]
	cp b
	jr z, .skip
	ld a, [hli]
	or [hl]
	jr nz, .notfainted
	dec hl

.skip
	inc b
	ld a, [wPartyCount]
	cp b
	jr z, .done
	add hl, de
	jr .loop

.done
	scf
	ret

.notfainted
	and a
	ret

GetBoxCountWithC:
	ld a, [wCurBox]
	ld b, a
	ld a, c
	ld c, b
	dec a
	cp c
	jr z, .activebox
	ld c, a
	ld b, 0
	ld hl, .boxbanks
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld b, a
	call GetSRAMBank
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [hl]
	call CloseSRAM
	ld c, a
	ld a, [wSavedAtLeastOnce]
	and a
	jr z, .newfile
	ld a, c
	ret

.newfile
	xor a
	ret

.activebox
	ld a, BANK(sBoxCount)
	ld b, a
	call GetSRAMBank
	ld hl, sBoxCount
	ld a, [hl]
	jp CloseSRAM

.boxbanks
	dba sBox1
	dba sBox2
	dba sBox3
	dba sBox4
	dba sBox5
	dba sBox6
	dba sBox7
	dba sBox8
	dba sBox9
	dba sBox10
	dba sBox11
	dba sBox12
	dba sBox13
	dba sBox14
