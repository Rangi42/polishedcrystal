
; we do not need to talk to the RTC hardware in the NoRTC patch, this is so
; that we do not get some kind of conflict if NoRTC is ran on hardware that
; inlcudes a clock (such as emulators)
if !DEF(NO_RTC)

; start the RTC hardware running;
; it will continue to count time passing whilst the gameboy is off
StartRTC:								; 14019
	; turn on the SRAM, where the
	; RTC hardware is also located
	ld a, SRAM_ENABLE
	ld [MBC3SRamEnable], a
	; enable the RTC hardware
	call LatchClock
	; the control flags for the RTC hardware are in the
	; top-bits of the top-most value -- the high-byte
	; of the day count -- tell the MBC3 mapper to select
	; this value for read/write
	ld a, RTC_DH
	ld [MBC3SRamBank], a
	; read the value of the days count high byte
	ld a, [MBC3RTC]
	; activate the clock hardware by setting bit 6 to zero
	res 6, a
	ld [MBC3RTC], a
	; remember to switch off the SRAM
	jp CloseSRAM
; 14032

endc

; get time of day based on the current hour
GetTimeOfDay:: 								; 14032
	ld a, [hHours] ; hour
	ld hl, TimesOfDay

.check
	; if we're within the given time period,
	; get the corresponding time of day
	cp [hl]
	jr c, .match
	; else, get the next entry
	rept 2
		inc hl
	endr
	; try again
	jr .check

.match
	; get time of day
	inc hl
	ld a, [hl]
	ld [TimeOfDay], a
	ret
; 14044

; hours for the time of day
; 0400-0959 morn | 1000-1959 day | 2000-0359 nite
TimesOfDay: 								; 14044
	db MORN_HOUR, NITE
	db DAY_HOUR, MORN
	db NITE_HOUR, DAY
	db 24, NITE
	db -1, MORN
; 1404e

StageRTCTimeForSave: 							; 14056
	call UpdateTime
	ld hl, GameSaveTime
	ld a, [CurDay]
	ld [hli], a
	ld a, [hHours]
	ld [hli], a
	ld a, [hMinutes]
	ld [hli], a
	ld a, [hSeconds]
	ld [hli], a
	ret
; 1406a

SaveRTC: 								; 1406a
	; enable SRAM/RTC hardware
	ld a, $a
	ld [MBC3SRamEnable], a
    
    ; do not talk to the RTC hardware in the NoRTC patch:
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
	jp CloseSRAM
; 14089

StartClock:: 								; 14089
	; 1. read the current clock time into the cache in HRAM
	call GetClock
	call Function1409b
	call FixDays
	jr nc, .skip_set
	; bit 5: Day count exceeds 139
	; bit 6: Day count exceeds 255
	call RecordRTCStatus ; set flag on sRTCStatusFlags

.skip_set
	; start the RTC hardware running
	; (this label doesn't exist in the NoRTC patch)
	if !DEF(NO_RTC)
		jp StartRTC
	else
		ret
	endc
; 1409b

Function1409b: 								; 1409b
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
	jp RecordRTCStatus ; set bit 7 on sRTCStatusFlags
; 140ae

Function140ae: 								; 140ae
	call CheckRTCStatus
	ld c, a
	and %11000000 ; Day count exceeded 255 or 16383
	jr nz, .time_overflow

	ld a, c
	and %00100000 ; Day count exceeded 139
	jr z, .dont_update

	call UpdateTime
	ld a, [GameSaveTime + 0]
	ld b, a
	ld a, [CurDay]
	cp b
	jr c, .dont_update

.time_overflow
	farcall ClearDailyTimers
	farcall Function170923
	ld a, $5
	call GetSRAMBank
	ld a, [$aa8c]
	inc a
	ld [$aa8c], a
	ld a, [$b2fa]
	inc a
	ld [$b2fa], a
	jp CloseSRAM

.dont_update
	xor a
	ret
; 140ed

_InitTime:: 								; 140ed
	call GetClock
	call FixDays
	ld hl, hRTCSeconds
	ld de, StartSecond

	ld a, [StringBuffer2 + 3]
	sub [hl]
	dec hl
	jr nc, .okay_secs
	add 60
.okay_secs
	ld [de], a
	dec de

	ld a, [StringBuffer2 + 2]
	sbc [hl]
	dec hl
	jr nc, .okay_mins
	add 60
.okay_mins
	ld [de], a
	dec de

	ld a, [StringBuffer2 + 1]
	sbc [hl]
	dec hl
	jr nc, .okay_hrs
	add 24
.okay_hrs
	ld [de], a
	dec de

	ld a, [StringBuffer2]
	sbc [hl]
	dec hl
	jr nc, .okay_days
	add 140
	ld c, 7
	call SimpleDivide

.okay_days
	ld [de], a
	ret
; 1412a

Function170923: 							; 170923
	ld a, $5
	call GetSRAMBank
	xor a
	ld [$aa48], a
	ld [$aa47], a
	ld hl, $aa5d
	ld bc, $0011
	call ByteFill
	jp CloseSRAM
; 17093c
