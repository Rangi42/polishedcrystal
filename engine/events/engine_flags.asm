EngineFlagAction::
; Do action b on engine flag de
;
;   b = 0: reset flag
;     = 1: set flag
;     > 1: check flag, result in c
;
; Setting/resetting does not return a result.

; Get this flag's location.
	ld hl, EngineFlags
; location
	add hl, de
	add hl, de
; bit
	add hl, de

; location
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
; bit
	ld c, [hl]

; What are we doing with this flag?
	ld a, b
	and a ; 0?
	jr z, .reset
	dec a ; 1?
	ld a, [de]
	jr z, .set

; Return the given flag in c.
	and c
	ld c, a
	ret

; Set the given flag.
.set
	or c
	ld [de], a
	ret

; Reset the given flag.
.reset
	ld a, c
	cpl ; AND all bits except the one in question
	ld c, a
	ld a, [de]
	and c
	ld [de], a
	ret

INCLUDE "data/events/engine_flags.asm"
