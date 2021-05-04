CanLearnTMHMMove:
	ld a, [wPutativeTMHMMove]
	and a
	jmp z, GetForgottenMoves

	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	call GetBaseData
	ld hl, wBaseTMHM
	push hl

	ld a, [wPutativeTMHMMove]
	ld b, a
	ld c, 0
	ld hl, TMHMMoves
.loop
	ld a, [hli]
	and a
	jr z, .end
	cp b
	jr z, .found
	inc c
	jr .loop

.found
	pop hl
	ld b, CHECK_FLAG
	push de
	ld d, 0
	predef FlagPredef
	pop de
	ret

.end
	pop hl
	ld c, 0
	ret

GetTMHMMove:
	ld a, [wTempTMHM]
	dec a
	ld hl, TMHMMoves
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wTempTMHM], a
	ret

INCLUDE "data/moves/tmhm_moves.asm"
