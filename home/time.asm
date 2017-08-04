; Functions relating to the timer interrupt and the real-time-clock.

; we do not need to talk to the RTC hardware in the NoRTC patch, this is so
; that we do not get some kind of conflict if NoRTC is ran on hardware that
; includes a clock (such as emulators)
if !DEF(NO_RTC)

LatchClock:: 								; 59c
	; latch clock counter data
	xor a
	ld [MBC3LatchClock], a
	inc a
	ld [MBC3LatchClock], a
	ret
; 5a7

endc

; update the Time of Day, i.e. what time it is inside the game. this is much
; more complicated than it seems as we must read the Real Time Clock which
; gives us only an absolute amount of time that has passed since a new game
; was started and not an actual 'time of day'. we must then calculate what the
; date and time is in-game based on how much time has elapsed since the date
; and time that was established upon starting a new game; e.g. if you set the
; date/time as Monday 12:00 when you began the game and 32 hours have elapsed,
; the time will now be Tuesday 20:00
UpdateTime:: 								; 5a7
	; 1. read the clock hardware
	call GetClock
	; 2. keep the number of days passed in-bounds
	call FixDays
	; 3. calculate the time based on the start time and RTC duration
	call FixTime
	farjp GetTimeOfDay
; 5b7


; read the RTC hardware and cache the value into HRAM
GetClock:: 								; 5b7

; there is no clock hardware with the NoRTC patch, so instead we are pulling
; the time from values in RAM that are updated each frame. the reason we don't
; just update the HRAM values directly is that the area of WRAM used is what
; gets copied to SRAM to save/restore the game and we need to save the fake
; RTC's current 'time' as it will not persist whilst the game is not running
; (like real RTC hardware)
if DEF(NO_RTC)
	ld hl, wNoRTC
	ld de, hRTCDayHi
	ld bc, 5
	jp CopyBytes
else
	; enable clock r/w
	ld a, SRAM_ENABLE
	ld [MBC3SRamEnable], a
	call LatchClock
	
	; clock data is 'backwards' in hram
	ld hl, MBC3SRamBank
	ld de, MBC3RTC
	
	; read the seconds count
	ld [hl], RTC_S
	ld a, [de]
	and $3f	; mask off the bits above 64
	ld [hRTCSeconds], a

	ld [hl], RTC_M
	ld a, [de]
	and $3f ; mask off the bits above 64
	ld [hRTCMinutes], a

	ld [hl], RTC_H
	ld a, [de]
	and $1f ; mask off the bits above 32
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

; fix day count:
; the RTC hardware will continue to run, counting up days, whilst the gameboy
; is switched off. the RTC can count a maximum of 512 days (9 bits) but the
; game loops 140 days (7 weeks). this is done to keep the RTC from overflowing
; and for realigning the number of days when the game has been switched off for
; long amounts of time. I'm not sure about the reasoning behind the specific
; number of 140 days.
FixDays:: 								; 5e8
	; check if day count > 255 (bit 8 set):
	; the RTC hardware provides a 9-bit (bit#0-8)
	; day counter capable of counting 512 days
	ld a, [hRTCDayHi] ; DH
	bit 0, a
	jr z, .daylo
	
	; the day counter is over 255,
	; set this high-bit back to zero
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
	; quit if fewer than 140 days have passed,
	; no realignment needed
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


; add ingame time (set at newgame) to current time
; store time in CurDay, hHours, hMinutes, hSeconds
FixTime:: 								; 61d
	; second
	ld a, [hRTCSeconds] ; seconds from RTC
	ld c, a
	ld a, [StartSecond] ; seconds at new game
	add c
	sub 60
	jr nc, .updatesec
	add 60
.updatesec
	ld [hSeconds], a
	
	; minute
	ccf ; carry is set, so turn it off
	ld a, [hRTCMinutes] ; minutes from RTC
	ld c, a
	ld a, [StartMinute] ; minutes at new game
	adc c
	sub 60
	jr nc, .updatemin
	add 60
.updatemin
	ld [hMinutes], a

	; hour
	ccf ; carry is set, so turn it off
	ld a, [hRTCHours] ; hours from RTC
	ld c, a
	ld a, [StartHour] ; houts at new game
	adc c
	sub 24
	jr nc, .updatehr
	add 24
.updatehr
	ld [hHours], a

	; day
	ccf ; carry is set, so turn it off
	ld a, [hRTCDayLo] ; number of days from the RTC
	ld c, a
	ld a, [StartDay] ; day at new game
	adc c
	ld [CurDay], a
	ret
; 658

SetTimeOfDay:: 								; 658
	xor a
	ld [StringBuffer2], a
	ld [StringBuffer2 + 3], a
	jr InitTime

SetDayOfWeek:: 								; 663
	call UpdateTime
	ld a, [hHours]
	ld [StringBuffer2 + 1], a
	ld a, [hMinutes]
	ld [StringBuffer2 + 2], a
	ld a, [hSeconds]
	ld [StringBuffer2 + 3], a

InitTime:: 								; 677
	farjp _InitTime
; 67e


; zero the RTC in case of problems
PanicResetClock:: 							; 67e
	xor a
	ld [hRTCSeconds], a
	ld [hRTCMinutes], a
	ld [hRTCHours], a
	ld [hRTCDayLo], a
	ld [hRTCDayHi], a
	jp SetClock
; 685


; set clock data from HRAM:
SetClock:: 								; 691

; we do not need to talk to the RTC hardware in the NoRTC patch, this is so
; that we do not get some kind of conflict if NoRTC is ran on hardware that
; includes a clock (such as emulators)
if DEF(NO_RTC)
	; the 'RTC' in the NoRTC patch is a set of values in
	; WRAM which are been incremented every frame, when
	; setting the clock we update these values
	ld hl, hRTCDayHi
	ld de, wNoRTC
	ld bc, 5
	jp CopyBytes
else
	; enable clock r/w
	ld a, SRAM_ENABLE
	ld [MBC3SRamEnable], a
	call LatchClock

	; set clock data
	; stored 'backwards' in hram
	ld hl, MBC3SRamBank
	ld de, MBC3RTC

	; seconds
	ld [hl], RTC_S
	ld a, [hRTCSeconds]
	ld [de], a
	; minutes
	ld [hl], RTC_M
	ld a, [hRTCMinutes]
	ld [de], a
	; hours
	ld [hl], RTC_H
	ld a, [hRTCHours]
	ld [de], a
	; day lo
	ld [hl], RTC_DL
	ld a, [hRTCDayLo]
	ld [de], a
	; day hi
	ld [hl], RTC_DH
	ld a, [hRTCDayHi]
	res 6, a ; make sure timer is active
	ld [de], a

	; cleanup
	jp CloseSRAM ; unlatch clock, disable clock r/w

endc
; 6c4


; append flags to sRTCStatusFlags
RecordRTCStatus:: 							; 6d3
	ld hl, sRTCStatusFlags
	push af
	ld a, BANK(sRTCStatusFlags)
	call GetSRAMBank
	pop af
	or [hl]
	ld [hl], a
	jp CloseSRAM
; 6e3

; check sRTCStatusFlags
CheckRTCStatus:: 							; 6e3
	ld a, BANK(sRTCStatusFlags)
	call GetSRAMBank
	ld a, [sRTCStatusFlags]
	jp CloseSRAM
; 6ef
