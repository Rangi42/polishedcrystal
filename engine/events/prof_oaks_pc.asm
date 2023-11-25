CountCaught:
	farcall Pokedex_CountSeenOwn
	ld hl, wTempDexOwn
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ldh a, [hScriptVar]
	cpl
	ld l, a
	ldh a, [hScriptVar+1]
	cpl
	ld h, a
	inc hl
	xor a
	ldh [hScriptVar], a
	add hl, bc
	ret nc
	inc a ; TRUE
	ldh [hScriptVar], a
	ret

CountSeen:
	farcall Pokedex_CountSeenOwn
	ld hl, wTempDexSeen
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ldh a, [hScriptVar]
	cpl
	ld l, a
	ldh a, [hScriptVar+1]
	cpl
	ld h, a
	inc hl
	xor a
	ldh [hScriptVar], a
	add hl, bc
	ret nc
	inc a ; TRUE
	ldh [hScriptVar], a
	ret

ProfOaksPC:
	ld hl, OakPCText1
	call MenuTextbox
	call YesNoBox
	call nc, ProfOaksPCBoot ; player chose "yes"?
	ld hl, OakPCText4
	call PrintText
	call JoyWaitAorB
	jmp ExitMenu

ProfOaksPCBoot:
	ld hl, OakPCText2
	call PrintText
	call Rate
	call PlaySFX ; sfx loaded by previous Rate function call
	call JoyWaitAorB
	jmp WaitSFX

ProfOaksPCRating:
	call Rate
	push de
	ld e, MUSIC_NONE
	call PlayMusic
	pop de
	call PlaySFX
	call JoyWaitAorB
	jmp WaitSFX

Rate:
; calculate Seen/Owned
	farcall Pokedex_CountSeenOwn

	ld hl, OakPCText3
	call PrintText
	call JoyWaitAorB
	ld hl, wTempDexOwn
	ld a, [hli]
	ld c, [hl]
	ld b, a
	ld hl, OakRatings
	call FindOakRating
	push de
	call PrintText
	pop de
	ret

FindOakRating:
; get pokedex caught count in bc
; return sound effect in de
; return text pointer in hl
	ld a, [hli]
	ld d, a
	ld a, [hli]
	cp b
	jr c, .next
	jr nz, .match
	ld a, d
	cp c
	jr nc, .match
.next
rept 4
	inc hl
endr
	jr FindOakRating

.match
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

INCLUDE "data/events/pokedex_ratings.asm"

OakPCText1:
	text_far _OakPCText1
	text_end

OakPCText2:
	text_far _OakPCText2
	text_end

OakPCText3:
	text_far _OakPCText3
	text_end

OakRating01:
	text_far _OakRating01
	text_end

OakRating02:
	text_far _OakRating02
	text_end

OakRating03:
	text_far _OakRating03
	text_end

OakRating04:
	text_far _OakRating04
	text_end

OakRating05:
	text_far _OakRating05
	text_end

OakRating06:
	text_far _OakRating06
	text_end

OakRating07:
	text_far _OakRating07
	text_end

OakRating08:
	text_far _OakRating08
	text_end

OakRating09:
	text_far _OakRating09
	text_end

OakRating10:
	text_far _OakRating10
	text_end

OakRating11:
	text_far _OakRating11
	text_end

OakRating12:
	text_far _OakRating12
	text_end

OakRating13:
	text_far _OakRating13
	text_end

OakRating14:
	text_far _OakRating14
	text_end

OakRating15:
	text_far _OakRating15
	text_end

OakRating16:
	text_far _OakRating16
	text_end

OakRating17:
	text_far _OakRating17
	text_end

OakRating18:
	text_far _OakRating18
	text_end

OakRating19:
	text_far _OakRating19
	text_end

OakPCText4:
	text_far _OakPCText4
	text_end
