RTC::
; update time and time-sensitive palettes

; rtc enabled?
	ld a, [wSpriteUpdatesEnabled]
	and a
	ret z

	call UpdateTime

; obj update on?
	ld a, [wStateFlags]
	bit SPRITE_UPDATES_DISABLED_F, a ; obj update
	ret z
	; fallthrough

TimeOfDayPals::
	farjp _TimeOfDayPals

UpdateTimePals::
	farjp _UpdateTimePals
