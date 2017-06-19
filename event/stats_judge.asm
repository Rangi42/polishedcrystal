; Stats Judge code by TPP Anniversary Crystal 251
; https://github.com/TwitchPlaysPokemon/tppcrystal251pub/blob/public/event/poke_seer.asm


SpecialStatsJudge: ; 4f0bc
	ld hl, .Intro
	call PrintText
	call YesNoBox
	jr c, .cancel
	ld hl, .Which
	call PrintText
	call JoyWaitAorB

	ld b, $6
	farcall SelectMonFromParty
	jr c, .cancel

	ld a, [CurPartySpecies]
	cp EGG
	jr z, .egg

	call IsAPokemon
	jr c, .no_mon

	call ReadDVs
	call JudgePokemon
	ret

.cancel
	ld hl, .Cancel
	jp PrintText

.no_mon
	ret

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
	done

.Cancel
	text "You don't need me"
	line "to judge? Okay."
	done

.Egg
	text "Judge an Egg?!"
	line "I can't do that!"
	done


ReadDVs:
	ld a, MON_DVS
	call GetPartyParamLocation
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld d, a
	ld a, [hl]
	ld e, a
	ld hl, wd002
; HP
	ld a, c
	swap a
	and $f
	ld [hli], a
; Attack
	ld a, c
	and $f
	ld [hli], a
; Defense
	ld a, d
	swap a
	and $f
	ld [hli], a
; Speed
	ld a, d
	and $f
	ld [hli], a
; Special Attack
	ld a, e
	swap a
	and $f
	ld [hli], a
; Special Defense
	ld a, e
	and $f
	ld [hli], a
	ret


JudgePokemon:
	ld hl, .InitJudge
	call PrintText
	call JoyWaitAorB
	call GetDVTotal
	; push bc
	call JudgeDVTotal
	ld hl, .Incidentally
	call PrintText
	call JoyWaitAorB

;	pop bc
;	ld a, b
;	and a
;	jr z, .skip_maxdv
;	cp 75
;	jr z, .skip_maxdv
	call GetMaxDV
	push bc
	call InformMaxDVs
	pop bc
	call JudgeMaxDV
	ld hl, .Conclude
	call PrintText
	call JoyWaitAorB
	call GetMinDV
	call InformMinDVs
;.skip_maxdv
	ld hl, .Finish
	jp PrintText

.InitJudge
	text "I see… I see…"
	done

.Incidentally
	text "Incidentally…"
	done

.Conclude
	text "That's how I judge"
	line "it."
	done

.Finish
	text "Come again some-"
	line "time."
	done


GetDVTotal:
	ld hl, wd002
	ld b, 0
	ld c, 6
.loop
	ld a, [hli]
	add b
	ld b, a
	dec c
	jr nz, .loop
	ret


JudgeDVTotal:
	ld a, b
	; max dv total is 6 * 15 = 90
	and a
	ld hl, .AbsoluteWorst
	jr z, .okay
	cp 25
	ld hl, .Poor
	jr c, .okay
	cp 40
	ld hl, .Unremarkable
	jr c, .okay
	cp 60
	ld hl, .Decent
	jr c, .okay
	cp 90
	ld hl, .Strong
	jr c, .okay
	ld hl, .Perfect
.okay
	call PrintText
	call JoyWaitAorB
	ret

.AbsoluteWorst
	text "Oh my! Your #-"
	line "mon has so little"
	cont "potential!"

	para "I've never seen a"
	line "#mon so weak!"
	done

.Poor
	text "Your #mon"
	line "seems to be lac-"
	cont "king in potential."
	done

.Unremarkable
	text "Your #mon's"
	line "potential is"
	cont "unremarkable."
	done

.Decent
	text "Your #mon seems"
	line "to be decent"
	cont "overall."
	done

.Strong
	text "Your #mon seems"
	line "to be spectacular"
	cont "overall."
	done

.Perfect
	text "I don't even need"
	line "to look closely"

	para "to see your #-"
	line "mon's perfection!"
	done


GetMaxDV:
	ld hl, wd002
	ld b, 0
	ld c, 6
.loop
	ld a, [hli]
	cp b
	jr c, .skip
	ld b, a
.skip
	dec c
	jr nz, .loop
	; We found the max value, now let's get which ones are equal.
	ld hl, wd002
	ld c, 6
	ld d, 0
.loop2
	srl d
	ld a, [hli]
	cp b
	jr nz, .skip2
	set 4, d
.skip2
	dec c
	jr nz, .loop2
	ret


InformMaxDVs:
	ld c, 5
	ld b, 0
.loop
	srl d
	jr nc, .next
	push de
	push bc
	ld a, 6
	sub c
	add a
	ld e, a
	ld d, 0
	ld hl, StatNames
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, StringBuffer1
.loop1
	ld a, [hli]
	ld [de], a
	cp "@"
	jr z, .done1
	inc de
	jr .loop1
