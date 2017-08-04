
; reset the number of hours the game has been played:
; -- not to be confused with the real time clock which either continues to
; increment when the gameboy is switched off, or, in the NoRTC patch, runs
; at 6x speed whilst the Game Time remains real-time
ResetGameTime::								; 208a
	xor a
	ld [GameTimeCap], a
	ld [GameTimeHours], a
	ld [GameTimeHours + 1], a
	ld [GameTimeMinutes], a
	ld [GameTimeSeconds], a
	ld [GameTimeFrames], a
	ret
; 209e


GameTimer:: ; 209e
	nop

	ld a, [rSVBK]
	push af
	ld a, 1
	ld [rSVBK], a

	call UpdateGameTimer

	pop af
	ld [rSVBK], a
	ret
; 20ad


; Increment the game timer by one frame.
; The game timer is capped at 999:59:59.00.
UpdateGameTimer:: 							; 20ad
	; Don't update if game logic is paused.
	ld a, [wGameLogicPaused]
	and a
	ret nz

	; Is the timer paused?
	ld hl, GameTimerPause
	bit 0, [hl]
	ret z

	; Is the timer already capped?
	ld hl, GameTimeCap
	bit 0, [hl]
	ret nz


	; +1 frame
	ld hl, GameTimeFrames
	ld a, [hl]
	inc a

	cp 60 ; frames/second
	jr nc, .second

	ld [hl], a
	ret

.second
	xor a
	ld [hl], a

	; kroc - noRTC Patch
	; the game timer has increased by 1 second, increase the "fake" RTC
	; by 6 seconds (24 in-game hours will pass in 4 real-world hours)
	; this does not affect the rate of the "hours played" time which
	; remains real-time
	if DEF(NO_RTC)
		rept NO_RTC_SPEEDUP
		call UpdateNoRTC
		endr
	endc

	; +1 second
	ld hl, GameTimeSeconds
	ld a, [hl]
	inc a

	cp 60 ; seconds/minute
	jr nc, .minute

	ld [hl], a
	ret

.minute
	xor a
	ld [hl], a

	; +1 minute
	ld hl, GameTimeMinutes
	ld a, [hl]
	inc a

	cp 60 ; minutes/hour
	jr nc, .hour

	ld [hl], a
	ret

.hour
	xor a
	ld [hl], a

	; +1 hour
	ld a, [GameTimeHours]
	ld h, a
	ld a, [GameTimeHours + 1]
	ld l, a
	inc hl
	
	; Cap the timer after 1000 hours.
	ld a, h
	cp 1000 / $100
	jr c, .ok

	ld a, l
	cp 1000 % $100
	jr c, .ok

	ld hl, GameTimeCap
	set 0, [hl]

	ld a, 59 ; 999:59:59.00
	ld [GameTimeMinutes], a
	ld [GameTimeSeconds], a
	ret

.ok
	ld a, h
	ld [GameTimeHours], a
	ld a, l
	ld [GameTimeHours + 1], a
	ret
; 210f

; add a second to the fake Real Time Clock:
if DEF(NO_RTC)

UpdateNoRTC::
	; set our modulus
	ld a, 60
	ld b, a
	
	ld hl, wNoRTCSeconds

	; +1 second
	;;ld a, b		; micro-optimisation
	inc [hl]		; add one to seconds (in RAM)
	sub [hl]		; subtract that from 60 (update A)
	ret nz			; not 60 -- we're done
	ld [hld], a		; is 60 -- go back to 0 (A should be zero from
				; the `sub` before), also move HL to minutes
				; byte at the same time
	; +1 minute
	ld a, b			; set modulus to 60 again
	inc [hl]		; add one to minutes (in RAM)
	sub [hl]
	ret nz
	ld [hld], a

	; +1 hour
	ld a, 24		; change our modulus to 24 (hours)
	inc [hl]
	sub [hl]
	ret nz
	ld [hld], a

	; the RTC stores days as a 9-bit number, it does not handle months
	; and so on as that's calculated by the game from the start date.
	; note that this is different than GameTime which just counts hours
	; and not days

	; +1 day
	; NOTE: we *do not* need to check for overflow! Pokemon Crystal always
	; keeps the RTC within a 140 day loop (see time.asm/FixDays:)! since
	; the NoRTC patch is not running the clock when the gameboy is off,
	; it is not possible for the clock to stray beyond 140 days, let alone
	; the RTC hardware limit of 512 days!
	inc [hl]
	ret
endc
