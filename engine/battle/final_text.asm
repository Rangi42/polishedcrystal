GetFinalPkmnTextPointer::
	; Silver and Lyra have a phrase for each set of three IDs
	ld a, [wOtherTrainerClass]
	ld hl, FinalTextList_TriplePhrases
	call .findinarray
	jr c, .rival_or_lyra
	; Proton to Giovanni have a phrase for each ID
	ld a, [wOtherTrainerClass]
	cp PROTON
	jr c, .not_rocket
	cp GIOVANNI + 1
	jr c, .rocket
.not_rocket
	; Leaf and below, and Prof. Oak and above, have one unique phrase
	dec a
	cp LEAF
	jr c, .single_phrase
	cp PROF_OAK - 1
	jr c, .nothing
	sub PROF_OAK - LEAF - 1
	jr .single_phrase

.nothing:
	xor a
	ret

.rival_or_lyra:
	ld a, [wOtherTrainerID]
	dec a
	ld c, 3
	call SimpleDivide
	ld a, b
	jr .get_text

.rocket:
	; a = ([wOtherTrainerClass] - PROTON) * 2 + [wOtherTrainerID] - 1
	sub PROTON
	add a
	ld b, a
	ld a, [wOtherTrainerID]
	dec a
	add b
	ld hl, FinalText_TeamRocket
	jr .get_text

.single_phrase:
	ld hl, FinalText_SinglePhrases
.get_text:
	ld b, 0
	ld c, a
	add hl, bc
	add hl, bc
	jr .finish

.findinarray:
	push de
	ld de, 3
	call IsInArray
	pop de
	ret nc
	inc hl
.finish:
	ld a, [hli]
	ld h, [hl]
	ld l, a
	or h
	jr z, .nothing
.done:
	scf
	ret

INCLUDE "data/trainers/final_text.asm"
