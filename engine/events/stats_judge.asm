; Stats Judge code originally by TPP Anniversary Crystal 251
; https://github.com/TwitchPlaysPokemon/tppcrystal251pub/blob/public/event/poke_seer.asm

SpecialStatsJudge: ; 4f0bc
	ld hl, .Intro
	call PrintText
	call YesNoBox
	jr c, .cancel
	ld hl, .Which
	call PrintText

	ld b, $6
	farcall SelectMonFromParty
	jr c, .cancel

	ld a, [CurPartySpecies]
	cp EGG
	jr z, .egg

	call IsAPokemon
	ret c

	jp JudgePokemon

.cancel
	ld hl, .Cancel
	jp PrintText

.egg
	ld hl, .Egg
	jp PrintText
; 4f0ee

.Intro
	text "You can call me"
	line "the Stats Judge."

	para "I can discern the"
	line "overall potential"
	cont "of your #mon."

	para "Want me to judge"
	line "one of your #-"
	cont "mon?"
	done

.Which
	text "Which #mon"
	line "should I judge?"
	prompt

.Cancel
	text "You don't need me"
	line "to judge? Okay."
	done

.Egg
	text "Judge an Egg?!"
	line "I can't do that!"
	done

JudgePokemon:
	ld a, MON_DVS
	call GetPartyParamLocation
	push hl
	ld hl, .i_see
	call PrintText
	pop hl
	push hl
	; b: Good stats, c: Bad stats, d: Total, e: Best
	lb bc, %000000, %000000
	lb de, %100000, 0
.loop
	ld a, [hli]
	push af
	swap a
	call .SetDV
	pop af
	call .SetDV
	jr nc, .loop

	; Now figure out total
	pop hl
	push bc
	ld b, 3
.loop2
	ld a, [hli]
	push af
	swap a
	call .AddDV
	pop af
	call .AddDV
	dec b
	jr nz, .loop2

	; Print total text
	push de
	ld a, d
	cp 46
	ld hl, .decent_total
	jr c, .total_ok
	cp 61
	ld hl, .above_average_total
	jr c, .total_ok
	cp 76
	ld hl, .relatively_superior_total
	jr c, .total_ok
	ld hl, .outstanding_total
.total_ok
	call PrintText
	ld hl, .total_after
	call PrintText
	pop de
	pop bc

	; Print max DV(s)
	ld hl, .best_table
	call .PrintDV

	; Print how good it is
	ld a, e
	cp 8
	ld hl, .ok_best
	jr c, .got_best_text
	cp 13
	ld hl, .good_best
	jr c, .got_best_text
	cp 15
	ld hl, .fantastic_best
	jr c, .got_best_text
	ld hl, .very_best
.got_best_text
	push bc
	call PrintText
	ld hl, .conclude_best
	call PrintText
	pop bc

	; Print bad DVs
	ld b, c
	ld hl, .zero_table
	call .PrintDV

	; We're done
	ld hl, .finish
	jp PrintText

.AddDV:
; Add DV to total
	and $f
	add d
	ld d, a
	ret

.SetDV:
; Flag best DVs and DVs at zero
	and $f
	; Flag bad DV
	cp 1
	rl c
	cp e
	jr c, .good_done
	ld e, a
	jr z, .goodreset_done
	xor a
	ld b, a
.goodreset_done
	ld a, d
	or b
	ld b, a
.good_done
	srl d
	ret

.PrintDV:
; Prints stat info, used to note best and 0 DVs
	sla b
	sla b
	ld d, 6
.best_loop
	sla b
	jr nc, .best_next
	call JudgeGetStatName
	push bc
	push de
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText
	pop hl
	pop de
	pop bc
	inc hl
	inc hl
.best_next
	dec d
	jr nz, .best_loop
	ret

.i_see
	text "I see… I see…"
	prompt

.decent_total
	text "This #mon's"
	line "potential is"
	cont "decent all around."
	prompt

