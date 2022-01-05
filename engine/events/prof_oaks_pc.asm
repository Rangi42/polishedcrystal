CountCaught:
	farcall Pokedex_CountSeenOwn
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
	ld de, MUSIC_NONE
	call PlayMusic
	pop de
	call PlaySFX
	call JoyWaitAorB
	jmp WaitSFX

Rate:
; calculate Seen/Owned
	farcall Pokedex_CountSeenOwn

; print appropriate rating, we start on bc = pokedex caught due to Pokedex_CountSeenOwn
	ld hl, wStringBuffer4
	call .UpdateRatingBuffer
	ld hl, wTempDexSeen
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld hl, wStringBuffer3
	call .UpdateRatingBuffer
	ld hl, OakPCText3
	call PrintText
	call JoyWaitAorB
	pop bc
	ld hl, OakRatings
	call FindOakRating
	push de
	call PrintText
	pop de
	ret

.UpdateRatingBuffer:
	push hl
	push bc
	ld a, "@"
	ld bc, ITEM_NAME_LENGTH
	rst ByteFill
	ld hl, sp + 2
	ld d, h
	ld e, l
	pop hl
	lb bc, PRINTNUM_LEFTALIGN | 2, 3
	call PrintNum
	pop bc
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

OakRatings:
; if you caught at most this many, play this sound, load this text
	dw   9, SFX_DEX_FANFARE_LESS_THAN_20, OakRating01
	dw  19, SFX_DEX_FANFARE_LESS_THAN_20, OakRating02
	dw  34, SFX_DEX_FANFARE_20_49,        OakRating03
	dw  49, SFX_DEX_FANFARE_20_49,        OakRating04
	dw  64, SFX_DEX_FANFARE_50_79,        OakRating05
	dw  79, SFX_DEX_FANFARE_50_79,        OakRating06
	dw  94, SFX_DEX_FANFARE_80_109,       OakRating07
	dw 109, SFX_DEX_FANFARE_80_109,       OakRating08
	dw 124, SFX_CAUGHT_MON,               OakRating09
	dw 139, SFX_CAUGHT_MON,               OakRating10
	dw 154, SFX_DEX_FANFARE_140_169,      OakRating11
	dw 169, SFX_DEX_FANFARE_140_169,      OakRating12
	dw 184, SFX_DEX_FANFARE_170_199,      OakRating13
	dw 199, SFX_DEX_FANFARE_170_199,      OakRating14
	dw 214, SFX_DEX_FANFARE_200_229,      OakRating15
	dw 229, SFX_DEX_FANFARE_200_229,      OakRating16
	dw 239, SFX_DEX_FANFARE_230_PLUS,     OakRating17
	dw 249, SFX_DEX_FANFARE_230_PLUS,     OakRating18
	dw  -1, SFX_DEX_FANFARE_230_PLUS,     OakRating19

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
