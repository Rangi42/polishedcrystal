OffsetStackJumpTable::
	add hl, bc
	ld a, [hl]
	jr StackJumpTable

StandardStackJumpTable::
	ld a, [wJumptableIndex]
StackJumpTable::
	pop hl
JumpTable::
	push de
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	pop de
IndirectHL::
	ld a, [hli]
	ld h, [hl]
	ld l, a
_hl_::
	jp hl
