Special_CheckForLuckyNumberWinners:
; Returns number of digits matching
	xor a
	ldh [hScriptVar], a

	; Prepare lucky number buffer
	ld hl, wStringBuffer1
	ld de, wLuckyIDNumber
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	call PrintNum

	ld b, NUM_BOXES
	push bc ; will be where box+position number is stored
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
	jr nz, .compare_end
	inc b
	dec de
	dec hl
	ld a, b
	cp 5
	jr nz, .compare_loop
.compare_end
	ldh a, [hScriptVar]
	cp b
	ld a, b
	pop bc
	jr nc, .next
; if matching digits were found...
	ldh [hScriptVar], a
	ld hl, sp+0 ; store box + position on the stack for mon with matching digits
	ld a, c
	ld [hli], a
	ld [hl], b
	cp 5
	jr z, .done
.next
	dec c
	jr nz, .loop
	dec b
	bit 7, b ; check for reaching -1
	jr z, .outer_loop
.done
	pop bc ; restores box + position, if applicable
	call WaitSFX
	ldh a, [hScriptVar]
	and a
	ret z ; found nothing

	; Prepare found storage mon ID
	push bc
	farcall GetStorageBoxMon
	ld de, wTempMonID
	ld hl, wStringBuffer2
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	call PrintNum
	ld [hl], '@' ; PrintNum returns address of next char in the buffer hl
	pop bc

	; Get box name (if applicable)
	inc b
	dec b
	ld hl, .MatchInParty
	jr z, .got_text
	farcall GetBoxName ; loads box name into wStringBuffer1
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
	ld [hl], '@'
	ret
