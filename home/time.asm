; Functions relating to the timer interrupt and the real-time-clock.

; do not talk to the RTC hardware in the no-RTC patch
if !DEF(NO_RTC)
LatchClock:: ; 59c
; latch clock counter data
	xor a
	ld [MBC3LatchClock], a
	inc a
	ld [MBC3LatchClock], a
	ret
; 5a7
endc

UpdateTime:: ; 5a7
	call GetClock ; read the clock hardware
	call FixDays  ; keep the number of days passed in-bounds
	call FixTime  ; calculate the time based on the start time and RTC duration
	farjp GetTimeOfDay
; 5b7

GetClock:: ; 5b7
; store clock data in hRTCDayHi-hRTCSeconds

if DEF(NO_RTC)
	ld hl, wNoRTC
	ld de, hRTCDayHi
	ld bc, 5
	jp CopyBytes
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
	ld [hRTCSeconds], a

	ld [hl], RTC_M
	ld a, [de]
	and $3f
	ld [hRTCMinutes], a

	ld [hl], RTC_H
	ld a, [de]
	and $1f
	ld [hRTCHours], a

	ld [hl], RTC_DL
	ld a, [de]
	ld [hRTCDayLo], a

	ld [hl], RTC_DH
	ld a, [de]
	ld [hRTCDayHi], a

; unlatch clock / disable clock r/w
	jp CloseSRAM
endc
; 5e8

FixDays:: ; 5e8
; fix day count
; mod by 140

; check if day count > 255 (bit 8 set)
	ld a, [hRTCDayHi] ; DH
	bit 0, a
	jr z, .daylo
; reset dh (bit 8)
	res 0, a
	ld [hRTCDayHi], a ; DH

; mod 140
; mod twice since bit 8 (DH) was set
	ld a, [hRTCDayLo] ; DL
.modh
	sub 140
	jr nc, .modh
.modl
	sub 140
	jr nc, .modl
	add 140

; update dl
	ld [hRTCDayLo], a ; DL

; flag for sRTCStatusFlags
	ld a, %01000000
	jr .set

.daylo
; quit if fewer than 140 days have passed
	ld a, [hRTCDayLo] ; DL
	cp 140
	jr c, .quit

; mod 140
.mod
	sub 140
	jr nc, .mod
	add 140

; update dl
	ld [hRTCDayLo], a ; DL

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
; 61d

FixTime:: ; 61d
; add ingame time (set at newgame) to current time
;				  day     hr    min    sec
; store time in CurDay, hHours, hMinutes, hSeconds

	ld a, [hRTCSeconds]
	ld c, a
	ld a, [StartSecond]
	add c
	sub 60
	jr nc, .updatesec
	add 60
.updatesec
	ld [hSeconds], a

	ccf ; carry is set, so turn it off
	ld a, [hRTCMinutes]
	ld c, a
	ld a, [StartMinute]
	adc c
	sub 60
	jr nc, .updatemin
	add 60
.updatemin
	ld [hMinutes], a

	ccf ; carry is set, so turn it off
	ld a, [hRTCHours]
	ld c, a
	ld a, [StartHour]
	adc c
	sub 24
	jr nc, .updatehr
	add 24
.updatehr
	ld [hHours], a

	ccf ; carry is set, so turn it off
	ld a, [hRTCDayLo]
	ld c, a
	ld a, [StartDay]
	adc c
	ld [CurDay], a
	ret
; 658

SetTimeOfDay:: ; 658
	xor a
	ld [StringBuffer2], a
	ld [StringBuffer2 + 3], a
	jr InitTime

SetDayOfWeek:: ; 663
	call UpdateTime
	ld a, [hHours]
	ld [StringBuffer2 + 1], a
	ld a, [hMinutes]
	ld [StringBuffer2 + 2], a
	ld a, [hSeconds]
	ld [StringBuffer2 + 3], a

InitTime:: ; 677
	farjp _InitTime
; 67e

PanicResetClock:: ; 67e
	xor a
	ld [hRTCSeconds], a
	ld [hRTCMinutes], a
	ld [hRTCHours], a
	ld [hRTCDayLo], a
	ld [hRTCDayHi], a
; fallthrough
; 685

SetClock:: ; 691
; set clock data from hram

; do not talk to the RTC hardware in the no-RTC patch
if DEF(NO_RTC)
	ld hl, hRTCDayHi
	ld de, wNoRTC
	ld bc, 5
	jp CopyBytes
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
	ld a, [hRTCSeconds]
	ld [de], a

	ld [hl], RTC_M
	ld a, [hRTCMinutes]
	ld [de], a

	ld [hl], RTC_H
	ld a, [hRTCHours]
	ld [de], a

	ld [hl], RTC_DL
	ld a, [hRTCDayLo]
	ld [de], a

	ld [hl], RTC_DH
	ld a, [hRTCDayHi]
	res 6, a ; make sure timer is active
	ld [de], a

; cleanup
	jp CloseSRAM ; unlatch clock, disable clock r/w
endc
; 6c4

RecordRTCStatus:: ; 6d3
; append flags to sRTCStatusFlags
	ld hl, sRTCStatusFlags
	push af
	ld a, BANK(sRTCStatusFlags)
	call GetSRAMBank
	pop af
	or [hl]
	ld [hl], a
	jp CloseSRAM
; 6e3

CheckRTCStatus:: ; 6e3
; check sRTCStatusFlags
	ld a, BANK(sRTCStatusFlags)
	call GetSRAMBank
	ld a, [sRTCStatusFlags]
	jp CloseSRAM
; 6ef
