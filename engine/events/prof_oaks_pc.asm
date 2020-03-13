
ProfOaksPC:
	ld hl, OakPCText1
	call MenuTextBox
	call YesNoBox
	jr c, .shutdown
	call ProfOaksPCBoot ; player chose "yes"?
.shutdown
	ld hl, OakPCText4
	call PrintText
	call JoyWaitAorB
	jp ExitMenu

ProfOaksPCBoot
	ld hl, OakPCText2
	call PrintText
	call Rate
	call PlaySFX ; sfx loaded by previous Rate function call
	call JoyWaitAorB
	jp WaitSFX

ProfOaksPCRating:
	call Rate
	push de
	ld de, MUSIC_NONE
	call PlayMusic
	pop de
	call PlaySFX
	call JoyWaitAorB
	jp WaitSFX

Rate:
; calculate Seen/Owned
	ld hl, wPokedexSeen
	ld b, wEndPokedexSeen - wPokedexSeen
	call CountSetBits
	ld [wd002], a
	ld hl, wPokedexCaught
	ld b, wEndPokedexCaught - wPokedexCaught
	call CountSetBits
	ld [wd003], a

; print appropriate rating
	call .UpdateRatingBuffers
	ld hl, OakPCText3
	call PrintText
	call JoyWaitAorB
	ld a, [wd003]
	ld hl, OakRatings
	call FindOakRating
	push de
	call PrintText
	pop de
	ret

.UpdateRatingBuffers:
	ld hl, wStringBuffer3
	ld de, wd002
	call .UpdateRatingBuffer
	ld hl, wStringBuffer4
	ld de, wd003
	; fallthrough

.UpdateRatingBuffer:
	push hl
	ld a, "@"
	ld bc, ITEM_NAME_LENGTH
	rst ByteFill
	pop hl
	lb bc, PRINTNUM_LEFTALIGN | 1, 3
	jp PrintNum

FindOakRating:
; return sound effect in de
; return text pointer in hl
	ld c, a
.loop
	ld a, [hli]
	cp c
	jr nc, .match
rept 4
	inc hl
endr
	jr .loop

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
oakrating: MACRO
	db \1
	dw \2, \3
ENDM

; if you caught at most this many, play this sound, load this text
	oakrating   9, SFX_DEX_FANFARE_LESS_THAN_20, OakRating01
	oakrating  19, SFX_DEX_FANFARE_LESS_THAN_20, OakRating02
	oakrating  34, SFX_DEX_FANFARE_20_49,        OakRating03
	oakrating  49, SFX_DEX_FANFARE_20_49,        OakRating04
	oakrating  64, SFX_DEX_FANFARE_50_79,        OakRating05
	oakrating  79, SFX_DEX_FANFARE_50_79,        OakRating06
	oakrating  94, SFX_DEX_FANFARE_80_109,       OakRating07
	oakrating 109, SFX_DEX_FANFARE_80_109,       OakRating08
	oakrating 124, SFX_CAUGHT_MON,               OakRating09
	oakrating 139, SFX_CAUGHT_MON,               OakRating10
	oakrating 154, SFX_DEX_FANFARE_140_169,      OakRating11
	oakrating 169, SFX_DEX_FANFARE_140_169,      OakRating12
	oakrating 184, SFX_DEX_FANFARE_170_199,      OakRating13
	oakrating 199, SFX_DEX_FANFARE_170_199,      OakRating14
	oakrating 214, SFX_DEX_FANFARE_200_229,      OakRating15
	oakrating 229, SFX_DEX_FANFARE_200_229,      OakRating16
	oakrating 239, SFX_DEX_FANFARE_230_PLUS,     OakRating17
	oakrating 249, SFX_DEX_FANFARE_230_PLUS,     OakRating18
	oakrating 255, SFX_DEX_FANFARE_230_PLUS,     OakRating19

OakPCText1:
	text_jump _OakPCText1
	db "@"

OakPCText2:
	text_jump _OakPCText2
	db "@"

OakPCText3:
	text_jump _OakPCText3
	db "@"

OakRating01:
	text_jump _OakRating01
	db "@"

OakRating02:
	text_jump _OakRating02
	db "@"

OakRating03:
	text_jump _OakRating03
	db "@"

OakRating04:
	text_jump _OakRating04
	db "@"

OakRating05:
	text_jump _OakRating05
	db "@"

OakRating06:
	text_jump _OakRating06
	db "@"

OakRating07:
	text_jump _OakRating07
	db "@"

OakRating08:
	text_jump _OakRating08
	db "@"

OakRating09:
	text_jump _OakRating09
	db "@"

OakRating10:
	text_jump _OakRating10
	db "@"

OakRating11:
	text_jump _OakRating11
	db "@"

OakRating12:
	text_jump _OakRating12
	db "@"

OakRating13:
	text_jump _OakRating13
	db "@"

OakRating14:
	text_jump _OakRating14
	db "@"

OakRating15:
	text_jump _OakRating15
	db "@"

OakRating16:
	text_jump _OakRating16
	db "@"

OakRating17:
	text_jump _OakRating17
	db "@"

OakRating18:
	text_jump _OakRating18
	db "@"

OakRating19:
	text_jump _OakRating19
	db "@"

OakPCText4:
	text_jump _OakPCText4
	db "@"
