ClearDailyTimers:
	xor a
	ld [wLuckyNumberDayBuffer], a
	ld [wDailyResetTimer], a
	ret

InitCallReceiveDelay::
	xor a
	ld [wTimeCyclesSinceLastCall], a
	; fallthrough

NextCallReceiveDelay:
	ld a, [wTimeCyclesSinceLastCall]
	cp 3
	jr c, .okay
	ld a, 3

.okay
	ld e, a
	ld d, 0
	ld a, [wInitialOptions2]
	and 1 << RTC_OPT
	ld hl, .ReceiveCallDelays
	jr nz, .using_rtc
	ld hl, .ReceiveCallDelaysNoRTC
.using_rtc
	add hl, de
	ld a, [hl]
	ld hl, wReceiveCallDelay_MinsRemaining
	ld [hl], a
	call UpdateTime
	ld hl, wReceiveCallDelay_StartTime
	ld a, [wCurDay]
	ld [hli], a
	ldh a, [hHours]
	ld [hli], a
	ldh a, [hMinutes]
	ld [hli], a
	ret

.ReceiveCallDelays:
	db 20, 10, 5, 3
.ReceiveCallDelaysNoRTC:
	db 20 * NO_RTC_SPEEDUP, 10 * NO_RTC_SPEEDUP, 5 * NO_RTC_SPEEDUP, 3 * NO_RTC_SPEEDUP

CheckReceiveCallTimer:
	call CheckReceiveCallDelay ; check timer
	ret nc
	ld hl, wTimeCyclesSinceLastCall
	ld a, [hl]
	cp 3
	jr nc, .ok
	inc [hl]

.ok
	call NextCallReceiveDelay ; restart timer
	scf
	ret

CheckDayDependentEventHL:
	inc hl
	push hl
	call CalcDaysSince
	ld a, [wDaysSince]
	pop hl
	dec hl
	jr UpdateTimeRemaining

CheckReceiveCallDelay:
	ld hl, wReceiveCallDelay_StartTime
	call CalcMinsHoursDaysSince
	call GetMinutesSinceIfLessThan60

	; Double effective time if lead mon has Lightning Rod, which boosts call rate
	push bc
	ld b, a
	call GetLeadAbility
	cp LIGHTNING_ROD
	ld a, b
	pop bc
	jr nz, .ok
	add a
	jr nc, .ok
	ld a, -1
.ok
	ld hl, wReceiveCallDelay_MinsRemaining
	; fallthrough

UpdateTimeRemaining:
; If the amount of time elapsed exceeds the capacity of its
; unit, skip this part.
	cp -1
	jr z, .set_carry
	ld c, a
	ld a, [hl] ; time remaining
	sub c
	jr nc, .ok
	xor a

.ok
	ld [hl], a
	jr z, .set_carry
	xor a
	ret

.set_carry
	xor a
	ld [hl], a
	scf
	ret

RestartDailyResetTimer:
	ld hl, wDailyResetTimer
	ld a, 1
	ld [hli], a
	push hl
	call UpdateTime
	pop hl
	jr CopyDayToHL

InitializeStartDay:
	call UpdateTime
	ld hl, wTimerEventStartDay
CopyDayToHL:
	ld a, [wCurDay]
	ld [hl], a
	ret

CheckDailyResetTimer::
	ld hl, wDailyResetTimer
	call CheckDayDependentEventHL
	ret nc
	xor a
	ld hl, wDailyFlags
	ld [hli], a ; wDailyFlags
	ld [hli], a ; wDailyFlags2
	ld [hli], a ; wDailyFlags3
	ld [hli], a ; wDailyFlags4
	ld [hli], a ; wWeeklyFlags
	ld [hli], a ; wWeeklyFlags2
	ld [hl], a ; wSwarmFlags
	ld [wLuckyNumberShowFlag], a
	ld hl, wFruitTreeFlags
rept (NUM_FRUIT_TREES + 7) / 8 - 1
	ld [hli], a
endr
	ld [hl], a
	ld hl, wDailyRematchFlags
rept 4 - 1
	ld [hli], a
endr
	ld [hl], a
	ld hl, wDailyPhoneItemFlags
rept 4 - 1
	ld [hli], a
endr
	ld [hl], a
	ld hl, wDailyPhoneTimeOfDayFlags
rept 4 - 1
	ld [hli], a
endr
	ld [hl], a
	ld [wDailyTrainerHouseOpponent], a
	ld hl, wKenjiBreakTimer
	ld a, [hl]
	and a
	jr z, .RestartKenjiBreakCountdown
	dec [hl]
	jr nz, RestartDailyResetTimer
.RestartKenjiBreakCountdown:
	call Special_SampleKenjiBreakCountdown
	jr RestartDailyResetTimer

