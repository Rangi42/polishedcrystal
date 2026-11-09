HandleStoneTable::
	ld hl, wStoneTableAddress
	ld a, [hli]
	ld b, [hl]
	ld c, a
	or b
	ret z

	ld de, wPlayerStruct
	ld a, NUM_OBJECT_STRUCTS
.loop
	push af

	ld hl, OBJECT_SPRITE
	add hl, de
	ld a, [hl]
	and a
	jr z, .next

	ld hl, OBJECT_MOVEMENT_TYPE
	add hl, de
	ld a, [hl]
	cp SPRITEMOVEDATA_STRENGTH_BOULDER
	jr nz, .next

	ld hl, OBJECT_WALKING
	add hl, de
	ld a, [hl]
	cp STANDING
	jr nz, .next

	ld hl, OBJECT_TILE_COLLISION
	add hl, de
	ld a, [hl]
	sub COLL_HOLE
	jr z, .action
	assert COLL_HOLE + 1 == COLL_STONE_WARP
	dec a ; cp COLL_STONE_WARP
	jr nz, .next

.action
	call HandleStoneTableAction
	jr c, .fall_down_hole

.next
	ld hl, OBJECT_LENGTH
	add hl, de
	ld d, h
	ld e, l

	pop af
	dec a
	jr nz, .loop
	ret

.fall_down_hole
	pop af
	ret
