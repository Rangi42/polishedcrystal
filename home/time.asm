; Functions relating to the timer interrupt and the real-time-clock.

; do not talk to the RTC hardware in the no-RTC patch
if !DEF(NO_RTC)
LatchClock::
; latch clock counter data
	xor a
	ld [MBC3LatchClock], a
	inc a
	ld [MBC3LatchClock], a
	ret
endc

UpdateTime::
	call GetClock ; read the clock hardware
	call FixDays  ; keep the number of days passed in-bounds
	call FixTime  ; calculate the time based on the start time and RTC duration
	farjp GetTimeOfDay

GetClock::
; store clock data in hRTCDayHi-hRTCSeconds

if DEF(NO_RTC)
	ld hl, wNoRTC
	ld de, hRTCDayHi
	ld bc, 5
	rst CopyBytes
	ret
else
; enable clock r/w
	ld a, SRAM_ENABLE
	ld [MBC3SRamEnable], a

; clock data is 'backwards' in hram
	call LatchClock
	ld hl, MBC3SRamBank
	ld de, MBC3RTC

	ld [hl], RTC_S
	ld a, [de]
	and $3f
	ldh [hRTCSeconds], a

	ld [hl], RTC_M
	ld a, [de]
	and $3f
	ldh [hRTCMinutes], a

	ld [hl], RTC_H
	ld a, [de]
	and $1f
	ldh [hRTCHours], a

	ld [hl], RTC_DL
	ld a, [de]
	ldh [hRTCDayLo], a

	ld [hl], RTC_DH
	ld a, [de]
	ldh [hRTCDayHi], a

; unlatch clock / disable clock r/w
	jmp CloseSRAM
endc

FixDays::
; fix day count
; mod by 140

; check if day count > 255 (bit 8 set)
	ldh a, [hRTCDayHi] ; DH
	bit 0, a
	jr z, .daylo
; reset dh (bit 8)
	res 0, a
	ldh [hRTCDayHi], a ; DH

; mod 140
; mod twice since bit 8 (DH) was set
	ldh a, [hRTCDayLo] ; DL
.modh
	sub 140
	jr nc, .modh
.modl
	sub 140
	jr nc, .modl
	add 140

; update dl
	ldh [hRTCDayLo], a ; DL

; flag for sRTCStatusFlags
	ld a, %01000000
	jr .set

.daylo
; quit if fewer than 140 days have passed
	ldh a, [hRTCDayLo] ; DL
	cp 140
	jr c, .quit

; mod 140
.mod
	sub 140
	jr nc, .mod
	add 140

; update dl
	ldh [hRTCDayLo], a ; DL

; flag for sRTCStatusFlags
	ld a, %00100000

.set
; update clock with modded day value
	push af
	call SetClock
	pop af
	scf
	ret

.quit
	xor a
	ret

FixTime::
; add ingame time (set at newgame) to current time
;				  day     hr    min    sec
; store time in wCurDay, hHours, hMinutes, hSeconds

	ldh a, [hRTCSeconds]
	ld c, a
	ld a, [wStartSecond]
	add c
	sub 60
	jr nc, .updatesec
	add 60
.updatesec
	ldh [hSeconds], a

	ccf ; carry is set, so turn it off
	ldh a, [hRTCMinutes]
	ld c, a
	ld a, [wStartMinute]
	adc c
	sub 60
	jr nc, .updatemin
	add 60
.updatemin
	ldh [hMinutes], a

	ccf ; carry is set, so turn it off
	ldh a, [hRTCHours]
	ld c, a
	ld a, [wStartHour]
	adc c
	sub 24
	jr nc, .updatehr
	add 24
.updatehr
	ldh [hHours], a

	ccf ; carry is set, so turn it off
	ldh a, [hRTCDayLo]
	ld c, a
	ld a, [wStartDay]
	adc c
	ld [wCurDay], a
	ret

SetTimeOfDay::
	xor a
	ld [wStringBuffer2], a
	ld [wStringBuffer2 + 3], a
	jr InitTime

SetDayOfWeek::
	call UpdateTime
	ldh a, [hHours]
	ld [wStringBuffer2 + 1], a
	ldh a, [hMinutes]
	ld [wStringBuffer2 + 2], a
	ldh a, [hSeconds]
	ld [wStringBuffer2 + 3], a

InitTime::
	farjp _InitTime

PanicResetClock::
	xor a
	ldh [hRTCSeconds], a
	ldh [hRTCMinutes], a
	ldh [hRTCHours], a
	ldh [hRTCDayLo], a
	ldh [hRTCDayHi], a
; fallthrough

SetClock::
; set clock data from hram

; do not talk to the RTC hardware in the no-RTC patch
if DEF(NO_RTC)
	ld hl, hRTCDayHi
	ld de, wNoRTC
	ld bc, 5
	rst CopyBytes
	ret
else
; enable clock r/w
	ld a, SRAM_ENABLE
	ld [MBC3SRamEnable], a

; set clock data
; stored 'backwards' in hram
	call LatchClock
	ld hl, MBC3SRamBank
	ld de, MBC3RTC

	ld [hl], RTC_S
	ldh a, [hRTCSeconds]
	ld [de], a

	ld [hl], RTC_M
	ldh a, [hRTCMinutes]
	ld [de], a

	ld [hl], RTC_H
	ldh a, [hRTCHours]
	ld [de], a

	ld [hl], RTC_DL
	ldh a, [hRTCDayLo]
	ld [de], a

	ld [hl], RTC_DH
	ldh a, [hRTCDayHi]
	res 6, a ; make sure timer is active
	ld [de], a

; cleanup
	jmp CloseSRAM ; unlatch clock, disable clock r/w
endc

RecordRTCStatus::
; append flags to sRTCStatusFlags
	ld hl, sRTCStatusFlags
	push af
	ld a, BANK(sRTCStatusFlags)
	call GetSRAMBank
	pop af
	or [hl]
	ld [hl], a
	jmp CloseSRAM

CheckRTCStatus::
; check sRTCStatusFlags
	ld a, BANK(sRTCStatusFlags)
	call GetSRAMBank
	ld a, [sRTCStatusFlags]
	jmp CloseSRAM
