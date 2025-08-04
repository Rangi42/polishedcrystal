_StdBattleTextbox:
; Additional battle-specific text handling
	push hl
	push de
	push bc

.loop
	; Delay for 60 - wTimeSinceText frames, in case text was recently displayed.
	ld a, [wTimeSinceText]
	cp 60
	jr nc, .allow_advance
	call DelayFrame
	call JoyCheckTextAdvance
	jr z, .loop

.allow_advance
	; Special-case enemy linebreaks
	ld b, h
	ld c, l
	ld hl, wTextboxFlags
	res NEWLINE_ENEMY_F, [hl]
	ld hl, .EnemyLinebreakTable
	ld de, 2
	call IsInWordArray
	jr nc, .done

	; See if the name is long enough.
	ld b, 0
	ld hl, wOTClassName
	call .CountCharacters

	push bc
	farcall Battle_GetTrainerName
	ld h, d
	ld l, e
	pop bc
	call .CountCharacters
	ld a, b

	; 19 rather than 18 because .CountCharacters include terminators. Not 20,
	; because we also want to fit a space.
	cp 19
	jr c, .done
	ld hl, wTextboxFlags
	set NEWLINE_ENEMY_F, [hl]
.done
	pop bc
	pop de
	pop hl
	jmp BattleTextbox

.CountCharacters:
	; Returns length including terminator.
	inc b
	ld a, [hli]
	cp '@'
	jr nz, .CountCharacters
	ret

.EnemyLinebreakTable:
	dw TiedAgainstText
	dw LostAgainstText
	dw BattleText_WentBackToEnemy
	dw EnemyAffectionEvasionText
	dw -1
