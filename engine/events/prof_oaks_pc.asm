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
	text_farend _OakPCText1
OakPCText2:
	text_farend _OakPCText2
OakPCText3:
	text_farend _OakPCText3
OakRating01:
	text_farend _OakRating01
OakRating02:
	text_farend _OakRating02
OakRating03:
	text_farend _OakRating03
OakRating04:
	text_farend _OakRating04
OakRating05:
	text_farend _OakRating05
OakRating06:
	text_farend _OakRating06
OakRating07:
	text_farend _OakRating07
OakRating08:
	text_farend _OakRating08
OakRating09:
	text_farend _OakRating09
OakRating10:
	text_farend _OakRating10
OakRating11:
	text_farend _OakRating11
OakRating12:
	text_farend _OakRating12
OakRating13:
	text_farend _OakRating13
OakRating14:
	text_farend _OakRating14
OakRating15:
	text_farend _OakRating15
OakRating16:
	text_farend _OakRating16
OakRating17:
	text_farend _OakRating17
OakRating18:
	text_farend _OakRating18
OakRating19:
	text_farend _OakRating19
OakPCText4:
	text_farend _OakPCText4