.done1
	ld a, b
	add a
	ld e, a
	ld d, 0
	ld hl, .WhichStatTexts
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText
	call JoyWaitAorB
	pop bc
	pop de
	inc b
.next
	dec c
	jr nz, .loop
	ret

.WhichStatTexts
	dw .FirstStatText
	dw .SecondStatText
	dw .ThirdStatText
	dw .FourthStatText
	dw .FifthStatText
	dw .SixthStatText

.FirstStatText
	text "Its greatest po-"
	line "tential lies in"
	cont "its @"
	text_from_ram StringBuffer1
	text "."
	done

.SecondStatText
	text "Its @"
	text_from_ram StringBuffer1
	text " is"
	line "equally good."
	done

.ThirdStatText
	text "Its @"
	text_from_ram StringBuffer1
	text " is"
	line "also impressive."
	done

.FourthStatText
	text "Its @"
	text_from_ram StringBuffer1
	text " is"
	line "good as well."
	done

.FifthStatText
	text "Its @"
	text_from_ram StringBuffer1
	text " is"
	line "also good."
	done

.SixthStatText
	text "Well, its @"
	text_from_ram StringBuffer1
	text ""
	line "is worth mention-"
	cont "ing also."
	done


JudgeMaxDV:
	ld a, b
	cp 7
	ld hl, .Decent
	jr c, .okay
	cp 12
	ld hl, .Good
	jr c, .okay
	cp 15
	ld hl, .Fantastic
	jr c, .okay
	ld hl, .Perfect
.okay
	call PrintText
	call JoyWaitAorB
	ret

.Decent
	text "It has rather"
	line "decent stats, I'd"
	cont "say."
	done

.Good
	text "It's definitely"
	line "got some good"
	cont "stats."
	done

.Fantastic
	text "This #mon has"
	line "some pretty fan-"
	cont "tastic stats."
	done

.Perfect
	text "Stats like those…"
	line "They simply can't"
	cont "be beat!"
	done


GetMinDV:
	; Find DVs equal to zero
	ld hl, wd002
	ld c, 6
	ld d, 0
.loop
	srl d
	ld a, [hli]
	and a
	jr nz, .skip
	set 4, d
.skip
	dec c
	jr nz, .loop
	ret


InformMinDVs:
	ld c, 5
	ld b, 0
.loop
	srl d
	jr nc, .next
	push de
	push bc
	ld a, 6
	sub c
	add a
	ld e, a
	ld d, 0
	ld hl, StatNames
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, StringBuffer1
.loop1
	ld a, [hli]
	ld [de], a
	cp "@"
	jr z, .done1
	inc de
	jr .loop1
.done1
	ld a, b
	add a
	ld e, a
	ld d, 0
	ld hl, .WhichStatTexts
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText
	call JoyWaitAorB
	pop bc
	pop de
	inc b
.next
	dec c
	jr nz, .loop
	ret

.WhichStatTexts
	dw .FirstStatText
	dw .SecondStatText
	dw .ThirdStatText
	dw .FourthStatText
	dw .FifthStatText
	dw .SixthStatText

.FirstStatText
	text "But its @"
	text_from_ram StringBuffer1
	text "…"
	line "It's pretty dis-"
	cont "mal, you know?"
	done

.SecondStatText
	text "And its @"
	text_from_ram StringBuffer1
	text ""
	line "is pretty disap-"
	cont "pointing, too."
	done

.ThirdStatText
	text "I'm afraid its"
	line "@"
	text_from_ram StringBuffer1
	text " is pretty"
	cont "bad, too…"
	done

.FourthStatText
	text "I'm not too happy"
	line "with its @"
	text_from_ram StringBuffer1
	text ""
	cont "either."
	done

.FifthStatText
	text "Its @"
	text_from_ram StringBuffer1
	text ""
	line "is pretty disap-"
	cont "pointing, too."
	done

.SixthStatText
	text "Well, its @"
	text_from_ram StringBuffer1
	text ""
	line "is nothing to brag"
	cont "about, that's for"
	cont "sure."
	done


StatNames:
	dw .hp
	dw .atk
	dw .def
	dw .spd
	dw .sat
	dw .sdf
.hp
	db "HP@"
.atk
	db "Attack@"
.def
	db "Defense@"
.spd
	db "Speed@"
.sat
	db "Spcl.Atk@"
.sdf
	db "Spcl.Def@"


GetCaughtGender: ; 4f301
	ld hl, MON_CAUGHTGENDER
	add hl, bc

	ld a, [hl]
	and CAUGHTGENDER_MASK
	rl a
	ld c, a
	ret
; 4f31c
