
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
	ld hl, wPokedexSeen
	ld b, wEndPokedexSeen - wPokedexSeen
	call CountSetBits
	ld [wTempPokedexSeenCount], a
	ld hl, wPokedexCaught
	ld b, wEndPokedexCaught - wPokedexCaught
	call CountSetBits
	ld [wTempPokedexCaughtCount], a

; print appropriate rating
	call .UpdateRatingBuffers
	ld hl, OakPCText3
	call PrintText
	call JoyWaitAorB
	ld a, [wTempPokedexCaughtCount]
	ld hl, OakRatings
	call FindOakRating
	push de
	call PrintText
	pop de
	ret

.UpdateRatingBuffers:
	ld hl, wStringBuffer3
	ld de, wTempPokedexSeenCount
	call .UpdateRatingBuffer
	ld hl, wStringBuffer4
	ld de, wTempPokedexCaughtCount
	; fallthrough

.UpdateRatingBuffer:
	push hl
	ld a, "@"
	ld bc, ITEM_NAME_LENGTH
	rst ByteFill
	pop hl
	lb bc, PRINTNUM_LEFTALIGN | 1, 3
	jmp PrintNum

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