Special_SampleKenjiBreakCountdown:
; Generate a random number between 3 and 6
	call Random
	and 3
	add 3
	ld [wKenjiBreakTimer], a
	ret

StartBugContestTimer:
	ld a, [wInitialOptions2]
	and 1 << RTC_OPT
	ld a, BUG_CONTEST_MINUTES
	jr nz, .using_rtc
	ld a, BUG_CONTEST_MINUTES * NO_RTC_SPEEDUP
.using_rtc
	ld [wBugContestMinsRemaining], a
	xor a ; BUG_CONTEST_SECONDS
	ld [wBugContestSecsRemaining], a
	call UpdateTime
	ld hl, wBugContestStartTime
	ld a, [wCurDay]
	ld [hli], a
	ldh a, [hHours]
	ld [hli], a
	ldh a, [hMinutes]
	ld [hli], a
	ldh a, [hSeconds]
	ld [hli], a
	ret

CheckBugContestTimer::
	ld hl, wBugContestStartTime
	call CalcSecsMinsHoursDaysSince
	ld a, [wDaysSince]
	and a
	jr nz, .timed_out
	ld a, [wHoursSince]
	and a
	jr nz, .timed_out
	ld a, [wSecondsSince]
	ld b, a
	ld a, [wBugContestSecsRemaining]
	sub b
	jr nc, .okay
	add 60

.okay
	ld [wBugContestSecsRemaining], a
	ld a, [wMinutesSince]
	ld b, a
	ld a, [wBugContestMinsRemaining]
	sbc b
	ld [wBugContestMinsRemaining], a
	jr c, .timed_out
	and a
	ret

.timed_out
	xor a
	ld [wBugContestMinsRemaining], a
	ld [wBugContestSecsRemaining], a
	scf
	ret

CheckPokerusTick::
	ld hl, wTimerEventStartDay
	call CalcDaysSince
	ld a, [wDaysSince]
	and a
	ret z ; not even a day has passed since game start
	ld b, a

	ld a, [wPartyCount]
	and a
	ret z ; don't waste time if we don't have any party members

; shift all partymon pokerus values to the left b times
; if this overflows the pokerus nybble, the infection no longer spreads
	ld c, a
	ld hl, wPartyMon1PokerusStatus
.loop
	ld a, [hl]
	and POKERUS_MASK
	jr z, .next
	assert POKERUS_CURED & %1000
	ld d, POKERUS_CURED ; no need to check if pokerus status = POKERUS_CURED, bit 3 is already set
	ld e, b
.inner_loop
	rlca
	cp POKERUS_MASK + 1
	jr nc, .cured
	dec e
	jr nz, .inner_loop
	ld d, a
.cured
	ld a, [hl]
	and ~POKERUS_MASK
	or d
	ld [hl], a
.next
	ld de, PARTYMON_STRUCT_LENGTH
	add hl, de
	dec c
	jr nz, .loop
	ret

GetMinutesSinceIfLessThan60:
	ld a, [wDaysSince]
	and a
	jr nz, .GetTimeElapsed_ExceedsUnitLimit
	ld a, [wHoursSince]
	and a
	jr nz, .GetTimeElapsed_ExceedsUnitLimit
	ld a, [wMinutesSince]
	ret

.GetTimeElapsed_ExceedsUnitLimit:
	ld a, -1
	ret

CalcDaysSince:
	xor a
	jr _CalcDaysSince

CalcMinsHoursDaysSince:
	inc hl
	inc hl
	xor a
	jr _CalcMinsHoursDaysSince

CalcSecsMinsHoursDaysSince:
	inc hl
	inc hl
	inc hl
	ldh a, [hSeconds]
	ld c, a
	sub [hl]
	jr nc, .skip_seconds
	add 60
.skip_seconds
	ld [hl], c ; current seconds
	dec hl ; no-optimize *hl++|*hl-- = b|c|d|e
	ld [wSecondsSince], a ; seconds since
	; fallthrough

_CalcMinsHoursDaysSince:
	ldh a, [hMinutes]
	ld c, a
	sbc [hl]
	jr nc, .skip_minutes
	add 60
.skip_minutes
	ld [hl], c ; current minutes
	dec hl ; no-optimize *hl++|*hl-- = b|c|d|e
	ld [wMinutesSince], a ; minutes since

; calc hours+days since
	ldh a, [hHours]
	ld c, a
	sbc [hl]
	jr nc, .skip_hours
	add 24
.skip_hours
	ld [hl], c ; current hours
	dec hl ; no-optimize *hl++|*hl-- = b|c|d|e
	ld [wHoursSince], a ; hours since
	; fallthrough

_CalcDaysSince:
	ld a, [wCurDay]
	ld c, a
	sbc [hl]
	jr nc, .skip_days
	add 20 * 7
.skip_days
	ld [hl], c ; current days
	ld [wDaysSince], a ; days since
	ret