.above_average_total
	text "This #mon's"
	line "potential is"
	cont "above-average"
	cont "overall."
	prompt

.relatively_superior_total
	text "This #mon's"
	line "potential is"
	cont "relatively"
	cont "superior"
	cont "overall."
	prompt

.outstanding_total
	text "This #mon's"
	line "potential is"
	cont "outstanding"
	cont "overall."
	prompt

.total_after
	text "That's how I judge"
	line "it, anyway."
	prompt

.best_table
	dw .first_best
	dw .second_best
	dw .third_best
	dw .fourth_best
	dw .fifth_best
	dw .sixth_best

.first_best
	text "Incidentally, I'd"
	line "say that its best"
	cont "potential lies in"
	cont "its @"
	text_from_ram StringBuffer1
	text "."
	prompt

.second_best
	text "Its @"
	text_from_ram StringBuffer1
	text " is"
	line "equally good."
	prompt

.third_best
	text "Its @"
	text_from_ram StringBuffer1
	text " is"
	line "also impressive."
	prompt

.fourth_best
	text "Its @"
	text_from_ram StringBuffer1
	text " is"
	line "good as well."
	prompt

.fifth_best
	text "Its @"
	text_from_ram StringBuffer1
	text " is"
	line "also good."
	prompt

.sixth_best
	text "Well, its @"
	text_from_ram StringBuffer1
	text ""
	line "is worth mention-"
	cont "ing also."
	prompt

.ok_best
	text "It has rather"
	line "decent stats, I'd"
	cont "say."
	prompt

.good_best
	text "It's definitely"
	line "got some good"
	cont "stats."
	prompt

.fantastic_best
	text "This #mon has"
	line "some fantastic"
	cont "stats."
	prompt

.very_best
	text "Stats like those…"
	line "They simply can't"
	cont "be beat!"
	prompt

.conclude_best
	text "That's how I judge"
	line "it."
	prompt

.zero_table
	dw .first_zero
	dw .second_zero
	dw .third_zero
	dw .fourth_zero
	dw .fifth_zero
	dw .sixth_zero

.first_zero
	text "But its @"
	text_from_ram StringBuffer1
	text "…"
	line "It's pretty dis-"
	cont "mal, you know?"
	prompt

.second_zero
	text "And its @"
	text_from_ram StringBuffer1
	text ""
	line "is pretty disap-"
	cont "pointing, too."
	prompt

.third_zero
	text "I'm afraid its"
	line "@"
	text_from_ram StringBuffer1
	text " is pretty"
	cont "bad, too…"
	prompt

.fourth_zero
	text "I'm not too happy"
	line "with its @"
	text_from_ram StringBuffer1
	text ""
	cont "either."
	prompt

.fifth_zero
	text "Its @"
	text_from_ram StringBuffer1
	text ""
	line "is pretty disap-"
	cont "pointing, too."
	prompt

.sixth_zero
	text "Well, its @"
	text_from_ram StringBuffer1
	text ""
	line "is nothing to brag"
	cont "about, that's for"
	cont "sure."
	prompt

.finish
	text "Come again,"
	line "some time."
	done

JudgeGetStatName:
	push bc
	push de
	push hl
	ld hl, .names
.loop
	dec d
	jr z, .got_stat
.inner_loop
	ld a, [hli]
	cp "@"
	jr z, .loop
	jr .inner_loop

.got_stat
	ld de, StringBuffer1
	ld bc, StringBuffer2 - StringBuffer1
	call CopyBytes
	pop hl
	pop de
	pop bc
	ret

.names
	db "Spcl.Def@"
	db "Spcl.Atk@"
	db "Speed@"
	db "Defense@"
	db "Attack@"
	db "HP@"

GetCaughtGender:
	ld hl, MON_CAUGHTGENDER
	add hl, bc

	ld a, [hl]
	and CAUGHTGENDER_MASK
	rl a
	ld c, a
	ret
