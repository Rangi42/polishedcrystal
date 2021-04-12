; get time of day based on the current hour
GetTimeOfDay::
	ld hl, TimesOfDay
	call GetHourIntervalValue
	ld [wTimeOfDay], a
	ret

; hours for the time of day
TimesOfDay:
	db MORN_HOUR, NITE
	db DAY_HOUR,  MORN
	db EVE_HOUR,  DAY
	db NITE_HOUR, EVE
	db -1,        NITE

StageRTCTimeForSave:
	call UpdateTime
	ld hl, wRTC
	ld a, [wCurDay]
	ld [hli], a
	ldh a, [hHours]
	ld [hli], a
	ldh a, [hMinutes]
	ld [hli], a
	ldh a, [hSeconds]
	ld [hli], a
	ret

SaveRTC:
	; enable SRAM/RTC hardware
	ld a, $a
	ld [MBC3SRamEnable], a

; do not talk to the RTC hardware in the no-RTC patch
if !DEF(NO_RTC)
	; pulse the RTC to get its value
	call LatchClock
	; set the MBC3 register to the RTC day high byte & status flags
	ld hl, MBC3RTC
	ld a, $c
	; read the value from the hardware
	ld [MBC3SRamBank], a
	; clear clock overflow bit
	res 7, [hl]
endc

	; select the SRAM bank for the saved RTC status flags
	ld a, BANK(sRTCStatusFlags)
	ld [MBC3SRamBank], a
	; clear the SRAM RTC status flags
	xor a
	ld [sRTCStatusFlags], a
	; clean up
	jmp CloseSRAM

StartClock::
	; read the current clock time into the cache in HRAM
	call GetClock
	call _FixDays
	call FixDays
	; bit 5: Day count exceeds 139
	; bit 6: Day count exceeds 255
	call c, RecordRTCStatus
if DEF(NO_RTC)
	ret
else
	; start the RTC hardware running
	; it will continue to count time passing while the GameBoy is off
	; turn on the SRAM, where the RTC hardware is also located
	ld a, SRAM_ENABLE
	ld [MBC3SRamEnable], a
	; enable the RTC hardware
	call LatchClock
	; the control flags for the RTC hardware are in the top bits of the
	; topmost value (the high-byte of the day count);
	; tell the MBC3 mapper to select this value for read/write
	ld a, RTC_DH
	ld [MBC3SRamBank], a
	; read the value of the days count high byte
	ld a, [MBC3RTC]
	; activate the clock hardware by setting bit 6 to zero
	res 6, a
	ld [MBC3RTC], a
	; remember to switch off the SRAM
	jmp CloseSRAM
endc

_FixDays:
	ld hl, hRTCDayHi
	bit 7, [hl]
	jr nz, .set_bit_7
	bit 6, [hl]
	jr nz, .set_bit_7
	xor a
	ret

.set_bit_7
	; Day count exceeds 16383
	ld a, %10000000
	jmp RecordRTCStatus ; set bit 7 on sRTCStatusFlags

ClockContinue:
	call CheckRTCStatus
	ld c, a
	and %11000000 ; Day count exceeded 255 or 16383
	jr nz, .time_overflow

	ld a, c
	and %00100000 ; Day count exceeded 139
	jr z, .dont_update

	call UpdateTime
	ld a, [wRTC]
	ld b, a
	ld a, [wCurDay]
	cp b
	jr c, .dont_update

.time_overflow
	farjp ClearDailyTimers

.dont_update
	xor a
	ret

_InitTime::
	call GetClock
	call FixDays
	ld hl, hRTCSeconds
	ld de, wStartSecond
	ld bc, wStringBuffer2 + 3
; seconds
	ld a, [bc]
	sub [hl]
	dec hl
	jr nc, .ok_secs
	add 60
.ok_secs
	ld [de], a
	dec de
	dec bc
; minutes
	ld a, [bc]
	sbc [hl]
	dec hl
	jr nc, .ok_mins
	add 60
.ok_mins
	ld [de], a
	dec de
	dec bc
; hours
	ld a, [bc]
	sbc [hl]
	dec hl
	jr nc, .ok_hrs
	add 24
.ok_hrs
	ld [de], a
	dec de
	dec bc
; days
	ld a, [bc]
	sbc [hl]
	dec hl
	jr nc, .ok_days
	add 140
	ld c, 7
	call SimpleDivide
.ok_days
	ld [de], a
	ret
