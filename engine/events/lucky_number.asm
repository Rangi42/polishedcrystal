Special_CheckForLuckyNumberWinners:
; Returns number of digits matching
	xor a
	ldh [hScriptVar], a
	ld [wFoundMatchingID], a

	; Prepare lucky number buffer
	ld hl, wStringBuffer1
	ld de, wLuckyIDNumber
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	call PrintNum

	ld b, NUM_BOXES
.outer_loop
	inc b
	dec b
	ld c, PARTY_LENGTH
	jr z, .loop
	ld c, MONS_PER_BOX
.loop
	farcall GetStorageBoxMon
	jr z, .next

	ld hl, wTempMonIsEgg
	bit MON_IS_EGG_F, [hl]
	jr nz, .next
	ld de, wTempMonID
	push bc
	ld hl, wBuffer1
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	call PrintNum
	ld hl, wStringBuffer1 + 4
	ld de, wBuffer1 + 4
	ld b, 0
.compare_loop
	ld a, [de]
	cp [hl]
	jr nz, .compare_failed
	inc b
	dec de
	dec hl
	ld a, b
	cp 5
	jr nz, .compare_loop
	; if we're here, all 5 digits match
.compare_failed
	ldh a, [hScriptVar]
	and $f
	cp b
	ld a, b
	pop bc
	jr nc, .next
	swap a
	or b
	swap a
	ldh [hScriptVar], a
	ld hl, wFoundMatchingID
	ld [hl], c
	cp 5
	jr z, .done
	jr nz, .next
.next
	dec c
	jr nz, .loop
	dec b
	bit 7, b ; check for reaching -1
	jr z, .outer_loop
.done
	ldh a, [hScriptVar]
	and a
	ret z ; found nothing

	; Get storage mon nickname
	push af
	swap a
	and $f
	ld b, a
	ld a, [wFoundMatchingID]
	ld c, a
	farcall GetStorageBoxMon
	pop af
	and $f
	ldh [hScriptVar], a

	inc b
	dec b
	ld hl, .MatchInParty
	jr z, .got_text
	farcall GetBoxName
	ld hl, wStringBuffer1
	ld de, wStringBuffer2
	ld bc, BOX_NAME_LENGTH
	rst CopyBytes
	ld hl, .MatchInStorage
.got_text
	jmp PrintText

.MatchInParty:
	; Congratulations! We have a match with the ID number of @  in your party.
	text_far _LuckyNumberMatchPartyText
	text_end

.MatchInStorage:
	; Congratulations! We have a match with the ID number of @  in your PC BOX.
	text_far _LuckyNumberMatchPCText
	text_end

Special_PrintTodaysLuckyNumber:
	ld hl, wStringBuffer3
	ld de, wLuckyIDNumber
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	call PrintNum
	ld a, "@"
	ld [wStringBuffer3 + 5], a
	ret
